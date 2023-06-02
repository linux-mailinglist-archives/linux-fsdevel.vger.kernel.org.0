Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12C71FF75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjFBKgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjFBKfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:35:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3631FC7;
        Fri,  2 Jun 2023 03:34:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f60e536250so23707025e9.1;
        Fri, 02 Jun 2023 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701995; x=1688293995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WwVzjMT13eHkkQuH4z/XI2TgceopoHSsmejuQOoz9k=;
        b=Y0r7TXZE33mYlN7FVr58Liz7F66cdOWOUajtii8RswIxqkVGn49vT9AGdXLvlzb5c5
         Vl2ZGtPbcaZztzALwVqAzNlC9FcYE/DHSsasPw96bWyxt4VEouYAK5YPy1KdQIEKTorX
         XeDAgiS4I4EYReiOeeXztwgZnfcv0CjkaC9Eray/M+r1iSe7KaBEw/Jm25suES3vY5La
         0DJT5O42nkBMMbFZrF+bpC10CRpDYy5Z5TKENoFdZh11kPxVjPWl/i+zE3TaQW73FY42
         YMMdstts1kO9FdItwTClVen72JWvTEjFnz68CUykMRkjNJKS6wBEXMxfUXqhkfCQS8bQ
         yEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701995; x=1688293995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WwVzjMT13eHkkQuH4z/XI2TgceopoHSsmejuQOoz9k=;
        b=Xzzk/hIb6F1aQSSzbcVve+We1eAQ718z3IvVdXrp2ntSKnriurBLh13lSgj6Iu+zVF
         9ZLb4IbfF5YryGR0fsVC2zEWCQkld0PAB3VKVvmdzlXG+yLMWJSHSW6eUBOOjqMkLZNh
         STMzhaQgmg/UQeP6h3DmWNZb7PLttb/rROZJFsJ4cJlEFrIgW3Ejtv6OQ/N5hZGP5/DD
         jqzZZjwACm/bbWenAiUBUObd1YIWkySZChjwezXYE0lgVYgUHv6q8gO8+2lq7rEcpN8K
         fJYX38LSn6g5LvP4cNLPcEAJcHjpHm20q/p9Z6rxReEvJYoN7dKqxdU3J9bOvxbPwep7
         xw+w==
X-Gm-Message-State: AC+VfDyhETCLGQL5ZohJzO8xBhWKsxBDMpfNY0CyeWLLVtjwYeTHssls
        mAnXqK1gWc8lScuEi9lcGWM=
X-Google-Smtp-Source: ACHHUZ7H9FfL5WnoVHiPDlmb7Pf9mWxA+40EPLe9rU+qoF2Fadwa2H6cgJaSZJhIl5yaru6osNtUSA==
X-Received: by 2002:adf:cd8b:0:b0:307:cf71:ed8c with SMTP id q11-20020adfcd8b000000b00307cf71ed8cmr3429402wrj.35.1685701994532;
        Fri, 02 Jun 2023 03:33:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-99-244.retail.telecomitalia.it. [79.23.99.244])
        by smtp.gmail.com with ESMTPSA id f4-20020adff8c4000000b00307a83ea722sm1270596wrq.58.2023.06.02.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:33:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] highmem: Rename put_and_unmap_page() to unmap_and_put_page()
Date:   Fri,  2 Jun 2023 12:33:07 +0200
Message-Id: <20230602103307.5637-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With commit 849ad04cf562a ("new helper: put_and_unmap_page()"), Al Viro
introduced the put_and_unmap_page() to use in those many places where we
have a common pattern consisting of calls to kunmap_local() +
put_page().

Obviously, first we unmap and then we put pages. Instead, the original
name of this helper seems to imply that we first put and then unmap.

Therefore, rename the helper and change the only known upstreamed user
(i.e., fs/sysv) before this helper enters common use and might become
difficult to find all call sites and instead easy to break the builds.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I had sent an RFC which had a typo in a call of unmap_and_put_page().
The Kernel Test Robot made me notice that typo (thanks) and now it is fixed.

