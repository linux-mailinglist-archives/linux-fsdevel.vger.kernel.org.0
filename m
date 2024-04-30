Return-Path: <linux-fsdevel+bounces-18227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16BC8B6874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6E284248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F517589;
	Tue, 30 Apr 2024 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ90b7qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E38168A9;
	Tue, 30 Apr 2024 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447416; cv=none; b=W4oN7BKXe9p8UMLuZfdJK/yVTGq6Mhu/UlsKEmkUz6NaBQZxHHgr2jasefsARl0Fwx9MuFagWYFRvkit411hYHmn8MxSnBc4Be8EsDiDuqkuCz59Fu/6XtmZ6vWOSS0XosMG+Nbk8lI+tL3mj1jTEt4wbyGtyyEOuNmwg01nbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447416; c=relaxed/simple;
	bh=+qKViSXR8MymxT3CGYQ2JI55vVyjx+Hwgld6ysDP5pc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtq1iiWsdoliHzgVEqzXDIxIg+dK+9sip6vpo+cpMHcNl7mAt9q5PcmWeqxw0GDwyjclV7nJ7c4Q1c/VInyL6FTSTTsDF0OmwTS+3nc4c7vkHrR1nRNKXyXUHD3qVP+SL7HheXcavEfHgsSCJ+jRAsNF5lzy+n52AdbnTZwPNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ90b7qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D20C4AF14;
	Tue, 30 Apr 2024 03:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447415;
	bh=+qKViSXR8MymxT3CGYQ2JI55vVyjx+Hwgld6ysDP5pc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VQ90b7qjAUfbA11+FU/LMTsszGajAHxZ0xWbdCY19/z732nZuAYDXu0UkUTRSufsJ
	 TqxQE72l9OU9VMsFGt2Ypze4BYjrhM/Lm/i/jnDkUhlRspJDzs1ab42NsM67q0dJH7
	 A22odb0bxWGDso9Ijwj0RJJ08sBlMxfKUNLF6WPVceK2yfVl4P+rjWYT356kiiQrQr
	 rtY2YG/e6+RK7MkfGC/ZaFnXVqCYJpMze96FIEodvX4mHHAP5a9/LRF+myYMVk7bBa
	 PhKqNsR8FzCQXeV1Q2aO75nLm8Pr+x11A9aKR1X8Vo+9txxK8xrd7J1TfL+CucMH64
	 xhw2VUktvPcbQ==
Date: Mon, 29 Apr 2024 20:23:35 -0700
Subject: [PATCH 16/18] btrfs: use a per-superblock fsverity workqueue
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679858.955480.1250714507271465464.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Switch btrfs to use a per-sb fsverity workqueue instead of a systemwide
workqueue.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/super.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)


diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e44ccaf348f2..937f0491c01e5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,6 +28,7 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -924,6 +925,19 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_export_op = &btrfs_export_ops;
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &btrfs_verityops;
+	/*
+	 * Use a high-priority workqueue to prioritize verification work, which
+	 * blocks reads from completing, over regular application tasks.
+	 *
+	 * For performance reasons, don't use an unbound workqueue.  Using an
+	 * unbound workqueue for crypto operations causes excessive scheduler
+	 * latency on ARM64.
+	 */
+	err = fsverity_init_wq(sb, WQ_HIGHPRI, num_online_cpus());
+	if (err) {
+		btrfs_err(fs_info, "fsverity_init_wq failed");
+		return err;
+	}
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;


