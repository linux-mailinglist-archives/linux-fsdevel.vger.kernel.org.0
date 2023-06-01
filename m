Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECE9719D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjFANXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjFANXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:23:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA6180;
        Thu,  1 Jun 2023 06:23:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30af0aa4812so862181f8f.1;
        Thu, 01 Jun 2023 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685625802; x=1688217802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLK6ieUgz6X3Gz+ExOMDvHB9gFBu3LRs52TXPMBnCz0=;
        b=Xm0P9xUkyqClPHqwMqK1vG4r5Rv0IqlbZ++DW4NMA3pla4EQ5NBW71TT5qqIoPfsdg
         QtODhIc4pImsHDqF+BWLC9CCtNomXKnzqcqqtCR29APiMtPAQle991TkfLh0UWy0uZNK
         OOzFKqvyheixg4+1JsmGtnK7qfL8U52DD42uXHsJv/H5jdtqwtfoRu0IiPnC4hEqrko5
         BG0lJieSeMV8T1JAva5yF1RqyO0SNfzXVbgVhHTOsH8p9gcrUHFRo2t4gUZrQ4pl2e5B
         jxQnZDggQb6IrGQ4BK4JtluBXnd/MIGa5b2b41REjGIAm5Ym+27Q1mfCTNXujL66qNsx
         DXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685625802; x=1688217802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLK6ieUgz6X3Gz+ExOMDvHB9gFBu3LRs52TXPMBnCz0=;
        b=crCecooac4WUzMHOcsZWiXOvFRB5Kl3B+rwjGjqnUUmOqE5DBBj+xlfRT4crrxQkuv
         x2tD7kYDa7yoRcWQOZuPFWTY9r4aBq61mXdZRZq0xbj4duWA2qz3zEFDw/g245P1GeLT
         ACHtzD/oVeR43OkpItsvrN7VHAnEVCFeSWhnSy2LhLU1IdMNBhFrxbVDObNMp0N8AL3N
         rnQa/mRQxcSzlFTXQfmW5WBB3O6FEEm0pLYz15Jzq7YdhjIdQj99CWgsartltei9sT+I
         Ud+CPjY5bKN0qQB5ooJelFEYRFTrymyeLjw+lLWyzBv/euvlX3vYGxrckDG2+Up5loc1
         Ggcg==
X-Gm-Message-State: AC+VfDzXsiC+DT+WVQl86kHXkJHYHBMbascPH47gTLEK6y+AQ8JcuJud
        iJEd3OLWRroWtwM/xh1vFME=
X-Google-Smtp-Source: ACHHUZ7Awj6EoXoL4TrWY3g1vWHy2Ga03RvqQOGvFL8I9tCS9JOUBcmFIxeI6QM59JdmAosnERotlw==
X-Received: by 2002:a5d:457c:0:b0:30a:ea89:8863 with SMTP id a28-20020a5d457c000000b0030aea898863mr2080277wrc.0.1685625802262;
        Thu, 01 Jun 2023 06:23:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-99-244.retail.telecomitalia.it. [79.23.99.244])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d63ca000000b002c70ce264bfsm10344047wrw.76.2023.06.01.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:23:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC PATCH] fs: Rename put_and_unmap_page() to unmap_and_put_page()
Date:   Thu,  1 Jun 2023 15:23:17 +0200
Message-Id: <20230601132317.13606-1-fmdefrancesco@gmail.com>
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
difficult to find all call sites and break the Kernel builds.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This is an RFC because I'm pretty sure that Al must have been a good
reason to use this counter intuitive name for his helper. I'm not
probably aware of some obscure helpers names convention.

Furthermore, I know that Al's VFS tree has already used this helper at
least in fs/minix and probably in other filesystems.

Therefore I didn't want to send a "real" patch.

I'm looking forward to hearing from people involved with fs and
especially from Al before sending a real patch or throwing it away.

 fs/sysv/dir.c           | 22 +++++++++++-----------
 fs/sysv/namei.c         |  8 ++++----
 include/linux/highmem.h |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index cdb3d632c63d..d6a3bbb550c3 100644
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
+ * On Success unmap_iand_put_page() should be called on *res_page.
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
+	unmap_iand_put_page(page, kaddr);
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

