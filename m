Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6077F662C45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbjAIRIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjAIRHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:07:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1C3DBD6;
        Mon,  9 Jan 2023 09:06:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s9so8878880wru.13;
        Mon, 09 Jan 2023 09:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVOWfeV8XAusRFbQDF4pruLZCgXugYaujYQ4ITxrwOI=;
        b=FOFDBc/QbOf8IDAwa/61C8INGWFoZsWMgIZ4VM4s9/2EOINa8XCucYv0wYr3mzAr22
         Cip/gMElBCOYNtNXgWiR4SApnC8S1c7SU2o15DBqrHzPFpjwDsgZ6aiRBIq+KPIualHu
         8JOV2zQ+MdCWMdrLI72wiXYsHJcl7w6OqMFJf+BmrU1m4jfkRPXtHE8uIQQSmi6ZHMGj
         bran+mSNEGO48QOqesVf+tghGONGJQFzYCmIjc9OHiMsUsUl+nRB+J8Uz1pK5k3oM3bX
         SfUPnRnRXYKxIOqdYvcYUOTuvnCHxwCiE/1zWp0TribW22wV+onqeC9W0uNc/7cl/a+C
         v3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVOWfeV8XAusRFbQDF4pruLZCgXugYaujYQ4ITxrwOI=;
        b=gU0QKEbxH6bFn+hespU0gyJVNbrCtuNHDQQWAhlAn8qU4JQiZLhqlV3oC2j2QMG9jv
         SqXSmr6p7N/SGmNjwUotei42zPsa86GLAP/uNC5JzNVfje2kA+dKWsr9MNJwVmz8Zc3d
         unX6oCPUTTYL//WCrWpJ4rY1Mi1ALzj0qly3kgiiWDRtyZHuvSCE+rjfty/mEL6j4pkA
         cmnGixFeJG2DptgRi95z6zv8JF2WLGaMbnHJuF7R5VFY1mF2vTuZaawDDoKq9wYZtU3y
         Qfh3yhUbCYmlolBWR68VXAdLrpPc+Q2IbIf0nbyLDwiDHknqKaLEeLhxv5EGm6Dz7129
         K0aA==
X-Gm-Message-State: AFqh2koT93FOyHJ6QaWRtDRE/LF/Zogpx+Z3S9UefvgCz8YysorzU3kV
        JKHhAL8qIeDc/Y4dC61kbP0=
X-Google-Smtp-Source: AMrXdXu1ZHtF51FzYNnMwsAyGvAAgZwv5KrXd/dc1uNsTPT+oAE6jiTLfj7mQAPAkSSkUD9RudbHtA==
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id bz16-20020a056000091000b00242733baf28mr55981006wrb.5.1673284010639;
        Mon, 09 Jan 2023 09:06:50 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm8954527wrx.96.2023.01.09.09.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:06:50 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Mon,  9 Jan 2023 18:06:39 +0100
Message-Id: <20230109170639.19757-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109170639.19757-1-fmdefrancesco@gmail.com>
References: <20230109170639.19757-1-fmdefrancesco@gmail.com>
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

No changes from v1.

 fs/sysv/dir.c   | 64 +++++++++++++++++++++++++++++++++----------------
 fs/sysv/namei.c |  4 ++--
 fs/sysv/sysv.h  |  2 +-
 3 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index ee38dc5a3010..db5c483a9b68 100644
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
 	struct page *page = NULL;
@@ -343,7 +365,7 @@ struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 
 	if (!IS_ERR(de)) {
 		*p = page;
-		return (struct sysv_dir_entry *)page_address(page) + 1;
+		return (struct sysv_dir_entry *)de + 1;
 	}
 	return NULL;
 }
@@ -356,7 +378,7 @@ ino_t sysv_inode_by_name(struct dentry *dentry)
 	
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

