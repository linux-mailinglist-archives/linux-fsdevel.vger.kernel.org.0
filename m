Return-Path: <linux-fsdevel+bounces-62750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A6AB9FC2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F7E172E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6762D0C7B;
	Thu, 25 Sep 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7kK8Qey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366622C3260
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808515; cv=none; b=Op5WRu1PvfY8l3i/BvTeGyJIZAej9cK8dM1kBL89npom6dnnpzkmkt2Fitlc9H0VLnXk5omoPwKtiYJe4VWmnBC9TC0Gpl/ob/3LQ6MPAwQJzRtZbdyUu5CaWeH8Vv1kVGq2190t9GxJ09UkD8LMn6lDl73cHEYqJ9bn3ROw3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808515; c=relaxed/simple;
	bh=300cxburWPWmY9lTssmajDxSN3zcFF24g06h9nRYs20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxGGNmkLZ8HJ+/XMb0mr3ToaStalUZZ8AHm7c+fODoRFwKAuSMEqnS4Cs7HmBwpuA1yurybYMRSiTkEIlu0fZ6E1I+nYGhkaFSnzFi2ZtG1lSQXy7GPdlIRD7C2fFxH/C2oVvcBuz2jMM1ZM3u3hucZmMDRVfhazVJjrHY/DqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7kK8Qey; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-71b9d805f2fso7561686d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808512; x=1759413312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U63Q3tKt4yvUc7kEZBTozLak/g9U24aoTdz7wTOUUn8=;
        b=R7kK8QeyCq/GNryJEpW9r0RObftk9S8KCWumPWpZzothsIpNBzRnlxRREuiLSEtTZ3
         VRXoU4kg4U+3bbGwKFRdVJPZFtc9A0p1ymsvEfxiZpS2g9XOZfkrueX1uxlQ2Q8PFfbp
         AI747GJFqPXqPR+mCUfls+h4UUamRmaYEKjQCbkWuWCkUy+09QyJFpR6DHlMk/BvpdmL
         gt/8Vt/lsMvnNnZtbHQNeQKY4VOyTNYhTj6tCXhvZUOgNAZS4UF3nHlfyBQKUYw/BwSs
         rscYRNJRz/JO7pNegR+VMKoUBc+JIhcTOuQjV+q/xHksVXkVd+IHTEfZ963U0rkyshRp
         U3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808512; x=1759413312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U63Q3tKt4yvUc7kEZBTozLak/g9U24aoTdz7wTOUUn8=;
        b=v5upYnns7CUTkywTo/Xji38j/+17f/BSqjklXLKTjUeqLUc7uLOFUf251NEXZceMlJ
         Gg3oCD7H4fUjW6TYFt7NzyGjT1v9qrvcRJOviqjCDzW+pDi0F3RpSeqUe5ohp9SKhvq5
         xsJdJo/sd5nla+kWi12B6Oe9rhiwH4Ktskkx4b5HLo+EQcmlRNOt4JPIFd2uAvDAJcMo
         uXb3R2dKJvTkgQggJIzpOHhylOYuhgzGnDJS/x8GM8pMV5YYycVRFdk7PneUmpBHe0do
         /gqUGw6XMMZ+orLoL1a1JTQHfKv3bF8aIUkxYz9+4cjqFgWhLtYTOADOduwTHEMJ+JYs
         BCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWteGZrWAPuhCGoNJ+aToJYnPiPFAGO1j7AclRa6T+r+LMU4BD6zdhFjVrOiRneStGVUUFXAM24GbP5sl3x@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCgRd4S7Shysz9uCnQe0HRrX897PVtqBDZ3upFQlOCD1Y29n9
	VRFEEOeutIaiQR//MY3oxeIbgMERmzdX0D0zhR2mNGomdYxWrScB3LhT
X-Gm-Gg: ASbGnctNBc48idEsoE4idV6j9QDOVMG+oFg6dFcG6TmsMGB6WA1gYvDVv4QkxukPPyW
	4PrQteQxyW50StwDJt64FeL1jtCMzIv8T+0D+5Lht7EMN49sRCek/jmougrMXGzV6pqrXCZy6Sf
	fhJDO7GEvYm3pvLqpNhgseRhXgdw6WSb2opoMPWsZNMlcPqyjnmj+7E5vQCCSf2FsEgTwOCVXK6
	Voffa3dMkjdMoG3PAn00HBlStNhE4t48Ketnvy8vxbnemQOPdJ/30WGK6KEhqomfZTVTLSEGQmv
	7nWoupPjrWujC0dGOaNXPXEkbRNgGE4kKv7BaXBsUmnHN9P+4ueHmGFbopt77inqopGrkciiBrt
	Kyb5LARhYM3AJ/E+XHv/ybrE4ft073mR2ZGpj10af89a7tihRMDFsjlqFl4ZXp+qsvlKNP/0rCD
	PU76FzoutM8SKr9yFBse1BF57vkJQx1PEIMCNgkhz00fj69bD8HmLlEtgltPYP6v23CfZx
