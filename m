Return-Path: <linux-fsdevel+bounces-5798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A58108A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC4B1C20DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E136DDAE;
	Wed, 13 Dec 2023 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OnmCZyrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5178B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=HHK9iip+14M2GQ6l0cD6JdJ+QVtnx8uqkwMXlEigi+Y=; b=OnmCZyrDsx3ytauLM8Ot2U83XA
	Kw9EiqswB39WK/qpLAA1ECWHCWAkhqyA6PZxpNaoNAEv3Nr/t2uP+n6zteRJYDONaZ44v/P6dhy7T
	+vpV5wLtqss3zgyxDJpOs4WePONz/HVnaDq5me5vmzpZiFXVIQb0v6q/04b9lZ0uWOSzSQ7Jfinvv
	lGMW4AUHxj2mctCjRQnBR9jA+X+rUvSy4blOM3U+N0ujVBqCV3kIWd/fCx94bL55ahzVoW8Hy6vrE
	22/CH1pVCAkXLi63X7IdWiStqFpB39DnGaxuTxfmA1n4oEF3Ken4dJYhl2p2/Z0Vjb6FZiuEXjAT4
	AWB8gKHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlU-00Bbxs-1U;
	Wed, 13 Dec 2023 03:18:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 04/12] fs/ufs: Replace kmap() with kmap_local_page()
Date: Wed, 13 Dec 2023 03:18:19 +0000
Message-Id: <20231213031827.2767531-4-viro@zeniv.linux.org.uk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

The use of kmap_local_page() in fs/ufs is "safe" because (1) the kernel
virtual addresses are exclusively re-used by the thread which
established the mappings (i.e., thread locality is never violated) and (2)
the nestings of mappings and un-mappings are always stack based (LIFO).

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
and use it as parameter for the second argument of ufs_put_page().

[AV: replaced ufs_put_page() with unmap_and_put() - there's nothing
ufs-specific about it]

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/dir.c   | 74 +++++++++++++++++++++++++++++++-------------------
 fs/ufs/namei.c | 11 ++++----
 fs/ufs/ufs.h   |  1 -
 3 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 2c9061ad3ab3..fcf13e3ca869 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -66,12 +66,6 @@ static int ufs_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-inline void ufs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 {
 	ino_t res = 0;
@@ -81,7 +75,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	de = ufs_find_entry(dir, qstr, &page);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(page);
+		unmap_and_put_page(page, de);
 	}
 	return res;
 }
@@ -104,7 +98,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	ufs_commit_chunk(page, pos, len);
-	ufs_put_page(page);
+	unmap_and_put_page(page, de);
 	if (update_times)
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
@@ -112,11 +106,10 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 }
 
 
-static bool ufs_check_page(struct page *page)
+static bool ufs_check_page(struct page *page, char *kaddr)
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
-	char *kaddr = page_address(page);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_SIZE;
 	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
@@ -191,23 +184,32 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
+/*
+ * Calls to ufs_get_page()/unmap_and_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
+ * and must be treated accordingly for nesting purposes.
+ */
 static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
+	char *kaddr;
+
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
-		kmap(page);
+		kaddr = kmap_local_page(page);
 		if (unlikely(!PageChecked(page))) {
-			if (!ufs_check_page(page))
+			if (!ufs_check_page(page, kaddr))
 				goto fail;
 		}
 		*p = page;
-		return page_address(page);
+		return kaddr;
 	}
 	return ERR_CAST(page);
 
 fail:
-	ufs_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return ERR_PTR(-EIO);
 }
 
@@ -233,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 					fs16_to_cpu(sb, p->d_reclen));
 }
 
+/*
+ * Calls to ufs_get_page()/unmap_and_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
+ */
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
 	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
@@ -250,6 +259,11 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
  * returns the page in which the entry was found, and the entry itself
  * (as a parameter - res_dir). Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
+ *
+ * On Success unmap_and_put_page() should be called on *res_page.
+ *
+ * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
  */
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 				     struct page **res_page)
@@ -288,7 +302,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(page);
+			unmap_and_put_page(page, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -366,7 +380,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
 		unlock_page(page);
-		ufs_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -397,7 +411,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	err = ufs_handle_dirsync(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -475,13 +489,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(page);
+					unmap_and_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -492,10 +506,15 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
  * previous entry.
  */
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
-		     struct page * page)
+		     struct page *page)
 {
 	struct super_block *sb = inode->i_sb;
-	char *kaddr = page_address(page);
+	/*
+	 * The "dir" dentry points somewhere in the same page whose we need the
+	 * address of; therefore, we can simply get the base address "kaddr" by
+	 * masking the previous with PAGE_MASK.
+	 */
+	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
 	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
@@ -535,7 +554,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
 out:
-	ufs_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	UFSD("EXIT\n");
 	return err;
 }
@@ -559,8 +578,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 		goto fail;
 	}
 
-	kmap(page);
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct ufs_dir_entry *) base;
@@ -577,7 +595,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	kunmap(page);
+	kunmap_local(base);
 
 	ufs_commit_chunk(page, 0, chunk_size);
 	err = ufs_handle_dirsync(inode);
@@ -594,9 +612,9 @@ int ufs_empty_dir(struct inode * inode)
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
+	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct ufs_dir_entry *de;
 
 		kaddr = ufs_get_page(inode, i, &page);
@@ -629,12 +647,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return 0;
 }
 
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 50dbe13d24d6..25fa97340f73 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -250,7 +250,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct page *dir_page = NULL;
-	struct ufs_dir_entry * dir_de = NULL;
+	struct ufs_dir_entry *dir_de = NULL;
 	struct page *old_page;
 	struct ufs_dir_entry *old_de;
 	int err = -ENOENT;
@@ -307,7 +307,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (old_dir != new_dir)
 			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
 		else {
-			ufs_put_page(dir_page);
+			unmap_and_put_page(dir_page, dir_de);
 		}
 		inode_dec_link_count(old_dir);
 	}
@@ -315,11 +315,10 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 
 out_dir:
-	if (dir_de) {
-		ufs_put_page(dir_page);
-	}
+	if (dir_de)
+		unmap_and_put_page(dir_page, dir_de);
 out_old:
-	ufs_put_page(old_page);
+	unmap_and_put_page(old_page, old_de);
 out:
 	return err;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 4594cbe6b2e0..6b499180643b 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -98,7 +98,6 @@ extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, uns
 extern void ufs_put_cylinder (struct super_block *, unsigned);
 
 /* dir.c */
-extern void ufs_put_page(struct page *page);
 extern const struct inode_operations ufs_dir_inode_operations;
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
-- 
2.39.2


