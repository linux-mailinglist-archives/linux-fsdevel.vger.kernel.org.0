Return-Path: <linux-fsdevel+bounces-26216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01C2956075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 02:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E7281B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 00:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508E15C0;
	Mon, 19 Aug 2024 00:06:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [92.204.81.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E555BE46
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025984; cv=none; b=Utnnvx9++bHPGHbIVc1Mlkjz/yl7KuVEX9yTkvyS3j8YwepKFw/avcCenKu5zTp8e+GjmrweaaenGWk5OZ4cxXL6w58q5brV4285KbigFZhQkl8G38sJu/VrYehzU32U3CN6t3tC+dhZY2N0hxI3sFgWMKPu2ZHzdd25bCzgy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025984; c=relaxed/simple;
	bh=CLxWQbrGLeGhf8m0jbFA8flJFaDPvmVHoBNH0fNSN8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwObJ/QxxAzpKnrfD8q2jmIXBYPDLreNJyr163E1CqZIJCc7oTTXsdff8hwnZzaza5DjhFLXl3dQ12FIT3NvBqdstXKHCQO3NsA3idnqz+e0KURRQ8Q/5Me2PSt3W7HSJM24bZWKSMiMVgAhOO6Lcepp/f/IUuVi+PC8wNPi6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id fpn7sTYC0QGHUfpnNsxSIj; Sun, 18 Aug 2024 16:58:49 -0700
X-CMAE-Analysis: v=2.4 cv=LJ6tQ4W9 c=1 sm=1 tr=0 ts=66c28ab9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=pK5tc-4CcGVY2xxucFwA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	lizetao1@huawei.com,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 3/4] Squashfs: Update squashfs_readpage_block() to not use page->index
Date: Mon, 19 Aug 2024 00:58:46 +0100
Message-Id: <20240818235847.170468-4-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818235847.170468-1-phillip@squashfs.org.uk>
References: <20240818235847.170468-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC4EVImtNchewiNRgGU1EmOg2S2bEAhPfYB7xYHZx62zj16rW1wXEiGhBHJb2pZyWqgHuUiMHBnuoaKse3n4P2iplaSfLA0GibD8z3UEo6VMJ13xHzzz
 ZX6qikiQjekYxDy8K9wjlydyXOTI2NFtR4pBSHVOH4IkX17/CpV4gCGK0OpFxCdqKwexPg40XbH4IYz482sZ1vFm1LqUq7zxgiRQ4ClJFMu8O7bqWFnb5zLm
 8tQihrRuTqnIlsu+JHWGh8003TV7ajTlm9iop1Uwi6rQBAbSNdOLhKrAyitgrrB2rsNXrIZ9hK0uxORY4hHZQNsuogHHSvRARbAmX2RkLRXc8bNuJm76nWbw
 pUGtse+x32VYdUY34ruG5RBzUKAK8WwNmkMBoCxGrkn74mHR8kQ=

This commit replaces references to page->index to folio->index or
their equivalent.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file_direct.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 0586e6ba94bf..646d4d421f99 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -23,15 +23,15 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int expected)
 
 {
+	struct folio *folio = page_folio(target_page);
 	struct inode *inode = target_page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-
 	loff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	loff_t start_index = target_page->index & ~mask;
+	loff_t start_index = folio->index & ~mask;
 	loff_t end_index = start_index | mask;
 	int i, n, pages, bytes, res = -ENOMEM;
-	struct page **page;
+	struct page **page, *last_page;
 	struct squashfs_page_actor *actor;
 	void *pageaddr;
 
@@ -46,7 +46,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 
 	/* Try to grab all the pages covered by the Squashfs block */
 	for (i = 0, n = start_index; n <= end_index; n++) {
-		page[i] = (n == target_page->index) ? target_page :
+		page[i] = (n == folio->index) ? target_page :
 			grab_cache_page_nowait(target_page->mapping, n);
 
 		if (page[i] == NULL)
@@ -75,7 +75,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-	squashfs_page_actor_free(actor);
+	last_page = squashfs_page_actor_free(actor);
 
 	if (res < 0)
 		goto mark_errored;
@@ -87,8 +87,8 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 
 	/* Last page (if present) may have trailing bytes not filled */
 	bytes = res % PAGE_SIZE;
-	if (page[pages - 1]->index == end_index && bytes) {
-		pageaddr = kmap_local_page(page[pages - 1]);
+	if (end_index == file_end && last_page && bytes) {
+		pageaddr = kmap_local_page(last_page);
 		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
 		kunmap_local(pageaddr);
 	}
-- 
2.39.2


