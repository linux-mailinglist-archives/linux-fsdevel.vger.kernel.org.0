Return-Path: <linux-fsdevel+bounces-61567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C0B589EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598377A2DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2071A3172;
	Tue, 16 Sep 2025 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivVz1YOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766E179A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983417; cv=none; b=fnjDt0+blQewK4ANloG8rvKCj7VTnZLf8bwIcJUVGJOTkddqWQoh3wss+QYfyCOKMmeqMXAwd8LASdoSHc94Tqjkl+ZAYE2YNXbZe0oUqoXxFsFK2pDaHl1w+SY0db2cWIe8Jkyze+nPdJr9BzgqL4uBVji/4onqfU9HDeMiBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983417; c=relaxed/simple;
	bh=wE9b7Xcp2YyTXyWy2IdrMNz7+QkOvAMvLVAfiaq+MKY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzoKBt8UUVliXDHarY2xrQ/Y+KVviH53D5LWAQzUPIAnqlArU4SNBv731ynx5OpBVq6ZPwUnPJwhcHufjYVnktRP8ELNgbgmebxGYmbWllxlhA1nMTEvzF7BUXsa/SiPXRo/lxGY0RTjpCEtkdF7mZAfLMou4/nT9wjOcIRuCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivVz1YOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F447C4CEF1;
	Tue, 16 Sep 2025 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983417;
	bh=wE9b7Xcp2YyTXyWy2IdrMNz7+QkOvAMvLVAfiaq+MKY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ivVz1YOVmb1oTPmnsyz29dnqo1ABxPL0G0br/NL+26Hep+mK51/E5ip3+eHiP/MhE
	 1wnsFv66iX2xRTQ8ufVY/d3DJSTM8UlFA4vLcqPdJ982PIvjXLjRImx3rP9oB35y9a
	 ocNKB20musWY9ZkBa9A9Tm6bUy6CNPtII8CuGd4+LE5GA9ya8pNid6pc+R+t88RZVH
	 dx/Zam2pUdbzDG1duDYe9CEihk4c3LjNTlE3UCrTsSo+GTtU2J9HsrZ6W+Nxr+iOEi
	 uZplxDzsAgI4aE5IkUf32nqbLv3beqJQVJO2CjI+KJ6Uyxt0YOKgGN0A+/OgQV/Sbx
	 m/Faq8rv3GsBg==
Date: Mon, 15 Sep 2025 17:43:36 -0700
Subject: [PATCH 07/18] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154636.386924.9372349709907667483.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
index b544d0700165e8..b349ede09e494f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -663,6 +663,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1342,4 +1343,14 @@ struct fuse_iomap_end_in {
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
index 45e3cf8c79b91d..ab274091f2248f 100644
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
index a3cc5491ff6a24..e8b78622b8f850 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2638,6 +2638,27 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
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
@@ -3539,6 +3560,7 @@ static struct {
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3596,6 +3618,7 @@ static struct {
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 


