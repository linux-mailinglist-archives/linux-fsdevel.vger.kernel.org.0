Return-Path: <linux-fsdevel+bounces-64303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E0BE0643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39A0F35825C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47170311C33;
	Wed, 15 Oct 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJKfS4+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0913115AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556327; cv=none; b=YEzmhu+g/ToMh4scVxFvM67nC6qUPMDEP1g73dd95XRX5DzyaCSM+QcnJfaAs7rntjoOVXYE5B+TQi2pvfpJgcVFPab/dV/f3nuflR9SYYPARKRgB04WlIUHcgPwioLJ79nNIZsv7QMSQgWepc+K+tu3rCX8AoZiBolNUekAZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556327; c=relaxed/simple;
	bh=56qk4oXZToDCRjUenEK2FztuuA7wWME8i0VRUMgg2i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvxLeEvxZgUjTOg3BB2p8vyVsfMUOQxzSQHwlmh5/6h9PNqabdczi+Hnx77AaaXY1s2/kebDGGD5xH9vRZWbVp1LP8tuT2PCOjR2z+7ImEZ09banGnq8WHHjX0XUTSHtO0Ma/cHNbXWAlnYFOoBP7FV+ldYQTCcerxThBoLfvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJKfS4+r; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7ea50f94045so19392306d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556323; x=1761161123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiEqMd3xsyy/ksNexRFAfYvN9OsAs0xxvpBCNib+PpM=;
        b=aJKfS4+r8JBaaDfMiyH0Jys+JShqPPEVAYbpK3QIdz9AzsJlnj1Lyc/18i2xsdrDoG
         +2DY4EsAA8sP+breQ9fI4CFig4QYBVZFaYN6BXXPRZ1dSm42rShuchmO5ry2+kCr3Dez
         dc/W01KGJVaPcRwtKbMPUNETLZPSjDSfxbQRTQxuQ448fWWMybIuXuvwpWf6dM6GYMGT
         /gQa3i1MW6TC+ykI1Nad9QC/u9AahxYqtL8VGRyP0Q8VTOt7TwQVJOCrK2Zd9CEsJ4AE
         ZAve20Bc4r7IsxTWu01NdPAV5GuZE0miixEFqE4eMG9rjJyYZXQvd0YpSBmFdTkytyRl
         mmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556323; x=1761161123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiEqMd3xsyy/ksNexRFAfYvN9OsAs0xxvpBCNib+PpM=;
        b=GtvdkRXR6skgTsWvhr2rNjx0w9LfgiSg5hvBnV1lcVYxpf114QdDglPih3DR/YN13E
         TiHW8GSAdps9/rbGN6/1bu0fOSxNzgh0e4c+4sexaq3+a2eo/SIdoRzeC9msjfwxKXZW
         nOsaM80GGLUHon0lefvZTDkJ0bk0CkFUJe5VAPH4LkvAePQdSubyyvi390DTtb023Lyo
         hw3m0yHyYaHpHc0yrjodBQwQU6KnhuzYBjmcYfMHA7ZxS3yMqo2a+mknPprvhrUIph38
         0LpTegYwMgdtvzNauNnE3MdkmU2jQqjTZ7+VZh9aVTTMqkslgEHkBRZYE0jzIX0k66VW
         qGgg==
X-Forwarded-Encrypted: i=1; AJvYcCV/UMUAY06wMu0vXKYhlIownWbul3n0Y6/sx/P1xgjgXHU2i1aO6+tNlE2Z0sNjSnHa1Qd44y4dtxEyzuxJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg01aCyDXcThYYQSMbMMWw1ZIdCWnCyk1Z9B5wTwy6FdQyqBe0
	2SOilKHSoif5b9Tykf8TNsnJe4aKhRjxVH7xVN6y/b0hE0JreNAApc2d
X-Gm-Gg: ASbGncuBW4BsCx57OvGugQKZvLtd1gbST+EoPjh8bnjQF8EGHU1MGe/ixfTpmqvJkhf
	5ut5veXWyKNY0ChCWNvKn4X0QtObIKoKy5tOGSeQdKQPGy/0YYmXGuAiProkyGzGO4wp/ARq97j
	4WGP8Uyl83y0CsHEv8P/y2rN93eZF95BAhCYfO1ud8t2dMXRFlRSewgTzdA/YcfL4XZuV50V+ce
	8dOmY/qUUhECp+mDv7IJrdHif7nLhJ7PDRdKtNXyG0J95kgMdKr9TCNquthFdpdi1hW15gp8kkR
	gCnjikCHMhp+nKNc/Foqr/od9sV4N8EAfDGZ6+efgpliyBjnueiXottDLOH0vh13VKYuCFnvbvj
	tNh9bwRFkh7C5qityckkmbhAYLSKyVwIvoGv2RQSHS4DaOUYl+Oe797wyLnIzf33PPB4ckV/czN
	+dnRhrthEN127zdCNqRjX254jwFa4fDgH2eaYWS18XPiBPPaeMP6DnxLQiRqcz9nPBYZDRVF+2+
	fVnO6KUFDlppk/C9MbMdnfDntEWQ9Ls+fwYe+9flq+9mBFOB0wBlR7yGyHOXc4=
