Return-Path: <linux-fsdevel+bounces-61428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9250B58172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C530E2041C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874423D297;
	Mon, 15 Sep 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ur/PuRRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC61D5CC7;
	Mon, 15 Sep 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952156; cv=none; b=JUxzGEC8JNqWvNM6kepjBazrcaX+iw4Pn4EJse5EZuIuerPBFKUEySxPmvSKhX+YhFgoXaZUSCs5KyJDxPRX2VQCKAD0KnQjLzR7Z7PBSlPucvivpJTWOhJI+aDpWsAaVujy4E3LH1YzPpgOb7ajQkyzanIGzzRPVJvnTY2IfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952156; c=relaxed/simple;
	bh=KrdcTcOmvrTnZXWtRS2/iVJmA+q1zLW/5mkZAZj3qVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gf+DGw9vZ4Mh3TMR31poSPcceJ0ycnE0HEdC5fckccT/QKRuedLb4YUlFgqj6lohYEAEJ0G5jqu2OuCHUkjmcx9WNPm1PuUrrCcpf/bxnlzjJDtrDWqKYxi2JfgDfxzc2Uu+WcL0pu7L9G/3nn6ZR4JpscD10qmQps5afQfuABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ur/PuRRN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757952150; x=1789488150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KrdcTcOmvrTnZXWtRS2/iVJmA+q1zLW/5mkZAZj3qVg=;
  b=Ur/PuRRNpLmjPGEuXGhGXClFAceaEgf1k3EP6i6jp6jfLM3LOGbwNHf6
   xWuAv5Tu7Awd5RfSrIn+MTlvDeKhNvqZsX//iIlOkzfmM/G/Os/43/O3X
   p2rdPJ9L1X71ycUt431GiGE4xCEtLZxAL4f8KgkiPKUtEElPIu8iI+Nc3
   Gz/9P4Vno31g6SEaQsLqhWHYv11gh1DMOANGgHBAcJ0aKillYNqR+ArTe
   2hQBcAxzgl9fWPcKU9I3+4DpcpyrpXrcuX6qRWiMZGdICRa3jCjTK+khy
   PXnc12de8te8eHHiExFjFCaJVLG7AMU2MKWXEb8X3pRUp4PcfIge2nrrT
   w==;
X-CSE-ConnectionGUID: ACRRAeb7R0aaS/YLX+Nnkg==
X-CSE-MsgGUID: ZdFjC9QCTLO07TH1TrK0AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70462407"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="70462407"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:02:29 -0700
X-CSE-ConnectionGUID: PY5zR71HRaehcY/K9csPBg==
X-CSE-MsgGUID: s6tF1+90Q9SB6KinGRyPQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="178666903"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 15 Sep 2025 09:02:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 45F2A94; Mon, 15 Sep 2025 18:02:25 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] lock_mount(): Remove unused function
Date: Mon, 15 Sep 2025 18:02:21 +0200
Message-ID: <20250915160221.2916038-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang is not happy about unused function:

/fs/namespace.c:2856:20: error: unused function 'lock_mount' [-Werror,-Wunused-function]
 2856 | static inline void lock_mount(const struct path *path,
      |                    ^~~~~~~~~~
1 error generated.

Fix the compilation breakage (`make W=1` build) by removing unused function.

Fixes: d14b32629541 ("change calling conventions for lock_mount() et.al.")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/namespace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 14924dd3a21b..ebd61d903a59 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2853,12 +2853,6 @@ static void do_lock_mount(const struct path *path,
 	} while (err == -EAGAIN);
 }
 
-static inline void lock_mount(const struct path *path,
-			      struct pinned_mountpoint *m)
-{
-	do_lock_mount(path, m, false);
-}
-
 static void __unlock_mount(struct pinned_mountpoint *m)
 {
 	inode_unlock(m->mp->m_dentry->d_inode);
-- 
2.50.1


