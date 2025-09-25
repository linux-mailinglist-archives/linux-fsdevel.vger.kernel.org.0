Return-Path: <linux-fsdevel+bounces-62736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD246B9FA1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BEC2E0212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96D275852;
	Thu, 25 Sep 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq5SyrLp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19C2727FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807781; cv=none; b=bgNd2NX+eMV9SjUydbS91usOrKvPxcCjhI/tvk2iU+cGGeEclGPNlZAoYNmcahRTnsg4H8SJ6fZB0nkYxD7iuEMqL3uq8BlYm6jNIXWsgrrzRlitnctB7UXQTMAOFE1d64e/JH78Y0HCIa4LYxpqXaEcSRimIQiU/47RcGVdiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807781; c=relaxed/simple;
	bh=AjPmM/pHX+h/hQUMZDyfnxxXsUMwDVAu0atf3xdL/Kw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hPvZ2xFjKdt3q790P/Ql9Kv9uookeLs0g14k0J1A0IQzYNE0OuKnGRXUNS2snZFAON/UhXrs2d1MqmQGxIbhYtYOvGT4zegqslTqBeipWWxc/yhuDIMMELMMpSh6oLQDBfWHUSaslirlpEUGpHrjAST/+iCMVhRd0NEXo05Lef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq5SyrLp; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78ea15d3489so7008876d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758807779; x=1759412579; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOg8apmzpeDQqSa/Dd8F6OxOIBmGa/u84P5Smsxjlh0=;
        b=Mq5SyrLpSZ5Qe8OduaR0YZXEBvegvYCIg5H+IVi2xtLDkFIhZcDrK+laYliJG1LZDw
         w7MtooBmO6SJT+FDsvAr3oyMm7xQoUWJrosXIg647uHJISvfjfSSoEZaJk+gYiit4ogO
         mooVUYLsQHb5ngGr1MlzZDE1BzENMqtWMEcDPPkRgUefWGpB2vsSxbMgO3PzbnMELHbk
         xFHQTefWDlBGKJPqKa29xgFArF/aW2GZV3MBedJauMqWWo0Ded5UNXB/zok/DCBAvRlh
         c6aR/XubA4Rh7NHxrNWZxyBi9PqwfTdesygfypuh/hvlf6hgqMY1h7gJ1a5AnQk9OVwd
         JI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807779; x=1759412579;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOg8apmzpeDQqSa/Dd8F6OxOIBmGa/u84P5Smsxjlh0=;
        b=E1t3zqplRnZHnI3DmiWwoBbfbIQmI0Gr3NzSk+JFee24k1K61X+xXdhJKKdM6COlCT
         qw0djkUnHxyIziL4+ilVmjweBw5GRWehvGP/ECoC4w1XjJoJa5FyW+dXcKJqfxjH2GH9
         UMnMtB+WC9eCS4fXFSwBkD+OAtSvkpViQPA9dcZTJhiNFqkUp83dVkX47ZfHyhSQkCnu
         D01kU8z1XkudoAcfhmqgK46EN3kg9+0rt/1OZXHs3oE029lNAv2FijbYu8FN1ipi3ITX
         vNjmWcVemi6NRKTwlWbMOzQ7cW/ME/cJTOvRFZLqs+AbUqMTWBFO0e6Pl8q+E0OvDXeR
         H8CA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Vlg0G4uzo0z0b2Gx0W04pc8EWECSq73cQr0MP8mCg+H7x9jxw8d2CRzKYFo3Me64XuuuLaHNeu9t/4Wc@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbxvfQoKnxLTzuU5xUsivFN+kBTbb5I96zQl+45YhrfUILCd5
	7beCPwoX+kXsEAdaE+DZElP/J2rruQno+tvvdo60BJHD46bqsbOXIEaH
X-Gm-Gg: ASbGncvDOegQlWB6yMWlUi6CsYLMp83w9ohHFmB8QaojrST4SLjTFdh4pUf7BKWHwOE
	KO184MxdvdtSe5gcL4bWTA2Qcl8nNqx8elh3fbgXf/McdJ5uIQQoVwAnoKVWW9d9Wk3lscaY9Fc
	ILcRy5Lr9O970OJYP6EpANofCjU4gVpR9xEnbKLthie8IlCSptJuYVT3iGFbVurWD/5jHB33Osz
	Xb9TLfoVFX7GjxpZUSfCtsdWf7XLKP/8hFVcYmZOgHZrMLncBnIUTp0hVMD1qeUsqzLHn2rzbYa
	aevjmLN9M59Z/7L9vDOtMMytvXkZQgZvcexSpJkePI5EqXw838/EbRY2oQugrd9PjSPIhJwqYqU
	JamauGJQr1fi20MNItrt+NetusQ8e+HfWJnb2KGWKT9IpHAtP+hb2zWvYuyJ6f5eimrIjqcXvHL
	kJ+tXCsCttcR1BQBBQRV1R083p0CECM/A5FSy5bVyyIx6XN4v/2z6au/d1crSb4QknCM1q
