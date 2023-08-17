Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0477F93B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjHQOiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352031AbjHQOhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:37:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A030E5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:37:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C82E1F37E;
        Thu, 17 Aug 2023 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSBheQgS72FH+PayfnEenCUpGM0K1qxQzbYxeX9mKF8=;
        b=If165Vs9FFPjM1/zB6lA8cVXz78u0mVJreiWFXkmvaN1LolzXtXgq/sACAvRhE562spIlg
        vUHkVD/weSAh8w5A7tRbFNaSx+j1i54m96IrhoXkk7GIzaskqjuKtRYUMfUBjfOnf8U2E7
        8FLllEyI0uR3zB4TqjbT59jxJjAtTJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSBheQgS72FH+PayfnEenCUpGM0K1qxQzbYxeX9mKF8=;
        b=c4hT5EM4xurPNPotyuB1NLIbtY0jiD51I9T0cz514kICsFAu0TxSrx27RcV4Alm6/9UERt
        g/9hmRz1F8uqinAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F25C31358B;
        Thu, 17 Aug 2023 14:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r8IfO7Aw3mR8KgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:37:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C5C6A0769; Thu, 17 Aug 2023 16:37:36 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:37:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] super: wait until we passed kill super
Message-ID: <20230817143736.u22c5o5sesojlo3y@quack3>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-3-06ddeca7059b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817-vfs-super-fixes-v3-v1-3-06ddeca7059b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 12:47:44, Christian Brauner wrote:
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
> ---
>  fs/super.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/fs.h |  1 +
>  2 files changed, 66 insertions(+), 6 deletions(-)

<snip>

> @@ -456,6 +497,25 @@ void deactivate_locked_super(struct super_block *s)
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
> @@ -638,15 +698,14 @@ void generic_shutdown_super(struct super_block *sb)
>  			spin_unlock(&sb->s_inode_list_lock);
>  		}
>  	}
> -	spin_lock(&sb_lock);
> -	/* should be initialized for __put_super_and_need_restart() */
> -	hlist_del_init(&sb->s_instances);
> -	spin_unlock(&sb_lock);

OK, but we have several checks of hlist_unhashed(&sb->s_instances) in the
code whose meaning is now subtly changed. We have:
  trylock_super() - needs SB_DYING check instead of s_instances check
  __iterate_supers() - probably we should add SB_DYING check to not block
    emergency operations on s_umount unnecessarily and drop s_instances
    check
  iterate_supers() - we can drop s_instances check
  get_super() - we can drop s_instances check
  get_active_super() - we can drop s_instances check
  user_get_super() - we can drop s_instances check

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
