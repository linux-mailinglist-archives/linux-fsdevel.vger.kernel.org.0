Return-Path: <linux-fsdevel+bounces-74530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395ED3B8BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482CA3045CF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6A2F6900;
	Mon, 19 Jan 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7qlIuyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFD25F99F;
	Mon, 19 Jan 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855319; cv=none; b=o5faULc3inyuC5grTt01RRsPg83XFZzE/83PqgWi7Pl8E6k+h/Qz2EDJ0ZXJyd860K5QrbVh7dA2qPjBWw65TO+uXDRZuriGGbAMjrD1bPrnHd1Lllq6r8NXHCzh1ViC8Ud+gfeKHf/oKVRtN1HfS/HtpEJ8SGkZmxZYMEfuPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855319; c=relaxed/simple;
	bh=PJCIfWAyuh7QU/YAEQSlOGHLmxFYeLDUZEQ6qsw87S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvRfi/7bMii6lJ0jbxS0nZ8P7I8Ng042HvKvw0hRacKCyoFIUsWB4chuO8EZ2kZo8RTaqnlqxMKex9cgdPGI+rNq1ufrJz8ihyns6OQHAIe8AKhC9x5Ffsyn1Cj/qG9xq6OD2aJ60EybPQUSO9w0P8ntUBZfs0bCKX3MgpxlHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7qlIuyN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768855319; x=1800391319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PJCIfWAyuh7QU/YAEQSlOGHLmxFYeLDUZEQ6qsw87S4=;
  b=V7qlIuyNKx2guNcIrkK8TC7NnH0xg8L+yHWTDV7pCziv4kZx2WreSMof
   eGuae3dxOfVqFHwU64WSZwocXiKNr2D5c8unOWBonQopxPaMocmd72ykv
   YAozqOnBQLoNp4wxcy4akTMO2GFka79UhtDMpd//3zkQ+QCLQc8M/K94I
   fflAjgwed5c82aBy9jOWuDJOMcqrN9zhiPaeVP7eIOxgWKqDgFyjzilEW
   VZ+kUz9Jp59m6yv27g8sJFmmsdjCMkR1wIVEZ46R+Z8GrivRwqPf7O7hc
   CjfdoQ+0dZvpXAHCRYJ6MxvzGV0Inmk89nD0UZc5NLeDWKQdBUokZ+QhH
   Q==;
X-CSE-ConnectionGUID: 7XNK9R3/Tp2MiYj1Tl5Ang==
X-CSE-MsgGUID: FPPY3ThgTwa7lSfEr+uBUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70230304"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70230304"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:41:58 -0800
X-CSE-ConnectionGUID: y+8UocVQSAyIXV2lp98gWw==
X-CSE-MsgGUID: NqEU22gRQeKnGPxCgNYgBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="236620586"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 19 Jan 2026 12:41:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 28DB498; Mon, 19 Jan 2026 21:41:54 +0100 (CET)
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
Subject: [PATCH v1 0/4] initramfs: get rid of custom hex2bin()
Date: Mon, 19 Jan 2026 21:38:37 +0100
Message-ID: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series that introduced simple_strntoul() had passed into kernel
without proper review and hence reinvented a wheel that's not needed.
Here is the refactoring to show that. This is assumed to go via PRINTK
tree.

I have tested this on x86, but I believe the same result will be
on big-endian CPUs (I deduced that from how strtox() works).

Andy Shevchenko (4):
  initramfs: Sort headers alphabetically
  initramfs: Refactor to use hex2bin() instead of custom approach
  vsprintf: Revert "add simple_strntoul"
  kstrtox: Drop extern keyword in the simple_strtox() declarations

 include/linux/kstrtox.h |  9 +++----
 init/initramfs.c        | 60 ++++++++++++++++++++++-------------------
 lib/vsprintf.c          |  7 -----
 3 files changed, 36 insertions(+), 40 deletions(-)

-- 
2.50.1


