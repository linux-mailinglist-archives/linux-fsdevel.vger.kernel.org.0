Return-Path: <linux-fsdevel+bounces-54499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEBFB00371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A425F1886C71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3BF25C81D;
	Thu, 10 Jul 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="egiZQ3Yh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5ED258CF6;
	Thu, 10 Jul 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154434; cv=none; b=pTCZ2Qn6k+dkqubD76A57C8gPd6wVP9T0wRQvApWTPw3Q/6uhSkX69Z1GXgwIpTp+70qwmIHhYfcLOwatF5d4BHTMttbijgEcJnL2KVJ1r0mWgcomEUDDG/WXQm2dWlVbrBkPOmm9PNjfx+1I9wjgdkyJX7/GeRCUdr6+Q/V3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154434; c=relaxed/simple;
	bh=q/wAtD7V+Of0qCimAE9DwLme1dmlXtY0Bo52C4zAqaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrbcvXDH7506TlnHJzcq+fCHhj8DTz0zeEhkss3N/km4AbfD/r6Qfm9JTA9iRXoomb9wWHc5XBbKPIgBmZA+WJbhNCXt3FsP5M0GHpr1c68z8UhaO/i+3amLFYJJj+l4bxP+h4tiEjDA/+JxME0l8gcjm4g7daCiZokNOjm0sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=egiZQ3Yh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ItqJDHqSjPJStLJ0ErKWXebS10aSzaXBGt94sT6886s=; b=egiZQ3Yhz+y4ktD6d7oEx1BRZu
	xd6IL2fDkZTa8M7RksAe9W0FUv5uOy1MdJ2jjHFICXOK6BotzRTn+C4OXUXhldkylNDowfyHxhroU
	OJzVkGB4FIvjH3a3FR8PS2FPjaSO1JTgJBJ+cPTI4Vr+O9+vPoCfZnGralYI0JclRa69ISG6S0XSu
	KbgxP0VJ83wHeQc5GpY98zTZ8XDD3BZVxsqCoOWdUY/Bz6z2K9qM8+kGo8c1ycsr8AMsWicQVH9OU
	IJrlGK8MW+N58RJEBONLGS0HS6Mk2kn4O8lO0U6c9pUIfOZbxFZxnrfW0NtkoxAF891UmmpnlEV68
	l8jYCUtg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPK-0000000BwR7-3OeO;
	Thu, 10 Jul 2025 13:33:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 01/14] iomap: header diet
Date: Thu, 10 Jul 2025 15:33:25 +0200
Message-ID: <20250710133343.399917-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drop various unused #include statements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 8 --------
 fs/iomap/direct-io.c   | 5 -----
 fs/iomap/fiemap.c      | 3 ---
 fs/iomap/iter.c        | 1 -
 fs/iomap/seek.c        | 4 ----
 fs/iomap/swapfile.c    | 3 ---
 fs/iomap/trace.c       | 1 -
 7 files changed, 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..bbd722365404 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -3,18 +3,10 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (C) 2016-2023 Christoph Hellwig.
  */
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/fs.h>
 #include <linux/iomap.h>
-#include <linux/pagemap.h>
-#include <linux/uio.h>
 #include <linux/buffer_head.h>
-#include <linux/dax.h>
 #include <linux/writeback.h>
 #include <linux/swap.h>
-#include <linux/bio.h>
-#include <linux/sched/signal.h>
 #include <linux/migrate.h>
 #include "internal.h"
 #include "trace.h"
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 844261a31156..6f25d4cfea9f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -3,14 +3,9 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (c) 2016-2025 Christoph Hellwig.
  */
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/fs.h>
 #include <linux/fscrypt.h>
 #include <linux/pagemap.h>
 #include <linux/iomap.h>
-#include <linux/backing-dev.h>
-#include <linux/uio.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 #include "trace.h"
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 80675c42e94e..d11dadff8286 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -2,9 +2,6 @@
 /*
  * Copyright (c) 2016-2021 Christoph Hellwig.
  */
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/fs.h>
 #include <linux/iomap.h>
 #include <linux/fiemap.h>
 #include <linux/pagemap.h>
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 6ffc6a7b9ba5..cef77ca0c20b 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (c) 2016-2021 Christoph Hellwig.
  */
-#include <linux/fs.h>
 #include <linux/iomap.h>
 #include "trace.h"
 
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 04d7919636c1..56db2dd4b10d 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -3,12 +3,8 @@
  * Copyright (C) 2017 Red Hat, Inc.
  * Copyright (c) 2018-2021 Christoph Hellwig.
  */
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/fs.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
-#include <linux/pagevec.h>
 
 static int iomap_seek_hole_iter(struct iomap_iter *iter,
 		loff_t *hole_pos)
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index c1a762c10ce4..0db77c449467 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -3,9 +3,6 @@
  * Copyright (C) 2018 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
  */
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/fs.h>
 #include <linux/iomap.h>
 #include <linux/swap.h>
 
diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
index 728d5443daf5..da217246b1a9 100644
--- a/fs/iomap/trace.c
+++ b/fs/iomap/trace.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2019 Christoph Hellwig
  */
 #include <linux/iomap.h>
-#include <linux/uio.h>
 
 /*
  * We include this last to have the helpers above available for the trace
-- 
2.47.2


