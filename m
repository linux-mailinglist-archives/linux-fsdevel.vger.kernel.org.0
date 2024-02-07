Return-Path: <linux-fsdevel+bounces-10560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485284C486
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE55288C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549A17991;
	Wed,  7 Feb 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqTl0AOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A11CD19;
	Wed,  7 Feb 2024 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285486; cv=none; b=EmwAJoQk6x8XsyqcyCFK47yFnbOp6OzLbch5wAr45Rh2hMw3IHOj7gdSNEgOxyDRA+cBqFUdXsnpcDFalN3DtrNNq13YizsrlLHa1HvXN3brBsjwCHDtDB9+fNyv3g2BosUEA99XOTKfrM1Im9dMddOQBap18MvEsmaxJTFCfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285486; c=relaxed/simple;
	bh=IP+M1HnDVYGg1erO3V8Pi68EDJkY0vOBrsE+b1FLdoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKGXsb00m2hqVgHvGHlbBXkFj5MkZThD3g/EP08s7cvfQB9tCqPEmtW5uWJgciwJFJoK4+14U9wpfaJGE+RG++KIhZOn7nuPJcq3utG8B7W/DEQgwGK84wVvpoFHeukw0QShg2p5hgba6hs0mSaoQ3VaP2d+HjQOoTh++h6oMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqTl0AOw; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso14015639f.2;
        Tue, 06 Feb 2024 21:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707285483; x=1707890283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhIWxZvHtLi72suBdkFEy8DAKzGI6L8hcYsZq6CGKyk=;
        b=XqTl0AOwLtWJnBzumKJgA2d5SKnrkfyKQ+pYMLU+V/fyMaMwIkgc/8gM4gaahDzs7e
         soTAhF/TwzOkoAEa4Sy4p3tgu1ZMFsInX6tqRFjk0MUpemYHjMwJ0e1byxK/UhpBVn9X
         uOY5lXn0N1Aostq89nV7tcnBGYqFwbrFA5Pn6QhOD9whd6PeXlw/azmpca5Y7gi3dGps
         7b9ot++zvoiLCxzc3B60eYdiDB9Ys6hhdsCB+wlgbcvs8IQr8gz8TZMtYtQ+3bGyP9Iy
         WV1kuGFmQqn6Y2sdwAJAbseXzuSomzQOtAr4ZjrtehTdddZBKpbzUKDRoJ5VueczFUF0
         EBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285483; x=1707890283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhIWxZvHtLi72suBdkFEy8DAKzGI6L8hcYsZq6CGKyk=;
        b=dSoFyyudRzjQIkaitaUYuY4WIn3tkepJg+2ZtzutR5OU16Oc4NGsKWyAuRKAz9kF0R
         vi7i/FqRTK/ddHYuyJaXzOKs0PDNnznHrRcOEz6eG1ESAP337GzjqrMH4B6EMsSVGCSH
         wvhkRzLz3xdZldCfTUk++jN3li0nlRlLz2TDwhLHzqGIisBAStYrrxVoP00lKWCTq57p
         GxwwMtS3Zdcvt6HCHYSALgt729MPxvRVXOcN60QucEScIfpAoFbW/aiMZsK1iJYIkMld
         2yATcOAlRG2qt606ohEOgaMmji+Cp3NjTTkE6HjWxyT+FTbIbEY4cnlbjhWgxT5cTINv
         oB1A==
X-Gm-Message-State: AOJu0Ywykn4rPZ+EyaaIowa18grM1dTlxvoxqAEAcie3u7xCcKqitDxS
	8RQhN8o4Tx3NmIjUU1dvvj86xE8fv8GELywXdo+8DDNGel1N7HwCPZ61rT4WxMo=
