Return-Path: <linux-fsdevel+bounces-47092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C880FA98BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E651B681F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807AE1A9B3D;
	Wed, 23 Apr 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6bhpHGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9D74040;
	Wed, 23 Apr 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416482; cv=none; b=KFgJW11+EJYheD+jrq4YwvIeKHAL2OxLDIEWmMz5KH3jLoBe+TE4dwfhHICUBfKy2VrYxWem4raYzxre/fpwYk07o4rqundnooFzfXS4T8A1kozUffoBaMqulqbjKWSNbI25Ey93bTzVf1eRtjbGiMJS/Wq4EvwQTQ02NzPH6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416482; c=relaxed/simple;
	bh=XoBOMesWgUXT+lk88oveJberGTagV7NIVBewsaFDlvY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oC5QdI9Ti+6XxgGjNEVCijtVa8X6s/S1uSHqQen6CAx2GESWhODvCcqhKA0abwA+dIZtl5Ugbaj68YmrSWGba8rmGR6j99trfTmYdZBY3LgVzBlBzBVhXULKZ3fNkgXCPjCRsJnoDQdwT3VLCLZHVsceSY/UBzTexjviP/RN1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6bhpHGW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47677b77725so71392171cf.3;
        Wed, 23 Apr 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416480; x=1746021280; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSo0kVaG4qlwv2htSq5AzmCujd9KDIILJgYGjLhd/jM=;
        b=M6bhpHGWW/KJS021/LJPCVKiY8Srl4G9PxTmJEYfmFDRiI8s4fyVXM/qBKF5bh7+Gr
         /HC+eEvjKAhR5Q3B4JdhjkoF0Yd0YUv7lWCxa2Lw33suGsqW+s6ryHk8m8NLuJrMRbtV
         piicuQEixN2KN7V2oBQtX8l5PnXHVw8MLXGqvqGkTkAxjldXFbaiBW+LZSJt1JOROtNn
         SEKqa4mPbSV9grg8uj6xd9wsLIuQ2ycFe4EcMVo2/rwpxu1Gh9h2o4BOppoEf8aJs02V
         IuOvfADzlh6T/7J9idzsUxTCX35K069PmkrQDERocNqS6fyO6WokB82Os18cXWE3VWyU
         KORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416480; x=1746021280;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSo0kVaG4qlwv2htSq5AzmCujd9KDIILJgYGjLhd/jM=;
        b=pTQy6QfWUX2z7cnrLvfJTdTciQooIMwI8Ohjp5wVE1i5t1puLyVcDQ26igq9RnFTz2
         jvKHpL9E0dSPkroU3D/x1BTR+zObObuhgeB/i3h4K4X0yeB0N6ZSL7IKJArvImTqKMoO
         z6Jiv8HoGVjkPWIwFZmGfAc4cDUHoUn8CEHn9hbvGYiJ9ojYv/hTyOjCe72w9F9ztQ6X
         YxJKAccNGs47AfTCRlofFQlOYfVknbNR/nmVAwefewTSnceC8a8azqQRdANl24SV3Xtq
         Rv7t6TZBluY+73UPb32fCy62ax2mM7+mD6Ub7AwrMA1CPEoZgYq1Rx4cPwuv2dEMQXqU
         GKtA==
X-Forwarded-Encrypted: i=1; AJvYcCVI5CGtiz2wGJ23yNeWWj93szKkYSVAR/8Yj4ECqOa/Dg2tBel0iXI1IZuwbFQUJP+EZd7qoS8Ufy/z@vger.kernel.org, AJvYcCVtCs7wL9SChUijYjruRemb8WnoZEeVQqN9sX16fQC2q3+Ykpq7sFQbPFkP0ceC8WL4bemkFbnaqJnbZJyHSDg=@vger.kernel.org, AJvYcCXGX08AQCWTHx5mCohhjJh1yh6S6DanI4IfdYaJGoMzsKUAA6796pNxk/a4F3g1qhJzkiqiQ98883GbvfjK@vger.kernel.org, AJvYcCXuN9M/+5UKPHZZDJsSBqi5yEkpXfW1lrMWGM2wPR7W7/SssY5dhMueyKYjbHZ3dvmCLoeRgO7lnGjoKLkV@vger.kernel.org
X-Gm-Message-State: AOJu0YzheLLw2SJTHAWhJsR2IGCv4jEyACFYKXtdMyuF/Rs46LWMu/+c
	WWalFLGoi5CKMRpF//ChHtnAgfCOebEu7uGe+AGObZtf/JGryV+8