X-Google-Smtp-Source: AGHT+IExdU72Eod/dU9rvr4b53QJKFOsJtt7i1o6560BU4l1shliOTP11G8m0f0laH/knism0B6wyQ==
X-Received: by 2002:ad4:5deb:0:b0:765:44f5:6fa9 with SMTP id 6a1803df08f44-7fc3ca0be75mr52461066d6.37.1758807778596;
        Thu, 25 Sep 2025 06:42:58 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-800fa5f6dd7sm11852546d6.0.2025.09.25.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:42:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v16 0/3] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Thu, 25 Sep 2025 09:42:51 -0400
Message-Id: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxG1WgC/3XSTU7DMBAF4KugrHE1M/5n1XsgFo7t0AhaFydEV
 FXvjlMoSRqxdOzv5cmec9XF3Maueno4VzkObdemQ1mgenyo/M4dXiNrQ/lQEZAEAmS+6zPzKUc
 WRG1rZZHAN1U5f8yxab+uYc8vZd3ktGf9Lkd3SxBg0KLkSqoNGQOaERtcSDkN3dtpe8ypT4e9a
 983Pu3HyF3b9SmfrvUGNQbfitCsyKAYMCOU9UEFsk3Yvv6FjEUG/a/URQaHpmwRCG7upZlLPpe
 mSF/zhlTURhl1L+0kOeq5tEVKDMp7SdQoupcIE5Uk5hShWCWQnBXBBi1XFmeWw8Li2DhYD772t
 YX1f2myCu3C0njD4K3XtZAWYGX5ZPViSspWseVVdOCxttqtbgrFzOKysxg7Ox3BO0PerDvLyRp
 cPBDK0WpOwRLxRsS5vfzMa44fn2Xm+9+hvVy+AapJCxQRAwAA
X-Change-ID: 20250201-cstr-core-d4b9b69120cf
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
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758807774; l=6972;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=AjPmM/pHX+h/hQUMZDyfnxxXsUMwDVAu0atf3xdL/Kw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAdxlTupRVKg8Eba4pcHKMHx2RXPutys8afIdrm3UkljcyR2ySheNrAGBHqOJ/BGyyCcHRvfwBY
 tiGT+DR6Z6wo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

