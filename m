Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02C78B155
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjH1NIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjH1NHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:07:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A1C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 06:07:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F6CC1FD6A;
        Mon, 28 Aug 2023 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693228045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZpW2wCsXjX7PpPx7Pk0qxJ7eWFIs3ijG2aJOKxu8iI=;
        b=RQeaFxChuP0ZxWBL5kp+fNH9Sm1d1KuIkhzlZ0TPe2zjAaNReryR655eJbw+J9TZHKYqUN
        j+ymvNR0CnmLjuCC4xM9eh15BvbK2+ihDMviPOa7ZIb/4dxZABWTcXIvTrVFgWw1a+dcAi
        jG73sT1Is2N0GLUH3pdblntt2urj7zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693228045;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZpW2wCsXjX7PpPx7Pk0qxJ7eWFIs3ijG2aJOKxu8iI=;
        b=7j9R1URKtFIpRPzPga6w13FSN5pq81T+WfQWfsOHwGIo9ndoQGzaxUhRfTW/X9myGFcvNG
        dnBH0itEu0qPaZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8264D13A11;
        Mon, 28 Aug 2023 13:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N2rPHw2c7GTvLwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 13:07:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0C92EA0774; Mon, 28 Aug 2023 15:07:25 +0200 (CEST)
Date:   Mon, 28 Aug 2023 15:07:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] super: ensure valid info
Message-ID: <20230828130725.azxxf2hrhokwugxk@quack3>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
 <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-08-23 13:26:24, Christian Brauner wrote:
> For keyed filesystems that recycle superblocks based on s_fs_info or
> information contained therein s_fs_info must be kept as long as the
> superblock is on the filesystem type super list. This isn't guaranteed
> as s_fs_info will be freed latest in sb->kill_sb().
> 
> The fix is simply to perform notification and list removal in
> kill_anon_super(). Any filesystem needs to free s_fs_info after they
> call the kill_*() helpers. If they don't they risk use-after-free right
> now so fixing it here is guaranteed that s_fs_info remain valid.
> 
> For block backed filesystems notifying in pass sb->kill_sb() in
> deactivate_locked_super() remains unproblematic and is required because
> multiple other block devices can be shut down after kill_block_super()
> has been called from a filesystem's sb->kill_sb() handler. For example,
> ext4 and xfs close additional devices. Block based filesystems don't
> depend on s_fs_info (btrfs does use s_fs_info but also uses
> kill_anon_super() and not kill_block_super().).
> 
> Sorry for that braino. Goal should be to unify this behavior during this
> cycle obviously. But let's please do a simple bugfix now.
> 
> Fixes: 2c18a63b760a ("super: wait until we passed kill super")
> Fixes: syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
> Reported-by: syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

So AFAICT this fixes the UAF issues. It does reintroduce the EBUSY problems
with mount racing with umount e.g. for EROFS which calls bdev_release()
after calling kill_anon_super() but I think we can live with that until we
come up with a neater solution for this problem. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 49 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 779247eb219c..ad7ac3a24d38 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -434,6 +434,33 @@ void put_super(struct super_block *sb)
>  	spin_unlock(&sb_lock);
>  }
>  
> +static void kill_super_notify(struct super_block *sb)
> +{
> +	lockdep_assert_not_held(&sb->s_umount);
> +
> +	/* already notified earlier */
> +	if (sb->s_flags & SB_DEAD)
> +		return;
> +
> +	/*
> +	 * Remove it from @fs_supers so it isn't found by new
> +	 * sget{_fc}() walkers anymore. Any concurrent mounter still
> +	 * managing to grab a temporary reference is guaranteed to
> +	 * already see SB_DYING and will wait until we notify them about
> +	 * SB_DEAD.
> +	 */
> +	spin_lock(&sb_lock);
> +	hlist_del_init(&sb->s_instances);
> +	spin_unlock(&sb_lock);
> +
> +	/*
> +	 * Let concurrent mounts know that this thing is really dead.
> +	 * We don't need @sb->s_umount here as every concurrent caller
> +	 * will see SB_DYING and either discard the superblock or wait
> +	 * for SB_DEAD.
> +	 */
> +	super_wake(sb, SB_DEAD);
> +}
>  
>  /**
>   *	deactivate_locked_super	-	drop an active reference to superblock
> @@ -453,6 +480,8 @@ void deactivate_locked_super(struct super_block *s)
>  		unregister_shrinker(&s->s_shrink);
>  		fs->kill_sb(s);
>  
> +		kill_super_notify(s);
> +
>  		/*
>  		 * Since list_lru_destroy() may sleep, we cannot call it from
>  		 * put_super(), where we hold the sb_lock. Therefore we destroy
> @@ -461,25 +490,6 @@ void deactivate_locked_super(struct super_block *s)
>  		list_lru_destroy(&s->s_dentry_lru);
>  		list_lru_destroy(&s->s_inode_lru);
>  
> -		/*
> -		 * Remove it from @fs_supers so it isn't found by new
> -		 * sget{_fc}() walkers anymore. Any concurrent mounter still
> -		 * managing to grab a temporary reference is guaranteed to
> -		 * already see SB_DYING and will wait until we notify them about
> -		 * SB_DEAD.
> -		 */
> -		spin_lock(&sb_lock);
> -		hlist_del_init(&s->s_instances);
> -		spin_unlock(&sb_lock);
> -
> -		/*
> -		 * Let concurrent mounts know that this thing is really dead.
> -		 * We don't need @sb->s_umount here as every concurrent caller
> -		 * will see SB_DYING and either discard the superblock or wait
> -		 * for SB_DEAD.
> -		 */
> -		super_wake(s, SB_DEAD);
> -
>  		put_filesystem(fs);
>  		put_super(s);
>  	} else {
> @@ -1260,6 +1270,7 @@ void kill_anon_super(struct super_block *sb)
>  {
>  	dev_t dev = sb->s_dev;
>  	generic_shutdown_super(sb);
> +	kill_super_notify(sb);
>  	free_anon_bdev(dev);
>  }
>  EXPORT_SYMBOL(kill_anon_super);
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
