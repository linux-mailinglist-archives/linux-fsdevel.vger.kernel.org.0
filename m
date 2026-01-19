Return-Path: <linux-fsdevel+bounces-74532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22638D3B8BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8323089FD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90C2F9D9A;
	Mon, 19 Jan 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbRz+9D9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C142DB7AF;
	Mon, 19 Jan 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855321; cv=none; b=hfRaq4RP+hhKQCbEx1whTZuYOS6lMw4bUWRHVmYzQyFwn5gvcMfE6MM7lbVUbX34WN2SUEtCVZ+A4Y8sAG/3qCjXWrKI+ErFuG5t/X+ITvrAm2X4a0duZ5hPm20aL4HpBSxORP9xNBlKF0OUrJPp5dLfEDVUOMP8MvQ6LUwQotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855321; c=relaxed/simple;
	bh=wK7kwTXUEiZv21y6ZXZQd3Cigz4S8TqeTbOgdka3mGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdkUy6rMJ1+W2m309uBTmBrSu8+8OD0EufCGpmay0+wTtccMeHL3X1AStWSbQzUdsumRTFje0D7YssJegCRfsENE5/dgwgM8QibDZ8TxyYFky8a6QqsxsxCO/m7PCQy1bHfC+7Qsql53K6/H9oCR9b4clesr7kG16bxb9Nnykp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbRz+9D9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768855321; x=1800391321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wK7kwTXUEiZv21y6ZXZQd3Cigz4S8TqeTbOgdka3mGA=;
  b=GbRz+9D9XH4IQZkbhcEMdJxgoE5IuPK0DJS6SXhg0DoyBcoCq2H+3oXm
   l0jx/CqCGX/6XBIN/+buxTf1DDjUN1vUK3vi14SIslBnJMTYUgCkt3pLx
   le/RAMpy5/FclxfsWLZu988dCaS3SiV3EE9RscjGkd15LgSP28FN3vHBh
   Vj3d+03DVtPHkIimKOC39GV7KW3mXqCjlFy+FJE+V14laN4imXl+csCng
   SZX6yQqJBobf8u/ot3Z0nH44diXcVZNDbPvhr2rRb21mv8oyVzPGmbpg3
   ni5C4MxuDAsMu3wVeaRDo0PYhraexPF4bRyztekerzjUGRYqcG5OhWavr
   g==;
X-CSE-ConnectionGUID: 8oizC8QgQ3G2S4kP0ucUfw==
X-CSE-MsgGUID: 7RiOtHCeTqKU4CeKDL4spQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70230318"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70230318"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:41:58 -0800
X-CSE-ConnectionGUID: IWnn+rC8TMaLjZVkYQI8dA==
X-CSE-MsgGUID: TnWgMIr1QU6BhkTBkwIUwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="236620588"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 19 Jan 2026 12:41:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2CA2099; Mon, 19 Jan 2026 21:41:54 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v1 1/4] initramfs: Sort headers alphabetically
Date: Mon, 19 Jan 2026 21:38:38 +0100
Message-ID: <20260119204151.1447503-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6ddbfb17fb8f..750f126e19a0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,25 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
 #include <linux/async.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
 #include <linux/delay.h>
-#include <linux/string.h>
 #include <linux/dirent.h>
-#include <linux/syscalls.h>
-#include <linux/utime.h>
+#include <linux/export.h>
+#include <linux/fcntl.h>
 #include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
-#include <linux/init_syscalls.h>
-#include <linux/umh.h>
-#include <linux/security.h>
 #include <linux/overflow.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/umh.h>
+#include <linux/utime.h>
 
 #include "do_mounts.h"
 #include "initramfs_internal.h"
-- 
2.50.1


