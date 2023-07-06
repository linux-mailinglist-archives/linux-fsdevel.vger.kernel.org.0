Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59572749DE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjGFNiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGFNht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:37:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4C129;
        Thu,  6 Jul 2023 06:37:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 649191F85D;
        Thu,  6 Jul 2023 13:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688650666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SvjJMU2RLsCedQ3MvPejpvvnZCxXu+NaMD2t/+cpPw0=;
        b=FxtLh5kGIwVmCXz1GbBaL0cMrf4GLWoq2HllPiQNXbeDV4mZRYAJZA5Y4ErReOwl9lLf/m
        funLejrrr9NbBC4riU8y4bpQnxWFlC6I1rbevdYHiDJ81fxclMQwxLx7jtY8zgRbQgI1F7
        k3gqUIiNC8hyLZieCGpWOFV788ZrjwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688650666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SvjJMU2RLsCedQ3MvPejpvvnZCxXu+NaMD2t/+cpPw0=;
        b=Zkz5zzbeCIY1rjiLSW6rwwxZbsRzf8b9k7HZEt80avbP8w7Lh9ua78xp1qIUJl7WE/Ue9g
        fSO71Q3lTo2AUZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5671D138EE;
        Thu,  6 Jul 2023 13:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R40WFarDpmSlWwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:37:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C973AA0707; Thu,  6 Jul 2023 15:37:45 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:37:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH v2 60/92] ntfs: convert to ctime accessor functions
Message-ID: <20230706133745.rmijt7wmwn5rivwh@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-58-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-58-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:25, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ntfs/inode.c | 15 ++++++++-------
>  fs/ntfs/mft.c   |  3 +--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 6c3f38d66579..99ac6ea277c4 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -654,7 +654,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
>  	 * always changes, when mtime is changed. ctime can be changed on its
>  	 * own, mtime is then not changed, e.g. when a file is renamed.
>  	 */
> -	vi->i_ctime = ntfs2utc(si->last_mft_change_time);
> +	inode_set_ctime_to_ts(vi, ntfs2utc(si->last_mft_change_time));
>  	/*
>  	 * Last access to the data within the file. Not changed during a rename
>  	 * for example but changed whenever the file is written to.
> @@ -1218,7 +1218,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
>  	vi->i_gid	= base_vi->i_gid;
>  	set_nlink(vi, base_vi->i_nlink);
>  	vi->i_mtime	= base_vi->i_mtime;
> -	vi->i_ctime	= base_vi->i_ctime;
> +	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
>  	vi->i_atime	= base_vi->i_atime;
>  	vi->i_generation = ni->seq_no = base_ni->seq_no;
>  
> @@ -1484,7 +1484,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
>  	vi->i_gid	= base_vi->i_gid;
>  	set_nlink(vi, base_vi->i_nlink);
>  	vi->i_mtime	= base_vi->i_mtime;
> -	vi->i_ctime	= base_vi->i_ctime;
> +	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
>  	vi->i_atime	= base_vi->i_atime;
>  	vi->i_generation = ni->seq_no = base_ni->seq_no;
>  	/* Set inode type to zero but preserve permissions. */
> @@ -2804,13 +2804,14 @@ int ntfs_truncate(struct inode *vi)
>  	 */
>  	if (!IS_NOCMTIME(VFS_I(base_ni)) && !IS_RDONLY(VFS_I(base_ni))) {
>  		struct timespec64 now = current_time(VFS_I(base_ni));
> +		struct timespec64 ctime = inode_get_ctime(VFS_I(base_ni));
>  		int sync_it = 0;
>  
>  		if (!timespec64_equal(&VFS_I(base_ni)->i_mtime, &now) ||
> -		    !timespec64_equal(&VFS_I(base_ni)->i_ctime, &now))
> +		    !timespec64_equal(&ctime, &now))
>  			sync_it = 1;
> +		inode_set_ctime_to_ts(VFS_I(base_ni), now);
>  		VFS_I(base_ni)->i_mtime = now;
> -		VFS_I(base_ni)->i_ctime = now;
>  
>  		if (sync_it)
>  			mark_inode_dirty_sync(VFS_I(base_ni));
> @@ -2928,7 +2929,7 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (ia_valid & ATTR_MTIME)
>  		vi->i_mtime = attr->ia_mtime;
>  	if (ia_valid & ATTR_CTIME)
> -		vi->i_ctime = attr->ia_ctime;
> +		inode_set_ctime_to_ts(vi, attr->ia_ctime);
>  	mark_inode_dirty(vi);
>  out:
>  	return err;
> @@ -3004,7 +3005,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
>  		si->last_data_change_time = nt;
>  		modified = true;
>  	}
> -	nt = utc2ntfs(vi->i_ctime);
> +	nt = utc2ntfs(inode_get_ctime(vi));
>  	if (si->last_mft_change_time != nt) {
>  		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
>  				"new = 0x%llx", vi->i_ino, (long long)
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 0155f106ec34..ad1a8f72da22 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2682,8 +2682,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
>  			vi->i_mode &= ~S_IWUGO;
>  
>  		/* Set the inode times to the current time. */
> -		vi->i_atime = vi->i_mtime = vi->i_ctime =
> -			current_time(vi);
> +		vi->i_atime = vi->i_mtime = inode_set_ctime_current(vi);
>  		/*
>  		 * Set the file size to 0, the ntfs inode sizes are set to 0 by
>  		 * the call to ntfs_init_big_inode() below.
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
