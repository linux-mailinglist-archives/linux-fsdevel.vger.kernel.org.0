Return-Path: <linux-fsdevel+bounces-58442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98659B2E9C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67CEF4E1351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D01E5B64;
	Thu, 21 Aug 2025 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv+7ZSiI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D959C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737566; cv=none; b=tlAbKbd26uyK/bFY5rgZvC+Xe1fppE/JJnsJHb/fue9FZXRGvwf0ZfCli8IFG1Al5tunUd9KUjg7T+PZxPG+sa1aPr6pS4nk41WTeDeF6e4kI6GxiO6gJZzwvLhAYh3WWas/37Hp4gEbd8sw+nG+h/IiN0eOlIG1LSNr6RKHZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737566; c=relaxed/simple;
	bh=8ecwQPvgBRaFNHbdhfDCfr/1RYcSTY4JFThsVP9RlQQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxGzdea5CRESz82GhhE/8LWWWxlw35ZLRU7TOUGHBfhkAfLVAXbnU024uThKFOWYz7ydreEtOGj5M3Wmf9hCuqX7F0guzp5EaNudodzW20+ISoACnKTAOHPiPadtxz1X21/27VCiV0JR1NguMhOsxPANim9vBR8tPe935yUAXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv+7ZSiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C86AC4CEE7;
	Thu, 21 Aug 2025 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737566;
	bh=8ecwQPvgBRaFNHbdhfDCfr/1RYcSTY4JFThsVP9RlQQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Rv+7ZSiIW77ALoEFucIswVJdWs381LuyI37O9/1tOazQGo8HrI6YFoLHLe8+UPLdu
	 DEtxAwDQD06MCK/GgkTeNtwLLSx+xc/GRyIv60ICpzGALvrzamSXpmuzh/uoaj9Bi2
	 N85pDVfNsRwPWB7AJNLEx8/Pdd5g5464nttivLjsBIl0tGeYL3nDrwsbDXvBF8fZK5
	 pUHH9lc1KieOkFeeuhBlD7wyVjisOCZwYPfKffCkVhlWQHIlsh1XB+yR54VD5lNicV
	 mxJJrYOyr4p9KkQe2EroLRORdwBs9E1Zdn0GBxIYnDG5uoFxbVGh2avjY6n4iVQ1V0
	 DrOfoGrbgVxog==
Date: Wed, 20 Aug 2025 17:52:45 -0700
Subject: [PATCH 01/23] fuse: move CREATE_TRACE_POINTS to a separate file
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709136.17510.9802949445425558710.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Before we start adding new tracepoints for fuse+iomap, move the
tracepoint creation itself to a separate source file so that we don't
have to start pulling iomap dependencies into dev.c just for the iomap
structures.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/Makefile |    3 ++-
 fs/fuse/dev.c    |    1 -
 fs/fuse/trace.c  |   13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/trace.c


diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3f0f312a31c1cc..f3a273131a6cd1 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
-fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
+fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 05d6e7779387a4..dbde17fff0cda9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -26,7 +26,6 @@
 #include <linux/seq_file.h>
 #include <linux/nmi.h>
 
-#define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
new file mode 100644
index 00000000000000..93bd72efc98cd0
--- /dev/null
+++ b/fs/fuse/trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "dev_uring_i.h"
+#include "fuse_i.h"
+#include "fuse_dev_i.h"
+
+#include <linux/pagemap.h>
+
+#define CREATE_TRACE_POINTS
+#include "fuse_trace.h"


