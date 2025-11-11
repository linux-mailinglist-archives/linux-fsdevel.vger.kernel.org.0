Return-Path: <linux-fsdevel+bounces-67954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF9C4E73F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F043F3ACE82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E20B36C5B6;
	Tue, 11 Nov 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l15myyQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E236C59A;
	Tue, 11 Nov 2025 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870443; cv=none; b=ag+VwmvkdMVTeKRZXDa18VuSjyN0iB6S56/pecTRdylOoVQ7eoNzogzK2pn1fUoWhWWrxXstsaqfujoJKejzSDojOJM7jFHCh7+PbMrDsJJp5bFtuk2LOLozCDLwvt5TcXt8yDUwtqoPEvE6d6UNgXBw3z7o2UfKRq0AyV+kcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870443; c=relaxed/simple;
	bh=WdewGaiNuFLjHV1a6vCFo/mDFJ2AWK1PFe+Yl6HB3Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr2+r9Q7SwfHi3K7CshA3FjCficCwZYKOJqd5GNKFo1wUSlVdGjIV3x6RbJAXR19TiFRb9KUdrDofKeya3leu0AVWCxEnFEwxtiMXkDaD80ERdzdoSdiyziu6TtQbP7u8IEjyNybPRVj9iilO0TWXGRyKANgSMvN7xQ+exmM6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l15myyQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF65C4CEF7;
	Tue, 11 Nov 2025 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870442;
	bh=WdewGaiNuFLjHV1a6vCFo/mDFJ2AWK1PFe+Yl6HB3Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l15myyQIerMvxjgtiRi6NwuRnkXFNTFcl60S3EzEy5KHr7vD5SJE25gbpJBLscxRe
	 tZ+TF5RNMOPAgumvBWteGwwBJqcf/CpQtr1SDnn2Rjrtj9qBBzArMZhh9ddqoy+CjD
	 rvTeM4E+m/QTBMkeNes1o7UL6DzVXut+2zpjb68DQap317Td29xpx5LijMTQkSRYKl
	 u362c7yWxTpdQpWZRy4Cy44JvutBF7vCD8hQbVAdRMSv7eWTv3fv3e+VkGXDNHcVET
	 +oXc4M7SafwrMJyCrtHM68p4NBgut2PRkYGSmg89k3LjKveh8qwKqXKPJD+iUnEfw9
	 4Rcb0wgf3KpcQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:58 -0500
Subject: [PATCH v6 17/17] vfs: expose delegation support to userland
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-17-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
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
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6536; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WdewGaiNuFLjHV1a6vCFo/mDFJ2AWK1PFe+Yl6HB3Sk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0Rqurk9cWPo6zP4fAmosJ6He97p9pqHQES7s
 Z06KXXBPjWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEagAKCRAADmhBGVaC
 FTB/EACh5AspYIZTqRbll6q3mdwbK586tz7VH6SHn0JNvaDbeCV5/kAN0/r/8NI5lSY/RXE9gfA
 NjDm600CiqSZi94ckvFWfZdcUb/cwo7kbMk4UQHL+JH8fcRjqE1v2KGmf8gFejRebq7xo4/BxLa
 3r+EIRxQoWimgPyhqtSPeBGqq2KOdBrYWqzAB6NZdULUezfg4g5aHo7aPxHtn4P0n4ZUMIdpJ8J
 7z0K+s6lGWBNtXTFb3pSiNF7NXM3amOPp4TYrxSMmigVmvBD/kdoy2UOyGr4hMWx/DawdzNuBxQ
 vwgik4WPHaUMdUZBS+7wPoEJnDML2IRdKFET2wLPlN6X/Xf4vA3t4sC7Z0g+u8gFNjKLB0S+6O0
 rM58JVJ8PvU4+PAUQsabbYf0YWm+49DC03SLQrOKX/oNFKaP1PSJFmzzqH/I1Tu0xd8usz4Lzvn
 HPjh1KW+KhUOtuUphSu/+eCRdEOc3vU9X9QYvPeSLdFurXnezJvxuEedvoaYop03JBRZ3kZzo/H
 Sr4QfnmZ+D7XqOdSPKDdz5IplJfDj71bOagfmFVc5ckULbrLCbrGmeESpfEqEqNbtiTVmq8QRX+
 AChQAZDZPCkee/EMaXoyb3CsgpEUzjpyhGQSFi6zLmXSviCpp4yfqo3tkyxqpoqiakzaqXVIzui
 g4ecbM/7WKg19EQ==
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
 fs/fcntl.c                 | 13 +++++++++++++
 fs/locks.c                 | 45 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/filelock.h   | 12 ++++++++++++
 include/uapi/linux/fcntl.h | 11 +++++++++++
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 72f8433d9109889eecef56b32d20a85b4e12ea44..f93dbca0843557d197bd1e023519cfa0f00ad78f 100644
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
@@ -550,6 +551,18 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_hint(filp, arg);
 		break;
+	case F_GETDELEG:
+		if (copy_from_user(&deleg, argp, sizeof(deleg)))
+			return -EFAULT;
+		err = fcntl_getdeleg(filp, &deleg);
+		if (!err && copy_to_user(argp, &deleg, sizeof(deleg)))
+			return -EFAULT;
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
index dd290a87f58eb5d522f03fa99d612fbad84dacf3..7f4ccc7974bc8d3e82500ee692c6520b53f2280f 100644
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
@@ -1730,6 +1731,19 @@ int fcntl_getlease(struct file *filp)
 	return type;
 }
 
+int fcntl_getlease(struct file *filp)
+{
+	return __fcntl_getlease(filp, FL_LEASE);
+}
+
+int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
+{
+	if (deleg->d_flags != 0 || deleg->__pad != 0)
+		return -EINVAL;
+	deleg->d_type = __fcntl_getlease(filp, FL_DELEG);
+	return 0;
+}
+
 /**
  * check_conflicting_open - see if the given file points to an inode that has
  *			    an existing open that would conflict with the
@@ -2039,13 +2053,13 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
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
 
@@ -2081,7 +2095,28 @@ int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 
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
+	if (deleg->d_flags != 0 || deleg->__pad != 0)
+		return -EINVAL;
+
+	if (deleg->d_type == F_UNLCK)
+		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
+	return do_fcntl_add_lease(fd, filp, FL_DELEG, deleg->d_type);
 }
 
 /**
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 208d108df2d73a9df65e5dc9968d074af385f881..54b824c05299261e6bd6acc4175cb277ea35b35d 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -159,6 +159,8 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
 
 int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
 int fcntl_getlease(struct file *filp);
+int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg);
+int fcntl_getdeleg(struct file *filp, struct delegation *deleg);
 
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
+	return -EINVAL;
+}
+
 static inline bool lock_is_unlock(struct file_lock *fl)
 {
 	return false;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 3741ea1b73d8500061567b6590ccf5fb4c6770f0..008fac15e573084a9b48e4e991528b4363c54047 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -79,6 +79,17 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/* Set/Get delegations */
+#define F_GETDELEG		(F_LINUX_SPECIFIC_BASE + 15)
+#define F_SETDELEG		(F_LINUX_SPECIFIC_BASE + 16)
+
+/* Argument structure for F_GETDELEG and F_SETDELEG */
+struct delegation {
+	uint32_t	d_flags;	/* Must be 0 */
+	uint16_t	d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
+	uint16_t	__pad;		/* Must be 0 */
+};
+
 /*
  * Types of directory notifications that may be requested.
  */

-- 
2.51.1


