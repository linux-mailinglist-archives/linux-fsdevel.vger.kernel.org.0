Return-Path: <linux-fsdevel+bounces-41199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A285A2C443
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221AD3A7C48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5771FC7D8;
	Fri,  7 Feb 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZb1bbzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11F1F76B6;
	Fri,  7 Feb 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936732; cv=none; b=Dal0siUYVISx0cR/BD6dBT7LtSPc76UEmJMm5RUXlXYz9MfGGio3OrmrvuTHdpHq4ptZE7z4Aqlne+RapRye9q7yLIZfs2e0rBwcI+0u2/XN+10MO+F0MR0t/CKPbT/qRhfqYzYh4yMqS6ZOcvbB3XDfAeorXWCtK8VCqUCr/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936732; c=relaxed/simple;
	bh=k7oSg/j/17fzI47cnShRzp1NqArW9/Ic//XwRDNJw3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E05nei+ULEsAQWRyw+/gHpH2c/bYLYb1PVIENrSeqH6mrx7tlt7gKusq3y9Mu02c/CGbSJaChb5xcfi14tnhwwmKbq/UAIcXUO6MfPnDw5jJDGGu6U6Xs+6W0cVXmZIQjI5/N4AJZRM9YEEzRhtNxJUdhdDSP02s0pS2YUzLT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZb1bbzB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6eb531e13so108111885a.0;
        Fri, 07 Feb 2025 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738936728; x=1739541528; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qXJIaOMNdOM3J+4MWSyfG159TVOFqHcISnYco4hiDM=;
        b=NZb1bbzBFIU8YlA0I0NCjZBq6EkxPiOVsYtgyTPVsfbz0iYFwsLa6KeB5W94rJa1Ki
         4uxMP75vMDTjb2yDUQDgVipOn0yG9v02sQfqfCRDJGGgFyn/qVIMQygXwRJaJmvShPrL
         nIbqZLpW6IO+r3gCEV1Wu7uZmMlQWT5tGa4YiWV6Pv3uGMI1mdOdm6JRvP6rohon+yqM
         HJIAHP4bpPVaiHziKrU+MBBkH/MG5iz4Xc+YU+s3NrvzF12vnMPEeVR19L/E+4eeuy16
         d8xRV+OkxYnzlFNJ3Dup0KggoJRe7eQzOdr91N89bcH9PcaDpGeyi5aTdSq3ajhA4s1M
         vOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936728; x=1739541528;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qXJIaOMNdOM3J+4MWSyfG159TVOFqHcISnYco4hiDM=;
        b=ZkLgmdkuNfX/+EDudnEhqP6L2U1NgWsgA0kb3U9vanp+ph9NyG3ac69r0vXmns3e0v
         lQBhlF/YpZVTYueKyLKi5mIbKVPKwU75U63plVLKIergnR3pXulhe+L0NHzulL449wo2
         kLmFXpcJFX+15NtpPu9jKXmmTGIlR748PRg93u7gaC8lj2o4aHG4S75kBblOmww1R2dG
         DxQI9VqigeRACoaL7v24PlOMnGVlSKRBdo2GUSn1rtn/e1qIr0b2cpaqHdU90IAh3OZU
         Ge3RCety0+OztcD/YHo1hOkyFQQyQnXdmspgTVt+J1OcpyIleeXpWLYqlGXC5fCidgBI
         lAVw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Qz5ksGaZd0QAcWV2yxZ6jPbYQGR1w/MpWLo7I6S0Ev58Fkl/zoDt/PtRBOE9V6wUftvENkXZ8R5J@vger.kernel.org, AJvYcCUCSiSVfJZ12gyROeD8pRStruo+di0F//TvQ5TBA0oQP41cvdsI+TXnpa76tvRD3OYOANmykeUyj4tcCtkS@vger.kernel.org, AJvYcCUmGmcGmtgwqLaGjeTXT+3wamtoDgoP/L5OH7cUtBJs6Qm3AiIfr2fWTSdaHGqKNyFk/ZCWVDotith56R+gFLE=@vger.kernel.org, AJvYcCV2mFx+8s+fAEMO/oaMYViXk0KnIuG5GabUXDTZORS4rS161OM4HLI7psU3PRHGCA32/2uvh3bBr5AqajVY@vger.kernel.org
