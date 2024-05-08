Return-Path: <linux-fsdevel+bounces-19103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B88C00D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979A2B23572
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26828126F3A;
	Wed,  8 May 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtTlwpb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FB8562E;
	Wed,  8 May 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181696; cv=none; b=J2JQNDtfBjWon47aWNkM5QIJtwRB6vLBWhnYeC9ff+mj7XGdvP+thnwLAVZ0dlfx13xW6iMzNZaIfqCgODf5Pqy/y5T7NhtqwLHmfbUdsi/2MZmxvHH3f7wMYgrk1hfKOzyPHt6CcwEQGHfOvrv2rSlKE+ef1e10yOsqqaNc4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181696; c=relaxed/simple;
	bh=wYODmWptbOs8YBeJCa9/Nlhstjn+sSRJZBZLNRuuUW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+1BXom9V01NEAXLM4iukPdIUdYGfiP49K1IUT8zPa2REw/NtJdoEv+Q6cYnTXmGJv7WQYNimmiPGbfxPmyMGZnYL64ZWzDx6rQhS7Pm3pouehgDgFNR0VXXPewIWPpLvDuTzF/c08EHKeTwC9VQP4WTcmfbAVoP12kf+AX16fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtTlwpb3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715181695; x=1746717695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wYODmWptbOs8YBeJCa9/Nlhstjn+sSRJZBZLNRuuUW8=;
  b=HtTlwpb311MgeRgSqJ0UFJeMC0izE7SAqZ2yZiodbKq06pHXfqjpYoNJ
   4ityX6E8ivy1WGOlSk4OsAUsXfcmOawxFDvBS0wL+STJsLr/Cxy3BjOPV
   iHJQUzGj084XnoW8LWmJ9tbXC3wP3CbIatYw9J7yZmfQLE9XVgewJZWDP
   ya7c2js6UdOSimd4eHXFY03fW9hl55tEqx4ex3VKXX7BKOC7vYJzpziz/
   bUr3TpQTCNqSG677CTB5b5E1D+esuT39B0fVV76hR2hsuipmVBWhXfz1I
   S4n3VaYEXFgcXHbLOsenauevsfI84MUY0JxyQCBZ4AoY2McJaF/H/zXEx
   w==;
X-CSE-ConnectionGUID: UxovCE/vT+im8QaIy2TUKQ==
X-CSE-MsgGUID: ryqL6BKARoKFP/hgSPRQXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11210968"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11210968"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:21:34 -0700
X-CSE-ConnectionGUID: 1XCXLO1TR++Bj7LD5HJU+A==
X-CSE-MsgGUID: YTt6qQwBRdqNHdyO8DUC8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="66349865"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 08 May 2024 08:21:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BF5F1109; Wed, 08 May 2024 18:21:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH v1 1/1] isofs: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 18:21:11 +0300
Message-ID: <20240508152129.1445372-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Note, the original approach is weirdest from the existing.
Only a few drivers use this (-objs-y) one most likely by mistake.

 fs/isofs/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/Makefile b/fs/isofs/Makefile
index 6498fd2b0f60..b25bc542a22b 100644
--- a/fs/isofs/Makefile
+++ b/fs/isofs/Makefile
@@ -5,7 +5,6 @@
 
 obj-$(CONFIG_ISO9660_FS) += isofs.o
 
-isofs-objs-y 			:= namei.o inode.o dir.o util.o rock.o export.o
-isofs-objs-$(CONFIG_JOLIET)	+= joliet.o
-isofs-objs-$(CONFIG_ZISOFS)	+= compress.o
-isofs-objs			:= $(isofs-objs-y)
+isofs-y 		:= namei.o inode.o dir.o util.o rock.o export.o
+isofs-$(CONFIG_JOLIET)	+= joliet.o
+isofs-$(CONFIG_ZISOFS)	+= compress.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


