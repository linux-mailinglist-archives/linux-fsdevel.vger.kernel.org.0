Return-Path: <linux-fsdevel+bounces-50218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D77AC8CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481241BA556E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D9226D1E;
	Fri, 30 May 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYk8nQjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED29226527
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603431; cv=none; b=VDD0/khiR7XWe7VS8xQDem6XaZfZ1NO+7bypHw2VcbT8qHroHNiTqq9/ayZxROhmxjY7tVIR8BGOcmTkFLeUt3x52JWUNqBzIRXB2338wTI7NPa1SwT6SiwHdjwdieAx32/98s9yOoZLKjaxh001kYCWfzLf8hWeMuwiRx7rPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603431; c=relaxed/simple;
	bh=EZaqlcl4Qu9AR3kr7VPXeD0hHs/EsG7p58m6Yg/X4wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDDh38InlysJCKiA1cKY2Hd3uv3vw7S0MvOx1WwOAF8dRKiddRNBMGoFB1F5QNkdyN7LNDJ/5up1xrhkz9CYKbg/mEDxyCdpn7L8gWuUPG1yQ3BNpQpHXClsXi12E9+pnZnCeBYeW4v0j+MkS3Oe2IPQFPsKJhW/MjirANIHQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYk8nQjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A6C4CEEA;
	Fri, 30 May 2025 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748603430;
	bh=EZaqlcl4Qu9AR3kr7VPXeD0hHs/EsG7p58m6Yg/X4wA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kYk8nQjP0roO5noEISsRcxOftaKT/Eq4bSS+Wbedk7q3Zm+wSPoBJN9Ec2zfWTmmY
	 tYMoPZ5H1VddjSUaFm5nU8GDM5SF2aMiNLglylsLRA2wyCuHvzhyvgYegxM4Kd1cvq
	 E0zJSWVrBeAS1VaSkMa8ko2HlO8XDie1YeKUyq1VoS0MjV3JWXTQTYiCldhNGytxqP
	 mwSvB6vJ+5/YpECbIYyQDWTmy9iVoWqiAe8IOHKOn+vVI8UD6J105ch+dUDoYFTEeU
	 m2+m4KfSouTn9Jz0cGWakgHo/upe1/fiTSNF1LOywjBz4wkWXO2QFT6tgHMIDqpdNs
	 E1ij1/zEi4nvA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 May 2025 13:09:59 +0200
Subject: [PATCH 1/5] coredump: allow for flexible coredump handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-work-coredump-socket-protocol-v1-1-20bde1cd4faa@kernel.org>
References: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
In-Reply-To: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Jan Kara <jack@suse.cz>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=14088; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EZaqlcl4Qu9AR3kr7VPXeD0hHs/EsG7p58m6Yg/X4wA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYTlJgOplaKja9xqK4zKSFYXc7QyGHysoTTxbp/XfVU
 BT+E/u6o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJzVzMyvIrm2FOWNeEO+0xO
 ObObHyLyOev4zrWIxXw+dNCCpfpSAsNvlpa+ML7ZFQc3pJ5R9Mk/7r5jTiSbRnRSjkrGpf6X6wt
 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extend the coredump socket to allow the coredump server to tell the
kernel how to process individual coredumps.

When the crashing task connects to the coredump socket the kernel will
send a struct coredump_req to the coredump server. The kernel will set
the size member of struct coredump_req allowing the coredump server how
much data can be read.

The coredump server uses MSG_PEEK to peek the size of struct
coredump_req. If the kernel uses a newer struct coredump_req the
coredump server just reads the size it knows and discard any remaining
bytes in the buffer. If the kernel uses an older struct coredump_req
the coredump server just reads the size the kernel knows.

The returned struct coredump_req will inform the coredump server what
features the kernel supports. The coredump_req->mask member is set to
the currently know features.

The coredump server may only use features whose bits were raised by the
kernel in coredump_req->mask.

In response to a coredump_req from the kernel the coredump server sends
a struct coredump_ack to the kernel. The kernel informs the coredump
server what version of struct coredump_ack it supports by setting struct
coredump_req->size_ack to the size it knows about. The coredump server
may only send as many bytes as coredump_req->size_ack indicates (a
smaller size is fine of course). The coredump server must set
coredump_ack->size accordingly.

The coredump server sets the features it wants to use in struct
coredump_ack->mask. Only bits returned in struct coredump_req->mask may
be used.

