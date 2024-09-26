Return-Path: <linux-fsdevel+bounces-30205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600FF987B0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 00:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B401F2580E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E494189909;
	Thu, 26 Sep 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVcYjpdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37C18953C;
	Thu, 26 Sep 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388721; cv=none; b=i4Nw+z1iSlhq/zhNXH087endEyejqYfUfsQ5CoxR6XuHZBi68dvb5uiDphAe/jkKHX3BLPU2Ow1tdd6jI1P4V11cybz0e6mzSnkoI3TqqOc9VGQZpLiIh9FQE097e093NZLIhQtMxyTi0fMgyQr+SiSz1J8TrMWVb2aA889neo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388721; c=relaxed/simple;
	bh=QvMnrSEOtedu7hG4MUQWbtF0q2dHoP30sYkapiOoAzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxHIwtTKrgqvmSK/o1mCX9bT0k3g4IVD3Ju6zNNbgnh825nIYuGzBIhK+WWOtuLWfEM1FJJpgK8ji4E2H50O1gdQsYpzyEnDfvFwBZ3Fdg+0yurW/IGx6hroHfPzUyV7QKjQOaBpbBmUWH/Zw6EsCEYER6aPfHyPRHUm6J1B7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVcYjpdb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so1085428f8f.2;
        Thu, 26 Sep 2024 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727388718; x=1727993518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHIdz8N5X9UxsI9bI03NQBXIlayyWD0jMXQux7dbgDU=;
        b=BVcYjpdbg5NZ+3nJj/bH1FMJCAguiX76MceRRXLXHejGGtofDNmG900Vg3SUND54zB
         qTv4WGlji1aiwzhZXdsV1KCmYsG2SFsdYsrV9tBRQN0jlasgU1k8Jy4guRDnW7AR9mWA
         N2/Bb7s9oKEP9hRgY2pYKHpNLAqnq/HQfQjUZPZGFfhYl4bqsB8qdbMLYajHqdFRPAav
         TRrQ4Zv0gBfBrZI5B+uKonC8avJTZbmAF0nISUIsEsMWcgaS1jIJRAXOLXzgsbXGIeM6
         ksp0EWg6ZQ58pCpjOcveNH38NFoYLmWV3DxrBxNMzja16eqc4MGNlSWldJU6ArlLz66B
         wePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727388718; x=1727993518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHIdz8N5X9UxsI9bI03NQBXIlayyWD0jMXQux7dbgDU=;
        b=kEY5wms0WpBX4xy7ypkrl+GCO8fbE9xgYWinOzUuopq/n5HveDqlRi6a/RurBEdWHJ
         gZ6Z/5hvw0SHJ5N1ijgiuWC9qF0wjU5BOyT2gYvL+1+xVwOQRcTtdYwBIMcHdXkNSLkZ
         /P4e3JpYldBALSyD4gkhCH59NoPzdDvxHDPxmeM8zj8dtQ55cFClUXR3bt6Xq1vnq7WZ
         bwVdOtyKLTmgyUIfZGgLAipmWi7XAS9szYxV763suewsHXp4LfN65WKyLsyDU1fZMToA
         fWDU7CajVUauw32thLnluWlDr+Pq1y3IK7s5kj8yRvXoXcrpqLPquRkXhGCpi88hJHE0
         PKNg==
X-Forwarded-Encrypted: i=1; AJvYcCUbeEKfruzNUi8T+xazGMi57xxO5SzS+cm1BjOPphZrAQVnI3OmLoCPldhA2yI0gl/Y6fytZIEe+OaFkSruyg==@vger.kernel.org, AJvYcCVYdosVBZZVNin42xot3lJS5LLDHo7FYDnc9ILNTKGHUCrh1NsDLNPEW93TQ7kf6RriMBinqhtWoVeVUd3F@vger.kernel.org, AJvYcCVwF9oCuNw+MuwA5tW0/K7Eg6HAlR4EDKlkcVbZEbkH11onmV6puKpzMej8uD8Y13vSnrCN2s1n4Gh5@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1T6BMwzA7SaSDnrdFWbIAmlfwMbsCWkyVYawBW+MGGffvFi0
	XLf5DlnYPdQNE+70IGX+yC4YmOnNosDS2RRCgA8n5I238NKgiRGd
