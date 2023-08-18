Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CB780AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376398AbjHRLI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376403AbjHRLIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:08:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1712708
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:08:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2980A21884;
        Fri, 18 Aug 2023 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692356895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvaD4DSy05ZfHNcva0EWDwFteqJUAYrD3l8e3hByZjo=;
        b=g9fSzb6SqI4q07G8d5mYFpWkUL4db0AnYayyi8tGE+H+38KO5Xyh+HKPMFtX9fC7723FRk
        8lgp2yDxZzGXWkQfYfpLL1/EwwXFKn80875EkUQBV+KLeVgH1zFr2hg9lWxMhYPmTgWf9g
        7f4QAEo5tT8z+RjmUnFVEJ+wM6iTzK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692356895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvaD4DSy05ZfHNcva0EWDwFteqJUAYrD3l8e3hByZjo=;
        b=oiBCu1PNrj/6RBSmgR9jUovAWPLFveCZWFmD1lhabIjJWA1U6MOtPUS2bvZ7qLiStc9AvE
        qyi90rZQ7GRjHHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C32613441;
        Fri, 18 Aug 2023 11:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uD/3Ah9R32T0WgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 18 Aug 2023 11:08:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6A0AEA076B; Fri, 18 Aug 2023 13:08:14 +0200 (CEST)
Date:   Fri, 18 Aug 2023 13:08:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] super: make locking naming consistent
Message-ID: <20230818110814.fxosugjmb5znhx2h@quack3>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
 <20230818-vfs-super-fixes-v3-v2-2-cdab45934983@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-vfs-super-fixes-v3-v2-2-cdab45934983@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 12:54:16, Christian Brauner wrote:
> Make the naming consistent with the earlier introduced
> super_lock_{read,write}() helpers.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c |  4 ++--
>  fs/internal.h     |  2 +-
>  fs/super.c        | 28 ++++++++++++++--------------
>  3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index aca4b4811394..969ce991b0b0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1953,9 +1953,9 @@ static long __writeback_inodes_wb(struct bdi_writeback *wb,
>  		struct inode *inode = wb_inode(wb->b_io.prev);
>  		struct super_block *sb = inode->i_sb;
>  
> -		if (!trylock_super(sb)) {
> +		if (!super_trylock_shared(sb)) {
>  			/*
> -			 * trylock_super() may fail consistently due to
> +			 * super_trylock_shared() may fail consistently due to
>  			 * s_umount being grabbed by someone else. Don't use
>  			 * requeue_io() to avoid busy retrying the inode/sb.
>  			 */
> diff --git a/fs/internal.h b/fs/internal.h
> index b94290f61714..74d3b161dd2c 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -115,7 +115,7 @@ static inline void put_file_access(struct file *file)
>   * super.c
>   */
>  extern int reconfigure_super(struct fs_context *);
> -extern bool trylock_super(struct super_block *sb);
> +extern bool super_trylock_shared(struct super_block *sb);
>  struct super_block *user_get_super(dev_t, bool excl);
>  void put_super(struct super_block *sb);
>  extern bool mount_capable(struct fs_context *);
> diff --git a/fs/super.c b/fs/super.c
> index b12e2f247e1e..ba5d813c5804 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -112,7 +112,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>  	if (!(sc->gfp_mask & __GFP_FS))
>  		return SHRINK_STOP;
>  
> -	if (!trylock_super(sb))
> +	if (!super_trylock_shared(sb))
>  		return SHRINK_STOP;
>  
>  	if (sb->s_op->nr_cached_objects)
> @@ -159,17 +159,17 @@ static unsigned long super_cache_count(struct shrinker *shrink,
>  	sb = container_of(shrink, struct super_block, s_shrink);
>  
>  	/*
> -	 * We don't call trylock_super() here as it is a scalability bottleneck,
> -	 * so we're exposed to partial setup state. The shrinker rwsem does not
> -	 * protect filesystem operations backing list_lru_shrink_count() or
> -	 * s_op->nr_cached_objects(). Counts can change between
> -	 * super_cache_count and super_cache_scan, so we really don't need locks
> -	 * here.
> +	 * We don't call super_trylock_shared() here as it is a scalability
> +	 * bottleneck, so we're exposed to partial setup state. The shrinker
> +	 * rwsem does not protect filesystem operations backing
> +	 * list_lru_shrink_count() or s_op->nr_cached_objects(). Counts can
> +	 * change between super_cache_count and super_cache_scan, so we really
> +	 * don't need locks here.
>  	 *
>  	 * However, if we are currently mounting the superblock, the underlying
>  	 * filesystem might be in a state of partial construction and hence it
> -	 * is dangerous to access it.  trylock_super() uses a SB_BORN check to
> -	 * avoid this situation, so do the same here. The memory barrier is
> +	 * is dangerous to access it.  super_trylock_shared() uses a SB_BORN check
> +	 * to avoid this situation, so do the same here. The memory barrier is
>  	 * matched with the one in mount_fs() as we don't hold locks here.
>  	 */
>  	if (!(sb->s_flags & SB_BORN))
> @@ -428,7 +428,7 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
>  }
>  
>  /*
> - *	trylock_super - try to grab ->s_umount shared
> + *	super_trylock_shared - try to grab ->s_umount shared
>   *	@sb: reference we are trying to grab
>   *
>   *	Try to prevent fs shutdown.  This is used in places where we
> @@ -444,7 +444,7 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
>   *	of down_read().  There's a couple of places that are OK with that, but
>   *	it's very much not a general-purpose interface.
>   */
> -bool trylock_super(struct super_block *sb)
> +bool super_trylock_shared(struct super_block *sb)
>  {
>  	if (down_read_trylock(&sb->s_umount)) {
>  		if (!hlist_unhashed(&sb->s_instances) &&
> @@ -1210,7 +1210,7 @@ EXPORT_SYMBOL(get_tree_keyed);
>   * and the place that clears the pointer to the superblock used by this function
>   * before freeing the superblock.
>   */
> -static bool lock_active_super(struct super_block *sb)
> +static bool super_lock_shared_active(struct super_block *sb)
>  {
>  	super_lock_shared(sb);
>  	if (!sb->s_root ||
> @@ -1228,7 +1228,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	/* bd_holder_lock ensures that the sb isn't freed */
>  	lockdep_assert_held(&bdev->bd_holder_lock);
>  
> -	if (!lock_active_super(sb))
> +	if (!super_lock_shared_active(sb))
>  		return;
>  
>  	if (!surprise)
> @@ -1247,7 +1247,7 @@ static void fs_bdev_sync(struct block_device *bdev)
>  
>  	lockdep_assert_held(&bdev->bd_holder_lock);
>  
> -	if (!lock_active_super(sb))
> +	if (!super_lock_shared_active(sb))
>  		return;
>  	sync_filesystem(sb);
>  	super_unlock_shared(sb);
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
