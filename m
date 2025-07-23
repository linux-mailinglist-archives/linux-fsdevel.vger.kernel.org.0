Return-Path: <linux-fsdevel+bounces-55806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A2B0F091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3972517972C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300022DEA8E;
	Wed, 23 Jul 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJt2v8u6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2E2BCF6A;
	Wed, 23 Jul 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268298; cv=none; b=Q12waeQvIertFUqno4p/WklxnSxLikrq6wJx/qrSfnYKUJ+mS9V+ONEBT11ggtD7llzcj96PbT0sqwOfhJg3d8On3HQMGy/Y0A2vuEY+KbaZvcK4VNPmRJ9wwjoTWylzFCYl7cq4ToeIeTxyTlvR0iy9pqDB41OEABxSi1KLfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268298; c=relaxed/simple;
	bh=MOk8HvjhEoNVTUvHdsOCBEeFsjDZ/+Gm3zRv3ewF2Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y119abNOua8Z9/7vxnEt2Z9lC4aLruYAQmeRwmNS2UUWMH2Sc0K+7lAg8SwFj9W6OpJcPgMPYtF7aXgfMIGNs3F5kU0osJN3OMNWmaXjxDHxINFM8CEJoO1hyyywiGbbJ42UkaiQIXC8LmqCMqC707TCHnyxnb/xOu9QboP0cPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJt2v8u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D03AC4CEE7;
	Wed, 23 Jul 2025 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268298;
	bh=MOk8HvjhEoNVTUvHdsOCBEeFsjDZ/+Gm3zRv3ewF2Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJt2v8u6IxIzTI9xCeHJkY7txTqw4GYBmjXh99YzIodtzu+5vx8GK8+Yt4hhwdr7p
	 fcoG3YBwX0GEOwz5ag9hCWXP8uNss9oFcj5EO7MUJNAvhzS2kvekbBzqcvtjCzC8aX
	 89VQddFKdSLE5GXBuZ7U3yME3Sflh2PSkHjeyKyVMWdDwU8c4BZcoh3g6SF9oCZR/P
	 tys+itxNUKjMQMCuwwpTvnbUPhC25nXj/70nlbxLdGXz41WDlS+liUVOl8Bo501Vy5
	 pXcMsEel1a3ECgrYQ/Ecyli15g4JzwrXWFrTq85rHk8UAfut/c1lYKtVDMKTq7/XY2
	 S9vZop4ONA1bg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v4 05/15] f2fs: move fscrypt to filesystem inode
Date: Wed, 23 Jul 2025 12:57:43 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-5-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=brauner@kernel.org; h=from:subject:message-id; bh=MOk8HvjhEoNVTUvHdsOCBEeFsjDZ/+Gm3zRv3ewF2Aw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HND6HaLtmm0RVZ/yr12pW+VModr08vLQTbxP5+y1d +d+tTG5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLzjjP8j3FQMxZ+s2p//e62 5fv2Hv55yebYusdqTKk7r19e7mwn+JqR4TzLwbZz8oa317UIhn0oaeC7ZSS7veDBl+ssMjxLP92 +xAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/super.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9333a22b9a01..53cb6b6fc70b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -905,6 +905,9 @@ struct f2fs_inode_info {
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info; /* filesystem encryption info */
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..dab4078c2f6a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1453,6 +1453,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
+#ifdef CONFIG_FS_ENCRYPTION
+	fi->i_crypt_info = NULL;
+#endif
 
 	return &fi->vfs_inode;
 }
@@ -3326,6 +3329,10 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.inode_info_offs	= offsetof(struct f2fs_inode_info, i_crypt_info) -
+				  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
 	.supports_subblock_data_units = 1,

-- 
2.47.2


