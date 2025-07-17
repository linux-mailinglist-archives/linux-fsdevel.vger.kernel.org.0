Return-Path: <linux-fsdevel+bounces-55361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B279B09831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1862B3BB86B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABB23FC4C;
	Thu, 17 Jul 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5+5zmyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE4233D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795516; cv=none; b=R3GSDfra6hFT3GA7vK1y04FmzrjRU+dq8jltkIobdaBEb+BEayq1yX0Z1KZNZz6b+aNhXt44FRf0mDTf7saYbAQzj3XKba9J89C7UYWiFvtNuY7Pqgr8RtU5Sh78UoKquyXccLLZIDw8ScpbbYXgItIU5R6s7hUd2xR6DofP4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795516; c=relaxed/simple;
	bh=PoYB3L78492AbE71O/SlMPuCM0XDjWrRmidASQYoi6c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLxeD21ifyZpUR1ZXUVGqcoRTVHnsA+A5O9piWha30PnZbhlMC8KGjwUmduy7m50oOQyYa7spW55DWWPtBVomi1sKibmPhjxN6k2K74Xj3bFjyUIkmcApIVS0tPS4AJgPs/GbcqR/IVnXga9HJ84+23jsIi/hV4palgVxIrwvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5+5zmyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E8BC4CEE3;
	Thu, 17 Jul 2025 23:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795515;
	bh=PoYB3L78492AbE71O/SlMPuCM0XDjWrRmidASQYoi6c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g5+5zmyXdlEbzU3nIdquVfWJyUILLRcg5BAPtdh7jq4a2IwA6krRQj51ixb+e0b47
	 kWiKUm+KjyAOdMgXjNDMWWUFwrrOcJYhksvCZo8FFUvIkhQXNiMHs9F2kOnDG5VDD+
	 b1zgxnlgNIFRiY+QQYvqDl+w81RlcImA0/j3upFbqHTsimSfVq0HPsEYzLkXxhF63Z
	 blUZG82lNF0eVicQ5/jralk5e1O9NeHIIMWKKc8ZQK52Yra2K7ioak+LC7GldufgK/
	 +JJWfGMe0w1GwYj9GtYP5umci8lMfCfyBAo5vmSdHYdDhVZCYbDbMhnoz6eM1C5izX
	 OjasHUtbAuUUA==
Date: Thu, 17 Jul 2025 16:38:35 -0700
Subject: [PATCH 1/4] libfuse: wire up FUSE_SYNCFS to the low level library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460394.714831.14069407187906016671.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
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
index f690c62fcdd61c..77685e433e4f7d 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1400,6 +1400,22 @@ struct fuse_lowlevel_ops {
 	 * @param maxbytes maximum supported file size
 	 */
 	void (*iomap_config) (fuse_req_t req, uint32_t flags, int64_t maxbytes);
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
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index e31ce96593a9b3..ec30ebc4cdd074 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2636,6 +2636,23 @@ static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
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
@@ -3609,6 +3626,7 @@ static struct {
 	[FUSE_RENAME2]     = { do_rename2,      "RENAME2"    },
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
+	[FUSE_SYNCFS]	   = { do_syncfs,	"SYNCFS"     },
 	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3667,6 +3685,7 @@ static struct {
 	[FUSE_RENAME2]		= { _do_rename2,	"RENAME2" },
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
+	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },


