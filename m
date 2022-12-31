Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE57E65A325
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 08:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiLaH5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 02:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiLaH5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:57:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861EE0C;
        Fri, 30 Dec 2022 23:57:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so14682569wms.0;
        Fri, 30 Dec 2022 23:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcSze+U7PfTyjTQa3rm6f69rHENmMnX7aW5kNhZMEAo=;
        b=a/l98VSRyAGoTPGUzjPt62kx2BRR55noi+PjympWB+j+H5ge7OhmeGWPw5Vv35ipam
         vP04+gNteF4gLtYq5gsI8Vm2sMxi+Z3SS+kW0MCTF9Gj9fK/CHSgmjuZYdfjlNrwSPmq
         DAJy8+Dkxy895Ecwlsl2QikEUch0s/+9LAh+vP43qFYLAqNBNgEtWAjNkrruRJmKcu8Y
         X4WRBAc1VuGzrVTrepvBdgN0hyosuE1sSNWVd2ZhPhJAjMvQYmEQWE63EnF73gqRrG3E
         rSPAV7hf6OdCQgHOxOTEYE9gcq0RCcWwtPWIbpga7fZyA4NjuGLD7oxhpxqkO4u1k6FZ
         puWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcSze+U7PfTyjTQa3rm6f69rHENmMnX7aW5kNhZMEAo=;
        b=LnDWIkZE5fKprARpnEHSCq+J9FQH4QJcJ9rYz05AQWD+nxuQxN/sDhTZUupCyPbfgn
         cR6hIW0brcavxJ6aPJ0YHXGfS4x1EVQqx1Oqe4Ar/krBuGVWufLWD/S4tn8bTD0QfGjC
         6YVFfXaR+j9N6112OO+kG2goi9kz9Wype32baxzlqQzXwG0FB/FQq1koTZ+koHkAE7FR
         VPvQzIJE967e+YMnlVQprfTeSLV90z2npMmX5sgL4wY5SKKD6lDZ3Xf2MYT55CXO7W1s
         l6WnRqmIRdm82iWCjMEu860YG+3a2NTeKd/0rKdNb/TddoeFry1PfZHFFVfEOPvLddMj
         S3/g==
X-Gm-Message-State: AFqh2koYJ7ugSxeqNd6P4tRfpCjk2K2Zq/mYQFdlnBy8Hnj4wuKkYrtU
        Vb8jHRd61S7F4KUImmNGyB8=
X-Google-Smtp-Source: AMrXdXuHwn9zIhuW1y8j/MLIO5XBTVYw+EQXmN9nfTxbIKv1MGiFoCJeevaIp1pWo26vRw0iVpbnqQ==
X-Received: by 2002:a05:600c:13ca:b0:3d3:4427:dfbf with SMTP id e10-20020a05600c13ca00b003d34427dfbfmr23804176wmg.5.1672473448748;
        Fri, 30 Dec 2022 23:57:28 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm39389232wms.11.2022.12.30.23.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:57:27 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Sat, 31 Dec 2022 08:57:17 +0100
Message-Id: <20221231075717.10258-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231075717.10258-1-fmdefrancesco@gmail.com>
References: <20221231075717.10258-1-fmdefrancesco@gmail.com>
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
 fs/sysv/dir.c   | 64 +++++++++++++++++++++++++++++++++----------------
 fs/sysv/namei.c |  4 ++--
 fs/sysv/sysv.h  |  2 +-
 3 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index a37747e9e9a3..ab409aa24757 100644
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
@@ -200,7 +211,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 				goto out_page;
 			de++;
 		}
-		dir_put_page(page);
+		dir_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -218,7 +229,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 out_page:
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -229,6 +240,12 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
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
@@ -236,7 +253,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 	BUG_ON(err);
 	de->inode = 0;
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 	return err;
@@ -256,9 +273,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 		unlock_page(page);
 		goto fail;
 	}
-	kmap(page);
-
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct sysv_dir_entry *) base;
@@ -268,7 +283,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
 	strcpy(de->name,"..");
 
-	kunmap(page);
+	kunmap_local(base);
 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
 fail:
 	put_page(page);
@@ -283,10 +298,10 @@ int sysv_empty_dir(struct inode * inode)
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
@@ -310,12 +325,12 @@ int sysv_empty_dir(struct inode * inode)
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
 
@@ -332,11 +347,18 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
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
 	struct page *page = NULL;
@@ -344,7 +366,7 @@ struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 
 	if (!IS_ERR(de)) {
 		*p = page;
-		return (struct sysv_dir_entry *)page_address(page) + 1;
+		return (struct sysv_dir_entry *)de + 1;
 	}
 	return NULL;
 }
@@ -357,7 +379,7 @@ ino_t sysv_inode_by_name(struct dentry *dentry)
 	
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

