Return-Path: <linux-fsdevel+bounces-44096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0686CA62096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECD71B63256
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADC1DEFE0;
	Fri, 14 Mar 2025 22:39:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE31547E2;
	Fri, 14 Mar 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991953; cv=none; b=eTsq/rNLkoRqZMkel224Gpvc8BjFd70r/ZvOGjidaA2Pux5vgWcu+MVlewOMYPeMbiN2RVjXLtKGqo3d5jEKYvjtT3fC1kKmfgzG3fXUa/XbfDX54e3HIzSizhsDNmuQJEJBROqcEV4eV00HzmksnFKzP6LaCl6+HHkT8eDHtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991953; c=relaxed/simple;
	bh=Hy6X7HLlR6nCe05sEMzcsd5zK0Wy9GJRMdXNJcJDoqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9WCVFyf/m+Sls8CbceOlMdDojEEPSsrc6Qx5dakFXdTGdP5F42Z+QZlMNTt4ShGG8rPlVBO/13+fDPWDmZZBh56L6dp4DLnC75YbqcPW58VzY/PPFlRHowPgN4bxILFIOPv7rbXQ2kWFGTP7t3nHCfDvx7UJyGtVaIWpfMlIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.1.104] (helo=plastiekpoot)
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1ttDL0-000000005rc-2CNl;
	Sat, 15 Mar 2025 00:17:06 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1ttDKy-000000003ko-0GIh;
	Sat, 15 Mar 2025 00:17:04 +0200
From: Jaco Kroon <jaco@uls.co.za>
To: jaco@uls.co.za
Cc: bernd.schubert@fastmail.fm,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	rdunlap@infradead.org,
	trapexit@spawn.link
Subject: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
Date: Sat, 15 Mar 2025 00:16:28 +0200
Message-ID: <20250314221701.12509-3-jaco@uls.co.za>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314221701.12509-1-jaco@uls.co.za>
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
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
 fs/fuse/readdir.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 17ce9636a2b1..a0ccbc84b000 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -337,11 +337,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = ctx->count };
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
+	int order;
 
-	folio = folio_alloc(GFP_KERNEL, 0);
+	if (desc.length < PAGE_SIZE)
+		desc.length = PAGE_SIZE;
+	else if (desc.length > (PAGE_SIZE << 7)) /* 128 pages, typically 512KB */
+		desc.length = PAGE_SIZE << 7;
+
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
 
@@ -353,10 +367,10 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
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


