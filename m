Return-Path: <linux-fsdevel+bounces-55385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD92B09878
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DD41C46055
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04712561A8;
	Thu, 17 Jul 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFdGWV+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929E22FAC3;
	Thu, 17 Jul 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795892; cv=none; b=CEez61i8bUZDdWQF0ZbkI1nHszKak76wc/1WpKPfCuIF7Icbr/994Jfxsz8tD/NoFDJhc9lmF33Vhdywqf7DsqCqMtup+LhtZJZLi5GWExI19Hbb6d6105s1Uwkt/iCSRZDJx6vcAvDHYD5D0vVqclycsWpi/FGPSYYbrVd9FSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795892; c=relaxed/simple;
	bh=fdH+PN4ioZbDGhOA4EW8kuvRR8kaYAiMgHqXbNT/HPw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riPVLPkRM2d81FMN/4bG7NZXoA/a7gvH7PGeNi0bOeztsfZUlMlhHg2ZZVfH1EQjLhi8uEMTDDeTk/U8b6cRim7XMtqQbl47S/JNlRdgxWV93N87g1MuwLdLPdCGYid0a2f04/uyz68B7uP8ecg70Ql5qLVf51e+NJl69uZtYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFdGWV+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02750C4CEE3;
	Thu, 17 Jul 2025 23:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795892;
	bh=fdH+PN4ioZbDGhOA4EW8kuvRR8kaYAiMgHqXbNT/HPw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cFdGWV+NXk0OFdTY4eTDxWmhFKLLS55H8zEyynXl8TWEiM81ydovioS07s2ayO7Wx
	 Sk2ViIgRKO73XqB/saf/g5v0wHGroZ/xlCmd7U40gSgI8uWAi3nBJtcXJkeN5XytWp
	 95uvHbDvVyRkoiSmOF8UQ+xRz8dBNl7Gv8nCQLIZWfEJLIUlIT7pF4KjDgNFF3eXHj
	 p99P0d3ZbjVNInDXBXBF12L4UfSW0khSZTE8J95WKQCo7A69ZRgjfL12VgchsPuFvH
	 eya4OPWI8sHJo4etfgo6BITLPylCnEtOwa3FUSFWa4FxLOx4JcYfQFxq5wAwJxv43s
	 x8QqOBxy0YHUA==
Date: Thu, 17 Jul 2025 16:44:51 -0700
Subject: [PATCH 21/22] fuse2fs: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461413.715479.7362461117350070043.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, we can support the strictatime/lazytime mount options.
Add them to fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e71fcbaeeaf0c6..b5f665ada36991 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -262,6 +262,7 @@ struct fuse2fs {
 	uint8_t unmount_in_destroy;
 	uint8_t noblkdev;
 	uint8_t can_hardlink;
+	uint8_t iomap_passthrough_options;
 
 	enum fuse2fs_opstate opstate;
 	int blocklog;
@@ -1370,6 +1371,10 @@ static void *op_init(struct fuse_conn_info *conn
 		err_printf(ff, "%s\n", _("could not enable iomap."));
 		goto mount_fail;
 	}
+	if (ff->iomap_passthrough_options && !fuse2fs_iomap_enabled(ff)) {
+		err_printf(ff, "%s\n", _("some mount options require iomap."));
+		goto mount_fail;
+	}
 #endif
 #if defined(HAVE_FUSE_IOMAP) && defined(FUSE_CAP_IOMAP_DIRECTIO)
 	if (fuse2fs_iomap_enabled(ff))
@@ -6228,6 +6233,7 @@ enum {
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_IOMAP,
+	FUSE2FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -6251,6 +6257,17 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("lockfile=%s",	lockfile,		0),
 	FUSE2FS_OPT("noblkdev",		noblkdev,		1),
 
+#ifdef HAVE_FUSE_IOMAP
+#ifdef MS_LAZYTIME
+	FUSE_OPT_KEY("lazytime",	FUSE2FS_IOMAP_PASSTHROUGH),
+	FUSE_OPT_KEY("nolazytime",	FUSE2FS_IOMAP_PASSTHROUGH),
+#endif
+#ifdef MS_STRICTATIME
+	FUSE_OPT_KEY("strictatime",	FUSE2FS_IOMAP_PASSTHROUGH),
+	FUSE_OPT_KEY("nostrictatime",	FUSE2FS_IOMAP_PASSTHROUGH),
+#endif
+#endif
+
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
@@ -6277,6 +6294,12 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	struct fuse2fs *ff = data;
 
 	switch (key) {
+#ifdef HAVE_FUSE_IOMAP
+	case FUSE2FS_IOMAP_PASSTHROUGH:
+		ff->iomap_passthrough_options = 1;
+		/* pass through to libfuse */
+		return 1;
+#endif
 	case FUSE2FS_DIRSYNC:
 		ff->dirsync = 1;
 		/* pass through to libfuse */


