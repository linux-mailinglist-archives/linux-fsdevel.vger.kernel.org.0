Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFE78EA99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbjHaKoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjHaKow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:44:52 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60436E4F;
        Thu, 31 Aug 2023 03:44:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbyCb0PyTz9v7gP;
        Thu, 31 Aug 2023 18:32:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S10;
        Thu, 31 Aug 2023 11:44:03 +0100 (CET)
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 08/25] evm: Align evm_inode_post_setattr() definition with LSM infrastructure
Date:   Thu, 31 Aug 2023 12:41:19 +0200
Message-Id: <20230831104136.903180-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43Cw43Jr43Jw1xWF1ftFb_yoW5Ww1xpF
        Z5K3Wvkw1F9ryUWr95GF48ZayFgFy8WryUX3yFgw1YyFnrKrnIqFn3K3yUAry5GrW8Wrn0
        qFnFvrs5Ar15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj49c5wAAsF
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

Change evm_inode_post_setattr() definition, so that it can be registered as
implementation of the inode_post_setattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/attr.c                         | 2 +-
 include/linux/evm.h               | 6 ++++--
 security/integrity/evm/evm_main.c | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 7d4553c1208d..431f667726c7 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -487,7 +487,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		ima_inode_post_setattr(idmap, dentry, ia_valid);
-		evm_inode_post_setattr(dentry, ia_valid);
+		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
 	return error;
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 01fc495a83e2..aebaae181fd9 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -23,7 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr);
-extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
+void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    int ia_valid);
 extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
@@ -97,7 +98,8 @@ static inline int evm_inode_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
+					  struct dentry *dentry, int ia_valid)
 {
 	return;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ff9a939dad8e..d2f986a55d38 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -841,6 +841,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 /**
  * evm_inode_post_setattr - update 'security.evm' after modifying metadata
+ * @idmap: idmap of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @ia_valid: for the UID and GID status
  *
@@ -850,7 +851,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    int ia_valid)
 {
 	if (!evm_revalidate_status(NULL))
 		return;
-- 
2.34.1

