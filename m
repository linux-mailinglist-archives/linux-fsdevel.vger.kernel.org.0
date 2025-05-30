Return-Path: <linux-fsdevel+bounces-50221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E468AAC8CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81247A98C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD5227E82;
	Fri, 30 May 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2atdSaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77119AD70
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603441; cv=none; b=PqUdeAnyMxvGvhCJmyHH8xoVfw0C/BsMpBK9P/rTd4RxCUzNQiGlLHa1e7sLYhYqbh1XrlvQgyzqX2Zthpw4/hmAnprY0tA7LmNakeCzopLiKXvkI4RUhQhcPQXxBvWEPVhGEVRhTYhXY5QN+Dv+S4G9lZbpBa83w//n6krxrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603441; c=relaxed/simple;
	bh=WT+oCVOZ9hV9lOdxwFmNZSx67RnscZbMhhQ2Es/DOXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehzhIZjYn8GrbKsEfYDE01nrTpT2h/QGDD2eEjYW+MMLztO+jDkxd0AOthLFyZuSnWhFp6UK1gNZet/ywZWWso9MXthiiB1kEX1XRCofAPBcuMMQzzx9ajf3CRfheWr52yinGw/YkKfJFJ3XI1aKPDJgutoEFjyCI65VHWIuV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2atdSaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE37C4CEE9;
	Fri, 30 May 2025 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748603439;
	bh=WT+oCVOZ9hV9lOdxwFmNZSx67RnscZbMhhQ2Es/DOXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C2atdSaTmZN5CA7TzkoUPC+XfFL42Zf/HZB7hH/pfRDhF1J5OfS4VwOh5HbgluXgY
	 i9JoaFbX2wApStmY5bHQP+Jer6rf6s5QD4PsQCMIdp523GUxU7RlFWL6cobqEHs30d
	 uBbbjEmF74xVdNv1n+TS71n3cU0HwACZpT0eHlouuTYImIaioTyPsdFqCgsdMFz1BM
	 8EIKlwJAmZ5RfeoHzr4Ao8BxL+KRQtODjFD+kEdzgFyrKkAAoJXBk1BpsFa02Kfg0x
	 H55XDU7AFuqOBmYEqqRfatIgQE5VkDRAPxhhRX1bENOCcZx+EspRls66r1YALxjgYw
	 HiGT+t9hjlFzA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 May 2025 13:10:02 +0200
Subject: [PATCH 4/5] tools: add coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-work-coredump-socket-protocol-v1-4-20bde1cd4faa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4175; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WT+oCVOZ9hV9lOdxwFmNZSx67RnscZbMhhQ2Es/DOXs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYTlLQ8rQ1zp9ycZpm6Nzar+tnvPo1jzeSVcizLZrZs
 nz39jM2HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZzMjwv1j7AUtH34K7iWtC
 c39b8Hw8vXDux1eTMpV91h+tqOru4mX4X2A544hNMrNe4A+FRUna11lYAiSjbHdN3b82dY//sat
 izAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Copy the coredump header so we can rely on it in the selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 104 ++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
new file mode 100644
index 000000000000..cc3e5543c10a
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