X-Google-Smtp-Source: AGHT+IH9+tttxsjIqhuk1VOxYqI4jahwrxh+2ox3fGUPMd+1i2Grr3NhJMZ5dGzv4D7GefheoI9aQg==
X-Received: by 2002:a05:6e02:318b:b0:363:9f50:9715 with SMTP id cb11-20020a056e02318b00b003639f509715mr6516415ilb.31.1707285482777;
        Tue, 06 Feb 2024 21:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGeBF8/UyiTOqIeuWt5dvI0CsdDg9a3l9AxmmqKlQWUh7+FiwCbpUxl9zUQVnNqARs5uwdKvqKW7UMbdrrDpsmId2Y9ZZjW06Rh2/R70MuIKOpOvnE6FGasA7W/K9uJCRfhr7DYCi8pLk/TxY8lVj/1Ry6Dtp/C60qIQMDkVMomimE1TMQnbjj0Wq1xs2B7zpYyGom4FPJc1QQXA2mMA5m0aYleETMFcSo12rCbUJbB5/I1MpXUzph/VlRuVosNCPpY51iHcQl8vCzvWwddo4W/kopQ+D3sDS2JwP7mF+pzI1SJxwMfLQjYUtpM4CvB+zIzXNxNgWj03Evd9ElGhEd+7gTyZnAurD0Tvyl+w==
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id l26-20020a02ccfa000000b0047135df02eesm109510jaq.54.2024.02.06.21.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:58:02 -0800 (PST)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	kent.overstreet@linux.dev,
	bfoster@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	masahiroy@kernel.org
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH RFC 1/3] kbuild: rust: move bindgen commands to top-level
Date: Tue,  6 Feb 2024 22:57:51 -0700
Message-ID: <20240207055751.611644-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bindgen commands are currently defined in rust/Makefile which
means they are only accessible to be used in the rust/ tree. This is
fine as long as all bindgen-generated Rust bindings live under that
tree, but there will be a need to run bindgen in other areas of the
kernel source.

This moves the bindgen commands into scripts/Makefile.build so that they
are available to be used by Makefiles anywhere in the kernel source.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 rust/Makefile          | 67 ---------------------------------------
 scripts/Makefile.build | 71 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 9d2a16cc91cb..25b68933750f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -270,73 +270,6 @@ rusttest-kernel: $(src)/kernel/lib.rs rusttest-prepare \
 	$(call if_changed,rustc_test)
 	$(call if_changed,rustc_test_library)
 
-ifdef CONFIG_CC_IS_CLANG
-bindgen_c_flags = $(c_flags)
-else
-# bindgen relies on libclang to parse C. Ideally, bindgen would support a GCC
-# plugin backend and/or the Clang driver would be perfectly compatible with GCC.
-#
-# For the moment, here we are tweaking the flags on the fly. This is a hack,
-# and some kernel configurations may not work (e.g. `GCC_PLUGIN_RANDSTRUCT`
-# if we end up using one of those structs).
-bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
-	-mskip-rax-setup -mgeneral-regs-only -msign-return-address=% \
-	-mindirect-branch=thunk-extern -mindirect-branch-register \
-	-mfunction-return=thunk-extern -mrecord-mcount -mabi=lp64 \
-	-mindirect-branch-cs-prefix -mstack-protector-guard% -mtraceback=no \
-	-mno-pointers-to-nested-functions -mno-string \
-	-mno-strict-align -mstrict-align \
-	-fconserve-stack -falign-jumps=% -falign-loops=% \
-	-femit-struct-debug-baseonly -fno-ipa-cp-clone -fno-ipa-sra \
-	-fno-partial-inlining -fplugin-arg-arm_ssp_per_task_plugin-% \
-	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
-	-fzero-call-used-regs=% -fno-stack-clash-protection \
-	-fno-inline-functions-called-once -fsanitize=bounds-strict \
-	-fstrict-flex-arrays=% \
-	--param=% --param asan-%
-
-# Derived from `scripts/Makefile.clang`.
-BINDGEN_TARGET_x86	:= x86_64-linux-gnu
-BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
-
-# All warnings are inhibited since GCC builds are very experimental,
-# many GCC warnings are not supported by Clang, they may only appear in
-# some configurations, with new GCC versions, etc.
-bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
-
-# Auto variable zero-initialization requires an additional special option with
-# clang that is going to be removed sometime in the future (likely in
-# clang-18), so make sure to pass this option only if clang supports it
-# (libclang major version < 16).
-#
-# https://github.com/llvm/llvm-project/issues/44842
-# https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0-rc2/clang/docs/ReleaseNotes.rst#deprecated-compiler-flags
-ifdef CONFIG_INIT_STACK_ALL_ZERO
-libclang_maj_ver=$(shell $(BINDGEN) $(srctree)/scripts/rust_is_available_bindgen_libclang.h 2>&1 | sed -ne 's/.*clang version \([0-9]*\).*/\1/p')
-ifeq ($(shell expr $(libclang_maj_ver) \< 16), 1)
-bindgen_extra_c_flags += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
-endif
-endif
-
-bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
-	$(bindgen_extra_c_flags)
-endif
-
-ifdef CONFIG_LTO
-bindgen_c_flags_lto = $(filter-out $(CC_FLAGS_LTO), $(bindgen_c_flags))
-else
-bindgen_c_flags_lto = $(bindgen_c_flags)
-endif
-
-bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
-
-quiet_cmd_bindgen = BINDGEN $@
-      cmd_bindgen = \
-	$(BINDGEN) $< $(bindgen_target_flags) \
-		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
-		--no-debug '.*' \
-		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
-		$(bindgen_target_cflags) $(bindgen_target_extra)
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dae447a1ad30..a6dd502f3b0c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -312,6 +312,77 @@ quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
 $(obj)/%.ll: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_ll_rs)
 
