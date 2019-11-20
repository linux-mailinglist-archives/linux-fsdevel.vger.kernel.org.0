Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055FB103F23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfKTPld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732099AbfKTPld (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:41:33 -0500
Received: from hubcapsc.localdomain (adsl-074-187-100-144.sip.mia.bellsouth.net [74.187.100.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A09F220709;
        Wed, 20 Nov 2019 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574264492;
        bh=zwIi3KjbTJyA9nlUEN7sOsjcjcY0B6OVVYRZkrdYyUM=;
        h=From:To:Cc:Subject:Date:From;
        b=JvoQxyASNfmrn7/hMU11pLlwhNjf14Lv5w58YbQidQDcjHrFMLKASLenlqfaouEvO
         fk2ZWfTnPZMVrHrTNUNGsKckSO4p5I2jlLumuJTXAZvp44XbFmAwZSbXq9MEl0P9qn
         BazJmIreo927OSzrWtQxIh7SXUN6NsU/vw1LAo1c=
From:   hubcap@kernel.org
To:     torvalds@linux-foundation.org
Cc:     Mike Marshall <hubcap@omnibond.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] orangefs: posix read and write on open files.
Date:   Wed, 20 Nov 2019 10:41:11 -0500
Message-Id: <20191120154111.9788-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Marshall <hubcap@omnibond.com>

Orangefs doesn't have an open function. Orangefs performs
permission checks on files each time they are accessed.
Users create files with arbitrary permissions. A user
might create a file with a mode that doesn't include write,
or change the mode of a file he has opened to one that doesn't
include write. Posix says the user can write on the file
anyway since he was able to open it.

Orangefs through the kernel module needs to seem posixy, so
when someone creates or chmods a file to a mode that disallows owner
read and/or write, we'll call orangefs_posix_open to stamp a
temporary S_IRWXU acl on it in userspace without telling the kernel
about the acl, and remove the acl later when the kernel passes through
file_operations->release.

This fixes known real-world problems: git, for example,
uses openat(AT_FDCWD, argv[1], O_RDWR|O_CREAT|O_EXCL, 0444)
on some important files it later tries to write on during clone.
We don't actually know use cases where people chmod their open files to
un-writability and then try to write on them, but they
should be able to if they want to :-).

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/file.c            | 16 ++++++++++++
 fs/orangefs/inode.c           | 15 +++++++++++
 fs/orangefs/namei.c           | 10 ++++++-
 fs/orangefs/orangefs-kernel.h |  3 +++
 fs/orangefs/orangefs-utils.c  | 49 +++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a5612abc0936..c582e7bc5d40 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -513,6 +513,22 @@ static int orangefs_file_release(struct inode *inode, struct file *file)
 		}
 
 	}
+	/*
+	 * Check to see if we're affecting posixness by keeping a temporary
+	 * owner rw ACL on this file while it is open, so that the process
+	 * that has it open can read and write it no matter what the mode is.
+	 * If there is a temporary ACL on the file, clean it and
+	 * its associated inode flag up. See the comments in
+	 * orangefs_posix_open for more info.
+	 */
+	if (ORANGEFS_I(inode)->opened) {
+		ORANGEFS_I(inode)->opened = 0;
+		orangefs_inode_setxattr(inode,
+			XATTR_NAME_POSIX_ACL_ACCESS,
+			NULL,
+			0,
+			0);
+	}
 	return 0;
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index efb12197da18..af9eb24ad7c6 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -880,6 +880,20 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 		}
 	}
 
