Return-Path: <linux-fsdevel+bounces-64957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D4BF7672
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FF475091CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05334DCC8;
	Tue, 21 Oct 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+FmqUcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979E342CBB;
	Tue, 21 Oct 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060408; cv=none; b=J7XjfdOfmthY2S2mWK0eF7Th121cER0hdrFvdrQEZSkbDhOGT9tAXIEChASVI2uuB5RmOIInpbecbbGh8XKRd6c/U13lf3AdjfTgqU+w39JbolrA5/GTkGxb0khZH4zNC9Bq5o+WByNK26VcXkPVJKIEzaNJRslhZq433G6fpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060408; c=relaxed/simple;
	bh=WRzp2TQlTZchoT6m2ivAAefI4zmvljKPPT9tDXMZtL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hm1yfUWW+10GcotkF2gUzbd2bZkmoFSSu9OUEPm04jrHuPeTF9tj5+3HL6Xi1bOt36F3coMgCMpRkRe/yXMNuzaXHbsHtZKVhxOaIAjbF2zDQI+s5F8DQIQDF8MLGKcGWDYMDnwkmiOtyGwtwgpT6rmsxQSkPXepU5Z+/nQ+ZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+FmqUcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494E4C4CEF5;
	Tue, 21 Oct 2025 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060406;
	bh=WRzp2TQlTZchoT6m2ivAAefI4zmvljKPPT9tDXMZtL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n+FmqUcYAgkei075A/8cGIUiLqlWli+96Xn28UrYT3CQ2x9JIehk4i1bTWJMNM6o0
	 FycuYs3ytk72UthUb7vw61+Zkig10GCvhJikLfvwRLURsrNbSWwji5IhaQH1rOUxFJ
	 JQqfUYrgIvWL7HHeKLtFr10TgkIrmqyX77UIRpIfUYfnTZpeAy1o2UNEi6vUls/giS
	 b3BhGyEla/6uuIspxu0KTcvqN2ZPAHVrlxil8IZMzUXIiCIVoymNnyb1mXU7migWWc
	 gufjRskzI+bzjX4pD4w4ZmnUyJnUtNQNsUogaHShbpK0ytN4x77/9TDA28iI3wftPw
	 bZ0MGWDQtHijw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:48 -0400
Subject: [PATCH v3 13/13] vfs: expose delegation support to userland
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-13-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7870; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WRzp2TQlTZchoT6m2ivAAefI4zmvljKPPT9tDXMZtL8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YG+lqopk+r/W1MoUjb/aRCWEUcUM376vNc7
 uokTUn+zGmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBgAKCRAADmhBGVaC
 FSd9EACpg3fMTz1BEDjC8LY/SO85bg8i477SYR5KG2MrcAHKO8SUo/fZhyj8G4Nu+qBaClIlvwU
 Tq+2Hd4xxBM53VIeY/HBP5lfqDBl7MSua/mqDaekwBs4oCYwUZeVlmtq5X6nqTrxuLVCnlOstJr
 txLasYK//noELyGLZBoN1CW9UjgtHKWVPioDHi7l842TcTh1MsYT8AuwnnOlQhChhjq5+D4mSGS
 ZVOQpll1PDROw3S2/AVfqfLbvabHiUcMLW0K9e912rAvWJTIFmVyRLeFO0+psrBcT0PybZFPOnM
 +cLlwc/AVE8xt8m2bRmsY3jv5PuzY12IXO1L8N6nVTt7pYOgECHWAiO/enBlhbTZ5q8FYgizjYM
 gyliV3iKxCayC2tqKI+MTL/2tnqcaucbMbnNUONstBOZs1z0AVQJpTPPX57G/AwL0FvReZPHufz
 XqJSkPEfLZts8OslA1SOlbI8zYMVh/lNdt3Wmm1xst11oVvlN5y5RG3iXWBfPNLoIbzWO2ijFD+
 PVduCqacE96IUhreKifx5nV23dsP8Nxnl5abj+FjVx3HxEICt829mJ7C7YcgSp75wWBU84ERp7K
 3NkXd/uSHljpHMXDiCKMrSu5ubQuYJ2gtGGEV5/XZZ5Lfl9nDPlYvqspvWHspKQp2YEOJALT/G+
 WhoDrAzmlMfpl6Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that support for recallable directory delegations is complete,
expose this functionality to userland with new F_SETDELEG and F_GETDELEG
commands for fcntl(). This also allows userland to request a FL_DELEG
type lease on files too. Userland applications that do will get
signalled when there are metadata changes in addition to just data
changes (which is a limitation of FL_LEASE leases).

