Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75322705FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 18:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfGVQx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 12:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731091AbfGVQxx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:53:53 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485BF22389;
        Mon, 22 Jul 2019 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563814432;
        bh=qlYFvaRE9iv35XeI/MgdJESP4AHiCPwz+PUBzSpBBQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXY269iNhGDOsVvfXmidJWUTUfuZyZi84H8rhRYSLRsRseLkv2W+42TtN7tD73/hL
         pDtT6ezz7ST5gEo3TaDdeR4bQK1CxYkM5qqxgD+RH0OOsHIu3RCCYk6/Zwjuz3o16V
         hLXC3fv6tI4kqIVWCvWFDb00u8wTRMzS9Cb2ODGY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v7 08/17] fs-verity: add the hook for file ->setattr()
Date:   Mon, 22 Jul 2019 09:50:52 -0700
Message-Id: <20190722165101.12840-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722165101.12840-1-ebiggers@kernel.org>
References: <20190722165101.12840-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function fsverity_prepare_setattr() which filesystems that support
fs-verity must call to deny truncates of verity files.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/open.c         | 21 +++++++++++++++++++++
 include/linux/fsverity.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index 8013f77f907eb..2cb2fe8082bff 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -295,6 +295,27 @@ int fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(fsverity_file_open);
 
+/**
+ * fsverity_prepare_setattr() - prepare to change a verity inode's attributes
+ * @dentry: dentry through which the inode is being changed
+ * @attr: attributes to change
+ *
+ * Verity files are immutable, so deny truncates.  This isn't covered by the
+ * open-time check because sys_truncate() takes a path, not a file descriptor.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	if (IS_VERITY(d_inode(dentry)) && (attr->ia_valid & ATTR_SIZE)) {
+		pr_debug("Denying truncate of verity file (ino %lu)\n",
+			 d_inode(dentry)->i_ino);
+		return -EPERM;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_prepare_setattr);
+
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  *
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 09b04dab64520..cbd0f84e1620f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -46,6 +46,7 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 /* open.c */
 
 extern int fsverity_file_open(struct inode *inode, struct file *filp);
+extern int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 extern void fsverity_cleanup_inode(struct inode *inode);
 
 #else /* !CONFIG_FS_VERITY */
@@ -62,6 +63,12 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 	return IS_VERITY(inode) ? -EOPNOTSUPP : 0;
 }
 
+static inline int fsverity_prepare_setattr(struct dentry *dentry,
+					   struct iattr *attr)
+{
+	return IS_VERITY(d_inode(dentry)) ? -EOPNOTSUPP : 0;
+}
+
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
 }
-- 
2.22.0

