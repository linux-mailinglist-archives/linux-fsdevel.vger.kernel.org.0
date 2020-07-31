Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7880F2345BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgGaMW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733296AbgGaMWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D2C061574;
        Fri, 31 Jul 2020 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xABHaGccHyeMiOAO3PmSx6x4b+NSs8y5Q9sXTcSjN2c=; b=moaquv5iHzVmRq5IbxFGXS1D6/
        q90RHvkyG/m9AfAQ2Iw++XQyFaeesY9nZtzz2Lt1oRbqqmVBBtrNRLaKTRkQWos86KUNsHY40XgAw
        KcBRV6RQLFAel0M61uBJZfjso6lBliWcMwX2m6j/FS5H0uKHbwLKzVH/L4GwhccLehUIXMgQlTOWh
        Zk1NzZstMp2mi3ZWc3GFPgGmnyRR0v5S3erpYsSG8lAefVxZDsmyB2vOK8CGejjXaMMumig87fgA0
        CdAQ+Bs5LXy9p/PvrB2RRjm/ReWpvMtnIxxtpXmzVhfoQ5COWF7i+QjH+xSVdFmQ7LRaCKWk72+Jj
        4jvjufkA==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1U38-00026U-H3; Fri, 31 Jul 2020 12:22:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] quota: simplify the quotactl compat handling
Date:   Fri, 31 Jul 2020 14:22:02 +0200
Message-Id: <20200731122202.213333-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731122202.213333-1-hch@lst.de>
References: <20200731122202.213333-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold the misaligned u64 workarounds into the main quotactl flow instead
of implementing a separate compat syscall handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jan Kara <jack@suse.cz>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   2 +-
 fs/quota/Kconfig                       |   5 --
 fs/quota/Makefile                      |   1 -
 fs/quota/compat.c                      | 120 -------------------------
 fs/quota/compat.h                      |  34 +++++++
 fs/quota/quota.c                       |  73 ++++++++++++---
 include/linux/quotaops.h               |   3 -
 kernel/sys_ni.c                        |   1 -
 8 files changed, 94 insertions(+), 145 deletions(-)
 delete mode 100644 fs/quota/compat.c
 create mode 100644 fs/quota/compat.h

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed11f..41d442d7c2db67 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -142,7 +142,7 @@
 128	i386	init_module		sys_init_module
 129	i386	delete_module		sys_delete_module
 130	i386	get_kernel_syms
-131	i386	quotactl		sys_quotactl			compat_sys_quotactl32
+131	i386	quotactl		sys_quotactl
 132	i386	getpgid			sys_getpgid
 133	i386	fchdir			sys_fchdir
 134	i386	bdflush			sys_bdflush
diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index 7218314ca13f00..4f5bb85099a904 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -70,8 +70,3 @@ config QFMT_V2
 config QUOTACTL
 	bool
 	default n
-
-config QUOTACTL_COMPAT
-	bool
-	depends on QUOTACTL && COMPAT_FOR_U64_ALIGNMENT
-	default y
diff --git a/fs/quota/Makefile b/fs/quota/Makefile
index f2b49d0f0287c9..9160639daffa75 100644
--- a/fs/quota/Makefile
+++ b/fs/quota/Makefile
@@ -4,5 +4,4 @@ obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
 obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
 obj-$(CONFIG_QUOTA_TREE)	+= quota_tree.o
 obj-$(CONFIG_QUOTACTL)		+= quota.o kqid.o
-obj-$(CONFIG_QUOTACTL_COMPAT)	+= compat.o
 obj-$(CONFIG_QUOTA_NETLINK_INTERFACE)	+= netlink.o
