Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68DF749FD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGFOwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjGFOwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:52:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9711FC8;
        Thu,  6 Jul 2023 07:52:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23C1F1FD65;
        Thu,  6 Jul 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LgZwsKI2T3oa0WncIjDyarSkI0GCAb7uNCNg6xYK9Y=;
        b=jhNa9vmboRax7O75Hw7m7bur3/q/eg7nb3uJb3R50OnQDiTJJZbT5rqJQtMdNhg3sCGl+4
        lC0WP/JWx30VjPRA9toi9q45dJaWY9n3swejKo9vbTlqrB6LkNIXDTTbKxkcp1FOu1JaSm
        8Nt4Xi3vkMK/Du3rLBTJUuXDcWTS9Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655125;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LgZwsKI2T3oa0WncIjDyarSkI0GCAb7uNCNg6xYK9Y=;
        b=oHJkIUL9M1Q3+szTqQx+MYm3Gz8aEq+us9efoe/4GNIP97YsxR4WkGfQGw6QUZ9bDcvzWV
        PgRsQHccjU1MIvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13FB41390F;
        Thu,  6 Jul 2023 14:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g5zfBBXVpmQEAwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:52:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8ED00A0707; Thu,  6 Jul 2023 16:52:04 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:52:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 82/92] xfs: convert to ctime accessor functions
