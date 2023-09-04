Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF0791868
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353075AbjIDNgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjIDNgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:36:37 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB881719;
        Mon,  4 Sep 2023 06:36:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfTnB4f40z9xHM1;
        Mon,  4 Sep 2023 21:21:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHerrf3PVkUqceAg--.16511S8;
        Mon, 04 Sep 2023 14:35:49 +0100 (CET)
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
Subject: [PATCH v3 06/25] ima: Align ima_inode_removexattr() definition with LSM infrastructure
Date:   Mon,  4 Sep 2023 15:33:56 +0200
Message-Id: <20230904133415.1799503-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHerrf3PVkUqceAg--.16511S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWktF47GrykAFWftrW7XFb_yoW5Jr13pF
        s3K3WUC348XFy7Wr9YyF9rC3yS9rWUGrnrX3yrWan2yFnxJr1IqFWfXF17C34rGr48KF1v
        qFsFqw45CF15trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4+BVAAAsn
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_inode_removexattr() definition, so that it can be registered as
implementation of the inode_removexattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                   | 7 +++++--
 security/integrity/ima/ima_appraise.c | 3 ++-
 security/security.c                   | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 3dedff8659d2..93e3c6cdf1f8 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -206,7 +206,9 @@ static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
 {
 	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
 }
-extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
+
+int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			  const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
@@ -237,7 +239,8 @@ static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static inline int ima_inode_removexattr(struct dentry *dentry,
+static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
+					struct dentry *dentry,
 					const char *xattr_name)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 88c5a0b2992f..c35e3537eb87 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -788,7 +788,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 }
 
-int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
+int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			  const char *xattr_name)
 {
 	int result;
 
diff --git a/security/security.c b/security/security.c
index 00826269481e..2746e889db6d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2332,7 +2332,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 		ret = cap_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
-	ret = ima_inode_removexattr(dentry, name);
+	ret = ima_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
 	return evm_inode_removexattr(idmap, dentry, name);
-- 
2.34.1

