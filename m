Return-Path: <linux-fsdevel+bounces-5788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60A81089F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B66B21024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39D63C7;
	Wed, 13 Dec 2023 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dh35lbe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68F8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fx95EkwWz1mt4+AaZxFljby7hee95+tcGnGk7TC6CmE=; b=dh35lbe9Btl0zk/y86LVD1CZPd
	Vi8be388xwcj1YiNcROgcYguDXOiS6J3UKbvDB67aLywzJRLqTGmumY4sb24rW0C7e4on9EDAKBVy
	Gl+H9VQyC0qAlRdJMNW+r1BxdT2YQ4XKL+aX1KVtli4dF+qLqROKGs239fFOCMUQk5FFp6v/EGA5J
	+Z4rrAavQjdAHcIU7YJDCAiwiXicwFg8cdXXnlOJjxA4EFKhS4f7cdRrR8mCdlDpSoKDY5RnRFECA
	g/VCciOiExL1IbubSHAKB3knC4q4FzSO7gR9+89scRFIXmTAGMFEPMHPLNVgNIRjsfIZvwKk6NsF3
	tX3VKJCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlT-00Bbxi-2f;
	Wed, 13 Dec 2023 03:18:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 01/12] fs/ufs: Use the offset_in_page() helper
Date: Wed, 13 Dec 2023 03:18:16 +0000
Message-Id: <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213031639.GJ1674809@ZenIV>
References: <20231213031639.GJ1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>

Use the offset_in_page() helper because it is more suitable than doing
explicit subtractions between pointers to directory entries and kernel
virtual addresses of mapped pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 27c85d92d1dc..5be536fe0e3f 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -92,8 +92,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 		  struct page *page, struct inode *inode,
 		  bool update_times)
 {
-	loff_t pos = page_offset(page) +
-			(char *) de - (char *) page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
 	int err;
 
@@ -377,8 +376,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + offset_in_page(de);
 	err = ufs_prepare_chunk(page, pos, rec_len);
 	if (err)
 		goto out_unlock;
@@ -504,8 +502,8 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 {
 	struct super_block *sb = inode->i_sb;
 	char *kaddr = page_address(page);
-	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
-	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
+	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
+	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
 	struct ufs_dir_entry *pde = NULL;
 	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
@@ -529,7 +527,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		de = ufs_next_entry(sb, de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
+		from = offset_in_page(pde);
 
 	pos = page_offset(page) + from;
 	lock_page(page);
-- 
2.39.2