This series is intended to be taken through rust-next. The final patch
in the series requires some other subsystems' `Acked-by`s:
- rust/kernel/device.rs: driver-core. Already acked by gregkh.
- rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
- rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
- rust/kernel/sync/*: locking-core. Boqun, could you take a look?

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v16:
- Rebase on rust-next.
- Link to v15: https://lore.kernel.org/r/20250813-cstr-core-v15-0-c732d9223f4e@gmail.com

Changes in v15:
- Seal `CStrExt`. (Benno Lossin)
- Add patch to remove trailing commas from
  samples/rust/rust_driver_platform.rs.
- Link to v14: https://lore.kernel.org/r/20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com

Changes in v14:
- Break the change into multiple series.
- Move `CStr` reexport to `kernel::ffi`. (Alice Ryhl)
- `pub use core::fmt::{....}` in `kernel/fmt.rs`. (Benno Lossin)
- Avoid unnecessary binding to `first_lit` in `fmt!`. (Benno Lossin)
- Add comment to `identifier`-extracting loop. (Benno Lossin)
- Change `quote_spanned!` formatting. (Benno Lossin)
- Link to v13: https://lore.kernel.org/r/20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com

Changes in v13:
- Rebase on v6.16-rc4.
- Link to v12: https://lore.kernel.org/r/20250619-cstr-core-v12-0-80c9c7b45900@gmail.com

Changes in v12:
- Introduce `kernel::fmt::Display` to allow implementations on foreign
  types.
- Tidy up doc comment on `str_to_cstr`. (Alice Ryhl).
- Link to v11: https://lore.kernel.org/r/20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com

Changes in v11:
- Use `quote_spanned!` to avoid `use<'a, T>` and generally reduce manual
  token construction.
- Add a commit to simplify `quote_spanned!`.
- Drop first commit in favor of
  https://lore.kernel.org/rust-for-linux/20240906164448.2268368-1-paddymills@proton.me/.
  (Miguel Ojeda)
- Correctly handle expressions such as `pr_info!("{a}", a = a = a)`.
  (Benno Lossin)
- Avoid dealing with `}}` escapes, which is not needed. (Benno Lossin)
- Revert some unnecessary changes. (Benno Lossin)
- Rename `c_str_avoid_literals!` to `str_to_cstr!`. (Benno Lossin &
  Alice Ryhl).
- Link to v10: https://lore.kernel.org/r/20250524-cstr-core-v10-0-6412a94d9d75@gmail.com

Changes in v10:
- Rebase on cbeaa41dfe26b72639141e87183cb23e00d4b0dd.
- Implement Alice's suggestion to use a proc macro to work around orphan
  rules otherwise preventing `core::ffi::CStr` to be directly printed
  with `{}`.
- Link to v9: https://lore.kernel.org/r/20250317-cstr-core-v9-0-51d6cc522f62@gmail.com

Changes in v9:
- Rebase on rust-next.
- Restore `impl Display for BStr` which exists upstream[1].
- Link: https://doc.rust-lang.org/nightly/std/bstr/struct.ByteStr.html#impl-Display-for-ByteStr [1]
- Link to v8: https://lore.kernel.org/r/20250203-cstr-core-v8-0-cb3f26e78686@gmail.com

Changes in v8:
- Move `{from,as}_char_ptr` back to `CStrExt`. This reduces the diff
  some.
- Restore `from_bytes_with_nul_unchecked_mut`, `to_cstring`.
- Link to v7: https://lore.kernel.org/r/20250202-cstr-core-v7-0-da1802520438@gmail.com

Changes in v7:
- Rebased on mainline.
- Restore functionality added in commit a321f3ad0a5d ("rust: str: add
  {make,to}_{upper,lower}case() to CString").
- Used `diff.algorithm patience` to improve diff readability.
- Link to v6: https://lore.kernel.org/r/20250202-cstr-core-v6-0-8469cd6d29fd@gmail.com

Changes in v6:
- Split the work into several commits for ease of review.
- Restore `{from,as}_char_ptr` to allow building on ARM (see commit
  message).
- Add `CStrExt` to `kernel::prelude`. (Alice Ryhl)
- Remove `CStrExt::from_bytes_with_nul_unchecked_mut` and restore
  `DerefMut for CString`. (Alice Ryhl)
- Rename and hide `kernel::c_str!` to encourage use of C-String
  literals.
- Drop implementation and invocation changes in kunit.rs. (Trevor Gross)
- Drop docs on `Display` impl. (Trevor Gross)
- Rewrite docs in the style of the standard library.
- Restore the `test_cstr_debug` unit tests to demonstrate that the
  implementation has changed.

Changes in v5:
- Keep the `test_cstr_display*` unit tests.

Changes in v4:
- Provide the `CStrExt` trait with `display()` method, which returns a
   `CStrDisplay` wrapper with `Display` implementation. This addresses
   the lack of `Display` implementation for `core::ffi::CStr`.
- Provide `from_bytes_with_nul_unchecked_mut()` method in `CStrExt`,
   which might be useful and is going to prevent manual, unsafe casts.
- Fix a typo (s/preffered/prefered/).

Changes in v3:
- Fix the commit message.
- Remove redundant braces in `use`, when only one item is imported.

Changes in v2:
- Do not remove `c_str` macro. While it's preferred to use C-string
   literals, there are two cases where `c_str` is helpful:
   - When working with macros, which already return a Rust string literal
     (e.g. `stringify!`).
   - When building macros, where we want to take a Rust string literal as an
     argument (for caller's convenience), but still use it as a C-string
     internally.
- Use Rust literals as arguments in macros (`new_mutex`, `new_condvar`,
   `new_mutex`). Use the `c_str` macro to convert these literals to C-string
   literals.
- Use `c_str` in kunit.rs for converting the output of `stringify!` to a
   `CStr`.
- Remove `DerefMut` implementation for `CString`.

---
Tamir Duberstein (3):
      samples: rust: platform: remove trailing commas
      rust: support formatting of foreign types
      rust: replace `CStr` with `core::ffi::CStr`

 rust/ffi.rs                          |   2 +
 rust/kernel/device.rs                |   1 +
 rust/kernel/error.rs                 |   2 +
 rust/kernel/firmware.rs              |   9 +-
 rust/kernel/fmt.rs                   |  87 +++++++-
 rust/kernel/prelude.rs               |   7 +-
 rust/kernel/seq_file.rs              |   2 +-
 rust/kernel/str.rs                   | 395 ++++++++---------------------------
 rust/kernel/sync/condvar.rs          |   2 +-
 rust/kernel/sync/lock.rs             |   2 +-
 rust/kernel/sync/lock/global.rs      |   2 +-
 rust/macros/fmt.rs                   |  94 +++++++++
 rust/macros/lib.rs                   |  19 ++
 rust/macros/quote.rs                 |   7 +
 samples/rust/rust_driver_platform.rs |   4 +-
 15 files changed, 318 insertions(+), 317 deletions(-)
---
base-commit: f3f6b3664302e16ef1c6b91034a72df5564d6b8a
change-id: 20250201-cstr-core-d4b9b69120cf

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


