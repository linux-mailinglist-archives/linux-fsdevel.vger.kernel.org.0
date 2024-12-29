Return-Path: <linux-fsdevel+bounces-38254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413E9FE10F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 00:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C40318820EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B65199935;
	Sun, 29 Dec 2024 23:58:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F82594BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735516684; cv=none; b=qantzv40O0Jn9ZmDPzaaYVGo3bHBxOrF7+D/9yp9LKqP/jY4ZiXAEwhDvzI+6MdHI1x/bowUZXW4QWGO5fDp83nR+FLMN25jelrVCM3mxBvdFOxLNdP92CFAS2loCWvcszLOrRHseV/lA1MKwngzZjOFqX+FfGQJCD+bvIT24gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735516684; c=relaxed/simple;
	bh=ookR3hMtlinDMiJs9Ys4VFkXKQROHTaE43ktFjCNRPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4powu7s804+E3rWz3KKiJljEczcj9b4vz6Fm5yO05lPjHCrDC7WlZ9zmA5CsWJDUtvbIN6VQASWp9IIqb5il41zyEpz/TDeLg8rzdu37Br18vdumjJWt/hySrMwgSyna7s8hhSbnq2pUw400h45o6ffRrhhq89CAG+IxddVSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from raspberrypi.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id S2rotGQTRxZ1ZS2rztFiU6; Sun, 29 Dec 2024 16:38:52 -0700
X-CMAE-Analysis: v=2.4 cv=S8MjwJsP c=1 sm=1 tr=0 ts=6771dd8c
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=LqOhZttQMPkbruw0GBwA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 2/4] squashfs: don't allocate read_page cache if SQUASHFS_FILE_DIRECT configured
Date: Sun, 29 Dec 2024 23:37:50 +0000
Message-Id: <20241229233752.54481-3-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241229233752.54481-1-phillip@squashfs.org.uk>
References: <20241229233752.54481-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDfskyE4LXpm9JvCF0IlQQyVNTmewYv3X2vfK1c1o3WDSAchyl7rcPGaZjA5azw1RNRtX+1CdvkOxjPu+eMUzWOtj1tBaUAzzYSxsofK07TzUteQf2Eh
 ICqQNbRViwxReV/Eb8/5+k1r5krwuXjWjEceQRuNiI2Z2bH34JJXFy+jAzRQL0q8z0j7qsiMBDKgaxWyR5uZy4RXRWgp3CKl9/RBCva1jBGddKgtKntXZbO6
 2FM0I7kWYixdMMgVtgJOs/217SQ1oXGHTFLH2b/okra0MclOQ5NiToaYvMKNH1lPX7vKRIUGmulM/VJHpJhthHXV17oFeix1OZSYG9gaPgM=

If Squashfs has been configured to directly read datablocks into the
page cache (SQUASHFS_FILE_DIRECT), then the read_page cache is unnecessary.

This improvement is due to the following two commits, which added the
ability to read datablocks into the page cache when pages were
missing, enabling the fallback which used an intermediate buffer
to be removed.

commit f268eedddf359 ("squashfs: extend "page actor" to handle missing pages")
commit 1bb1a07afad97 ("squashfs: don't use intermediate buffer if pages missing")

This reduces the amount of memory used when mounting a filesystem by
block_size * maximum number of threads.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/squashfs.h | 6 ++++++
 fs/squashfs/super.c    | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 37f3518a804a..218868b20f16 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -14,6 +14,12 @@
 
 #define WARNING(s, args...)	pr_warn("SQUASHFS: "s, ## args)
 
+#ifdef CONFIG_SQUASHFS_FILE_CACHE
+#define SQUASHFS_READ_PAGES msblk->max_thread_num
+#else
+#define SQUASHFS_READ_PAGES 0
+#endif
+
 /* block.c */
 extern int squashfs_read_data(struct super_block *, u64, int, u64 *,
 				struct squashfs_page_actor *);
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index fedae8dbc5de..67c55fe32ce8 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -323,7 +323,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Allocate read_page block */
 	msblk->read_page = squashfs_cache_init("data",
-		msblk->max_thread_num, msblk->block_size);
+		SQUASHFS_READ_PAGES, msblk->block_size);
 	if (IS_ERR(msblk->read_page)) {
 		errorf(fc, "Failed to allocate read_page block");
 		err = PTR_ERR(msblk->read_page);
-- 
2.39.5


