Return-Path: <linux-fsdevel+bounces-41999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C77A3A04A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F1F3B74CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAAD26E630;
	Tue, 18 Feb 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBE19Myi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8526B2DB;
	Tue, 18 Feb 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889472; cv=none; b=pYSap0VBHWCZ52iRCkfO3cwNV9WIpu/GN8FW8Rsp6MEs3APr8n691XmVGfb0Cj6MwE4PBbr7j8pCwYELLHXe6HooxhNQDBYNpb0Z8h70DZlOFiPEZZoIZUCD5dNd0PWDDj69PAEwCYkU/COGV3ehwIU4BPfY+I+cNTP2mo82F0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889472; c=relaxed/simple;
	bh=kTZkgisOeW801Sth2+lerhok9tOzKPXAzYpArOKOy6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J818UMEMoN7kyeX9AA1h2v0skWOjla0QEkb2wWJZdhY8rXury5bri5UuUUh+LYpaBsJbeDmhg+sTVlyBKIO/yYNyUtCcRKkx6abHLk0yePrpx9ZCqHlmScAJg65mf4gO9FRQmEfRpAyxogLZk9oUdfkUUdr/OLbKK65VFQdPN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBE19Myi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f257f763so16314031cf.0;
        Tue, 18 Feb 2025 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739889470; x=1740494270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HcaZw8R1wNpH+/hwT2VE9RWMhIZpp47OuhMJQ43oHw=;
        b=PBE19MyiA6N1yIcjTl3Mz55/aM9hzFAqGPkNCe8ia8XxGCl6ZWu/5dSM7UyLj819T2
         cwA6H6s1A9sg/ukSUc85PQA0SX2BmIfgYZntwYat705J5wyoaNSLRFvjNjGe+sL4FvU1
         LMyRAnlPaww/RNpzDlcT2WDe/3PtudgmMRVWmgyaOH0xodA0uJTy5Bn8AwM40snfRBHP
         yyLZGNvJdqVznhR26ilLvVul56HrD6J7OdIZfkh22KsYI2Tc7ms/Vpm+Ga7qx0LYoFz/
         aL8UVrfkYh69IPs+8WMmlUa7gbSz+myJ+iq5NSwgmH8m9n15w1L7OopM5bxZo+5SsUr0
         BVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889470; x=1740494270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HcaZw8R1wNpH+/hwT2VE9RWMhIZpp47OuhMJQ43oHw=;
        b=upozvza4G3c74X4obCFPODUbB8D6ZvGTrMpSCI3alApyNiLOPtpevwOwqAmuvG38qp
         oEGX5ky/m1Hb7ioyTqGO8WvgZHDk7wHstBWlrQeFfeYMMew6awXqBfaWRtqKRc2K9iuP
         e7FRRNflavwxeTnn6Tsj6aBgwrY6A1oF+9rUdagnKG8mJY3ivUzM/IU/MZTWQZ0PXqRt
         fJp3ysUaTN1lZtmSKcnip4uG8m4Y8nCdxCnHRm6Ar/j2LhJbsGe6o4nA2dHkSQIZznyp
         KusTRO5g3u1egmAT/zNMsRlvoYi38sfRoV9nsVXnREQhjqNjZVZNA9kUIGcETZUW0ilf
         yhCw==
X-Forwarded-Encrypted: i=1; AJvYcCVAfvoK6RB6qhBoEr1M8WIFUDGYmp4nfiK3KpPVqmO8tHs/CqlgC/yCDAZbQ0hEwA2s0/WKuIKz0XNxcI81@vger.kernel.org, AJvYcCVB9HRsGJH7LVdnGn6ligFKPQVigb/iDBgUtiPAZLEwt8PnWVhV3PAxflL+5MwE65ZYqO3SGUMQqOXH@vger.kernel.org, AJvYcCWZhdbTPYp2BABtbR5QsFt/KXlySxVRvwQWEFtYe15k4aV6WcXZOo0sVMHkX0R/zYFtr9cb4NnpY9DGaR8c@vger.kernel.org, AJvYcCWpGQGoq7npRrIkgLctAOipmBibiqw3C91tHFrzzCR/goppMgDUsz0hC852hMF8CgXwttx/ycnpr5DdHawfl70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJvnEe2QHztdf4u/sYPRK35GhCkWN47wbX+vS1Kr4+grXhNMl
	ZV0BoiToGQ6JDGtpUtEgzabNJEodr9Uq5duqA0uXk8hR0ej5xw4l1JeHeI9P
X-Gm-Gg: ASbGncsbtshNGC2+WZY8l+FX270Uc/UteUxdlrj1Nb0kuYqSjCKxTnpOW+2TpKuT1l9
	jrqmQy43oCw+ASZz/2zphvZwikcFwEt8uQBclH/lJnyojufAcwdQGV0I4YApe8+DEi0J1cnBa2k
	gPXwhgnLYsbX0KiPWgWC+g+qMGAyNLHObHaK+AllWQVuXfjTiwJ9Eo+bVGBF4O+W9rG4Avfsf0e
	aJB/XTSad/Mk3yeV60h4zT8akcubM2qIBUJUjpKRKn6qpfAw5nfripA7Eh6SPiWdKYxhjALuqES
	9FyssthjZkniXP3GuQNMUgcu4Bc55joxMYBrh1k=
X-Google-Smtp-Source: AGHT+IG7VJe+61wvnIsolh0sANxc/xJbP61UOhGcDR2IAysdCbfSG3tsR8slb+Tj/RTbi9efoyXXNg==
X-Received: by 2002:ac8:5892:0:b0:471:cdae:ac44 with SMTP id d75a77b69052e-471dbe978a2mr220943451cf.47.1739889469779;
        Tue, 18 Feb 2025 06:37:49 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:283f:a857:19c2:7622])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ef0a5943sm24409281cf.51.2025.02.18.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:37:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v17 0/3] rust: xarray: Add a minimal abstraction for XArray
Date: Tue, 18 Feb 2025 09:37:42 -0500
Message-Id: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADabtGcC/3XSzW7DIAwH8Fepch4VNpiEnfoe0w5AIEVqko2kU
 auq7z6afTRSlqMt/OMP8q0YfIp+KF53tyL5KQ6x73IB5cuucEfTNZ7FOjcK5CiBI2fpPIzsYlI
 yV2ZjV8euGZj1gUCCRK2qIo9+JB/iZXbf3nMdUt+y8Zi8+cO44BoFaSz3oCoNxJC1znTmdIiNO
 UWzd337YyX/ec7Rxid4jMPYp+uce9KP7ndCgOr/hJNmnAkE7WpLQlV0aFoTT/MlD3ACvlC23pl
 PZcYgWbTcBqpwxcCTQS62GMgMVUZTDaL0bs3gggHcYvDBaGO1hSBr9CtGLJnNNCIzlSICJb1CG
 VaMXDLlFiMzo4MPwvngrIQVQ78M5U1SWwzNX4yWamecsWLFqCWzmUZlBklZ7oIWytZL5n6/fwF
 gM3Xg+wIAAA==
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
 rust/kernel/xarray.rs           | 276 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 393 insertions(+), 49 deletions(-)
---
base-commit: 11668f3b4a446222f0f3fe89b21247c176928c72
change-id: 20241020-rust-xarray-bindings-bef514142968

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


