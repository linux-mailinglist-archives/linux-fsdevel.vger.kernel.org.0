Return-Path: <linux-fsdevel+bounces-66064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01951C17B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 785F235652A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB842D9498;
	Wed, 29 Oct 2025 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9wwpuWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C981FAC42;
	Wed, 29 Oct 2025 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699670; cv=none; b=VycgywP20YblK8dBnpKsP6TPJ0xKw+1gLM60J3EXtpWt+OO1mascMltgRzSccisWoSzDly3cNjz3w+Pdd9T49MkbxOQdwg+XM85sp6aJExTKFPFRqvHzhYJiE6dNcybfFvdlbqFBl3zdVGRDp3WYIGR0Opxc4RuIxGQpZCSiwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699670; c=relaxed/simple;
	bh=I+LPCtA0z+c61Zm+0+C2yPphQoYhXufqoFXvBt9ca3Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHYRq6i1GYSjlcYK9sdefDQexiNZXuEoB7dijG9y/Pcxcz07SLwmQLSXf4ZNZN4sHoWM3aQV2dpU8zakKDLFl9DMp+FQwIm/ovu4t82Z0agAwEU+GD9l70CsOWtAPIKC8F6E+QdMn2VAk6PfN/fERmGKI3uE3l70gVI9twCTffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9wwpuWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E308C4CEE7;
	Wed, 29 Oct 2025 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699668;
	bh=I+LPCtA0z+c61Zm+0+C2yPphQoYhXufqoFXvBt9ca3Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C9wwpuWjZB+o4ikhGdAq00sco6JuprZpZbkENzWdZar1tBxP2lq1iXTs3JpQ+Xor9
	 v1kNOGnAH63YefkA+dVVs+pt5+q0LGf/V8/NzX5ar53bAjxMyi81mvDnSR4qrXLBHq
	 bQnxVEbS+ncU2gOVBlALRcaA3NSzrHKzcKgzRGcz9DXuzKYM3H2YMro8rjDoEDJ70q
	 3HgiaV7XAjKN/uTSxjL9R8tHdIBCA4jjoKzEqHI+fYJO+7FV8Qx/ayV3F7odaS+igj
	 sOBOaMwrDStrpT525ZOjUzYu/cid5fzQXtDejjzWk0mh9xwC/NMNOseyi1+eQ/UDlG
	 Mjl4MjbwdnKkg==
Date: Tue, 28 Oct 2025 18:01:08 -0700
Subject: [PATCH 07/22] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813659.1427432.5276282398065113594.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |   13 +++++++++++++
 include/fuse_kernel.h   |   11 +++++++++++
 include/fuse_lowlevel.h |   20 ++++++++++++++++++++
 lib/fuse_lowlevel.c     |   23 +++++++++++++++++++++++
 4 files changed, 67 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 12b951039f0a67..c75428dae64e2f 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1208,6 +1208,19 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
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
+/* is pagecache writeback */
+#define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 3857259e27f9c1..378019cc15cfd3 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -668,6 +668,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1352,4 +1353,14 @@ struct fuse_iomap_end_in {
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
index dcacde79e78b1a..bef2e709d559b0 100644
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
index 570253b9dc74b6..3cfabdaed6439d 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2696,6 +2696,27 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
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
@@ -3605,6 +3626,7 @@ static struct {
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3663,6 +3685,7 @@ static struct {
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 


