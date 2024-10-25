Return-Path: <linux-fsdevel+bounces-32844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B99AF857
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A44E1F22545
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625618CBF6;
	Fri, 25 Oct 2024 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba9r2xWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF318C913;
	Fri, 25 Oct 2024 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827975; cv=none; b=tazsiGEtvQjwLu67uWABsPW7z1RPS8L8W2Kr12zHu5GO3mbVzOoV1XJl693NckxlNWoJs1kP0+0X+kTpxzBfsGLvuGXKIi026CMgrK4Z6OAPbzzv5YZNv3RZ5sgIfkHjXQD0u+h/RmPWwJyDL/iHBPb4e/lvVrYt74VMKiaIUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827975; c=relaxed/simple;
	bh=xVExj8sHZH5uULT4cvGiGnRyhNwkdZz65CKNZZT4fx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nndFFY0FUiQFXU8IzHUIgg6LBXbGc907KqVZUyDtLkIq4dSE66HOoVHOxHfPHDiJ7bpBRfLZLvuGRLIaz1OCCnBLUtOnoOvkyBrHOIwsFvIjqqwPNhkvbahB7hqgTHjpxMFmhWy4PyPjpPTcNaZSi5qTJ8Zbb3RwR8nk4OsSFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba9r2xWb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so1185841a91.0;
        Thu, 24 Oct 2024 20:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827971; x=1730432771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GQ8gMBVajrbBrY4WQuOAAu3ETMW067CiWzIB7SBFck=;
        b=ba9r2xWb7Yk2aQ4dm72jSFKBQUhbDht7Ow5N0ye855FQcWPn5uBF1mI0rGh9PqgQbs
         nqC764LVhGQdUDCNVLJFb0ym2ZEqTLJGOVSsn9KYXO9zZKzRKtmLGTOZJEGo/N22AuOH
         pjHVYZKHYk5eTKYc/dRIdq9lk9hHyxnSsDI/F2SMv5Y4VVypLlw2JAqFEGKcwLQwrcRr
         mQ1+oq6OoW87INKpUI1AYe5ZBQMc+qV8iS9T1N1DGDWaaJWU2lZQDMti5ssfs3pwA6nw
         5ZePqNAy3YrT89dA/PiWfMojuvIxRQqOPMUd45P/6w6WQCunpXQi943cr7r1a0gBIjco
         8FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827971; x=1730432771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GQ8gMBVajrbBrY4WQuOAAu3ETMW067CiWzIB7SBFck=;
        b=uXIL1dtm831c1o0oCC7KnGZIFkF4MN6nJKPqVY45PASfw0caoTDmtLIEIyvTko0HxV
         Gg1fbhBJfjyx2bHQ6FO6TqxGkmnDEEyar0QG+ju0Y47I2XeG3nhxy6B/PVlFXjy1o4b/
         yqYvQwXpxNCYtQoonCkaJ0c5vXn9TsVFOf9cemPWU2flPVDyIyeg3TbTdlMyjU5/3zQB
         uRDxbL8ipyiPruniKJRRoIMi0dMdJ6KI0a5o4aKLfiXEmji8yvMhtAt9w8+omOzh1yGk
         5YDl6rl5DU2b04BQNCcc/R9KRZq2KU0CxhLI2XF80iYysH6X/L5nOzacZVgFNiXiHKY6
         V/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBCYRHtEjpOXqfFKZw1+G8cv7FSYs/wainxbVewdcCILCZEpje+6JwRIgz77AVOKvgcEI4oAMWJYVy@vger.kernel.org, AJvYcCUu1AO/ejpFyjeHTXWwqRQC7kG4/A2vM2Sq1mjHXqKbVVQsx69LqOH59jVbUtzKhwIUGZXAtJwKlrZAidaA@vger.kernel.org, AJvYcCV1v7R7MTBfHWsrsGv/OoMgpkdNmLNYRVZxamp4UO2bbMNYgInkIs6PxdVjjZ13yUPSyRYGGfo0xrtFR838@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/75UDvGEevvRZ0Gghkaty6t4adwIAiNfu+K2Lf6K43bBVCZ/
	+LU810mB8X8nbv0LX1touyHQsaHoUG60R4Lj3G7n8x+Q3amGp9BIOMqaxA==
