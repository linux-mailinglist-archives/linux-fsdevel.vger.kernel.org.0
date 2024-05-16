Return-Path: <linux-fsdevel+bounces-19615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABA8C7CEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBBB2413A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13F15E1ED;
	Thu, 16 May 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZQC7mWQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990415AAD3;
	Thu, 16 May 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886325; cv=none; b=Nk48Puo7SbYbLesfe2PUKDLbWpjpZKnjPDOEYu+KPvdhN9j78XWoOxQ79e5eiegXag68Zw2NmXvRXX5Tif6nnY429eIWpqdobOTzUsPVWpr61/PTt9AfLmRop/oIYyz4Em5koosQXqb50mH3SIFVcjTWwyB+IwKhhwhWffLyVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886325; c=relaxed/simple;
	bh=yLauolBXrHXd3uryAiWbWkiottax/Pz7IPpXWXka154=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qBLMgJQkv58dPJPjQdzMHrDcfKTDlkCTmVqtOYlLHX3rouJRD3GAs55b3yw376ov5zos1kNa2o3LTd9eRGyeOPeFgY9pB4cwoxZ4ITnqsotxEsoerwXahVNIJuCLpqWtctVCGFvL0yNr0UXtl1+PBfmUpoaTx+LkGk+jbziOwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ZQC7mWQM; arc=none smtp.client-ip=173.38.203.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2754; q=dns/txt; s=iport;
  t=1715886324; x=1717095924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZDiRqz2la8YaFUbhmJvVA89OpRYWxJrlsQsevwHzgg=;
  b=ZQC7mWQMUH7WnQVfHQrKY7vHlKXqXsFMKgUGACxdNEwsyUWMxy5eGehC
   5qmFvdER4foXkkfao0DW+ziOljtFro2LtPJFapnYemR5xft0Nu47pssFn
   FDBUwOj4aysX162xdLRAyzB+P02IIrvMncJizQinc2avfEX5zrczLEdQj
   w=;
X-CSE-ConnectionGUID: ZWTzMNIzQI+Z/UGXhKyUVQ==
X-CSE-MsgGUID: Dqvu3BUkRxquSWbt47rBBw==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="10016312"
Received: from aer-iport-nat.cisco.com (HELO aer-core-6.cisco.com) ([173.38.203.22])
  by aer-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:12 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4Bpp006168
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:12 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 09/22] rust: Kbuild: enable `capnp`
Date: Thu, 16 May 2024 22:03:32 +0300
Message-Id: <20240516190345.957477-10-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-6.cisco.com

With all the new files in place for capnp, this patch adds support
for it in the build system.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/Makefile          | 23 ++++++++++++++++++++---
 scripts/Makefile.build |  2 +-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index fef8e38fbebd..f088ff4bdd34 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,7 +15,7 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o hex.o kernel.o
+obj-$(CONFIG_RUST) += alloc.o bindings.o hex.o capnp.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
     exports_kernel_generated.h
 
@@ -74,6 +74,16 @@ hex-flags := \
     --edition=2018 \
     -Amissing_docs
 
+capnp-skip_flags := \
+    -Drust_2018_idioms \
+    -Dunsafe_op_in_unsafe_fn \
+    -Dunreachable_pub
+
+capnp-flags := \
+    -Amissing_docs \
+    --cfg 'feature="kernel"' \
+    --cfg 'feature="sync_reader"'
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -470,11 +480,18 @@ $(obj)/hex.o: private rustc_target_flags = $(hex-flags)
 $(obj)/hex.o: $(src)/hex/lib.rs $(obj)/compiler_builtins.o FORCE
 	$(call if_changed_dep,rustc_library)
 
+$(obj)/canpproto.o: private skip_clippy = 1
+$(obj)/capnp.o: private skip_flags = $(capnp-skip_flags)
+$(obj)/capnp.o: private rustc_target_flags = $(capnp-flags)
+$(obj)/capnp.o: $(src)/capnp/lib.rs $(obj)/compiler_builtins.o FORCE
+	$(call if_changed_dep,rustc_library)
+
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi \
-    --extern hex
+    --extern hex --extern capnp
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
-    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o $(obj)/hex.o FORCE
+    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o $(obj)/hex.o \
+    $(obj)/capnp.o FORCE
 	$(call if_changed_dep,rustc_library)
 
 endif # CONFIG_RUST
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e9a64224c51..8a500593ea05 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -273,7 +273,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	--extern alloc --extern kernel --extern hex \
+	--extern alloc --extern kernel --extern hex --extern capnp \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \
-- 
2.34.1


