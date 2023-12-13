Return-Path: <linux-fsdevel+bounces-5771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087B80FBF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325DE1C20D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C473819;
	Wed, 13 Dec 2023 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ssFYiY+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB6D69;
	Tue, 12 Dec 2023 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FR4Bu1shg/1OWRZtkrUGIBB3IegyXrsoJGzrPQwNckk=; b=ssFYiY+Cz+KBWgVJ8B4d/3gkXn
	kdaPXjvqWiMyWeNeW415BxuXaOWZr/rvcir6rjSIoi3+3+lILgmATZ+W4bxcDxpbUJecBraaiNNjy
	hs6OMshEfgHBMffYJg9yaunRID73USie1VzRAZWF6e58h9C+/gJyZTrKVFAW6ty9obhyjJHYaTTBr
	5lx++i3OL+RVyNGUqQRkgB0MXkurp+x0zQ5+apPumm5oVu1FBjZW6eUBbM3V9ODiWQF7pE9pH4R2K
	yYFjgvhyQJ9puJPYM1270dYvEnmZQoEaYZHvcjmbcjR5lvDvT2xZxSMzV7WaL80TaY/EFwqpfuIUE
	Ar8BllQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCny-00BX1z-04;
	Wed, 13 Dec 2023 00:08:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] minixfs: use offset_in_page()
Date: Wed, 13 Dec 2023 00:08:46 +0000
Message-Id: <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000656.GI1674809@ZenIV>
References: <20231213000656.GI1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It's cheaper and more idiomatic than subtracting page_address()
of the corresponding page...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/minix/dir.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 62c313fc9a49..34a5d17f0796 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -268,7 +268,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) + p - (char *)page_address(page);
+	pos = page_offset(page) + offset_in_page(p);
 	err = minix_prepare_chunk(page, pos, sbi->s_dirsize);
 	if (err)
 		goto out_unlock;
@@ -296,8 +296,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = page_address(page);
-	loff_t pos = page_offset(page) + (char*)de - kaddr;
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	unsigned len = sbi->s_dirsize;
 	int err;
@@ -421,8 +420,7 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 {
 	struct inode *dir = page->mapping->host;
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
-- 
2.39.2


