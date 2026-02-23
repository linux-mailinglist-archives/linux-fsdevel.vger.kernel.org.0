Return-Path: <linux-fsdevel+bounces-78150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGSiLE/knGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:35:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15DD17F9E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B8D30927C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDD37F8C3;
	Mon, 23 Feb 2026 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufCW1yTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692537F8B7;
	Mon, 23 Feb 2026 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889731; cv=none; b=qDq3yHWgYCZU0N/NtwmgxW98m0saQSIDSYxnGgdsIfzfDpFDM2TBeUQ4bQSPH/xrZJPPPhhn3HtOHC24kfiffnUmApkMmYZ1UgnUKo5l8LR/hJIJT52X9Vn+nLbE+c9GphQoo/qdb80DmDw4hX2GeMqqPpBhbou3q9Z4jQ6sFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889731; c=relaxed/simple;
	bh=m38C2VW7jC6A3pIDRVKPEJhUCDT+7qhDGhO0azP7vck=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qt9cwWHAKUwVsxZcwnqkopPcV/PGMLVss+UyPxzFsdt2GwjQirZZxGy9BteR8yQLbDae5subwjEvuSwto3z0KCVPOssNx75aLWom+vh2tvZeB1zec1jroKFIgbhtCNWsHBbUp+Llo8mw6lwdUEseiJqC4ggoCoj1xwgyX/eFiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufCW1yTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C20C116C6;
	Mon, 23 Feb 2026 23:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889731;
	bh=m38C2VW7jC6A3pIDRVKPEJhUCDT+7qhDGhO0azP7vck=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ufCW1yTnpxPhB2kirBoA1ZVT1PhGyFi+C1gM/Tb07EqdCLAvIHX3D2Gz3ePUXC7K4
	 NmlHQLuvFj76dqUGk1c3x9nOB92Lf86Lzrs5WX5cWsKreuDPc4H1y8qdWvAoT323Z0
	 g4gd+z/R4Ar29ASN66wWb8Xa67g+Bg/oJ8B+EDwtYXj/ZXAqAqdUKiup0jT+N1MZo7
	 X5F1S27HR6k53Wfy9K6vw2dH+No4+yzZ+7+YoXryDnDoQ/CY1ZKO+Hl/IdJNrxi4Av
	 j6Mdtd9U7kt2Sk7ZM41CHfFzrMtHjGj7Y4MUdT5DeEtTZuAnNw5cS2cAfumniysnKE
	 +hvLUbSnn9CPA==
Date: Mon, 23 Feb 2026 15:35:31 -0800
Subject: [PATCH 1/3] libfuse: allow fuse servers to upload bpf code for iomap
 functions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, john@groves.net, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741624.3942368.18134296650103657464.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741597.3942368.18114094782378370092.stgit@frogsfrogsfrogs>
References: <177188741597.3942368.18114094782378370092.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,groves.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-78150-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E15DD17F9E6
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create the necessary header files to enable lowlevel fuse servers to
compile their own BPF blobs that override iomap functions, and a bunch
of meson code to detect if the system is even capable of compiling BPF.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_iomap_bpf.h |  241 ++++++++++++++++++++++++++++++++++++++++++++++
 include/meson.build      |    3 -
 2 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 include/fuse_iomap_bpf.h