In case an invalid struct coredump_ack is sent to the kernel an
out-of-band byte will be sent by the kernel indicating the reason why
the coredump_ack was rejected.

If the coredump server sent a valid struct coredump_ack the kernel will
place an out-of-band byte indicating that the request was successful. If
the kernel is generating the coredump and sending the coredump data on
the socket the success out-of-band marker can be used as an indicator
when coredump data starts.

The out-of-band markers allow advanced userspace to infer failure. They
are optional and can be ignored by not listening for POLLPRI events and
aren't necessary for the coredump server to function correctly.

In the initial version the following features are supported in
coredump_{req,ack}->mask:

* COREDUMP_KERNEL
  The kernel will write the coredump data to the socket after the
  req-ack sequence has concluded successfully.

* COREDUMP_USERSPACE
  The kernel will not write coredump data but will indicate to the
  parent that a coredump has been generated. This is used when userspace
  generates its own coredumps.

* COREDUMP_REJECT
  The kernel will skip generating a coredump for this task.

* COREDUMP_WAIT
  The kernel will prevent the task from exiting until the coredump
  server has shutdown the socket connection.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c                 | 151 ++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/coredump.h | 104 +++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+), 7 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f217ebf2b3b6..4711786c6470 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -51,6 +51,7 @@
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 #include <uapi/linux/un.h>
+#include <uapi/linux/coredump.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -83,15 +84,17 @@ static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
 
 enum coredump_type_t {
-	COREDUMP_FILE = 1,
-	COREDUMP_PIPE = 2,
-	COREDUMP_SOCK = 3,
+	COREDUMP_FILE		= 1,
+	COREDUMP_PIPE		= 2,
+	COREDUMP_SOCK		= 3,
+	COREDUMP_SOCK_REQ	= 4,
 };
 
 struct core_name {
 	char *corename;
 	int used, size;
 	enum coredump_type_t core_type;
+	u64 mask;
 };
 
 static int expand_corename(struct core_name *cn, int size)
@@ -235,6 +238,9 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	int pid_in_pattern = 0;
 	int err = 0;
 
+	cn->mask = COREDUMP_KERNEL;
+	if (core_pipe_limit)
+		cn->mask |= COREDUMP_WAIT;
 	cn->used = 0;
 	cn->corename = NULL;
 	if (*pat_ptr == '|')
@@ -264,6 +270,13 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		pat_ptr++;
 		if (!(*pat_ptr))
 			return -ENOMEM;
+		if (*pat_ptr == '@') {
+			pat_ptr++;
+			if (!(*pat_ptr))
+				return -ENOMEM;
+
+			cn->core_type = COREDUMP_SOCK_REQ;
+		}
 
 		err = cn_printf(cn, "%s", pat_ptr);
 		if (err)
