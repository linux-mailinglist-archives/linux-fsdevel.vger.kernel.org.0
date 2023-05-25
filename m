Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA6710E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbjEYOOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjEYOOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 10:14:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85929183;
        Thu, 25 May 2023 07:14:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C06521CBC;
        Thu, 25 May 2023 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685024071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7RZVOpUgKAIKKStr6mg8ItmOigKUlpi4ivof3Issio=;
        b=TTqW+UC0GIpI7UOwRaBG29HSTo3TfDzWh+Q4gQht0/v4jLFfFjJww8xnmDgqGaGTrF86Rg
        ojwRa/AgsxcMV8ZShfSCjAZzed4lPNwe0mw+z7pVKue3lnHpZDCFBSRodwoZcBDU5zb4NX
        jK5EhS2CW6cc1fwU+GODk695Ytv5iVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685024071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7RZVOpUgKAIKKStr6mg8ItmOigKUlpi4ivof3Issio=;
        b=aZ8WnxzKcjA2gdMAZYdYL0wMophIY0sBTBWymF80w/z8EAEjfOgUJTDHKTQVPzDWv4Kwhv
        Uc3l0FhszMYBGbBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 043A5134B2;
        Thu, 25 May 2023 14:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QzL1AEdtb2SbZgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 14:14:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86387A075C; Thu, 25 May 2023 16:14:30 +0200 (CEST)
Date:   Thu, 25 May 2023 16:14:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230525141430.slms7f2xkmesezy5@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wr2u3ku724mk4x5d"
Content-Disposition: inline
In-Reply-To: <20230522234200.GC11598@frogsfrogsfrogs>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wr2u3ku724mk4x5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 22-05-23 16:42:00, Darrick J. Wong wrote:
> How about this as an alternative patch?  Kernel and userspace freeze
> state are stored in s_writers; each type cannot block the other (though
> you still can't have nested kernel or userspace freezes); and the freeze
> is maintained until /both/ freeze types are dropped.
> 
> AFAICT this should work for the two other usecases (quiescing pagefaults
> for fsdax pmem pre-removal; and freezing fses during suspend) besides
> online fsck for xfs.
> 
> --D
> 
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
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
> Inspired-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Yes, this is exactly how I'd imagine it. Thanks for writing the patch!

I'd just note that this would need rebasing on top of Luis' patches 1 and
2. Also:

> +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> +		switch (who) {
> +		case FREEZE_HOLDER_KERNEL:
> +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> +				/*
> +				 * Kernel freeze already in effect; caller can
> +				 * try again.
> +				 */
> +				deactivate_locked_super(sb);
> +				return -EBUSY;
> +			}
> +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> +				/*
> +				 * Share the freeze state with the userspace
> +				 * freeze already in effect.
> +				 */
> +				sbw->freeze_holders |= who;
> +				deactivate_locked_super(sb);
> +				return 0;
> +			}
> +			break;
> +		case FREEZE_HOLDER_USERSPACE:
> +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> +				/*
> +				 * Userspace freeze already in effect; tell
> +				 * the caller we're busy.
> +				 */
> +				deactivate_locked_super(sb);
> +				return -EBUSY;
> +			}
> +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> +				/*
> +				 * Share the freeze state with the kernel
> +				 * freeze already in effect.
> +				 */
> +				sbw->freeze_holders |= who;
> +				deactivate_locked_super(sb);
> +				return 0;
> +			}
> +			break;
> +		default:
> +			BUG();
> +			deactivate_locked_super(sb);
> +			return -EINVAL;
> +		}
> +	}

Can't this be simplified to:

	BUG_ON(who & ~(FREEZE_HOLDER_USERSPACE | FREEZE_HOLDER_KERNEL));
	BUG_ON(!(!(who & FREEZE_HOLDER_USERSPACE) ^
	       !(who & FREEZE_HOLDER_KERNEL)));
retry:
	if (sb->s_writers.freeze_holders & who)
		return -EBUSY;
	/* Already frozen by someone else? */
	if (sb->s_writers.freeze_holders & ~who) {
		sb->s_writers.freeze_holders |= who;
		return 0;
	}

Now the only remaining issue with the code is that the two different
holders can be attempting to freeze the filesystem at once and in that case
one of them has to wait for the other one instead of returning -EBUSY as
would happen currently. This can happen because we temporarily drop
s_umount in freeze_super() due to lock ordering issues. I think we could
do something like:

	if (!sb_unfrozen(sb)) {
		up_write(&sb->s_umount);
		wait_var_event(&sb->s_writers.frozen,
			       sb_unfrozen(sb) || sb_frozen(sb));
		down_write(&sb->s_umount);
		goto retry;
	}

and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
in freeze_super().

BTW, when reading this code, I've spotted attached cleanup opportunity but
I'll queue that separately so that is JFYI.

> +#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
> +#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */

Why not start from 1U << 0? And bonus points for using BIT() macro :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--wr2u3ku724mk4x5d
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fs-Drop-wait_unfrozen-wait-queue.patch"

From 9fce35f21f9a62470e764463c84373fb013108fd Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 25 May 2023 15:56:19 +0200
Subject: [PATCH] fs: Drop wait_unfrozen wait queue

wait_unfrozen waitqueue is used only in quota code to wait for
filesystem to become unfrozen. In that place we can just use
sb_start_write() - sb_end_write() pair to achieve the same. So just
remove the waitqueue.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota.c   | 5 +++--
 fs/super.c         | 4 ----
 include/linux/fs.h | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..0e41fb84060f 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -895,8 +895,9 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
-		wait_event(sb->s_writers.wait_unfrozen,
-			   sb->s_writers.frozen == SB_UNFROZEN);
+		/* Wait for sb to unfreeze */
+		sb_start_write(sb);
+		sb_end_write(sb);
 		put_super(sb);
 		goto retry;
 	}
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..6283cea67280 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -236,7 +236,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 					&type->s_writers_key[i]))
 			goto fail;
 	}
-	init_waitqueue_head(&s->s_writers.wait_unfrozen);
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
 	if (s->s_user_ns != &init_user_ns)
@@ -1706,7 +1705,6 @@ int freeze_super(struct super_block *sb)
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
-		wake_up(&sb->s_writers.wait_unfrozen);
 		deactivate_locked_super(sb);
 		return ret;
 	}
@@ -1722,7 +1720,6 @@ int freeze_super(struct super_block *sb)
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
-			wake_up(&sb->s_writers.wait_unfrozen);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -1768,7 +1765,6 @@ static int thaw_super_locked(struct super_block *sb)
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
-	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);
 	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..3b65a6194485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1146,7 +1146,6 @@ enum {
 
 struct sb_writers {
 	int				frozen;		/* Is sb frozen? */
-	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
-- 
2.35.3


--wr2u3ku724mk4x5d--
