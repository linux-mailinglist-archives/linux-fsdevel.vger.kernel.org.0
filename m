Return-Path: <linux-fsdevel+bounces-42300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876EA400DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADF4700232
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37F253B62;
	Fri, 21 Feb 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6lWIlHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05F25335A;
	Fri, 21 Feb 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169666; cv=none; b=LfRMCUL+r2WY3zjy4JjCVjOBRWh3IJHLq3BrxyTYFDgL1Zdv9AiOMrRb7PxdVYtWv07Xq3yKMEwLPwpckG3bvNyux3IvkBnNb3WSM0wRjRb1UYmApAVDCxV6uPbVuInaVKhEB4rQvexkgKtbfppCcq8lOJB+Hu4f7MOE2ih4Bt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169666; c=relaxed/simple;
	bh=I/R/zFaciHA9gGkeV0IZ15Yww2f8zPpqErANmslniS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VQwxmC8pSnIN1A8qWNBeMl87Uz4JWmUVqFQoeQ6ci86UdGm5vAa1z6h6fB1gaYfDlbhF3b99V0fJ61cYNoTSowY7QL60hsS7gzozt0H8W+XazjUwFNbABSbgC4adV/PO8G80EZgr5srYC3rxneSi1GB+3qz7MHNILaCN+QGtZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6lWIlHA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e67f377236so19868416d6.1;
        Fri, 21 Feb 2025 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169663; x=1740774463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Vaow0RQtk0G8diHK9x6hi889Fv7Pmh+PpJU50p/50=;
        b=V6lWIlHA0E+eWTwQnAA1L0+XJd7u9sjzItmyah0E+b3xRksgjesY51jlYzQc6dvM6J
         GpxIZOlz+DXgoRmzFa2oP48cwrIeYou1o7oaJbOxEPNv6gcSDZ1B1dlGZ/eOk3p+Mp5D
         Dpk34Es4OjiFd87okx7k2HpUm2PyX0o3Zwh7/T/aw25OaWjzgBue6gqOJbzkeINkcWaD
         WqrXuk8WU9vrFnIIjipkAjNWm6kDCjuXXLjMR0ZFmZZdanEApW9Td20afvTa6Qb4jlPD
         hmIjc5/gQEgCaFDJqhFKlrDgnwvdCGrCa5R1sgyjS90JPO2M56z9t5pt8pN+wcPo/eHS
         v1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169663; x=1740774463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/Vaow0RQtk0G8diHK9x6hi889Fv7Pmh+PpJU50p/50=;
        b=qf6mV9e9AXckuseBssUVGphdep8zAcl8KFzJ+k3WOZxD8cxXn7hH2M0Ln1+cXk5g7v
         V5VRWeW0A78GTSFVjDteRXLKYh7PNo00MuJl95+QWU+f8WGDPmmFzjb4p05baUBPVnR5
         70MWsgG0P6w3sLyvWPCV3jFYKU/Q1YsSY7ZXlGPAtLFOL//xp7mwh0V5sTI5jlll0PtX
         f/d5kWDS1jv7P+qc8yttej7/uFrBTedR3qdPToVFADZkth6pzHswNCcefPIzvGduEJ0N
         wjBAIXreCnzTmwRS2xhK4wqG19m71B6u9BrcnS20lP5SBNmv4dfUFdtoYdAKVihkNq10
         Ia8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9re5TjO2Xs4LDHHDy0A1gb8sGqtI9k23+wiYNhac+Uihl7R51Un1ErilCwHMx8AlkTzrY1GvHKVU2@vger.kernel.org, AJvYcCUDkoSiP8AhQxz1Q9LNO+5iaaays5fN9nqmk/iqq9idmD3n9NnKzVGWDNmq9pTnGz4S3eW78MaxM4Pf9p9d@vger.kernel.org, AJvYcCUGkCTMevUa9Q+QVKsgfPcHF8lI00uWVapjSMZkqDl2vblZR/0zN765xHt8GAHV6xhQoEsOaNbCh/AMGPNIww0=@vger.kernel.org, AJvYcCVHK+y5yO3FjC1CNg64GSoRrvuIFvteFLvtrsnwwItk99yOj0A03FN0rRTEPiKjPD45hKLPhPnktLktxLZo@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdl1nsSMExbFF6Q3owyDWYqLyS6w9oTC/1W0PsgBK4SqoY9QE
	pr2pgWL3aYw8tA8cvuLFfcw3oBOZSuzc6lHfDYjv5+nOK6gpqbrE
X-Gm-Gg: ASbGncs8MAI4ECleHBX6m3iJ4Fgwqb+ILi0ApMWNCqz2UtQac6dmwFn+3PD4APOWmBV
	Q3neL0QoWh7EVh0z0Sia6AMS8aetPrOOwdcmVvRYPITevcz4hIaFYy8ipGBsq4HmiLn9F7uhA8i
	NYPjZTgo8jDd7Mb6GMniCa4nk2pJyZKfqvxgjXhBmg4gnbUXAdiRSqXSOkEWJktrq+EVjU3JYZV
	cNTqg1EpXdbGqn6gXiUZW/zk+vz75jR8GeEcOFoOOghm5U9GUsk0O9l06OACs9BuMzk9l4knu1v
	j9UCaXQqhPxMXWE/sDRNsMTk/r6W8ZA5xi1SXzF8mrTIfyVKsQ==
X-Google-Smtp-Source: AGHT+IFc8qMGO/DOx2svQBC8cp3Ya9wPrWFdP2MTBAU7FpokJPT2IPLMHe/fQFbm0EyPaH6bLxk15Q==
X-Received: by 2002:a05:6214:29c7:b0:6e6:5b17:a6c with SMTP id 6a1803df08f44-6e6b002e7femr62975946d6.6.1740169663086;
        Fri, 21 Feb 2025 12:27:43 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:880f:47d4:56c6:b852])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a99d363csm539224985a.70.2025.02.21.12.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:27:42 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v18 0/3] rust: xarray: Add a minimal abstraction for XArray
Date: Fri, 21 Feb 2025 15:27:39 -0500
Message-Id: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALvhuGcC/3XSzW7DIAwH8Fepch4VNpjATn2PaQcg0CK1yUbSq
 FXVdx/NPhopy9EW/Pgb+Vb1IafQV6+bW5XDmPrUtaUA/bKp/MG2+8BSUxoVcpTAkbN87gd2sTn
 bK3OpbVK775kLkUCCRKN0Va5+5BDTZXLf3ksdc3diwyEH+4dxwQ0KMlhvQWkDxJCdvG3tcZf29
 pjs1nenHyuHz3OJNjzBQ+qHLl+n3KN5dL8TAuj/E46GcSYQjG8cCaVptz/ZdJweeYAj8JmyNmc
 5VRiL5NBxF0njgoEng1ysMVAY0tZQA6IOfsngjAFcY/DBGOuMgygbDAtGzJnVNKIwWhGBkkGhj
 AtGzpl6jZGFMTFE4UP0TsKCoV+GyiapNYamL0ZHjbfeOrFg1JxZTaMKg6Qc99EI5ZoFU8+Y1bU
 p03IWhTUGjAok9Jy53+9fHGjOBkIDAAA=
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
 rust/kernel/xarray.rs           | 277 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 394 insertions(+), 49 deletions(-)
---
base-commit: 11668f3b4a446222f0f3fe89b21247c176928c72
change-id: 20241020-rust-xarray-bindings-bef514142968

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


