Return-Path: <linux-fsdevel+bounces-45228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D863A74E67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0AF7A3830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB771DEFE6;
	Fri, 28 Mar 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnQiU3D1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9F1DA0E0;
	Fri, 28 Mar 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178593; cv=none; b=YzltDuc9FHcKt8UCtVTZtecxCMJ0BBY9yK/yLgYW2KHhdOElUzPrm1s7sRjjNm9jOzZVzX6ELUnfIFFaB/8VYaXOXoS11kch5t8tj6j1/5oZOKanXo+SjXC5MdLm9mIVK79TrZIdllkzMvMJ8HIk1vNmBUoytFDSIM2N9NZSjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178593; c=relaxed/simple;
	bh=lt6u0j7G8M4UVt/q9RdtvvmlEwoeC1nsKag6HYnxJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgsZrJxRDckP+9Y0iLXUvpBqScR+G1n6IX2GTUGIeG91s/q+oXH9w5NfQBDVnZJFtmePJ+lk1JjLcP5UnLb/d5zWjIX0a7XfGqain3D06ZiuoH/N30uSAIsusQxKMvqlZ+8GC75NAymdv+47Z8yNcN+AX0Y3ytjQdcYmscKJVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnQiU3D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF0C4CEE9;
	Fri, 28 Mar 2025 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178593;
	bh=lt6u0j7G8M4UVt/q9RdtvvmlEwoeC1nsKag6HYnxJkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnQiU3D1umTaR/AAcrsZckyuXz/ZLIdk0NEsccP2UgAsaV9Kgl2f4oYsIBSje7waC
	 6uUDTdnftl0tNa4BlJu7qWhTVdusA93CNa6Yh5EekUDHkgl3htqMoMqKJBemrxGSTf
	 /19CqRGmrf16ssQYXAWrZ+lKZEFrvLvNdNF11J13MYQOGO16f8FHigZC0QM1yvV97p
	 JUWeyibTdPnluBfPIrgav1merQK1oS6kx3icGeDbDSQQ+7Kq5ntQsztzlu/lgMi9ic
	 FtDPlkjTYwRFYpctBhT/7enrGsloZ5pYOR3znq5IM5tJTqmNXJ2SVwhCgEXTFBhaV7
	 utTqgN144vRlw==
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
Subject: [PATCH 5/6] super: use common iterator (Part 2)
Date: Fri, 28 Mar 2025 17:15:57 +0100
Message-ID: <20250328-work-freeze-v1-5-a2c3a6b0e7a6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4796; i=brauner@kernel.org; h=from:subject:message-id; bh=lt6u0j7G8M4UVt/q9RdtvvmlEwoeC1nsKag6HYnxJkE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/O+18+tS7+hNWlydoXr96tpujxqRXytPGve9aBU/Nq aK2P4YpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5O5WRYcbt6OJUawk7EfGr p7pTE+cuSbwWVjVXbefMrlXM825dnMzw3+GgePTH/ueeNjWd98IzbvKb3Zi0I50hLsZCUTPyduJ rVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Use a common iterator for all callbacks. We could go for something even
more elaborate (advance step-by-step similar to iov_iter) but I really
don't think this is warranted.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 76 +++++++++++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  6 +----
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 0dd208804a74..58c95210e66c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -887,24 +887,71 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
-void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl)
+enum super_iter_flags_t {
+	SUPER_ITER_EXCL		= (1U << 0),
+	SUPER_ITER_GRAB		= (1U << 1) | SUPER_ITER_EXCL,
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
+static inline void super_cb_locked(struct super_block *sb,
+				   void (*f)(struct super_block *, void *),
+				   void *arg, bool excl)
+{
+        if (super_lock(sb, excl)) {
+                f(sb, arg);
+                super_unlock(sb, excl);
+        }
+}
+
+static inline void super_cb_grabbed(struct super_block *sb,
+				    void (*f)(struct super_block *, void *),
+				    void *arg)
+{
+	if (super_lock_excl(sb)) {
+		bool active = atomic_inc_not_zero(&sb->s_active);
+		super_unlock_excl(sb);
+		if (active)
+			f(sb, arg);
+		deactivate_super(sb);
+	}
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
-			f(sb, arg);
-			super_unlock(sb, excl);
-		}
+                if (flags & SUPER_ITER_GRAB)
+                        super_cb_grabbed(sb, f, arg);
+                else
+                        super_cb_locked(sb, f, arg, excl);
 
 		spin_lock(&sb_lock);
 		if (p)
@@ -913,7 +960,11 @@ void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool e
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
@@ -1097,7 +1148,8 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 
 static void do_emergency_remount(struct work_struct *work)
 {
-	__iterate_supers(do_emergency_remount_callback, NULL, true);
+	__iterate_supers(do_emergency_remount_callback, NULL,
+			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
@@ -1124,7 +1176,7 @@ static void do_thaw_all_callback(struct super_block *sb, void *unused)
 
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


