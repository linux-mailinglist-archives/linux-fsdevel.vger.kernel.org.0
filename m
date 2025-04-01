Return-Path: <linux-fsdevel+bounces-45454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D8A77DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE21891109
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70251204F84;
	Tue,  1 Apr 2025 14:29:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFC204C30;
	Tue,  1 Apr 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517757; cv=none; b=ENRtIpN/gd8+oy2FvAd/fDlEQ3CW0mICmsN1maCQP+CLMLOnlx3Rqj+223ck1aYdWAm/FjkAw1V16n9U14GVpNbSRxj375jtpqTgcYc9Rs6XIPVLutlJmykenifQUF4sbVtZmcASEPuZmeNUU/zVrsfLbO7zBfWN67Q7IhrhZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517757; c=relaxed/simple;
	bh=0yNPU7fR3KA5NeXuXtdDLJE2giSzHzCBTZjemcexo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRKIaQd4vnTOk+1yRSQOyp8+an0lTUTpMTg8H2ITk/HR12ZeTposHW65h0lnJxnPFeB8o0ZLG5QFeG0/i0vyaa+kTR0jqwaRibA2kPaGkcCWAJO7t3diYJr6yILlSPNcw0hwlsDXjwwDDkc6obX0H4revq2WrBnSe/0HJPH3NOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.42.36] (helo=plastiekpoot)
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1tzcc1-000000000L0-1oDe;
	Tue, 01 Apr 2025 16:29:09 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1tzcbz-000000003Hl-0WOy;
	Tue, 01 Apr 2025 16:29:07 +0200
From: Jaco Kroon <jaco@uls.co.za>
To: bernd.schubert@fastmail.fm,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	joannelkoong@gmail.com
Cc: miklos@szeredi.hu,
	rdunlap@infradead.org,
	trapexit@spawn.link,
	david.laight.linux@gmail.com,
	Jaco Kroon <jaco@uls.co.za>
Subject: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
Date: Tue,  1 Apr 2025 16:18:17 +0200
Message-ID: <20250401142831.25699-3-jaco@uls.co.za>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401142831.25699-1-jaco@uls.co.za>
References: <20250314221701.12509-1-jaco@uls.co.za>
 <20250401142831.25699-1-jaco@uls.co.za>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

Clamp to min 1 page (4KB) and max 128 pages (512KB).

Glusterfs trial using strace ls -l.

Before:

getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 616
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 624
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 624
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 608
getdents64(3, 0x7f2d7d7a7040 /* 1 entries */, 131072) = 24
getdents64(3, 0x7f2d7d7a7040 /* 0 entries */, 131072) = 0

After:

getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) = 6696
getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) = 0

Signed-off-by: Jaco Kroon <jaco@uls.co.za>
---
 fs/fuse/readdir.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 17ce9636a2b1..a13534f411b4 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/minmax.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -337,11 +338,21 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = ctx->count };
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
+	int order;
 
-	folio = folio_alloc(GFP_KERNEL, 0);
+	desc.length = clamp(desc.length, PAGE_SIZE, fm->fc->max_pages << PAGE_SHIFT);
+	order = get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
+
+	do {
+		folio = folio_alloc(GFP_KERNEL, order);
+		if (folio)
+			break;
+		--order;
+		desc.length = PAGE_SIZE << order;
+	} while (order >= 0);
 	if (!folio)
 		return -ENOMEM;
 
@@ -353,10 +364,10 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
 		evict_ctr = fuse_get_evict_ctr(fm->fc);
-		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
+		fuse_read_args_fill(&ia, file, ctx->pos, desc.length,
 				    FUSE_READDIRPLUS);
 	} else {
-		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
+		fuse_read_args_fill(&ia, file, ctx->pos, desc.length,
 				    FUSE_READDIR);
 	}
 	locked = fuse_lock_inode(inode);
-- 
2.48.1


