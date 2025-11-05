Return-Path: <linux-fsdevel+bounces-67175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E9C36EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6752E1A211E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7D34EF10;
	Wed,  5 Nov 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBTGik+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0534EEE0;
	Wed,  5 Nov 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361708; cv=none; b=LsiqCrR/N3gQXe8nwodkmFjKAK2Yur8bonzX0oKJSIldU9iTEe/guEqYUzoXWK+fh0uqLkJ74rtQuto9aUS1ELzhY1NK7e3wQpK+xnk1BIoceYorIDva6nweV8BgHUaEzqheL7PmvRMAEIQrBtVxoCxpgldW1aI1+UKc9CC3oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361708; c=relaxed/simple;
	bh=pHQnZqDye2qaTatSgq4OXFwdAwiLQyPYO+69SCCQtfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYr8VpgxKkawxjrdTXnAkfe3aaNLfy20JMWwGBp4vbWF0SIK0SNLoBCCYhoM0+KYNTkD94smDR7ws+pXy0T0KgWQrsd9lg8eh3Ll9evt+6Pd0i0S7p5LAH1QLIrG5MoWtyxqKTIZgz8BKwrcjVsaUn2WsIPKV+wjkAs8gkkwi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBTGik+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF21DC4CEF5;
	Wed,  5 Nov 2025 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361707;
	bh=pHQnZqDye2qaTatSgq4OXFwdAwiLQyPYO+69SCCQtfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JBTGik+KGApcRDnD7tKuXfLlvy24pAkGW/q/bC63SLiap3dfvi7Vs6ett37VtjOen
	 xto6nlKVTSV4c6LZsGCdHGYiG26WAX5proiv8Z+OY5aPsMU1igjguxdPlNxRuVbi0P
	 M6E22Fu0GKuobJCoHB5MINTTmDLrHSxy9H58xqP5gPbnFrkgQdsaK0dORT10MIp0sE
	 sz2XXa6v90jPU/xEHQtg6if2It/aINMrzwc6W09RSUkFB2t3+LeLdlib0GR760XUiZ
	 Uds/IaKZsdGXVBsFhEUz+IxVikU8ZoKqsfvIxJZMSwcSbczNKJ2AzJ9cAMANUcObtj
	 ChLoRbEVH38Jw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:54:03 -0500
Subject: [PATCH v5 17/17] vfs: expose delegation support to userland
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-17-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6459; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pHQnZqDye2qaTatSgq4OXFwdAwiLQyPYO+69SCCQtfM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EtYO9g213M0+4Xu08/XD5YLvG/YRoCjGRHa
 a023/sFBO2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBLQAKCRAADmhBGVaC
 FURQD/4ooSEC0PkLMBZot7lnVw7U+E5RpTPjIttF+PRS2fFgtiPU7b1k+61+KC6ofprR9z6D3LC
 hW1FT+ESskSFFKFhpVdWnT2QTOstrQUgmAxRXcp8wbvK4KHruI7lIVPiEaZvQ31sh13EvOh3I0p
 EYMSUlXppIGTMPK22+n3Iy5N3YpnoWOyEsI8jWsoP1otSbdsBUgFfF5Tpvttyhc23Jz+0Mo+9pq
 Ia2qZc24IFGaJiRuwuFSR2n0aKaRfhCbY9AnNoepz0qozHqzAbNfj9eLEvT5i1E329tx9+RhsT0
 GcJxKnGYQymJWyCq2O6Ejcpr8IY8LdomLqk11j0KsxDcwCjXLUDreOoJK0bkowc2qRlRsREDu6G
 Uz4TkBJfqUZUPhx9+Z1W8WnZ9euI5vbXzQ4yfo0u4pelNlMi/cct5u4H/xHf5NaBLRIBopYArTX
 kBOAmkM/cDswicc6yhP8bSFGdeqbxd18uuFSugh78VgyDIDfXWFcz+YDx4HC2e9kY+jWL0yLoy/
 jDXO44D5ile0ijwAWUUffYcEBRUpcI3dXXrrLh56bLeBIm712SVpQ9Jdg4vlK3SOHg3nX9GQkkD
 /3L8R7eBKN46swf7iqCXc9zQIAjYygxEgl6MbcEoIP21XnO4hUjO6aneT5FSU5A0l0EGoP+qLRP
 d50Ibh1FhDJARgg==
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
 include/uapi/linux/fcntl.h | 10 ++++++++++
 4 files changed, 75 insertions(+), 5 deletions(-)

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
index dd290a87f58eb5d522f03fa99d612fbad84dacf3..c52f6a7b6a5c633ff0157624990d81aaa055f1ec 100644
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
+	if (deleg->d_flags != 0)
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
+	if (deleg->d_flags != 0)
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
index 3741ea1b73d8500061567b6590ccf5fb4c6770f0..8123fe70e03cfb1ba9ce1b5e20d61b62e462a7ea 100644
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
+	unsigned int	d_flags;	/* Must be 0 */
+	short		d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
+};
+
 /*
  * Types of directory notifications that may be requested.
  */

-- 
2.51.1


