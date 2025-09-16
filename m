Return-Path: <linux-fsdevel+bounces-61582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B4CB589FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161EA7AC2B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861463D561;
	Tue, 16 Sep 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrpwbT5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBF5C96
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983652; cv=none; b=iHUHMWFE7stAWIwwfxmpiP04hhuFndWO7iwV620l4sjPg8qEnjKTtLh4bGuPmXCQosBZSI/TPzppEuPIiwycx2waXh5OhO73rO/4ou2ppwwPyRjI4awzaHty4AB2KnMIIvOuLbsaMObzSm0jUNDlaGw49AkAyTzwBZU23kvuk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983652; c=relaxed/simple;
	bh=P/1yRqqXGcaldhj8gkz7s2Mc46pW+li+6tiyLOB8PGo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+XDZ+c0AUHk1aEm3WMUJ/e96nvUarBzjYAdnB4twznqv0UZPVEIMR6VYVp/6kvR1WjaC7EbbpGNiQrQuHm0L/xLZ0aeVSKz+3EDDyddHClFscG1y1zQWW+nHnw7GMltIg3CuvmFiMkCtss+hgRwEaTG35W1xGDR6ayLnMbyHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrpwbT5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590E8C4CEF1;
	Tue, 16 Sep 2025 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983651;
	bh=P/1yRqqXGcaldhj8gkz7s2Mc46pW+li+6tiyLOB8PGo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YrpwbT5VHKWVaABXO1dW6on6JHN/KfeBSv7xbIKTPjV2hywAfSHRdmJA8WHlJgmyQ
	 9DLfVLhDVkZEpf1QpmCrb9DxlXPQt2wyA0JwgMwSVgOVAtZ5tXQM79l/TqJciSC87m
	 Y458Ix8i4A6iR5EaoZhGQHEz15ILookw7GSJ+DfEU6DncrM7m2bhttLCvwstqpAUKW
	 fp4qeFmrGzQOV8zNlM0YScB/scAhtCmUxiD9PJO0Wp1OE9TRbEK0iFqVmYRirH2eNJ
	 inAvuhwswxAwamHr2tRnyxJCOjQfJVXvuymMXE6+NgUNj2//w9VCRfbs9vfT8QtqWD
	 F7tJjjd7SYcEQ==
Date: Mon, 15 Sep 2025 17:47:30 -0700
Subject: [PATCH 3/4] libfuse: wire up FUSE_SYNCFS to the low level library
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155295.387738.4752456657837395030.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
References: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create hooks in the lowlevel library for syncfs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
 2 files changed, 35 insertions(+)


diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 687e14b8fea64f..9de93392d6df67 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1422,6 +1422,22 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*iomap_config) (fuse_req_t req, uint64_t flags,
 			      uint64_t maxbytes);
+
+	/**
+	 * Flush the entire filesystem to disk.
+	 *
+	 * If this request is answered with an error code of ENOSYS, this is
+	 * treated as a permanent failure, i.e. all future syncfs() requests
+	 * will fail with the same error code without being sent to the
+	 * filesystem process.
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the inode number
+	 */
+	void (*syncfs) (fuse_req_t req, fuse_ino_t ino);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index a6294c5c065cd2..668645dd1c2e08 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2783,6 +2783,23 @@ static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_config(req, nodeid, inarg, NULL);
 }
 
+static void _do_syncfs(fuse_req_t req, const fuse_ino_t nodeid,
+		      const void *op_in, const void *in_payload)
+{
+	(void)op_in;
+	(void)in_payload;
+
+	if (req->se->op.syncfs)
+		req->se->op.syncfs(req, nodeid);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_syncfs(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg)
+{
+	_do_syncfs(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3704,6 +3721,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_SYNCFS]	   = { do_syncfs,	"SYNCFS"     },
 	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3763,6 +3781,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },


