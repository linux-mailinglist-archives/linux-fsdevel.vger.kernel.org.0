Return-Path: <linux-fsdevel+bounces-45747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186CA7BAA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D883B4F95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86A1B3950;
	Fri,  4 Apr 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixYM1hnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9B19DF66;
	Fri,  4 Apr 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762280; cv=none; b=SVZgH+T+K2TezqjYITNCC0PwFnwx9g+HhNY2+p5h0ULXcUNwRky4D0Q9PtJJYk8BNcLaqZBTMTYdYwohW0Hzt3vYiqS61nd3ntm/gGk4J3qKrO9AZ8jyTVnbOplGotnRlX8psYB17FsfRcAM0xttfg5EyAWaKY93E2zTc36T0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762280; c=relaxed/simple;
	bh=7XhvsaAR1vcF0yyiP58bhi1Lq1t+C31IiBxcJ1YTFd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebr7kyCrdwnLi6TFf8yLkK6uykVkH7CtpgrILOZt8nRzJfQ2L8T+5J1oVgrgwSkQhPLw9tTK3waN6ps5SF2F4icIFBmgrf1ki3pDKSFj/sJxEL5k9aVaXaXTtAR1K9L51Ij1GXslkT5FBkCgsbezm5ucvfzRSUB3xJC05uzkYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixYM1hnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E6C4CEDD;
	Fri,  4 Apr 2025 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743762280;
	bh=7XhvsaAR1vcF0yyiP58bhi1Lq1t+C31IiBxcJ1YTFd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixYM1hnuNyixIb7Ehti6HV/1A1n4LO9AHCzk4LSVvDq1DfBBZvh36tt7u54aWD1mS
	 UDOkVj1nD1IxTSiHzT/MMjftL48YTbvDM39pHNtEIl0Hu4yRxE42AVtpbX9rNzExSJ
	 8MP1O1VkDSzkL13dsN4bEdJ7kER0vs4/e4t3YNF3yYjXxTkf6704R1s0LRJXVjd5qd
	 ls9QVYB9AJPtveEvQ3JckTQvvdLPgIQkcbXBKOBUbSEFimVhZd84VKr2QkgCNctzgk
	 m1mUN6VMt1UwMHE3rPDj/tp79Q9OsRh+aPSG7OoleTFvqIZfm8hRnMNuvg7xIgK3kb
	 2BVwJX7nJYwQQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH] fs: allow nesting with FREEZE_EXCL
Date: Fri,  4 Apr 2025 12:24:09 +0200
Message-ID: <20250404-work-freeze-v1-1-31f9a26f7bc9@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>
References: <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250404-work-freeze-5eacb515f044
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5320; i=brauner@kernel.org; h=from:subject:message-id; bh=7XhvsaAR1vcF0yyiP58bhi1Lq1t+C31IiBxcJ1YTFd0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/3xzDZb7MRtpzQfyEmY0Cu/ZeM40yU4/OKVrp+XvbN J7+64a5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRLWJkmD7Tq4Wn8LYYI3t8 5NMkCy/7ReKX+5qzlmixO25SzL9exfDfad/X2eGMrlnhsfefKR8OeLT8xNWU2mctH/Zw5059JdP IBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

If hibernation races with filesystem freezing (e.g. DM reconfiguration),
then hibernation need not freeze a filesystem because it's already
frozen but userspace may thaw the filesystem before hibernation actually
happens.

If the race happens the other way around, DM reconfiguration may
unexpectedly fail with EBUSY.

So allow FREEZE_EXCL to nest with other holders. An exclusive freezer
cannot be undone by any of the other concurrent freezers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 71 ++++++++++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |  2 +-
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index b4bdbc509dba..e2fee655fbed 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1979,26 +1979,34 @@ static inline int freeze_dec(struct super_block *sb, enum freeze_holder who)
 	return sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount;
 }
 
