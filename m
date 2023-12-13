Return-Path: <linux-fsdevel+bounces-5773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE380FBFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1071C20E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9441109;
	Wed, 13 Dec 2023 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U9peSLMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F45D6C;
	Tue, 12 Dec 2023 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UwHapak3vBQulaJ7TIdCjIPIffjzzG88sHPWPcNNZCs=; b=U9peSLMAz04+nMSU3oho06QOYI
	fWoMKrvnSOFxzbKN+VcM1cUdelGgkLxbhGwS7CCp9n+qnG6VaeshFVs90EmzoEO5oYsBNOnWDeBWy
	5CNnROPuDcazkkzeAx30dy8ttTD/V6ucVQSiAiO544LcVcPCHdLG6mH9lAQaVv8tObApuF2J7I90A
	qY6qtW9Unz5cgaU+MCShff32JkbI+GxhWYgXNN6C+QtCTF4LHbp9xq8nlL90cR6MKpNfA5vFbuF/s
	pOxAxERxrm3/1NVT1KL8hWHcnQjQH+Y4fwYwn+Y2ie8wTU6IOVAMpgc3SjQFE7djP9hcxQANXfyla
	E0Eaaujg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCny-00BX22-0u;
	Wed, 13 Dec 2023 00:08:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] minixfs: change the signature of dir_get_page()
Date: Wed, 13 Dec 2023 00:08:47 +0000
Message-Id: <20231213000849.2748576-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
References: <20231213000656.GI1674809@ZenIV>
 <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Change the signature of dir_get_page() in order to prepare this function
to the conversion to the use of kmap_local_page(). Change also those call
sites which are required to adjust to the new signature.

Essentially a copy of the corresponding fs/sysv commit by
Fabio M. De Francesco <fmdefrancesco@gmail.com>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/minix/dir.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 34a5d17f0796..4e5483adea40 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -70,13 +70,15 @@ static int minix_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-static struct page * dir_get_page(struct inode *dir, unsigned long n)
+static void *dir_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
+	if (IS_ERR(page))
+		return ERR_CAST(page);
+	kmap(page);
+	*p = page;
+	return page_address(page);
 }
 
 static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
@@ -104,11 +106,11 @@ static int minix_readdir(struct file *file, struct dir_context *ctx)
 
 	for ( ; n < npages; n++, offset = 0) {
 		char *p, *kaddr, *limit;
-		struct page *page = dir_get_page(inode, n);
+		struct page *page;
 
-		if (IS_ERR(page))
+		kaddr = dir_get_page(inode, n, &page);
+		if (IS_ERR(kaddr))
 			continue;
-		kaddr = (char *)page_address(page);
 		p = kaddr+offset;
 		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
 		for ( ; p <= limit; p = minix_next_entry(p, sbi)) {
@@ -173,11 +175,10 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 	for (n = 0; n < npages; n++) {
 		char *kaddr, *limit;
 
-		page = dir_get_page(dir, n);
-		if (IS_ERR(page))
+		kaddr = dir_get_page(dir, n, &page);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = (char*)page_address(page);
 		limit = kaddr + minix_last_byte(dir, n) - sbi->s_dirsize;
 		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
 			if (sbi->s_version == MINIX_V3) {
@@ -229,12 +230,10 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *limit, *dir_end;
 
-		page = dir_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto out;
+		kaddr = dir_get_page(dir, n, &page);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
 		lock_page(page);
-		kaddr = (char*)page_address(page);
 		dir_end = kaddr + minix_last_byte(dir, n);
 		limit = kaddr + PAGE_SIZE - sbi->s_dirsize;
 		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
@@ -286,7 +285,6 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	err = minix_handle_dirsync(dir);
 out_put:
 	dir_put_page(page);
-out:
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -375,11 +373,10 @@ int minix_empty_dir(struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *p, *kaddr, *limit;
 
-		page = dir_get_page(inode, i);
-		if (IS_ERR(page))
+		kaddr = dir_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = (char *)page_address(page);
 		limit = kaddr + minix_last_byte(inode, i) - sbi->s_dirsize;
 		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
 			if (sbi->s_version == MINIX_V3) {
@@ -441,15 +438,12 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 
 struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
 {
-	struct page *page = dir_get_page(dir, 0);
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
-	struct minix_dir_entry *de = NULL;
+	struct minix_dir_entry *de = dir_get_page(dir, 0, p);
 
-	if (!IS_ERR(page)) {
-		de = minix_next_entry(page_address(page), sbi);
-		*p = page;
-	}
-	return de;
+	if (!IS_ERR(de))
+		return minix_next_entry(de, sbi);
+	return NULL;
 }
 
 ino_t minix_inode_by_name(struct dentry *dentry)
-- 
2.39.2


