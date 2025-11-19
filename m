Return-Path: <linux-fsdevel+bounces-69095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D9C6EF8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id AF7DF28DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC535FF7F;
	Wed, 19 Nov 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktexG/gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAE3612E9;
	Wed, 19 Nov 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559763; cv=none; b=KxsmOdzLJJ4j8N2biA1ifO5Vc2Ux1LCpcblcW2h2uaFqaSm0PKn5Wo9IOjBZMzRC6qy2WmVDq2wEzIF9kW//2VJAfWO6HIxB6nEgDAOh7Be1Y8FkR4X82xiyeTxCHhm1wEFLcPll/0QeNC9R/eoJsEoDUhf3N6Kggrje6CP68iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559763; c=relaxed/simple;
	bh=bOsgYjPeUMmPlZY4cRL+96QYFL7r0WVAw5+qEW5Suvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/KpCMWrax3vuSD8GxiAGrsM6tY6TkoOsBXhS3M+6aFwUbrT+CQYS4f69QEkNwjswYYrpS5Mu9V4qbW+gRkT87jNGMPzgWBjH+jEFSkNR5aK+TTCjKGPPVORHlDSA4VMkjgW7mZc8UvItGmrpkxUyQRXfecOh4RGOl0RuZG5tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktexG/gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00DCC2BCB6;
	Wed, 19 Nov 2025 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559762;
	bh=bOsgYjPeUMmPlZY4cRL+96QYFL7r0WVAw5+qEW5Suvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ktexG/gu+z6XOVhONgGEnD7abxAfddd09s5oKjiVzfcugnDli9klLcxc/2YdAxNUb
	 UVgfsjSGiGQ8G/h1zqZLWUI1auozQwEpVBezxJBcCOPnFmCPI7wwy0dNWg7QnSQ6/J
	 O2B+6Uw22hdUXsUG8tk3fN0LnkNKAqWsgl3ZdGkaQagO5dYn+VcIlOVgQuV8MZZf0T
	 CMKNKLkmSaOIPHj4DwidUPUCprDZmrQhyYXR0Y78DC6ckN9NnGErHtV5lLBsX3fFFk
	 J6hAychofZXBymPZIXkEqt5PhXPiKmMeSTHhPOW+mqcS/E/eM8fApyVpPCBXvjtAOy
	 Ik+7LPTVfqNOw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Nov 2025 08:42:18 -0500
Subject: [PATCH v8 1/3] vfs: expose delegation support to userland
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-dir-deleg-ro-v8-1-81b6cf5485c6@kernel.org>
References: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
In-Reply-To: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8057; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bOsgYjPeUMmPlZY4cRL+96QYFL7r0WVAw5+qEW5Suvo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHclPCvJ5fmEIyYv3UXwu8nHA70rNSfvoCSU9S
 dVvU8TyOjyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3JTwAKCRAADmhBGVaC
 Fb3xEADDya80yW/Om5bTNCsIwU6GnQKVhTTWAs/UBbdLSAhfpjFlKi1hoIjGlGiWh9ZT+u2qtXV
 PPkr4yZpxzlXpogyRuitbr8jjr7lb9qJQtydxcGkj23BEbQ6PXGEsi+sX3I4vnLnPUpGZD45LGt
 0jqUDiG/yRb7HuToswrJtsVRQ04FgT+IdtpKzIe7OFlHOR1wub/xEcwhrPAhUrsSU3AGVre4Mpp
 7W7XM0v6ZMDandGkUHrRxHaj9xiTogyA/03xvP0k3Ep2qu9Rjd8H0C3BwjXVnMUpXI/bRhcM72P
 WtSMhT98T7EOWZW63+w7zaH03PBVwiBDLfOc96GlgVkSUDCMVPYGmxLiHfVNt3Z/rmcRd9ez5WW
 opgq7pmlAKJ1vxH+CVytXDKIt+QTHtS9uZQJT1HhzY888EmzjTKxEnbTAM3m8En6kujOG73WJtq
 a3txsWVfi306svANoE13i17Y264/ZucAbp1SkD/0oxrrd2k/6Q6ut13zJzsMH7pcBE8rZGHJipA
 p37PdOak1YunT1MElZolsy8KqtYy5DfH/dXIc06BmVNwIsMmFoVIYLs6UjUpuUg9qMiTrc7Xbft
 KuAja0MkTqmLU3HOk5505Dy27KmHtlemChPxpfevisJXqYseHRng9umpIxrbddM/Vjmz2048K/B
 5gUwWl8D5f1v8Sw==
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
Link: https://patch.msgid.link/20251111-dir-deleg-ro-v6-17-52f3feebb2f2@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fcntl.c                 | 13 +++++++
 fs/locks.c                 | 94 ++++++++++++++++++++++++++++++++++------------
 include/linux/filelock.h   | 12 ++++++
 include/uapi/linux/fcntl.h | 16 ++++++++
 4 files changed, 110 insertions(+), 25 deletions(-)

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
index dd290a87f58eb5d522f03fa99d612fbad84dacf3..3df07871b5ab7bbe883cdd8fba822d130282da8e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1680,6 +1680,34 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 }
 EXPORT_SYMBOL(lease_get_mtime);
 
