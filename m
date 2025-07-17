Return-Path: <linux-fsdevel+bounces-55350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA9B09824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F5D3A8C22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36A24110F;
	Thu, 17 Jul 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk+taIh7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870B233D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795344; cv=none; b=FPW2UoLxTZ9m8hmJFhvZuaDaUDvkYB9d4Tlk0py+SA5uWO2weXX61SS40T2YMbIxnxakKyrxdL/GQ5n5C1u/Rm+JiSdHMhHOGjISOLBC9JjDgKAwE4DbLKdTD5Wtbxdbqk6gtAhFTEZQcy85AVJMFQ6sQKDN3+Gy3ecFfOR4RTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795344; c=relaxed/simple;
	bh=zLFBdyUB8Ps/HSe+Xg4w/vOiOGMgpNvnAip73xIfluo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjZdLThdUVnv80zyekcdAOVDeEKkqqEzZUOn+mpL1Pb+dzMdzHTagWEh2iN0Oliq+ymstzHGiA0CP3rRHkLDdD7yQrjAjYlcm7jdEvTjGlWSMHv8WR2Sb8nbVRvWt6+0XM8LJTwHj7khyQd67hAdkbB6d0+QGtWpTAVleQ0123c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk+taIh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A06C4CEEB;
	Thu, 17 Jul 2025 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795343;
	bh=zLFBdyUB8Ps/HSe+Xg4w/vOiOGMgpNvnAip73xIfluo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sk+taIh7PMNn84NL/8g5eiaCw7BQ5J/O4tOIsW/TkjIbaUoF123xMasva5ses1IB4
	 1zwVF/EH8vdAaK88rW5zLfwf5QxjEfgJm51VIYrz8noWHP6rXhWA1xh7Dhe84dEtdN
	 J2pqjF/ZLSuBJomXpcjOBLtvkG5m1XD6i8y7bMUnkOSdJ3guGB1IVtjUUvtqxardMr
	 y/DtfrtnXqAgZfa5HMcbx8FxsBXin/RVQ9EsmrV9m9dHJpD+0WFuzz8MNNQTyGavde
	 +CHUizdVUrcRsWdeme7mPPw6OnIbtwBGRxtvBVSESP0ryTj/8PvwnPE/mpXewxqX63
	 pX/wlF0eGM39g==
Date: Thu, 17 Jul 2025 16:35:43 -0700
Subject: [PATCH 05/14] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459821.714161.1192992166087050782.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
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
 include/fuse_kernel.h   |   12 ++++++++++++
 include/fuse_lowlevel.h |   20 ++++++++++++++++++++
 lib/fuse_lowlevel.c     |   24 +++++++++++++++++++++++-
 4 files changed, 68 insertions(+), 1 deletion(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index f48724b0d1ea0f..66c25afe15ec76 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1197,6 +1197,19 @@ struct fuse_iomap {
 	uint16_t flags;		/* FUSE_IOMAP_F_* */
 	uint32_t dev;		/* device cookie */
 };
+
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
 #endif /* FUSE_USE_VERSION >= 318 */
 
 /* ----------------------------------------------------------- *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 97ca55f0114b1d..a06c16243a7885 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -666,6 +666,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1341,4 +1342,15 @@ struct fuse_iomap_end_in {
 	uint32_t map_dev;	/* device cookie */
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
index d3e505ed52815b..1b856431de0a60 100644
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
index 5df0cdd4ac461a..d26043fa54c036 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2515,6 +2515,27 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
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
@@ -2713,7 +2734,6 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
-
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -3395,6 +3415,7 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3451,6 +3472,7 @@ static struct {
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 