X-Google-Smtp-Source: AGHT+IGbumeN2+sOtoVqOaL0IlcYe6rLvQcQmR2eIUejioxGB/ADbwp3sejP1Cn23n+oTyZ4VY+6IA==
X-Received: by 2002:a17:90a:c405:b0:2d8:e7db:9996 with SMTP id 98e67ed59e1d1-2e76b5e6d17mr9204923a91.13.1729827971122;
        Thu, 24 Oct 2024 20:46:11 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 1/6] ext4: Add statx support for atomic writes
Date: Fri, 25 Oct 2024 09:15:50 +0530
Message-ID: <e6af669b237690491ecff0717039e28e949208c8.1729825985.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729825985.git.ritesh.list@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds base support for atomic writes via statx getattr.
On bs < ps systems, we can create FS with say bs of 16k. That means
both atomic write min and max unit can be set to 16k for supporting
atomic writes.

Later patches adds support for bigalloc as well so that ext4 can also
support doing atomic writes for bs = ps systems.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  |  7 ++++++-
 fs/ext4/inode.c | 14 ++++++++++++++
 fs/ext4/super.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..a41e56c2c628 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1729,6 +1729,10 @@ struct ext4_sb_info {
 	 */
 	struct work_struct s_sb_upd_work;
 
+	/* Atomic write unit values */
+	unsigned int fs_awu_min;
+	unsigned int fs_awu_max;
+
 	/* Ext4 fast commit sub transaction ID */
 	atomic_t s_fc_subtid;
 
@@ -1820,7 +1824,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
+	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
+	EXT4_MF_ATOMIC_WRITE	/* Supports atomic write */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..897c028d5bc9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
+	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
+		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		unsigned int awu_min, awu_max;
+
+		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_ATOMIC_WRITE)) {
+			awu_min = sbi->fs_awu_min;
+			awu_max = sbi->fs_awu_max;
+		} else {
+			awu_min = awu_max = 0;
+		}
+
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..f5c075aff060 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4425,6 +4425,37 @@ static int ext4_handle_clustersize(struct super_block *sb)
 	return 0;
 }
 
+/*
+ * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
+ * @sb: super block
+ * TODO: Later add support for bigalloc
+ */
+static void ext4_atomic_write_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct block_device *bdev = sb->s_bdev;
+
+	if (!bdev_can_atomic_write(bdev))
+		return;
+
+	if (!ext4_has_feature_extents(sb))
+		return;
+
+	sbi->fs_awu_min = max(sb->s_blocksize,
+			      bdev_atomic_write_unit_min_bytes(bdev));
+	sbi->fs_awu_max = min(sb->s_blocksize,
+			      bdev_atomic_write_unit_max_bytes(bdev));
+	if (sbi->fs_awu_min && sbi->fs_awu_max &&
+			sbi->fs_awu_min <= sbi->fs_awu_max) {
+		ext4_set_mount_flag(sb, EXT4_MF_ATOMIC_WRITE);
+		ext4_msg(sb, KERN_NOTICE, "Supports atomic writes awu_min: %u, awu_max: %u",
+			 sbi->fs_awu_min, sbi->fs_awu_max);
+	} else {
+		sbi->fs_awu_min = 0;
+		sbi->fs_awu_max = 0;
+	}
+}
+
 static void ext4_fast_commit_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -5336,6 +5367,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	spin_lock_init(&sbi->s_bdev_wb_lock);
 
+	ext4_atomic_write_init(sb);
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
-- 
2.46.0


