Return-Path: <linux-fsdevel+bounces-47525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BFA9F512
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1513A950F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5C27A138;
	Mon, 28 Apr 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsdBoFYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C8184524;
	Mon, 28 Apr 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856035; cv=none; b=fSHXo32ldmqrA7/G3nEI/ibiDyUA/Jwlzu84ElL+5fe+64uWY/QZlLEp+0BfeYOIustWh/L22iCKgAtX3gLnCWWrZQeY8XCNpwPxZ3G/i163x2yLy8luzq/5JirrlG8lqbLHH8obbkZw58n2EF7r3yPJFROxG3OFvWPplE/UNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856035; c=relaxed/simple;
	bh=2pF5ZVuvv6ywjV5CAQxpNFVYGGO75yrto/uXyKHjBqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHRa1csF3wmYIgHPRSQgz8ZK6y0pQoJgvUyhNREv6ySAN2v6kCOhjKm5+X+VqpdEsQB27aFP1+jgspl7XKJnDAw+eJ8klcZm7F3xJLgH6gJMVJQsx12AZ3czNFRYDxKx6hmbPTQAaqGw0NTctjG8cRo/mCFErVnMGjW1Vz4Q/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsdBoFYO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8efefec89so51683936d6.3;
        Mon, 28 Apr 2025 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745856032; x=1746460832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5r+fit36PDk6bbKWFNNj/Jg/r2XACS3LZjEojHndMuU=;
        b=LsdBoFYOpcUtBbZ2j/zapDWy/REZXYgOaHfTWylyCbJjilciLBBWH9nRF0ZoPJjk0j
         ZH7qQCmG72c9Gx7WIf6FJFAfgKQGDwcQl3eWJ2INtxgU/W89xwOIGWeHv+EkyETYeoFF
         ePG8O5wb+oGQJKCX32lw3QhC+j3l5paNr0N7XWE8uj4St0MW9Ow0zOdcHcaqhy82yzkS
         ezIunAmE5/2h8trW6yb1QKniBJuZJAtgDL/uecAwIsNe0smZiWH1XCYyQh2TFsE3LhxA
         UI3/sTAZiCH4GY/5iPjQPGOzwIGb/+aKUcE72310lPDU/ALxEc04tbDUYBer3ys5uG2L
         u9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856032; x=1746460832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r+fit36PDk6bbKWFNNj/Jg/r2XACS3LZjEojHndMuU=;
        b=dKXnQp7V/YC0ryBEAumzFayP1o7Q52QtiYsTa+omuWMx1VDCph0cw85qNNcX2LkOyi
         FZf+jQsw8m9vc7AgGoDbvpY1US1hwehjGSfZQakwppFr2UvsrIbpd/yBp//E61wCuNgT
         zeP9cdHgDJbBAVh+8dpdONU7UUwyrJuSYXrxAdYFHi66gtIWrle7Kr2QAt+ImX0oW/ZI
         KO5TZDx+NNIf7YM15oQrbsVw0xFH/R45A1pASCt6CPc5FMSmUsKeb2iLC+c9qHKkMKmx
         Z+25yXL+pyFumVlMis0KXqx7fF9w+gb9LGo1DDL6vMDM/CSnmYR/Yc8uZmnz8kDvta7i
         JxIA==
