Return-Path: <linux-fsdevel+bounces-31065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC8991923
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55A1282EE5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D1158DB9;
	Sat,  5 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yls1V4w9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9AC40C15
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151346; cv=none; b=gPGTig30Oh/FeKV49c8NXU1LIwFFzD4cPK6Db8I3R4/LSwMBaC214jR9uIvzcawaOa66+Tp0G4GQ5u9cxV6a3/4zpTneejA8tppMVQ3MnZlJMeD08V66TjvG0ju2oDIdhuNImTG421AGf20/hXUAhkRAluJv2zhOxwk6m9K3kQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151346; c=relaxed/simple;
	bh=LdyGAAj4knWMDajjRvuu0pnE4ZfGYgw6Af+zh25NIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aV6Kt3eUJr9eVuLrdUt8DcFt3z7c35G8amVr3MK+GlEzm1WN6RQQ5dShY4SO4ELFH32qiWcBlPvHrXWCG11BwpyDl2Qs9eqiM9TJuS8BA4gfNQKleO1wBihxhxEAEUiQm9J4945X9g87ZIzqjwkfPHiEpIs5QdP6yiWo3pG0Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yls1V4w9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bFsXyN0pe8TO0FfymeIVL5FGxEwmd7OwuICgPpBSdMM=; b=Yls1V4w9MTVdkeEHFjNghe+SFQ
	O/2k8uapSMBLw9Pfx9Ye1Yg9gGHtk9ImQ2IGO8gyhKwzYgXxQVvfqLR8DWWlWbRltQKiKe4ySVaty
	ZSBmjdiMEnQaecvQOv3ZuBK63ruV9n1ysvAA8Q5hfyQjuk58xh9yuvz9XZSm/0CcB66AX3dh4cTLr
	c0s4a9p3+uSXQHq8xqOQR+v+0DWDRVqcD/+kV+Kz0T1z7s98ZFp09WSfVxLCCvj3rgoQ9JnAsnKCD
	YiuZ7rFOElPKce/eDOq3bMKnSxAWqMPwALFYKexps1o3ox7CFHtnLLoha4Wl8UXRakUIbh2PG1Tfp
	JZwUU38Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx96f-0000000DLlW-3dW5;
	Sat, 05 Oct 2024 18:02:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] ufs: Pass a folio to ufs_new_fragments()
Date: Sat,  5 Oct 2024 19:02:07 +0100
Message-ID: <20241005180214.3181728-5-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005180214.3181728-1-willy@infradead.org>
References: <20241005180214.3181728-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio, pass it to ufs_new_fragments() instead
of converting back to a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/balloc.c | 10 +++++-----
 fs/ufs/inode.c  |  8 ++++----
 fs/ufs/ufs.h    |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 53c11be2b2c1..2abe13d07f85 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -337,7 +337,7 @@ static void ufs_clear_frags(struct inode *inode, sector_t beg, unsigned int n,
 
 u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 			   u64 goal, unsigned count, int *err,
-			   struct page *locked_page)
+			   struct folio *locked_folio)
 {
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
@@ -417,7 +417,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 		result = ufs_alloc_fragments (inode, cgno, goal, count, err);
 		if (result) {
 			ufs_clear_frags(inode, result + oldcount,
-					newcount - oldcount, locked_page != NULL);
+					newcount - oldcount, locked_folio != NULL);
 			*err = 0;
 			write_seqlock(&UFS_I(inode)->meta_lock);
 			ufs_cpu_to_data_ptr(sb, p, result);
@@ -441,7 +441,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 						fragment + count);
 		read_sequnlock_excl(&UFS_I(inode)->meta_lock);
 		ufs_clear_frags(inode, result + oldcount, newcount - oldcount,
-				locked_page != NULL);
+				locked_folio != NULL);
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		UFSD("EXIT, result %llu\n", (unsigned long long)result);
 		return result;
@@ -462,11 +462,11 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 	result = ufs_alloc_fragments (inode, cgno, goal, request, err);
 	if (result) {
 		ufs_clear_frags(inode, result + oldcount, newcount - oldcount,
-				locked_page != NULL);
+				locked_folio != NULL);
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		ufs_change_blocknr(inode, fragment - oldcount, oldcount,
 				   uspi->s_sbbase + tmp,
-				   uspi->s_sbbase + result, locked_page);
+				   uspi->s_sbbase + result, &locked_folio->page);
 		*err = 0;
 		write_seqlock(&UFS_I(inode)->meta_lock);
 		ufs_cpu_to_data_ptr(sb, p, result);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a2be1bd301ee..b9359fd95d00 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -239,7 +239,7 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
 	p = ufs_get_direct_data_ptr(uspi, ufsi, block);
 	tmp = ufs_new_fragments(inode, p, lastfrag, ufs_data_ptr_to_cpu(sb, p),
 				new_size - (lastfrag & uspi->s_fpbmask), err,
-				&locked_folio->page);
+				locked_folio);
 	return tmp != 0;
 }
 
@@ -250,7 +250,7 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
  * @new_fragment: number of new allocated fragment(s)
  * @err: we set it if something wrong
  * @new: we set it if we allocate new block
- * @locked_page: for ufs_new_fragments()
+ * @locked_folio: for ufs_new_fragments()
  */
 static u64 ufs_inode_getfrag(struct inode *inode, unsigned index,
 		  sector_t new_fragment, int *err,
@@ -287,7 +287,7 @@ static u64 ufs_inode_getfrag(struct inode *inode, unsigned index,
 			goal += uspi->s_fpb;
 	}
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment),
-				goal, nfrags, err, &locked_folio->page);
+				goal, nfrags, err, locked_folio);
 
 	if (!tmp) {
 		*err = -ENOSPC;
@@ -367,7 +367,7 @@ static u64 ufs_inode_getblock(struct inode *inode, u64 ind_block,
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment), goal,
-				uspi->s_fpb, err, &locked_folio->page);
+				uspi->s_fpb, err, locked_folio);
 	if (!tmp)
 		goto out;
 
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index a2c762cb65a0..9b462c62511f 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -88,10 +88,10 @@ struct ufs_inode_info {
 #endif
 
 /* balloc.c */
-extern void ufs_free_fragments (struct inode *, u64, unsigned);
-extern void ufs_free_blocks (struct inode *, u64, unsigned);
-extern u64 ufs_new_fragments(struct inode *, void *, u64, u64,
-			     unsigned, int *, struct page *);
+void ufs_free_fragments (struct inode *, u64 fragment, unsigned count);
+void ufs_free_blocks (struct inode *, u64 fragment, unsigned count);
+u64 ufs_new_fragments(struct inode *, void *, u64 fragment, u64 goal,
+		unsigned count, int *err, struct folio *);
 
 /* cylinder.c */
 extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, unsigned);
-- 
2.43.0


