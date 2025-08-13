Return-Path: <linux-fsdevel+bounces-57764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678CB24F1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627551BC6312
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD42F83C0;
	Wed, 13 Aug 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NslFXO2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2032BD590;
	Wed, 13 Aug 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100797; cv=none; b=cRrRrLjrflpGiLAe0ztWOsW+DbKAPgLLngo4EXlVBkIVE/KW8tSdRHQjt1AiMvDlAMG1mTbCkCkr1NyRHY5hIYiwnv3DDtLQa2+5jj2kp+esXaU0A3P6+4g7LSIEGvFJHMByMpHHGgiwdLDaq8CfF8XhdtxGRfBrqBPd2D6QZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100797; c=relaxed/simple;
	bh=3ctZUWrM/ZFmDC33VBQrd7Y11Him7NQEHmNwBUrqlE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDAwyr8hSoK2l3IstWvGdgqYrh9J0gR8/UA/sCJ0hs+O2SJxgFhiZAbHccEd+XfAXQsPoGtiwI+0VKGIYk9sjvdLuPWddWtJ6WRBMgSPidkwXSbeqTx+pUCgYzJ3o1LLopGnUB172mCgs7qfX/WFDaFwkXxI57VEsZJlWKpifDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NslFXO2x; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109add472so359301cf.1;
        Wed, 13 Aug 2025 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100792; x=1755705592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xZaci7KvfQ9cJKxtLL1F647IuetZqbfoBs69JfjggA=;
        b=NslFXO2xtmuBMRpIDu8ZNFbn1DUugTULp7t7bevuNK/zG+2/VyWP3n2QTjtAJA7mna
         yT4AwQKPhwbxkOp4rEO3JEqQ7GQiIx32QzL30EbP+Jq2AkELG6cvb1d/97GO+nrcPXdD
         eQ94XN9XMCfG3mTwreyByrkNi51WNV53bQlAuwEv2ynrGayjy72VB9rPy51ksPOrElx+
         KIhSopflHLUnisbj663Ib6XAr9GdtsmnE5mPv4tTDjyWmLtaLcUEUZozpP3Xy5tf6bOp
         H+mCs4d1M89eHLBUTN5AtH56ZNeh5Pe341PD1T2XtQ8jA6QVXMLY6ONiFaPs7gzlBLPf
         82NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100792; x=1755705592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xZaci7KvfQ9cJKxtLL1F647IuetZqbfoBs69JfjggA=;
        b=ozDSUU+CjH3HDd864h4o5tQ5YfrKbUorwjnJs0hI92HrY4gSJypdbW3XGlaqHrhqZr
         i74MQ6Ps3QuagBlIQbyw/pC6rCrDIwmPVl8Cni618mC1/vsk5ZrOjfN42wmKCpPxlmXV
         g8POM2RPVdJ2k8Ieac7o5pKFI1avHn+WGq0HIGjCiiVBNorc3HQSO08L/kmQhVSPGDBR
         WJvdm2+OrqPGElHmCC5aU7G4dE6/r0SqakJTlnNt7AJgWHeimMAG4vOOE93NOHnXIr8p
         b3EFz1eVpr4lgBOt6+9z9IBn1hRHOBHNAigIebhSy/0a0OUTLr8xZiniU+kv3S1/YkGw
         8UpA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Qf1ahQ4rb2dZMyOtThTkvUj4FIoiaE6fgo71lWa7J61/VBW03UC0T2VW4gdk0+XiB7EOSHGk@vger.kernel.org, AJvYcCW232TLcFUei4dPxuRWIn0P7be2STErr5WprwdTbekNzpPHMzg2KpyswLxvP1zR2kZz7+y22oDSVJCX@vger.kernel.org, AJvYcCWOME+ZujoiTc5dNd5WINoSmnVSTRCyJhiw5ZqTJ2B3V5vDYdgGSCf0oxtxVbMlBnMQKV6GCffD6q9xtNzEGtBs@vger.kernel.org, AJvYcCWfZUyVFKu4MqQja8aBJR8OQk+S0R/Ox0sBytyTXjoxwtcZENbYVzZO+ItwEJoYZGHfkxMkeA5anda4Q0Ca@vger.kernel.org, AJvYcCWiLtccC8/XarwhZhA+Rwb0gvbA0iOkKZGQPkKtZdvh155rkt03PlKOGj8OvfOtlqSNsAwh5eoG/iUGdGcryA==@vger.kernel.org, AJvYcCWxvgwiGCfJznKjI77Bxa961Gws3v78Qa3x8JnTT7PP5Q5n/h7IBRTyL42Q2/KxIkfEZ5axO3nCqEvC2w==@vger.kernel.org, AJvYcCXEZ7om96Nf9VAi2nb9BRBjzDJbkVRDuFBgTcJYE7KHgRZIRjdhvchfqCaewOBaexNYharTpIynZVuw@vger.kernel.org, AJvYcCXFNSEAiUdavmQ94xC9nPA1U8YXXsGpTJpkCf+n06wbzLZb+I49tKdOweIhatYzUBYk1vgAYlaHanX1bkHpaB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEw3ira23L3nWcKJL9feV4tKSqQ7QU2WWE1Q/WLtAn++lESE6y
	cC8A0aGDJdqDie3baJ4JROyLEbO57qFTYyPKJy7E6gu5zTRe2B+9mCzn
X-Gm-Gg: ASbGncu9R43YpUmmqV/dL2ic6+amacAlNaLyvI6O4/FVPdFoFpB4D9zldkm0Dc1cKDt
	bSJvr+CuVijzq9YwCP3579c5jyfxD1il9NXuofUBoUnI9xJ7ll2CUGfqJuNL/qw/j1KMNRC5rjq
	FsNvPOsdsD/i/kuBRqaHXX3jWMu+/LmdcS7KVYr5dl88xXcXQiApQyGkjRl2dSH6Ci1Z6A2cAzU
	6BtzV+lJ5BETWZ8yI7zM5F8W/2+s7qZgIvBFC18tVToCka/KnO2bsw2pz2POodUDHl/a5O8wfgJ
	CMVGyW7yW9skjdYvcvFWXa4ofIXUAotILNPCJH9TtZK0PG5x/REwwbM+7tdwXLo1WlymB+9TE2f
	pxv1Adt6xgJLUKFvdDkLnAWtuAdQQxnUPYunX0+Uvb9BXUEnu5PXAU9Rzz0c5ffzM4ErC6XB4C/
	DPPciTBZUJC4S/OoRQ0E0Z/rvgmjx9
X-Google-Smtp-Source: AGHT+IGwyVF+jp+j/Dub7WGy29Shkca+ClbBDQ3S7nH/cS43Ir+wi1vGYs4X645d5o4aO3uUzcvYDg==
X-Received: by 2002:ac8:7c49:0:b0:4b0:80f1:8d48 with SMTP id d75a77b69052e-4b0fc8341aemr51857231cf.34.1755100791894;
        Wed, 13 Aug 2025 08:59:51 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:19 -0400
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
Message-Id: <20250813-core-cstr-cstrings-v2-9-00be80fc541b@gmail.com>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
In-Reply-To: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=5270;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=3ctZUWrM/ZFmDC33VBQrd7Y11Him7NQEHmNwBUrqlE0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKf/DdfqfaED3xwqY+++A2dwChPSjf3U7ItyFbVJ88ts9zWW6tRuEgZCnj3v561AZLUo2HTPEX6
 hlgrbpm3ZJAg=
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
2.50.1


