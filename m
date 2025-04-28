Return-Path: <linux-fsdevel+bounces-47539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF661A9FA52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067CB1A85FDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51321AF0B4;
	Mon, 28 Apr 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guigTfFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543D23C9;
	Mon, 28 Apr 2025 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871320; cv=none; b=XrSo4sCq9WMF/1oF9Qugu3o33qDqUAUNny5z2WCQTPW0JCfvcgtljiFJB+cDp8kyNvAbA9FkWBYOBmAyzj7Elgpzvwyk1AVacTiOJSe3dtIpx8xZzK0rPfdNrv/E1zUjKW/qvQakAHnK9UqW+kHtz+e6eUca9W7b7ndSWC0Su3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871320; c=relaxed/simple;
	bh=7eobBzQqN4HNMyhKQ+/dQH6xVTxkj2pXU4HMJHKjGBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIT/7XUvLyim5aS9ExwbQ+D2hfetFo5MsFGaWwp6O9jwURqa+WURoAncibZGA1BBnwU1QUx3+DjmcOA/1DfkFH1IhxFHihOqIYR5LCFWv6XofnZQw93MHta9TkfscwNBSfA2DsalCeeCvxRLOKLlNr9JLG9OLcET/VFUS6h6ZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guigTfFn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47ae894e9b7so114791361cf.3;
        Mon, 28 Apr 2025 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745871315; x=1746476115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkfZcfzzBiDH8faCF+27QhjG8w+VTH8k8055ar9MiOM=;
        b=guigTfFnQnukgFqC9c4QhROIH4G9QbRvOZpXG9/AhYeVUZi65v6MIxpO7Byf/rXTn5
         TPnt6GLF5wOR+Vyuj4myLPoy56tKQlcb/oeDtDLWOgoi/SNlTCZUnB7kHAEK1p5o4XZ5
         Ls9n4z5uhIUcEcKCxxjmlPB7/as9zGrL+ECLsqZ3sUPlKJxJYp23r8c1XOo4z5w1F/b6
         MWlRtrE9tgNyeYytVr1akYV8O1jfksq2Cz3rWHmXvaCVCtfgMXbdqw5r6OMBx1qadVPv
         m8MwucZh6N6XpKsmAbZGcrjZcZbpWRIMSUW5fSIbfkzgq7z2W/vL64xgpV1QPDSWUmkQ
         dxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871315; x=1746476115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkfZcfzzBiDH8faCF+27QhjG8w+VTH8k8055ar9MiOM=;
        b=Dqv44qk8FfrxVlZyMo/x30TwCu7ITl1JAlBHDWikmg9DNGgZR1PZqqY78gCCE24ghu
         hEm+fqr8mq3LMpzOuC8n/RxbHkFvrwFxhoiCYMlf74mdvJp2Q8a4sF1w4pm1O1zO2U+B
         L54qIJu0N3MugGtZ9NX4TKM2L5KCMOhuOs7eiuPlEUHRz7B+XxgM14GBbGxuSPBGoMob
         0OyBiRKkRuOoDfUWXdTTjuYQTNUp8fMc+EbP/7vb9pZRnIbJw2XAWU9h002joEYxh36F
         o9l2jcwzNba22muRkHnxYWeiUy2IuB33mpsjaFxCWclmfQR+dCviF7hstBxmxi6pftxs
         eq6w==
X-Forwarded-Encrypted: i=1; AJvYcCUh03+QS7vBGo0yqS5tF+W+nBZWxFGevwzz0DaVzPUXQYwvfm6tDf7hAtkBWrlLw1I8w8IigLRP@vger.kernel.org, AJvYcCVgWldiZoAQH8U72Mj00l+Qgrf7E6DvDLATzEogK/f+KFJQyR/fa6W25lnjrA0NjqtqaEq+6l7TMw==@vger.kernel.org, AJvYcCX/t8pQP4cBdOl9V/0d/MwSZTmspvyqKGkyJTKXJSpHHC7iM1Q5ufpczwFnDUkNQFwftx9TH/ZwMmuUH8P3@vger.kernel.org, AJvYcCXCexf+gzif+kPxC1ugaI+72q1I0a4bZEST/jsOvYHWRfXeaPzoTNj/PEFt5cnMNFooidWf/mUeUv4Q@vger.kernel.org, AJvYcCXI4S9z33QquKbYJpm1h3T411y9Z0FTIwZYLb+ZvrvpC9sR0/ueGGjU/AZmwzfsOTVLFLSOMG7hlcj0lkBVSg+C8Z4YiAgT@vger.kernel.org, AJvYcCXnYfyFhJAQMzWae/6KWlfaqM4/Zbj6j4qc/8HRJx1coKUW/tjKosY39jRH1xgY8XM1+ItozqIufzH6VK4Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCtOOxeROdgYbq/T47LPhqNmnA1FTUtZiR4URMfJ7ZLksEG4O
	1aozQh98wFBKd/HzVjnEbWydXiuZBHvXQ/lHsput35isLHyFvIrT
