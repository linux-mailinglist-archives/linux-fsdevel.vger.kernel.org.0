Return-Path: <linux-fsdevel+bounces-26847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF195C13C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812D7285588
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6971D1F4C;
	Thu, 22 Aug 2024 23:05:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-15.prod.sxb1.secureserver.net (sxb1plsmtpa01-15.prod.sxb1.secureserver.net [188.121.53.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87918AEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367949; cv=none; b=Mm4aCjBVf+OUIR15eHqVo9waVJ3NERi8zck9y18yWqMSn6saMDJr0IgnFWScK3zJxX7711d+dDWiRXX2+LSxM0gkydN/D2TmYXgc1sBPHkwkKg+zl/PrH9KtYvugjJr11Pyz9XGTykAn9/8CPqNyjjPOlFdkenB/K01zPh3g8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367949; c=relaxed/simple;
	bh=lxAwp9I3kfoBzyu+yEC6APrB0bUQmLjjzHwWOjiCeHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CToRd9A7U955UgthQYJdZR+AfYKmE7URYro7ncTndN8P6oHcAXqUgJUj9mUlk/48giIeLQprXnG/4u8gD5o2MtsMHy1W+3hRp3vmAQl97Dn5R0jLAsEFzkdn1yUDKn1QJVKlfmjwgBYAticymkxUlb6Kh8aE7edPWaeAZIcTfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id hGkfsDg1Wp0VxhGktsYyjL; Thu, 22 Aug 2024 15:58:12 -0700
X-CMAE-Analysis: v=2.4 cv=C+4iyhP+ c=1 sm=1 tr=0 ts=66c7c284
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=FXvPX3liAAAA:8 a=s94iO8TKwuVpzBr5ofsA:9 a=AjGcO6oz07-iQ99wixmX:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH V2] Squashfs: Ensure all readahead pages have been used
Date: Thu, 22 Aug 2024 23:58:12 +0100
Message-Id: <20240822225812.78755-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMN4Lk1lDEx9iRxHOcWKbqDtEBWRs3PTPMO5JNix4YyfPx6pa+f53zRF4//2lnjzMogCrYMBUK8PqqdiB9IAuAgsmrPlf9HNKnx399rcIMtVsxxFAjUE
 dbPTSLtEL14briK3AhHcnzuSb1r2QrdHQwE5Uf7yl8te67El/19UqzC1mOdmWDKkx5cHmZiFeGjASReAlEj22LYxmzH20IrLoK6+hd+ZxxEU+9dNFCDLbs4K
 3xoOFlN/8up40SwqCaDXTGSvXg++uH4THYj4VehZ7gSjXh4jFWEUgV0YjgQrapq9gneJSCn1bz78IfqwStpTtDsdmf/8A+BkUS9Vvbefs0Qh9H2X3zNKLzaQ
 WUW956Bg

In the recent work to remove page->index, a sanity check
that ensured all the readhead pages were covered by the
Squashfs data block was removed [1].

To avoid any regression, this commit adds the sanity check
back in an equivalent way.  Namely the page actor will now
return error if any pages are unused after completion.

[1] https://lore.kernel.org/all/20240818235847.170468-3-phillip@squashfs.org.uk/

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
--
V2: fix use after free thinko.
---
 fs/squashfs/file.c        | 4 ++--
 fs/squashfs/file_direct.c | 2 +-
 fs/squashfs/page_actor.h  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 5a3745e52025..21aaa96856c1 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -535,7 +535,7 @@ static int squashfs_readahead_fragment(struct page **page,
 
 	last_page = squashfs_page_actor_free(actor);
 
-	if (copied == expected) {
+	if (copied == expected && !IS_ERR(last_page)) {
 		/* Last page (if present) may have trailing bytes not filled */
 		bytes = copied % PAGE_SIZE;
 		if (bytes && last_page)
@@ -625,7 +625,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		last_page = squashfs_page_actor_free(actor);
 
-		if (res == expected) {
+		if (res == expected && !IS_ERR(last_page)) {
 			int bytes;
 
 			/* Last page (if present) may have trailing bytes not filled */
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 646d4d421f99..22251743fadf 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -80,7 +80,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	if (res < 0)
 		goto mark_errored;
 
-	if (res != expected) {
+	if (res != expected || IS_ERR(last_page)) {
 		res = -EIO;
 		goto mark_errored;
 	}
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index c6d837f0e9ca..aa0d0e583634 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -33,10 +33,11 @@ extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				loff_t start_index);
 static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *actor)
 {
-	struct page *last_page = actor->last_page;
+	struct page *last_page = actor->next_page == actor->pages ? last_page : ERR_PTR(-EIO);
 
 	kfree(actor->tmp_buffer);
 	kfree(actor);
+
 	return last_page;
 }
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
-- 
2.39.2


