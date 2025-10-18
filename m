Return-Path: <linux-fsdevel+bounces-64570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A694EBED5FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 927224E18DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D312609FC;
	Sat, 18 Oct 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgA/ww7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E881FE46D
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809537; cv=none; b=s74zO4H240k48wPEm+lJKJsLUxlt1f98nQANeQ7ndryjmByWgL9RqriduinbIZf2guLyMmiPwrP9cOOmeRdL4qDF3j2FAmj9TbdNb1CeIziPsNc4ab3ag1KggOe5nqYxkN8hJQ/tyoVPhz7rog/MA+FA3anYt9zxAdG/SOILhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809537; c=relaxed/simple;
	bh=RkRyHI7uPJ58DcP8916jBGhXJnT62dW3s7Q+6uzhQjA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uyEwqTBCZ+mKALbD5EUIDnAQsUkuzSmM2P34P7s92BPGuQwg6j02365gZdGHP48llqmnMMA1Rdd/N7n1qYYQ4+DtVI5/mSnS3ohLoKc6fJhbSY9s9BdH7gG3aY5437CXLoZHoB/cLXOkAutt9QoaqXVQhxJpgzIYDFqbKwMzFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgA/ww7w; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2aebce7fso450747385a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809532; x=1761414332; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GdMS95Atx4mSrNPZQAo+LsUQxkW9pe6jqlDkCSsN+lg=;
        b=UgA/ww7wEmiz3T8cs0PpRj3NhbSeVpFRYahyuWcxurfuX/pjpdckIPTm8j9Gzb4KaD
         JqGWdDVZfJSf2QhUbEmjFbEO+wyI1R12R2tIbSi6FJV4erXBuACx/eMHM52+pQe89Cih
         wZqVGM9YDGGcXPeM95JD0/hZ7v4aFM86wlstTelb+clOhi2w4KR9nXIkUyyyOaYrLbrk
         LOEZV+NgPKI1QCVr5GfHu+mFHQFTJdVlnL1ZTQkKONQ3Zrs7a6x2g8DGOJ5Goi4yXdaI
         eznJOzIn1ANrhcTm2iOWrRuWYcjyXuVnz9rMNci+eSOy9Jg61az0xc19atQhuhIxFrdT
         0XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809532; x=1761414332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdMS95Atx4mSrNPZQAo+LsUQxkW9pe6jqlDkCSsN+lg=;
        b=PCJogfGVZBpZdYQOJECnIhmy8KAZcDcT6czjRsPVUnjqz/0dIix74fNZN1w8f6JiR5
         YfVBW/ucLC0QLqwD4pL415gTolyxzAk3310HC5gdgkNZmiW2qPG0Sf3DvEDEL3XIu2kG
         uVRmbbLiF9DvzwwPLP0pybeSe4WUx3zO1+Cb4qlL2Z5fvQeYtWUJyOY3KuHA2scsQTF1
         7EfMXqoqX08Xwf7CaziHXq9fvrot3zTKo0UQavuIfw3rWJPBjLl7C42IIqe+dFlDHNXx
         pcCP67VIRkvXUYS35AQoGldxZOWfD5iXteVLMX0TiBHStt+GfyTQoYLsTvvX0SidsYKS
         6dpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh5SC4P57Rb4ZYiAKmoAIaGVCh/yMFQxduGXd/4baE7OEPtOueJ1lSoPhA4B7OLbDTP+ChuDBL7b0n3WH2@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWDN0QmKjO7BeWkrRLId0yNv7BNE2y5pi+zftM5aECynKvdH3
	eBNIgemBekFa2IXs+jwGEz+uilic/uvi1QThFXhYbOT0rTs+wVqXK4fs
X-Gm-Gg: ASbGnctYbyvu2gddguexHCcQZ5OT0t4YAU+luF1kgpDFxBfJLQSLLHrTgdtDAKOqrF7
	AjP6avImZhudQhAUxbf5BkbmhKoFZ90JUKHdfF/qVEMi/vQNKfTIVCLPh/QTM/FLRlmRZfyWWrY
	ivjlmRy387PJ3Pi+ZWkblelsp1oEvAMJSxro9MwtQLf4CqcxkOpr88r1R/STzDN1sRoYaqDQq9c
	C8bCutniT11uxPORjfwoPHxCGOxDgfMI+akgb7nsQvgjQGfA9bVv6Zwb8rApGNJoWVZ5SQp8b4m
	BWGgnTIuZhjv/4I7ZhP3f3ewSUrQKhg+zz6tMO1ZIi2DesK9lIOU2tO0hwpiH00GczrQ0dAPXu3
	xbeDWUv3iGPzxPha6mwvf/k6ym98UClw/CPLVtP9haHBzXGVjVj6jOl5mMTMqSHQ4g5n0kqINn5
	nsKrTtocq662DgdELYD744OEf+YUpiFCOqqy/pnGtQZIadv0FcaCaQk4KFccG8hR88WTlWVp6vV
	PBKjpv4b3Rci5FFOKqJuGU/rYj9y9JIz6L47f+tye8rtXE2u+9bb+S8VBAqD7E=
X-Google-Smtp-Source: AGHT+IEdevRuwofuzpFzVC3FI0PAVHgIWWVzq4ljVRX5kAtuoN7pN/QGHe+EUZbFrhmTy1MgZSLsgQ==
X-Received: by 2002:a05:620a:4806:b0:890:28c7:f668 with SMTP id af79cd13be357-890706048dfmr1055053185a.75.1760809532242;
        Sat, 18 Oct 2025 10:45:32 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:31 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v18 00/16] rust: replace kernel::str::CStr w/
 core::ffi::CStr