X-Gm-Message-State: AOJu0YweJw5FekC/yrKfogKlHDRXByJgsgnKYYQnvHOPRx029v0oHkk4
	GCDOvZrpFKKIKkIPAJql5/RE/3P1bVmA/SYwa+/4nxRSYbpb2uHA
X-Gm-Gg: ASbGncunRej33LmraYK8tCiqGi0RGVdjxNw5C73/+YBIsHK8Fqy9BMctEaxGnoOJe/w
	1c8gpSfhEh+x/O+XCyHc7WS6ela/HzJyS+EsveT+s9TLI72nRLFEuzzgzJYJXAl7VgaiwOmOaFU
	OZNPQlyENwxqhGGgMBrimJFyJHRIKBcYbQi5ZpJswbimOkxYZCsituF8WqdO59qBilFL5AKIWlC
	31S4ugt1EajP8OnBWs5y9WWUtIXSOiUPej60l4Dns9kYQecEF/kAKGdAzSLiNumMQ73/0D6fZFC
	JfHIHDFueZfY5SMl5CjrTfUCIt11gpQ2R70=
X-Google-Smtp-Source: AGHT+IGie926EWH3jNAx2AducGaXHoOLO2cQkuY4tWmSKOI4r85qEYp3P4wS3gFVETNz2lB2Q2ruhQ==
X-Received: by 2002:a05:620a:2a0c:b0:7b6:dd82:ac9c with SMTP id af79cd13be357-7c047ba69f0mr410912685a.12.1738936728430;
        Fri, 07 Feb 2025 05:58:48 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e11d19sm191919685a.52.2025.02.07.05.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:58:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v16 0/4] rust: xarray: Add a minimal abstraction for XArray
Date: Fri, 07 Feb 2025 08:58:23 -0500
Message-Id: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIARpmcC/3XSzW7DIAwH8Fepch4VNpiGnfoe0w5AIEVqko2kU
 asq7z6afTRSlqMt/OMP8r3ofYq+L1539yL5Mfaxa3MB6mVXuJNpa89ilRsFcpTAkbN06Qd2NSm
 ZG7OxrWJb98z6QCBBolZlkUc/kg/xOrtv77kOqWvYcEre/GFccI2CNB72oEoNxJA1zrTmfIy1O
 Uezd13zYyX/ecnRhid4iv3Qpduce9SP7ndCgPL/hKNmnAkE7SpLQpV0rBsTz/MlD3AEvlC23pl
 PZcYgWbTcBipxxcCTQS62GMgMlUZTBeLg3ZrBBQO4xeCD0cZqC0FW6FeMWDKbaURmSkUESnqFM
 qwYuWQOW4zMjA4+COeDsxJWDP0ylDdJbTE0fzFaqpxxxoolM03TFybQcum0AgAA
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
 linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
X-Mailer: b4 0.15-dev

This is a reimagining relative to earlier versions[0] by Asahi Lina and
Maíra Canal.

It is needed to support rust-binder, though this version only provides
enough machinery to support rnull.

Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcanal@igalia.com/ [0]
---
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
Tamir Duberstein (4):
      rust: remove redundant `as _` casts
      rust: types: add `ForeignOwnable::PointedTo`
      rust: xarray: Add an abstraction for XArray
      MAINTAINERS: add entry for Rust XArray API

 MAINTAINERS                     |  11 ++
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 ++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       |   7 +-
 rust/kernel/pci.rs              |   5 +-
 rust/kernel/platform.rs         |   5 +-
 rust/kernel/sync/arc.rs         |  21 +--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 276 ++++++++++++++++++++++++++++++++++++++++
 13 files changed, 405 insertions(+), 45 deletions(-)
---
base-commit: 5652819e2b9232489eaefd019675abd55a442b62
change-id: 20241020-rust-xarray-bindings-bef514142968

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


