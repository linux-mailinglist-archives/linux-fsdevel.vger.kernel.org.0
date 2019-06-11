Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD943C613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbfFKIjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 04:39:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbfFKIjb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:39:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13652AE4D;
        Tue, 11 Jun 2019 08:39:30 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and update timestamps
References: <20190610174007.4818-1-amir73il@gmail.com>
Date:   Tue, 11 Jun 2019 09:39:27 +0100
In-Reply-To: <20190610174007.4818-1-amir73il@gmail.com> (Amir Goldstein's
        message of "Mon, 10 Jun 2019 20:40:07 +0300")
Message-ID: <87h88w8qio.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> Because ceph doesn't hold destination inode lock throughout the copy,
> strip setuid bits before and after copy.
>
> The destination inode mtime is updated before and after the copy and the
> source inode atime is updated after the copy, similar to the filesystem
> ->read_iter() implementation.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Ilya,
>
> Please consider applying this patch to ceph branch after merging
> Darrick's copy-file-range-fixes branch from:
>         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>
> The series (including this patch) was tested on ceph by
> Luis Henriques using new copy_range xfstests.
>
> AFAIK, only fallback from ceph to generic_copy_file_range()
> implementation was tested and not the actual ceph clustered
> copy_file_range.

JFYI I've also run tests that exercise the ceph implementation,
i.e. that actually do the copy offload.  It's the xfstests that (AFAIR)
only exercise the generic VFS copy_file_range as they never meet the
requirements for this copy offload to happen (for example, the copy must
be at least the same length as the files object size which is 4M by
default).

Cheers,
-- 
Luis


>
> Thanks,
> Amir.
>
>  fs/ceph/file.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index c5517ffeb11c..b04c97c7d393 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1949,6 +1949,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  		goto out;
>  	}
>  
> +	/* Should dst_inode lock be held throughout the copy operation? */
> +	inode_lock(dst_inode);
> +	ret = file_modified(dst_file);
> +	inode_unlock(dst_inode);
> +	if (ret < 0) {
> +		dout("failed to modify dst file before copy (%zd)\n", ret);
> +		goto out;
> +	}
> +
>  	/*
>  	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
>  	 * clients may have dirty data in their caches.  And OSDs know nothing
> @@ -2099,6 +2108,14 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  out:
>  	ceph_free_cap_flush(prealloc_cf);
>  
> +	file_accessed(src_file);
> +	/* To be on the safe side, try to remove privs also after copy */
> +	inode_lock(dst_inode);
> +	err = file_modified(dst_file);
> +	inode_unlock(dst_inode);
> +	if (err < 0)
> +		dout("failed to modify dst file after copy (%d)\n", err);
> +
>  	return ret;
>  }