+	/*
+	 * if it seems like someone might be fixing to chmod an open file into
+	 * unread or unwritability, use the orangefs_posix_open hat-trick to
+	 * posixly provide read and writability.
+	 */
+	if ((iattr->ia_mode) &&
+	    (!ORANGEFS_I(inode)->opened) &&
+	    (iattr->ia_valid & ATTR_MODE) &&
+	    (!(iattr->ia_mode & S_IRUSR) || (!(iattr->ia_mode & S_IWUSR)))) {
+		ret = orangefs_posix_open(inode);
+		if (ret)
+			goto out;
+	}
+
 	if (iattr->ia_valid & ATTR_SIZE) {
 		ret = orangefs_setattr_size(inode, iattr);
 		if (ret)
@@ -1060,6 +1074,7 @@ static int orangefs_set_inode(struct inode *inode, void *data)
 	hash_init(ORANGEFS_I(inode)->xattr_cache);
 	ORANGEFS_I(inode)->mapping_time = jiffies - 1;
 	ORANGEFS_I(inode)->bitlock = 0;
+	ORANGEFS_I(inode)->opened = 0;
 	return 0;
 }
 
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 3e7cf3d0a494..040ef164563e 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -86,7 +86,15 @@ static int orangefs_create(struct inode *dir,
 	iattr.ia_valid |= ATTR_MTIME | ATTR_CTIME;
 	iattr.ia_mtime = iattr.ia_ctime = current_time(dir);
 	__orangefs_setattr(dir, &iattr);
-	ret = 0;
+
+	/*
+	 * If you can open (or create) a file, Posix says you should
+	 * be able to read or write to the file without regard to
+	 * the file's mode until the fd is closed.
+	 */
+	if (!(mode & S_IRUSR) || (!(mode & S_IWUSR)))
+		ret = orangefs_posix_open(inode);
+
 out:
 	op_release(new_op);
 	gossip_debug(GOSSIP_NAME_DEBUG,
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 34a6c99fa29b..cad7a7e08e34 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -198,6 +198,7 @@ struct orangefs_inode_s {
 	kuid_t attr_uid;
 	kgid_t attr_gid;
 	unsigned long bitlock;
+	int opened;
 
 	DECLARE_HASHTABLE(xattr_cache, 4);
 };
@@ -405,6 +406,8 @@ ssize_t do_readv_writev(enum ORANGEFS_io_type, struct file *, loff_t *,
 /*
  * defined in orangefs-utils.c
  */
+int orangefs_posix_open(struct inode *inode);
+
 __s32 fsid_of_op(struct orangefs_kernel_op_s *op);
 
 ssize_t orangefs_inode_getxattr(struct inode *inode,
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index d4b7ae763186..3c60c65ec445 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -452,6 +452,55 @@ int orangefs_inode_setattr(struct inode *inode)
 	return ret;
 }
 
+/*
+ * Orangefs doesn't have an open function. Orangefs performs
+ * permission checks on files each time they are accessed.
+ * Users create files with arbitrary permissions. A user
+ * might create a file with a mode that doesn't include write,
+ * or change the mode of a file he has opened to one that doesn't
+ * include write. Posix says the user can write on the file
+ * anyway since he was able to open it.
+ *
+ * Orangefs through the kernel module needs to seem posixy, so
+ * when someone creates or chmods a file to a mode that disallows owner
+ * read and/or write, we'll call orangefs_posix_open to stamp a
+ * temporary S_IRWXU acl on it in userspace without telling the kernel
+ * about the acl, and remove the acl later when the kernel passes through
+ * file_operations->release.
+ *
+ * This fixes known real-world problems: git, for example,
+ * uses openat(AT_FDCWD, argv[1], O_RDWR|O_CREAT|O_EXCL, 0444)
+ * on some important files it later tries to write on during clone.
+ * We don't actually know use cases where people chmod their open files to
+ * un-writability and then try to write on them, but they
+ * should be able to if they want to :-).
+ */
+int orangefs_posix_open(struct inode *inode) {
+	struct posix_acl_xattr_header *posix_header;
+	struct posix_acl_xattr_entry *posix_entry;
+	void *buffer;
+	int size = sizeof(struct posix_acl_xattr_header) +
+			sizeof(struct posix_acl_xattr_entry);
+	const char *name = XATTR_NAME_POSIX_ACL_ACCESS;
+	int ret;
+
+	buffer = kmalloc(size, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	ORANGEFS_I(inode)->opened = 1;
+	posix_header = buffer;
+	posix_header->a_version = POSIX_ACL_XATTR_VERSION;
+	posix_entry = (void *)(posix_header + 1);
+	posix_entry->e_tag = ACL_USER;
+	posix_entry->e_perm = S_IRWXU >> 6;
+	posix_entry->e_id = from_kuid(&init_user_ns, current_fsuid());
+
+	ret = orangefs_inode_setxattr(inode, name, buffer, size, 0);
+	kfree(buffer);
+	return ret;
+}
+
 /*
  * The following is a very dirty hack that is now a permanent part of the
  * ORANGEFS protocol. See protocol.h for more error definitions.
-- 
2.20.1