diff --git a/fs/quota/compat.c b/fs/quota/compat.c
deleted file mode 100644
index c305728576193d..00000000000000
--- a/fs/quota/compat.c
+++ /dev/null
@@ -1,120 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/syscalls.h>
-#include <linux/compat.h>
-#include <linux/quotaops.h>
-
-/*
- * This code works only for 32 bit quota tools over 64 bit OS (x86_64, ia64)
- * and is necessary due to alignment problems.
- */
-struct compat_if_dqblk {
-	compat_u64 dqb_bhardlimit;
-	compat_u64 dqb_bsoftlimit;
-	compat_u64 dqb_curspace;
-	compat_u64 dqb_ihardlimit;
-	compat_u64 dqb_isoftlimit;
-	compat_u64 dqb_curinodes;
-	compat_u64 dqb_btime;
-	compat_u64 dqb_itime;
-	compat_uint_t dqb_valid;
-};
-
-/* XFS structures */
-struct compat_fs_qfilestat {
-	compat_u64 dqb_bhardlimit;
-	compat_u64 qfs_nblks;
-	compat_uint_t qfs_nextents;
-};
-
-struct compat_fs_quota_stat {
-	__s8		qs_version;
-	__u16		qs_flags;
-	__s8		qs_pad;
-	struct compat_fs_qfilestat	qs_uquota;
-	struct compat_fs_qfilestat	qs_gquota;
-	compat_uint_t	qs_incoredqs;
-	compat_int_t	qs_btimelimit;
-	compat_int_t	qs_itimelimit;
-	compat_int_t	qs_rtbtimelimit;
-	__u16		qs_bwarnlimit;
-	__u16		qs_iwarnlimit;
-};
-
-COMPAT_SYSCALL_DEFINE4(quotactl32, unsigned int, cmd,
-		       const char __user *, special, qid_t, id,
-		       void __user *, addr)
-{
-	unsigned int cmds;
-	struct if_dqblk __user *dqblk;
-	struct compat_if_dqblk __user *compat_dqblk;
-	struct fs_quota_stat __user *fsqstat;
-	struct compat_fs_quota_stat __user *compat_fsqstat;
-	compat_uint_t data;
-	u16 xdata;
-	long ret;
-
-	cmds = cmd >> SUBCMDSHIFT;
-
-	switch (cmds) {
-	case Q_GETQUOTA:
-		dqblk = compat_alloc_user_space(sizeof(struct if_dqblk));
-		compat_dqblk = addr;
-		ret = kernel_quotactl(cmd, special, id, dqblk);
-		if (ret)
-			break;
-		if (copy_in_user(compat_dqblk, dqblk, sizeof(*compat_dqblk)) ||
-			get_user(data, &dqblk->dqb_valid) ||
-			put_user(data, &compat_dqblk->dqb_valid))
-			ret = -EFAULT;
-		break;
-	case Q_SETQUOTA:
-		dqblk = compat_alloc_user_space(sizeof(struct if_dqblk));
-		compat_dqblk = addr;
-		ret = -EFAULT;
-		if (copy_in_user(dqblk, compat_dqblk, sizeof(*compat_dqblk)) ||
-			get_user(data, &compat_dqblk->dqb_valid) ||
-			put_user(data, &dqblk->dqb_valid))
-			break;
-		ret = kernel_quotactl(cmd, special, id, dqblk);
-		break;
-	case Q_XGETQSTAT:
-		fsqstat = compat_alloc_user_space(sizeof(struct fs_quota_stat));
-		compat_fsqstat = addr;
-		ret = kernel_quotactl(cmd, special, id, fsqstat);
-		if (ret)
-			break;
-		ret = -EFAULT;
-		/* Copying qs_version, qs_flags, qs_pad */
-		if (copy_in_user(compat_fsqstat, fsqstat,
-			offsetof(struct compat_fs_quota_stat, qs_uquota)))
-			break;
-		/* Copying qs_uquota */
-		if (copy_in_user(&compat_fsqstat->qs_uquota,
-			&fsqstat->qs_uquota,
-			sizeof(compat_fsqstat->qs_uquota)) ||
-			get_user(data, &fsqstat->qs_uquota.qfs_nextents) ||
-			put_user(data, &compat_fsqstat->qs_uquota.qfs_nextents))
-			break;
-		/* Copying qs_gquota */
-		if (copy_in_user(&compat_fsqstat->qs_gquota,
-			&fsqstat->qs_gquota,
-			sizeof(compat_fsqstat->qs_gquota)) ||
-			get_user(data, &fsqstat->qs_gquota.qfs_nextents) ||
-			put_user(data, &compat_fsqstat->qs_gquota.qfs_nextents))
-			break;
-		/* Copying the rest */
-		if (copy_in_user(&compat_fsqstat->qs_incoredqs,
-			&fsqstat->qs_incoredqs,
-			sizeof(struct compat_fs_quota_stat) -
-			offsetof(struct compat_fs_quota_stat, qs_incoredqs)) ||
-			get_user(xdata, &fsqstat->qs_iwarnlimit) ||
-			put_user(xdata, &compat_fsqstat->qs_iwarnlimit))
-			break;
-		ret = 0;
-		break;
-	default:
-		ret = kernel_quotactl(cmd, special, id, addr);
-	}
-	return ret;
-}
diff --git a/fs/quota/compat.h b/fs/quota/compat.h
new file mode 100644
index 00000000000000..ef7d1e12d650b3
--- /dev/null
+++ b/fs/quota/compat.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compat.h>
+
+struct compat_if_dqblk {
+	compat_u64			dqb_bhardlimit;
+	compat_u64			dqb_bsoftlimit;
+	compat_u64			dqb_curspace;
+	compat_u64			dqb_ihardlimit;
+	compat_u64			dqb_isoftlimit;
+	compat_u64			dqb_curinodes;
+	compat_u64			dqb_btime;
+	compat_u64			dqb_itime;
+	compat_uint_t			dqb_valid;
+};
+
+struct compat_fs_qfilestat {
+	compat_u64			dqb_bhardlimit;
+	compat_u64			qfs_nblks;
+	compat_uint_t			qfs_nextents;
+};
+
+struct compat_fs_quota_stat {
+	__s8				qs_version;
+	__u16				qs_flags;
+	__s8				qs_pad;
+	struct compat_fs_qfilestat	qs_uquota;
+	struct compat_fs_qfilestat	qs_gquota;
+	compat_uint_t			qs_incoredqs;
+	compat_int_t			qs_btimelimit;
+	compat_int_t			qs_itimelimit;
+	compat_int_t			qs_rtbtimelimit;
+	__u16				qs_bwarnlimit;
+	__u16				qs_iwarnlimit;
+};
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 5444d3c4d93f37..e1e9d05a14c3e4 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/writeback.h>
 #include <linux/nospec.h>
