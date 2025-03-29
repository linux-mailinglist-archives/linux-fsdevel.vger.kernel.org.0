Return-Path: <linux-fsdevel+bounces-45261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2640A75539
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B836417398C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0653C1CAA63;
	Sat, 29 Mar 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYGTSIZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526B1C5F25;
	Sat, 29 Mar 2025 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237828; cv=none; b=CmiMtKZ0RA9ZmearLog5JrD68fm03HajpCBIxXwayQR76vkgXXv8qwaZIi7lSt8wu3SeIecGb+x6lWwWWAyRwEgPJKKDzPZs/DvKZjrUyto9miUGdSggSU6dLjWJj55J0mty3zu1MiDEGXHYp/g2nDQ11L6zxk33hheyXesiBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237828; c=relaxed/simple;
	bh=GFcv+iHs3cxAf0PS51ww4sS11+jxpW/HW9m0JZc6IcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqzAjahG8+eZ1nL7XiQwn3/gn6DNMLvLAHkTFLH8kN3+jvPFAk9dTemJICuA5qbvcW6euZQWsYj++ca0PUIvZaCC/AUX1aI20aR9EgWE5xNqJckJ6akJnFEdMo3MiowiTjKjRjRsi+zKAri5xFZgSkSUlkUZ4alqXBPivxEaByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYGTSIZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2889CC4CEE9;
	Sat, 29 Mar 2025 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237828;
	bh=GFcv+iHs3cxAf0PS51ww4sS11+jxpW/HW9m0JZc6IcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYGTSIZCU9arFXhgfPLFgIXCcXZDwPiA/aKam1zwQnv0gCOcYeQaW8NaFTBoqEfex
	 c1mx6nEvoN5R9IkI+hWv0UosTWYHFzirKgQIAEsGRwaTzSf/Gc5TdkW8LWuZwi0rI2
	 u7KXj6RgruLNGCmL2gCcVCHVf8cpRkv7dQUlxelmjCKPqoy37FnVaJzSwsP2HUhzIe
	 PM+zI81pboY6u1jCDexr8L9FjBxorcgIlbeiKok1TZK7roWxnnaVpanbv02mURgfZy
	 pzu6wfTlghW3g4G50mDD7PP44ZL3ZytQHlmBSPvuFy6ROTpClmbtnrqrmHR8yB7xsD
	 P9L1JWySm5qmA==
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
Subject: [PATCH v2 6/6] super: add filesystem freezing helpers for suspend and hibernate
Date: Sat, 29 Mar 2025 09:42:19 +0100
Message-ID: <20250329-work-freeze-v2-6-a47af37ecc3d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2519; i=brauner@kernel.org; h=from:subject:message-id; bh=GFcv+iHs3cxAf0PS51ww4sS11+jxpW/HW9m0JZc6IcE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31S53cT63z6jXa7OYsFqN6eE9d3fYKg1qUPp+F6vq lqzGXZtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJ12H4w2eW+CeLfVfpu2/G iTwC3PU7vmSqyna1MT9jmbfZTvvONUaG+ZqBLht9jz7RbTGffvfb9dS/R/iDLt9of5fTI2yk9mk OAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Allow the power subsystem to support filesystem freeze for
suspend and hibernate.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 57 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 666a2a16df87..4364b763e91f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1176,6 +1176,61 @@ void emergency_thaw_all(void)
 	}
 }
 
+static inline bool get_active_super(struct super_block *sb)
+{
+	bool active;
+
+	if (super_lock_excl(sb)) {
+		active = atomic_inc_not_zero(&sb->s_active);
+		super_unlock_excl(sb);
+	}
+	return active;
+}
+
+static void filesystems_freeze_callback(struct super_block *sb, void *unused)
+{
+	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
+		return;
+
+	if (!get_active_super(sb))
+		return;
+
+	if (sb->s_op->freeze_super)
+		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+	else
+		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+
+	deactivate_super(sb);
+}
+
+void filesystems_freeze(bool hibernate)
+{
+	__iterate_supers(filesystems_freeze_callback, NULL,
+			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
+}
+
+static void filesystems_thaw_callback(struct super_block *sb, void *unused)
+{
+	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
+		return;
+
+	if (!get_active_super(sb))
+		return;
+
+	if (sb->s_op->thaw_super)
+		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+	else
+		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+
+	deactivate_super(sb);
+}
+
+void filesystems_thaw(bool hibernate)
+{
+	__iterate_supers(filesystems_thaw_callback, NULL,
+			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
+}
+
 static DEFINE_IDA(unnamed_dev_ida);
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c475fa874055..29bd28491eff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3518,6 +3518,8 @@ extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*f)(struct super_block *, void *), void *arg);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
+void filesystems_freeze(bool hibernate);
+void filesystems_thaw(bool hibernate);
 
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);

-- 
2.47.2


