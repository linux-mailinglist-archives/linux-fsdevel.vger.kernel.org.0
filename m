Return-Path: <linux-fsdevel+bounces-66078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C7C17BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55354E847B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A82D839F;
	Wed, 29 Oct 2025 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgxQnJjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D52D2381;
	Wed, 29 Oct 2025 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699888; cv=none; b=NKSKHenr9VFxoDhoVyub2+8F4Vv9NK54W9KZuLqpx5DJyMcHjoGAyuNKM0K7EHiwAZfna3QjCnCpEmnoZr3w8g7BBWUmEiHRkSmjFFMiR448F9JKrB7iy0+HnDp3+A7Ta+J3Uu9uvxuWIxFUT7uQg5ojVjzjFTZtT9Etx9EVif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699888; c=relaxed/simple;
	bh=f+bF98SpYOEeXr1qRa9QzgR1SbTr6s1biUTsw1PoK80=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMbrpB5hzAPHq7NFTgSDQGQid7cASXR9WHI39GALuwusEygjtY9ckvrbMrtXNT7iCoTb2SoIbAReXq49MaapkdxQ9fPWMCUa0wxPElbM1Co9lWnHHkCESovVDPWl4zco1x5scGZFLxnbIprhE6FfEeYMsWoqgQgsfp8sGnWEERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgxQnJjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65432C4CEE7;
	Wed, 29 Oct 2025 01:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699887;
	bh=f+bF98SpYOEeXr1qRa9QzgR1SbTr6s1biUTsw1PoK80=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OgxQnJjPyndbPJtEFONFZzxPKzydGknTsXFjlI7VKbG4JwBPEgOtvGxw73yZExbSQ
	 v+vVH59Oh/8UgKnURtp9kgWMcCYzR0XImMDAOPC2yeCNFUZHNr0Oip5DO2p6HZLjeQ
	 Z/ApM4xfjbrKVCaGnzAk4bc6LEuD9vOLG8O09L25scZg+9Jn3lGyN8vfRiHj4+q3dH
	 +ynF1FniZduH/oKvwinAoXC5S5JRnvOfbhW/H6GCKxnvx6UJm5NUbk0KhVLOklhkiJ
	 1kzE7xRBoDRwoqx9YgkZv7QWtsI+V6pbDsNZ1WUm1K4v0uAGmfZr3+eDpmXYUsnCll
	 mIS5YCVg+8F6g==
Date: Tue, 28 Oct 2025 18:04:46 -0700
Subject: [PATCH 21/22] libfuse: add lower-level filesystem freeze, thaw,
 and shutdown requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813912.1427432.13731634577241744688.stgit@frogsfrogsfrogs>
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

Pass the kernel's filesystem freeze, thaw, and shutdown requests through
to low level fuse servers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |   12 +++++++++
 include/fuse_lowlevel.h |   35 +++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 5b9259714a628d..37e5eb8c65f206 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -676,6 +676,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_FREEZE_FS		= 4089,
+	FUSE_UNFREEZE_FS	= 4090,
+	FUSE_SHUTDOWN_FS	= 4091,
+
 	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
@@ -1225,6 +1229,14 @@ struct fuse_syncfs_in {
 	uint64_t	padding;
 };
 
+struct fuse_freezefs_in {
+	uint64_t	unlinked;
+};
+
+struct fuse_shutdownfs_in {
+	uint64_t	flags;
+};
+
 /*
  * For each security context, send fuse_secctx with size of security context
  * fuse_secctx will be followed by security context name and this in turn
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 110f7f73edbb2a..b37d1f03ab5d7f 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1422,6 +1422,41 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*iomap_config) (fuse_req_t req, uint64_t flags,
 			      uint64_t maxbytes);
+
+	/**
+	 * Freeze the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 * @param unlinked count of open unlinked inodes
+	 */
+	void (*freezefs) (fuse_req_t req, fuse_ino_t ino, uint64_t unlinked);
+
+	/**
+	 * Thaw the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 */
+	void (*unfreezefs) (fuse_req_t req, fuse_ino_t ino);
+
+	/**
+	 * Shut down the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 * @param flags zero, currently
+	 */
+	void (*shutdownfs) (fuse_req_t req, fuse_ino_t ino, uint64_t flags);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 605848bb4cd55b..728a6b635471c7 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2835,6 +2835,60 @@ static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_config(req, nodeid, inarg, NULL);
 }
 
+static void _do_freezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	const struct fuse_freezefs_in *inarg = op_in;
+	(void)in_payload;
+
+	if (req->se->op.freezefs)
+		req->se->op.freezefs(req, nodeid, inarg->unlinked);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_freezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_freezefs(req, nodeid, inarg, NULL);
+}
+
+static void _do_unfreezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	(void)op_in;
+	(void)in_payload;
+
+	if (req->se->op.unfreezefs)
+		req->se->op.unfreezefs(req, nodeid);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_unfreezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_unfreezefs(req, nodeid, inarg, NULL);
+}
+
+static void _do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	const struct fuse_shutdownfs_in *inarg = op_in;
+	(void)in_payload;
+
+	if (req->se->op.shutdownfs)
+		req->se->op.shutdownfs(req, nodeid, inarg->flags);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_shutdownfs(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3764,6 +3818,9 @@ static struct {
 	[FUSE_COPY_FILE_RANGE_64] = { do_copy_file_range_64, "COPY_FILE_RANGE_64" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_FREEZE_FS]   = { do_freezefs,	"FREEZE"     },
+	[FUSE_UNFREEZE_FS] = { do_unfreezefs,	"UNFREEZE"   },
+	[FUSE_SHUTDOWN_FS] = { do_shutdownfs,	"SHUTDOWN"   },
 	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3824,6 +3881,9 @@ static struct {
 	[FUSE_COPY_FILE_RANGE_64]	= { _do_copy_file_range_64, "COPY_FILE_RANGE_64" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_FREEZE_FS]	= { _do_freezefs,	"FREEZE" },
+	[FUSE_UNFREEZE_FS]	= { _do_unfreezefs,	"UNFREEZE" },
+	[FUSE_SHUTDOWN_FS]	= { _do_shutdownfs,	"SHUTDOWN" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },


