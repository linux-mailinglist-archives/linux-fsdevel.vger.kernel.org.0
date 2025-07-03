Return-Path: <linux-fsdevel+bounces-53850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0AEAF82D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89101564983
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 21:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6E238C34;
	Thu,  3 Jul 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="xWsgZTHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6402DE701
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579370; cv=none; b=UAI7jeqRafZPOCuEKnMKBcxDxYg6j6LGpBAMap69SQWBl32RKnmZ3/H13M3aKnEbsr2Vc8daI/QUXbnIJWHHwea7nkqHVzynd3pAA/p7MEZTduDV896XRNywobJ1d1V8IDhBIqvMM3/nsydxTmA/V57x78WRAf6DAmnC1h7vVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579370; c=relaxed/simple;
	bh=KbYogzfUVqoUYSy+FLGA9xyAPMO1p7VypHtxZGwssqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EaVJGV9t15mOuzmnqZTbAu+94t5wpNPJQgvufD8ZmbXLwRTRiLifI1DI7xBJis5icoChs1J+fcEtC6F0olZoXv5mhITU/UEb9qJDYbkVorhOefkIlwJ5/pWX/+Bvf2tmtYYd+wKVgnHPmzJzEE5tNrfZg3DOE1Vll7WmutSk3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=xWsgZTHY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71101668dedso2382987b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751579367; x=1752184167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oVkeJO3k7khkAdlC6wAYm+58kKBAE1Cl6uBXSxMMU0=;
        b=xWsgZTHY/52dPklf5kOw0FdveO6FL/6DM1RwSK1cUO0bPI5AsPtoj8fWudJWOT8jx9
         T4pMaeiqMfEfBUe/dGGqRY8qjTo9tlk2XRAYNNNWhH//qKiCYgTxDS8CRqm30AquyQai
         24C5TZKpk/VyS28P/vcsRUtWVSA+ISRP7xIQPXetiVm6xKPkr17xPSewAPbY9HFB8H4j
         Ij/SgiyMZcHhtmAkFBBMJucII/C6dXfMVSUp70CNS2cCUL9oxS27LcsyipeQ3LAN+xdz
         /6ZJWoBVuCnKHDxU5W2cs4bJ5Hq5ACjIWDi6zdNO9DpDwdMKiO6TalUkeOR0RY8hiiX6
         t45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579367; x=1752184167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oVkeJO3k7khkAdlC6wAYm+58kKBAE1Cl6uBXSxMMU0=;
        b=EwxDmQFRDjc2EPxwC2mqL9HvoDnVI/iv5TG91TaEZkxpGp1UeI9lt6FOGqxfBcENPA
         9nFU9C95DgUukYwsMsXNcwSE1hHQPAw+gG3Ss3H3Knf7a2ry6xpRXufbmQ9ZrwPM9pX7
         jdPs29IEDKLZXH9CSIa0hIXrJIyipAZOge1//BPpm4ON/bvg+cNMqRz+b1kKdrhHVU3v
         SOsOf9l/M6yrmh3jfTaQtoEhG95FwTtkXwi3YtDOSiFC9+R0hx3ROyZ6o7b2sHellMLK
         dWZVd5O0Inkx21oJvTSXuuo+nLVRkOihbDislKyo3DP/6vXPourS4r5ro1VP0Vk+hP8r
         9m4g==
X-Forwarded-Encrypted: i=1; AJvYcCWaiBOpnGV9Vo7rIjncQVNNbeHdZolRC5KYO9ouW0gdfcAkodnC1UyNEDAg0zRCI+/j4tjr0crq3kJG1c/I@vger.kernel.org
X-Gm-Message-State: AOJu0YzTM7HQpHx4m+OTTfAf5mzHHYEpEcjTm0MmzCCmb5xl9ncdBVnP
	5hkJ8pmgzdMnhkjM+1ja+530muDawW7EAe/DtTEs6CNgVrzD6Ct8D5QBnh4sP3Q2VnE=
X-Gm-Gg: ASbGncuvDaLlRTUt8LpTOmiItkM0JpbE/2pH7OiVkFdLcM3/UrqeeehCrZtjUrraO3X
	TypthG7Cnwb3EwsOLKYq03BmDi5+1Gv3i8skgSj2O2YmBO+CzZA85n3am5gD3Bq928O78v8rTtg
	UfleKJEetdddp3tGwwmBXaEE7kgrvPmqcnGGWmdNeYu6fQeuC1Bd/hdutOn3cYGFviSf305qY2W
	MalkaSPab9U6Ni5ZbM+BwZLsueUXQnMcQyNt55Ci0Z48bXvY5ccZP1cl3wBfK+Q41CrOOJfhzio
	4MMSVfg18x0vnojjWCgaFOWT3xo2DMqxm8DFcOlXlY/YGEx5Hw+MHLO5wDgFiHuWIEbMj2M/6GE
	FZ7OGHNk=
X-Google-Smtp-Source: AGHT+IEYyyNmoacbfwS+ZICqeKsTwgSZsh+9RqgHIlOY08pDUPS2kbuq2qywFb5QNDM+BJHgfn8xGg==
X-Received: by 2002:a05:690c:64c9:b0:710:f2a1:fa6 with SMTP id 00721157ae682-71668d5b70fmr3153097b3.29.1751579367286;
        Thu, 03 Jul 2025 14:49:27 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:38f:e803:4bcd:b8f6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665ae2a1esm1278617b3.72.2025.07.03.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:49:26 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	huk23@m.fudan.edu.cn,
	jjtan24@m.fudan.edu.cn,
	baishuoran@hrbeu.edu.cn,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix slab-out-of-bounds in hfs_bnode_read()
Date: Thu,  3 Jul 2025 14:49:12 -0700
Message-Id: <20250703214912.244138-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces is_bnode_offset_valid() method that checks
the requested offset value. Also, it introduces
check_and_correct_requested_length() method that checks and
correct the requested length (if it is necessary). These methods
are used in hfs_bnode_read(), hfs_bnode_write(), hfs_bnode_clear(),
hfs_bnode_copy(), and hfs_bnode_move() with the goal to prevent
the access out of allocated memory and triggering the crash.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/bnode.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index cb823a8a6ba9..1dac5d9c055f 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,6 +15,48 @@
 
 #include "btree.h"
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
@@ -22,6 +64,20 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	int bytes_read;
 	int bytes_to_read;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagenum = off >> PAGE_SHIFT;
 	off &= ~PAGE_MASK; /* compute page offset for the first page */
@@ -80,6 +136,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	page = node->page[0];
 
@@ -104,6 +174,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 {
 	struct page *page;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	page = node->page[0];
 
@@ -119,6 +203,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(src_node, src, len);
+	len = check_and_correct_requested_length(dst_node, dst, len);
+
 	src += src_node->page_offset;
 	dst += dst_node->page_offset;
 	src_page = src_node->page[0];
@@ -136,6 +224,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(node, src, len);
+	len = check_and_correct_requested_length(node, dst, len);
+
 	src += node->page_offset;
 	dst += node->page_offset;
 	page = node->page[0];
-- 
2.43.0


