Return-Path: <linux-fsdevel+bounces-74533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B058AD3B8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E38DC3022812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAA2FB616;
	Mon, 19 Jan 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3tohigi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AD2F28EF;
	Mon, 19 Jan 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855321; cv=none; b=E5OPCRVKuojIH/0QxLn4uLytHb/BUOC68WcvZdOdmbmtfE41ssfHi3/0ojGgQIUwM+oGf6cp/sJ84CM9ENyxtyUQQlh9XhCoWGciDVIHnRLrvZ9yKb5Q8RR06NEHGJWV4ltlaO+8Mzgj8XRnNjTIedB7U5GdPGawjwyerpWxLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855321; c=relaxed/simple;
	bh=VUhri3d7VyauDsHJzIbJLk+19FEXBT199psKUOzW3cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMldFRnBf8ume286lxicct+YuGZb9SaolFTKnxdX65UMNvKQfsPN/KwQCO1bybDnWAHiCIMDab+ZKkLEXqg19/tm0JkrFQsIY8yg6Y2vPVkbADoob/YmEdxP7uVz/MhXY1cj5C77XxwnmjgRNHyKuXYEQ2TTyjtCJBjTQibjmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3tohigi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768855321; x=1800391321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUhri3d7VyauDsHJzIbJLk+19FEXBT199psKUOzW3cI=;
  b=m3tohigiBFQVfCxJnaRB12Jhjlpk4j3mrT4WFauohQmDhOBxmZqkK6MB
   gopo8WCc8/UF2RMtwLxlgv3Gnw24X9hG1dMa9PZCIT5L7IfF5V6d+EX9s
   4GEc1zM32ktxM3KuQY3weaCOqCt0UUpdms/9fFcca+2lpygksypJYlTED
   WvOVX396nyb4Y/Z452pMW5K9KNi6F4ztBKaz+XHjHVE3Vbu+rvAWn+p8P
   yaw8X8r/xKEXCIX2YoFwj+iEzdevumsuqAfE4V+mOqLD006vn6ptQdaP/
   OjcqG1t9YoeNumlWJt5H5ZGXYmFWQ/DRcs76CjVkUgiQ1lqFVMLJlRZJO
   A==;
X-CSE-ConnectionGUID: KvwBKGbiTmeMRmmyE14qZA==
X-CSE-MsgGUID: ZsGlXU00Sm+vsFNLiIBMog==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73695310"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73695310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:41:59 -0800
X-CSE-ConnectionGUID: HXrRidrqRPqbAUxLLH27HA==
X-CSE-MsgGUID: FKpgtP8JQUOt3UH89k2mWA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jan 2026 12:41:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 39A479E; Mon, 19 Jan 2026 21:41:54 +0100 (CET)
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
Subject: [PATCH v1 4/4] kstrtox: Drop extern keyword in the simple_strtox() declarations
Date: Mon, 19 Jan 2026 21:38:41 +0100
Message-ID: <20260119204151.1447503-5-andriy.shevchenko@linux.intel.com>
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

There is legacy 'extern' keyword for the exported simple_strtox()
function which are the artefact that can be removed. So drop it.

While at it, tweak the declaration to provide parameter names.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kstrtox.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de..6c9282866770 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -142,9 +142,9 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  * Keep in mind above caveat.
  */
 
-extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern long simple_strtol(const char *,char **,unsigned int);
-extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
+unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base);
+long simple_strtol(const char *cp, char **endp, unsigned int base);
+unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
+long long simple_strtoll(const char *cp, char **endp, unsigned int base);
 
 #endif	/* _LINUX_KSTRTOX_H */
-- 
2.50.1


