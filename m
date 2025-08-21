Return-Path: <linux-fsdevel+bounces-58499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260C9B2EA07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9F189E890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E981E32D3;
	Thu, 21 Aug 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCcSWqBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F75FEE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738457; cv=none; b=Rhe5x/a4utAwkBToDp1fafOli0lm2dgYWhGcQ0oncPIVGpFuB6IxhLUFYNrIPRDIblz4LLnW04cgPWcdy7clrD8GiZ1Gj6SCm89mD1ACvP+FQ8qAJM7QIc3GObkPMhWwQrv1lz6WjO9NpO79jMgHGtdcFdA82CQuYCicEcdt23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738457; c=relaxed/simple;
	bh=542lLe08h6aeZOFkkM+nINTNxBKEzBFfcc7pXsaYet0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPkV0VHB1F4yAnY4GZUDCa+2k8fpp57YQhkkKb5xDg1eV4rZy2AZo8gt67Dh9VGwkIQeO6jU+vGI3WiSw/EUamg71jZMHQy39jDejdaQjVpgEWNMLvjsUPEkKf1EhvN5sfoYaj7q3AsSLiT5oQz1mO3IEhnBN8ZHn3wp1qyXLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCcSWqBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB9C4CEE7;
	Thu, 21 Aug 2025 01:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738457;
	bh=542lLe08h6aeZOFkkM+nINTNxBKEzBFfcc7pXsaYet0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NCcSWqBQfgwC5rKNz9bawbqKIi8x7Y74wM3YLoBviqAMNdBccExJvhywajxZau1Hl
	 DISemcsSLe2L/Hkh4i6cSNMajKg261zmaIZh98vhwosiLY9Cxeqjtxqh3s5ry3T5Kc
	 XkAQmC3aAT+AY//gc0xwqKY5yaI1v/dbcD2AceqWUVHCqBbjLHki72euWnW58ISXSF
	 u7xzCzYPQpNdZRqAtCuPKSJd3vf3HsO4ZJeD4Sxk8KHdE0Upq5eRJ44AzZKfaZQ2+D
	 Qw0MNpn2Vt4S//ur83+3QMpyqGfTu4ZmMarOR80L3SQUFGgVmt1FWXkPfJW85YcMir
	 XdP5ikjFeDfNA==
Date: Wed, 20 Aug 2025 18:07:36 -0700
Subject: [PATCH 1/2] libfuse: wire up FUSE_SYNCFS to the low level library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573712212.20121.18374471818685508198.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
References: <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
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
index 326c8f061aecfa..90a09b066c71f0 100644
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
index 721abe2686d9c4..e5c7c4487cef8c 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2776,6 +2776,23 @@ static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
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
@@ -3756,6 +3773,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_SYNCFS]	   = { do_syncfs,	"SYNCFS"     },
 	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3815,6 +3833,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },


