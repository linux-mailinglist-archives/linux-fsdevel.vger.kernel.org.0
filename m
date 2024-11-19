Return-Path: <linux-fsdevel+bounces-35183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA49D22B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 10:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADE91F2146D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28771C2337;
	Tue, 19 Nov 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmrDGZeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1014AD24;
	Tue, 19 Nov 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009578; cv=none; b=lEK43DJdTxOhUKjhuOMUpV1A1ATK5DAH3pp2upJIhojlIN4IfxVhgwWwW0AfqsLBgpu3hhrR1vFof614y6FcbX/NO4o+AAy10E8hscQuxN0lEgmqF6L1oui94fqX1a9kySkD5zNYHKJ93IXFkrmPp/w0AI7X6azRc/soZhuH5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009578; c=relaxed/simple;
	bh=Aqm33//0M4n/QeEu7byuSoQ6drD5r7B3WtfM0xIZfSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK+xc20yqA37ymXsj4XT7kDBDruhXmlVrMcgJsRcGjsuxbhTLWx8Vb/YFASZMJcaSH1y33RdYrVfrmUS/UVsWREKNUtuRz4BpCQHJr26RUHzKU2rb6KK0VB4FriCnxYsS2AE8L0XbzocOchbkr6kmr6jpfC+pLIHh4kQwPgHI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmrDGZeR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ee097a478so212105066b.2;
        Tue, 19 Nov 2024 01:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732009575; x=1732614375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k+LOXLkuwwtIxGlSwTxzA89tsnqiig0usDZlI6j5Rc=;
        b=BmrDGZeREgDEOfL6VTVlqq4RvE2e0VXux+4AmSnoJSVwsPkdrD71+d7WA5j9m+oiIe
         BMzh8Tmn5X44v0HZRg1O0G5iwnZ2TL1BG/66BAw9X5mE+f7BiTeowx2tU6hk3lKBJ70b
         dmiTDt4PXmejMXETQUsbOPcXHsW5Y5B/gWNrOltAClFTSXiTysSJPMmCM11ZFIJ6oOFW
         3al3IT/y7VL9IqfPm1k08nY5XBHtizdpyvc3ur5A0PrHPfVsgdFR4qb1WvYekk8i5ANB
         T1XfTG8reBF2tXmdCtZWkL/BA44hZDC3W5NPUonfZBKP82GmFoorRS1fbeIGlo9dWU3A
         By3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009575; x=1732614375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k+LOXLkuwwtIxGlSwTxzA89tsnqiig0usDZlI6j5Rc=;
        b=nh/AHwFPcnbxyB7Ir73BQFual6CAQxl+TTvz3nCKTWZDcHpSHYJmQNDG64qaU56CFn
         pcN4nmmBleDTjIy5r5ptB8mesJiROvpBY5iBsyz1ST1CiBH061nkYW3+EPzKhiAsONgE
         Q4BZAedEJL0F+YwxVa4UJNQO1nk07tZX1SXCjAjRiXT57r+YI1LKk8rfhiMMJ8qm5NuH
         uRcGtX8h/zbjHXLKmSONVNQlv/4C23Jfj+iqqvyN8uNPpE1qroUDdEDo6kYC0XmsZcwU
         kcHtGt+LvQVKOce8wCXKANOjAbxLvl+bZ+kRDM1WDhZ+/iljKqjayzFCxZ/baQyBpQ91
         tOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3WFtrDsigrpyZp2JRkR0QaoGV2gvW+qxF8kOlBde7Nj+6bT7JIcb1fj0wB2njU/7u4Srlxl+znScVsEUa@vger.kernel.org, AJvYcCWJY5HrNyZBIyNp/7HEkcN29SMEmmh2BpfMPS6DYRizB7eT/IOGyngF4NoIqQrhVg1aGoV+XW0819ZHn0sv5A==@vger.kernel.org, AJvYcCXGLy1tbZNzQkv20yPcV29sGuN9jczvJ9ZB/saE9ZrJlwgqEbH3HK8AD2jytIbAZJsu23z7C93fnd3Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcKLbMhOtXdSOBo3rFj/8LKc9rUjS4KpoSIxAamfcWeb1iv2g
	lgZj8uduF7zwKN+RLYnM6oJnv6paARjlCAdZu05NgPes5/VpfjI0
X-Google-Smtp-Source: AGHT+IHq3gRQkbq4vilVBjoFrqlc2rP/Dxb0QaL818D1CYDKfch0hN3L/I87OgXz6zPDisBWU8VEfw==
X-Received: by 2002:a05:6402:524d:b0:5cf:c1a3:b109 with SMTP id 4fb4d7f45d1cf-5cfc1a3b3d8mr8659092a12.2.1732009574442;
        Tue, 19 Nov 2024 01:46:14 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfcb3edce9sm1821154a12.35.2024.11.19.01.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:46:13 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/3] vfs: support caching symlink lengths in inodes