These commands accept a new "struct delegation" argument that contains
a flags field for future expansion.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fcntl.c                 |  9 ++++++++
 fs/locks.c                 | 53 ++++++++++++++++++++++++++++++++++++----------
 include/linux/filelock.h   | 12 +++++++++++
 include/uapi/linux/fcntl.h | 10 +++++++++
 4 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 72f8433d9109889eecef56b32d20a85b4e12ea44..f34f0a07f993f9f95a60f2954bb4304d3c218498 100644
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
@@ -550,6 +551,14 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_hint(filp, arg);
 		break;
+	case F_GETDELEG:
+		err = fcntl_getdeleg(filp);
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
index b47552106769ec5a189babfe12518e34aa59c759..fda62897e371fbc8d04b8073df3d2267d2c7c430 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -585,7 +585,7 @@ static const struct lease_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, int type, struct file_lease *fl)
+static int lease_init(struct file *filp, unsigned int flags, int type, struct file_lease *fl)
 {
 	if (assign_type(&fl->c, type) != 0)
 		return -EINVAL;
@@ -594,13 +594,13 @@ static int lease_init(struct file *filp, int type, struct file_lease *fl)
 	fl->c.flc_pid = current->tgid;
 
 	fl->c.flc_file = filp;
-	fl->c.flc_flags = FL_LEASE;
+	fl->c.flc_flags = flags;
 	fl->fl_lmops = &lease_manager_ops;
 	return 0;
 }
 
 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lease *lease_alloc(struct file *filp, int type)
+static struct file_lease *lease_alloc(struct file *filp, unsigned int flags, int type)
 {
 	struct file_lease *fl = locks_alloc_lease();
 	int error = -ENOMEM;
@@ -608,7 +608,7 @@ static struct file_lease *lease_alloc(struct file *filp, int type)
 	if (fl == NULL)
 		return ERR_PTR(error);
 
-	error = lease_init(filp, type, fl);
+	error = lease_init(filp, flags, type, fl);
 	if (error) {
 		locks_free_lease(fl);
 		return ERR_PTR(error);
@@ -1548,10 +1548,9 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
 
-	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
+	new_fl = lease_alloc(NULL, type, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
-	new_fl->c.flc_flags = type;
 
 	/* typically we will check that ctx is non-NULL before calling */
 	ctx = locks_inode_context(inode);
@@ -1697,7 +1696,7 @@ EXPORT_SYMBOL(lease_get_mtime);
  *	XXX: sfr & willy disagree over whether F_INPROGRESS
  *	should be returned to userspace.
  */
-int fcntl_getlease(struct file *filp)
+static int __fcntl_getlease(struct file *filp, unsigned int flavor)
 {
 	struct file_lease *fl;
 	struct inode *inode = file_inode(filp);
@@ -1713,7 +1712,8 @@ int fcntl_getlease(struct file *filp)
 		list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
 			if (fl->c.flc_file != filp)
 				continue;
-			type = target_leasetype(fl);
+			if (fl->c.flc_flags & flavor)
+				type = target_leasetype(fl);
 			break;
 		}
 		spin_unlock(&ctx->flc_lock);
@@ -1724,6 +1724,16 @@ int fcntl_getlease(struct file *filp)
 	return type;
 }
 
+int fcntl_getlease(struct file *filp)
+{
+	return __fcntl_getlease(filp, FL_LEASE);
+}
+
+int fcntl_getdeleg(struct file *filp)
+{
+	return __fcntl_getlease(filp, FL_DELEG);
+}
+
 /**
  * check_conflicting_open - see if the given file points to an inode that has
  *			    an existing open that would conflict with the
@@ -2033,13 +2043,13 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 }
 EXPORT_SYMBOL_GPL(vfs_setlease);
 
-static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
+static int do_fcntl_add_lease(unsigned int fd, struct file *filp, unsigned int flavor, int arg)
 {
 	struct file_lease *fl;
 	struct fasync_struct *new;
 	int error;
 
-	fl = lease_alloc(filp, arg);
+	fl = lease_alloc(filp, flavor, arg);
 	if (IS_ERR(fl))
 		return PTR_ERR(fl);
 
@@ -2075,7 +2085,28 @@ int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 
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
index c2ce8ba05d068b451ecf8f513b7e532819a29944..69b8fa8dce35dab670e6c7b288e13dc4caed1bc0 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -159,6 +159,8 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
 
 int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
 int fcntl_getlease(struct file *filp);
+int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg);
+int fcntl_getdeleg(struct file *filp);
 
 static inline bool lock_is_unlock(struct file_lock *fl)
 {
@@ -271,6 +273,16 @@ static inline int fcntl_getlease(struct file *filp)
 	return F_UNLCK;
 }
 
+static inline int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg)
+{
+	return -EINVAL;
+}
+
+static inline int fcntl_getdeleg(struct file *filp)
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
2.51.0


