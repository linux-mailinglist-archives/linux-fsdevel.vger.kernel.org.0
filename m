Return-Path: <linux-fsdevel+bounces-13354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA2F86EF38
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841EA1F23209
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51A17C70;
	Sat,  2 Mar 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5ZJk0Zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429917BC7;
	Sat,  2 Mar 2024 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365363; cv=none; b=aB2aaJJBu4hFlWc6cV2gcao3LOKuWGymLfBxb5t0rxcfhunOA64kaGdl2+1NLlfn8qCQwJIsAE51OKUNBeA5044bU/J659CxqIYrTlGvtTmkljfKdshpCzEz1Cli2FS2mzPUtKaIwlOORQou003ZUu/5zq0zUJD+3aDUIDfLvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365363; c=relaxed/simple;
	bh=BDptZaUdouDGvCPACBlkzaPvTTUmwhTQ7mmrE9tmTVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edhVxKr6ym9uCo3KI8Jbc0qsleDkXX+9lsuhc+YamO3eY1HDoHaglDykjbkTC73IiLlZnH/PHX73upAMQ/MHUG/y64h9JFgvf0RHLwTQVSLBc565E2hmUuOABlFIc04AEps4COG46f1O79U0Ribty8LPc17n21JZMGltHEZh0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5ZJk0Zx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-365145ef32fso9452035ab.1;
        Fri, 01 Mar 2024 23:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365360; x=1709970160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTfdJwbprgG1n5WYQCCw6xYQX3etSudrpY9bbjKNIpw=;
        b=i5ZJk0Zx/+ilD36uEuMKdHpjcnFebawqXa/RJQ3pxAiYPTzvGHv7VeDe5JGCCcqIZm
         HgvOqObkKfz1EmezjxRtQfvO+SrbmVrAvT92ClWHEfdd+MYJRUkN6WrvpnSSjXbpVaBy
         5MSh4ta/5hNWcniMBb8uGbkaGvEyGlNh1+Pq7IIdFKfYMZ5XJyjQhob1NFx0lD77M8s+
         Fg5c2KS5Bzr3QGJwn4nuqkCQQa9RL3LZmmQs7/o0vEhYtuq0LwOxm/JY6fHVEwkyZMZn
         8p+GUBbLyqXczYwuSLthkpOqXWHkyC0bXfQVIYKbR8eZBf3WYmJICDiOzx6LFGq7LBW3
         V9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365360; x=1709970160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTfdJwbprgG1n5WYQCCw6xYQX3etSudrpY9bbjKNIpw=;
        b=OJVnFoPGjkVupYQhC/XIA48Af4appOQ250EQzGDle0/K+p1euP71NvfF9Iyelu2zNq
         JvfIgO+rqhd97wDBiJxTtVU+g2xlXheXDCJVJUFaj3f0RGZ8T5sSAl+rBSIvfvM3czkg
         0yq2bLp3MZ6Awm13KTyq72a2bRndY37IxoYpP1zUgcEfFWnU6Jp0b8MXriTu7xsRJxUO
         42OPgHbPGhfQ/nouohi6ZJyASO8x+qdI3I5A/asjNTpVt3wKjnWyEe9WWmE96MG9ae2W
         XWFBJa8hQrdAvU2dTh/g3tB728YXdvKAFWtI4DvNgamijNGosuwH1MoA3byHVkO2dphi
         NkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/buRLFrkeTEf0ct6noqXPXhXVKmTbtnGTlaQF02wt/0G9j/LjpWZs8pgfUOCk5uDg75kGIJp71QgsAv1y64a7szQQ2VZ18HDzBmL/Omieithn2xCnJGu8yEAEsFMenvWvW3JEIZf+aw==
X-Gm-Message-State: AOJu0YzEhJn8wKSGKj1gRvknApj9W9Gus/8GyExC8v9GB72ah7A76w2R
	EmEilWbfi4MO+jroRYtIy8W2rtNuu+63+fA3eG+wesHTJZWXTyN4VmjK6A4a
