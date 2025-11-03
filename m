Return-Path: <linux-fsdevel+bounces-66792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F1C2BFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66DFA4FCB8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31331A80D;
	Mon,  3 Nov 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwfojEvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85431A564;
	Mon,  3 Nov 2025 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174429; cv=none; b=eqDXfUe4BiZA/YUOUoXB+H2vGhTp71lghSuo2mEsAI7b1BH6uOo4Vj1XVzLmwCRhU6YA6Cn5vzZFaS/B9Jpl61Rg+twmp1iR5EaQQHzk4tpLEJ+16OAjwRhZoMrJ47sGLElUIELg+FWsKsIj/5+0RhB0LH5yOPuzxqS+OTiohGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174429; c=relaxed/simple;
	bh=5vnEsFLmQTNGsjzc9nlp6oQVoid1mJ5o3l9cHdo2eoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSo9f8HP68sQLgUpRROUKPuubLujBpJeoYtnjwmEeR03D0nP+1QAAegkFsyhrEp5Wziu6qmBcZOS6PW9NN2x72gO9O1ppGdpC4EwfDT6UNAsj9IKhzEKPNMmwLwyCcywsFKZ3VwWRedwsB1qlhu5eV71oCzVQU8PyWX0orpMphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwfojEvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98ECC4CEE7;
	Mon,  3 Nov 2025 12:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174428;
	bh=5vnEsFLmQTNGsjzc9nlp6oQVoid1mJ5o3l9cHdo2eoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YwfojEvQFoTNEWx92dDbQY9YwM2gMVZbl+HVm2qYIb4bEdRAKAFfXcjEUTdDW9tfA
	 7qXTMn/4SphtVmKx7owviI2gqf+g28D6onZp70Dxl2KaYswfcWV98lpmJV4MOBcgCj
	 Wag9u0li54jMktkldlTwPf3QPOYjN0yCg0ufsprjCOKUMsB4NJR9vtyx1urhXyMK/y
	 VbMFkgGAAtJPuB3kj+igWAVCsbRmSvWIaUIHNtrmv9DaM6ZAgfcKN0eMi4AwG+ZWLI
	 ooxWF6PEQPSNB5dQlfTSkYL/QkAO3JLSOnbPwqh+V5VUYE80VrSbGTba3GyIiELZIz
	 I2Ur7jxHtbysQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:45 -0500
Subject: [PATCH v4 17/17] vfs: expose delegation support to userland
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-17-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6381; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5vnEsFLmQTNGsjzc9nlp6oQVoid1mJ5o3l9cHdo2eoU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWfL5rEDvoecb6h2EtHSx6vtxVMPU49VDa09
 uywOyfKWUeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnwAKCRAADmhBGVaC
 FT1vEADNkNWiGMlbqP7jUf8X5h6MV4sgqioLwoiaAFjuRU5X4KuPCYmeDsJwj9wB/gZ4ja/oL3g
 lr2Frya3Vi29F7gQOaEIk57edySLRufmHXUcdYbA4OEPTczEiLh/gX+YaFxnddpBLYXjSUPUBCz
 GAcnAXnCfnM6S67Pld55yVeOH+A3hSTo3tUHOpZ2WxgalhLWaNaVgrzWKkF05O1fj91Ca69FeLx
 8Nk1SXdCZsF4SjEhBkUVqniNL97JKW+uL9fAUUt2n61XHohfJpZL4SSb96u+PghRlcOithDDZNW
 Yz3H+qOm2+UyrSKq/23CsCJpmPmBQJMWC3hQHgDfPKk/DmUstkYEphjo6MHP5JN/xh0xy+Fjc46
 vkcKFu0oJjyk4Cgg6N2VaSvnFlKF1CGhjTVwiyCf9S+r/NbfjkXEfTEfcuoMHVqA54X3HaL8Vei
 hVNqXr1t1/TWUJHoMFmSZdxgfdTmZ8/b1C5rnNNniSFnQcRktterb61H46ibbSoskjzhVpa5Rg6
 Npj3xwO1qGDqxlAoBqrzc4tkJcF2Z51uP8MuxufprmSzvr+n21c5g2bjvHEqoJ4BuKcsTfQMu8t
 285nYgJNzuxJzNtQbtllD1d/nd6IjJOA/4kNVIDBwbHOiqmWfk22Ekl+QIh9dbCU51bkH5cS1kk
 CX67UzGREA7+Yug==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that support for recallable directory delegations is available,
expose this functionality to userland with new F_SETDELEG and F_GETDELEG
commands for fcntl().

Note that this also allows userland to request a FL_DELEG type lease on
files too. Userland applications that do will get signalled when there
are metadata changes in addition to just data changes (which is a
limitation of FL_LEASE leases).

These commands accept a new "struct delegation" argument that contains a
flags field for future expansion.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fcntl.c                 | 14 ++++++++++++++
 fs/locks.c                 | 42 +++++++++++++++++++++++++++++++++++++-----
 include/linux/filelock.h   | 12 ++++++++++++
 include/uapi/linux/fcntl.h | 10 ++++++++++
 4 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 72f8433d9109889eecef56b32d20a85b4e12ea44..8d57a6e34076d68228b6d8d9bb381f78a751b151 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -445,6 +445,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
 	void __user *argp = (void __user *)arg;
