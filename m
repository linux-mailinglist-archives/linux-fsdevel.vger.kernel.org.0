Return-Path: <linux-fsdevel+bounces-50468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56368ACC7DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3228D7A6FE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236722DFE8;
	Tue,  3 Jun 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4+R87+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E99231A23
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957542; cv=none; b=ZOJ1w10/jroOYQJ8EuLIC/dTZD8Y2yk4Qllte/kL7SnZhoSySNsWFPK99VkV45os/tav68KRWiQS2X6/bvEq09HQkac9D7BevckNqF1F/mY5T869iPmRHuX4y8Miugoa4gxVMyvDRMnOLbgAtzuDZ+my08+JFRDc+VopTxt9b/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957542; c=relaxed/simple;
	bh=7OksV+j4ftic7jQNOfsEAySa1HsFiI7bkaNYCVpV8pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ybv38E56bCnESOxYv8r2pEhd1fSLTluqFzTf/bKexS+6pywcopQf07v0M2GL6Q0Y6VygoROfMT6QBCE4MOgFnsGleu6rEHYPzBBlssddO9qa+d/h7/O+iP/ah8GDEItItAI5pazF9xlx6XopjEmf8AhJNW5LJH7B1sI01Si3UKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4+R87+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952F4C4CEF3;
	Tue,  3 Jun 2025 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748957542;
	bh=7OksV+j4ftic7jQNOfsEAySa1HsFiI7bkaNYCVpV8pU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4+R87+5Bq5nrtUfgnQ9E/EAafi8ehE8rggCgs7HqZ85JgXGPrJqkaXAGqwwiit1w
	 nhr53DjoA6DOmmxVhleEYTahs+YI0seWiu3Ol+glB/gvLHhnd3NcmMcCkIiApyPLK4
	 JS+hArTiEvwfZaQcTWoEmMUEWf5fm6MT8Tf8tw0D/Xw8WcISCS9tkQsrgT2I+RElsJ
	 t3O0SEkue7JyoFzhKifJQxr93n62q3J18F98+/NGH+mPJ3N5eF12ecaSk/+WDz/PS5
	 U0E0wj7bto38HSzoBrh2SLMCmfRMfu7vB9ZYbPAoLXcRsszH+HMivcmy6ANGocxFyp
	 no0+yFKGrrEZg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Jun 2025 15:31:58 +0200
Subject: [PATCH v2 4/5] tools: add coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-work-coredump-socket-protocol-v2-4-05a5f0c18ecc@kernel.org>
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Jan Kara <jack@suse.cz>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=4211; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7OksV+j4ftic7jQNOfsEAySa1HsFiI7bkaNYCVpV8pU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTY/QxjCuv58n0Jd8smhw21mh84BQxCX/z2M/2drK6jv
 Wd6z/rijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImUr2T4n7z3oCNnT6p3wv0r
 U2/8cJAxXx5u0njVLzKo9YHz4oiXvQz/rHQqGa7sjD09Kyflxq0T88QWdlsL5OeICtSqf8mbaKT
 CCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Copy the coredump header so we can rely on it in the selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 104 ++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
new file mode 100644
index 000000000000..4fa7d1f9d062
--- /dev/null
+++ b/tools/include/uapi/linux/coredump.h
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
+	COREDUMP_REQ_SIZE_VER0 = 16U, /* size of first published struct */
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
+	COREDUMP_ACK_SIZE_VER0 = 16U, /* size of first published struct */
+};
+
+/**
+ * enum coredump_oob - Out-of-band markers for the coredump socket
+ *
+ * The kernel will place a single byte coredump_oob marker on the
+ * coredump socket. An interested coredump server can listen for POLLPRI
+ * and figure out why the provided coredump_ack was invalid.
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
+} __attribute__ ((__packed__));
+
+#endif /* _UAPI_LINUX_COREDUMP_H */

-- 
2.47.2


