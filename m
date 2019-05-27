Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192B82B7A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfE0Ofn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 10:35:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:43340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbfE0Ofm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 10:35:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D712FAF10;
        Mon, 27 May 2019 14:35:40 +0000 (UTC)
Date:   Mon, 27 May 2019 15:35:39 +0100
From:   Luis Henriques <lhenriques@suse.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 6/8] vfs: copy_file_range should update file timestamps
Message-ID: <20190527143539.GA14980@hermes.olymp>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190526061100.21761-7-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:57AM +0300, Amir Goldstein wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Timestamps are not updated right now, so programs looking for
> timestamp updates for file modifications (like rsync) will not
> detect that files have changed. We are also accessing the source
> data when doing a copy (but not when cloning) so we need to update
> atime on the source file as well.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/read_write.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e16bcafc0da2..4b23a86aacd9 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1576,6 +1576,16 @@ int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
>  
>  	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
>  
> +	/* Update source timestamps, because we are accessing file data */
> +	file_accessed(file_in);
> +
> +	/* Update destination timestamps, since we can alter file contents. */
> +	if (!(file_out->f_mode & FMODE_NOCMTIME)) {
> +		ret = file_update_time(file_out);
> +		if (ret)
> +			return ret;
> +	}
> +

Is this the right place for updating the timestamps?  I see that in same
cases we may be updating the timestamp even if there was an error and no
copy was performed.  For example, if file_remove_privs fails.

(btw, I've re-tested everything on ceph and everything seems to be
working fine.)

Cheers,
--
Luís


>  	/*
>  	 * Clear the security bits if the process is not being run by root.
>  	 * This keeps people from modifying setuid and setgid binaries.
> -- 
> 2.17.1
> 
> 
