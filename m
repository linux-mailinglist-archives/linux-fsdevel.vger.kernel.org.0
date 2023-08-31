Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5778EA75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344654AbjHaKnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjHaKnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:43:39 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051AE74;
        Thu, 31 Aug 2023 03:43:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RbyBN3ZGkz9xFH2;
        Thu, 31 Aug 2023 18:31:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S5;
        Thu, 31 Aug 2023 11:42:58 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 03/25] ima: Align ima_post_create_tmpfile() definition with LSM infrastructure
Date:   Thu, 31 Aug 2023 12:41:14 +0200
Message-Id: <20230831104136.903180-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fWrWUtrW3tr4DKryDZFb_yoW5Xw48pF
        s3Kw1UGrZ5Wry29FykJayDZryfKayqqr4UZrWfW3s0yF1vqr1FvF1fCFnIkF13JFWrCry2
        v3y5KrWDAr1UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
        0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU8Ru
        WJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5NcxgABs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_post_create_tmpfile() definition, so that it can be registered
as implementation of the post_create_tmpfile hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                        | 2 +-
 include/linux/ima.h               | 7 +++++--
 security/integrity/ima/ima_main.c | 8 ++++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c5e96f716f98..1f5ec71360de 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3698,7 +3698,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
-	ima_post_create_tmpfile(idmap, inode);
+	ima_post_create_tmpfile(idmap, dir, file, mode);
 	return 0;
 }
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 179ce52013b2..893c3b98b4d0 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -19,7 +19,8 @@ extern enum hash_algo ima_get_current_hash_algo(void);
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-				    struct inode *inode);
+				    struct inode *dir, struct file *file,
+				    umode_t mode);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long reqprot,
 			 unsigned long prot, unsigned long flags);
@@ -69,7 +70,9 @@ static inline int ima_file_check(struct file *file, int mask)
 }
 
 static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-					   struct inode *inode)
+					   struct inode *dir,
+					   struct file *file,
+					   umode_t mode)
 {
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 76eba92d7f10..52e742d32f4b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -663,16 +663,20 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @idmap: idmap of the mount the inode was found from
- * @inode: inode of the newly created tmpfile
+ * @dir: inode structure of the parent of the new file
+ * @file: file descriptor of the new file
+ * @mode: mode of the new file
  *
  * No measuring, appraising or auditing of newly created tmpfiles is needed.
  * Skip calling process_measurement(), but indicate which newly, created
  * tmpfiles are in policy.
  */
 void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-			     struct inode *inode)
+			     struct inode *dir, struct file *file,
+			     umode_t mode)
 {
 	struct integrity_iint_cache *iint;
+	struct inode *inode = file_inode(file);
 	int must_appraise;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
-- 
2.34.1

