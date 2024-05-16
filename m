Return-Path: <linux-fsdevel+bounces-19610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0B8C7CE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728C1285454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179715B979;
	Thu, 16 May 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="QJwMHFy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969D15B0E0;
	Thu, 16 May 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886317; cv=none; b=Loz+Z0Wjjca0YpnRMgDaITDKVVVv+3f8UgJ/EZtAsDhajjcIzexReQRhrHBNdSr7PqKAH9R4qZSlN0Ani4OWshcowiLnNQ5lMOIKm/fMqSo+TMfYk2mnzlGH2avBAuArtUHJnpJKgmboLcyaZRA2f4/dF49h4NZRyp/uB8F9RAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886317; c=relaxed/simple;
	bh=xtn+hR+P6AtQasd2NPiultmzHD+2r4okOEboO6xOKX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EiZecIh9/50TnMapbmazHaxznYKhC5p9mW6+JImULbAIxcS1h4wzqmMOuPbUutfqerUJi3S0WoeA8am20HMa3lr5WKGzXHSyBpddtjvp10el68C3E71xcYWNVCgaH4jDCUrcJpQk30LxNRiyZz2j8y0M79s75EYXzncE8Bhc+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=QJwMHFy0; arc=none smtp.client-ip=173.38.203.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2646; q=dns/txt; s=iport;
  t=1715886315; x=1717095915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eUbj65dbFM2s2DOl9iZSyGQu1oPu0UEugwjSxAQmAg8=;
  b=QJwMHFy03a+TIFgaJ96fKH3lZTvieLnf4VI5QB6T+Qi22J1LkZPHjAAm
   H0uXKZD4ZuQF/Ub5b5iwYDJ8WES1pOVGHZ3Cy2epvLFdFYtafOfBISu6d
   05O/HieSCXGicf8x2AVeerDH5+T7198ONCZnZume3M8SHMk7wrq8nq87+
   Q=;
X-CSE-ConnectionGUID: Pc4fKmp5QsiZIb2FD6WG/g==
X-CSE-MsgGUID: XN6AYbzsQ8GBJglZ3GZLDQ==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12237923"
Received: from aer-iport-nat.cisco.com (HELO aer-core-8.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:02 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-8.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ41l7042434
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:02 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 04/22] rust: Kbuild: enable `hex`
Date: Thu, 16 May 2024 22:03:27 +0300
Message-Id: <20240516190345.957477-5-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-8.cisco.com

With all the new files in place from the hex crate, this patch
adds support for them in the build system.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/Makefile          | 24 ++++++++++++++++++++----
 scripts/Makefile.build |  2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index ca86abac4ed0..fef8e38fbebd 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,7 +15,7 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
+obj-$(CONFIG_RUST) += alloc.o bindings.o hex.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
     exports_kernel_generated.h
 
@@ -65,6 +65,15 @@ alloc-cfgs = \
     --cfg no_rc \
     --cfg no_sync
 
+hex-skip_flags := \
+    --edition=2021 \
+    -Drust_2018_idioms \
+    -Dunreachable_pub
+
+hex-flags := \
+    --edition=2018 \
+    -Amissing_docs
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -455,10 +464,17 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_dep,rustc_library)
 
+$(obj)/hex.o: private skip_clippy = 1
+$(obj)/hex.o: private skip_flags = $(hex-skip_flags)
+$(obj)/hex.o: private rustc_target_flags = $(hex-flags)
+$(obj)/hex.o: $(src)/hex/lib.rs $(obj)/compiler_builtins.o FORCE
+	$(call if_changed_dep,rustc_library)
+
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
-    --extern build_error --extern macros --extern bindings --extern uapi
+    --extern build_error --extern macros --extern bindings --extern uapi \
+    --extern hex
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
-    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
-	+$(call if_changed_dep,rustc_library)
+    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o $(obj)/hex.o FORCE
+	$(call if_changed_dep,rustc_library)
 
 endif # CONFIG_RUST
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 367cfeea74c5..2e9a64224c51 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -273,7 +273,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	--extern alloc --extern kernel \
+	--extern alloc --extern kernel --extern hex \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \
-- 
2.34.1


