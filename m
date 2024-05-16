Return-Path: <linux-fsdevel+bounces-19600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDD88C7CCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A71C2106D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594A1581EA;
	Thu, 16 May 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Gl/ORZvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E4156F53;
	Thu, 16 May 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886264; cv=none; b=byYUHRtSoD8dkST+4SaXhdjazZY5WogJGt622yh/5EBPR5AhV/tjm7sH3270zox35G4ejfX5tlWEakneLOBJiOFRLlDlTO4GVsIchM3XTAEHRNvHpoSe/0q3lZxcxuji+DQOGLedZGq0h7Uz4qDO6pcAIOrG0+M3V4f9iTRnevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886264; c=relaxed/simple;
	bh=3nnpWWKMStpUeM3Ik6Rv784yA2JQMowYJQgZdZU31uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1NAI6NZKEUkqOKILqsk5IbJgT7JzDXVD9r8B8ilntgmkT464OLPiUQkMCw7KBeieJHhP9U8ZnoN4OCDi6JQk7g6YqwHLUPnrIui5jE30emQw0wb2zC1E/6oaaRqSXFx3PJlr19O8iHFYVc+kyLvlG/UviT1vc6LB/SrhowcBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Gl/ORZvq; arc=none smtp.client-ip=173.38.203.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=894; q=dns/txt; s=iport;
  t=1715886262; x=1717095862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L5yDgP+cxPTKmz+g24R6+/RadbYoww9Xk7B9o4e4exM=;
  b=Gl/ORZvqSstJ5aoCzJZG6jHLTVA7+35XPz7DlWoVkYHRA5+pwPIuFebK
   4JfSCsaqiygbHLIPs2vdEWeL1TPcC0JVphcjkdCVr4BVnq8HPU/U164V1
   F3nu1c4NZvJ970MeDaAyg3qUFYqp44luU3hAazkFAWw62M//HDNjZ1sjF
   8=;
X-CSE-ConnectionGUID: 3gwLQrPxT+2Tcptk91gRkA==
X-CSE-MsgGUID: L99Lj4d9T0GlqFWcxSX9fw==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12416990"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:21 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4KvF030203
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:21 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 16/22] scripts: add fs directory to rust-analyzer
Date: Thu, 16 May 2024 22:03:39 +0300
Message-Id: <20240516190345.957477-17-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-1.cisco.com

This enables the Rust code navigation features inside fs/, where
PuzzleFS resides.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index f270c7b0cf34..6985b9e37429 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -116,7 +116,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers", "fs"))
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:
-- 
2.34.1