X-Gm-Gg: ASbGncundXzlMrBmJaurGAsNRyC92pMeGGv8R5L21vVyQ2VTGhS4d4Qcrnpw+XESLL7
	6PLlDvLrCIcqANa2K6NavQ24aDZ3Je7VAgv7RHYdPJ9EuVPDtUYv9uE6yDoQ2VLQgD1eYdduLOh
	hbslyk/S+uObj2cEfRout3MG4mnqPXLKQy4SVvXy512Z8XeX2DPwPaQEQBzdk4qFEVUCHV/IBpr
	d3TbwG9bM52DA9MMtCdIuIpvi5miCgMzZ+sT4qVeok8Wv5PyMwdotCpWUiwMgz5fy9GFvJPylRF
	51kJnfGml1U5tqDtczI5vv67xPQs0TV7aJ32ASOdYOipG6rrizX84B6BV3X6F/VTqX4xsthB/Wl
	YtWarUJ5mvYFqXM049YUf4FjYBxCYV/zPbByhBRdno0WtYQ9a7w==
X-Google-Smtp-Source: AGHT+IFTWCPiBOoKOSKSIX68I4H2kT7mfY6TzI+IL0WM9cWQNYz9zfcZdIgiXlUm+rBI/51oqr2/cA==
X-Received: by 2002:a05:622a:e:b0:476:8296:17e5 with SMTP id d75a77b69052e-47aec392209mr284737881cf.17.1745416479732;
        Wed, 23 Apr 2025 06:54:39 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f7dsm68135461cf.74.2025.04.23.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:54:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v19 0/3] rust: xarray: Add a minimal abstraction for XArray
Date: Wed, 23 Apr 2025 09:54:36 -0400
Message-Id: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABzxCGgC/3XS224CIRAG4Fdp9roYZmAQeuV7NL3gqCS627JqN
 MZ3L9qD22y5nAl8/ANcujGWHMfu5enSlXjMYx76WoB5fur8xvbryHKojQ45SuDIWTmMe3aypdg
 zc7kPuV+PzMVEIEGiUbqrW99LTPl0d1/fap3KsGP7TYn2F+OCGxRkcLkApQ0QQ7bztrfbVV7bb
 bYLP+y+rRI/DjXa/gFu8rgfyvme+2hu3a+EAPr/hEfDOBMIxgdHQmlarXc2b++H3MAj8InSmrO
 uqoxFcui4S6RxxsCDQS5aDFSGtDUUQCyjnzM4YQBbDN4YY51xkGTAOGPElGmmEZXRigiUjAplm
 jFyyixbjKyMSTEJH5N3EmYM/TBUf5JqMXS/YnQUvPXWiRmjpkwzjaoMknLcJyOUCzNmOWGa36Z
 Oy1kS1hgwKpLQM0ZPGIQWoyvjnXWRQkhe/Hnw6/X6CaoQ6vOJAwAA
X-Change-ID: 20241020-rust-xarray-bindings-bef514142968
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
X-Mailer: b4 0.15-dev

This is a reimagining relative to earlier versions[0] by Asahi Lina and
Maíra Canal.

It is needed to support rust-binder, though this version only provides
enough machinery to support rnull.

Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcanal@igalia.com/ [0]
---
Changes in v19:
- Rebase on v6.15-rc2.
- Link to v18: https://lore.kernel.org/r/20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com

