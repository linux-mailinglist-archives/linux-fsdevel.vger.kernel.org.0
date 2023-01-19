Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94489673D8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjASPdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjASPcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477C4860E;
        Thu, 19 Jan 2023 07:32:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1540802wms.2;
        Thu, 19 Jan 2023 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeQOnDIxishoqUV4xglLQiul2G5rA5E2GtpDLgQ/xtI=;
        b=hZCyTB3tpMJD3NpXlMKptkshlqv03DD7UjDhH1qJOE5ooZjATD0MnP+boQDSJUGpAO
         avHNPHhG4IT3ap5Vr9Og+s0XJq7aPpX569rRKeYY0uIh7O+FbAQrsmDaut0h9N3drl+X
         hTtQI/7egycruLQFLrKSdYCqcBx81YGPBCh1xKsT57LuZhAy4a0q+hJuJoofSzM9wbae
         2/ayrVm3IKx/3s99RCl1CgCGSJfPqEQINoh7jPu69+ip1tQsq5yKPRgQhzwoSoZnXZ8D
         ZeVlySVVjbakzrGR1JRrjLniXGihLpnU6iXybvtuUsFz1+T2DgyDA34es4RQYY0qLspd
         Mn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeQOnDIxishoqUV4xglLQiul2G5rA5E2GtpDLgQ/xtI=;
        b=Y+vmRQcVXdTgZBWYTiwOnbELp8FgFRNUs/tkEwl2jBA7R5LwDBJO5BRCLU+D6d37WI
         bMZ9y1cN2sIaVkHMWmcW6p/XuC31TWceFCtiuGzW13rkEWF4M0qReLRGgyawyNu3MXoI
         FhFYS7ly2IhS1tf9Z35ZPRKo8Ed909tBxLN8Nu0HWv67geWnjacPBh0rY8mg3FaZjLYb
         NLPJOcfV53b/G+vV+fSEmyuFQ8VD5ImpCINzWaR6hiPTlNlSB3augZUJLaZ3X1ZR2/7h
         SGHm372WstoQngKUj13z2xaE1p75EiSro3loHuMhAvEL0nu68uwLokj0mHxJbLE26sSU
         vQqA==
X-Gm-Message-State: AFqh2krhk5y12CRAKB6JWvLJBtqtWiXgwt+GGQMQt9YLoch9ynssd6w/
        kTFgxNxWSTBdm7wVJaeNb60=
X-Google-Smtp-Source: AMrXdXv+Fi+1mBj5wi/UO26kiYD5FEtovE8oYpwn38UhlLHhQkDh0cBO77nbGvm2i60HzCWyJHL7WQ==
X-Received: by 2002:a05:600c:1e1d:b0:3cf:674a:aefe with SMTP id ay29-20020a05600c1e1d00b003cf674aaefemr10731038wmb.22.1674142362579;
        Thu, 19 Jan 2023 07:32:42 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003cfd4e6400csm5827815wms.19.2023.01.19.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:32:41 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Thu, 19 Jan 2023 16:32:32 +0100
Message-Id: <20230119153232.29750-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119153232.29750-1-fmdefrancesco@gmail.com>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
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

Since kmap_local_page() would not break the strict rules of local mappings
(i.e., the thread locality and the stack based nesting), this function can
be easily and safely replace the deprecated API.

Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local()
requires the mapping address, so return that address from dir_get_page()
to be used in dir_put_page().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c   | 62 +++++++++++++++++++++++++++++++++----------------
 fs/sysv/namei.c |  4 ++--
 fs/sysv/sysv.h  |  2 +-
 3 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 2e35b95d3efb..0a83a01862f3 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -28,9 +28,9 @@ const struct file_operations sysv_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
-inline void dir_put_page(struct page *page)
+inline void dir_put_page(struct page *page, void *page_addr)
 {
-	kunmap(page);
+	kunmap_local(page_addr);
 	put_page(page);
 }
 
@@ -52,15 +52,21 @@ static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
+/*
+ * Calls to dir_get_page()/dir_put_page() must be nested according to the
+ * rules documented in mm/highmem.rst.
+ *
+ * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_page()
+ * and must be treated accordingly for nesting purposes.
+ */
 static void *dir_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
