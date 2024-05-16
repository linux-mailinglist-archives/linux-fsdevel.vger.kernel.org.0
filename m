Return-Path: <linux-fsdevel+bounces-19609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A98C7CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1811C21536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8215B103;
	Thu, 16 May 2024 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Q98/3hMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8C1581FF;
	Thu, 16 May 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886314; cv=none; b=JOMLicT4oHvbJ0MO+xI55N7XZlTTO2XOcQAMwvkhPwO8zbRZPzT1MSqqZcn5dkVo3wAHYHDdMBupNB4iOyEVR3utnqECyALgu4D38AjjTTBgxobx2cu46YAH1AtaAA6UzCzmiBfeNatmDiSmb8sHvxUQCpwK+t1LgdvjZShYmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886314; c=relaxed/simple;
	bh=JLavhVFc09FEg9EY6gMPlypJaSPpAewW2C1Acr5xDKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EflXRPzJ5xn2hfl9U92jk3OhYDe8ejbQ/3pGhXLjOWqLlMGASRMyLXR6RnqBwkMlzBT7HdDWX0QIij+Beso7bfTetIIeTsNWVsmuJntE2n3NUOZUwZS1QFGjPM3w+s1TDew9xtxYYjmVGCY+4r+7cZonMTvLIOzwFS+F7h5jelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Q98/3hMV; arc=none smtp.client-ip=173.38.203.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1236; q=dns/txt; s=iport;
  t=1715886312; x=1717095912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+y082Y8KjvrVBkn/4Dxr8IGelz4ZU6IVUPo0Qa5ojw=;
  b=Q98/3hMV/0EKTxd++4RCdqVjH+x2Bfg3w+bjhox28KFaCGMzhr+v2omK
   yg569fPgcI1veznH48oP+Ane/ydXqnJyLDZENnc07m6uYM9h89TgnEoK5
   XTXL8qmvERXD+HAdOjkpvv7VXwg7V3+c7mimQeqPlBDPD3qE+HyYwWMIZ
   E=;
X-CSE-ConnectionGUID: O0HGUG50T4C2oJrIvng/bQ==
X-CSE-MsgGUID: xtzBqNHyRSisowtvoRep0w==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="9839846"
Received: from aer-iport-nat.cisco.com (HELO aer-core-3.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:01 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-3.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ40nr017864
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:01 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 03/22] rust: hex: add SPDX license identifiers
Date: Thu, 16 May 2024 22:03:26 +0300
Message-Id: <20240516190345.957477-4-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-3.cisco.com

Add the SPDX license identifiers, since the initial patch added the
upstream sources with no modifications whatsoever.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/hex/error.rs | 2 ++
 rust/hex/lib.rs   | 2 ++
 rust/hex/serde.rs | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/rust/hex/error.rs b/rust/hex/error.rs
index ff7a3b5c16bd..e553a046c9ed 100644
--- a/rust/hex/error.rs
+++ b/rust/hex/error.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use core::fmt;
 
 /// The error type for decoding a hex string into `Vec<u8>` or `[u8; N]`.
diff --git a/rust/hex/lib.rs b/rust/hex/lib.rs
index ec48961b9ffe..a23def3f80db 100644
--- a/rust/hex/lib.rs
+++ b/rust/hex/lib.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 // Copyright (c) 2013-2014 The Rust Project Developers.
 // Copyright (c) 2015-2020 The rust-hex Developers.
 //
diff --git a/rust/hex/serde.rs b/rust/hex/serde.rs
index 335a15132a27..40ab1edb2bc8 100644
--- a/rust/hex/serde.rs
+++ b/rust/hex/serde.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Hex encoding with `serde`.
 #[cfg_attr(
     all(feature = "alloc", feature = "serde"),
-- 
2.34.1


