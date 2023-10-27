Return-Path: <linux-fsdevel+bounces-1335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1556E7D91EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA953B2146B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D2156E9;
	Fri, 27 Oct 2023 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99778156D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:39:11 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F84D72;
	Fri, 27 Oct 2023 01:39:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SGwjL0QK3z9y4ST;
	Fri, 27 Oct 2023 16:25:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX8JGqdjtlDvIBAw--.29710S9;
	Fri, 27 Oct 2023 09:38:39 +0100 (CET)
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
Subject: [PATCH v4 07/23] evm: Align evm_inode_setxattr() definition with LSM infrastructure
Date: Fri, 27 Oct 2023 10:35:42 +0200
Message-Id: <20231027083558.484911-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCX8JGqdjtlDvIBAw--.29710S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGryfXF4ktFy8trWrXFy5Jwb_yoW5Ar4kpF
	Z8Ka48Gw1FqFyUWryvkF47uayv93yrWryjk3yDK3WvyF9xJr92qFyxKF4jkryrCr48Krn0
	qanFvrs8Cw15X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5WUWgAAss
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Change evm_inode_setxattr() definition, so that it can be registered as
implementation of the inode_setxattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/evm.h               | 4 ++--
 security/integrity/evm/evm_main.c | 3 ++-
 security/security.c               | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index cf976d8dbd7a..7c6a74dbc093 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -27,7 +27,7 @@ extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
-			      const void *value, size_t size);
+			      const void *value, size_t size, int flags);
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
@@ -106,7 +106,7 @@ static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
 
 static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
 				     struct dentry *dentry, const char *name,
-				     const void *value, size_t size)
+				     const void *value, size_t size, int flags)
 {
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index d2f986a55d38..779ec35fb39f 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -559,6 +559,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
  * @xattr_value_len: pointer to the new extended attribute value length
+ * @flags: flags to pass into filesystem operations
  *
  * Before allowing the 'security.evm' protected xattr to be updated,
  * verify the existing value is valid.  As only the kernel should have
@@ -568,7 +569,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
  */
 int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       const char *xattr_name, const void *xattr_value,
-		       size_t xattr_value_len)
+		       size_t xattr_value_len, int flags)
 {
 	const struct evm_ima_xattr_data *xattr_data = xattr_value;
 
diff --git a/security/security.c b/security/security.c
index b222c4b81760..f508101bf465 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2265,7 +2265,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
-	return evm_inode_setxattr(idmap, dentry, name, value, size);
+	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
 }
 
 /**
-- 
2.34.1


