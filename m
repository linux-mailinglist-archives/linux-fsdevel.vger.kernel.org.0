Return-Path: <linux-fsdevel+bounces-17177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312778A89F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C478C1F23C1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F399172789;
	Wed, 17 Apr 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J2T2crc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE2172796;
	Wed, 17 Apr 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373794; cv=none; b=ZJ2wU/XJnKNpHlgFI5NY9uP7Qw5Dy+QFDcGPpU4tkoh2i1uzsE7GZxD3XscI5a11ZLX39/zmdv7b67w3xBdz6Qp1lybJFWGiP2KPqbuFWEDL3krGMgAobMKeaz015n9nVblGiYcjsdiGHfyxFzrH4EiEcaLg5J37P5VvRtoeq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373794; c=relaxed/simple;
	bh=UiymJav+ACgwnnTqZhZOJCG1ZgXeoBStmosnsPpXk84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/RY040rGiNGCk7/eNdsEoWxj/3pkvxh24Bt+MoXVqgE6zj0lvGl9OCMpUXE0MNZcV3SDehmnDAAAG27p1x8UGvf7j04qoGbIHRecj8gFlOJEogL9xpP4kjqnqbM8OjSBMwm3WeHJk308pY9JPrQIxXG7qhnb4R2IQpjPeYDqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J2T2crc1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7bZeS0mEdRY/gU0MkUgofDOebQU6IakHlHbte6xXEK4=; b=J2T2crc1kwpQ+zbrZpppXPQjVT
	JsRtGj9yHVyQgenHPtlw8Q9LH24kBPgayR3XGOKFfjiC0BxAJnKcWaq0bmFJMZvflgoSngtFpiPib
	E7MBuIL4CiOugxk0kFvmgjP5cBP7Xgc+fI/+3wUNpbgACni05SS+cWzIFUGCPrmJ6JhTaIIo9DDUt
	pIX6Y7y57awYZm5sKQU/fZ891XuMZ2eBS4cy5wDcrycyjCP33laZB9aN4GguwVGeWIcBzoP4z6DBD
	wNtAi20IhNVBudhLgjqZ8eEqJ6NUTYMaRSdU7kYTySwxcErLZxLIlM3/dX7S/zmda8UuJ1MHq/K+q
	lfSmlkEA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n7-00000003LNS-3pry;
	Wed, 17 Apr 2024 17:09:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] ntfs3: Convert ntfs_write_end() to work on a folio
Date: Wed, 17 Apr 2024 18:09:32 +0100
Message-ID: <20240417170941.797116-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the passed page back into a folio and use the folio APIs, saving
a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1eb11c3b480d..e649d191554d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -938,6 +938,7 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		   u32 len, u32 copied, struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 valid = ni->i_valid;
@@ -949,23 +950,23 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		err = attr_data_write_resident(ni, page);
 		ni_unlock(ni);
 		if (!err) {
+			struct buffer_head *head = folio_buffers(folio);
 			dirty = true;
-			/* Clear any buffers in page. */
-			if (page_has_buffers(page)) {
-				struct buffer_head *head, *bh;
+			/* Clear any buffers in folio. */
+			if (head) {
+				struct buffer_head *bh = head;
 
-				bh = head = page_buffers(page);
 				do {
 					clear_buffer_dirty(bh);
 					clear_buffer_mapped(bh);
 					set_buffer_uptodate(bh);
 				} while (head != (bh = bh->b_this_page));
 			}
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 			err = copied;
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	} else {
 		err = generic_write_end(file, mapping, pos, len, copied, page,
 					fsdata);
-- 
2.43.0