@@ -632,6 +645,110 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
+#ifdef CONFIG_UNIX
+static inline int coredump_sock_recv(struct file *file, struct coredump_ack *ack, size_t size, int flags)
+{
+	struct msghdr msg = {};
+	struct kvec iov = { .iov_base = ack, .iov_len = size };
+	ssize_t ret;
+
+	memset(ack, 0, size);
+	ret = kernel_recvmsg(sock_from_file(file), &msg, &iov, 1, size, flags);
+	if (ret < 0)
+		return ret;
+	if (ret != size)
+		return -EINVAL;
+	return 0;
+}
+
+static inline int coredump_sock_send(struct file *file, struct coredump_req *req)
+{
+	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL };
+	struct kvec iov = { .iov_base = req, .iov_len = sizeof(*req) };
+	ssize_t ret;
+
+	ret = kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(*req));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(*req))
+		return -EINVAL;
+	return 0;
+}
+
+static inline int coredump_sock_oob(struct file *file, uint8_t oob)
+{
+#ifdef CONFIG_AF_UNIX_OOB
+	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL | MSG_OOB };
+	struct kvec iov = { .iov_base = &oob, .iov_len = sizeof(oob) };
+
+	kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(oob));
+#endif
+	return -EINVAL;
+}
+
+static int coredump_request(struct core_name *cn, struct coredump_params *cprm)
+{
+	struct coredump_req req = {
+		.size		= sizeof(struct coredump_req),
+		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
+				  COREDUMP_REJECT | COREDUMP_WAIT,
+		.size_ack	= sizeof(struct coredump_ack),
+	};
+	struct coredump_ack ack = {};
+	ssize_t ret, usize;
+
+	if (cn->core_type != COREDUMP_SOCK_REQ)
+		return 0;
+
+	/* Let userspace know what we support. */
+	ret = coredump_sock_send(cprm->file, &req);
+	if (ret)
+		return ret;
+
+	/*
+	 * Peek the size of the coredump_ack struct that userspace
+	 * wants to send us and then retrieve it all in one go.
+	 */
+	ret = coredump_sock_recv(cprm->file, &ack, sizeof(ack.size),
+				 MSG_PEEK | MSG_WAITALL);
+	if (ret)
+		return ret;
+
+	/*
+	 * We told userspace what size we know about.
+	 * So refuse anything too small or larger than we know.
+	 */
+	usize = ack.size;
+	if (usize < COREDUMP_ACK_SIZE_VER0 || usize > sizeof(ack))
+		return coredump_sock_oob(cprm->file, COREDUMP_OOB_INVALIDSIZE);
+
+	/* Now retrieve the coredump_ack. */
+	ret = coredump_sock_recv(cprm->file, &ack, usize, MSG_WAITALL);
+	if (ret)
+		return ret;
+	if (ack.size != usize)
+		return -EINVAL;
+
+	/*
+	 * We told userspace what flags we support.
+	 * So refuse any flags we don't know.
+	 */
+	if (ack.mask & ~req.mask)
+		return coredump_sock_oob(cprm->file, COREDUMP_OOB_UNSUPPORTED);
+
+	/* Handle mutually exclusive options. */
+	if (hweight64(ack.mask & (COREDUMP_USERSPACE | COREDUMP_KERNEL |
+				  COREDUMP_REJECT)) != 1)
+		return coredump_sock_oob(cprm->file, COREDUMP_OOB_CONFLICTING);
+
+	if (ack.spare)
+		return coredump_sock_oob(cprm->file, COREDUMP_OOB_UNSUPPORTED);
+
+	cn->mask = ack.mask;
+	return 0;
+}
+#endif
+
 void do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -850,6 +967,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK_REQ:
+		fallthrough;
 	case COREDUMP_SOCK: {
 #ifdef CONFIG_UNIX
 		struct file *file __free(fput) = NULL;
@@ -918,6 +1037,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 		cprm.limit = RLIM_INFINITY;
 		cprm.file = no_free_ptr(file);
+
+		retval = coredump_request(&cn, &cprm);
+		if (retval)
+			goto close_fail;
 #else
 		coredump_report_failure("Core dump socket support %s disabled", cn.corename);
 		goto close_fail;
@@ -929,12 +1052,20 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		goto close_fail;
 	}
 
+	/* Don't even generate the coredump. */
+	if (cn.mask & COREDUMP_REJECT)
+		goto close_fail;
+
 	/* get us an unshared descriptor table; almost always a no-op */
 	/* The cell spufs coredump code reads the file descriptor tables */
 	retval = unshare_files();
 	if (retval)
 		goto close_fail;