+	struct delegation deleg;
 	int argi = (int)arg;
 	struct flock flock;
 	long err = -EINVAL;
@@ -550,6 +551,19 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_hint(filp, arg);
 		break;
+	case F_GETDELEG:
+		if (copy_from_user(&deleg, argp, sizeof(deleg)))
+			return -EFAULT;
+		fcntl_getdeleg(filp, &deleg);
+		if (copy_to_user(argp, &deleg, sizeof(deleg)))
+			return -EFAULT;
+		err = 0;
+		break;
+	case F_SETDELEG:
+		if (copy_from_user(&deleg, argp, sizeof(deleg)))
+			return -EFAULT;
+		err = fcntl_setdeleg(fd, filp, &deleg);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/locks.c b/fs/locks.c
index dd290a87f58eb5d522f03fa99d612fbad84dacf3..1e29aecf79b8df66a6c67ca5f59cec40a376b9bc 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1703,7 +1703,7 @@ EXPORT_SYMBOL(lease_get_mtime);
  *	XXX: sfr & willy disagree over whether F_INPROGRESS
  *	should be returned to userspace.
  */
-int fcntl_getlease(struct file *filp)
+static int __fcntl_getlease(struct file *filp, unsigned int flavor)
 {
 	struct file_lease *fl;
 	struct inode *inode = file_inode(filp);
@@ -1719,7 +1719,8 @@ int fcntl_getlease(struct file *filp)
 		list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
 			if (fl->c.flc_file != filp)
 				continue;
-			type = target_leasetype(fl);
+			if (fl->c.flc_flags & flavor)
+				type = target_leasetype(fl);
 			break;
 		}
 		spin_unlock(&ctx->flc_lock);
@@ -1730,6 +1731,16 @@ int fcntl_getlease(struct file *filp)
 	return type;
 }
 
+int fcntl_getlease(struct file *filp)
+{
+	return __fcntl_getlease(filp, FL_LEASE);
+}
+
+void fcntl_getdeleg(struct file *filp, struct delegation *deleg)
+{
+	deleg->d_type = __fcntl_getlease(filp, FL_DELEG);
+}
+
 /**
  * check_conflicting_open - see if the given file points to an inode that has
  *			    an existing open that would conflict with the
@@ -2039,13 +2050,13 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 }
 EXPORT_SYMBOL_GPL(vfs_setlease);
 
-static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
+static int do_fcntl_add_lease(unsigned int fd, struct file *filp, unsigned int flavor, int arg)
 {
 	struct file_lease *fl;
 	struct fasync_struct *new;
 	int error;
 
-	fl = lease_alloc(filp, FL_LEASE, arg);
+	fl = lease_alloc(filp, flavor, arg);
 	if (IS_ERR(fl))
 		return PTR_ERR(fl);
 
@@ -2081,7 +2092,28 @@ int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 
 	if (arg == F_UNLCK)
 		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
-	return do_fcntl_add_lease(fd, filp, arg);
+	return do_fcntl_add_lease(fd, filp, FL_LEASE, arg);
+}
+
+/**
+ *	fcntl_setdeleg	-	sets a delegation on an open file
+ *	@fd: open file descriptor
+ *	@filp: file pointer
+ *	@deleg: delegation request from userland
+ *
+ *	Call this fcntl to establish a delegation on the file.
+ *	Note that you also need to call %F_SETSIG to
+ *	receive a signal when the lease is broken.
+ */
+int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg)
+{
+	/* For now, no flags are supported */
+	if (deleg->d_flags != 0)
+		return -EINVAL;
+
+	if (deleg->d_type == F_UNLCK)
+		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
+	return do_fcntl_add_lease(fd, filp, FL_DELEG, deleg->d_type);
 }
 
 /**
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 208d108df2d73a9df65e5dc9968d074af385f881..4384c6f61fad8f21d15974fac1d0f77747155f0f 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -159,6 +159,8 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
 
 int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
 int fcntl_getlease(struct file *filp);
+int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg);
+void fcntl_getdeleg(struct file *filp, struct delegation *deleg);
 
 static inline bool lock_is_unlock(struct file_lock *fl)
 {
@@ -278,6 +280,16 @@ static inline int fcntl_getlease(struct file *filp)
 	return F_UNLCK;
 }
 
+static inline int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg)
+{
+	return -EINVAL;
+}
+
+static inline int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
+{
+	return F_UNLCK;
+}
+
 static inline bool lock_is_unlock(struct file_lock *fl)
 {
 	return false;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 3741ea1b73d8500061567b6590ccf5fb4c6770f0..aae88f4b5c05205b2b28ae46b21bca9817197e04 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -79,6 +79,16 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/* Set/Get delegations */
+#define F_GETDELEG		(F_LINUX_SPECIFIC_BASE + 15)
+#define F_SETDELEG		(F_LINUX_SPECIFIC_BASE + 16)
+
+/* Argument structure for F_GETDELEG and F_SETDELEG */
+struct delegation {
+	short		d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
+	unsigned int	d_flags;
+};
+
 /*
  * Types of directory notifications that may be requested.
  */

-- 
2.51.1


