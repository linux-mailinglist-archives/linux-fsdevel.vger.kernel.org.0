Return-Path: <linux-fsdevel+bounces-49622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C1CAC0100
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4379516CB58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D558849C;
	Thu, 22 May 2025 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Nk4EHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F27464
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872398; cv=none; b=ikKRB6vm7eX0WsTVkfKDJMmFi5qWmzpgAIktbvUxx4JYxmuS0rjJaWx7x404gn2kSwODslyFbkeKVAGU22VkwXEzkTMEP8MjS1CweN6WnYV2OrLUOefVgDn1WZbAr0kpyxdg+/pc/DtG+Ys6X7aV8OBt9KRouZ/LHk5o/Lyzq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872398; c=relaxed/simple;
	bh=Fh9VzFh8lH+3JdHnUiBwMtVSUu6D17xofRBN5vLhQBQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chI6hrawoefqvQJwVpt5lgjet0Z9YdAhj99MGd0cXSSEYJ3UpXhiPdHPgZKdYmAqrdyCPAzPiAFANvLFUlYrdgYqmnl8hgAV8IXDvbOglAaKRSATOdq/+Q03Pkh9bnB6isw1WLDGlQIMMagB/7U1cCoKRpCKM9Q9s83QSbCk1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Nk4EHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD67C4CEE4;
	Thu, 22 May 2025 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872398;
	bh=Fh9VzFh8lH+3JdHnUiBwMtVSUu6D17xofRBN5vLhQBQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W9Nk4EHt+pJSdOeRtyFjm1hl4RaqwQSYiqp9VrhHQBbYG/11+E88ZwmillBnhFtPz
	 fXL2x0inX/MSfvqAZmdi1PEQdpNO8f7Nj3v/WjYk3hE9KSwZTwFHamTHPfme03uq7t
	 NePvZ8awc+3rEYBHXxLOQqwjLHc3k1lYAOOnZGG+NjgA/9BvTnvDR8+mHRFfNoU2kn
	 6Gk99d8vDSP/L9vBJrRhPZdqR4YZlTMjGcV36zyY0AhLunWaRmujaCfTsAC32aC092
	 pDyrXmaPfYihhlQ4FKCwUdVu4dMrkIz7AfIjN8FGSm8gNJoBK/IPlJwZ5MAMprFcOX
	 zzxZFmn0fuxrQ==
Date: Wed, 21 May 2025 17:06:37 -0700
Subject: [PATCH 5/8] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196448.1483718.4449462565909691278.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |   17 +++++++++++++++++
 include/fuse_kernel.h   |   15 +++++++++++++++
 include/fuse_lowlevel.h |   20 ++++++++++++++++++++
 lib/fuse_lowlevel.c     |   30 ++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index fb9c2f5c3811e3..f7bc03427d12e4 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -525,6 +525,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_IOMAP (1ULL << 32)
 
+/**
+ * Client supports using iomap for direct I/O file operations
+ */
+#define FUSE_CAP_IOMAP_DIRECTIO (1ULL << 33)
+
 /**
  * Ioctl flags
  *
@@ -1182,6 +1187,18 @@ struct fuse_iomap {
 };
 #endif /* FUSE_USE_VERSION >= 318 */
 
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 15)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 94efb90279579c..a2c044b5957169 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -234,6 +234,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_NOTIFY_ADD_IOMAP_DEVICE for multi-device filesystems
+ *  - add FUSE_IOMAP_DIRECTIO for direct I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -442,6 +443,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
+ * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -490,6 +492,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_IOMAP		(1ULL << 43)
+#define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
 
 /**
  * CUSE INIT request/reply flags
@@ -658,6 +661,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1336,4 +1340,15 @@ struct fuse_iomap_add_device_out {
 	uint32_t *map_dev;	/* location to receive device cookie */
 };
 
+struct fuse_iomap_ioend_in {
+	uint16_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
+	uint16_t reserved;	/* zero */
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
index c9975f1862a074..eb457007a72cbc 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1362,6 +1362,26 @@ struct fuse_lowlevel_ops {
 	void (*iomap_end) (fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
 			   off_t pos, uint64_t count, uint32_t opflags,
 			   ssize_t written, const struct fuse_iomap *iomap);
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
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ef92ab8c062cbf..9d07743fe522c6 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2491,6 +2491,27 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
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
+		fuse_reply_err(req, 0);
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
@@ -2616,6 +2637,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
+		if (inargflags & FUSE_IOMAP_DIRECTIO)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP_DIRECTIO;
 
 	} else {
 		se->conn.max_readahead = 0;
@@ -2664,6 +2687,7 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 
 	/* servers need to opt-in to iomap explicitly */
 	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP_DIRECTIO);
 
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
@@ -2790,6 +2814,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_OVER_IO_URING;
 	if (se->conn.want_ext & FUSE_CAP_IOMAP)
 		outargflags |= FUSE_IOMAP;
+	if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
+		outargflags |= FUSE_IOMAP_DIRECTIO;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2833,6 +2859,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 				outarg.max_stack_depth);
 		if (se->conn.want_ext & FUSE_CAP_IOMAP)
 			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
+		if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap_directio=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;
@@ -3311,6 +3339,7 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3367,6 +3396,7 @@ static struct {
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 


