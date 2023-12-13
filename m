Return-Path: <linux-fsdevel+bounces-5772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FEA80FBF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF71F213D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2FA5E;
	Wed, 13 Dec 2023 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A01MbGvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E28D6E;
	Tue, 12 Dec 2023 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rvXeUqtEC+dRyenBVr0uZJ7uutUWHkARWVLiznoStTU=; b=A01MbGvsdycCUVwNSggJnOKrG4
	FnmZb47R5fhWo6XRI14Jr6Np34m/QSuOOAZDAloM8Lfuon9BQ4FFZzXWRLpMNpt0Iz87M5sNXfLwj
	bJAxA5OHeil8MPxAZUWE/pv3iGvehTekO4ajOEKWEO5cvLHtzWWKheEUN6k2yvWmxZ7gEJXeCL7ET
	Hgio+iMND7jL3aL+z6hwDFmUzyrP9/WlkIG5gxJYiSsKBANG6KRwVLyBtgfbW9XnMILBx2Et53QTI
	ThVPU10apMf0y2ezAWTHbm2aBVISQha1kwpVNV6gG17d4JjLKL1N/DLXo+OS7D8yWBbTQ+qPPLBNA
	WIN80OCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCny-00BX29-1d;
	Wed, 13 Dec 2023 00:08:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] minixfs: switch to kmap_local_page()
Date: Wed, 13 Dec 2023 00:08:49 +0000
Message-Id: <20231213000849.2748576-4-viro@zeniv.linux.org.uk>
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

Again, a counterpart of Fabio's fs/sysv patch

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/minix/dir.c   | 27 +++++++++++++--------------
 fs/minix/minix.h |  5 -----
 fs/minix/namei.c |  6 +++---
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index ccb6c47fd7fe..a224cf222570 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -70,9 +70,8 @@ static void *dir_get_page(struct inode *dir, unsigned long n, struct page **p)
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
-	kmap(page);
 	*p = page;
-	return page_address(page);
+	return kmap_local_page(page);
 }
 
 static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
@@ -123,13 +122,13 @@ static int minix_readdir(struct file *file, struct dir_context *ctx)
 				unsigned l = strnlen(name, sbi->s_namelen);
 				if (!dir_emit(ctx, name, l,
 					      inumber, DT_UNKNOWN)) {
-					dir_put_page(page);
+					unmap_and_put_page(page, p);
 					return 0;
 				}
 			}
 			ctx->pos += chunk_size;
 		}
-		dir_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -189,7 +188,7 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 			if (namecompare(namelen, sbi->s_namelen, name, namx))
 				goto found;
 		}
-		dir_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return NULL;
 
@@ -255,7 +254,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 				goto out_unlock;
 		}
 		unlock_page(page);
-		dir_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -278,7 +277,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	err = minix_handle_dirsync(dir);
 out_put:
-	dir_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -324,7 +323,7 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
 		goto fail;
 	}
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memset(kaddr, 0, PAGE_SIZE);
 
 	if (sbi->s_version == MINIX_V3) {
@@ -344,7 +343,7 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
 		de->inode = dir->i_ino;
 		strcpy(de->name, "..");
 	}
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
 	err = minix_handle_dirsync(inode);
@@ -361,11 +360,11 @@ int minix_empty_dir(struct inode * inode)
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
-	char *name;
+	char *name, *kaddr;
 	__u32 inumber;
 
 	for (i = 0; i < npages; i++) {
-		char *p, *kaddr, *limit;
+		char *p, *limit;
 
 		kaddr = dir_get_page(inode, i, &page);
 		if (IS_ERR(kaddr))
@@ -396,12 +395,12 @@ int minix_empty_dir(struct inode * inode)
 					goto not_empty;
 			}
 		}
-		dir_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	dir_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return 0;
 }
 
@@ -455,7 +454,7 @@ ino_t minix_inode_by_name(struct dentry *dentry)
 			res = ((minix3_dirent *) de)->inode;
 		else
 			res = de->inode;
-		dir_put_page(page);
+		unmap_and_put_page(page, de);
 	}
 	return res;
 }
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index cb42b6cf7909..d493507c064f 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -64,11 +64,6 @@ extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
 extern unsigned V1_minix_blocks(loff_t, struct super_block *);
 extern unsigned V2_minix_blocks(loff_t, struct super_block *);
 
-static inline void dir_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
 extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct page**);
 extern int minix_add_link(struct dentry*, struct inode*);
 extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 20923a15e30a..d6031acc34f0 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -149,7 +149,7 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 	if (!de)
 		return -ENOENT;
 	err = minix_delete_entry(de, page);
-	dir_put_page(page);
+	unmap_and_put_page(page, de);
 
 	if (err)
 		return err;
@@ -242,9 +242,9 @@ static int minix_rename(struct mnt_idmap *idmap,
 	}
 out_dir:
 	if (dir_de)
-		dir_put_page(dir_page);
+		unmap_and_put_page(dir_page, dir_de);
 out_old:
-	dir_put_page(old_page);
+	unmap_and_put_page(old_page, old_de);
 out:
 	return err;
 }
-- 
2.39.2


