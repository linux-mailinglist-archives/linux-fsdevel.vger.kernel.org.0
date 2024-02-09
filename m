Return-Path: <linux-fsdevel+bounces-11030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D3850013
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 23:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055DCB2D7C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A82374DE;
	Fri,  9 Feb 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SB+99+Bj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123F374D4;
	Fri,  9 Feb 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517975; cv=none; b=R3bqkVkqHF8Xt5d5g4Y08/wydqBBwbbZCVohU620ygH4Nvv0n7l6tllF2/ABuQi9jUXnj3069bP9i9b4sqATlBe429dP5H3oStCSpFNlwwVeGWRExDj7dWSMVSmclNO0NNzCWV7O5+VWuVagiUItB45nn0MoLBewVmqcLM74Rc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517975; c=relaxed/simple;
	bh=mxSQgiHlybAgyETmfC8M0E9iRnzlwV0Vzk4GIBsvgE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+8QGgqDGdNnHFemXxmr0UPwgJRQurvYuf7rfGWWg3sL0Y8Xy4LdoktXJcky+vRzMTVpoNLseNlxm2cCG/TgQVNDkeM2yIX/MV3+rJfakdsM2wLmsjJ5j+6vW0eLpA+2QKYoJthGWZN/gIMU/IQhR5naaN+7B6b6396imP/dUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SB+99+Bj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ih75kBvK/GaZxC3xY7qa2xlO0zPuURVDit2B4aob+Sc=; b=SB+99+BjB6SVTMennKxfT0fztH
	qnQHHc/0LvkRuITPICY+ULSUjunc8RzJItWGx4rT0R8b9y4FC2nrpBdEhBGKfuTsqIOGLOLsa1zaw
	iZsYzElXPPdq/OYxcC1apUrENn6Bc/nonMZhqrQgNzgq+Z3+aF9xN5FRjVfFMJFLrjiXIr9pvN7QX
	cRSLX45xdC068DZ0LsnKnmKPZEDhc5cxvIWtkryWNNiIqRcnBYkz3P+D/OQvmJO/5NsyUE+xKA+yz
	aIm+9nRq0dwhZoidTH2hKzfZi5ETI8UWUjhjfLjnvTQmU84HwCF7kvbrhNSU+vPXzxTEjB5lvz6ab
	yKvcpohA==;
Received: from [179.234.233.159] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rYZQ9-00FjSP-9d; Fri, 09 Feb 2024 23:32:33 +0100
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
Subject: [PATCH v7 0/2] rust: xarray: Add an abstraction for XArray
Date: Fri,  9 Feb 2024 19:31:06 -0300
Message-ID: <20240209223201.2145570-2-mcanal@igalia.com>
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
 rust/kernel/xarray.rs           | 396 ++++++++++++++++++++++++++++++++
 6 files changed, 460 insertions(+)
 create mode 100644 rust/kernel/xarray.rs

--
2.43.0


