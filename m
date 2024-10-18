Return-Path: <linux-fsdevel+bounces-32396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377B9A49ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EAB283D76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6771922F4;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IScAIbqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97759191461
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293561; cv=none; b=s9v5txT+Wmn36P+lgZ1zJHaDJrXXVYZeln9ZoDurpSVjtDHDB1DIalQj1UPEI1eY7SIV3iJTu7L2Ys64Erx6DaCl9jjyVL+ROnqhEDoF4a+dYJto6RfsdOj5kCdF5bOgjVmCHubgmCah6B5xKlGC/uZ0yiE+BlK+Jm+sA6WOCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293561; c=relaxed/simple;
	bh=mytbpyeqKwdMhJ9ze1E9vBj9e7GeXaS4wu2USFlfE3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8nJn3UWCKU9HUdYzLBmEQesj7EV+/i9GGZu482Eyi1f/6LG6QEoOH84+BYqD9j0MXhndWmMCmPF4EBTIVGi0awVVMBhAnec1DnhkUeNvH41MC5+VHmLZDQiuYgRS9MAw42wEN1WAgNkbJJntwVqfjAmSMZSm55h4xPR13VbJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IScAIbqF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=M/L9rvTnqtf8e90/h2TUjh0ieAClUaQCKeUeKBPTjeA=; b=IScAIbqFjlcHLwBQ7WwN4zM1bM
	eRY2QBvo+PQ4P5YYPAQIgu3pyb6swHzWI4HYEJi9gc9N5PHm7cUD/jPDtXONeyfjOhx2UpY8wYjHb
	XhB+JTB7d4z0YX76l+glNnjyEGAj2yOt7dH5g4wbj1kD+jVvLFd4X9ENRHsPN9pZLIqsxJKcVOLkF
	CO6RwKhkaQE/6rHWZSBzFYt90KFnUavYcRvl8ZBO7zMTY0i8Ml9fKdPOYla01ZBgJuZ9nHfCYPQc7
	8kG+yb81Qfvxb0Ib5H1X1GIOU8+bMcYcUN+gjQhCpogZKIeRV3rN441Lr8vAOw+bu5yBNQy4BnTfK
	ELWEckvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFa-00000005E7S-0JWG;
	Fri, 18 Oct 2024 23:19:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 14/17] ufs: Convert ufs_extend_tail() to take a folio
Date: Sat, 19 Oct 2024 00:19:13 +0100
Message-ID: <20241018231916.1245836-14-viro@zeniv.linux.org.uk>
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
 fs/ufs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 912950ee5104..1d3eb485df41 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -220,7 +220,7 @@ static u64 ufs_frag_map(struct inode *inode, unsigned offsets[4], int depth)
  */
 static bool
 ufs_extend_tail(struct inode *inode, u64 writes_to,
-		  int *err, struct page *locked_page)
+		  int *err, struct folio *locked_folio)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -239,7 +239,7 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
 	p = ufs_get_direct_data_ptr(uspi, ufsi, block);
 	tmp = ufs_new_fragments(inode, p, lastfrag, ufs_data_ptr_to_cpu(sb, p),
 				new_size - (lastfrag & uspi->s_fpbmask), err,
-				locked_page);
+				&locked_folio->page);
 	return tmp != 0;
 }
 
@@ -413,7 +413,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 		unsigned tailfrags = lastfrag & uspi->s_fpbmask;
 		if (tailfrags && fragment >= lastfrag) {
 			if (!ufs_extend_tail(inode, fragment,
-					     &err, bh_result->b_page))
+					     &err, bh_result->b_folio))
 				goto out;
 		}
 	}
-- 
2.39.5


