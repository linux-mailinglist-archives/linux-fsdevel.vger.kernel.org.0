Return-Path: <linux-fsdevel+bounces-64589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF1BED8BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C033AF35E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA730285419;
	Sat, 18 Oct 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewpx1nWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98B264628;
	Sat, 18 Oct 2025 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814995; cv=none; b=Uu4i+9syCUkJtQ1UtgC7rYwl8UgLyCsXHh07sZyIx9PJkmuW6Z8aZANQgiJ4Bgb4fLxWsI0ijoBXmwq4Epao9Dph0RMdXqby7Ptcm0XekmA2U66H/2H9qPaHsxsYUCbX1wlZ8vklm9CFuzy6ViwTj+cNch1JR5Gs22Tq0/ehUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814995; c=relaxed/simple;
	bh=UYAvvRatgJl1U8kE6JX/B7FyqWQOeGcu/l2CxDZG50o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=por3WVD+mljPjK+bhZKCMPN4A4Sv1vmKa2aGOhSaXGkJ8NN/zvfIoqqI+k7juvVxpQH6ZVnIwgYR2xNaOxBkUdQ0JTNLRX2M/6BZ287gBhlU8Kd0jYSnOW8jF/W8h6Tklu78rNvWSGfik0Da2EqFfRDot2DRCUcRkY39GkGk5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewpx1nWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98444C4CEF8;
	Sat, 18 Oct 2025 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760814994;
	bh=UYAvvRatgJl1U8kE6JX/B7FyqWQOeGcu/l2CxDZG50o=;
	h=From:Subject:Date:To:Cc:From;
	b=Ewpx1nWMwrqjaeIQdw2qtZvRytuHaqwG4PeXw/a7+4FGEV77pfSZzUZuPMF6KJZKI
	 GZUrw3nJ5g/hxsaveFMRmGczdoVWCL4woNfZpeZceCxJDcuPpCX//bSGCi2BwkSkcF
	 pTLTyQUc8J9yzcRcVyjJeY3Gl4HRGwN9SEfIP46CaWzpk6XngAoBBB+gUsl7z5uypA
	 12yUfsbW4ettgS6cRqwOK5Nft2AGl4LjCo1DSNGZxYhGoPVZgmiILdVXSjRjRpwkui
	 Rhp2Nl/M0cH7neSlsMNF3aFFPEiTyvl0DXK6wLDINKYqrQ84uLr7lGT7k6oXr2veOb
	 o+gIdVgk5r1cw==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [RESEND PATCH v18 00/16] rust: replace kernel::str::CStr w/
 core::ffi::CStr
Date: Sat, 18 Oct 2025 15:16:21 -0400
Message-Id: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>, 
 Matthew Maurer <mmaurer@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760814987; l=9242;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=UYAvvRatgJl1U8kE6JX/B7FyqWQOeGcu/l2CxDZG50o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMqk4e8mOkVUeNwhi9l7hWb5JZ46JZD93uSmL8TNdynrWKVMqsisHZdKKoej4OLKPLUu4bN5KHa
 MFCgTLTGHBgU=
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
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7h
JgsMRt+XVZTrIzMVIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQEVaxSMN3lgosViuLpol+oKplGSPij8p3lhf7mo+qFEJPLoNeoN6VLWNN2qURlMZq6
P/Mu0dq9fcwXsg/g3MLgU=
-----END SSH SIGNATURE-----
-- 
Tamir Duberstein <tamird@gmail.com>