X-Forwarded-Encrypted: i=1; AJvYcCUJKhUf45rsrv5LLL9C62GJ/tHUJJ9G4bTJ2V2IORYJSIW31DwU65qbeZJjIOUJ2Pwbta4VyCiEXywLX/1S@vger.kernel.org, AJvYcCUQuNuIPJQ92IxoXKFkm4S5a3KknOU0rPl9zjuVt9Ctb0e+Ni2RQDCOZbc0s31tz6WsWwBtMDrn2fV/C7Gy1YC0UAcMlcHV@vger.kernel.org, AJvYcCUtCBv4gXxDWcRMxPJbu3Zyrb4Ex2srDOHekTgQlbaehtYzsKkgtl/EjmaiQdwgOkiCY9u9zOQscrOp/T9P@vger.kernel.org, AJvYcCV/ppjwCU9uG3od+4ZF3J3TvBkTm+FULM8Zaapkkwj79FY52KEszNCXXmIdnRTXkRcJn9ZlXRR2@vger.kernel.org, AJvYcCVsi+5pctAIEYmfdHTF952fP3HQzP2vsZuhCkgNnHX4aUPpn5r3IcUYGBTPkuIYQm55RhAr3MXRTBdx@vger.kernel.org, AJvYcCWGUUMpJRe7hd/4JHr7WHrMkWr/8KeJCH+SQUosP2WwJ2QwzqxidPBUdqSkV0j2+W/5GB62nRvdrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTD2ckl1lrRkkUxnBxSmFyHn9SuvSpD7++W9cuXXetDQFqwUr
	jC3v/7s3AW/YFU0ihVG7CCZLBc7Kd0XdkO9lBSIPB/QLjsk/eJMe85cRNPLoIjU=
X-Gm-Gg: ASbGncuxb4lxux8Vl2JC1H9Ib1jAoKee+MkfHST9ObkM2LRPIZpcWIsOxjZUrkczQSq
	QcatiSUeh0iJHUmoqkSwuZnTTlLFhcllErHSahueN0r1E8bLG0CPdU8aeSt4s+KDOJ+zENdTKMF
	Md7dz13GMMEEK4rOn6ZCr0dohZyd9FqeyrCY6vIILQPb3TqZlo4o0UbX9OqkmmVEnn7IkkTfaLg
	7FB5HlEX2lbcrADMSox8XpCAdD5ftKXYdyjYQco/kFz5I6pZp96kO401cKl5bntEh1JqE6Y6lMZ
	mNzUYcZI65B3z6VS9oZhlulMHOuLJn9Fxm+XDngn82ONDEAYpfcWKVDqHne2AAEXoKg7q2BFv6+
	RjBeK2lMJlzl8uVhWTekLYLftmTqHxHFQPRwvFFD9s4djaNyVpMBAAyMktZySJYR+WIei
X-Google-Smtp-Source: AGHT+IEaHqdauwA3gBnLn9R84FGC9rQTXYgsEqW4m0sWTxpVGx7bmQRrDTucoMS5bvojIJd4YNLjLw==
X-Received: by 2002:a0c:f201:0:b0:6e8:97f6:3229 with SMTP id 6a1803df08f44-6f4cbcb9e24mr226814186d6.16.1745856031452;
        Mon, 28 Apr 2025 09:00:31 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c09341d6sm62947416d6.32.2025.04.28.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:00:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] security,fs,nfs,net: update security_inode_listsecurity() interface
Date: Mon, 28 Apr 2025 11:55:31 -0400
Message-ID: <20250428155535.6577-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the security_inode_listsecurity() interface to allow
use of the xattr_list_one() helper and update the hook
implementations.

Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This patch is relative to the one linked above, which in theory is on
vfs.fixes but doesn't appear to have been pushed when I looked.

 fs/nfs/nfs4proc.c             |  9 +++++----
 fs/xattr.c                    | 20 ++++++++------------
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      |  5 +++--
 net/socket.c                  |  8 +-------
 security/security.c           | 16 ++++++++--------
 security/selinux/hooks.c      | 10 +++-------
 security/smack/smack_lsm.c    | 13 ++++---------
 8 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..a1d7cb0acb5e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8023,12 +8023,13 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 static ssize_t
 nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 {
-	int len = 0;
+	ssize_t len = 0;
+	int err;
 
 	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
-		len = security_inode_listsecurity(inode, list, list_len);
-		if (len >= 0 && list_len && len > list_len)
-			return -ERANGE;
+		err = security_inode_listsecurity(inode, &list, &len);
+		if (err)
+			len = err;
 	}
 	return len;
 }
diff --git a/fs/xattr.c b/fs/xattr.c
index 2fc314b27120..fdd2f387bfd5 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -492,9 +492,12 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
-		error = security_inode_listsecurity(inode, list, size);
-		if (size && error > size)
-			error = -ERANGE;
+		char *buffer = list;
+		ssize_t len = 0;
+
+		error = security_inode_listsecurity(inode, &buffer, &len);
+		if (!error)
+			error = len;
 	}
 	return error;
 }
