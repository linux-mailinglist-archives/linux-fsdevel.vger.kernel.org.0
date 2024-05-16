Return-Path: <linux-fsdevel+bounces-19599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C898C7CC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC65A1F21EED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2588157A76;
	Thu, 16 May 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Y45+4JjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C5156F29;
	Thu, 16 May 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886263; cv=none; b=ngVcwjV8uUEcAvdUUzhP+kU2fvBgkvvoj/dOzaO+DsSssmgHf7RLlvP6fE+gljTtVpPySn3uaiFNGXdCF6yaaI6M4FF8zkKfw1i7sBHfryEyEsIaQcVwaRQ7u2xEcpFY89g4AZFiQs6PNwnAxbf50fnShvOukJ8FrDi2i3BHNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886263; c=relaxed/simple;
	bh=0lJ0FxB1P4rcK9zFSRBA5T+g6CrZ0Gf7SJqvtne45QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0YChVzG+7YlkB/RruhQ8P4zdQh/8NLtREtAVi72qcclgvJyF0DQxfJwiU+POYC1N1uKoNa9SjKdfu6M3egmyGjppE/rZpVTh+ZoTBff+fr49kHSjQWmeuhrGervMP+FUOHRHpvZpPH1E3VuAxR0Ko+TqoA96COFPOhMzXkuoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Y45+4JjE; arc=none smtp.client-ip=173.38.203.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=967; q=dns/txt; s=iport;
  t=1715886261; x=1717095861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RM2bpcKeFIOuwJsUXBWZw4CVFhC5QI3+qCCBvqPUBZo=;
  b=Y45+4JjEVPEgetC8nH5A6haMkizYINtaHu4gEwAurckM5okiDt6f9MGX
   4hSirA1iB/qHoK8jYHnArjafGhS2YfzS2/jNhdcMHaMUhJUYcJf2b9jy0
   VN0SHSofetW/JSq62Ycf6VFXjHDhFkSNn2hdeKmGh/+mXdEY1ytVaH8yp
   Q=;
X-CSE-ConnectionGUID: MAYFYa3ZSRKzGDsl4DkK+w==
X-CSE-MsgGUID: XZR3mbPyTBmG61iWLKTEaQ==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12379874"
Received: from aer-iport-nat.cisco.com (HELO aer-core-11.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:19 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4IDD020825
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:18 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 14/22] rust: kernel: add from_iter_fallible for Vec<T>
Date: Thu, 16 May 2024 22:03:37 +0300
Message-Id: <20240516190345.957477-15-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-11.cisco.com

This function takes an iterator and creates a new vector with its
elements. It is used in multiple places in the PuzzleFS code.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/kernel/alloc/vec_ext.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index 6ad0b6da45d3..cbc8b06183d7 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -132,6 +132,18 @@ fn resize(&mut self, new_len: usize, value: T, flags: Flags) -> Result<(), Alloc
     {
         self.resize_with(new_len, flags, || value.clone())
     }
+
+    /// See https://doc.rust-lang.org/std/vec/struct.Vec.html#examples-31
+    fn from_iter_fallible(
+        iter: impl Iterator<Item = T>,
+        flags: Flags,
+    ) -> Result<Vec<T>, AllocError> {
+        let mut vec = Vec::new();
+        for value in iter {
+            vec.push(value, flags)?;
+        }
+        Ok(vec)
+    }
 }
 
 impl<T> VecExt<T> for Vec<T> {
-- 
2.34.1