X-Google-Smtp-Source: AGHT+IFWMR0iD5S1X6cXwZlRMEtzfoP6D2Qm79oKix9BQEH2yFaei3OpgngEmHA9hP1GVazSKMs5EQ==
X-Received: by 2002:ad4:5ba8:0:b0:7ef:f440:2b40 with SMTP id 6a1803df08f44-7fc400b2becmr55283556d6.53.1758808511621;
        Thu, 25 Sep 2025 06:55:11 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:57 -0400
Subject: [PATCH v2 09/19] rust: kunit: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-9-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=5270;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=300cxburWPWmY9lTssmajDxSN3zcFF24g06h9nRYs20=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF54YtyD7aRAwHefr9LP1bPC0QTAqFHSUYTCpwBSPQUvl7eHVoDyM2m+1w0mdq8s608UqPwa3aB
 hTCM+d3+ziQ4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs        | 11 ++++-------
 rust/macros/kunit.rs        | 10 +++++-----
 scripts/rustdoc_test_gen.rs |  4 ++--
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 3a43886cc14e..6223a5ac801c 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -9,9 +9,6 @@
 use crate::fmt;
 use crate::prelude::*;
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
-
 /// Prints a KUnit error-level message.
 ///
 /// Public but hidden since it should only be used from KUnit generated code.
@@ -22,7 +19,7 @@ pub fn err(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c_str!("\x013%pA").as_char_ptr(),
+            c"\x013%pA".as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -38,7 +35,7 @@ pub fn info(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            c_str!("\x016%pA").as_char_ptr(),
+            c"\x016%pA".as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -60,7 +57,7 @@ macro_rules! kunit_assert {
                 break 'out;
             }
 
-            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
+            static FILE: &'static $crate::str::CStr = $file;
             static LINE: i32 = ::core::line!() as i32 - $diff;
             static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
 
@@ -249,7 +246,7 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
 /// }
 ///
 /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] = [
-///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
+///     kernel::kunit::kunit_case(c"name", test_fn),
 ///     kernel::kunit::kunit_case_null(),
 /// ];
 /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 81d18149a0cc..c64df1a01b9d 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -89,8 +89,8 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: *mut ::kernel::bindings::kunit) { bar(); }
     //
     // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] = [
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_rust_wrapper_foo),
-    //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_rust_wrapper_bar),
+    //     ::kernel::kunit::kunit_case(c"foo", kunit_rust_wrapper_foo),
+    //     ::kernel::kunit::kunit_case(c"bar", kunit_rust_wrapper_bar),
     //     ::kernel::kunit::kunit_case_null(),
     // ];
     //
@@ -109,7 +109,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
             test_cases,
-            "    ::kernel::kunit::kunit_case(::kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
+            "    ::kernel::kunit::kunit_case(c\"{test}\", {kunit_wrapper_fn_name}),"
         )
         .unwrap();
         writeln!(
@@ -119,7 +119,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
 #[allow(unused)]
 macro_rules! assert {{
     ($cond:expr $(,)?) => {{{{
-        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
+        kernel::kunit_assert!("{test}", c"{path}", 0, $cond);
     }}}}
 }}
 
@@ -127,7 +127,7 @@ macro_rules! assert {{
 #[allow(unused)]
 macro_rules! assert_eq {{
     ($left:expr, $right:expr $(,)?) => {{{{
-        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
+        kernel::kunit_assert_eq!("{test}", c"{path}", 0, $left, $right);
     }}}}
 }}
         "#
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index c8f9dc2ab976..b0b70a3d0f54 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -174,7 +174,7 @@ pub extern "C" fn {kunit_name}(__kunit_test: *mut ::kernel::bindings::kunit) {{
     macro_rules! assert {{
         ($cond:expr $(,)?) => {{{{
             ::kernel::kunit_assert!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $cond
             );
         }}}}
     }}
@@ -184,7 +184,7 @@ macro_rules! assert {{
     macro_rules! assert_eq {{
         ($left:expr, $right:expr $(,)?) => {{{{
             ::kernel::kunit_assert_eq!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
+                "{kunit_name}", c"{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
             );
         }}}}
     }}

-- 
2.51.0