+# Generate Rust bindings (.h -> .rs)
+# ---------------------------------------------------------------------------
+
+ifdef CONFIG_CC_IS_CLANG
+bindgen_c_flags = $(c_flags)
+else
+# bindgen relies on libclang to parse C. Ideally, bindgen would support a GCC
+# plugin backend and/or the Clang driver would be perfectly compatible with GCC.
+#
+# For the moment, here we are tweaking the flags on the fly. This is a hack,
+# and some kernel configurations may not work (e.g. `GCC_PLUGIN_RANDSTRUCT`
+# if we end up using one of those structs).
+bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
+	-mskip-rax-setup -mgeneral-regs-only -msign-return-address=% \
+	-mindirect-branch=thunk-extern -mindirect-branch-register \
+	-mfunction-return=thunk-extern -mrecord-mcount -mabi=lp64 \
+	-mindirect-branch-cs-prefix -mstack-protector-guard% -mtraceback=no \
+	-mno-pointers-to-nested-functions -mno-string \
+	-mno-strict-align -mstrict-align \
+	-fconserve-stack -falign-jumps=% -falign-loops=% \
+	-femit-struct-debug-baseonly -fno-ipa-cp-clone -fno-ipa-sra \
+	-fno-partial-inlining -fplugin-arg-arm_ssp_per_task_plugin-% \
+	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
+	-fzero-call-used-regs=% -fno-stack-clash-protection \
+	-fno-inline-functions-called-once -fsanitize=bounds-strict \
+	-fstrict-flex-arrays=% \
+	--param=% --param asan-%
+
+# Derived from `scripts/Makefile.clang`.
+BINDGEN_TARGET_x86	:= x86_64-linux-gnu
+BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
+
+# All warnings are inhibited since GCC builds are very experimental,
+# many GCC warnings are not supported by Clang, they may only appear in
+# some configurations, with new GCC versions, etc.
+bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
+
+# Auto variable zero-initialization requires an additional special option with
+# clang that is going to be removed sometime in the future (likely in
+# clang-18), so make sure to pass this option only if clang supports it
+# (libclang major version < 16).
+#
+# https://github.com/llvm/llvm-project/issues/44842
+# https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0-rc2/clang/docs/ReleaseNotes.rst#deprecated-compiler-flags
+ifdef CONFIG_INIT_STACK_ALL_ZERO
+libclang_maj_ver=$(shell $(BINDGEN) $(srctree)/scripts/rust_is_available_bindgen_libclang.h 2>&1 | sed -ne 's/.*clang version \([0-9]*\).*/\1/p')
+ifeq ($(shell expr $(libclang_maj_ver) \< 16), 1)
+bindgen_extra_c_flags += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+endif
+endif
+
+bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
+	$(bindgen_extra_c_flags)
+endif
+
+ifdef CONFIG_LTO
+bindgen_c_flags_lto = $(filter-out $(CC_FLAGS_LTO), $(bindgen_c_flags))
+else
+bindgen_c_flags_lto = $(bindgen_c_flags)
+endif
+
+bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
+
+export quiet_cmd_bindgen = BINDGEN $@
+export cmd_bindgen = \
+	$(BINDGEN) $< $(bindgen_target_flags) \
+		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--no-debug '.*' \
+		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
+		$(bindgen_target_cflags) $(bindgen_target_extra)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
-- 
2.43.0