Changes in v18:
- Add INVARIANT comment in `XArray::new`. (Danilo Krummrich)
- Replace destructuring with field access in
  `impl<T> From<StoreError<T>> for Error`. (Danilo Krummrich)
- Use enumerations in SAFETY comments (3x). (Danilo Krummrich)
- Link to v17: https://lore.kernel.org/r/20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com

Changes in v17:
- Drop patch "rust: remove redundant `as _` casts". (Danilo Krummrich)
- Drop trailers for shared commit from configfs series[0]. (Danilo
  Krummrich)
- Avoid shadowing expressions with .cast() calls. (Danilo Krummrich)
- Link to v16: https://lore.kernel.org/r/20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com

Changes in v16:
- Extract prequel patch for `as _` casts. (Danilo Krummrich)
- Improve doc and safety comments. (Boqun Feng)
- Pull trailers for shared commit from configfs series[0]. (Andreas Hindborg, Alice Ryhl, Fiona Behrens)
- Link to configfs series: https://lore.kernel.org/rust-for-linux/20250131-configfs-v1-1-87947611401c@kernel.org/
- Link to v15: https://lore.kernel.org/r/20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com

Changes in v15:
- Rebase on v6.14-rc1.
- Add MAINTAINERS entry.
- Link to v14: https://lore.kernel.org/r/20241217-rust-xarray-bindings-v14-0-9fef3cefcb41@gmail.com

Changes in v14:
- Remove TODO made stale by Gary Guo's FFI type series.
- Link: https://lore.kernel.org/all/20240913213041.395655-5-gary@garyguo.net/
- Link to v13: https://lore.kernel.org/r/20241213-rust-xarray-bindings-v13-0-8655164e624f@gmail.com

Changes in v13:
- Replace `bool::then` with `if`. (Miguel Ojeda)
- Replace `match` with `let` + `if`. (Miguel Ojeda)
- Link to v12: https://lore.kernel.org/r/20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com

Changes in v12:
- Import `core::ptr::NonNull`. (Alice Ryhl)
- Introduce `StoreError` to allow `?` to be used with `Guard::store`.
  (Alice Ryhl)
- Replace `{crate,core}::ffi::c_ulong` and clarify TODO with respect to
  `usize`. (Alice Ryhl)
- Drop `T: Sync` bound on `impl Sync for XArray<T>`. (Alice Ryhl)
- Reword `Send` and `Sync` safety comments to match the style used in
  `lock.rs`. (Alice Ryhl and Andreas
  Hindborg)
- Link to v11: https://lore.kernel.org/r/20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com

Changes in v11:
- Consolidate imports. (Alice Ryhl)
- Use literal `0` rather than `MIN`. (Alice Ryhl)
- Use bulleted list in SAFETY comment. (Alice Ryhl)
- Document (un)locking behavior of `Guard::store`. (Alice Ryhl)
- Document Normal API behavior WRT `XA_ZERO_ENTRY`. (Alice Ryhl)
- Rewrite `unsafe impl Sync` SAFETY comment. (Andreas Hindborg)
- Link to v10: https://lore.kernel.org/r/20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com

Changes in v10:
- Guard::get takes &self instead of &mut self. (Andreas Hindborg)
- Guard is !Send. (Boqun Feng)
- Add Inspired-by tags. (Maíra Canal and Asahi Lina)
- Rebase on linux-next, use NotThreadSafe. (Alice Ryhl)
- Link to v9: https://lore.kernel.org/r/20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com

---
Tamir Duberstein (3):
      rust: types: add `ForeignOwnable::PointedTo`
      rust: xarray: Add an abstraction for XArray
      MAINTAINERS: add entry for Rust XArray API

 MAINTAINERS                     |  11 ++
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 ++++
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       |  10 +-
 rust/kernel/pci.rs              |   2 +-
 rust/kernel/platform.rs         |   2 +-
 rust/kernel/sync/arc.rs         |  21 +--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 275 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 392 insertions(+), 49 deletions(-)
---
base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
change-id: 20241020-rust-xarray-bindings-bef514142968

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


