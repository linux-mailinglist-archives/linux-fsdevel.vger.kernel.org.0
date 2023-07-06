Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9B749E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGFNwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGFNwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:52:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75419B2;
        Thu,  6 Jul 2023 06:52:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C9A41FDD8;
        Thu,  6 Jul 2023 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQ1RlVHox01/rgjSoYSm03xJTT4dNPjyRy/SW3c06/I=;
        b=P6/roGV8ofwgwQOqyOcPm2T2lwFAhk1iACl50Z7OB/oGbSRtd9Gf6h6fnxNj9LTQbebFHo
        z76QgjEcuRDjH90SZWvkgd365O30hUZIzmsdZlAnVgrl9U5rHpb4kVQpH6RZoQWYU6o+Qe
        uCPrm8a0ZhTa93YCB4/T2Rl2CEPC7N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651526;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQ1RlVHox01/rgjSoYSm03xJTT4dNPjyRy/SW3c06/I=;
        b=wu+9VobU0JAe09HZ/DliYN87fD85tZ4uXmH3Oiz9QYEPnqTsoNIic2/7a9cDhNkXHSHiHn
        0LPp7rh0bPq35oDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FBAF138EE;
        Thu,  6 Jul 2023 13:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 80FREwbHpmQ1YwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:52:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C158CA0707; Thu,  6 Jul 2023 15:52:05 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:52:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 63/92] omfs: convert to ctime accessor functions
Message-ID: <20230706135205.jrxfi6d2555ct7cg@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-61-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-61-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:28, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Bob Copeland <me@bobcopeland.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/omfs/dir.c   | 4 ++--
>  fs/omfs/inode.c | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
> index 82cf7e9a665f..6bda275826d6 100644
> --- a/fs/omfs/dir.c
> +++ b/fs/omfs/dir.c
> @@ -143,7 +143,7 @@ static int omfs_add_link(struct dentry *dentry, struct inode *inode)
>  	mark_buffer_dirty(bh);
>  	brelse(bh);
>  
> -	dir->i_ctime = current_time(dir);
> +	inode_set_ctime_current(dir);
>  
>  	/* mark affected inodes dirty to rebuild checksums */
>  	mark_inode_dirty(dir);
> @@ -399,7 +399,7 @@ static int omfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	if (err)
>  		goto out;
>  
> -	old_inode->i_ctime = current_time(old_inode);
> +	inode_set_ctime_current(old_inode);
>  	mark_inode_dirty(old_inode);
>  out:
>  	return err;
> diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
> index c4c79e07efc7..2f8c1882f45c 100644
> --- a/fs/omfs/inode.c
> +++ b/fs/omfs/inode.c
> @@ -51,7 +51,7 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
>  	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
>  	inode->i_mapping->a_ops = &omfs_aops;
>  
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	switch (mode & S_IFMT) {
>  	case S_IFDIR:
>  		inode->i_op = &omfs_dir_inops;
> @@ -134,8 +134,8 @@ static int __omfs_write_inode(struct inode *inode, int wait)
>  	oi->i_head.h_magic = OMFS_IMAGIC;
>  	oi->i_size = cpu_to_be64(inode->i_size);
>  
> -	ctime = inode->i_ctime.tv_sec * 1000LL +
> -		((inode->i_ctime.tv_nsec + 999)/1000);
> +	ctime = inode_get_ctime(inode).tv_sec * 1000LL +
> +		((inode_get_ctime(inode).tv_nsec + 999)/1000);
>  	oi->i_ctime = cpu_to_be64(ctime);
>  
>  	omfs_update_checksums(oi);
> @@ -232,10 +232,9 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
>  
>  	inode->i_atime.tv_sec = ctime;
>  	inode->i_mtime.tv_sec = ctime;
> -	inode->i_ctime.tv_sec = ctime;
> +	inode_set_ctime(inode, ctime, nsecs);
>  	inode->i_atime.tv_nsec = nsecs;
>  	inode->i_mtime.tv_nsec = nsecs;
> -	inode->i_ctime.tv_nsec = nsecs;
>  
>  	inode->i_mapping->a_ops = &omfs_aops;
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