Message-ID: <20230706145204.5n5c4oruohfqwwic@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-80-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-80-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:47, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xfs/libxfs/xfs_inode_buf.c   | 5 +++--
>  fs/xfs/libxfs/xfs_trans_inode.c | 2 +-
>  fs/xfs/xfs_acl.c                | 2 +-
>  fs/xfs/xfs_bmap_util.c          | 6 ++++--
>  fs/xfs/xfs_inode.c              | 3 +--
>  fs/xfs/xfs_inode_item.c         | 2 +-
>  fs/xfs/xfs_iops.c               | 4 ++--
>  fs/xfs/xfs_itable.c             | 4 ++--
>  8 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index 758aacd8166b..a35781577cad 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -222,7 +222,8 @@ xfs_inode_from_disk(
>  	 */
>  	inode->i_atime = xfs_inode_from_disk_ts(from, from->di_atime);
>  	inode->i_mtime = xfs_inode_from_disk_ts(from, from->di_mtime);
> -	inode->i_ctime = xfs_inode_from_disk_ts(from, from->di_ctime);
> +	inode_set_ctime_to_ts(inode,
> +			      xfs_inode_from_disk_ts(from, from->di_ctime));
>  
>  	ip->i_disk_size = be64_to_cpu(from->di_size);
>  	ip->i_nblocks = be64_to_cpu(from->di_nblocks);
> @@ -316,7 +317,7 @@ xfs_inode_to_disk(
>  
>  	to->di_atime = xfs_inode_to_disk_ts(ip, inode->i_atime);
>  	to->di_mtime = xfs_inode_to_disk_ts(ip, inode->i_mtime);
> -	to->di_ctime = xfs_inode_to_disk_ts(ip, inode->i_ctime);
> +	to->di_ctime = xfs_inode_to_disk_ts(ip, inode_get_ctime(inode));
>  	to->di_nlink = cpu_to_be32(inode->i_nlink);
>  	to->di_gen = cpu_to_be32(inode->i_generation);
>  	to->di_mode = cpu_to_be16(inode->i_mode);
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index cb4796b6e693..6b2296ff248a 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -67,7 +67,7 @@ xfs_trans_ichgtime(
>  	if (flags & XFS_ICHGTIME_MOD)
>  		inode->i_mtime = tv;
>  	if (flags & XFS_ICHGTIME_CHG)
> -		inode->i_ctime = tv;
> +		inode_set_ctime_to_ts(inode, tv);
>  	if (flags & XFS_ICHGTIME_CREATE)
>  		ip->i_crtime = tv;
>  }
> diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
> index 791db7d9c849..6b840301817a 100644
> --- a/fs/xfs/xfs_acl.c
> +++ b/fs/xfs/xfs_acl.c
> @@ -233,7 +233,7 @@ xfs_acl_set_mode(
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  	inode->i_mode = mode;
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  
>  	if (xfs_has_wsync(mp))
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index fbb675563208..fcefab687285 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1644,6 +1644,7 @@ xfs_swap_extents(
>  	uint64_t		f;
>  	int			resblks = 0;
>  	unsigned int		flags = 0;
> +	struct timespec64	ctime;
>  
>  	/*
>  	 * Lock the inodes against other IO, page faults and truncate to
> @@ -1756,8 +1757,9 @@ xfs_swap_extents(
>  	 * process that the file was not changed out from
>  	 * under it.
>  	 */
> -	if ((sbp->bs_ctime.tv_sec != VFS_I(ip)->i_ctime.tv_sec) ||
> -	    (sbp->bs_ctime.tv_nsec != VFS_I(ip)->i_ctime.tv_nsec) ||
> +	ctime = inode_get_ctime(VFS_I(ip));
> +	if ((sbp->bs_ctime.tv_sec != ctime.tv_sec) ||
> +	    (sbp->bs_ctime.tv_nsec != ctime.tv_nsec) ||
>  	    (sbp->bs_mtime.tv_sec != VFS_I(ip)->i_mtime.tv_sec) ||
>  	    (sbp->bs_mtime.tv_nsec != VFS_I(ip)->i_mtime.tv_nsec)) {
>  		error = -EBUSY;
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc500140..360fe83a334f 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -843,10 +843,9 @@ xfs_init_new_inode(
>  	ip->i_df.if_nextents = 0;
>  	ASSERT(ip->i_nblocks == 0);
>  
> -	tv = current_time(inode);
> +	tv = inode_set_ctime_current(inode);
>  	inode->i_mtime = tv;
>  	inode->i_atime = tv;
> -	inode->i_ctime = tv;
>  
>  	ip->i_extsize = 0;
>  	ip->i_diflags = 0;
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index 91c847a84e10..127b2410eb20 100644
> --- a/fs/xfs/xfs_inode_item.c
> +++ b/fs/xfs/xfs_inode_item.c
> @@ -528,7 +528,7 @@ xfs_inode_to_log_dinode(
>  	memset(to->di_pad3, 0, sizeof(to->di_pad3));
>  	to->di_atime = xfs_inode_to_log_dinode_ts(ip, inode->i_atime);
>  	to->di_mtime = xfs_inode_to_log_dinode_ts(ip, inode->i_mtime);
> -	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode->i_ctime);
> +	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode_get_ctime(inode));
>  	to->di_nlink = inode->i_nlink;
>  	to->di_gen = inode->i_generation;
>  	to->di_mode = inode->i_mode;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 24718adb3c16..3a9363953ef2 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -574,7 +574,7 @@ xfs_vn_getattr(
>  	stat->ino = ip->i_ino;
>  	stat->atime = inode->i_atime;
>  	stat->mtime = inode->i_mtime;
> -	stat->ctime = inode->i_ctime;
> +	stat->ctime = inode_get_ctime(inode);
>  	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
>  
>  	if (xfs_has_v3inodes(mp)) {
> @@ -1055,7 +1055,7 @@ xfs_vn_update_time(
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	if (flags & S_CTIME)
> -		inode->i_ctime = *now;
> +		inode_set_ctime_to_ts(inode, *now);
>  	if (flags & S_MTIME)
>  		inode->i_mtime = *now;
>  	if (flags & S_ATIME)
> diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
> index f225413a993c..c2093cb56092 100644
> --- a/fs/xfs/xfs_itable.c
> +++ b/fs/xfs/xfs_itable.c
> @@ -100,8 +100,8 @@ xfs_bulkstat_one_int(
>  	buf->bs_atime_nsec = inode->i_atime.tv_nsec;
>  	buf->bs_mtime = inode->i_mtime.tv_sec;
>  	buf->bs_mtime_nsec = inode->i_mtime.tv_nsec;
> -	buf->bs_ctime = inode->i_ctime.tv_sec;
> -	buf->bs_ctime_nsec = inode->i_ctime.tv_nsec;
> +	buf->bs_ctime = inode_get_ctime(inode).tv_sec;
> +	buf->bs_ctime_nsec = inode_get_ctime(inode).tv_nsec;
>  	buf->bs_gen = inode->i_generation;
>  	buf->bs_mode = inode->i_mode;
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