X-Google-Smtp-Source: AGHT+IG/KC9gXXC16YMbOycDvJ10Ha9WW5a5iCqjVhQ2Z+c4Jy04olCzirNgoZ+IubDFVcOz1hhoeA==
X-Received: by 2002:a5d:4e0e:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-37cd5a9eaddmr740525f8f.13.1727388718160;
        Thu, 26 Sep 2024 15:11:58 -0700 (PDT)
Received: from Max.. ([5.29.180.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6587sm851091f8f.47.2024.09.26.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 15:11:57 -0700 (PDT)
From: Max Brener <linmaxi@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Max Brener <linmaxi@gmail.com>
Subject: [PATCH] [PATCH] vfs/ext4: Fixed a potential problem related to an infinite loop
Date: Fri, 27 Sep 2024 01:11:03 +0300
Message-ID: <20240926221103.24423-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306

This patch fixes a potential infinite journal-truncate-print problem.
When systemd's journald is called, ftruncate syscall is called. If anywhere down the call stack of ftruncate a printk of some sort happens, it triggers journald again
therefore an infinite loop is established. Some example of such situation (aside from the example given in the added link): ext4_es_print_tree(struct inode*) is one of
the functions being called as a part of the call stack of ftruncate (System.journal is an extent file). In this function, some debug prints occur.
There can be more printk statements down the call stack (and if not, then there might be in the future). 
This patch does two things: prevents an infinite loop, and optimizes truncate operation by avoiding doing it if it is a no-op call.

To fix this issue:
Add  a new inode flag S_TRUNCATED which helps in stopping such an infinite loop by marking an in-memory inode as already truncated.
When ext4_setattr() is triggered, it won't call ext4_truncate() if the size of the file is unchanged and the file was truncated at least once
(which might be necessary for removing preallocated blocks). 
Calling truncate for the second time with no size change, is a no-op call, therefore the call is avoided.
Next, turn on the flag of the inode if it is truncated in ext4_truncate().
In ext4_setattr, avoid calling ext4_truncate if the inode is already truncated and the size of the file is not meant to change in the current call.
Finally, zero S_TRUNCATED flag of the inode at fallocate() when it is being called with FALLOC_FL_KEEP_SIZE flag.

Signed-off-by: Max Brener <linmaxi@gmail.com>
---
 fs/ext4/inode.c    | 5 ++++-
 fs/open.c          | 3 +++
 include/linux/fs.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..c2a9e9be23e2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4193,6 +4193,8 @@ int ext4_truncate(struct inode *inode)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
+	inode->i_flags |= S_TRUNCATED;
+
 out_stop:
 	/*
 	 * If this was a simple ftruncate() and the file will remain alive,
@@ -5492,7 +5494,8 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * Call ext4_truncate() even if i_size didn't change to
 		 * truncate possible preallocated blocks.
 		 */
-		if (attr->ia_size <= oldsize) {
+		if (attr->ia_size < oldsize ||
+			(attr->ia_size == oldsize && !IS_TRUNCATED(inode))) {
 			rc = ext4_truncate(inode);
 			if (rc)
 				error = rc;
diff --git a/fs/open.c b/fs/open.c
index daf1b55ca818..3f34dda79479 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -329,6 +329,9 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (!file->f_op->fallocate)
 		return -EOPNOTSUPP;
 
+	if (mode & FALLOC_FL_MODE_MASK & FALLOC_FL_KEEP_SIZE)
+		inode->i_flags &= (~S_TRUNCATED);
+
 	file_start_write(file);
 	ret = file->f_op->fallocate(file, mode, offset, len);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6b8df574729c..ae613481dc29 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2272,6 +2272,7 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_TRUNCATED (1 << 18) /* Is the file truncated */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2328,6 +2329,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
+#define IS_TRUNCATED(inode)	((inode)->i_flags & S_TRUNCATED)
 
 static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
 				   struct inode *inode)
-- 
2.43.0


