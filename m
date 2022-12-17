Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DB64FBA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 19:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLQSsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 13:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiLQSsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:48:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3FDFB4;
        Sat, 17 Dec 2022 10:48:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so3852103wml.4;
        Sat, 17 Dec 2022 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff3j5au/gpQ72wWKY1ty9HHyftxGy5cfKV/c2Zaa72A=;
        b=aNQD1P1SKnaojV1E7zxWra/NYDEgudyiYLzSJ13k5WcuAofqwSqfDptWC+6GqrUcEE
         xbh8fynZ1FC7xERi5zaqOsvsyH7P6cfg7vkce48AyJdnNqin30ZYmgOd++jGrZQ7bDlp
         84ygIxTrczGwVGIMIO5R2d0rKiI9nUofGv7r9wjRgIbai4qpdxqdJ2OL+jitNwNFFKkq
         HF68J+ttwfvPUoltI/ssLCrrNfzh0Vc3KkNglmRVDXMq0FIxfKTFQPIF7/IRiuPr4yN0
         pvApyhXJ7x0ZYJ7q58dgcUuiQ94qs6KsZvGUZghtEw1bXY4MDBAipszt7Ww+TEEm8s3V
         f+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ff3j5au/gpQ72wWKY1ty9HHyftxGy5cfKV/c2Zaa72A=;
        b=Uty1ZZfTtR7E2dPiAm+aRDYgGvLR38PnB8nVTTfQS/fXhxGCayb23YMCpHae2jIS4l
         XD3FR312P3XVfpCyPLYEQyMKtYfuLdeyicYQcJDcDLltHERGwEgXnr9UDnJVkKSwLiUm
         EcqQGAHm5Qgp3q8KiK5Q2J+Cz/TTrrHIfKdfW7oLO7joqrv5QOqV3ITmlifVbetprBLd
         RETmlqZC3WPNn+RGevxy+8WUTJ22mbEkpQfLrVjDc7ZPS2QiHpIe7nmQ0oXBAlZBosdT
         rQZrDsLsuskvxf8PT3Tv2Eg627tg/y9YiVoP+n8luqsKzwfYXOoWPGIazGuyRX8BSlNZ
         3tPQ==
X-Gm-Message-State: ANoB5pmQtW3SEibmKku71fkQHV3H/BjC+QleIRpphx/XWQGiviVNHWTh
        hSJYxRH/AH1+jrJ+UZCAb3o=
X-Google-Smtp-Source: AA0mqf5R/n26a5fNZrkb/RFkgoBwc0LMauwOHeSmhcxcwhUOxPRfnXuAkX1lHPwZ47P2FQ6H95wTWA==
X-Received: by 2002:a05:600c:384e:b0:3cf:ae53:b1e0 with SMTP id s14-20020a05600c384e00b003cfae53b1e0mr28393402wmr.9.1671302887211;
        Sat, 17 Dec 2022 10:48:07 -0800 (PST)
Received: from localhost.localdomain (host-79-17-30-229.retail.telecomitalia.it. [79.17.30.229])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b003b4935f04a4sm7726062wmi.5.2022.12.17.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 10:48:06 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Sat, 17 Dec 2022 19:47:49 +0100
Message-Id: <20221217184749.968-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221217184749.968-1-fmdefrancesco@gmail.com>
References: <20221217184749.968-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 75 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 9fa86614d2d1..a9dd5023b604 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static inline void ufs_put_page(struct page *page)
+static inline void ufs_put_page(struct page *page, void *page_addr)
 {
-	kunmap(page);
+	kunmap((void *)((unsigned long)page_addr & PAGE_MASK));
 	put_page(page);
 }
 
@@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	de = ufs_find_entry(dir, qstr, &page);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(page);
+		ufs_put_page(page, de);
 	}
 	return res;
 }
@@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	err = ufs_commit_chunk(page, pos, len);
-	ufs_put_page(page);
+	ufs_put_page(page, de);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
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
@@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
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
+	ufs_put_page(page, kaddr);
 	return ERR_PTR(-EIO);
 }
 
@@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 					fs16_to_cpu(sb, p->d_reclen));
 }
 
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
+ */
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
 	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
@@ -238,12 +253,15 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 }
 
 /*
- *	ufs_find_entry()
+ * Finds an entry in the specified directory with the wanted name. It returns a
+ * pointer to the directory's entry. The page in which the entry was found is
+ * in the res_page out parameter. The page is returned mapped and unlocked.
+ * The entry is guaranteed to be valid.
  *
- * finds an entry in the specified directory with the wanted name. It
- * returns the page in which the entry was found, and the entry itself
- * (as a parameter - res_dir). Page is returned mapped and unlocked.
- * Entry is guaranteed to be valid.
+ * On Success ufs_put_page() should be called on *res_page.
+ *
+ * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
  */
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 				     struct page **res_page)
@@ -282,7 +300,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(page);
+			ufs_put_page(page, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -360,7 +378,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
 		unlock_page(page);
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -390,7 +408,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -468,13 +486,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(page);
+					ufs_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -485,10 +503,10 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
  * previous entry.
  */
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
-		     struct page * page)
+		     struct page *page)
 {
 	struct super_block *sb = inode->i_sb;
-	char *kaddr = page_address(page);
+	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
 	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
@@ -527,7 +545,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 out:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	UFSD("EXIT\n");
 	return err;
 }
@@ -551,8 +569,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 		goto fail;
 	}
 
-	kmap(page);
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct ufs_dir_entry *) base;
@@ -569,7 +586,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	kunmap(page);
+	kunmap_local(base);
 
 	err = ufs_commit_chunk(page, 0, chunk_size);
 fail:
@@ -585,9 +602,9 @@ int ufs_empty_dir(struct inode * inode)
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
+	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct ufs_dir_entry *de;
 
 		kaddr = ufs_get_page(inode, i, &page);
@@ -620,12 +637,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return 0;
 }
 
-- 
2.39.0

