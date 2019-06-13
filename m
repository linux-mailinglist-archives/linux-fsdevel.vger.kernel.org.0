Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845D443B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfFMPZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbfFMMD7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:03:59 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5C421721;
        Thu, 13 Jun 2019 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560427438;
        bh=p2FKjRUBwjz5hPRVT7bIqF2K2jvLxaCfR3Nd2QCuhAI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h7oNytnJoZSKgKryW1tJj9jWvo+nYi59n7LE9Dz/eaP3Mc2jgY3VNdcESIoxlvf+u
         C0GXDXC/EjUmbNb/AVlxc3XpOYwUovNGErQ2VUEoVEPPUz9Onqp8RncBTcRjN8oQBr
         hjCcALIYmN7Y1oU3GcpawPyxm6X1xLhhZ9Aq+sh4=
Message-ID: <ed2e4b5d26890e96ba9dafcb3dba88427e36e619.camel@kernel.org>
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and
 update timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Date:   Thu, 13 Jun 2019 08:03:55 -0400
In-Reply-To: <20190610174007.4818-1-amir73il@gmail.com>
References: <20190610174007.4818-1-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-06-10 at 20:40 +0300, Amir Goldstein wrote:
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

I don't see anything that guarantees that the mode of the destination
file is up to date at this point. file_modified() just ends up checking
the mode cached in the inode.

I wonder if we ought to fix get_rd_wr_caps() to also acquire a reference
to AUTH_SHARED caps on the destination inode, and then call
file_modified() after we get those caps. That would also mean that we
wouldn't need to do this a second time after the copy.

The catch is that if we did need to issue a setattr, I'm not sure if
we'd need to release those caps first.

Luis, Zheng, thoughts?

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
>  


