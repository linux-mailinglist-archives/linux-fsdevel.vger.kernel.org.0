Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074E167B13D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjAYL37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjAYL3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20C2ED61
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DF0614C0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F414CC433A0;
        Wed, 25 Jan 2023 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646167;
        bh=rpioZjmc8Cn4WYIVXTsl179baJ9K19ztyXY6GuGAveU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K+Aq3OkLlQNrnJWUFa9bEr9bhTY3rAMvvY872cZDazBcXEbgeBgUHgKY/XUG1BeUa
         7vD2+QmB5tDhEGBcDPvIqw5bNDCD6QoI5rFrckzIYJUl5p96s8iIMa01CJ9sZe/FdL
         IQKHJpJAzvr8iMqJxBcuL82CZ9EK+v1p2ijnXQq4NvOrq9Nu9JvrIaiP12QMSDI7u7
         1yCk43TsND1nzg0E+O9y9DhrbNQcWxxnv6HRwQ5p/sWI1FB6O4z/BfrKtL8RGJy6wU
         dC5tNYFiJ/RdMA+t7rrGo8SPlOD0IltqJ/v76eryAkaeKO7oMq4cvDTTheTxz7Z9rs
         cvz7nsnh0G9iw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:46 +0100
Subject: [PATCH 01/12] xattr: simplify listxattr helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-1-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4210; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rpioZjmc8Cn4WYIVXTsl179baJ9K19ztyXY6GuGAveU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJq4a3r+19ecK57M68v9/STlNPOkJcf7vh9q/RR8O/AB
 /51wtY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ8LsyMnw34+o88bL4ffXrxIW/PU
 Q9VPa4/Dt96528Cv/u14dOh65j+Ke47zGD79nqrYf3Re85mekhY374/+oPt2r83ryre+21VpUBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The generic_listxattr() and simple_xattr_list() helpers list xattrs and
contain duplicated code. Add two helpers that both generic_listxattr()
and simple_xattr_list() can use.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/xattr.c | 114 +++++++++++++++++++++++++++++++------------------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index adab9a70b536..ed7fcaab8e1a 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -949,6 +949,46 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	return error;
 }
 
+static int xattr_list_one(char **buffer, ssize_t *remaining_size,
+			  const char *name)
+{
+	size_t len = strlen(name) + 1;
+	if (*buffer) {
+		if (*remaining_size < len)
+			return -ERANGE;
+		memcpy(*buffer, name, len);
+		*buffer += len;
+	}
+	*remaining_size -= len;
+	return 0;
+}
+
+static int posix_acl_listxattr(struct inode *inode, char **buffer,
+			       ssize_t *remaining_size)
+{
+#ifdef CONFIG_FS_POSIX_ACL
+	int err;
+
+	if (!IS_POSIXACL(inode))
+		return 0;
+
+	if (inode->i_acl) {
+		err = xattr_list_one(buffer, remaining_size,
+				     XATTR_NAME_POSIX_ACL_ACCESS);
+		if (err)
+			return err;
+	}
+
+	if (inode->i_default_acl) {
+		err = xattr_list_one(buffer, remaining_size,
+				     XATTR_NAME_POSIX_ACL_DEFAULT);
+		if (err)
+			return err;
+	}
+#endif
+	return 0;
+}
+
 /*
  * Combine the results of the list() operation from every xattr_handler in the
  * list.
@@ -957,33 +997,22 @@ ssize_t
 generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	const struct xattr_handler *handler, **handlers = dentry->d_sb->s_xattr;
-	unsigned int size = 0;
-
-	if (!buffer) {
-		for_each_xattr_handler(handlers, handler) {
-			if (!handler->name ||
-			    (handler->list && !handler->list(dentry)))
-				continue;
-			size += strlen(handler->name) + 1;
-		}
-	} else {
-		char *buf = buffer;
-		size_t len;
-
-		for_each_xattr_handler(handlers, handler) {
-			if (!handler->name ||
-			    (handler->list && !handler->list(dentry)))
-				continue;
-			len = strlen(handler->name);
-			if (len + 1 > buffer_size)
-				return -ERANGE;
-			memcpy(buf, handler->name, len + 1);
-			buf += len + 1;
-			buffer_size -= len + 1;
-		}
-		size = buf - buffer;
+	ssize_t remaining_size = buffer_size;
+	int err = 0;
+
+	err = posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_size);
+	if (err)
+		return err;
+
+	for_each_xattr_handler(handlers, handler) {
+		if (!handler->name || (handler->list && !handler->list(dentry)))
+			continue;
+		err = xattr_list_one(&buffer, &remaining_size, handler->name);
+		if (err)
+			return err;
 	}
-	return size;
+
+	return err ? err : buffer_size - remaining_size;
 }
 EXPORT_SYMBOL(generic_listxattr);
 
@@ -1245,20 +1274,6 @@ static bool xattr_is_trusted(const char *name)
 	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
 }
 
-static int xattr_list_one(char **buffer, ssize_t *remaining_size,
-			  const char *name)
-{
-	size_t len = strlen(name) + 1;
-	if (*buffer) {
-		if (*remaining_size < len)
-			return -ERANGE;
-		memcpy(*buffer, name, len);
-		*buffer += len;
-	}
-	*remaining_size -= len;
-	return 0;
-}
-
 /**
  * simple_xattr_list - list all xattr objects
  * @inode: inode from which to get the xattrs
@@ -1287,22 +1302,9 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	ssize_t remaining_size = size;
 	int err = 0;
 
-#ifdef CONFIG_FS_POSIX_ACL
-	if (IS_POSIXACL(inode)) {
-		if (inode->i_acl) {
-			err = xattr_list_one(&buffer, &remaining_size,
-					     XATTR_NAME_POSIX_ACL_ACCESS);
-			if (err)
-				return err;
-		}
-		if (inode->i_default_acl) {
-			err = xattr_list_one(&buffer, &remaining_size,
-					     XATTR_NAME_POSIX_ACL_DEFAULT);
-			if (err)
-				return err;
-		}
-	}
-#endif
+	err = posix_acl_listxattr(inode, &buffer, &remaining_size);
+	if (err)
+		return err;
 
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {

-- 
2.34.1

