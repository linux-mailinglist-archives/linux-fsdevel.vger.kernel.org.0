Return-Path: <linux-fsdevel+bounces-78107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLuUCOjhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C9617F552
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5799E308B41B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9237F8A0;
	Mon, 23 Feb 2026 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ77KnwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50634403A;
	Mon, 23 Feb 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889060; cv=none; b=gLkDwG3RRNBBt1L53T/9NVeOUQnKFC96oB3DDZOPIYzQcu0ItEBNuYteXiof3JrRFCKUprre/GaosUbZ09wuJQyAWWLv9eKQEB+fKbyLBYcKoafWHPwjRawzaTDV4AXB/+0UnowcMeWbpZr4YTjojbDb6KHl1iTDXRo8gC0ECxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889060; c=relaxed/simple;
	bh=KFVP+S1W6GF0TY+7XFJVwHANYFUaMw9/es5aPPkQ3jQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrnVdpy895Vksb34bOTyEvbPno0K9q0pBzymbO3dV5hwfwkGHVD90oEp/oQDgiLMZTLU+pv56Epo9csJJZf8LmmDxstkH+bIDiD6y/VnPcCQqLdYIxjzz5ETTvQxf73mhPy83/Y/ogzAIdT4tY66psrx2vPM2hiNaHo3MOiuzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ77KnwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E747C116C6;
	Mon, 23 Feb 2026 23:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889059;
	bh=KFVP+S1W6GF0TY+7XFJVwHANYFUaMw9/es5aPPkQ3jQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lZ77KnwE1kaSQLqPTRHeIb+IoGiwuEpU3Ovs29ZaM0KU8clBNL3TUh+Sk4OyZ4wzo
	 9pJHMrjTfxIMqhV8cRUEwD8vCBblqq92HgpKGI7QWm7BWtaE8XS6w1TXli5w1nWA7M
	 bKjT548bgqzsTR8JSjO+uGWC637HiB/DuXupoiHF1Qx+yS5ONKDFdIoLTfJdEkgeTW
	 lSsnK2zKjzbTT6U34noMS0v0M3RrqLsKSNcniO0qjlul/uszh24yZBhxmIO2U/7tKx
	 JYgRjGOmYEff8mtAQoObC/RKKdlV3UW0eBhA7Wgt2Na2Pc+HcMPsC3gCxKRHIXLVQ9
	 xE3Hb6uJGcIvA==
Date: Mon, 23 Feb 2026 15:24:19 -0800
Subject: [PATCH 1/5] fuse: enable fuse servers to upload BPF programs to
 handle iomap requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, john@groves.net,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188736816.3938194.8820121397606069778.stgit@frogsfrogsfrogs>
In-Reply-To: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
References: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,groves.net,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78107-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4C9617F552
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

There are certain fuse servers that might benefit from the ability to
upload a BPF program into the kernel to respond to ->iomap_begin
requests instead of upcalling the fuse server itself.

For example, consider a fuse server that abstracts a large amount of
storage for use as intermediate storage by programs.  If the storage is
striped across hardware devices (e.g. RAID0 or interleaved memory
controllers) then the iomapping pattern will be completely regular
but the mappings themselves might be very small.

Performance for large IOs will suck if it is necessary to upcall the
fuse server every time we cross a mapping boundary.  The fuse server can
try to mitigate that hit by upserting mappings ahead of time, but
there's a better solution for this usecase: BPF programs.

In this case, the fuse server can compile a BPF program that will
compute the mapping data for a given request and upload the program.
This avoids the overhead of cache lookups and server upcalls.  Note that
the BPF verifier still imposes instruction count and complexity limits
on the uploaded programs.

Note that I embraced and extended some code from Joanne, but at this
point I've modified it so heavily that it's not really the original
anymore.  But she still gets credit for coming up with the idea and
engaging me in flinging prototypes around.