X-Google-Smtp-Source: AGHT+IFQKa+FZlLitOI+81eU92YyCY7iySPL5/OZykjhtsqwND3gt1523zwGXbz3ei7VPR6ZEbkqWw==
X-Received: by 2002:a05:6214:19c6:b0:78e:8752:826e with SMTP id 6a1803df08f44-87c0c6d0b3amr17673706d6.7.1760556322438;
        Wed, 15 Oct 2025 12:25:22 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:40 -0400
Subject: [PATCH v17 10/11] rust: support formatting of foreign types
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-10-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556296; l=11126;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=56qk4oXZToDCRjUenEK2FztuuA7wWME8i0VRUMgg2i0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFrNY4+4m4vAKukuSLoJFRCfJDb+Tq/Q2hqOOgtZg/QKSE2wld7ttq7E3MYm2zyTtcUPVBf4tcF
 KzbGgVn8QZwU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Introduce a `fmt!` macro which wraps all arguments in
`kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This enables
formatting of foreign types (like `core::ffi::CStr`) that do not
implement `core::fmt::Display` due to concerns around lossy conversions
which do not apply in the kernel.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/fmt.rs     | 87 +++++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/prelude.rs |  3 +-
 rust/macros/fmt.rs     | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs     | 19 ++++++++++
 rust/macros/quote.rs   |  7 ++++
 5 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
index 0306e8388968..84d634201d90 100644
--- a/rust/kernel/fmt.rs
+++ b/rust/kernel/fmt.rs
@@ -4,4 +4,89 @@
 //!
 //! This module is intended to be used in place of `core::fmt` in kernel code.
 
-pub use core::fmt::{Arguments, Debug, Display, Error, Formatter, Result, Write};
+pub use core::fmt::{Arguments, Debug, Error, Formatter, Result, Write};
+
+/// Internal adapter used to route allow implementations of formatting traits for foreign types.
+///
+/// It is inserted automatically by the [`fmt!`] macro and is not meant to be used directly.
+///
+/// [`fmt!`]: crate::prelude::fmt!
+#[doc(hidden)]
+pub struct Adapter<T>(pub T);
+
+macro_rules! impl_fmt_adapter_forward {
+    ($($trait:ident),* $(,)?) => {
+        $(
+            impl<T: $trait> $trait for Adapter<T> {
+                fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+                    let Self(t) = self;
+                    $trait::fmt(t, f)
+                }
+            }
+        )*
+    };
+}
+
+use core::fmt::{Binary, LowerExp, LowerHex, Octal, Pointer, UpperExp, UpperHex};
+impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary, Pointer, LowerExp, UpperExp);
+
+/// A copy of [`core::fmt::Display`] that allows us to implement it for foreign types.
+///
+/// Types should implement this trait rather than [`core::fmt::Display`]. Together with the
+/// [`Adapter`] type and [`fmt!`] macro, it allows for formatting foreign types (e.g. types from
+/// core) which do not implement [`core::fmt::Display`] directly.
+///
+/// [`fmt!`]: crate::prelude::fmt!
+pub trait Display {
+    /// Same as [`core::fmt::Display::fmt`].
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result;
+}
+
+impl<T: ?Sized + Display> Display for &T {
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+        Display::fmt(*self, f)
+    }
+}
+
+impl<T: ?Sized + Display> core::fmt::Display for Adapter<&T> {
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+        let Self(t) = self;
+        Display::fmt(t, f)
+    }
+}
+
+macro_rules! impl_display_forward {
+    ($(
+        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )?
+    ),* $(,)?) => {
+        $(
+            impl$($($generics)*)? Display for $ty $(where $($where)*)? {
+                fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+                    core::fmt::Display::fmt(self, f)
+                }
+            }
+        )*
+    };
+}
+
+impl_display_forward!(
+    bool,
+    char,
+    core::panic::PanicInfo<'_>,
+    Arguments<'_>,
+    i128,
+    i16,
+    i32,
+    i64,
+    i8,
+    isize,
+    str,
+    u128,
+    u16,
+    u32,
+    u64,
+    u8,
+    usize,
+    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: core::fmt::Display},
+    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::UniqueArc<T>: core::fmt::Display},
+);
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 198d09a31449..26424ad7e989 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -25,7 +25,7 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{export, kunit_tests, module, vtable};
+pub use macros::{export, fmt, kunit_tests, module, vtable};
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
@@ -36,7 +36,6 @@
 pub use super::dbg;
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
-pub use core::format_args as fmt;
 
 pub use super::{try_init, try_pin_init};
 
diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
new file mode 100644
index 000000000000..2f4b9f6e2211
--- /dev/null
+++ b/rust/macros/fmt.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{Ident, TokenStream, TokenTree};
+use std::collections::BTreeSet;
+
+/// Please see [`crate::fmt`] for documentation.
+pub(crate) fn fmt(input: TokenStream) -> TokenStream {
+    let mut input = input.into_iter();
+
+    let first_opt = input.next();
+    let first_owned_str;
+    let mut names = BTreeSet::new();
+    let first_span = {
+        let Some((mut first_str, first_span)) = (match first_opt.as_ref() {
+            Some(TokenTree::Literal(first_lit)) => {
+                first_owned_str = first_lit.to_string();
+                Some(first_owned_str.as_str()).and_then(|first| {
+                    let first = first.strip_prefix('"')?;
+                    let first = first.strip_suffix('"')?;
+                    Some((first, first_lit.span()))
+                })
+            }
+            _ => None,
+        }) else {
+            return first_opt.into_iter().chain(input).collect();
+        };
+
+        // Parse `identifier`s from the format string.
+        //
+        // See https://doc.rust-lang.org/std/fmt/index.html#syntax.
+        while let Some((_, rest)) = first_str.split_once('{') {
+            first_str = rest;
+            if let Some(rest) = first_str.strip_prefix('{') {
+                first_str = rest;
+                continue;
+            }
+            if let Some((name, rest)) = first_str.split_once('}') {
+                first_str = rest;
+                let name = name.split_once(':').map_or(name, |(name, _)| name);
+                if !name.is_empty() && !name.chars().all(|c| c.is_ascii_digit()) {
+                    names.insert(name);
+                }
+            }
+        }
+        first_span
+    };
+
+    let adapter = quote_spanned!(first_span => ::kernel::fmt::Adapter);
+
+    let mut args = TokenStream::from_iter(first_opt);
+    {
+        let mut flush = |args: &mut TokenStream, current: &mut TokenStream| {
+            let current = std::mem::take(current);
+            if !current.is_empty() {
+                let (lhs, rhs) = (|| {
+                    let mut current = current.into_iter();
+                    let mut acc = TokenStream::new();
+                    while let Some(tt) = current.next() {
+                        // Split on `=` only once to handle cases like `a = b = c`.
+                        if matches!(&tt, TokenTree::Punct(p) if p.as_char() == '=') {
+                            names.remove(acc.to_string().as_str());
+                            // Include the `=` itself to keep the handling below uniform.
+                            acc.extend([tt]);
+                            return (Some(acc), current.collect::<TokenStream>());
+                        }
+                        acc.extend([tt]);
+                    }
+                    (None, acc)
+                })();
+                args.extend(quote_spanned!(first_span => #lhs #adapter(&#rhs)));
+            }
+        };
+
+        let mut current = TokenStream::new();
+        for tt in input {
+            match &tt {
+                TokenTree::Punct(p) if p.as_char() == ',' => {
+                    flush(&mut args, &mut current);
+                    &mut args
+                }
+                _ => &mut current,
+            }
+            .extend([tt]);
+        }
+        flush(&mut args, &mut current);
+    }
+
+    for name in names {
+        let name = Ident::new(name, first_span);
+        args.extend(quote_spanned!(first_span => , #name = #adapter(&#name)));
+    }
+
+    quote_spanned!(first_span => ::core::format_args!(#args))
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index fa847cf3a9b5..793f712dbf7c 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -15,6 +15,7 @@
 mod quote;
 mod concat_idents;
 mod export;
+mod fmt;
 mod helpers;
 mod kunit;
 mod module;
@@ -201,6 +202,24 @@ pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
     export::export(attr, ts)
 }
 
+/// Like [`core::format_args!`], but automatically wraps arguments in [`kernel::fmt::Adapter`].
+///
+/// This macro allows generating `fmt::Arguments` while ensuring that each argument is wrapped with
+/// `::kernel::fmt::Adapter`, which customizes formatting behavior for kernel logging.
+///
+/// Named arguments used in the format string (e.g. `{foo}`) are detected and resolved from local
+/// bindings. All positional and named arguments are automatically wrapped.
+///
+/// This macro is an implementation detail of other kernel logging macros like [`pr_info!`] and
+/// should not typically be used directly.
+///
+/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
+/// [`pr_info!`]: ../kernel/macro.pr_info.html
+#[proc_macro]
+pub fn fmt(input: TokenStream) -> TokenStream {
+    fmt::fmt(input)
+}
+
 /// Concatenate two identifiers.
 ///
 /// This is useful in macros that need to declare or reference items with names
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index acc140c18653..ddfc21577539 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -48,6 +48,7 @@ macro_rules! quote_spanned {
     ($span:expr => $($tt:tt)*) => {{
         let mut tokens = ::proc_macro::TokenStream::new();
         {
+            #[allow(unused_variables)]
             let span = $span;
             quote_spanned!(@proc tokens span $($tt)*);
         }
@@ -146,6 +147,12 @@ macro_rules! quote_spanned {
         )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident & $($tt:tt)*) => {
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('&', ::proc_macro::Spacing::Alone),
+        )]);
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
     (@proc $v:ident $span:ident _ $($tt:tt)*) => {
         $v.extend([::proc_macro::TokenTree::Ident(
             ::proc_macro::Ident::new("_", $span),

-- 
2.51.0


