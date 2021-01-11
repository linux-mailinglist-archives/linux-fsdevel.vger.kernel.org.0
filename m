Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE62F192E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbhAKPGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 10:06:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:49032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbhAKPGq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:06:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE86FAD5C;
        Mon, 11 Jan 2021 15:06:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 84E5D1E0807; Mon, 11 Jan 2021 16:06:03 +0100 (CET)
Date:   Mon, 11 Jan 2021 16:06:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/12] gfs2: don't worry about I_DIRTY_TIME in
 gfs2_fsync()
Message-ID: <20210111150603.GI18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-11-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:59:01, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The I_DIRTY_TIME flag is primary used within the VFS, and there's no
> reason for ->fsync() implementations to do anything with it.  This is
> because when !datasync, the VFS will expire dirty timestamps before
> calling ->fsync().  (See vfs_fsync_range().)  This turns I_DIRTY_TIME
> into I_DIRTY_SYNC.
> 
> Therefore, change gfs2_fsync() to not check for I_DIRTY_TIME.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index b39b339feddc9..7fe2497755a37 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -749,7 +749,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
>  {
>  	struct address_space *mapping = file->f_mapping;
>  	struct inode *inode = mapping->host;
> -	int sync_state = inode->i_state & I_DIRTY_ALL;
> +	int sync_state = inode->i_state & I_DIRTY;
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	int ret = 0, ret1 = 0;
>  
> @@ -762,7 +762,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
>  	if (!gfs2_is_jdata(ip))
>  		sync_state &= ~I_DIRTY_PAGES;
>  	if (datasync)
> -		sync_state &= ~(I_DIRTY_SYNC | I_DIRTY_TIME);
> +		sync_state &= ~I_DIRTY_SYNC;
>  
>  	if (sync_state) {
>  		ret = sync_inode_metadata(inode, 1);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
