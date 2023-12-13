Return-Path: <linux-fsdevel+bounces-5790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2E8108A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5AC28236D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6448FBA3B;
	Wed, 13 Dec 2023 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rAxqk4d4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203AB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OQP9VIwa9XhJVR5DwN/a2Z+WS205zCtcf/mrHiOcKMQ=; b=rAxqk4d4TPNFRnJFgd4uk+ypXD
	z+McQdavbfTxkKQcPyxvQ/RtjX9gvExaOpjlPsb09X1H1wvBWPJAX72SqHsm2qbHnwIqxl1U7K8nw
	cYgxpOhiiElacqk6V/04P+6a3f8FKvtX+6A4KrvPIfuVwhKhREWXeDvBdSPHRVZaoWRY4F9qRCS/z
	xfoAvxajlbz4+0vUdpWpwEhCm74OnC7tGTLM1LYZZQVloDeqf3j2EdkbmtDX0fQgqFKZlqYzIisf/
	fjfj+mqLsHJh6NiWAH2h4iIwtNfWeyc/uPRn7a1b0HB+7m/Xgl3s5shwhZrpL9XYkWIZyPwihdIv7
	E0Z9jVRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlU-00Bbxo-0o;
	Wed, 13 Dec 2023 03:18:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 03/12] fs/ufs: Use ufs_put_page() in ufs_rename()
Date: Wed, 13 Dec 2023 03:18:18 +0000
Message-Id: <20231213031827.2767531-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
References: <20231213031639.GJ1674809@ZenIV>
 <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>

Use the ufs_put_page() helper in ufs_rename() instead of open-coding three
kunmap() + put_page().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/dir.c   | 2 +-
 fs/ufs/namei.c | 9 +++------
 fs/ufs/ufs.h   | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index b695eab0105a..2c9061ad3ab3 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -66,7 +66,7 @@ static int ufs_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-static inline void ufs_put_page(struct page *page)
+inline void ufs_put_page(struct page *page)
 {
 	kunmap(page);
 	put_page(page);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 9cad29463791..50dbe13d24d6 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -307,8 +307,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (old_dir != new_dir)
 			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
 		else {
-			kunmap(dir_page);
-			put_page(dir_page);
+			ufs_put_page(dir_page);
 		}
 		inode_dec_link_count(old_dir);
 	}
@@ -317,12 +316,10 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 out_dir:
 	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
+		ufs_put_page(dir_page);
 	}
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	ufs_put_page(old_page);
 out:
 	return err;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 6b499180643b..4594cbe6b2e0 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -98,6 +98,7 @@ extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, uns
 extern void ufs_put_cylinder (struct super_block *, unsigned);
 
 /* dir.c */
+extern void ufs_put_page(struct page *page);
 extern const struct inode_operations ufs_dir_inode_operations;
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
-- 
2.39.2


