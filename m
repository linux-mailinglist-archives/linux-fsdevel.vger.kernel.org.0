Return-Path: <linux-fsdevel+bounces-58482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB738B2E9FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338AA5607C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A761DF97D;
	Thu, 21 Aug 2025 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn733i/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B941A9F9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738192; cv=none; b=j4Ib0DN0WVLbSyd7E7t/43PCLgIn7s//A1FFW35OfJvn3v1YRP5hOmmIeFej3jUm4o+Us93SZrMin7DMSi7wl+iujPIa4GCSq5sXqdhr5W7PDrzp7mzDBP+zI3yHgp6I6xFLdtRCSkKofM7HeShbtqpTOFQtpoSiQ0HTl8qoCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738192; c=relaxed/simple;
	bh=ICnpMZMiYgPqKNepff0US6CbBP+HNOc9mcd3aOPKH0s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtM8uKhBFdcZ37vB6+rh64o1dO1bIqjKdfRX63lRm6n8MNly3dTbuoTycqcaKxf8AE+WuwPXnDcr7t/+skEic3JCzljGizf4hCp/lf+9ydpGmYBHn2uZiaN45g6TR4OpA2RqvzlK/u5h3U5l3v5mw/XsB1/ITORmhF6Y95IZ4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn733i/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7268C4CEE7;
	Thu, 21 Aug 2025 01:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738191;
	bh=ICnpMZMiYgPqKNepff0US6CbBP+HNOc9mcd3aOPKH0s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Hn733i/qtyTEQyzh7gz7AB8BKfnpjaDqqCaoZIrDMdyOEwZ0Hiv6zgbUtXdWbfz2L
	 WPQ/ejDgLJRTcyaqB4zvsYAhc30dQBvp6xVhVT10YnvukcTEpaPivFag/yVN31Z/vR
	 cYPbq4FbQlIMkv4MUdGoIsJjQ3rpY9r72lUG0hhkr5SbgNHO0SwCWlRFm4o7Qu7l9h
	 mzmNpGrEdBDVPi6mFSADlY4DtU4jSmr6ouF7ziiOJQDqKCa1UX02I/7NqY4ziLjCkO
	 tRBloiK7XZyT9QYRSILQ24IabjfmybW11VrRHRkR9k1c489VONS0HzC7b91D1doGLq
	 mg/lpWo9E5emw==
Date: Wed, 20 Aug 2025 18:03:11 -0700
Subject: [PATCH 07/21] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711414.19163.16726092338863056278.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Teach the low level library about the iomap ioend handler, which gets
called by the kernel when we finish a file write that isn't a pure
overwrite operation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   11 +++++++++++
 include/fuse_kernel.h   |   11 +++++++++++
 include/fuse_lowlevel.h |   20 ++++++++++++++++++++
 lib/fuse_lowlevel.c     |   23 +++++++++++++++++++++++
 4 files changed, 65 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index d10364a077f31d..77e971c3fed17d 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1215,6 +1215,17 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 		!(opflags & FUSE_IOMAP_OP_ZERO);
 }
 
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
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 2bcb3b394c0169..849238c17baf5e 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -665,6 +665,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1337,4 +1338,14 @@ struct fuse_iomap_end_in {
 	struct fuse_iomap_io	map;
 };
 
+struct fuse_iomap_ioend_in {
+	uint32_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
+	int32_t error;		/* negative errno or 0 */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t new_addr;	/* disk offset of new mapping, in bytes */
+	uint32_t written;	/* bytes processed */
+	uint32_t reserved1;	/* zero */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 45655781e510a0..7f7f418b281601 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1379,6 +1379,26 @@ struct fuse_lowlevel_ops {
 	void (*iomap_end) (fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
 			   off_t pos, uint64_t count, uint32_t opflags,
 			   ssize_t written, const struct fuse_file_iomap *iomap);
+
+	/**
+	 * Complete an iomap IO operation
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param nodeid the inode number
+	 * @param attr_ino inode number as told by fuse_attr::ino
+	 * @param pos position in file, in bytes
+	 * @param written number of bytes processed, or a negative errno
+	 * @param ioendflags mask of FUSE_IOMAP_IOEND_ flags specifying operation
+	 * @param error errno code of what went wrong
+	 * @param new_addr disk address of new mapping, in bytes
+	 */
+	void (*iomap_ioend) (fuse_req_t req, fuse_ino_t nodeid,
+			     uint64_t attr_ino, off_t pos, size_t written,
+			     uint32_t ioendflags, int error,
+			     uint64_t new_addr);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index fec4e3265e53c1..ce7971a23be94b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2637,6 +2637,27 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_end(req, nodeid, inarg, NULL);
 }
 
+static void _do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *op_in, const void *in_payload)
+{
+	const struct fuse_iomap_ioend_in *arg = op_in;
+	(void)in_payload;
+	(void)nodeid;
+
+	if (req->se->op.iomap_ioend)
+		req->se->op.iomap_ioend(req, nodeid, arg->attr_ino, arg->pos,
+					arg->written, arg->ioendflags,
+					arg->error, arg->new_addr);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
+			   const void *inarg)
+{
+	_do_iomap_ioend(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3524,6 +3545,7 @@ static struct {
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3581,6 +3603,7 @@ static struct {
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 


