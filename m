Return-Path: <linux-fsdevel+bounces-14066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B23877490
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 01:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A5B1C20924
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0552BA53;
	Sun, 10 Mar 2024 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M7TGHF36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BE394;
	Sun, 10 Mar 2024 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710028854; cv=none; b=qe8b75Luea20S0F3OVJPu816gJYH6l9E7dA1Tk1IBug18A2cufpModp0nh0Y28HDGBhz1VlvnjBNO8nt1nXmqfEYuGKWssRJGOLr2tISL0Nri6KLYVH4Qbe47mCLcdN4DYDQdrJxmAEyaAUHtKqXKoOzYJYolD4xRjgPRberzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710028854; c=relaxed/simple;
	bh=xzbNb1Yxf9BTY6/pvIXx/t2QVQ3+TniBD89JbvaKGvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D4XKtvQz/xY7OblYvm0liVjF8w2tXRr9BbvcqiI0Crt5EABoHrJHC70ZwV4U/sXxV4TRshUFHCebctjBl6bLin0JGHwPeNizkTVDXB4bQmpApWGmVMr6KsqhGw9wYh5N0f1Pix5yUlTqYXVRbfM6YcTfYJr/a8ryqZ1T/Fzwkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=M7TGHF36; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qnHx40bjCYjrb1nob+HsWfSAIZCKPLdhcBGLbzh409U=; b=M7TGHF36CJy4w7pAIYVnPEFF/B
	gFeTiAV0wJIJ+d8FJolMr0Mmo3TEAFhb/XUtYbPzv1hcQ1tv9YgQrsjAI3Kuqa+sZlc+69ncvVG2g
	YTgbdqrqucKGpP3njNhTioPRNt9z+Hk8YsY2fBLq5aeSUT4L1cy5fWRlkIhBtN0dg+RezyjmxLqAT
	kFJCE9ZtrjTob5C+cspOXWM/wErtfmwmXNXGZ7pCPszkBs7c3QCbgBVBjtayxHtGRrs0FEqlMB3R2
	sx+51SO2dZ5vc8pRAg5uMGWERZBE5vo3/jGTlKb9NB5mTlYtQi4/NcVYPVJg5kRKeIwj1r14i1cgb
	4+kcQKbg==;
Received: from [186.230.26.74] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rj6by-008KqR-IC; Sun, 10 Mar 2024 01:00:19 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Asahi Lina <lina@asahilina.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v8 0/2] rust: xarray: Add an abstraction for XArray
Date: Sat,  9 Mar 2024 20:57:50 -0300
Message-ID: <20240309235927.168915-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This abstraction is part of the set of dependencies I need to upstream
rustgem, a virtual GEM provider driver in the DRM [1]. Also, this
abstraction will be useful for the upstreaming process of the drm/asahi
driver.

Best Regards,
- Maíra

Changelog
=========

v1 -> v2: https://lore.kernel.org/r/20230224-rust-xarray-v1-1-80f0904ce5d3@asahilina.net

- Added Pin requirement for all XArray operations, to close a
  soundness hole due to the lock in the XArray (locks are not safe to
  move while locked). Creation does not require pinning in place, since
  the lock cannot be acquired at that point.
- Added safety note to Drop impl about why we don't need to do the lock
  unlock dance to ensure soundness in case of a dropped lock guard.
- Downstream drm/asahi driver was also rebased on this version to prove
  it works (previously it was still on a pre-v1 version).
- This still depends on the Error series (v1). v2 of that will need a
  trivial rename of Error::from_kernel_errno -> Error::from_errno. If
  this version of XArray ends up looking good, I'll send a trivial v4 of
  XArray with the rename, after sending the v2 of the Error series.

v2 -> v3: https://lore.kernel.org/r/20230224-rust-xarray-v2-1-4eeb0134944c@asahilina.net

- Updated to the error v2/v3 series API.
- Renamed `err` to `ret` for consistency with the other instance.

v3 -> v4: https://lore.kernel.org/rust-for-linux/20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net/

- Rebase on top of rust-next.

