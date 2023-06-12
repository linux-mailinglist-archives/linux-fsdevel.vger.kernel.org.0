Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6672C2D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjFLLc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjFLLcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:32:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FC3AA4;
        Mon, 12 Jun 2023 04:08:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE8C622817;
        Mon, 12 Jun 2023 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686568091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jhJymzBB10fV9NytAOeb4PNWkPrKmPW9pNRox9P85cE=;
        b=lENdguABgJldqkUbfytzOauxJaYfveRt93kiXkFneW5eFKP4QvMGeMTM7/FbgEUOvrSVAN
        XxWHUXpPAKZNR877XkMRD50cgbeU09M4qdsY6Ixq8QM1xZmCLweDg/VmbfTZJXBsVH/RuM
        l3OvYj4T6F1Bv8K99ivIBKLITuyK5/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686568091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jhJymzBB10fV9NytAOeb4PNWkPrKmPW9pNRox9P85cE=;
        b=1ZulGmBtxZmQZIN5LtMWHKtZ5Kiz/Z5XoOjLu2u4DpW+9HJYkeurTqrz3b9WWvTqhRYf7I
        a+jJJqLVF4+D0ZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF0C7138EC;
        Mon, 12 Jun 2023 11:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0qq4Kpv8hmT0PQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 11:08:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4D6C2A0717; Mon, 12 Jun 2023 13:08:11 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:08:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230612110811.m7hv42sfqyfr6rwh@quack3>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972267.755178.18328538743442432037.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168653972267.755178.18328538743442432037.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 11-06-23 20:15:22, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> suspending the block device; this state persists until userspace thaws
> the filesystem with the FITHAW ioctl or resuming the block device.
> Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> the fsfreeze ioctl") we only allow the first freeze command to succeed.
> 
> The kernel may decide that it is necessary to freeze a filesystem for
> its own internal purposes, such as suspends in progress, filesystem fsck
> activities, or quiescing a device prior to removal.  Userspace thaw
> commands must never break a kernel freeze, and kernel thaw commands
> shouldn't undo userspace's freeze command.
> 
> Introduce a couple of freeze holder flags and wire it into the
> sb_writers state.  One kernel and one userspace freeze are allowed to
> coexist at the same time; the filesystem will not thaw until both are
> lifted.
> 
> I wonder if the f2fs/gfs2 code should be using a kernel freeze here, but
> for now we'll use FREEZE_HOLDER_USERSPACE to preserve existing
> behaviors.
> 
> Cc: mcgrof@kernel.org
> Cc: jack@suse.cz
> Cc: hch@infradead.org
> Cc: ruansy.fnst@fujitsu.com
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Thanks Darrick. Some comments below.

> +static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
> +{
> +	/* Someone else already holds this type of freeze */
> +	if (sb->s_writers.freeze_holders & who)
> +		return -EBUSY;
> +
> +	WARN_ON(sb->s_writers.freeze_holders == 0);
> +
> +	sb->s_writers.freeze_holders |= who;
> +	return 0;
> +}
> +
>  /**
>   * freeze_super - lock the filesystem and force it into a consistent state
>   * @sb: the super to lock
> + * @who: FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
> + * FREEZE_HOLDER_KERNEL if the kernel wants to freeze it
>   *
>   * Syncs the super to make sure the filesystem is consistent and calls the fs's
> - * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> + * freeze_fs.  Subsequent calls to this without first thawing the fs may return
>   * -EBUSY.
>   *
> + * The @who argument distinguishes between the kernel and userspace trying to
> + * freeze the filesystem.  Although there cannot be multiple kernel freezes or
> + * multiple userspace freezes in effect at any given time, the kernel and
> + * userspace can both hold a filesystem frozen.  The filesystem remains frozen
> + * until there are no kernel or userspace freezes in effect.
> + *
>   * During this function, sb->s_writers.frozen goes through these values:
>   *
>   * SB_UNFROZEN: File system is normal, all writes progress as usual.
> @@ -1668,12 +1688,19 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>   *
>   * sb->s_writers.frozen is protected by sb->s_umount.
>   */
> -int freeze_super(struct super_block *sb)
> +int freeze_super(struct super_block *sb, enum freeze_holder who)
>  {
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
> +
> +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> +		ret = freeze_frozen_super(sb, who);
> +		deactivate_locked_super(sb);
> +		return ret;
> +	}

I find it a little bit odd that the second freeze holder does not get the
active superblock reference. It all looks correct but I'd find it easier to
reason about (and also eventually lift the reference counting out of
freeze_super()) if the rule was: Successful freeze_super() <=> you have
s_active reference.

> +
>  	if (sb->s_writers.frozen != SB_UNFROZEN) {

I still find it strange that:

Task1					Task2

while (1) {				while (1) {
  ioctl(f, FIFREEZE);			  freeze_super(sb, FREEZE_HOLDER_KERNEL);
  ioctl(f, FITHAW);			  thaw_super(sb, FREEZE_HOLDER_KERNEL);
}					}

will randomly end up returning EBUSY to Task1 or Task2 although there is no
real conflict. I think it will be much more useful behavior if in case of
this conflict the second holder just waited for freezing procedure to finish
and then report success. Because I don't think either caller can do
anything sensible with this race other than retry but it cannot really
distinguish EBUSY as in "someone other holder of the same type has the sb
already frozen" from "freezing raced with holder of a different type".


>  		deactivate_locked_super(sb);
>  		return -EBUSY;
> @@ -1684,8 +1711,10 @@ int freeze_super(struct super_block *sb)
>  		return 0;	/* sic - it's "nothing to do" */
>  	}
>  
> +

Why the extra empty line?

>  	if (sb_rdonly(sb)) {
>  		/* Nothing to do really... */
> +		sb->s_writers.freeze_holders |= who;
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  		up_write(&sb->s_umount);
>  		return 0;
> @@ -1731,6 +1760,7 @@ int freeze_super(struct super_block *sb)
>  	 * For debugging purposes so that fs can warn if it sees write activity
>  	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
>  	 */
> +	sb->s_writers.freeze_holders |= who;
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  	lockdep_sb_freeze_release(sb);
>  	up_write(&sb->s_umount);
> @@ -1738,16 +1768,47 @@ int freeze_super(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(freeze_super);
>  
> -static int thaw_super_locked(struct super_block *sb)
> +static int try_thaw_shared_super(struct super_block *sb, enum freeze_holder who)
> +{
> +	/* Freeze is not held by this type? */
> +	if (!(sb->s_writers.freeze_holders & who))
> +		return -EINVAL;
> +
> +	/* Also frozen for someone else? */
> +	if (sb->s_writers.freeze_holders & ~who) {
> +		sb->s_writers.freeze_holders &= ~who;
> +		return 0;
> +	}
> +
> +	/* Magic value to proceed with thaw */
> +	return 1;
> +}
> +
> +/*
> + * Undoes the effect of a freeze_super_locked call.  If the filesystem is
> + * frozen both by userspace and the kernel, a thaw call from either source
> + * removes that state without releasing the other state or unlocking the
> + * filesystem.
> + */
> +static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  {
>  	int error;
>  
> +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> +		error = try_thaw_shared_super(sb, who);
> +		if (error != 1) {
> +			up_write(&sb->s_umount);
> +			return error;
> +		}
> +	}
> +
>  	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
>  		up_write(&sb->s_umount);
>  		return -EINVAL;
>  	}

I'd first check for the above condition and then just fold
try_thaw_shared_super() into here. That way you can avoid the odd special
return and the code will be actually more readable. Probably we should grow
out_err label for:

	up_write(&sb->s_umount);
	return error;

and use it for the error returns as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
