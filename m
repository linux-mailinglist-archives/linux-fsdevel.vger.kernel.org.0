Return-Path: <linux-fsdevel+bounces-45259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3285A75532
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5EB3AFF96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45991C173C;
	Sat, 29 Mar 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOqSSonc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67C149C55;
	Sat, 29 Mar 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237818; cv=none; b=c/R/X4y9L9fdgJXZ5rYY0nrq/QKWzfIfSNhZN845EHIC83hfeU1DF5NjwbPI1tDlaPiHKxSTXmbwYZRGFf+jTQtnb4SWGccRtSWuzZqX4cm176VBRl5lhPwZWDgtsYXd4VvPB4KU0fLyeqNtZosJ6c88V4y+qGbd2Egy4I4bh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237818; c=relaxed/simple;
	bh=kSJquFBWZLjXohp7CdfSUxcMmSKnA8vBlSuTa7rPH5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjm1uhLaGsv0DH+WWZ7xG83+7W0rr0lzk2DjeJCkW5qKteSKIj7XymZqQTUCTIc16j9HS450FUhdYI+J9JfDNaB1b+OkwliRQ/+qZsFRxJmrSacJnueV0PeOFgYyaUMH1RCZzwQ+dMgxThidViUXgduHUMcRWWuIKDyvsaFROj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOqSSonc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964DFC4CEEA;
	Sat, 29 Mar 2025 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237817;
	bh=kSJquFBWZLjXohp7CdfSUxcMmSKnA8vBlSuTa7rPH5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOqSSoncdSQdi2oPHb1SWPcFCUIW5Sgc0ysHjnv8czeAnhAkNARbN8QxZsYEyiyHx
	 3nhqjDve+t519n/W0/xywko11laZDCadp3VhFZa5RxRwpmHgEpyexKAntW+02RcTtU
	 YBXaLp7wTCC4zlfpJ4Gp3iczXRQ7OdmwWfWdHtc2cz2jTFkKRes5kGv2TZk6TTy8CD
	 bzt4ItopjgIHtwXthnIEQYJi5ivlNEA4dNz3aZ6cWZLf9lbHaJTgNTubEfB7qrlsC5
	 SJmIbexdNEhXLnfelZtnCgPtpiUYMjRrN+t72yAt5bVnnxHUMHAfWWPWZ5zfIaZpzN
	 28BHDUn64nz5Q==
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
Subject: [PATCH v2 4/6] super: use a common iterator (Part 1)
Date: Sat, 29 Mar 2025 09:42:17 +0100
Message-ID: <20250329-work-freeze-v2-4-a47af37ecc3d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478; i=brauner@kernel.org; h=from:subject:message-id; bh=kSJquFBWZLjXohp7CdfSUxcMmSKnA8vBlSuTa7rPH5k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31S59sp7/5W/dLY87awO/8du6b3/8t5ZZSI3GmYGX vr4LF56WkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEbr9gZFhS0ufqwN5W99Dy mV0hw+VZz5rkCmXXbTmyTuvAr/9zoiwZ/vBt+/ki4hBn4YVlP5V8Fu9kzpBbyTnjn3Tv0rpotjo 2aQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Use a common iterator for all callbacks.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 67 +++++++++++-------------------------------------------
 include/linux/fs.h |  6 ++++-
 2 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index c67ea3cdda41..0dd208804a74 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -887,37 +887,7 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
-static void __iterate_supers(void (*f)(struct super_block *))
-{
-	struct super_block *sb, *p = NULL;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (super_flags(sb, SB_DYING))
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-
-		f(sb);
-
-		spin_lock(&sb_lock);
-		if (p)
-			__put_super(p);
-		p = sb;
-	}
-	if (p)
-		__put_super(p);
-	spin_unlock(&sb_lock);
-}
-/**
- *	iterate_supers - call function for all active superblocks
- *	@f: function to call
- *	@arg: argument to pass to it
- *
- *	Scans the superblock list and calls given function, passing it
- *	locked superblock and given argument.
- */
-void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
+void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl)
 {
 	struct super_block *sb, *p = NULL;
 
@@ -927,14 +897,13 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 		if (super_flags(sb, SB_DYING))
 			continue;
-
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		locked = super_lock_shared(sb);
+		locked = super_lock(sb, excl);
 		if (locked) {
 			f(sb, arg);
-			super_unlock_shared(sb);
+			super_unlock(sb, excl);
 		}
 
 		spin_lock(&sb_lock);
@@ -1111,11 +1080,9 @@ int reconfigure_super(struct fs_context *fc)
 	return retval;
 }
 
-static void do_emergency_remount_callback(struct super_block *sb)
+static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 {
-	bool locked = super_lock_excl(sb);
-
-	if (locked && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
+	if (sb->s_bdev && !sb_rdonly(sb)) {
 		struct fs_context *fc;
 
 		fc = fs_context_for_reconfigure(sb->s_root,
@@ -1126,13 +1093,11 @@ static void do_emergency_remount_callback(struct super_block *sb)
 			put_fs_context(fc);
 		}
 	}
-	if (locked)
-		super_unlock_excl(sb);
 }
 
 static void do_emergency_remount(struct work_struct *work)
 {
-	__iterate_supers(do_emergency_remount_callback);
+	__iterate_supers(do_emergency_remount_callback, NULL, true);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
@@ -1148,24 +1113,18 @@ void emergency_remount(void)
 	}
 }
 
-static void do_thaw_all_callback(struct super_block *sb)
+static void do_thaw_all_callback(struct super_block *sb, void *unused)
 {
-	bool locked = super_lock_excl(sb);
-
-	if (locked && sb->s_root) {
-		if (IS_ENABLED(CONFIG_BLOCK))
-			while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
-				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
-		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
-		return;
-	}
-	if (locked)
-		super_unlock_excl(sb);
+	if (IS_ENABLED(CONFIG_BLOCK))
+		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
+			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
+	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
+	return;
 }
 
 static void do_thaw_all(struct work_struct *work)
 {
-	__iterate_supers(do_thaw_all_callback);
+	__iterate_supers(do_thaw_all_callback, NULL, true);
 	kfree(work);
 	printk(KERN_WARNING "Emergency Thaw complete\n");
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..0351500b71d2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3515,7 +3515,11 @@ extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl);
+static inline void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
+{
+	__iterate_supers(f, arg, false);
+}
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 

-- 
2.47.2