Link: https://lore.kernel.org/linux-ext4/CAJnrk1ag3ffQC=U1ZXVLTipDyo1VBQBM3MYNB6=6d4ywLOEieA@mail.gmail.com/
Co-authored-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h         |    5 +
 fs/fuse/fuse_iomap_bpf.h |   88 +++++++++++++
 fs/fuse/Makefile         |    4 +
 fs/fuse/fuse_iomap.c     |   13 +-
 fs/fuse/fuse_iomap_bpf.c |  309 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c          |    7 +
 6 files changed, 423 insertions(+), 3 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap_bpf.h
 create mode 100644 fs/fuse/fuse_iomap_bpf.c


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5f2e7755e3e4e4..677e1fa4c8586c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -686,6 +686,11 @@ struct fuse_iomap_conn {
 
 	/* maximum mapping cache size */
 	unsigned int cache_maxbytes;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* bpf iomap overrides for this fs */
+	struct fuse_iomap_bpf_ops __rcu *bpf_ops;
+#endif
 };
 #endif
 
diff --git a/fs/fuse/fuse_iomap_bpf.h b/fs/fuse/fuse_iomap_bpf.h
new file mode 100644
index 00000000000000..f6bfd2133bf2bb
--- /dev/null
+++ b/fs/fuse/fuse_iomap_bpf.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ * Copied from: Joanne Koong <joannelkoong@gmail.com>
+ */
+#ifndef _FS_FUSE_IOMAP_BPF_H
+#define _FS_FUSE_IOMAP_BPF_H
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP) && IS_ENABLED(CONFIG_BPF_SYSCALL)
+enum fuse_iomap_bpf_ret {
+	/* fall back to fuse server upcall */
+	FIB_FALLBACK = 0,
+	/* bpf function handled event completely */
+	FIB_HANDLED = 1,
+};
+
+struct fuse_iomap_bpf_ops {
+	/**
+	 * @iomap_begin: override iomap_begin.  See FUSE_IOMAP_BEGIN for
+	 * details.
+	 */
+	enum fuse_iomap_bpf_ret (*iomap_begin)(struct fuse_inode *fi,
+			uint64_t pos, uint64_t count, uint32_t opflags,
+			struct fuse_iomap_begin_out *outarg);
+
+	/**
+	 * @iomap_end: override iomap_end.  See FUSE_IOMAP_END for
+	 * details.
+	 */
+	enum fuse_iomap_bpf_ret (*iomap_end)(struct fuse_inode *fi,
+			uint64_t pos, uint64_t count, int64_t written,
+			uint32_t opflags);
+
+	/**
+	 * @iomap_ioend: override iomap_ioend.  See FUSE_IOMAP_IOEND for
+	 * details.
+	 */
+	enum fuse_iomap_bpf_ret (*iomap_ioend)(struct fuse_inode *fi,
+			uint64_t pos, int64_t written, uint32_t ioendflags,
+			int error, uint32_t dev, uint64_t new_addr,
+			struct fuse_iomap_ioend_out *outarg);
+
+	/**
+	 * @fuse_fd: file descriptor of the open fuse device
+	 */
+	int fuse_fd;
+
+	/**
+	 * @zeropad: Explicitly pad to zero.
+	 */
+	unsigned int zeropad;
+
+	/**
+	 * @name: string describing the fuse iomap bpf operations
+	 */
+	char name[16];
+
+	/* private: don't show fuse connection to the world */
+	struct fuse_conn *fc;
+
+	/*
+	 * private: number of iomap operations in progress, biased by one for
+	 * the fuse connection
+	 */
+	atomic_t users;
+};
+
+int fuse_iomap_init_bpf(void);
+void fuse_iomap_unmount_bpf(struct fuse_conn *fc);
+
+int fuse_iomap_begin_bpf(struct inode *inode,
+			 const struct fuse_iomap_begin_in *inarg,
+			 struct fuse_iomap_begin_out *outarg);
+int fuse_iomap_end_bpf(struct inode *inode,
+		       const struct fuse_iomap_end_in *inarg);
+int fuse_iomap_ioend_bpf(struct inode *inode,
+			 const struct fuse_iomap_ioend_in *inarg,
+			 struct fuse_iomap_ioend_out *outarg);
+#else
+# define fuse_iomap_init_bpf()		(0)
+# define fuse_iomap_unmount_bpf(...)	((void)0)
+# define fuse_iomap_begin_bpf(...)	(-ENOSYS)
+# define fuse_iomap_end_bpf(...)	(-ENOSYS)
+# define fuse_iomap_ioend_bpf(...)	(-ENOSYS)
+#endif /* CONFIG_FUSE_IOMAP && CONFIG_BPF_SYSCALL */
+
+#endif /* _FS_FUSE_IOMAP_BPF_H */
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index c672503da7bcbd..43ba967db197b1 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -20,4 +20,8 @@ fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
 fuse-$(CONFIG_FUSE_IOMAP) += fuse_iomap.o fuse_iomap_cache.o
 
