Return-Path: <linux-fsdevel+bounces-41093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B49A2ADA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2762160625
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F223645C;
	Thu,  6 Feb 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc9TE+Jh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EE1EDA2E;
	Thu,  6 Feb 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859093; cv=none; b=G5GbYnd2mqnBJIMr7+N1YKdQdw3i8nQLcI13SZ3y1x+sIK3Z4ieVla+YFemellwee+PZh83bhoUenQsJJwCKlEb73FoRnUYh8+mo7cu2hPtgB7mk1m468I6sYMdJ3yqq02GpMKsr8u1ETv8FA+mkmWQ3SxPvYGbRuYm2P5bIm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859093; c=relaxed/simple;
	bh=kju+6js0Yv4QtoktzUKTmIxCrstEL6CP7v4a5QxpKYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ipf2CWwTXYaAZPWf4QV1iuwA1p7D+laWLy2exTJ0NhqPirt1p7dC+vJegknO+wXv7uXsxK/R+fvc8h2nAGUvXfxSJdtdyAG3G/H/2ECb59e4i1oxYnfUgKaUYgjpVadeH/uV2R9CU52mpwg9dM2i8657EqaYiotwowUBoCCsF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc9TE+Jh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467918c360aso13545301cf.0;
        Thu, 06 Feb 2025 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738859090; x=1739463890; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ5WAraqa0Nl8T+8raEMefsUUiCCCAdvXMSJh5q+Lx8=;
        b=gc9TE+JhUDXhv7Z8zlndXf7vQOWHWD3ChUwwXvadn4MV9eCBrXCtBNKysBM3uxxHgc
         /6qH4VCkFWI18XKLJPFfo4NBJcoqKq13uMDzFvTHkk1S/Newg2cFhuiULSMfoyLhMaai
         t40BYIkWax4yMAbefko2f9bANExZgXy7NLuSdwikZbwJrLbzI6YjtjWazqllhg5f+MXR
         Tp53Km3D/dMdU3pMvP1rhdnscME2sSg16qNwBP83P70u4FkfoaOke/UYhcGncim2zKr+
         uX3a7T7IVrNKUdxk5R2B28o1UltpST5+dNYKgKRw2rcTEpb4VHv0u/kqaUZyilndo1Jv
         Dy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738859090; x=1739463890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJ5WAraqa0Nl8T+8raEMefsUUiCCCAdvXMSJh5q+Lx8=;
        b=ZXAu7xKbca1osUdHz5LnmKZooV9/rdOTBiyO5lUR5YbSmxJCUWzyr78I0KEvxKppTz
         HUEvEac8cwzHznX/Zphyee5CHcfRerhWrrELA3crFYj1GjJIX5KsAXIufej9mXRDE4ir
         kgSvHJoHplJcCw/mF7WCv+WobkibVqTLyqRnZ8Ub+lVwtS4e44UDLEV9E6E2/HFgydSp
         R6EJFVd/pS5bKI1bxFQqZe6J8kYbyUIYpfjL/IkGpC5B+vKssMdxgsPayGiiVIpAvC8A
         IrsBmPcs9qdtYwT5qpst/bxdowZvihPsBk7yIhi2rQvSFJbiPIWBrcvTzl1l9q2/BIy6
         w71w==
X-Forwarded-Encrypted: i=1; AJvYcCUR4QyiNSmhj0aZci4HzPw7wgxJYEphXwdE45oNqHlVUnWvvi8JI9zitJsgvPCM98+A0t3/rqCEyxeG1ju4cME=@vger.kernel.org, AJvYcCUoBlaomvIrXm14NH43GII2YXR6pxi9eHF5haSXwj1Xl+Zoq4AYc+84dJwaOn4eYYiemURprSP3M4aq@vger.kernel.org, AJvYcCW7LpQL/lrmIfLTac8dqZEPJJT+tED/MGm0iK2GYSN4g9mFVYXFa1pwlq3onGeUIAg7jF92bdjXnV9l8Jz1@vger.kernel.org, AJvYcCXCju4Qt2Y2kFemi8PA7AGx9CkCGPm6Xb8Sw7bvZgoTAQvPLWDOa2IzYVd1I8xIxzzZ2k6C7fByeg2/29w6@vger.kernel.org
X-Gm-Message-State: AOJu0YxAB5+hvu/bGKMXtoU8ccW00DvlFsennIEVNPEajLvJQEQwi3Q7
	Q3J7Tc0BbENg1kOpibwbCoVVoMfuwyt48uGr3VHQ0PRQt+nnXS2U
X-Gm-Gg: ASbGncu1qfty9qSI04sQqhyWF1v+OBrB1agPRarxWVTgRf3JqSxCHYaOg3WGGuJqAam
	yCyfou6izoUWOV/wDU2DWGnojsNSVGnuKYpqaEc5vg+SES4bUxXUVWNTAkVzBfvPbLhmEZmInWG
	C6Fn2MMsxNhrrJeuBPksvsn2SkBDwJ+uncuuvujG9TwxvRGwnox5LJbFOTDchtaHzsUu5j92Fcz
	M25mTRLtCnmrCzahwlyctc5rzgmfuhm+gdumQfLy9VQcDK8sFAxHr2YzcrhYiAXWQsvhMaj+1z0
	Fvgh/HYbVC1Mmsxo15tVMUZDMUV3F7gXW4Pg
X-Google-Smtp-Source: AGHT+IFRa2BZCLdY5bYSDmAbikbdHdZnUcWOTwEJ3Uh+MykbfDWum/HFRL9Ixor8mou4qJSIrFBaRg==
X-Received: by 2002:a05:620a:4094:b0:7b6:d736:55c1 with SMTP id af79cd13be357-7c03a02d577mr1122951885a.48.1738859090178;
        Thu, 06 Feb 2025 08:24:50 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb8e09sm76440685a.102.2025.02.06.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:24:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v15 0/3] rust: xarray: Add a minimal abstraction for XArray
Date: Thu, 06 Feb 2025 11:24:42 -0500
Message-Id: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEripGcC/3XP0W6DIBSA4VdpvB4N5wAWdtX3WHYBeFCSqh1a0
 6bpu4+6ZTVxXp4T+Pi5FwOlSEPxvrsXiaY4xL7LA6i3XeEb29XEYpUXBXKUwJGzdBlGdrUp2Rt
 zsatiVw/MUVAgQaIpdZGvnhOFeJ3dj888h9S3bGwS2T+MC25QKIOHPZTagGLIWm87ezrG2p6i3
 fu+/bUSfV1y2vgCmziMfbrN3ZN5bn8KAfT/hZNhnAkE4yunRKnVsW5tPM2PPMEJ+ELZ+mc+lRm
 LyqHjLiiNKwZeDHKxxUBmlLZGVSAO5NcMLhjALQafjLHOOAiyQloxYsls1ojM6FIpKCWVKMOKk
 UvmsMXIzJhAQXgK3klYMo/H4xubFwYTbQIAAA==
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
 Tamir Duberstein <tamird@gmail.com>
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
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       |   7 +-
 rust/kernel/pci.rs              |   5 +-
 rust/kernel/platform.rs         |   5 +-
 rust/kernel/sync/arc.rs         |  21 +--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 279 ++++++++++++++++++++++++++++++++++++++++
 13 files changed, 408 insertions(+), 45 deletions(-)
---
base-commit: e47e7490144c9fb26590447f73d90538e0934a75
change-id: 20241020-rust-xarray-bindings-bef514142968

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