Date: Tue, 19 Nov 2024 10:45:53 +0100
Message-ID: <20241119094555.660666-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119094555.660666-1-mjguzik@gmail.com>
References: <20241119094555.660666-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
speed up when issuing readlink on /initrd.img on ext4.

Filesystems opt in by calling inode_set_cached_link() when creating an
inode.

The size is stored in what used to be a 4-byte hole. If necessary the
field can be made smaller and converted into a union with something not
used with symlinks.

Churn-wise the current readlink_copy() helper is patched to accept the
size instead of calculating it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c                     | 34 +++++++++++++++++++---------------
 fs/proc/namespaces.c           |  2 +-
 include/linux/fs.h             | 12 ++++++++++--
 security/apparmor/apparmorfs.c |  2 +-
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..e56c29a22d26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5272,19 +5272,16 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newna
 				getname(newname), 0);
 }
 
-int readlink_copy(char __user *buffer, int buflen, const char *link)
+int readlink_copy(char __user *buffer, int buflen, const char *link, int linklen)
 {
-	int len = PTR_ERR(link);
-	if (IS_ERR(link))
-		goto out;
+	int copylen;
 
-	len = strlen(link);
-	if (len > (unsigned) buflen)
-		len = buflen;
-	if (copy_to_user(buffer, link, len))
-		len = -EFAULT;
-out:
-	return len;
+	copylen = linklen;
+	if (unlikely(copylen > (unsigned) buflen))
+		copylen = buflen;
+	if (copy_to_user(buffer, link, copylen))
+		copylen = -EFAULT;
+	return copylen;
 }
 
 /**
@@ -5304,6 +5301,9 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 	const char *link;
 	int res;
 
+	if (inode->i_opflags & IOP_CACHED_LINK)
+		return readlink_copy(buffer, buflen, inode->i_link, inode->i_linklen);
+
 	if (unlikely(!(inode->i_opflags & IOP_DEFAULT_READLINK))) {
 		if (unlikely(inode->i_op->readlink))
 			return inode->i_op->readlink(dentry, buffer, buflen);
@@ -5322,7 +5322,7 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 		if (IS_ERR(link))
 			return PTR_ERR(link);
 	}
-	res = readlink_copy(buffer, buflen, link);
+	res = readlink_copy(buffer, buflen, link, strlen(link));
 	do_delayed_call(&done);
 	return res;
 }
@@ -5391,10 +5391,14 @@ EXPORT_SYMBOL(page_put_link);
 
 int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
+	const char *link;
+	int res;
+
 	DEFINE_DELAYED_CALL(done);
-	int res = readlink_copy(buffer, buflen,
-				page_get_link(dentry, d_inode(dentry),
-					      &done));
+	link = page_get_link(dentry, d_inode(dentry), &done);
+	res = PTR_ERR(link);
+	if (!IS_ERR(link))
+		res = readlink_copy(buffer, buflen, link, strlen(link));
 	do_delayed_call(&done);
 	return res;
 }
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..c610224faf10 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -83,7 +83,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
-			res = readlink_copy(buffer, buflen, name);
+			res = readlink_copy(buffer, buflen, name, strlen(name));
 	}
 	put_task_struct(task);
 	return res;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 972147da71f9..30e332fb399d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -626,6 +626,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_XATTR	0x0008
 #define IOP_DEFAULT_READLINK	0x0010
 #define IOP_MGTIME	0x0020
+#define IOP_CACHED_LINK	0x0040
 
 /*
  * Keep mostly read-only and often accessed (especially for
@@ -686,7 +687,7 @@ struct inode {
 
 	/* Misc */
 	u32			i_state;
-	/* 32-bit hole */
+	int			i_linklen;	/* for symlinks */
 	struct rw_semaphore	i_rwsem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
@@ -749,6 +750,13 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
+{
+	inode->i_link = link;
+	inode->i_linklen = linklen;
+	inode->i_opflags |= IOP_CACHED_LINK;
+}
+
 /*
  * Get bit address from inode->i_state to use with wait_var_event()
  * infrastructre.
@@ -3351,7 +3359,7 @@ extern const struct file_operations generic_ro_fops;
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
 
-extern int readlink_copy(char __user *, int, const char *);
+extern int readlink_copy(char __user *, int, const char *, int);
 extern int page_readlink(struct dentry *, char __user *, int);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 01b923d97a44..60959cfba672 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2611,7 +2611,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
 	res = snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
 		       d_inode(dentry)->i_ino);
 	if (res > 0 && res < sizeof(name))
-		res = readlink_copy(buffer, buflen, name);
+		res = readlink_copy(buffer, buflen, name, strlen(name));
 	else
 		res = -ENOENT;
 
-- 
2.43.0