-static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
+static inline bool may_freeze(struct super_block *sb, enum freeze_holder who,
+			      const void *freeze_owner)
 {
+	lockdep_assert_held(&sb->s_umount);
+
 	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
 	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
 
 	if (who & FREEZE_EXCL) {
 		if (WARN_ON_ONCE(!(who & FREEZE_HOLDER_KERNEL)))
 			return false;
-
-		if (who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL))
+		if (WARN_ON_ONCE(who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL)))
 			return false;
-
-		return (sb->s_writers.freeze_kcount +
-			sb->s_writers.freeze_ucount) == 0;
+		if (WARN_ON_ONCE(!freeze_owner))
+			return false;
+		/* This freeze already has a specific owner. */
+		if (sb->s_writers.freeze_owner)
+			return false;
+		/*
+		 * This is already frozen multiple times so we're just
+		 * going to take a reference count and mark it as
+		 * belonging to use.
+		 */
+		if (sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount)
+			sb->s_writers.freeze_owner = freeze_owner;
+		return true;
 	}
 
-	/* This filesystem is already exclusively frozen. */
-	if (sb->s_writers.freeze_owner)
-		return false;
-
 	if (who & FREEZE_HOLDER_KERNEL)
 		return (who & FREEZE_MAY_NEST) ||
 		       sb->s_writers.freeze_kcount == 0;
@@ -2011,20 +2019,51 @@ static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
 static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
 				const void *freeze_owner)
 {
+	lockdep_assert_held(&sb->s_umount);
+
 	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
 	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
 
 	if (who & FREEZE_EXCL) {
-		if (WARN_ON_ONCE(sb->s_writers.freeze_owner == NULL))
-			return false;
 		if (WARN_ON_ONCE(!(who & FREEZE_HOLDER_KERNEL)))
 			return false;
-		if (who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL))
+		if (WARN_ON_ONCE(who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL)))
+			return false;
+		if (WARN_ON_ONCE(!freeze_owner))
+			return false;
+		if (WARN_ON_ONCE(sb->s_writers.freeze_kcount == 0))
 			return false;
-		return sb->s_writers.freeze_owner == freeze_owner;
+		/* This isn't exclusively frozen. */
+		if (!sb->s_writers.freeze_owner)
+			return false;
+		/* This isn't exclusively frozen by us. */
+		if (sb->s_writers.freeze_owner != freeze_owner)
+			return false;
+		/*
+		 * This is still frozen multiple times so we're just
+		 * going to drop our reference count and undo our
+		 * exclusive freeze.
+		 */
+		if ((sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount) > 1)
+			sb->s_writers.freeze_owner = NULL;
+		return true;
+	}
+
+	if (who & FREEZE_HOLDER_KERNEL) {
+		/*
+		 * Someone's trying to steal the reference belonging to
+		 * @sb->s_writers.freeze_owner.
+		 */
+		if (sb->s_writers.freeze_kcount == 1 &&
+		    sb->s_writers.freeze_owner)
+			return false;
+		return sb->s_writers.freeze_kcount > 0;
 	}
 
-	return sb->s_writers.freeze_owner == NULL;
+	if (who & FREEZE_HOLDER_USERSPACE)
+		return sb->s_writers.freeze_ucount > 0;
+
+	return false;
 }
 
 /**
@@ -2095,7 +2134,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 
 retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
-		if (may_freeze(sb, who))
+		if (may_freeze(sb, who, freeze_owner))
 			ret = !!WARN_ON_ONCE(freeze_inc(sb, who) == 1);
 		else
 			ret = -EBUSY;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1edcba3cd68e..7a3f821d2723 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2270,7 +2270,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
  * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
  * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
  * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
- * @FREEZE_EXCL: whether actual freezing must be done by the caller
+ * @FREEZE_EXCL: a freeze that can only be undone by the owner
  *
  * Indicate who the owner of the freeze or thaw request is and whether
  * the freeze needs to be exclusive or can nest.

---
base-commit: a83fe97e0d53f7d2b0fc62fd9a322a963cb30306
change-id: 20250404-work-freeze-5eacb515f044


