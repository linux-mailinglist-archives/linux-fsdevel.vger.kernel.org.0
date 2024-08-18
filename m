Return-Path: <linux-fsdevel+bounces-26215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B5956048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 02:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5D1B2196F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F6BE46;
	Mon, 19 Aug 2024 00:01:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [92.204.81.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE23BBF2
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025682; cv=none; b=tJEDO/FUTtYhIfTe7N8t/XMPiy3W07ksCQRBsHxrN/SzDS2TGDwymuDquu0Xv7pUBTeAJZSmLqDmN9ONDXGOTC7WAAdw/Of9NSAPc9iFrl6uWSH1t7DbAj8ewr3iZZmXSVrU+LNRiTCnsd3Qq/Rbnmv5ITfbvRpRXMvPaFnALJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025682; c=relaxed/simple;
	bh=VMbsSCwl8BRhNBMKYMjgjw4ce4B36fAYx4tZYgbpdIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2wI4WSv2gXmlbu9AmNH5mVV5uPsNpRtQUnfar4YOIoYhWvpdTL/9bJmaaRVAZIE4/Ez6jtViAldf7pk2PbZwVciuYi/SNbJyEqBgqKWmsc+mdVATQp8mqrspdW2D6lXYRYgBfIip0mylc63x13eIE+TXk2xOTEp4e+fWXxUsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id fpn7sTYC0QGHUfpnOsxSIr; Sun, 18 Aug 2024 16:58:51 -0700
X-CMAE-Analysis: v=2.4 cv=LJ6tQ4W9 c=1 sm=1 tr=0 ts=66c28abb
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=9tSg9AYEYi0W0Z4Y8GAA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	lizetao1@huawei.com,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 4/4] Squashfs: Rewrite and update squashfs_readahead_fragment() to not use page->index
Date: Mon, 19 Aug 2024 00:58:47 +0100
Message-Id: <20240818235847.170468-5-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfJrHU6NXhXbqHmipeh76Mhj9TxdPQEZUIwgjTedAZz55OJAQAGvHE6zLaMdETM4u2qYG8Ks0sRIclrYqajWNlwKi0jTtbp1KVEaqNN4ktOtuMMYAbQIS
 apd4NfiShAp/E+sNRpfNDUbfwU0pNKmiTFgZG+I2Bbgu7C7EuWUQIm2tFVAFANw5I9Mrxe2gl/UoCuSUMEZ98PuEeFUvRX99T8RukU5vCvqJpPrsKEePxIyt
 I0GNu8edEyFbtHsr8JallWSpp46NqPhbeHNPxW9ZClcW0kVGsNlkiGchTGVI9CIhM/OmOxzA1qbvnt8nLF0lzIXCdqLQo5RKTSdervWw6xEq/jorZRbQmRzU
 rCZ6m90kvn18KijJpoPE1mYS0L40jbtpmGheKf4/VUp83Ac2+Ak=

The previous implementation lacked error checking (e.g. the bytes
returned by squashfs_fill_page() is not checked), and the use of
page->index could not be removed without substantially rewriting
the routine to use the page actor abstraction used elsewhere.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c | 66 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 50fe5a078b83..5a3745e52025 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -494,39 +494,73 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 }
 
 static int squashfs_readahead_fragment(struct page **page,
-	unsigned int pages, unsigned int expected)
+	unsigned int pages, unsigned int expected, loff_t start)
 {
 	struct inode *inode = page[0]->mapping->host;
 	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
 		squashfs_i(inode)->fragment_block,
 		squashfs_i(inode)->fragment_size);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int error = buffer->error;
+	int i, bytes, copied;
+	struct squashfs_page_actor *actor;
+	unsigned int offset;
+	void *addr;
+	struct page *last_page;
 
-	if (error)
+	if (buffer->error)
 		goto out;
 
-	expected += squashfs_i(inode)->fragment_offset;
+	actor = squashfs_page_actor_init_special(msblk, page, pages,
+							expected, start);
+	if (!actor)
+		goto out;
 
-	for (n = 0; n < pages; n++) {
-		unsigned int base = (page[n]->index & mask) << PAGE_SHIFT;
-		unsigned int offset = base + squashfs_i(inode)->fragment_offset;
+	squashfs_actor_nobuff(actor);
+	addr = squashfs_first_page(actor);
 
-		if (expected > offset) {
-			unsigned int avail = min_t(unsigned int, expected -
-				offset, PAGE_SIZE);
+	for (copied = offset = 0; offset < expected; offset += PAGE_SIZE) {
+		int avail = min_t(int, expected - offset, PAGE_SIZE);
 
-			squashfs_fill_page(page[n], buffer, offset, avail);
+		if (!IS_ERR(addr)) {
+			bytes = squashfs_copy_data(addr, buffer, offset +
+					squashfs_i(inode)->fragment_offset, avail);
+
+			if (bytes != avail)
+				goto failed;
 		}
 
-		unlock_page(page[n]);
-		put_page(page[n]);
+		copied += avail;
+		addr = squashfs_next_page(actor);
 	}
 
+	last_page = squashfs_page_actor_free(actor);
+
+	if (copied == expected) {
+		/* Last page (if present) may have trailing bytes not filled */
+		bytes = copied % PAGE_SIZE;
+		if (bytes && last_page)
+			memzero_page(last_page, bytes, PAGE_SIZE - bytes);
+
+		for (i = 0; i < pages; i++) {
+			flush_dcache_page(page[i]);
+			SetPageUptodate(page[i]);
+		}
+	}
+
+	for (i = 0; i < pages; i++) {
+		unlock_page(page[i]);
+		put_page(page[i]);
+	}
+
+	squashfs_cache_put(buffer);
+	return 0;
+
+failed:
+	squashfs_page_actor_free(actor);
+
 out:
 	squashfs_cache_put(buffer);
-	return error;
+	return 1;
 }
 
 static void squashfs_readahead(struct readahead_control *ractl)
@@ -572,7 +606,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		if (start >> msblk->block_log == file_end &&
 				squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK) {
 			res = squashfs_readahead_fragment(pages, nr_pages,
-							  expected);
+							  expected, start);
 			if (res)
 				goto skip_pages;
 			continue;
-- 
2.39.2


