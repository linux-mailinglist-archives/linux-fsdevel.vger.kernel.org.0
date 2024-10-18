Return-Path: <linux-fsdevel+bounces-32401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D899A49F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8587283E01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AB1925AC;
	Fri, 18 Oct 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q9dDoMWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD774191496
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293563; cv=none; b=qidxBsAGwvW/4D6thglIVZlqY0NalJZbjLrGqvn1r+ntoNH9l+sTwbXwbbiRGLvepSFlnJwrjZFbmOjVDgHjLvNpGkSD86WutNN3DGicQOclYuvPpmafBTBgtJWaG/808xw9v4XxoeEb6zLaC5EinUO9uPar6TPq5HhuBRDBoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293563; c=relaxed/simple;
	bh=CbS0wCgwGa/cgl4sqoPf8fGMQv6ocG33GJfImcishk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cllnCeeCHA+ixWjhhpMpklurNSsrLEE4WVH72i0t/2bUv74QkCYuMC/n+nzj5xavceasqSdQnDAkPJyDrNCD6AhVQYVH3WUOMt8oJmiICrOD3DT7wOvpJDO7FEB0+oUilZksz89Hf3qdGDz2W2fCUlr68Ks/O+fq//sF/XHMXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q9dDoMWU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ny6Os/r2A0hUmcgdRZwzqQEdajuhiY0oq+Bl9gdLMo0=; b=q9dDoMWUYmAeEQQa7EuVlS5mZp
	3GiXyNBqg40ub7Y/I5CdYdD37XaERvcro12+aMxAuT4tZqs0RhA0w21C/7KK2Ltb0j9kyCVacNKhi
	XX0KgifgavRhdWUb2xWcvHNJbVscEnKqrWYewqdaG+8bbCSif1az7TlVpRBW1AuBfaZFtNIqA/0w/
	fcdxZfk3/1qVyTXvoJUGJzQSyYMstviZfUfmUJwfozUsHzb0ug+kjimW+G1pOAOXzxFO940bk0ipA
	UfOCfjYEq8rjIfiYXMZXHzV/wb9AZ4PLd4QrE0Nnd2A/QtLwE9WLyOPMNZYu192nH5WZa0aweOR4Y
	Qn6BIY4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFa-00000005E7Y-0n7i;
	Fri, 18 Oct 2024 23:19:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 15/17] ufs: Convert ufs_inode_getfrag() to take a folio
Date: Sat, 19 Oct 2024 00:19:14 +0100
Message-ID: <20241018231916.1245836-15-viro@zeniv.linux.org.uk>
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
 fs/ufs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 1d3eb485df41..30e5d695d74d 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -252,10 +252,9 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
  * @new: we set it if we allocate new block
  * @locked_page: for ufs_new_fragments()
  */
-static u64
-ufs_inode_getfrag(struct inode *inode, unsigned index,
+static u64 ufs_inode_getfrag(struct inode *inode, unsigned index,
 		  sector_t new_fragment, int *err,
-		  int *new, struct page *locked_page)
+		  int *new, struct folio *locked_folio)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -283,7 +282,7 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 			goal += uspi->s_fpb;
 	}
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment),
-				goal, nfrags, err, locked_page);
+				goal, nfrags, err, &locked_folio->page);
 
 	if (!tmp) {
 		*err = -ENOSPC;
@@ -420,7 +419,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 
 	if (depth == 1) {
 		phys64 = ufs_inode_getfrag(inode, offsets[0], fragment,
-					   &err, &new, bh_result->b_page);
+					   &err, &new, bh_result->b_folio);
 	} else {
 		int i;
 		phys64 = ufs_inode_getfrag(inode, offsets[0], fragment,
-- 
2.39.5