diff --git a/include/fuse_iomap_bpf.h b/include/fuse_iomap_bpf.h
new file mode 100644
index 00000000000000..3e69fb33cbdd7c
--- /dev/null
+++ b/include/fuse_iomap_bpf.h
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ * Copied from: Joanne Koong <joannelkoong@gmail.com>
+ */
+#ifndef FUSE_IOMAP_BPF_H_
+#define FUSE_IOMAP_BPF_H_
+
+/* Note: You probably want to #include bpf_helpers and bpf_tracing.h */
+
+/*
+ * XXX: Avoid including fuse_lowlevel.h and fuse_kernel.h because their use of
+ * uint64_t (instead of u64 like the kernel requires for uapi) is extremely
+ * problematic due to the kernel and glibc not agreeing on the exact type
+ * definitions.  BPF is considered a separate architecture from the host
+ * machine, which complicates things further.
+ */
+
+/* mapping types; see corresponding IOMAP_TYPE_ */
+#define FUSE_IOMAP_TYPE_HOLE		(0)
+#define FUSE_IOMAP_TYPE_DELALLOC	(1)
+#define FUSE_IOMAP_TYPE_MAPPED		(2)
+#define FUSE_IOMAP_TYPE_UNWRITTEN	(3)
+#define FUSE_IOMAP_TYPE_INLINE		(4)
+
+/* fuse-specific mapping type indicating that writes use the read mapping */
+#define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
+/* fuse-specific mapping type saying the server has populated the cache */
+#define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
+/* do not upsert this mapping */
+#define FUSE_IOMAP_TYPE_NOCACHE		(253)
+
+#define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
+
+/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
+#define FUSE_IOMAP_F_NEW		(1U << 0)
+#define FUSE_IOMAP_F_DIRTY		(1U << 1)
+#define FUSE_IOMAP_F_SHARED		(1U << 2)
+#define FUSE_IOMAP_F_MERGED		(1U << 3)
+#define FUSE_IOMAP_F_BOUNDARY		(1U << 4)
+#define FUSE_IOMAP_F_ANON_WRITE		(1U << 5)
+#define FUSE_IOMAP_F_ATOMIC_BIO		(1U << 6)
+
+/* fuse-specific mapping flag asking for ->iomap_end call */
+#define FUSE_IOMAP_F_WANT_IOMAP_END	(1U << 7)
+
+/* mapping flags passed to iomap_end */
+#define FUSE_IOMAP_F_SIZE_CHANGED	(1U << 8)
+#define FUSE_IOMAP_F_STALE		(1U << 9)
+
+/* operation flags from iomap; see corresponding IOMAP_* */
+#define FUSE_IOMAP_OP_WRITE		(1U << 0)
+#define FUSE_IOMAP_OP_ZERO		(1U << 1)
+#define FUSE_IOMAP_OP_REPORT		(1U << 2)
+#define FUSE_IOMAP_OP_FAULT		(1U << 3)
+#define FUSE_IOMAP_OP_DIRECT		(1U << 4)
+#define FUSE_IOMAP_OP_NOWAIT		(1U << 5)
+#define FUSE_IOMAP_OP_OVERWRITE_ONLY	(1U << 6)
+#define FUSE_IOMAP_OP_UNSHARE		(1U << 7)
+#define FUSE_IOMAP_OP_DAX		(1U << 8)
+#define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
+#define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
+
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
+/* pagecache writeback operation */
+#define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
+
+#define FUSE_IOMAP_NULL_ADDR		(-1ULL)	/* addr is not valid */
+
+struct fuse_iomap_io {
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of mapping, bytes */
+	uint64_t addr;		/* disk offset of mapping, bytes */
+	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
+	uint16_t flags;		/* FUSE_IOMAP_F_* */
+	uint32_t dev;		/* device cookie */
+};
+
+struct fuse_iomap_begin_in {
+	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
+	uint32_t reserved;	/* zero */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t count;		/* operation length, in bytes */
+};
+
+struct fuse_iomap_begin_out {
+	/* read file data from here */
+	struct fuse_iomap_io	read;
+
+	/* write file data to here, if applicable */
+	struct fuse_iomap_io	write;
+};
+
+struct fuse_iomap_end_in {
+	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
+	uint32_t reserved;	/* zero */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t count;		/* operation length, in bytes */
+	int64_t written;	/* bytes processed */
+
+	/* mapping that the kernel acted upon */
+	struct fuse_iomap_io	map;
+};
+
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+/* is pagecache writeback */
+#define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
+
+struct fuse_iomap_ioend_in {
+	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
+	int32_t error;		/* negative errno or 0 */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t new_addr;	/* disk offset of new mapping, in bytes */
+	uint64_t written;	/* bytes processed */
+	uint32_t dev;		/* device cookie */
+	uint32_t pad;		/* zero */
+};
+
+struct fuse_iomap_ioend_out {
+	uint64_t newsize;	/* new ondisk size */
+};
+
+/* Signal that reads and writes go to the same storage. */
+static inline void
+fuse_iomap_begin_pure_overwrite(struct fuse_iomap_begin_out *outarg)
+{
+	outarg->write.addr = FUSE_IOMAP_NULL_ADDR;
+	outarg->write.offset = outarg->read.offset;
+	outarg->write.length = outarg->read.length;
+	outarg->write.type = FUSE_IOMAP_TYPE_PURE_OVERWRITE;
+	outarg->write.flags = 0;
+	outarg->write.dev = FUSE_IOMAP_DEV_NULL;
+}
+
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
+};
+
+/* BPF code must be GPLv2 */
+#define DECLARE_GPL2_LICENSE_FOR_FUSE_IOMAP_BPF \
+	char LICENSE[] SEC("license") = "GPL v2";
+
+/* Macros to handle creating iomap_ops override functions */
+#define FUSE_IOMAP_BEGIN_BPF_FUNC(name) \
+SEC("struct_ops/iomap_begin") \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_inode *fi, \
+		uint64_t pos, uint64_t count, uint32_t opflags, \
+		struct fuse_iomap_begin_out *outarg)
+
+#define FUSE_IOMAP_END_BPF_FUNC(name) \
+SEC("struct_ops/iomap_end") \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_inode *fi, \
+		uint64_t pos, uint64_t count, int64_t written, \
+		uint32_t opflags)
+
+#define FUSE_IOMAP_IOEND_BPF_FUNC(name) \
+SEC("struct_ops/iomap_ioend") \
+enum fuse_iomap_bpf_ret BPF_PROG(name, struct fuse_inode *fi, \
+		uint64_t pos, int64_t written, uint32_t ioendflags, int error, \
+		uint32_t dev, uint64_t new_addr, \
+		struct fuse_iomap_ioend_out *outarg)
+
+/*
+ * XXX: The BPF compiler plays some weird shenanigans with argument passing
+ * conventions, which means that the actual function signature of BPF_PROG
+ * functions does not actually match the C definitions.  Hence the horrible
+ * (void *) casts below.
+ */
+#define DEFINE_FUSE_IOMAP_BPF_OPS(ops_name, fancy_name, begin_fn, end_fn, \
+				  ioend_fn) \
+SEC(".struct_ops.link") \
+struct fuse_iomap_bpf_ops ops_name = { \
+	.iomap_begin	= (void *)begin_fn, \
+	.iomap_end	= (void *)end_fn, \
+	.iomap_ioend	= (void *)ioend_fn, \
+	.name		= fancy_name, \
+}
+
+#endif /* FUSE_IOMAP_BPF_H_ */
diff --git a/include/meson.build b/include/meson.build
index 5ab4ecf052bf56..17f03df560475a 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -1,5 +1,6 @@
 libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
-	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
+	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h',
+                    'fuse_iomap_bpf.h' ]
 
 if private_cfg.get('FUSE_LOOPDEV_ENABLED')
   libfuse_headers += [ 'fuse_loopdev.h' ]


