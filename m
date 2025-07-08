Return-Path: <linux-fsdevel+bounces-54248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15107AFCC7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10D21AA72E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A92DECC9;
	Tue,  8 Jul 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ja2wnp8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76731E5B91;
	Tue,  8 Jul 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982701; cv=none; b=ZwgzvoiI59Cn6rxIiY6lxkBZ1VMPNJe6SwiaYXSAM0ithos/e8/w3y4oFlp+/PVAPMGpwD4ToKd4ExBOXEntLuYAaLjD7ppYBsTnEu7OwFuuoJDCldNZ5Cu4Fxd7BhFJ54IVoV+8XL5W7DCdvkhnN1/rdv1BsFXvgS82v28dW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982701; c=relaxed/simple;
	bh=vRVwe+wyVVmpMBdaGKLnojm2f5vw9O/vhN2plUY89SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2vr8ibPY1XdPezB4l7E7pSlJfng4HJjBoUUkQUUY4mH8hJVsFUBkfBREg97h4tFGPn7Hh8vywbK3sJMo3gGsz8vrpCcdwoJ5fT4EWGp//sJmWJwnUhc9wzeeyMkG5iy9OQ9iE++zCAhzRez3ReH25yWEOMworqukaHhKUU5pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ja2wnp8d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WKldzz430gTFKSZO+AyahV4GsHYxQrxGZFDVs8bHe7I=; b=Ja2wnp8dAkymIY0Awo7QsfxNOI
	eE6ZlxUNzAvn0UU/XLgs8DJN2wsyPCl1IUHFm5ZK3iqovGKWd3gK0svGk7/A7zuEOxwA6eReAvm6v
	c4851d2s0JoAQkB1OkZWXsbQqS2fng826MPi781vrN3/Vp+u5wp0Oz7mac9TlYHv5fbClN6ickv2f
	9pZbv1m00z6CGBuPVywpd9a2i3aShoOGlTlsyp9VPu5tgmGa73ePQP99iMtyVRR9ocK468Rhv5yhH
	O2R8Oc1D/zJQoEnzP8UsUDeiHhMJwlz6cxvOyv39v59HwNdc2Qjsis2haHpp66vXdj2o2Osjk1pNG
	ZrLD3Giw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8jT-00000005UNd-0VBw;
	Tue, 08 Jul 2025 13:51:39 +0000
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
Date: Tue,  8 Jul 2025 15:51:07 +0200
Message-ID: <20250708135132.3347932-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
References: <20250708135132.3347932-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 10 ----------
 fs/iomap/direct-io.c   |  5 -----
 fs/iomap/fiemap.c      |  3 ---
 fs/iomap/iter.c        |  1 -
 fs/iomap/seek.c        |  4 ----
 fs/iomap/swapfile.c    |  3 ---
 fs/iomap/trace.c       |  1 -
 7 files changed, 27 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..addf6ed13061 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -3,18 +3,8 @@
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
-#include <linux/writeback.h>
-#include <linux/swap.h>
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