-	if (!dump_interrupted()) {
+
+	if (dump_interrupted())
+		goto close_fail;
+
+	if (cn.mask & COREDUMP_KERNEL) {
 		/*
 		 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
 		 * have this set to NULL.
@@ -968,17 +1099,23 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		kernel_sock_shutdown(sock_from_file(cprm.file), SHUT_WR);
 #endif
 
+	/* Let the parent know that a coredump was generated. */
+	if (cn.mask & COREDUMP_USERSPACE)
+		core_dumped = true;
+
 	/*
 	 * When core_pipe_limit is set we wait for the coredump server
 	 * or usermodehelper to finish before exiting so it can e.g.,
 	 * inspect /proc/<pid>.
 	 */
-	if (core_pipe_limit) {
+	if (cn.mask & COREDUMP_WAIT) {
 		switch (cn.core_type) {
 		case COREDUMP_PIPE:
 			wait_for_dump_helpers(cprm.file);
 			break;
 #ifdef CONFIG_UNIX
+		case COREDUMP_SOCK_REQ:
+			fallthrough;
 		case COREDUMP_SOCK: {
 			ssize_t n;
 
@@ -1249,8 +1386,8 @@ static inline bool check_coredump_socket(void)
 	if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
 		return false;
 
-	/* Must be an absolute path. */
-	if (*(core_pattern + 1) != '/')
+	/* Must be an absolute path or the socket request. */
+	if (*(core_pattern + 1) != '/' && *(core_pattern + 1) != '@')
 		return false;
 
 	return true;
diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
new file mode 100644
index 000000000000..cc3e5543c10a
--- /dev/null
+++ b/include/uapi/linux/coredump.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_COREDUMP_H
+#define _UAPI_LINUX_COREDUMP_H
+
+#include <linux/types.h>
+
+/**
+ * coredump_{req,ack} flags
+ * @COREDUMP_KERNEL: kernel writes coredump
+ * @COREDUMP_USERSPACE: userspace writes coredump
+ * @COREDUMP_REJECT: don't generate coredump
+ * @COREDUMP_WAIT: wait for coredump server
+ */
+enum {
+	COREDUMP_KERNEL		= (1ULL << 0),
+	COREDUMP_USERSPACE	= (1ULL << 1),
+	COREDUMP_REJECT		= (1ULL << 2),
+	COREDUMP_WAIT		= (1ULL << 3),
+};
+
+/**
+ * struct coredump_req - message kernel sends to userspace
+ * @size: size of struct coredump_req
+ * @size_ack: known size of struct coredump_ack on this kernel
+ * @mask: supported features
+ *
+ * When a coredump happens the kernel will connect to the coredump
+ * socket and send a coredump request to the coredump server. The @size
+ * member is set to the size of struct coredump_req and provides a hint
+ * to userspace how much data can be read. Userspace may use MSG_PEEK to
+ * peek the size of struct coredump_req and then choose to consume it in
+ * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
+ * request. If the size the kernel sends is larger userspace simply
+ * discards any remaining data.
+ *
+ * The coredump_req->mask member is set to the currently know features.
+ * Userspace may only set coredump_ack->mask to the bits raised by the
+ * kernel in coredump_req->mask.
+ *
+ * The coredump_req->size_ack member is set by the kernel to the size of
+ * struct coredump_ack the kernel knows. Userspace may only send up to
+ * coredump_req->size_ack bytes to the kernel and must set
+ * coredump_ack->size accordingly.
+ */
+struct coredump_req {
+	__u32 size;
+	__u32 size_ack;
+	__u64 mask;
+};
+
+enum {
+	COREDUMP_REQ_SIZE_VER0 = 16, /* size of first published struct */
+};
+
+/**
+ * struct coredump_ack - message userspace sends to kernel
+ * @size: size of the struct
+ * @spare: unused
+ * @mask: features kernel is supposed to use
+ *
+ * The @size member must be set to the size of struct coredump_ack. It
+ * may never exceed what the kernel returned in coredump_req->size_ack
+ * but it may of course be smaller (>= COREDUMP_ACK_SIZE_VER0 and <=
+ * coredump_req->size_ack).
+ *
+ * The @mask member must be set to the features the coredump server
+ * wants the kernel to use. Only bits the kernel returned in
+ * coredump_req->mask may be set.
+ */
+struct coredump_ack {
+	__u32 size;
+	__u32 spare;
+	__u64 mask;
+};
+
+enum {
+	COREDUMP_ACK_SIZE_VER0 = 16, /* size of first published struct */
+};
+
+/**
+ * enum coredump_oob - Out-of-band markers for the coredump socket
+ *
+ * The kernel will place a single coredump_oob marker on the coredump
+ * socket. An interested coredump server can listen for POLLPRI and
+ * figure out why the provided coredump_ack was invalid.
+ *
+ * The out-of-band markers allow advanced userspace to infer more details
+ * about a coredump ack. They are optional and can be ignored. They
+ * aren't necessary for the coredump server to function correctly.
+ *
+ * @COREDUMP_OOB_INVALIDSIZE: the provided coredump_ack size was invalid
+ * @COREDUMP_OOB_UNSUPPORTED: the provided coredump_ack mask was invalid
+ * @COREDUMP_OOB_CONFLICTING: the provided coredump_ack mask has conflicting options
+ * @__COREDUMP_OOB_MAX: the maximum value for coredump_oob
+ */
+enum coredump_oob {
+	COREDUMP_OOB_INVALIDSIZE = 1U,
+	COREDUMP_OOB_UNSUPPORTED = 2U,
+	COREDUMP_OOB_CONFLICTING = 3U,
+	__COREDUMP_OOB_MAX       = 255U,
+};
+
+#endif /* _UAPI_LINUX_COREDUMP_H */

-- 
2.47.2