v4 -> v5: https://lore.kernel.org/rust-for-linux/20231126131210.1384490-1-mcanal@igalia.com/T/

- Use Gary's suggestion for the Deref trait - no unsafe code! (Benno Lossin)
- Use NonNull (Benno Lossin)
- Not spelling out the lifetimes (Benno Lossin)
- Change XArray invariants (Benno Lossin)
- Add all SAFETY comments (Benno Lossin)
- Use `kernel::error::to_result` (Benno Lossin)
- s/alloc_limits/alloc_limits_opt (Benno Lossin)
- Split unsafe block (Benno Lossin)
- Make error handling of the function `alloc_limits_opt` through `ScopeGuard` (Benno Lossin)
- Use `ScopeGuard` in the function `get` (Benno Lossin)

v5 -> v6: https://lore.kernel.org/rust-for-linux/20231201195300.1329092-1-mcanal@igalia.com/T/

- Update constants to the new format (RUST_CONST_HELPER)
- Add invariant for `self.0` being a pointer derived from `T::from_foreign` (Benno Lossin)
- Fix the place of the INVARIANT comments (Benno Lossin)
- Use the Pin-Init API (Benno Lossin)
- Remove PhantomPinned from XArray (Benno Lossin)
- Add new requirements for calling `xa_unlock()` (Benno Lossin)
- Improve SAFETY comments (Benno Lossin)
- Split unsafe block (Benno Lossin)
- s/alloc_limits_opt/insert_between (Benno Lossin)
- Specify the target type of the cast (Andreas Hindborg/Trevor Gross)
- Guarantee that T is 4-byte aligned (Andreas Hindborg)
- Add code examples in the code (Boqun Feng)

v6 -> v7: https://lore.kernel.org/rust-for-linux/20240116151728.370238-1-mcanal@igalia.com/T/

- Change the INVARIANT from `Guard` (Boqun Feng)
- Change the INVARIANT from `XArray` (Boqun Feng)
- Change INVARIANT to # Invariant (Benno Lossin)
- Move XArray definition to the top of the file (Benno Lossin)
- Show structs from examples (Benno Lossin)
- Import XArray directly (Benno Lossin)
- Adjust some SAFETY comments (Benno Lossin & Alice Ryhl)
- Reestructure the NonNull block (Alice Ryhl)
- Create method `to_index()` (Alice Ryhl)
- Use `drop(T::from_foreign(new))` (Alice Ryhl)
- Both Sync and Send requires Send (Alice Ryhl)
- Add FOREIGN_ALIGN to trait ForeignOwnable (Alice Ryhl)

v7 -> v8: https://lore.kernel.org/rust-for-linux/20240209223201.2145570-2-mcanal@igalia.com/T/

* Fix clippy complains (Andreas Hindborg)
* Move semicolon outside of the unsafe block (Alice Ryhl)
* Remove PhantomData from Reservation (Alice Ryhl)
* Add `drop` call in `insert_between` (Alice Ryhl)
* Use "# Invariants" on the XArray struct (Alice Ryhl)
* Don't mention that you use pin-init to make `self.xa` be initialized and valid. (Alice Ryhl)
* Change Guard `NonNull<T>` to `NonNull<c_void>`, since that's the type used by `into_foreign` (Alice Ryhl)
* Migrate the C header to the new `srctree/` notation (Miguel Ojeda)
* Keep comments at 100 columns (Miguel Ojeda)
* Use intra-doc links where possible (Miguel Ojeda)
* Misc fixes in the comments (Miguel Ojeda)

[1] https://github.com/mairacanal/linux/pull/11

Asahi Lina (1):
  rust: xarray: Add an abstraction for XArray

Maíra Canal (1):
  rust: types: add FOREIGN_ALIGN to ForeignOwnable

 rust/bindings/bindings_helper.h |  17 ++
 rust/helpers.c                  |  37 +++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/sync/arc.rs         |   2 +
 rust/kernel/types.rs            |   7 +
 rust/kernel/xarray.rs           | 407 ++++++++++++++++++++++++++++++++
 6 files changed, 471 insertions(+)
 create mode 100644 rust/kernel/xarray.rs

--
2.43.0


