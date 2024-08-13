Return-Path: <linux-fsdevel+bounces-25823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7912F950F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D03B2125A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047B91A76CD;
	Tue, 13 Aug 2024 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giFNn+kR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D843155
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584146; cv=none; b=kCdecTvOBHzCUFtcKAZuVV8YSwC2ksrYH0+giWXBCjLCAl9EMsaxYV45xoFSf4VZDbVF5tQe0pmaxYt9fnZBhMKQcDUIHPHo97PAuJ+azuMrw25U2lfDW5Y9Ck1VkUEzsu4tPZjYvrm+yH2tx9clskRgKtZvTiGUwTuD7OrjB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584146; c=relaxed/simple;
	bh=p0A9o2oUU/1HgAoajU1CwpXKwZGxUIb+/hezF8rWzmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FggY9AEDKDNmX/DmiG2Wn9VNL1/OyYAMz68wtS4qqVF1hkrRKIVjPTuPj5+PKOU/kRL710ucKVDq2BQBvgCkQn4F9Tv1Ly0CXcP3oqHLijhPm2ZNBXoaYZLu5o/7IQJ/UITdxbwifB819uJr5TldRIf4TWDk6SQoncqMSPwdP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giFNn+kR; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0bfa541c05so5232386276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723584144; x=1724188944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPo9dQpQLsf7z6K7R1mbR86q27Tov9VN11ZVUbU6rUI=;
        b=giFNn+kRrLIPW6VlahcHnjVBCeeJEWQNDOOBEa17q8KihWHkcrlNx2+KOm35SFpFQ1
         lVFwBY/ymoVS4UylUVpcHiAUPkD72v9qVd1bWLcp3glejL2E9HztlCINapuothI5OHfq
         6CQgltD6jM7tsvRcJMbis5LVolJ9XSB4+7Sx9Uv/SMLNw9yr7CIcBscGqRPeCT/iw0gM
         KGoeNoEodOqWXYwRxeEnoKcMLEnJzqOJ7wIuqnlC4vp6sHtQUYSSGjRLR7m94RogH6Il
         F3JotNS4g90bgga7RjHmqvph38WOsd6289IuEafqUoIUQwscsOoAGlMCXUFcCUXXmRUu
         vnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584144; x=1724188944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPo9dQpQLsf7z6K7R1mbR86q27Tov9VN11ZVUbU6rUI=;
        b=Lxia584RqH6e0MCHb4fKCfpK9my5DNxGwAOffPm0FMEzla1D+eMyQLZMRCWKI2WiPy
         sHfppjjqjkF1M2W82cIzDA9wfLV++dDsUC4TV5d8NgUixWQWb9XKs46y1Fwbn+fj7GUP
         URYwGZlBSm3ojJG8T3ycF+mBz9GMq5a0jylaBOSgOo1IA1gPpRWuuPcv6MINtYzm3omp
         Q+C1W1ObjTKpJfEKyff2/hRiw+Q7MTyF+1p4DckkESdXuloZchOia8YzT6AorzdGSDf8
         ClEwms6VY9ohHiI6IiE/a4BItiuqjtNpecSBlHqOq7K49aD8/wc0Wn9c/3XGy06QyZZ9
         b30A==
X-Forwarded-Encrypted: i=1; AJvYcCVnkeeyzHCTE3JdJLBTEFgirpRatOZBZMfrqbpG6rEvbw/c8hiYE/jRczQT+2ZgtmcA/3z6THypFUM4TxqVhG3SO5osubI4SI6QWwX10Q==
X-Gm-Message-State: AOJu0Ywf3w/e+mjO02zSaIc01iPMGFiMIitT8AccsX3m3+qG8x09/aU5
	HoE5w5fzpQeF4O+BQGPTeX/+Tc8z/Y6/Ft5kxNgaLR2wIkz2dZgopNzkiw==
X-Google-Smtp-Source: AGHT+IHibWji546Z+QPFpSXgvPb9WNo2I+Lnw+1wMNBczqvHFDt2zT5rOmppSXcDDS9bKSxwnuu2ow==
X-Received: by 2002:a05:6902:2305:b0:e0e:900c:946b with SMTP id 3f1490d57ef6-e1155a426fbmr1000095276.1.1723584143783;
        Tue, 13 Aug 2024 14:22:23 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8be6625sm1697628276.25.2024.08.13.14.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:22:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	osandov@osandov.com,
	bernd.schubert@fastmail.fm,
	sweettea-kernel@dorminy.me,
	kernel-team@meta.com
Subject: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes after open
Date: Tue, 13 Aug 2024 14:21:49 -0700
Message-ID: <20240813212149.1909627-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
fetched from the server after an open.

For fuse servers that are backed by network filesystems, this is
needed to ensure that file attributes are up to date between
consecutive open calls.

For example, if there is a file that is opened on two fuse mounts,
in the following scenario:

on mount A, open file.txt w/ O_APPEND, write "hi", close file
on mount B, open file.txt w/ O_APPEND, write "world", close file
on mount A, open file.txt w/ O_APPEND, write "123", close file

when the file is reopened on mount A, the file inode contains the old
size and the last append will overwrite the data that was written when
the file was opened/written on mount B.

(This corruption can be reproduced on the example libfuse passthrough_hp
server with writeback caching disabled and nopassthrough)

Having this flag as an option enables parity with NFS's close-to-open
consistency.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c            | 7 ++++++-
 include/uapi/linux/fuse.h | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..437487ce413d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct file *file)
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
 	if (!err) {
 		ff = file->private_data;
-		err = fuse_finish_open(inode, file);
+		if (ff->open_flags & FOPEN_FETCH_ATTR) {
+			fuse_invalidate_attr(inode);
+			err = fuse_update_attributes(inode, file, STATX_BASIC_STATS);
+		}
+		if (!err)
+			err = fuse_finish_open(inode, file);
 		if (err)
 			fuse_sync_release(fi, ff, file->f_flags);
 		else if (is_truncate)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..f5d1af6fe352 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ *  7.41
+ *  - add FOPEN_FETCH_ATTR
  */
 
 #ifndef _LINUX_FUSE_H
@@ -252,7 +255,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -360,6 +363,7 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
+ * FOPEN_FETCH_ATTR: attributes are fetched after file is opened
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -369,6 +373,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_PASSTHROUGH	(1 << 7)
+#define FOPEN_FETCH_ATTR	(1 << 8)
 
 /**
  * INIT request/reply flags
-- 
2.43.5