+static int __fcntl_getlease(struct file *filp, unsigned int flavor)
+{
+	struct file_lease *fl;
+	struct inode *inode = file_inode(filp);
+	struct file_lock_context *ctx;
+	int type = F_UNLCK;
+	LIST_HEAD(dispose);
+
+	ctx = locks_inode_context(inode);
+	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
+		percpu_down_read(&file_rwsem);
+		spin_lock(&ctx->flc_lock);
+		time_out_leases(inode, &dispose);
+		list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+			if (fl->c.flc_file != filp)
+				continue;
+			if (fl->c.flc_flags & flavor)
+				type = target_leasetype(fl);
+			break;
+		}
+		spin_unlock(&ctx->flc_lock);
+		percpu_up_read(&file_rwsem);
+
+		locks_dispose_list(&dispose);
+	}
+	return type;
+}
+
 /**
  *	fcntl_getlease - Enquire what lease is currently active
  *	@filp: the file
@@ -1705,29 +1733,24 @@ EXPORT_SYMBOL(lease_get_mtime);
  */
 int fcntl_getlease(struct file *filp)
 {
-	struct file_lease *fl;
-	struct inode *inode = file_inode(filp);
-	struct file_lock_context *ctx;
-	int type = F_UNLCK;
-	LIST_HEAD(dispose);
-
-	ctx = locks_inode_context(inode);
-	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
-		percpu_down_read(&file_rwsem);
-		spin_lock(&ctx->flc_lock);
-		time_out_leases(inode, &dispose);
-		list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
-			if (fl->c.flc_file != filp)
-				continue;
-			type = target_leasetype(fl);
-			break;
-		}
-		spin_unlock(&ctx->flc_lock);
-		percpu_up_read(&file_rwsem);
+	return __fcntl_getlease(filp, FL_LEASE);
+}
 
-		locks_dispose_list(&dispose);
-	}
-	return type;
+/**
+ * fcntl_getdeleg - enquire what sort of delegation is active
+ * @filp: file to be tested
+ * @deleg: structure where the result is stored
+ *
+ * Returns 0 on success or errno on failure. On success,
+ * deleg->d_type will contain the type of currently set lease
+ * (F_RDLCK, F_WRLCK or F_UNLCK).
+ */
+int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
+{
+	if (deleg->d_flags != 0 || deleg->__pad != 0)
+		return -EINVAL;
+	deleg->d_type = __fcntl_getlease(filp, FL_DELEG);
+	return 0;
 }
 
 /**
@@ -2039,13 +2062,13 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
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
 
@@ -2081,7 +2104,28 @@ int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 
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
index 3741ea1b73d8500061567b6590ccf5fb4c6770f0..5e277fd955aae50fa59e93f23d462415ac0ca171 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -4,6 +4,11 @@
 
 #include <asm/fcntl.h>
 #include <linux/openat2.h>
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -79,6 +84,17 @@
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


