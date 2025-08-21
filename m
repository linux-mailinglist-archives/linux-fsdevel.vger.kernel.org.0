Return-Path: <linux-fsdevel+bounces-58550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BACB2EA7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D99D16514A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21B205E25;
	Thu, 21 Aug 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i15mmP15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB851E493C;
	Thu, 21 Aug 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739256; cv=none; b=gI24d/ZnuyDasbG7sKcyMy+wgrYskT5NakcAS6NAU47vQ5xNTzXJTI8/eRW40g5c8t8rUT9LmHM0Nl6+gVGyO/b/yfGl0HM+UoDkdNnVF4HXNmtX5G6KZhDRI5/CuFuYus5c53c7+tpww5cTMcehR+LpvDpfmECM1cUlinrhyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739256; c=relaxed/simple;
	bh=YzYpJnt4yuNsoYX350PGKrRzeGT+X6AQ7PjpjEl8SrU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMESIST7vrD0DF1LWSuFseHYn4+O9w565kBBzZlC5v1N7+vPAIH8SGyIwa6LvqScI8AoYmKU/XOXDk666WAn5cYRElyfWLrbETxMyxfy1R8HROS0oGYzO5Pnj98krCvcKrnC8fw29YYvqJROmH0Kn8szIP/rXZ/T1BX30foUQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i15mmP15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC38C4CEE7;
	Thu, 21 Aug 2025 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739255;
	bh=YzYpJnt4yuNsoYX350PGKrRzeGT+X6AQ7PjpjEl8SrU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=i15mmP15fd5glylFLcWPsNe60ekap7cSdvL7iduWlMi0d+m57LNTjANlLbTU7SMaI
	 ZUIf8shcH8+uKg7t/UYkanrhYz1xPj1hwCGEm0GEnF+ervgrtpURRL4gh8ax5xRg5a
	 ux9EbPnp0LCCYKxsWU1Ga6dqiQPP0bKII1R0UyFyZ/yYKkAenbUnST0Dm8UtWUg55N
	 rYDAlxXwjdTDfc0fqg9jkNzC3X1fFYO3o2iokljFvg/aKvvKsCw81hJ4dbozxRY9MP
	 F9bbJ9tTJBwWVCIsti0480bGCVGNMQkT2gWHeKvJGcBXfVd5dzIXuiASDaICyEVF13
	 HO6nxGyIdP5bw==
Date: Wed, 20 Aug 2025 18:20:55 -0700
Subject: [PATCH 1/2] fuse2fs: enable caching of iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714218.22718.2857211152626150403.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714195.22718.16229398392414971041.stgit@frogsfrogsfrogs>
References: <175573714195.22718.16229398392414971041.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the iomaps we generate in the kernel for better performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   23 +++++++++++++++++++++++
 misc/fuse4fs.c |   24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 04bb96f3438f23..da384b10bc6bc5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -284,6 +284,7 @@ struct fuse2fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	uint8_t iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5900,6 +5901,23 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
+		if (ret) {
+			ret = translate_error(fs, attr_ino, -ret);
+			goto out_unlock;
+		} else {
+			/* Tell the kernel to retry from cache */
+			read->type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+			read->dev = FUSE_IOMAP_DEV_NULL;
+			read->addr = FUSE_IOMAP_NULL_ADDR;
+		}
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6718,6 +6736,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
 	FUSE2FS_OPT("noblkdev",		noblkdev,		1),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE2FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -6952,6 +6974,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 	};
 	errcode_t err;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 43fc21149ba564..a2601b5ca94970 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -280,6 +280,7 @@ struct fuse4fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	uint8_t iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6224,6 +6225,24 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_lowlevel_notify_iomap_upsert(ff->fuse, fino, ino,
+							&read, NULL);
+		if (ret) {
+			ret = translate_error(fs, ino, -ret);
+			goto out_unlock;
+		} else {
+			/* Tell the kernel to retry from cache */
+			read.type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+			read.dev = FUSE_IOMAP_DEV_NULL;
+			read.addr = FUSE_IOMAP_NULL_ADDR;
+		}
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -7029,6 +7048,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE4FS_OPT("timing",		timing,			1),
 #endif
 	FUSE4FS_OPT("noblkdev",		noblkdev,		1),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE4FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -7362,6 +7385,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 		.translate_inums = 1,
 	};


