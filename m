Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6258782DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjHUP5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjHUP5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:57:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB1A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:57:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAF6321F4F;
        Mon, 21 Aug 2023 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692633460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uv0kW6wm6qmzgAXSAgbCJhPZD9mqEQgZddcu2wG5T7k=;
        b=Qag43yARRLxTzU0s6gAE4jeaz36iQEvFwALqZp72XfQTAmJcDP1riPWAmDcngiXAsWS17q
        4bcB/gcNfbFbLR1e4Cn4UKxSHWurxME7Pcgtxv5xfSfwMb6otHO+jFrlF26BHGphzz8c9/
        KSGxnK+fsX02znocY5wb29+xcy0sxIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692633460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uv0kW6wm6qmzgAXSAgbCJhPZD9mqEQgZddcu2wG5T7k=;
        b=PejmtrPcbNjJb1ekSUD5vbc4dsDvzmbBRxOZMt6hZLXFw2luW0CgxcvNV9g8fvlfovciDj
        5HEyfbLSSdKyVKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAD471330D;
        Mon, 21 Aug 2023 15:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EOe2MXSJ42TOKwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 15:57:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 400EBA0774; Mon, 21 Aug 2023 17:57:40 +0200 (CEST)
Date:   Mon, 21 Aug 2023 17:57:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] super: wait until we passed kill super
Message-ID: <20230821155740.odhoouelk4gls4p2@quack3>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-4-9f0b1876e46b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-vfs-super-fixes-v3-v3-4-9f0b1876e46b@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 16:00:51, Christian Brauner wrote:
> Recent rework moved block device closing out of sb->put_super() and into
> sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
> blkdev_put() can end up taking s_umount again.
> 
> That means we need to move the removal of the superblock from @fs_supers
> out of generic_shutdown_super() and into deactivate_locked_super() to
> ensure that concurrent mounters don't fail to open block devices that
> are still in use because blkdev_put() in sb->kill_sb() hasn't been
> called yet.
> 
> We can now do this as we can make iterators through @fs_super and
> @super_blocks wait without holding s_umount. Concurrent mounts will wait
> until a dying superblock is fully dead so until sb->kill_sb() has been
> called and SB_DEAD been set. Concurrent iterators can already discard
> any SB_DYING superblock.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c         | 71 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  include/linux/fs.h |  1 +
>  2 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 896f05f34377..015e428818ce 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -153,7 +153,7 @@ static inline bool super_lock_excl(struct super_block *sb)
>  }
>  
>  /* wake waiters */
> -#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
> +#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
>  static void super_wake(struct super_block *sb, unsigned int flag)
>  {
>  	WARN_ON_ONCE((flag & ~SUPER_WAKE_FLAGS));
> @@ -457,6 +457,25 @@ void deactivate_locked_super(struct super_block *s)
>  		list_lru_destroy(&s->s_dentry_lru);
>  		list_lru_destroy(&s->s_inode_lru);
>  
> +		/*
> +		 * Remove it from @fs_supers so it isn't found by new
> +		 * sget{_fc}() walkers anymore. Any concurrent mounter still
> +		 * managing to grab a temporary reference is guaranteed to
> +		 * already see SB_DYING and will wait until we notify them about
> +		 * SB_DEAD.
> +		 */
> +		spin_lock(&sb_lock);
> +		hlist_del_init(&s->s_instances);
> +		spin_unlock(&sb_lock);
> +
> +		/*
> +		 * Let concurrent mounts know that this thing is really dead.
> +		 * We don't need @sb->s_umount here as every concurrent caller
> +		 * will see SB_DYING and either discard the superblock or wait
> +		 * for SB_DEAD.
> +		 */
> +		super_wake(s, SB_DEAD);
> +
>  		put_filesystem(fs);
>  		put_super(s);
>  	} else {
> @@ -513,6 +532,45 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
>  	return 0;
>  }
>  
> +static inline bool wait_dead(struct super_block *sb)
> +{
> +	unsigned int flags;
> +
> +	/*
> +	 * Pairs with memory barrier in super_wake() and ensures
> +	 * that we see SB_DEAD after we're woken.
> +	 */
> +	flags = smp_load_acquire(&sb->s_flags);
> +	return flags & SB_DEAD;
> +}
> +
> +/**
> + * grab_super_dead - acquire an active reference to a superblock
> + * @sb: superblock to acquire
> + *
> + * Acquire a temporary reference on a superblock and try to trade it for
> + * an active reference. This is used in sget{_fc}() to wait for a
> + * superblock to either become SB_BORN or for it to pass through
> + * sb->kill() and be marked as SB_DEAD.
> + *
> + * Return: This returns true if an active reference could be acquired,
> + *         false if not.
> + */
> +static bool grab_super_dead(struct super_block *sb)
> +{
> +
> +	sb->s_count++;
> +	if (grab_super(sb)) {
> +		put_super(sb);
> +		lockdep_assert_held(&sb->s_umount);
> +		return true;
> +	}
> +	wait_var_event(&sb->s_flags, wait_dead(sb));
> +	put_super(sb);
> +	lockdep_assert_not_held(&sb->s_umount);
> +	return false;
> +}
> +
>  /*
>   *	super_trylock_shared - try to grab ->s_umount shared
>   *	@sb: reference we are trying to grab
> @@ -639,15 +697,14 @@ void generic_shutdown_super(struct super_block *sb)
>  			spin_unlock(&sb->s_inode_list_lock);
>  		}
>  	}
> -	spin_lock(&sb_lock);
> -	/* should be initialized for __put_super_and_need_restart() */
> -	hlist_del_init(&sb->s_instances);
> -	spin_unlock(&sb_lock);
>  	/*
>  	 * Broadcast to everyone that grabbed a temporary reference to this
>  	 * superblock before we removed it from @fs_supers that the superblock
>  	 * is dying. Every walker of @fs_supers outside of sget{_fc}() will now
>  	 * discard this superblock and treat it as dead.
> +	 *
> +	 * We leave the superblock on @fs_supers so it can be found by
> +	 * sget{_fc}() until we passed sb->kill_sb().
>  	 */
>  	super_wake(sb, SB_DYING);
>  	super_unlock_excl(sb);
> @@ -742,7 +799,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>  		destroy_unused_super(s);
>  		return ERR_PTR(-EBUSY);
>  	}
> -	if (!grab_super(old))
> +	if (!grab_super_dead(old))
>  		goto retry;
>  	destroy_unused_super(s);
>  	return old;
> @@ -786,7 +843,7 @@ struct super_block *sget(struct file_system_type *type,
>  				destroy_unused_super(s);
>  				return ERR_PTR(-EBUSY);
>  			}
> -			if (!grab_super(old))
> +			if (!grab_super_dead(old))
>  				goto retry;
>  			destroy_unused_super(s);
>  			return old;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 173672645156..a63da68305e9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1095,6 +1095,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
>  
>  /* These sb flags are internal to the kernel */
> +#define SB_DEAD         BIT(21)
>  #define SB_DYING        BIT(24)
>  #define SB_SUBMOUNT     BIT(26)
>  #define SB_FORCE        BIT(27)
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