-	kmap(page);
 	*p = page;
-	return page_address(page);
+	return kmap_local_page(page);
 }
 
 static int sysv_readdir(struct file *file, struct dir_context *ctx)
@@ -98,11 +104,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
 					fs16_to_cpu(SYSV_SB(sb), de->inode),
 					DT_UNKNOWN)) {
-				dir_put_page(page);
+				dir_put_page(page, kaddr);
 				return 0;
 			}
 		}
-		dir_put_page(page);
+		dir_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -125,6 +131,11 @@ static inline int namecompare(int len, int maxlen,
  * returns the cache buffer in which the entry was found, and the entry
  * itself (as a parameter - res_dir). It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
+ *
+ * On Success dir_put_page() should be called on *res_page.
+ *
+ * sysv_find_entry() acts as a call to dir_get_page() and must be treated
+ * accordingly for nesting purposes.
  */
 struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_page)
 {
@@ -156,7 +167,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 							name, de->name))
 					goto found;
 			}
-			dir_put_page(page);
+			dir_put_page(page, kaddr);
 		}
 
 		if (++n >= npages)
@@ -199,7 +210,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 				goto out_page;
 			de++;
 		}
-		dir_put_page(page);
+		dir_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -217,7 +228,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 out_page:
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -228,6 +239,12 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	loff_t pos = page_offset(page) + offset_in_page(de);
+	/*
+	 * The "de" dentry points somewhere in the same page whose we need the
+	 * address of; therefore, we can simply get the base address "kaddr" by
+	 * masking the previous with PAGE_MASK.
+	 */
+	char *kaddr = (char *)((unsigned long)de & PAGE_MASK);
 	int err;
 
 	lock_page(page);
@@ -235,7 +252,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 	BUG_ON(err);
 	de->inode = 0;
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 	return err;
@@ -255,9 +272,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 		unlock_page(page);
 		goto fail;
 	}
-	kmap(page);
-
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct sysv_dir_entry *) base;
@@ -267,7 +282,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
 	strcpy(de->name,"..");
 
-	kunmap(page);
+	kunmap_local(base);
 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
 fail:
 	put_page(page);
@@ -282,10 +297,10 @@ int sysv_empty_dir(struct inode * inode)
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
+	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
-		struct sysv_dir_entry * de;
+		struct sysv_dir_entry *de;
 
 		kaddr = dir_get_page(inode, i, &page);
 		if (IS_ERR(kaddr))
@@ -309,12 +324,12 @@ int sysv_empty_dir(struct inode * inode)
 			if (de->name[1] != '.' || de->name[2])
 				goto not_empty;
 		}
-		dir_put_page(page);
+		dir_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	return 0;
 }
 
@@ -331,11 +346,18 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	BUG_ON(err);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	dir_put_page(page, de);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
 
+/*
+ * Calls to dir_get_page()/dir_put_page() must be nested according to the
+ * rules documented in mm/highmem.rst.
+ *
+ * sysv_dotdot() acts as a call to dir_get_page() and must be treated
+ * accordingly for nesting purposes.
+ */
 struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 {
 	struct sysv_dir_entry *de = dir_get_page(dir, 0, p);
@@ -354,7 +376,7 @@ ino_t sysv_inode_by_name(struct dentry *dentry)
 	
 	if (de) {
 		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
-		dir_put_page(page);
+		dir_put_page(page, de);
 	}
 	return res;
 }
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index 981c1d76f342..371cf9012052 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -251,9 +251,9 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 out_dir:
 	if (dir_de)
-		dir_put_page(dir_page);
+		dir_put_page(dir_page, dir_de);
 out_old:
-	dir_put_page(old_page);
+	dir_put_page(old_page, old_de);
 out:
 	return err;
 }
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index b250ac1dd348..50f19bfd8d10 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -148,7 +148,7 @@ extern void sysv_destroy_icache(void);
 
 
 /* dir.c */
-extern void dir_put_page(struct page *page);
+extern void dir_put_page(struct page *page, void *vaddr);
 extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
 extern int sysv_add_link(struct dentry *, struct inode *);
 extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
-- 
2.39.0

