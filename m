Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED173321F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjFPNYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjFPNYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:24:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961EED;
        Fri, 16 Jun 2023 06:24:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDF921F8AB;
        Fri, 16 Jun 2023 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686921851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIUgsOeG+CguKp/3EioHRDd0ffbR8IFJVCGqq3jlOGU=;
        b=fZZOvs+DnziSEo42/jvcB9m55CUqUet3gjNEIAf7jbwu3C+YbzxA+7qHCDkwjPIGqcMsQT
        IY2nCiiExU14n+AMr4kxJ6YB79qOHvs3mDXdqnclvn5Q3okYfRBtEMr/g4U5QTKvVvFZi8
        r58rvHDkx/I32zCVx8xMrT1mZhacsQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686921851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIUgsOeG+CguKp/3EioHRDd0ffbR8IFJVCGqq3jlOGU=;
        b=rFQVCb4qCAFfOH34CB+cFsMGGAuWdIeKGEnUV3XvjacgbQVSADpPjvhb7UMPotNkw3fvl/
        9BkeP4n19yjkePDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEAD1138E8;
        Fri, 16 Jun 2023 13:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /O9fNntijGRWRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 13:24:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67176A0755; Fri, 16 Jun 2023 15:24:11 +0200 (CEST)
Date:   Fri, 16 Jun 2023 15:24:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <20230616132411.bzhl3z6fawyn6uho@quack3>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
 <168688011838.860947.2073512011056060112.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168688011838.860947.2073512011056060112.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-06-23 18:48:38, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Jan Kara suggested that when one thread is in the middle of freezing a
> filesystem, another thread trying to freeze the same fs but with a
> different freeze_holder should wait until the freezer reaches either end
> state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.
> 
> Neither caller can do anything sensible with this race other than retry
> but they cannot really distinguish EBUSY as in "someone other holder of
						  ^^^ some

> the same type has the sb already frozen" from "freezing raced with
> holder of a different type".
> 
> Plumb in the extra coded needed to wait for the fs freezer to reach an
		     ^^^ code

> end state and try the freeze again.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Besides these typo fixes the patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c |   34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/fs/super.c b/fs/super.c
> index 81fb67157cba..1b8ea81788d4 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1635,6 +1635,24 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>  		percpu_up_write(sb->s_writers.rw_sem + level);
>  }
>  
> +static int wait_for_partially_frozen(struct super_block *sb)
> +{
> +	int ret = 0;
> +
> +	do {
> +		unsigned short old = sb->s_writers.frozen;
> +
> +		up_write(&sb->s_umount);
> +		ret = wait_var_event_killable(&sb->s_writers.frozen,
> +					       sb->s_writers.frozen != old);
> +		down_write(&sb->s_umount);
> +	} while (ret == 0 &&
> +		 sb->s_writers.frozen != SB_UNFROZEN &&
> +		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);
> +
> +	return ret;
> +}
> +
>  /**
>   * freeze_super - lock the filesystem and force it into a consistent state
>   * @sb: the super to lock
> @@ -1686,6 +1704,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
>  
> +retry:
>  	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
>  		if (sb->s_writers.freeze_holders & who) {
>  			deactivate_locked_super(sb);
> @@ -1704,8 +1723,13 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	}
>  
>  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> -		deactivate_locked_super(sb);
> -		return -EBUSY;
> +		ret = wait_for_partially_frozen(sb);
> +		if (ret) {
> +			deactivate_locked_super(sb);
> +			return ret;
> +		}
> +
> +		goto retry;
>  	}
>  
>  	if (!(sb->s_flags & SB_BORN)) {
> @@ -1717,6 +1741,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  		/* Nothing to do really... */
>  		sb->s_writers.freeze_holders |= who;
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> +		wake_up_var(&sb->s_writers.frozen);
>  		up_write(&sb->s_umount);
>  		return 0;
>  	}
> @@ -1737,6 +1762,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
>  		wake_up(&sb->s_writers.wait_unfrozen);
> +		wake_up_var(&sb->s_writers.frozen);
>  		deactivate_locked_super(sb);
>  		return ret;
>  	}
> @@ -1753,6 +1779,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  			sb->s_writers.frozen = SB_UNFROZEN;
>  			sb_freeze_unlock(sb, SB_FREEZE_FS);
>  			wake_up(&sb->s_writers.wait_unfrozen);
> +			wake_up_var(&sb->s_writers.frozen);
>  			deactivate_locked_super(sb);
>  			return ret;
>  		}
> @@ -1763,6 +1790,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	 */
>  	sb->s_writers.freeze_holders |= who;
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> +	wake_up_var(&sb->s_writers.frozen);
>  	lockdep_sb_freeze_release(sb);
>  	up_write(&sb->s_umount);
>  	return 0;
> @@ -1803,6 +1831,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.freeze_holders &= ~who;
>  		sb->s_writers.frozen = SB_UNFROZEN;
> +		wake_up_var(&sb->s_writers.frozen);
>  		goto out;
>  	}
>  
> @@ -1821,6 +1850,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  
>  	sb->s_writers.freeze_holders &= ~who;
>  	sb->s_writers.frozen = SB_UNFROZEN;
> +	wake_up_var(&sb->s_writers.frozen);
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
>  	wake_up(&sb->s_writers.wait_unfrozen);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
