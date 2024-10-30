Return-Path: <linux-fsdevel+bounces-33254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C29B6899
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642D0287424
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB3214424;
	Wed, 30 Oct 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDdBLmrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32A2141BD;
	Wed, 30 Oct 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303890; cv=none; b=awk828LYXl9g+3WK8oYjh1R9Ceq1JNQS17vwq7b2MbL+ySa+9XlEC3jWwOMTrEZ6z11Qr+0NNqWNw22A9CXnI95750m0fFRTQPv9IWZUYnuDWo8rbBB3Vki3prG7PWWULck8hScgN6awxBmgM+VUy6qIIgZtqcc0DOBWxs+QA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303890; c=relaxed/simple;
	bh=6MLbOFxGNNLBsEeUlGAXzKJfREo9mmcLXriQUfx9u6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt9pbAhM1prefNqe6JrG4QGEsZMkfK/oZr/kiQRIANKp7sb8LICtNt4o82PUqXH+zuEZ0qeNlMMWLfWkNsI0Og5yzbMJwz7bhCR6RPmtwVQgN1QopnbM4JHEmDnGxjGzxKGSYgSD7D780WYJ5kHFF4FTbVwppfvAaZZMGuYyaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDdBLmrj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720b173a9ebso519917b3a.0;
        Wed, 30 Oct 2024 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303887; x=1730908687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ul6bf5oFgoo++/QZF7+fo4tu6EaEqfB4zMIyb1p9Fg=;
        b=aDdBLmrjRAV1VJc44Qgwj1+HBGksfmTAUBgqqlQRB7QTMB91wXcVASy83Gfv/hONLa
         i6bcjwK2VCYyBE98lXWcMAgypbhY+ykSBbpbMfulmjXHiGwQDStpfeeSmFRVzItgJjAb
         SKZY3QJdcNGeM4jQ2c7sP+JZlDwvlzC6cTHOlrvgAa3WbGlvf5QXkuFtI72eFKXtr1Tc
         xhDuJG9iIKvTJeK0/SuHAMjvWvABOKQi/C2xSzHQvYViF63+WWKCyV+ZNnxA/6NFLsck
         LExxLvYGwgjdqx+putqO8K0Kxj2sHqi+kOZL36xF6LSvvoM8i3qPS9RwomI/jIPj1DUa
         iULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303887; x=1730908687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ul6bf5oFgoo++/QZF7+fo4tu6EaEqfB4zMIyb1p9Fg=;
        b=DC0hFLLJkLh3XlKSKunwyGoN/nZThVkW7B+ZNFv1ung3nvypPRufUx3D03edrwe2mS
         aj4hXs6GZYwOglnIKtXgUw70Z9KftKp9Lam1DLgBDhIT1kZ59EoAjzZHJilkyiOWwEME
         lmvgFmQEJwRQjeekTHgduIIho7+fNAUxT0HPJHCnwYW8eB9+VK6DF6iXrld8oQBfisnO
         3SqwYWcVy4Lz+uW0xdgNGWF1Gnlr3O4koKlxTGiiu5q1d6ZZXs8pG/By87AQ78Bz85nY
         MMpKc82yvHdaBZpHdozwW7oRyfoZfU7orle13fbBtSboA+a+1PQfmD6ojFYFhG9lQWmt
         nVxg==
X-Forwarded-Encrypted: i=1; AJvYcCUbXvK7dWL0YW9EmNEfNtBpEqwKC7Fy/rP4V/2mgFgLtpnjHZZsVCpjw2ahGSwlnWchYg1PzdK9NOZE@vger.kernel.org, AJvYcCUwVv9U2K45eZ6NcKjloWzULStmBUNGmlK9qmaQdx4egV1QVDX8FwMhnAnqmj5P0g996D2yoeWsg9BJ6CQ0@vger.kernel.org, AJvYcCW+z9L+BF5ASU31PeKzgKvOmR0kJko+prV7egPPFUydifvEYdq+z9p7fzVwrQzdYdGt4ydRg1UpQubTON2S@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxns4a9G59e5OsTYLbvvui8HV+Fp+UIR5gyz7wr6R2v0KJhCB
	Jc26f37HvEX78wsLE3Ewd4MZaOf1euce/qksE+0Gy6os9X2+Tt+YadM6rQ==
X-Google-Smtp-Source: AGHT+IGKGZlS/e2tooSc2exV5oRtb9Ih5JmhMr9zJXD1y+6ScM32dz3x4uWBEm9f/ZIR5uISOqFQwg==
X-Received: by 2002:a05:6a00:a29:b0:71e:7604:a76 with SMTP id d2e1a72fcca58-720b9bb3e7emr240914b3a.1.1730303886655;
        Wed, 30 Oct 2024 08:58:06 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.241.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2d5bsm9407519a12.57.2024.10.30.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:58:06 -0700 (PDT)
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
Subject: [PATCH v3 1/4] ext4: Add statx support for atomic writes
Date: Wed, 30 Oct 2024 21:27:38 +0530
Message-ID: <3338514d98370498d49ebc297a9b6d48a55282b8.1730286164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730286164.git.ritesh.list@gmail.com>
References: <cover.1730286164.git.ritesh.list@gmail.com>
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
index 16a4ce704460..ebe1660bd840 100644
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
+		ext4_msg(sb, KERN_NOTICE, "Supports (experimental) DIO atomic writes awu_min: %u, awu_max: %u",
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