My fault: I thought that an RFC doesn't need compiler's checks but now I
know I was wrong :-(

The RFC is at:
https://lore.kernel.org/lkml/20230601132317.13606-1-fmdefrancesco@gmail.com/

The reason of the RFC was mainly because I wasn't sure whether or not Al
was using some obscure name calling convention which is unknown to me.

Anyway, he and nobody else objected. Therefore, I decided to drop the
RFC prefix and send a real patch. In the meantime I changed the subject
prefif from "fs" to "mm" and added linux-mm to the list of recipients.

 fs/sysv/dir.c           | 22 +++++++++++-----------
 fs/sysv/namei.c         |  8 ++++----
 include/linux/highmem.h |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index cdb3d632c63d..0140010aa0c3 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -52,7 +52,7 @@ static int sysv_handle_dirsync(struct inode *dir)
 }
 
 /*
- * Calls to dir_get_page()/put_and_unmap_page() must be nested according to the
+ * Calls to dir_get_page()/unmap_and_put_page() must be nested according to the
  * rules documented in mm/highmem.rst.
  *
  * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_page()
@@ -103,11 +103,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
 					fs16_to_cpu(SYSV_SB(sb), de->inode),
 					DT_UNKNOWN)) {
-				put_and_unmap_page(page, kaddr);
+				unmap_and_put_page(page, kaddr);
 				return 0;
 			}
 		}
-		put_and_unmap_page(page, kaddr);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -131,7 +131,7 @@ static inline int namecompare(int len, int maxlen,
  * itself (as a parameter - res_dir). It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
  *
- * On Success put_and_unmap_page() should be called on *res_page.
+ * On Success unmap_and_put_page() should be called on *res_page.
  *
  * sysv_find_entry() acts as a call to dir_get_page() and must be treated
  * accordingly for nesting purposes.
@@ -166,7 +166,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 							name, de->name))
 					goto found;
 			}
-			put_and_unmap_page(page, kaddr);
+			unmap_and_put_page(page, kaddr);
 		}
 
 		if (++n >= npages)
@@ -209,7 +209,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 				goto out_page;
 			de++;
 		}
-		put_and_unmap_page(page, kaddr);
+		unmap_and_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -228,7 +228,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	err = sysv_handle_dirsync(dir);
 out_page:
-	put_and_unmap_page(page, kaddr);
+	unmap_and_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -321,12 +321,12 @@ int sysv_empty_dir(struct inode * inode)
 			if (de->name[1] != '.' || de->name[2])
 				goto not_empty;
 		}
-		put_and_unmap_page(page, kaddr);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	put_and_unmap_page(page, kaddr);
+	unmap_and_put_page(page, kaddr);
 	return 0;
 }
 
@@ -352,7 +352,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 }
 
 /*
- * Calls to dir_get_page()/put_and_unmap_page() must be nested according to the
+ * Calls to dir_get_page()/unmap_and_put_page() must be nested according to the
  * rules documented in mm/highmem.rst.
  *
  * sysv_dotdot() acts as a call to dir_get_page() and must be treated
@@ -376,7 +376,7 @@ ino_t sysv_inode_by_name(struct dentry *dentry)
 	
 	if (de) {
 		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
-		put_and_unmap_page(page, de);
+		unmap_and_put_page(page, de);
 	}
 	return res;
 }
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index 2b2dba4c4f56..fcf163fea3ad 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -164,7 +164,7 @@ static int sysv_unlink(struct inode * dir, struct dentry * dentry)
 		inode->i_ctime = dir->i_ctime;
 		inode_dec_link_count(inode);
 	}
-	put_and_unmap_page(page, de);
+	unmap_and_put_page(page, de);
 	return err;
 }
 
@@ -227,7 +227,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (!new_de)
 			goto out_dir;
 		err = sysv_set_link(new_de, new_page, old_inode);
-		put_and_unmap_page(new_page, new_de);
+		unmap_and_put_page(new_page, new_de);
 		if (err)
 			goto out_dir;
 		new_inode->i_ctime = current_time(new_inode);
@@ -256,9 +256,9 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 out_dir:
 	if (dir_de)
-		put_and_unmap_page(dir_page, dir_de);
+		unmap_and_put_page(dir_page, dir_de);
 out_old:
-	put_and_unmap_page(old_page, old_de);
+	unmap_and_put_page(old_page, old_de);
 out:
 	return err;
 }
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 4de1dbcd3ef6..68da30625a6c 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -507,7 +507,7 @@ static inline void folio_zero_range(struct folio *folio,
 	zero_user_segments(&folio->page, start, start + length, 0, 0);
 }
 
-static inline void put_and_unmap_page(struct page *page, void *addr)
+static inline void unmap_and_put_page(struct page *page, void *addr)
 {
 	kunmap_local(addr);
 	put_page(page);
-- 
2.40.1

