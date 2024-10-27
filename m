Return-Path: <linux-fsdevel+bounces-33026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE499B1FA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385BE2816BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E517E003;
	Sun, 27 Oct 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VflNNE5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB017C9B8;
	Sun, 27 Oct 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053071; cv=none; b=r5e+7xHKSSxDVzoL8po0BQElpvfn/pY2v0jg9fR/IQuOccd9q1Oi6fdN4J038DObQZ1a9hRN58vm82Hp8PK/UWORV4R87nKfrlXYElyxb3PGLVqJOGPbbtGks+3JnHqx+GOG36Wxy0lPW35rRDOQF7KtrwqCKv1eIhBq+7FdQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053071; c=relaxed/simple;
	bh=E4kn5FAkWbJ6k/m72AWp2fMttsJ6jfRJvG48Jo6+ghw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdDRtQRYqHzvBeBDTbvrWrflyQPo4cgdT9z2ZALZ5VIxaeG/zNcc5Rm68RmhkhQxEfssl+MLtJnxRzK+MVsFCcn7xrecB3hYYfNKWD7JaXrm15x8otp7cLw0x23mw5j5l/S4ykDYorPHesU34/bcw37D1pHqjWLdnByzO462+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VflNNE5p; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso2316457a12.1;
        Sun, 27 Oct 2024 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730053068; x=1730657868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpHmwu2LSyHM8Uyjkn2fhaNMGmMYwEF858nXYCRWd/w=;
        b=VflNNE5pwCrMpHKJQQ88pxVMcU9KuH635wuRyQUZ1aEVNWhba+ofNXG+DarW5LYTcV
         oU+2gOT9q26pUOuVRBbFrZuVEXLC9lIJxLbtpmub0Ke7Na3Le/GHn7UNJEy1zrNA8SqR
         zekox7oOOdiPj2A0u2dwJPcAIx7TBvMFPb1G2uuMA5gqrNLmobSKBYDnAV4l4CemSDhq
         r40IeFuNqVAMg6sW7EaeUHYkkH6DI0/RuOaA/GGgIbptRexjXT2e28g+WUAxcQg0JE84
         /0x+esy8vMM2vNYRLQDkP3iimBvQrROYmMxI4CUMozHY2fTY/5YIOLQc32dspeC5b7uR
         MV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053068; x=1730657868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpHmwu2LSyHM8Uyjkn2fhaNMGmMYwEF858nXYCRWd/w=;
        b=IPmYsJzIUizJAIAIrcwJC9nfi8HLXwOmTSe4QYO77yILo8EnZ9OvbIV7i9GHXUbeGq
         2vsm5+uh3AtfhSb7Bc7lrOK3w+zGC1+SALmOVHKjywa9vDKvi7VDtOqIWzneNdjgf582
         gU/oVLZVkj987NIUBXwBf72m6/NYY96JV55QfcdRdmEcM8PnIm4IpS6xN6/5sY6FaAQV
         7dfPvhTuGX2J6dypvbr65gRT1lws+pyFwrsc3QCS1t+xFq/ihRtPQoGKk+8euJZ8cwmX
         N5prSlreKkZw/BUyip6vIhB+Dla6xTT1OA2S01leNz56Mn0HUd02EEz7Twr+64dDkPOm
         saeg==
X-Forwarded-Encrypted: i=1; AJvYcCUaf9uFAGoI1h4XcbzSuvH3Gx0YiVog+KVZBmJ67kb+8QVvz9/MDaPOMkbdN3nptlfID/ygRKPZzAKg5H2X@vger.kernel.org, AJvYcCX2ZJ2xc20sKZliNmsNa6M9FvlpX0YIW+AQYMhsC2MlchHIBWtbWdLxTxG8PR8hrGA8exbB1rINOe7PYR2y@vger.kernel.org, AJvYcCXWkN/yVfyo7FIMpaK2fy/eLZbayw82I0qZLBPgWBrb0RMN1hYi60lesgLdQTCVsJNT1o9vAaxMTTuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YynD3LXvP0y549dKlW8luObIO+OKVAxnCZ6AYNWPRvEP9FLXod6
	Rqtd8fdu5397Q2hDGzoe4FcBrlHDBdkk1GS3TH+nvAsCcVy7MWOsnujzUg==
X-Google-Smtp-Source: AGHT+IGvGfEMuByImWk7dMpw3CXY3ZTVR8Qehtc38AAIoQWocV5rGOtQODxOlH0cp6oPATUnfEa+ZQ==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:476f:2d10 with SMTP id adf61e73a8af0-1d9a853b55amr8075328637.49.1730053068069;
        Sun, 27 Oct 2024 11:17:48 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867d0c1sm4306492a12.33.2024.10.27.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 11:17:47 -0700 (PDT)
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
Subject: [PATCH v2 1/4] ext4: Add statx support for atomic writes
Date: Sun, 27 Oct 2024 23:47:25 +0530
Message-ID: <b61c4a50b4e3b97c4261eb45ea3a24057f54d61a.1729944406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729944406.git.ritesh.list@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com>
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

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/inode.c | 14 ++++++++++++++
 fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..6ee49aaacd2b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1729,6 +1729,10 @@ struct ext4_sb_info {
 	 */
 	struct work_struct s_sb_upd_work;
 
+	/* Atomic write unit values in bytes */
+	unsigned int s_awu_min;
+	unsigned int s_awu_max;
+
 	/* Ext4 fast commit sub transaction ID */
 	atomic_t s_fc_subtid;
 
@@ -3855,6 +3859,11 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
+static inline bool ext4_can_atomic_write(struct super_block *sb)
+{
+	return EXT4_SB(sb)->s_awu_min > 0;
+}
+
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..fcdee27b9aa2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
+	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
+		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		unsigned int awu_min, awu_max;
+
+		if (ext4_can_atomic_write(inode->i_sb)) {
+			awu_min = sbi->s_awu_min;
+			awu_max = sbi->s_awu_max;
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
index 16a4ce704460..d6e3201a48be 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
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
+	sbi->s_awu_min = max(sb->s_blocksize,
+			      bdev_atomic_write_unit_min_bytes(bdev));
+	sbi->s_awu_max = min(sb->s_blocksize,
+			      bdev_atomic_write_unit_max_bytes(bdev));
+	if (sbi->s_awu_min && sbi->s_awu_max &&
+	    sbi->s_awu_min <= sbi->s_awu_max) {
+		ext4_msg(sb, KERN_NOTICE, "Supports atomic writes awu_min: %u, awu_max: %u",
+			 sbi->s_awu_min, sbi->s_awu_max);
+	} else {
+		sbi->s_awu_min = 0;
+		sbi->s_awu_max = 0;
+	}
+}
+
 static void ext4_fast_commit_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	spin_lock_init(&sbi->s_bdev_wb_lock);
 
+	ext4_atomic_write_init(sb);
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
-- 
2.46.0