@@ -1469,17 +1472,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	if (err)
 		return err;
 
-	err = security_inode_listsecurity(inode, buffer, remaining_size);
-	if (err < 0)
+	err = security_inode_listsecurity(inode, &buffer, &remaining_size);
+	if (err)
 		return err;
 
-	if (buffer) {
-		if (remaining_size < err)
-			return -ERANGE;
-		buffer += err;
-	}
-	remaining_size -= err;
-
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
 		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..3c3919dcdebc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -174,8 +174,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
 	 struct inode *inode, const char *name, void **buffer, bool alloc)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
-	 size_t buffer_size)
+LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffer,
+	 ssize_t *remaining_size)
 LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
 	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..0efc6a0ab56d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -457,7 +457,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
-int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
+int security_inode_listsecurity(struct inode *inode, char **buffer, ssize_t *remaining_size);
 void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
@@ -1077,7 +1077,8 @@ static inline int security_inode_setsecurity(struct inode *inode, const char *na
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static inline int security_inode_listsecurity(struct inode *inode,
+					char **buffer, ssize_t *remaining_size)
 {
 	return 0;
 }
diff --git a/net/socket.c b/net/socket.c
index 9a0e720f0859..52e3670dc89b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -562,15 +562,9 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 	ssize_t len;
 	ssize_t used = 0;
 
-	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
+	len = security_inode_listsecurity(d_inode(dentry), &buffer, &used);
 	if (len < 0)
 		return len;
-	used += len;
-	if (buffer) {
-		if (size < used)
-			return -ERANGE;
-		buffer += len;
-	}
 
 	len = (XATTR_NAME_SOCKPROTONAME_LEN + 1);
 	used += len;
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..3985d040d5a9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2710,22 +2710,22 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 /**
  * security_inode_listsecurity() - List the xattr security label names
  * @inode: inode
- * @buffer: buffer
- * @buffer_size: size of buffer
+ * @buffer: pointer to buffer
+ * @remaining_size: pointer to remaining size of buffer
  *
  * Copy the extended attribute names for the security labels associated with
- * @inode into @buffer.  The maximum size of @buffer is specified by
- * @buffer_size.  @buffer may be NULL to request the size of the buffer
- * required.
+ * @inode into *(@buffer).  The remaining size of @buffer is specified by
+ * *(@remaining_size).  *(@buffer) may be NULL to request the size of the
+ * buffer required. Updates *(@buffer) and *(@remaining_size).
  *
- * Return: Returns number of bytes used/required on success.
+ * Return: Returns 0 on success, or -errno on failure.
  */
 int security_inode_listsecurity(struct inode *inode,
-				char *buffer, size_t buffer_size)
+				char **buffer, ssize_t *remaining_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, remaining_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8115df536ab..e6c98ebbf7bc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3612,16 +3612,12 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	return 0;
 }
 
-static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static int selinux_inode_listsecurity(struct inode *inode, char **buffer,
+				ssize_t *remaining_size)
 {
-	const int len = sizeof(XATTR_NAME_SELINUX);
-
 	if (!selinux_initialized())
 		return 0;
-
-	if (buffer && len <= buffer_size)
-		memcpy(buffer, XATTR_NAME_SELINUX, len);
-	return len;
+	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SELINUX);
 }
 
 static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99833168604e..3f7ac865532e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1619,17 +1619,12 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
  * smack_inode_listsecurity - list the Smack attributes
  * @inode: the object
  * @buffer: where they go
- * @buffer_size: size of buffer
+ * @remaining_size: size of buffer
  */
-static int smack_inode_listsecurity(struct inode *inode, char *buffer,
-				    size_t buffer_size)
+static int smack_inode_listsecurity(struct inode *inode, char **buffer,
+				    ssize_t *remaining_size)
 {
-	int len = sizeof(XATTR_NAME_SMACK);
-
-	if (buffer != NULL && len <= buffer_size)
-		memcpy(buffer, XATTR_NAME_SMACK, len);
-
-	return len;
+	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SMACK);
 }
 
 /**
-- 
2.49.0


