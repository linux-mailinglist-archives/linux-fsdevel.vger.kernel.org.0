Return-Path: <linux-fsdevel+bounces-3923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD057F9EF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 12:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD781C20DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61621BDD3;
	Mon, 27 Nov 2023 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHB4ASHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE01A5B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA288C433C7;
	Mon, 27 Nov 2023 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701085903;
	bh=r9TAx3QidPhot0+bNiYSU7whM2Nz8LHDDcUX+vZPDDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IHB4ASHcz7Rg695bbhwqV5DnIIM92RGcy9k+3/fOlQQcys9gnamgwjgq6t5bSrK5D
	 qQPXVF9mc1NG6P8tUzKSGCiWTCjhlNefNUxa3sO4Z0MnN6hA7s8vzZOYF/BDzqAHik
	 PenvhrPnwLlOODvYO9f9YMxwCuhfIORkB+9UNFvDUGIRfgTVaPLaJobwnBAO/oPB3B
	 ACx/V9Q6MAl49A9hSrM1We2LnTvdKIRW3LgXzh5B4yZYsb+Gaoj19euOTAMyoLn+B1
	 EoMTf3sa8owFS26ZONpYsOyZJYWvwVZWhiIzDxl/qUCn7jD0zAudJ5NJvyUxh8jPQY
	 tFOz6Uau0RKvg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 27 Nov 2023 12:51:30 +0100
Subject: [PATCH 1/2] super: massage wait event mechanism
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
In-Reply-To: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r9TAx3QidPhot0+bNiYSU7whM2Nz8LHDDcUX+vZPDDQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSmNJ3xn8HXeclS7ppTw6FyldMuTWte8JSbuK5Wvz6Ne
 2P3JuX9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpamBkeLdLK50jwuKD6cz5
 xnunCG1+53arxfvRP/3JEpMPrRBbasLwzyDsy94f4r/et3ifeZLLGvDrjpD3tN1L3Bb/enE2OIf
 XmwkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 51 ++++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index aa4e5c11ee32..f3227b22879d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -81,16 +81,13 @@ static inline void super_unlock_shared(struct super_block *sb)
 	super_unlock(sb, false);
 }
 
-static inline bool wait_born(struct super_block *sb)
+static bool super_load_flags(const struct super_block *sb, unsigned int flags)
 {
-	unsigned int flags;
-
 	/*
 	 * Pairs with smp_store_release() in super_wake() and ensures
-	 * that we see SB_BORN or SB_DYING after we're woken.
+	 * that we see @flags after we're woken.
 	 */
-	flags = smp_load_acquire(&sb->s_flags);
-	return flags & (SB_BORN | SB_DYING);
+	return smp_load_acquire(&sb->s_flags) & flags;
 }
 
 /**
@@ -111,10 +108,15 @@ static inline bool wait_born(struct super_block *sb)
  */
 static __must_check bool super_lock(struct super_block *sb, bool excl)
 {
-
 	lockdep_assert_not_held(&sb->s_umount);
 
-relock:
+	/* wait until the superblock is ready or dying */
+	wait_var_event(&sb->s_flags, super_load_flags(sb, SB_BORN | SB_DYING));
+
+	/* Don't pointlessly acquire s_umount. */
+	if (super_load_flags(sb, SB_DYING))
+		return false;
+
 	__super_lock(sb, excl);
 
 	/*
@@ -127,20 +129,8 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 		return false;
 	}
 
-	/* Has called ->get_tree() successfully. */
-	if (sb->s_flags & SB_BORN)
-		return true;
-
-	super_unlock(sb, excl);
-
-	/* wait until the superblock is ready or dying */
-	wait_var_event(&sb->s_flags, wait_born(sb));
-
-	/*
-	 * Neither SB_BORN nor SB_DYING are ever unset so we never loop.
-	 * Just reacquire @sb->s_umount for the caller.
-	 */
-	goto relock;
+	WARN_ON_ONCE(!(sb->s_flags & SB_BORN));
+	return true;
 }
 
 /* wait and try to acquire read-side of @sb->s_umount */
@@ -523,18 +513,6 @@ void deactivate_super(struct super_block *s)
 
 EXPORT_SYMBOL(deactivate_super);
 
-static inline bool wait_dead(struct super_block *sb)
-{
-	unsigned int flags;
-
-	/*
-	 * Pairs with memory barrier in super_wake() and ensures
-	 * that we see SB_DEAD after we're woken.
-	 */
-	flags = smp_load_acquire(&sb->s_flags);
-	return flags & SB_DEAD;
-}
-
 /**
  * grab_super - acquire an active reference to a superblock
  * @sb: superblock to acquire
@@ -561,7 +539,7 @@ static bool grab_super(struct super_block *sb)
 		}
 		super_unlock_excl(sb);
 	}
-	wait_var_event(&sb->s_flags, wait_dead(sb));
+	wait_var_event(&sb->s_flags, super_load_flags(sb, SB_DEAD));
 	put_super(sb);
 	return false;
 }
@@ -908,8 +886,7 @@ static void __iterate_supers(void (*f)(struct super_block *))
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		/* Pairs with memory marrier in super_wake(). */
-		if (smp_load_acquire(&sb->s_flags) & SB_DYING)
+		if (super_load_flags(sb, SB_DYING))
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);

-- 
2.42.0


