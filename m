Return-Path: <linux-fsdevel+bounces-3228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B67F1A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1551C21162
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890E2230F;
	Mon, 20 Nov 2023 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA48124;
	Mon, 20 Nov 2023 09:34:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SYvRC5W01z9xvh9;
	Tue, 21 Nov 2023 01:20:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3NimFtlBH8KAQ--.51496S3;
	Mon, 20 Nov 2023 18:33:50 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 01/25] ima: Align ima_inode_post_setattr() definition with LSM infrastructure
Date: Mon, 20 Nov 2023 18:32:54 +0100
Message-Id: <20231120173318.1132868-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXU3NimFtlBH8KAQ--.51496S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45Zw48Zw4xCry5ur1DAwb_yoW5WFWfpa
	95G3WDG34ruFy8Wr95Aa13A3yF9FyUWFy7W3yrK34IyFnxtr1jqFn3Kry7Cry5CrW8Kr90
	qF1jgrs8C3WayrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU07r
	cDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apawAEsj
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_inode_post_setattr() definition, so that it can be registered as
implementation of the inode_post_setattr hook (to be introduced).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/attr.c                             | 2 +-
 include/linux/ima.h                   | 4 ++--
 security/integrity/ima/ima_appraise.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index bdf5deb06ea9..9bddc0a6352c 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -502,7 +502,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
-		ima_inode_post_setattr(idmap, dentry);
+		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(dentry, ia_valid);
 	}
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..910a2f11a906 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -186,7 +186,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry);
+				   struct dentry *dentry, int ia_valid);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_set_acl(struct mnt_idmap *idmap,
@@ -206,7 +206,7 @@ static inline bool is_ima_appraise_enabled(void)
 }
 
 static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
-					  struct dentry *dentry)
+					  struct dentry *dentry, int ia_valid)
 {
 	return;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 870dde67707b..36c2938a5c69 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -629,6 +629,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * ima_inode_post_setattr - reflect file metadata changes
  * @idmap:  idmap of the mount the inode was found from
  * @dentry: pointer to the affected dentry
+ * @ia_valid: for the UID and GID status
  *
  * Changes to a dentry's metadata might result in needing to appraise.
  *
@@ -636,7 +637,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * to lock the inode's i_mutex.
  */
 void ima_inode_post_setattr(struct mnt_idmap *idmap,
-			    struct dentry *dentry)
+			    struct dentry *dentry, int ia_valid)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
-- 
2.34.1


