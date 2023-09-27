Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1C7B07D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjI0PMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjI0PMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:12:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C133F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:12:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A71C433C9;
        Wed, 27 Sep 2023 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827557;
        bh=iX4dwJ00era04906TQE8AI6pkHd7dWSgaXpCKQsj6zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O796xU3H+QdZmj4XwdwQ+Ez4oebt4MOVNUVA/SOx3zwBU4nvljruTNPrOz2kHeW/E
         TTf3H1JjyQOG17gaWbApRiLWRE6QwNLsoTSwY/H1mUDffFpTmhHbN5imUCsU8lURN6
         xZUZYVcAhkUgg6s1lHR8+e93klhjhHL3OCvHF6uv1bMmt8cKn9P8+wCJEqHN7t1rQc
         pMAZjWDuP6abcdXcwBB5WOUK7KR99vAWEvI7yaftSeLSHixGynEnk8kDjxon53ftUX
         TbH030nO5vnjomKMvS9UoUNpjd6PX81jalQVCoWUfW5WK0MQ8kSYB1d2MOpSTtA0X/
         lG2eQUabNUxFQ==
Date:   Wed, 27 Sep 2023 08:12:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] fs: remove unused helper
Message-ID: <20230927151237.GF11414@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-6-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-6-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:19PM +0200, Christian Brauner wrote:
> The grab_super() helper is now only used by grab_super_dead(). Merge the
> two helpers into one.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yup, nice cleanup...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/super.c | 44 +++++++-------------------------------------
>  1 file changed, 7 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 181ac8501301..6cdce2b31622 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -517,35 +517,6 @@ void deactivate_super(struct super_block *s)
>  
>  EXPORT_SYMBOL(deactivate_super);
>  
> -/**
> - *	grab_super - acquire an active reference
> - *	@s: reference we are trying to make active
> - *
> - *	Tries to acquire an active reference.  grab_super() is used when we
> - * 	had just found a superblock in super_blocks or fs_type->fs_supers
> - *	and want to turn it into a full-blown active reference.  grab_super()
> - *	is called with sb_lock held and drops it.  Returns 1 in case of
> - *	success, 0 if we had failed (superblock contents was already dead or
> - *	dying when grab_super() had been called).  Note that this is only
> - *	called for superblocks not in rundown mode (== ones still on ->fs_supers
> - *	of their type), so increment of ->s_count is OK here.
> - */
> -static int grab_super(struct super_block *s) __releases(sb_lock)
> -{
> -	bool born;
> -
> -	s->s_count++;
> -	spin_unlock(&sb_lock);
> -	born = super_lock_excl(s);
> -	if (born && atomic_inc_not_zero(&s->s_active)) {
> -		put_super(s);
> -		return 1;
> -	}
> -	super_unlock_excl(s);
> -	put_super(s);
> -	return 0;
> -}
> -
>  static inline bool wait_dead(struct super_block *sb)
>  {
>  	unsigned int flags;
> @@ -559,7 +530,7 @@ static inline bool wait_dead(struct super_block *sb)
>  }
>  
>  /**
> - * grab_super_dead - acquire an active reference to a superblock
> + * grab_super - acquire an active reference to a superblock
>   * @sb: superblock to acquire
>   *
>   * Acquire a temporary reference on a superblock and try to trade it for
> @@ -570,17 +541,16 @@ static inline bool wait_dead(struct super_block *sb)
>   * Return: This returns true if an active reference could be acquired,
>   *         false if not.
>   */
> -static bool grab_super_dead(struct super_block *sb)
> +static bool grab_super(struct super_block *sb)
>  {
> -
>  	sb->s_count++;
> -	if (grab_super(sb)) {
> +	spin_unlock(&sb_lock);
> +	if (super_lock_excl(sb) && atomic_inc_not_zero(&sb->s_active)) {
>  		put_super(sb);
> -		lockdep_assert_held(&sb->s_umount);
>  		return true;
>  	}
> +	super_unlock_excl(sb);
>  	wait_var_event(&sb->s_flags, wait_dead(sb));
> -	lockdep_assert_not_held(&sb->s_umount);
>  	put_super(sb);
>  	return false;
>  }
> @@ -831,7 +801,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>  			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
>  		return ERR_PTR(-EBUSY);
>  	}
> -	if (!grab_super_dead(old))
> +	if (!grab_super(old))
>  		goto retry;
>  	destroy_unused_super(s);
>  	return old;
> @@ -875,7 +845,7 @@ struct super_block *sget(struct file_system_type *type,
>  				destroy_unused_super(s);
>  				return ERR_PTR(-EBUSY);
>  			}
> -			if (!grab_super_dead(old))
> +			if (!grab_super(old))
>  				goto retry;
>  			destroy_unused_super(s);
>  			return old;
> 
> -- 
> 2.34.1
> 