X-Gm-Gg: ASbGnctaJAmUmvwUZ6exbiIeBJyhfwuL3TT4h0VNI5vq78afG8C9TOzxVyk4Ek32GRg
	GyU75f44hchpYUCbg1Tx6NDBV/SaDN/VeTzYzbciAN/bTEfkAqa0cjHhcbjW3bSzgJge9PJeVz4
	X8acBkStWVq0GwRqu9Avg24mkhwxNQD9MvJNifG5C8DENslZePLoHRHKyL8GaHV6wFuflVxprVS
	3/P/U8sbMf39dhty1AO77oDsghvUU9giMjkk3IRSCeY4DQ6pZBwVkIT3cpAJfaBScf2gMmSvmhk
	bIIasnM0ncrBW72LszCKAyLGeZrinknl5z+0xYponCG3q0SfKHA1LHiV1jE0JewJk/72juVzIPk
	QL5sJJoYJXK2oteAY+zwilxhMFEZYZ1Q927IYvi9eYT9SQdOSUVKuLc1jry7n4eRK+tL9
X-Google-Smtp-Source: AGHT+IGFQWMTKoT2tNkGrF7UZsx6phPpBMGBgRckUMhIYKDPBp78LzqrBzYVWo5FQneUANSHSRsU6g==
X-Received: by 2002:a05:6214:21cc:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6f4d1eef321mr192627306d6.7.1745871315015;
        Mon, 28 Apr 2025 13:15:15 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0a73d63sm64707846d6.86.2025.04.28.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:15:14 -0700 (PDT)
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
Subject: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity() interface
Date: Mon, 28 Apr 2025 15:50:19 -0400
Message-ID: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
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

 fs/nfs/nfs4proc.c             | 10 ++++++----
 fs/xattr.c                    | 19 +++++++------------
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      |  5 +++--
 net/socket.c                  | 17 +++++++----------
 security/security.c           | 16 ++++++++--------
 security/selinux/hooks.c      | 10 +++-------
 security/smack/smack_lsm.c    | 13 ++++---------
 8 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..6168a35cbd15 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8023,12 +8023,14 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 static ssize_t
 nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 {
-	int len = 0;
+	ssize_t len = 0;
 
 	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
-		len = security_inode_listsecurity(inode, list, list_len);
-		if (len >= 0 && list_len && len > list_len)
-			return -ERANGE;
+		ssize_t remaining = list_len;
+
+		len = security_inode_listsecurity(inode, &list, &remaining);
+		if (!len)
+			len = list_len - remaining;
 	}
 	return len;
 }
diff --git a/fs/xattr.c b/fs/xattr.c
index 2fc314b27120..78387acab31b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -492,9 +492,11 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
-		error = security_inode_listsecurity(inode, list, size);
-		if (size && error > size)
-			error = -ERANGE;
+		ssize_t remaining = size;
+
+		error = security_inode_listsecurity(inode, &list, &remaining);
+		if (!error)
+			error = size - remaining;
 	}
 	return error;
 }
@@ -1469,17 +1471,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
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
index 9a0e720f0859..bbcaa3371fcd 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -560,17 +560,14 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 				size_t size)
 {
 	ssize_t len;
-	ssize_t used = 0;
+	ssize_t used, remaining;
+	int err;
 
-	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
-	if (len < 0)
-		return len;
-	used += len;
-	if (buffer) {
-		if (size < used)
-			return -ERANGE;
-		buffer += len;
-	}
+	err = security_inode_listsecurity(d_inode(dentry), &buffer,
+					  &remaining);
+	if (err)
+		return err;
+	used = size - remaining;
 
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


