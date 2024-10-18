Return-Path: <linux-fsdevel+bounces-32399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58F9A49EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C88283CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88F192583;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y3EzEdx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13E191494
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293562; cv=none; b=AL2WaqO3yH3vD2lmM3zADFuOu/qVXnC/A7yrC1zpPuFN8xu0h/iaKKVfX3Jy0aMX1U2iRH8QfiWPQl7U3c+cyqFMaCtBQ9jzAT/iHjECGOsTWsyBmy/FSdLtTE4ZGZaI0jrIF4oXSK44MtEGJS3kGMHifTRI3g11gEQK4AvFfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293562; c=relaxed/simple;
	bh=4K38SK4ZTwMEOe1pIvQaWQ3ucuNw67nY/lkCh2lNEgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cx/wDNVyQXzPVU1fJvCDE0nzj/5pwKLkJHn8b7j6YmBs3IY5r+jwIxqkI1xzIExCz70K0bAEm5ZmlRF5NOALgYDEbsqc1pXIqghaVVktznP7mSyChS7Wgko0UlTjkc1hmYVIdTmyXGaiJ04EgTf/LFQBXY6o7CdOTPmWz/ELdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Y3EzEdx1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MKcWVyYUe1a7W2udOjDki7kYR/9MnYTP9B1nGCuO4Z8=; b=Y3EzEdx1qaMoNMj0pOuavEnruQ
	cH29/f0S9Ju/aGGW8+m64bA1BVoFQ4BpVLSVkl2r9d9Q87MljxIDTT0ury+bLC1VlbGLgNJwGQxmf
	3V3whoXtWVhPaAFZniHRKjdKs5Rw/C+TBd4a4t41zOLW6oH9LHiFb/S8Lmv7Xqfh/z9WRulOZ6U4i
	Ifa7p0wlg7/a7btx90oid2KuvYI6XvO6UwPecfMf+jHGgT7ckCY++8FYtfJpgMW51+2hVFaGI+9tm
	LCbOaFBD1i8cwEdWtXza2rHpa4Ik1uduFaRwOBwFCYphsLGAAvtj8G/pALZXZdMZvNdsBI/zUzeUr
	Q3eoNqbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFa-00000005E7e-11sa;
	Fri, 18 Oct 2024 23:19:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 16/17] ufs: Pass a folio to ufs_new_fragments()
Date: Sat, 19 Oct 2024 00:19:15 +0100
Message-ID: <20241018231916.1245836-16-viro@zeniv.linux.org.uk>
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

All callers now have a folio, pass it to ufs_new_fragments() instead
of converting back to a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 10 +++++-----
 fs/ufs/inode.c  |  8 ++++----
 fs/ufs/ufs.h    |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index c60006c5806c..e578e429c5d8 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -332,7 +332,7 @@ static void ufs_clear_frags(struct inode *inode, sector_t beg, unsigned int n,
 
 u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 			   u64 goal, unsigned count, int *err,
-			   struct page *locked_page)
+			   struct folio *locked_folio)
 {
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
@@ -412,7 +412,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 		result = ufs_alloc_fragments (inode, cgno, goal, count, err);
 		if (result) {
 			ufs_clear_frags(inode, result + oldcount,
-					newcount - oldcount, locked_page != NULL);
+					newcount - oldcount, locked_folio != NULL);
 			*err = 0;
 			write_seqlock(&UFS_I(inode)->meta_lock);
 			ufs_cpu_to_data_ptr(sb, p, result);
@@ -436,7 +436,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 						fragment + count);
 		read_sequnlock_excl(&UFS_I(inode)->meta_lock);
 		ufs_clear_frags(inode, result + oldcount, newcount - oldcount,
-				locked_page != NULL);
+				locked_folio != NULL);
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		UFSD("EXIT, result %llu\n", (unsigned long long)result);
 		return result;
@@ -457,11 +457,11 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
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
index 30e5d695d74d..7dc38fdef2ea 100644
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
@@ -282,7 +282,7 @@ static u64 ufs_inode_getfrag(struct inode *inode, unsigned index,
 			goal += uspi->s_fpb;
 	}
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment),
-				goal, nfrags, err, &locked_folio->page);
+				goal, nfrags, err, locked_folio);
 
 	if (!tmp) {
 		*err = -ENOSPC;
@@ -347,7 +347,7 @@ static u64 ufs_inode_getblock(struct inode *inode, u64 ind_block,
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment), goal,
-				uspi->s_fpb, err, &locked_folio->page);
+				uspi->s_fpb, err, locked_folio);
 	if (!tmp)
 		goto out;
 
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index c7638e62ffe8..e7df65dd4351 100644
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
2.39.5


