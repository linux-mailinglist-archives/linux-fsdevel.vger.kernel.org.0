Return-Path: <linux-fsdevel+bounces-32397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3C9A49EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E2F1F21503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C21922F5;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cUQyrC8/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C9191499
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293561; cv=none; b=XGBk0CqffTb6YUtPTpseUq8V1JVrV/09KaZ7Efl+F6FR56u8PDQad8DZE66elXPzo67IjCs7Fw1k7FBr7epAV6FpMCJMuZoNBq6haWM+95ygnaKpGK5pYBqxEcxr1IuBnhohxJuhn80Lo63nSXkR1V/JBeuRqyynWzvW9Kdi8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293561; c=relaxed/simple;
	bh=mSNS9ZHb8J9edBLOFDSeE7333fa+R46m4eR55ErzdE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3pfAPuUJ78NLlgjwiUGuoWxI5DIe1sNyUpQq5joIzI4BKSqW7vPs5H70zXzhuJQ522I+JxMQK9lJcoQmtrFrQlRMOanXgEA02i6t7cnZe07dh8cGQnZaYxZ3SJuGuFBVpe9RH0OjHqz2qTJO5IpUWBJ+cHMvH36aROFtlH5m/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cUQyrC8/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hkA09h+I6ixav+0+EPxzrhhq+sYWxN3umjrMUgBsxJ4=; b=cUQyrC8/T03/HmqQyJKPiUyeJ7
	fKmOy3vZg/PT3p1ElX87D4ixCO00YH6Vx7D0TDSj0L5DZdt+t9uN4RMnB/xSB2POcgNztgdxHk6ab
	rCESJp4ob/fRsE8o21pMahuHhcIi1IVAKBX7D54SDZinrqt0eHEHUc5DrUQK1lGSyfo9Gfq2IFPn4
	+V+ndlDG2HvydDwWywgwDQCLtyLaRkXnVXPyKJYxlmgUTU7hlWuDrwztl4C+B6zRN5Myr6j/X9S84
	s1wIJhZLi0Lt2+O7BR88aMM/Us2XDyyGlPewI7f/pD1vVgM7ySEbVfpr9TGb2jH8g6v0oxjhisHqY
	G5IaC/lw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFa-00000005E7k-1Ls3;
	Fri, 18 Oct 2024 23:19:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 17/17] ufs: Convert ufs_change_blocknr() to take a folio
Date: Sat, 19 Oct 2024 00:19:16 +0100
Message-ID: <20241018231916.1245836-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
References: <20241018231428.GC1172273@ZenIV>
 <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Now that ufs_new_fragments() has a folio, pass it to ufs_change_blocknr()
as a folio instead of converting it from folio to page to folio.
This removes the last use of struct page in UFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index e578e429c5d8..194ed3ab945e 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -229,13 +229,13 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
  * situated at the end of file.
  *
  * We can come here from ufs_writepage or ufs_prepare_write,
- * locked_page is argument of these functions, so we already lock it.
+ * locked_folio is argument of these functions, so we already lock it.
  */
 static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 			       unsigned int count, sector_t oldb,
-			       sector_t newb, struct page *locked_page)
+			       sector_t newb, struct folio *locked_folio)
 {
-	struct folio *folio, *locked_folio = page_folio(locked_page);
+	struct folio *folio;
 	const unsigned blks_per_page =
 		1 << (PAGE_SHIFT - inode->i_blkbits);
 	const unsigned mask = blks_per_page - 1;
@@ -461,7 +461,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		ufs_change_blocknr(inode, fragment - oldcount, oldcount,
 				   uspi->s_sbbase + tmp,
-				   uspi->s_sbbase + result, &locked_folio->page);
+				   uspi->s_sbbase + result, locked_folio);
 		*err = 0;
 		write_seqlock(&UFS_I(inode)->meta_lock);
 		ufs_cpu_to_data_ptr(sb, p, result);
-- 
2.39.5


