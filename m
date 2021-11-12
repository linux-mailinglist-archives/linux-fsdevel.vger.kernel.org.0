Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A73A44E6A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhKLMro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4086 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhKLMre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:34 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJ9D1rK1z67bFK;
        Fri, 12 Nov 2021 20:41:04 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:44:40 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ebiggers@kernel.org>, <tytso@mit.edu>, <corbet@lwn.net>,
        <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 1/5] fsverity: Introduce fsverity_get_file_digest()
Date:   Fri, 12 Nov 2021 13:44:07 +0100
Message-ID: <20211112124411.1948809-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112124411.1948809-1-roberto.sassu@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the fsverity_info structure is defined internally in fsverity, expose
the fsverity file digest through the new function
fsverity_get_file_digest().

Given that an fsverity file is guaranteed to be immutable, also the
retrieved file digest is stable and won't change.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/verity/open.c         | 24 ++++++++++++++++++++++++
 include/linux/fsverity.h | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index 92df87f5fa38..9127c77c6539 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -218,6 +218,30 @@ void fsverity_free_info(struct fsverity_info *vi)
 	kmem_cache_free(fsverity_info_cachep, vi);
 }
 
+/*
+ * Copy the file digest and associated algorithm taken from the passed
+ * fsverity_info structure to the locations supplied by the caller.
+ *
+ * Return: the digest size on success, a negative value on error
+ */
+ssize_t fsverity_get_file_digest(struct fsverity_info *info, u8 *buf,
+				 size_t bufsize, enum hash_algo *algo)
+{
+	enum hash_algo a;
+
+	a = match_string(hash_algo_name, HASH_ALGO__LAST,
+			 info->tree_params.hash_alg->name);
+	if (a < 0)
+		return a;
+
+	if (bufsize < hash_digest_size[a])
+		return -ERANGE;
+
+	*algo = a;
+	memcpy(buf, info->file_digest, hash_digest_size[*algo]);
+	return hash_digest_size[*algo];
+}
+
 static bool validate_fsverity_descriptor(struct inode *inode,
 					 const struct fsverity_descriptor *desc,
 					 size_t desc_size)
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b568b3c7d095..877a7f609dd9 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -13,6 +13,7 @@
 
 #include <linux/fs.h>
 #include <uapi/linux/fsverity.h>
+#include <crypto/hash_info.h>
 
 /* Verity operations for filesystems */
 struct fsverity_operations {
@@ -137,6 +138,8 @@ int fsverity_ioctl_measure(struct file *filp, void __user *arg);
 int fsverity_file_open(struct inode *inode, struct file *filp);
 int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void fsverity_cleanup_inode(struct inode *inode);
+ssize_t fsverity_get_file_digest(struct fsverity_info *info, u8 *buf,
+				 size_t bufsize, enum hash_algo *algo);
 
 /* read_metadata.c */
 
@@ -187,6 +190,13 @@ static inline void fsverity_cleanup_inode(struct inode *inode)
 {
 }
 
+static inline ssize_t fsverity_get_file_digest(struct fsverity_info *info,
+					       u8 *buf, size_t bufsize,
+					       enum hash_algo *algo)
+{
+	return -EOPNOTSUPP;
+}
+
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,
-- 
2.32.0

