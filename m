Return-Path: <linux-fsdevel+bounces-45260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E09A75535
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607427A5FEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73AF1AA1C8;
	Sat, 29 Mar 2025 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKSExfwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EB149C55;
	Sat, 29 Mar 2025 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237825; cv=none; b=Mp+Ah3H8ojDun/J7dCxbYo2EajH4+oJYM9gdp3Ymr2RFtRy0u6bSnN/cM2AaAj9MuL9zpPyAiiFJtmboOL2pqz4Q3uaHtYBDC33ZqiJS8bZRNGKSHdrjnuYh0wh8nqjig0y5idVfwmhj6IumEIesWW6mp8YIZs+ZAcTVEq9A7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237825; c=relaxed/simple;
	bh=72IW7BF44UfUCx/jmJIVhavHPgdnbNCwCPoZ3/+N4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EK42E5/i36eayaAyv8FPx/FGPTvUFCeoT+3pF1W6CQRIRBE0CVcJFsFq++e5/95454IfslF+mSiQp42mspZ9P/Hz/8N48T1g7ZQTG8rCWxOqnHAePGnbYhvnGMrA8do/WoJk7hpKl9TxKvaFxUrMHs2CztwCXk2W014Zjm3X9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKSExfwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B1EC4CEE2;
	Sat, 29 Mar 2025 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237824;
	bh=72IW7BF44UfUCx/jmJIVhavHPgdnbNCwCPoZ3/+N4Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKSExfwm+GuPiZU5j3tsVy+adDftwiq6kY/YfH1rcyPEwzGvE9AgPzYQOoRXy5pU7
	 RFwZRmv5zl1uOH0k/CAoaRP2Ca90pEXbkRSHsHDt8O7Y0tavX4fPWdJeURx4wHS9WX
	 h8TV65+lfCstkGBhCsoVzAkCZnvhoaUaT2UH0KPlprIvIGqP1jY7KIw2H+zCrz9jRF
	 9A4/lB9qQ2fkP/fPmkUhjoT+VHLgNIjb5KnEoFZp63TiWKnBtzd961FNX4WPkaLwlG
	 srsswoh3y5xUcf+GyMyNTt6morxPqYEb6IX8Dq7ZWROhMDw6N5UCF6G1mXpEJFXzoq
	 Rc6kAvgn9jVKQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v2 5/6] super: use common iterator (Part 2)
Date: Sat, 29 Mar 2025 09:42:18 +0100
Message-ID: <20250329-work-freeze-v2-5-a47af37ecc3d@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; i=brauner@kernel.org; h=from:subject:message-id; bh=72IW7BF44UfUCx/jmJIVhavHPgdnbNCwCPoZ3/+N4Z0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31S572aA/JmD9gvK7BxlJY6/yvIoePCizPF/UOkJj oD3vjGbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyNZSRoWVpwm/hJ79OTtRe 4Pfk1VPGl4e/Tol7Z8+4t+NMTtr8XB1GhrmLLf7uzsrStnvH923hO5aSHqnpGu8iXE3m+iXrz+1 TYAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Use a common iterator for all callbacks. We could go for something even
more elaborate (advance step-by-step similar to iov_iter) but I really
don't think this is warranted.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 49 ++++++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  6 +-----
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 0dd208804a74..666a2a16df87 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -887,21 +887,47 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
-void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl)
+enum super_iter_flags_t {
+	SUPER_ITER_EXCL		= (1U << 0),
+	SUPER_ITER_UNLOCKED	= (1U << 1),
+	SUPER_ITER_REVERSE	= (1U << 2),
+};
+
+static inline struct super_block *first_super(enum super_iter_flags_t flags)
+{
+	if (flags & SUPER_ITER_REVERSE)
+		return list_last_entry(&super_blocks, struct super_block, s_list);
+	return list_first_entry(&super_blocks, struct super_block, s_list);
+}
+
+static inline struct super_block *next_super(struct super_block *sb,
+					     enum super_iter_flags_t flags)
+{
+	if (flags & SUPER_ITER_REVERSE)
+		return list_prev_entry(sb, s_list);
+	return list_next_entry(sb, s_list);
+}
+
+#define invalid_super list_entry_is_head
+
+static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
+			     enum super_iter_flags_t flags)
 {
 	struct super_block *sb, *p = NULL;
+	bool excl = flags & SUPER_ITER_EXCL;
 
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		bool locked;
+	guard(spinlock)(&sb_lock);
 
+	for (sb = first_super(flags); !invalid_super(sb, &super_blocks, s_list);
+	     sb = next_super(sb, flags)) {
 		if (super_flags(sb, SB_DYING))
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		locked = super_lock(sb, excl);
-		if (locked) {
+		if (flags & SUPER_ITER_UNLOCKED) {
+			f(sb, arg);
+		} else if (super_lock(sb, excl)) {
 			f(sb, arg);
 			super_unlock(sb, excl);
 		}
@@ -913,7 +939,11 @@ void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool e
 	}
 	if (p)
 		__put_super(p);
-	spin_unlock(&sb_lock);
+}
+
+void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
+{
+	__iterate_supers(f, arg, 0);
 }
 
 /**
@@ -1097,7 +1127,8 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 
 static void do_emergency_remount(struct work_struct *work)
 {
-	__iterate_supers(do_emergency_remount_callback, NULL, true);
+	__iterate_supers(do_emergency_remount_callback, NULL,
+			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
@@ -1124,7 +1155,7 @@ static void do_thaw_all_callback(struct super_block *sb, void *unused)
 
 static void do_thaw_all(struct work_struct *work)
 {
-	__iterate_supers(do_thaw_all_callback, NULL, true);
+	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_EXCL);
 	kfree(work);
 	printk(KERN_WARNING "Emergency Thaw complete\n");
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0351500b71d2..c475fa874055 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3515,11 +3515,7 @@ extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl);
-static inline void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
-{
-	__iterate_supers(f, arg, false);
-}
+extern void iterate_supers(void (*f)(struct super_block *, void *), void *arg);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 

-- 
2.47.2


