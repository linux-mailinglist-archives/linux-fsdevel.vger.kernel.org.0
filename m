Return-Path: <linux-fsdevel+bounces-32391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB779A49E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871B1B21848
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F251922C0;
	Fri, 18 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uVEPmfsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A3190661
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293561; cv=none; b=sVxLQgC4GwUDlkzadhNSMv+kfGcDNTJRfg8+m2JLXPhl54aQXJ9JkbowukXQTpUIqlnVuxzJspQPcwu8YvaLAP5SSxO/oTzcYLGzVCZO0a/8w8+oVTxp3sRs24Rwpgz5JvCU0mmqKG/O4BwVObVUWjez/PxSq2P5OPlkuRhs+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293561; c=relaxed/simple;
	bh=3JhbPFWCZ7zruMqnLJrw/Dl0q61qcTk5NyhPisNxufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpRYUbbcfWbFDvLppTAcDNDBuBTN7LlKhbkvxMYHFqGk5L8OyEQPZ7cGlyvOlZxP/wxhH2l69bBVFPPn0FdsPca2ohY9Jcj08NI2qwnHxAwF+ikcIi+ZGNSEA0e+nDrxojHLJquQzxuH6Y/5qbc38kMYA7W3VbkJSJwTPKUgnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uVEPmfsC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=THIIVdGDNd8KIOhZShAVHavkP1cYo442Eq+xHAPmyeI=; b=uVEPmfsCTlJ6lCrf3GbpBq8xca
	hvFNZzmpA0xEvjWDZcszZBUvKpHAcjolVrAcNg3bNVOrDads9TXGI69RX3twQBsdqyD6BopkiLtc9
	rCRCrp/xtg2U1XEOg817LJj40m0wU9abweGmqT6lzLa0ctDALPItD+ITBmTrjZHCxosaYJ/LOtoFR
	ABFrRuyhugOn/5HY1ES3g/pVIMoDHq1O/8svKUjWjofQh7eP4znWW0qH3Z9psv6CLv/pV6a8as5a/
	SbhFdKfyDBInnoFPkFlgKT0Acor5vXKkGU9Gbpfz+8zqFlUbrRVm4KGWGf3tPuPyhhxIb7PSwS5/T
	sQcc1ZEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E7M-3zo1;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/17] ufs: Convert ufs_inode_getblock() to take a folio
Date: Sat, 19 Oct 2024 00:19:12 +0100
Message-ID: <20241018231916.1245836-13-viro@zeniv.linux.org.uk>
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

Pass bh->b_folio instead of bh->b_page.  They're in a union, so no
code change expected.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/inode.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a3475afb3c26..912950ee5104 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -309,12 +309,11 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
  *  (block will hold this fragment and also uspi->s_fpb-1)
  * @err: see ufs_inode_getfrag()
  * @new: see ufs_inode_getfrag()
- * @locked_page: see ufs_inode_getfrag()
+ * @locked_folio: see ufs_inode_getfrag()
  */
-static u64
-ufs_inode_getblock(struct inode *inode, u64 ind_block,
-		  unsigned index, sector_t new_fragment, int *err,
-		  int *new, struct page *locked_page)
+static u64 ufs_inode_getblock(struct inode *inode, u64 ind_block,
+		unsigned index, sector_t new_fragment, int *err,
+		int *new, struct folio *locked_folio)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
@@ -349,7 +348,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment), goal,
-				uspi->s_fpb, err, locked_page);
+				uspi->s_fpb, err, &locked_folio->page);
 	if (!tmp)
 		goto out;
 
@@ -430,7 +429,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 			phys64 = ufs_inode_getblock(inode, phys64, offsets[i],
 						fragment, &err, NULL, NULL);
 		phys64 = ufs_inode_getblock(inode, phys64, offsets[depth - 1],
-					fragment, &err, &new, bh_result->b_page);
+				fragment, &err, &new, bh_result->b_folio);
 	}
 out:
 	if (phys64) {
-- 
2.39.5