Date: Sat, 18 Oct 2025 13:45:11 -0400
Message-Id: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjS82gC/3XTzW7bMAwH8FcpfK4Kkvreqe8x9CBTcmOsiTrZM
 xoEeffJWVvbMXaU5R/1h0hdmiGVPg3Nj4dLU9LUD30+1QW6x4eGD+H0mkQf64eGgDQQoOBhLIJ
 zSSKq1rfGIwF3Tf3/vaSu/7gV+/lS113JRzEeSgpfFRQ49Kil0eaJnAMrSEwh5pKn4df5+b3kM
 Z+OoX974nycSx76YczlfIs3mbnwVxBaBZmMAOGU8RxNJN/F59fvInOQyf5X2ipjQFe3CJR099K
 tpVxLVyW3siOTrDPO3Eu/SIl2LX2VGqNh1kSdoXuJsFBNak0RqjUKKXgVfbR6Z3FlJWwszomjZ
 +CWWw/7c2mxBv3G0nzDwJ5tq7QH2Fm5WLuZkrpVbe2KjTK13obdTaFaWdxmVnPmYBNwcMRun1k
 v1uGmQahnayVFTyQ7lXZ2NVCe9MbOE6U51gYrC4n35y4jhYBbe5sp1smGxM7CZhqv/95JSb//1
 Lc2fj6W6/UvA6b1f4kDAAA=
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
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>, 
 Matthew Maurer <mmaurer@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809526; l=8902;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=RkRyHI7uPJ58DcP8916jBGhXJnT62dW3s7Q+6uzhQjA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPrydIdiiRS/gK8h0NUWuFXcftpHIZ9RrtXQTWEtyVAud7xhDhZsNYylluVe0V4u3EjmEfmoG1y
 kqY2z5aP8tQw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

This series is intended to be taken through rust-next. The final patch
in the series requires some other subsystems' `Acked-by`s:
- drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
  look?
- rust/kernel/device.rs: driver-core. Already acked by gregkh.
- rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
- rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
- rust/kernel/sync/*: locking-core. Boqun, could you take a look?

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v18:
- Rebase on rust-next and fix more backsliding. (thanks Alice!)
- Link to v17: https://lore.kernel.org/r/20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com

Changes in v17:
- Rebase on rust-next and fix backsliding relative to series 2a and 2b.
- Link to v16: https://lore.kernel.org/r/20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com

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
Tamir Duberstein (16):
      samples: rust: platform: remove trailing commas
      rust_binder: remove trailing comma
      rust_binder: use `kernel::fmt`
      rust_binder: use `core::ffi::CStr` method names
      rnull: use `kernel::fmt`
      rust: alloc: use `kernel::fmt`
      rust: debugfs: use `kernel::fmt`
      rust: pci: use `kernel::fmt`
      rust: remove spurious `use core::fmt::Debug`
      rust: opp: use `CStr::as_char_ptr`
      rust: opp: fix broken rustdoc link
      rust: configfs: use `CStr::as_char_ptr`
      rust: regulator: use `CStr::as_char_ptr`
      rust: clk: use `CStr::as_char_ptr`
      rust: support formatting of foreign types
      rust: replace `CStr` with `core::ffi::CStr`

 drivers/android/binder/error.rs          |   5 +-
 drivers/android/binder/process.rs        |   2 +-
 drivers/android/binder/stats.rs          |   6 +-
 drivers/block/rnull/configfs.rs          |   9 +-
 rust/ffi.rs                              |   2 +
 rust/kernel/alloc/kvec/errors.rs         |  14 +-
 rust/kernel/clk.rs                       |   4 +-
 rust/kernel/configfs.rs                  |   2 +-
 rust/kernel/debugfs.rs                   |   2 +-
 rust/kernel/debugfs/callback_adapters.rs |   7 +-
 rust/kernel/debugfs/entry.rs             |   2 +-
 rust/kernel/debugfs/file_ops.rs          |   6 +-
 rust/kernel/debugfs/traits.rs            |  10 +-
 rust/kernel/device.rs                    |   1 +
 rust/kernel/drm/ioctl.rs                 |   4 +-
 rust/kernel/error.rs                     |   2 +
 rust/kernel/firmware.rs                  |   9 +-
 rust/kernel/fmt.rs                       |  87 ++++++-
 rust/kernel/opp.rs                       |   8 +-
 rust/kernel/pci/id.rs                    |   3 +-
 rust/kernel/prelude.rs                   |   7 +-
 rust/kernel/ptr.rs                       |   1 -
 rust/kernel/regulator.rs                 |   9 +-
 rust/kernel/seq_file.rs                  |   2 +-
 rust/kernel/str.rs                       | 395 +++++++------------------------
 rust/kernel/sync/condvar.rs              |   2 +-
 rust/kernel/sync/lock.rs                 |   2 +-
 rust/kernel/sync/lock/global.rs          |   2 +-
 rust/macros/fmt.rs                       |  94 ++++++++
 rust/macros/lib.rs                       |  19 ++
 rust/macros/quote.rs                     |   7 +
 samples/rust/rust_driver_platform.rs     |   4 +-
 32 files changed, 367 insertions(+), 362 deletions(-)
---
base-commit: 6f3b6e91f7201e248d83232538db14d30100e9c7
change-id: 20250201-cstr-core-d4b9b69120cf

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


