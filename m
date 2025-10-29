Return-Path: <linux-fsdevel+bounces-66083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8BC17C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC431C83657
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1F2D9EF0;
	Wed, 29 Oct 2025 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJvUvc4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376162D94B8;
	Wed, 29 Oct 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699969; cv=none; b=hMqfoaGz1G/6k/ljqCw5zzPvsMr0ZQSTiXRrxvj5QENj+SLHICwc2VnZbbl+saya/BnmJBgUpvJcNdT8pRky5mzS4e1f5NF2vxpfoG1NOYKr8OiU3pf+FZaSDIhPWwHrXIDUVWW7D9Cm32uLS8C3t7TDSJLg+5O2EanhJMMPRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699969; c=relaxed/simple;
	bh=vqTm4LcPyyxek+46YA/qKNR9Hw0Q6s1QEdXz0nY4dMM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuvtiSAn7zO33p71APQzlrG75u0PLIleY3aTwM5Qkz7wiyxuhr2iQvI15x/flxLNKqctW3BE6UtdIgU2AUWRAptYYdgBqdsBR5It/GcnHgx7ih0F1haIKkJKGmiYUlQe61HcBGVdnt3CvXnDpXlJdu5GoVPPEsU2ayI/r3VPRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJvUvc4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92984C4CEE7;
	Wed, 29 Oct 2025 01:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699965;
	bh=vqTm4LcPyyxek+46YA/qKNR9Hw0Q6s1QEdXz0nY4dMM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EJvUvc4gam0x1kDSg0sFWnHP2lLw99XNfeUhxBwkhWRb628RoD/bFH/hNDjHwz52a
	 TDULzxb21CS1pU5NLcbFwFy/E3j6eUEyejuTqsUWqcwVL+/IBeaEYoqLXQRHKLOgcW
	 RTocGxeIX0cuXAwOr83ICp8CZT4CjLIGgJKAio4ERVmG/6enlDeD1xhgOvczaHTjLn
	 LrLeNfc4wdWgXiqZ4SSoV/xvq/LIsNFiVPHE8dI6ky/d1GpYRo6IW6G0xKUnXH3i6A
	 GAMZmx5MBE2apv0ZcWTVhTkAKmlHNLtK1HK9FV8rJsTP5o35yxDi1tRdYCBZUbdgzG
	 A/BUwyTjC913g==
Date: Tue, 28 Oct 2025 18:06:05 -0700
Subject: [PATCH 3/4] libfuse: wire up FUSE_SYNCFS to the low level library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814372.1428390.6057897053088282234.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
References: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
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
index b37d1f03ab5d7f..f12f9b8226aa89 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1457,6 +1457,22 @@ struct fuse_lowlevel_ops {
 	 * @param flags zero, currently
 	 */
 	void (*shutdownfs) (fuse_req_t req, fuse_ino_t ino, uint64_t flags);
+
+	/*
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
index 3ab4a532b4edbb..f58ffa36978ae7 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2895,6 +2895,23 @@ static void do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_shutdownfs(req, nodeid, inarg, NULL);
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
@@ -3824,6 +3841,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE_64] = { do_copy_file_range_64, "COPY_FILE_RANGE_64" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_SYNCFS]	   = { do_syncfs,	"SYNCFS"     },
 	[FUSE_FREEZE_FS]   = { do_freezefs,	"FREEZE"     },
 	[FUSE_UNFREEZE_FS] = { do_unfreezefs,	"UNFREEZE"   },
 	[FUSE_SHUTDOWN_FS] = { do_shutdownfs,	"SHUTDOWN"   },
@@ -3887,6 +3905,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE_64]	= { _do_copy_file_range_64, "COPY_FILE_RANGE_64" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_FREEZE_FS]	= { _do_freezefs,	"FREEZE" },
 	[FUSE_UNFREEZE_FS]	= { _do_unfreezefs,	"UNFREEZE" },
 	[FUSE_SHUTDOWN_FS]	= { _do_shutdownfs,	"SHUTDOWN" },