+ifeq ($(CONFIG_BPF_SYSCALL),y)
+fuse-$(CONFIG_FUSE_IOMAP) += fuse_iomap_bpf.o
+endif
+
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 7bc938cd859fae..2e0c35e879ffcc 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -16,6 +16,7 @@
 #include "fuse_iomap_i.h"
 #include "fuse_dev_i.h"
 #include "fuse_iomap_cache.h"
+#include "fuse_iomap_bpf.h"
 
 static bool __read_mostly enable_iomap =
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
@@ -783,7 +784,9 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_iomap_begin_bpf(inode, &inarg, &outarg);
+	if (err == -ENOSYS)
+		err = fuse_simple_request(fm, &args);
 	if (err) {
 		trace_fuse_iomap_begin_error(inode, pos, count, opflags, err);
 		return err;
@@ -938,7 +941,9 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 		args.in_numargs = 1;
 		args.in_args[0].size = sizeof(inarg);
 		args.in_args[0].value = &inarg;
-		err = fuse_simple_request(fm, &args);
+		err = fuse_iomap_end_bpf(inode, &inarg);
+		if (err == -ENOSYS)
+			err = fuse_simple_request(fm, &args);
 		if (err == -ENOSYS) {
 			/*
 			 * libfuse returns ENOSYS for servers that don't
@@ -1047,7 +1052,9 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 		args.out_numargs = 1;
 		args.out_args[0].size = sizeof(outarg);
 		args.out_args[0].value = &outarg;
-		iomap_error = fuse_simple_request(fm, &args);
+		iomap_error = fuse_iomap_ioend_bpf(inode, &inarg, &outarg);
+		if (iomap_error == -ENOSYS)
+			iomap_error = fuse_simple_request(fm, &args);
 		switch (iomap_error) {
 		case -ENOSYS:
 			/*
diff --git a/fs/fuse/fuse_iomap_bpf.c b/fs/fuse/fuse_iomap_bpf.c
new file mode 100644
index 00000000000000..b104f3961721b2
--- /dev/null
+++ b/fs/fuse/fuse_iomap_bpf.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ * Copied from: Joanne Koong <joannelkoong@gmail.com>
+ */
+#include <linux/bpf.h>
+
+#include "fuse_i.h"
+#include "fuse_dev_i.h"
+#include "fuse_iomap_bpf.h"
+#include "fuse_iomap_i.h"
+#include "fuse_trace.h"
+
+/* spinlock for atomically updating fuse_conn <-> bpf_ops pointers */
+static DEFINE_SPINLOCK(fuse_iomap_bpf_ops_lock);
+
+/*
+ * The only structures that we provide to the BPF program are outparams, so
+ * they can write anything they want to it.
+ */
+static bool fuse_iomap_bpf_ops_is_valid_access(int off, int size,
+					       enum bpf_access_type type,
+					       const struct bpf_prog *prog,
+					       struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int fuse_iomap_bpf_ops_check_member(const struct btf_type *t,
+					   const struct btf_member *member,
+					   const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int fuse_iomap_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
+						const struct bpf_reg_state *reg,
+						int off, int size)
+{
+	return 0;
+}
+
+static const struct bpf_verifier_ops fuse_iomap_bpf_verifier_ops = {
+	.get_func_proto		= bpf_base_func_proto,
+	.is_valid_access	= fuse_iomap_bpf_ops_is_valid_access,
+	.btf_struct_access	= fuse_iomap_bpf_ops_btf_struct_access,
+};
+
+static int fuse_iomap_bpf_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+/* Copy data from userspace bpf ops to the kernel */
+static int fuse_iomap_bpf_ops_init_member(const struct btf_type *t,
+					  const struct btf_member *member,
+					  void *kdata, const void *udata)
+{
+	const struct fuse_iomap_bpf_ops *u_ops = udata;
+	struct fuse_iomap_bpf_ops *ops = kdata;
+	u32 moff;
+
+	/*
+	 * This function must copy all non-function-pointers by itself and
+	 * return 1 to indicate that the data has been handled by the
+	 * struct_ops type, or the verifier will reject the map if the value of
+	 * those fields is not zero.
+	 */
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct fuse_iomap_bpf_ops, fuse_fd):
+		ops->fuse_fd = u_ops->fuse_fd;
+		return 1;
+	case offsetof(struct fuse_iomap_bpf_ops, users):
+		ASSERT(atomic_read(&ops->users) == 0);
+		atomic_set(&ops->users, 1);
+		return 1;
+	case offsetof(struct fuse_iomap_bpf_ops, name):
+		if (bpf_obj_name_cpy(ops->name, u_ops->name,
+				     sizeof(ops->name)) <= 0)
+			return -EINVAL;
+		return 1;  /* Handled */
+	}
+
+	/* Not handled, use default */
+	return 0;
+}
+
+/* Register an iomap bpf program with a fuse connection */
+static int fuse_iomap_bpf_reg(void *kdata, struct bpf_link *link)
+{
+	struct fuse_iomap_bpf_ops *ops = kdata;
+	struct file *fusedev_file;
+	struct fuse_dev *fud;
+	struct fuse_conn *fc;
+
+	CLASS(fd, fusedev_fd)(ops->fuse_fd);
+	if (fd_empty(fusedev_fd))
+		return -EBADF;
+
+	fusedev_file = fd_file(fusedev_fd);
+	if (fusedev_file->f_op != &fuse_dev_operations)
+		return -EBADF;
+
+	fud = fuse_get_dev(fusedev_file);
+	fc = fud->fc;
+
+	if (!fc->iomap)
+		return -EOPNOTSUPP;
+
+	spin_lock(&fuse_iomap_bpf_ops_lock);
+	if (fc->iomap_conn.bpf_ops) {
+		spin_unlock(&fuse_iomap_bpf_ops_lock);
+		return -EBUSY;
+	}
+
+	/*
+	 * The initial ops user count bias is transferred to fc so that we only
+	 * initiate wakeup events when someone tries to unregister the BPF.
+	 */
+	rcu_assign_pointer(fc->iomap_conn.bpf_ops, ops);
+	ops->fc = fc;
+	spin_unlock(&fuse_iomap_bpf_ops_lock);
+
+	return 0;
+}
+
+static inline struct fuse_iomap_bpf_ops *
+fuse_iomap_get_bpf_ops(struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_iomap_bpf_ops *ops;
+
+	rcu_read_lock();
+	ops = rcu_dereference(fc->iomap_conn.bpf_ops);
+	if (ops && !atomic_inc_not_zero(&ops->users))
+		ops = NULL;
+	rcu_read_unlock();
+
+	return ops;
+}
+
+static inline void
+fuse_iomap_put_bpf_ops(struct fuse_iomap_bpf_ops *ops)
+{
+	if (ops)
+		atomic_dec_and_wake_up(&ops->users);
+}
+
+DEFINE_CLASS(iomap_bpf_ops, struct fuse_iomap_bpf_ops *,
+	     fuse_iomap_put_bpf_ops(_T), fuse_iomap_get_bpf_ops(inode),
+	     struct inode *inode);
+
+static void __fuse_iomap_detach_bpf(struct fuse_conn *fc,
+				    struct fuse_iomap_bpf_ops *ops)
+{
+	ops->fc = NULL;
+	rcu_assign_pointer(fc->iomap_conn.bpf_ops, NULL);
+	fuse_iomap_put_bpf_ops(ops);
+}
+
+/* Detach any iomap bpf programs from the fuse connection */
+void fuse_iomap_unmount_bpf(struct fuse_conn *fc)
+{
+	spin_lock(&fuse_iomap_bpf_ops_lock);
+	if (fc->iomap_conn.bpf_ops) {
+		/*
+		 * This should only be called from unmount, so there won't be
+		 * anybody trying to call the BPF iomap functions.
+		 */
+		ASSERT(atomic_read(&fc->iomap_conn.bpf_ops->users) == 1);
+
+		__fuse_iomap_detach_bpf(fc, fc->iomap_conn.bpf_ops);
+	}
+	spin_unlock(&fuse_iomap_bpf_ops_lock);
+}
+
+/* Detach the fuse connection from this iomap bpf program */
+static void fuse_iomap_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+	struct fuse_iomap_bpf_ops *ops = kdata;
+
+	spin_lock(&fuse_iomap_bpf_ops_lock);
+	if (ops->fc && ops->fc->iomap_conn.bpf_ops == ops)
+		__fuse_iomap_detach_bpf(ops->fc, ops);
+	spin_unlock(&fuse_iomap_bpf_ops_lock);
+
+	/* wait until nobody's trying to call into the bpf iomap program */
+	wait_var_event(&ops->users, atomic_read(&ops->users) == 0);
+}
+
+/* Dummy function stubs for control flow integrity hashes */
+static enum fuse_iomap_bpf_ret
+__iomap_begin(struct fuse_inode *fi, uint64_t pos, uint64_t count,
+	      uint32_t opflags, struct fuse_iomap_begin_out *outarg)
+{
+	return FIB_FALLBACK;
+}
+
+static enum fuse_iomap_bpf_ret
+__iomap_end(struct fuse_inode *fi, uint64_t pos, uint64_t count,
+	    int64_t written, uint32_t opflags)
+{
+	return FIB_FALLBACK;
+}
+
+static enum fuse_iomap_bpf_ret
+__iomap_ioend(struct fuse_inode *fi, uint64_t pos, int64_t written,
+	      uint32_t ioendflags, int error, uint32_t dev, uint64_t new_addr,
+	      struct fuse_iomap_ioend_out *outarg)
+{
+	return FIB_FALLBACK;
+}
+
+static struct fuse_iomap_bpf_ops __fuse_iomap_bpf_ops = {
+	.iomap_begin	= __iomap_begin,
+	.iomap_end	= __iomap_end,
+	.iomap_ioend	= __iomap_ioend,
+};
+
+static struct bpf_struct_ops fuse_iomap_bpf_struct_ops = {
+	.verifier_ops	= &fuse_iomap_bpf_verifier_ops,
+	.init		= fuse_iomap_bpf_ops_init,
+	.check_member	= fuse_iomap_bpf_ops_check_member,
+	.init_member	= fuse_iomap_bpf_ops_init_member,
+	.reg		= fuse_iomap_bpf_reg,
+	.unreg		= fuse_iomap_bpf_unreg,
+	.name		= "fuse_iomap_bpf_ops",
+	.cfi_stubs	= &__fuse_iomap_bpf_ops,
+	.owner		= THIS_MODULE,
+};
+
+/* Register the iomap bpf ops so that fuse servers can attach to it */
+int __init fuse_iomap_init_bpf(void)
+{
+	return register_bpf_struct_ops(&fuse_iomap_bpf_struct_ops,
+				       fuse_iomap_bpf_ops);
+}
+
+/* Register key structures with BTF so that BPF programs can use structs */
+BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_iomap_bpf_ops_id,
+			  struct, fuse_iomap_bpf_ops)
+BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_iomap_begin_out_id,
+			  struct, fuse_iomap_begin_out)
+BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_iomap_ioend_out_id,
+			  struct, fuse_iomap_ioend_out)
+
+static inline int bpf_to_errno(enum fuse_iomap_bpf_ret ret)
+{
+	switch (ret) {
+	case FIB_HANDLED:
+		return 0;
+	case FIB_FALLBACK:
+	default:
+		return -ENOSYS;
+	}
+}
+
+/* Try to call the bpf version of ->iomap_begin */
+int fuse_iomap_begin_bpf(struct inode *inode,
+			 const struct fuse_iomap_begin_in *inarg,
+			 struct fuse_iomap_begin_out *outarg)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	CLASS(iomap_bpf_ops, bpf_ops)(inode);
+	enum fuse_iomap_bpf_ret ret;
+
+	if (!bpf_ops || !bpf_ops->iomap_begin)
+		return -ENOSYS;
+
+	ret = bpf_ops->iomap_begin(fi, inarg->pos, inarg->count,
+				   inarg->opflags, outarg);
+	return bpf_to_errno(ret);
+}
+
+/* Try to call the bpf version of ->iomap_end */
+int fuse_iomap_end_bpf(struct inode *inode,
+		       const struct fuse_iomap_end_in *inarg)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	CLASS(iomap_bpf_ops, bpf_ops)(inode);
+	enum fuse_iomap_bpf_ret ret;
+
+	if (!bpf_ops || !bpf_ops->iomap_end)
+		return -ENOSYS;
+
+	ret = bpf_ops->iomap_end(fi, inarg->pos, inarg->count,
+				 inarg->written, inarg->opflags);
+	return bpf_to_errno(ret);
+}
+
+/* Try to call the bpf version of ->iomap_ioend */
+int fuse_iomap_ioend_bpf(struct inode *inode,
+			 const struct fuse_iomap_ioend_in *inarg,
+			 struct fuse_iomap_ioend_out *outarg)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	CLASS(iomap_bpf_ops, bpf_ops)(inode);
+	enum fuse_iomap_bpf_ret ret;
+
+	if (!bpf_ops || !bpf_ops->iomap_ioend)
+		return -ENOSYS;
+
+	ret = bpf_ops->iomap_ioend(fi, inarg->pos, inarg->written,
+				   inarg->flags, inarg->error, inarg->dev,
+				   inarg->new_addr, outarg);
+	return bpf_to_errno(ret);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0f2b12aa1ac4bb..1ab9c0dc3fc964 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -10,6 +10,7 @@
 #include "fuse_dev_i.h"
 #include "dev_uring_i.h"
 #include "fuse_iomap.h"
+#include "fuse_iomap_bpf.h"
 
 #include <linux/dax.h>
 #include <linux/pagemap.h>
@@ -1718,6 +1719,8 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
+
+	fuse_iomap_unmount_bpf(fc);
 	kfree(fc);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
@@ -2373,6 +2376,10 @@ static int __init fuse_fs_init(void)
 	if (!fuse_inode_cachep)
 		goto out;
 
+	err = fuse_iomap_init_bpf();
+	if (err)
+		goto out2;
+
 	err = register_fuseblk();
 	if (err)
 		goto out2;