+#include "compat.h"
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -211,8 +212,18 @@ static int quota_getquota(struct super_block *sb, int type, qid_t id,
 	if (ret)
 		return ret;
 	copy_to_if_dqblk(&idq, &fdq);
-	if (copy_to_user(addr, &idq, sizeof(idq)))
-		return -EFAULT;
+
+	if (compat_need_64bit_alignment_fixup()) {
+		struct compat_if_dqblk __user *compat_dqblk = addr;
+
+		if (copy_to_user(compat_dqblk, &idq, sizeof(*compat_dqblk)))
+			return -EFAULT;
+		if (put_user(idq.dqb_valid, &compat_dqblk->dqb_valid))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(addr, &idq, sizeof(idq)))
+			return -EFAULT;
+	}
 	return 0;
 }
 
@@ -277,8 +288,16 @@ static int quota_setquota(struct super_block *sb, int type, qid_t id,
 	struct if_dqblk idq;
 	struct kqid qid;
 
-	if (copy_from_user(&idq, addr, sizeof(idq)))
-		return -EFAULT;
+	if (compat_need_64bit_alignment_fixup()) {
+		struct compat_if_dqblk __user *compat_dqblk = addr;
+
+		if (copy_from_user(&idq, compat_dqblk, sizeof(*compat_dqblk)) ||
+		    get_user(idq.dqb_valid, &compat_dqblk->dqb_valid))
+			return -EFAULT;
+	} else {
+		if (copy_from_user(&idq, addr, sizeof(idq)))
+			return -EFAULT;
+	}
 	if (!sb->s_qcop->set_dqblk)
 		return -ENOSYS;
 	qid = make_kqid(current_user_ns(), type, id);
@@ -382,6 +401,33 @@ static int quota_getstate(struct super_block *sb, int type,
 	return 0;
 }
 
+static int compat_copy_fs_qfilestat(struct compat_fs_qfilestat __user *to,
+		struct fs_qfilestat *from)
+{
+	if (copy_to_user(to, from, sizeof(*to)) ||
+	    put_user(from->qfs_nextents, &to->qfs_nextents))
+		return -EFAULT;
+	return 0;
+}
+
+static int compat_copy_fs_quota_stat(struct compat_fs_quota_stat __user *to,
+		struct fs_quota_stat *from)
+{
+	if (put_user(from->qs_version, &to->qs_version) ||
+	    put_user(from->qs_flags, &to->qs_flags) ||
+	    put_user(from->qs_pad, &to->qs_pad) ||
+	    compat_copy_fs_qfilestat(&to->qs_uquota, &from->qs_uquota) ||
+	    compat_copy_fs_qfilestat(&to->qs_gquota, &from->qs_gquota) ||
+	    put_user(from->qs_incoredqs, &to->qs_incoredqs) ||
+	    put_user(from->qs_btimelimit, &to->qs_btimelimit) ||
+	    put_user(from->qs_itimelimit, &to->qs_itimelimit) ||
+	    put_user(from->qs_rtbtimelimit, &to->qs_rtbtimelimit) ||
+	    put_user(from->qs_bwarnlimit, &to->qs_bwarnlimit) ||
+	    put_user(from->qs_iwarnlimit, &to->qs_iwarnlimit))
+		return -EFAULT;
+	return 0;
+}
+
 static int quota_getxstate(struct super_block *sb, int type, void __user *addr)
 {
 	struct fs_quota_stat fqs;
@@ -390,9 +436,14 @@ static int quota_getxstate(struct super_block *sb, int type, void __user *addr)
 	if (!sb->s_qcop->get_state)
 		return -ENOSYS;
 	ret = quota_getstate(sb, type, &fqs);
-	if (!ret && copy_to_user(addr, &fqs, sizeof(fqs)))
+	if (ret)
+		return ret;
+
+	if (compat_need_64bit_alignment_fixup())
+		return compat_copy_fs_quota_stat(addr, &fqs);
+	if (copy_to_user(addr, &fqs, sizeof(fqs)))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int quota_getstatev(struct super_block *sb, int type,
@@ -816,8 +867,8 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
  * calls. Maybe we need to add the process quotas etc. in the future,
  * but we probably should use rlimits for that.
  */
-int kernel_quotactl(unsigned int cmd, const char __user *special,
-		    qid_t id, void __user *addr)
+SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
+		qid_t, id, void __user *, addr)
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;
@@ -871,9 +922,3 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 		path_put(pathp);
 	return ret;
 }
-
-SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
-		qid_t, id, void __user *, addr)
-{
-	return kernel_quotactl(cmd, special, id, addr);
-}
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 9cf0cd3dc88c68..a0f6668924d3ef 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -27,9 +27,6 @@ static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
 		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
 }
 
-int kernel_quotactl(unsigned int cmd, const char __user *special,
-		    qid_t id, void __user *addr);
-
 #if defined(CONFIG_QUOTA)
 
 #define quota_error(sb, fmt, args...) \
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac56..f01b91cc57fa00 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -370,7 +370,6 @@ COND_SYSCALL_COMPAT(fanotify_mark);
 /* x86 */
 COND_SYSCALL(vm86old);
 COND_SYSCALL(modify_ldt);
-COND_SYSCALL_COMPAT(quotactl32);
 COND_SYSCALL(vm86);
 COND_SYSCALL(kexec_file_load);
 
-- 
2.27.0