X-Google-Smtp-Source: AGHT+IF6jddCyDq2/OaWTlanWjcunc8w2YfYNzosd+LLUHNO2MfZmt29PENZpz6FxdzRAZaVYRKykw==
X-Received: by 2002:a05:6e02:1a47:b0:365:1ec4:a96c with SMTP id u7-20020a056e021a4700b003651ec4a96cmr4629876ilv.5.1709365360291;
        Fri, 01 Mar 2024 23:42:40 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:39 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 4/8] ext4: Add statx and other atomic write helper routines
Date: Sat,  2 Mar 2024 13:12:01 +0530
Message-ID: <9def15d6ffb88f7352713c65292513fab532112a.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the statx (STATX_WRITE_ATOMIC) support in ext4_getattr()
to query for atomic_write_unit_min(awu_min), awu_max and other
attributes for atomic writes.
This adds a new runtime mount flag (EXT4_MF_ATOMIC_WRITE_FSAWU),
for querying whether ext4 supports atomic write using fsawu
(filesystem atomic write unit).

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 16 +++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 023571f8dd1b..1d2bce26e616 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1817,7 +1817,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
+	EXT4_MF_FC_INELIGIBLE,		/* Fast commit ineligible */
+	EXT4_MF_ATOMIC_WRITE_FSAWU	/* Atomic write via FSAWU */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
@@ -3839,6 +3840,56 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
+#define ext4_can_atomic_write_fsawu(sb)				\
+	ext4_test_mount_flag(sb, EXT4_MF_ATOMIC_WRITE_FSAWU)
+
+/**
+ * ext4_atomic_write_fsawu	Returns EXT4 filesystem atomic write unit.
+ *  @sb				super_block
+ *  This returns the filesystem min|max atomic write units.
+ *  For !bigalloc it is filesystem blocksize (fsawu_min)
+ *  For bigalloc it should be either blocksize or multiple of blocksize
+ *  (fsawu_min)
+ */
+static inline void ext4_atomic_write_fsawu(struct super_block *sb,
+					   unsigned int *fsawu_min,
+					   unsigned int *fsawu_max)
+{
+	u8 blkbits = sb->s_blocksize_bits;
+	unsigned int blocksize = 1U << blkbits;
+	unsigned int clustersize = blocksize;
+	struct block_device *bdev = sb->s_bdev;
+	unsigned int awu_min =
+			queue_atomic_write_unit_min_bytes(bdev->bd_queue);
+	unsigned int awu_max =
+			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
+
+	if (ext4_has_feature_bigalloc(sb))
+		clustersize = 1U << (EXT4_SB(sb)->s_cluster_bits + blkbits);
+
+	/* fs min|max should respect awu_[min|max] units */
+	if (unlikely(awu_min > clustersize || awu_max < blocksize))
+		goto not_supported;
+
+	/* in case of !bigalloc fsawu_[min|max] should be same as blocksize */
+	if (!ext4_has_feature_bigalloc(sb)) {
+		*fsawu_min = blocksize;
+		*fsawu_max = blocksize;
+		return;
+	}
+
+	/* bigalloc can support write in blocksize units. So advertize it */
+	*fsawu_min = max(blocksize, awu_min);
+	*fsawu_max = min(clustersize, awu_max);
+
+	/* This should never happen, but let's keep a WARN_ON_ONCE */
+	WARN_ON_ONCE(!IS_ALIGNED(clustersize, *fsawu_min));
+	return;
+not_supported:
+	*fsawu_min = 0;
+	*fsawu_max = 0;
+}
+
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ccf3b5e3a7c..ea009ca9085d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5536,6 +5536,22 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
+	if (request_mask & STATX_WRITE_ATOMIC) {
+		unsigned int fsawu_min = 0, fsawu_max = 0;
+
+		/*
+		 * Get fsawu_[min|max] value which we can advertise to userspace
+		 * in statx call, if we support atomic writes using
+		 * EXT4_MF_ATOMIC_WRITE_FSAWU.
+		 */
+		if (ext4_can_atomic_write_fsawu(inode->i_sb)) {
+			ext4_atomic_write_fsawu(inode->i_sb, &fsawu_min,
+						&fsawu_max);
+		}
+
+		generic_fill_statx_atomic_writes(stat, fsawu_min, fsawu_max);
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-- 
2.43.0


