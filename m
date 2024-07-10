Return-Path: <linux-fsdevel+bounces-23495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3C92D599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA50289C48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49872194A65;
	Wed, 10 Jul 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f46o4KzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA0194A74
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627192; cv=none; b=ZZs2SfZtlzUunWIbJnOJ8XnpzGfmXGU0gAQ/M6nl5wfB1HpOfnB35fn9MCLgVjfewlfl6pioAn+sU1iMAHvXMfDdnS06tGJWanPLn7jtLBAgsYaUTybmHsAAmmBRM5CD5SmsfVDcy6FHZOB52xH5sBPkTFAqwEUzQTUq3k+vH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627192; c=relaxed/simple;
	bh=ZNebr72dGtfqAT2j6SI0Wj0vmnAdOESWNt/ppyp9hyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHKAgakG2dmaWYlEAYbuqVvQREu0+YlaNhgJLlYoIjZT90Ok9XrcPJMtf230E5ZwcH49lB6lbX4DpWfBEHOWP8gDgqfHY0u+Ho/JBlTHOS3UaejCI9uHVkDxwAspSU7nFqOrcqQQaDeRXcfL0PgTv9gJHHKcd8Dk5taEXwiPHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f46o4KzH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=geNJDYizzVe7uczLBIwosTrAFDv3LpwFIoF3VABHvds=; b=f46o4KzH+f/wtZbqsRf3gNDCiT
	ioDPhDdRN9t9c7dqk6NFH0KZbOTGj8jiWo/Z6BK1MyuAAuOyWQDgQ/pJNMmmgKvKiIATbaMbE45E8
	eZsfTwFrMTUybmrKcJuS//ock+NTMwJcDNY5a8Dx0oC5q1glgKQntFKFtHBmYy7Lqm79NFNxFx2R2
	riftOtjZissY+D6QYw7Prufs9E/LV6NWVL0oGRt8qcxfIN0fnT0iuU5578Gd4mAleThXMO3ibrtLl
	+eIX1aOX/V4cUUS9YFb9Nk/xy10OmWqr4Ls3bfkCCB4cKDZrLO9dfl7N6HkrwJCMHRYwDdOy4iqAm
	zqSe3F3w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjR-00000009TEb-1fBc;
	Wed, 10 Jul 2024 15:59:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/6] qnx6: Convert qnx6_iget() to use a folio
Date: Wed, 10 Jul 2024 16:59:43 +0100
Message-ID: <20240710155946.2257293-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a use of kmap() and a couple of conversions between folios and
pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/qnx6/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 6adee850278e..85925ec0051a 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -518,7 +518,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	struct inode *inode;
 	struct qnx6_inode_info	*ei;
 	struct address_space *mapping;
-	struct page *page;
+	struct folio *folio;
 	u32 n, offs;
 
 	inode = iget_locked(sb, ino);
@@ -538,17 +538,16 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 		return ERR_PTR(-EIO);
 	}
 	n = (ino - 1) >> (PAGE_SHIFT - QNX6_INODE_SIZE_BITS);
-	offs = (ino - 1) & (~PAGE_MASK >> QNX6_INODE_SIZE_BITS);
 	mapping = sbi->inodes->i_mapping;
-	page = read_mapping_page(mapping, n, NULL);
-	if (IS_ERR(page)) {
+	folio = read_mapping_folio(mapping, n, NULL);
+	if (IS_ERR(folio)) {
 		pr_err("major problem: unable to read inode from dev %s\n",
 		       sb->s_id);
 		iget_failed(inode);
-		return ERR_CAST(page);
+		return ERR_CAST(folio);
 	}
-	kmap(page);
-	raw_inode = ((struct qnx6_inode_entry *)page_address(page)) + offs;
+	offs = offset_in_folio(folio, (ino - 1) << QNX6_INODE_SIZE_BITS);
+	raw_inode = kmap_local_folio(folio, offs);
 
 	inode->i_mode    = fs16_to_cpu(sbi, raw_inode->di_mode);
 	i_uid_write(inode, (uid_t)fs32_to_cpu(sbi, raw_inode->di_uid));
@@ -578,7 +577,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 		inode->i_mapping->a_ops = &qnx6_aops;
 	} else
 		init_special_inode(inode, inode->i_mode, 0);
-	qnx6_put_page(page);
+	folio_release_kmap(folio, raw_inode);
 	unlock_new_inode(inode);
 	return inode;
 }
-- 
2.43.0


