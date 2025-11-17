Return-Path: <linux-fsdevel+bounces-68722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF0C64609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B53EF36400F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3C331A69;
	Mon, 17 Nov 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW4FrsJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5ED331218;
	Mon, 17 Nov 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386042; cv=none; b=E/ENmDVRkhPkAOSXcgBHis6zroNkwt38/Vk5Ulmgkkf+NSOIWOf3EtJahS+Kuy+VXENAHwhKbrOtf6T6nzDOD4Pzhjg8zUu9BBwBXaV9r9bmrVqppNkw0WIwAskD3ouA9WD54khDgisJRRxWl5JWxFxLAUmj1Y06qfMDOARvUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386042; c=relaxed/simple;
	bh=x+01MxsIpOH7u3pgyOnjl+mUnt4UzsqDJ8bIv9TPSfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EHb0w8pBl+sFOOpIoMekVN1YQf1a4uJ+qh+BAmLnaZP2x9gjIiNepLG7sDRUfaKnlUhzZs4nIKTqCChSjWLUlLRXzTGDluvbpobHxbnQdTBmrRthtLc3N34ttFOeOuBTQ957T8MMVvU/3IjXSC2rt5Eb4CaiHhbgaoTsthSWz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW4FrsJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ACEC19422;
	Mon, 17 Nov 2025 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763386042;
	bh=x+01MxsIpOH7u3pgyOnjl+mUnt4UzsqDJ8bIv9TPSfg=;
	h=From:Date:Subject:To:Cc:From;
	b=KW4FrsJSBGKLvACVATXiXM8mKj9Q0SrPQEblQAFoHYEg5JIg6zPzQGr4hniwp1cjF
	 TtygQ0yeSOYCr3pEYZwtphTvgMzZWb0NWEzjgSLiz4qaDc1llmvE7bXTIK4hskymmF
	 VaIHzW4kl7XwGoLcFdOyiGEKtpkzADiRZEw5t3mCiK7KlrC8Li7tj97w9x3ygjt7Y4
	 QMLfjotg/+3oLJESuVpF529EFDqkr2Fygq/RwekMUFQNTibXIyxFklkDHQrIXGxqjG
	 zr0MHQ4nhp0PoT22Ru8VMLuj4eJDWx/JrD0evDdH8Yb/4S0rl/VdcxVO7Be6fLL0Tz
	 yOsDZRaKg3Uqw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Nov 2025 08:27:11 -0500
Subject: [PATCH v7] vfs: expose delegation support to userland
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-dir-deleg-ro-v7-1-f8bfd13a3791@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBtQqaSuEi0kJxsIjREiCO+et
 HyL/18oJEwFZvWC0M2Fc2pwnYLt8CkScmgGq+1gjHEYWDDQSRElo6XR9s4br/0ELbmEdn7+3bL
 W+gFQqKP1XgAAAA==
X-Change-ID: 20251117-dir-deleg-ro-2e6247a1a0a9
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8733; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x+01MxsIpOH7u3pgyOnjl+mUnt4UzsqDJ8bIv9TPSfg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpGyK5aez9IO3bGODnW2Da1yO3BwW3nYORBTe2P
 DF+Gtbf3myJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRsiuQAKCRAADmhBGVaC
 FVpaD/0cCKDdTFuRrVn8SFwgU56yVqMAajBKLwPPvDvtaRzjv7Z5h1DzkeETgMLxj8wH+DsN9wB
 8muSzhcvHsnkAY2ef4wMsuoDvWavTkMloN9UxKkF7nkFbQN6JBy3I/HfryypjBknKmgIIW21WUi
 iDlX04yHZNke38Gw+XioPWLPTD3t9bweAXdryX/PFXGQQpEIodFx35ow3Ti9aaQtWonAIm19/fM
 X0nkhGe6F+5VappDKArzSa6XtwN7tosGauSqa3VrmPBfzhdUBGrYbpoeMemsMEKYy0MOiCdYBx6
 QCa12yqmEgQDpYhseSdFnCdNbcL70sMfuqWeV0+V1osWVWYfXCE6DC82zSqEnAANYDexDV2HDCX
 NOn6fCKWJDo5v22c31/p2NoaPqKbanUDERSVhwJpGZ4S50sObuL3PWOHvk51SGaQ5tZ/6KqB3Vf
 Zr8sM6vJrXD6oKzzoPVHBIZ9sD31cvpgUMwrg9bo3sTpQPqtGqDE/mhqqSvmOHOY0r3gR4QM4qr
 pQdfXKNlfPXEpAZtDe4VEI1o57GX8N6SSZ4bIg6ZuiPAag8ISUnjhAwA9d/GQ2Lw6vwcjrmHVuW
 /Zpz0p+dOycaAboexOiygVCMh3DKsf0Oj8VTRqyFuhyw2FgZmRgX5kk3jmZkGF9JKdmY8V0rvux
 kE2ZLSwflHNFZQg==
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
Stephen hit a couple of problems while merging the last patch in the
directory delegation series. Christian, could you drop the last patch in
your vfs-6.19.directory.delegations branch and pick up this one instead?
I think it should address all of the problems he reported. Let me know
if you'd rather I resend the whole series.

Changes in v7:
- have fcntl.h include proper headers for stdint.h integers
- move comment above fcntl_getlease() to the proper place
- add a kerneldoc comment over fcntl_getdeleg()
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

---
base-commit: 8b99f6a8c116f664a6788737705f6da2772cc96a
change-id: 20251117-dir-deleg-ro-2e6247a1a0a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


