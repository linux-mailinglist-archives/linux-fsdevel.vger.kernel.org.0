Return-Path: <linux-fsdevel+bounces-37643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602279F4F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AD1163F06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5AD1F757B;
	Tue, 17 Dec 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYNwL3mY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BE1F6671;
	Tue, 17 Dec 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449312; cv=none; b=tntwjNJUX/fNJw/1FOCit8mFc8Ul8x9x3T+5kaCJUGllU3cV04c4HJ/bI94h2jAGH/2gj+o7ENcDJDUk/adfd921KDZ6GMMjj2lJyUcf4VrOPTmmhMrAQqouybK9CjOD81sVb2Fb0qTt8WbKGkXQYngM8AU987r/xTaSnRixAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449312; c=relaxed/simple;
	bh=5QLW5SDrurRwqDOGjJn4+tBy6Z1lK3ju4JcTxUGJtsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bYZoWWAICLX6dWJhfgnrbIZOjUKCpM/r8Ldl70JrqqLD+FaYQswnryZoOwun+KgYx+c/tI+pQp//IFjWN3A77nr91Nl3Yx/oVNhHKEdpZTIZEGkvRnmiuoJpuWuxrVXelKTTXlxk/ddExCdKo6RDss3rsbm7EA7Re9pZQq8tn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYNwL3mY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4679fc9b5f1so44859111cf.1;
        Tue, 17 Dec 2024 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734449309; x=1735054109; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s09yS01LMH99HTi1ZquPBqX0TGfg1oM8maADsgZUJ64=;
        b=LYNwL3mYGx2XuXtZAFCuankFFeW8rmvOA+8M9hpaUC64TswsRaxmh9mJz4kMjYvNIx
         QKLSFe2C202mzTfWz6XkwtGjbL94FZ4DNyJyQr36jwnsXmzuBeBdn/DH5GESPAotFEHv
         cjvxH2bGrVpMqGFas7OXYgo68sFIEBkDaCr2o2ZQAkxoreyef+fOs9IgQbWx0diAM0VM
         gnE8qV3GJRYBT0T6WFZC3UgnwbdGl6PRMnv3Hh6YI8dS6IgF89kebkDdaO4bevnCnFJT
         le9j91dQpXhcVc78stnMKiXVoj2fkmsHa6r7r3Z3lN9zF6p4hkEHYDZRJy9U0ORcWM6y
         nZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449309; x=1735054109;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s09yS01LMH99HTi1ZquPBqX0TGfg1oM8maADsgZUJ64=;
        b=RuuPtSbwITpS0+OC0DAfTPUlgvDS4t0FQDuJlDKrUrrPAOFVuO/gHB75H54261tQiQ
         IbdB2PPe6984Ripb4KeykpD5tozpCNqJ2SctmVhjQ67H2+86/PbAdvX10QxoT8MBNPu6
         Fcw+5RXrofHlwxeym/c3vYg5ruyXBTcKwyAUHVy+pLGXXkn1axuIJ8xU6lQWGSqXl4TD
         gU1m13NBdh5i/VILihpkzj/FZZaKydGyqJDF9ZCzZA43T2+PavOlho1XDIm5dV3r5MgL
         r7JKJ9B0aI7yYdYm0+DEHAy1XJMDZyHjiy2CYm2aXE+kMngg0OeXhZ0L9e9mT/yYcYe/
         WADw==
X-Forwarded-Encrypted: i=1; AJvYcCUFKZhvr+2wcDx6rmuAnlWXgKTqnYEAS1+I0QRK8mY01Vw0B3OSu/Yx8oGPkAcq0J2/bw/j2naw1Kv8AS+ZBZc=@vger.kernel.org, AJvYcCUaZMZDwslg0mcF/l4JUiD+XjYX6HtKxhtp3XhzckmLiQASCX4nitKA41105NRHD87UYrrwqN4tF9ssnpUX@vger.kernel.org, AJvYcCUc7jl38qfvqbToYzTvmd/6ge7HYxMYsWlRCLSWRfoAPfstUQlIvyF1cpL+Xhh5gknm47YIX+arM2QvHcUK@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQwA7bxkjsCVmzAM9jlfYOIjDGcWxObnhlbQN78Apd0zN7esZ
	w5dyIhFrfP66NBOH2ZxzI3vVQt/dZK6XS+mAKUDXv7IJqrjfEfgZ/N0Yb+xU
X-Gm-Gg: ASbGnctk4hu3P60D6Yq4N1sy1efagY7GSXoHeS57c/MHvjEWKdT2d0gT2yUTP/IC68c
	6gfN5KFqgYkh2g9fwnpMt/hAxYfEtKhPoMFUMJ0rXT9uUYoS2GMgQz0uKgtUQlssAXdf9+IExmC
	G0oXQXQ4D88VbLjPRH8csgcrdkudsaBlObHmeB3A/3tQCIpvMssxTYOeYF5WsKok3ZK6DPuoLTF
	z8dHrZTcFeGGXvCLVPuAgAG+RzAn9kPozT1wEZ+gGMKaxVVfYB9PVfv25ISpeZ59DOMLOjI1TOb
	B6V4+RU8P2nBL7IZj5tJckY/S7FHG4/CHTltvWoeJay7yZxNtHaHnGClcthu
X-Google-Smtp-Source: AGHT+IHLGwFv2Ecya+gVShgDZmHPcYgmRLZ7JsJB1G9+cQcfgnD+KeHhF9zv554tO+yL63Z9uWW++Q==
X-Received: by 2002:a05:622a:1a86:b0:467:7a27:f3bb with SMTP id d75a77b69052e-468f8b6325dmr58956461cf.49.1734449309150;
        Tue, 17 Dec 2024 07:28:29 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:49e6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca057asm40250071cf.20.2024.12.17.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:28:28 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v14 0/2] rust: xarray: Add a minimal abstraction for XArray
Date: Tue, 17 Dec 2024 10:28:16 -0500
Message-Id: <20241217-rust-xarray-bindings-v14-0-9fef3cefcb41@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJCYYWcC/3XQTW7DIBAF4KtYXpeIGcAGr3KPqgt+HaTYbrHjJ
 opy92KnaiylWQ6Cbx7vWo4+RT+WTXEtk5/jGIc+D8DfitIedN96El0+KJEiB4qUpNM4kbNOSV+
 Iib2LfTsS44MADhxVJcv89DP5EM+r+/6R55CGjkyH5PUfRhlVyITCegeVVCAIks7qXh/3sdXHq
 Hd26H6t5L9OOdp0Bx/BmuIei1FihpSGb9KdJlKLABKC94HbZq4Ww+jRk+x1cWqKoC3lPlhha8W
 ctcbR2qMTSgcVFDV1sNRZzcsl+SGO05Aua0GzWtevOwHk/1XMilDCEJR1RrBKin3b6Xhcf7OAM
 9CN8qrQfCszGoVBQ00QEp8YeDBI2SsGMiOkVsIBq719ZnDDAL5icGGUNspA4A79E8O2zMs0LDO
 yEgIq7ivkYcvcbrcfSiESfY8CAAA=
X-Change-ID: 20241020-rust-xarray-bindings-bef514142968
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is a reimagining relative to earlier versions[0] by Asahi Lina and
Maíra Canal.

It is needed to support rust-binder, though this version only provides
enough machinery to support rnull.

Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcanal@igalia.com/ [0]
---
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
Tamir Duberstein (2):
      rust: types: add `ForeignOwnable::PointedTo`
      rust: xarray: Add an abstraction for XArray

 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 ++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       |   6 +-
 rust/kernel/sync/arc.rs         |  21 +--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 279 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 386 insertions(+), 45 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241020-rust-xarray-bindings-bef514142968
prerequisite-change-id: 20241030-borrow-mut-75f181feef4c:v6
prerequisite-patch-id: f801fb31bb4f202b3327f5fdb50d3018e25347d1
prerequisite-patch-id: b57aa4f44b238d4cb80f00276a188d9ba0c743cc
prerequisite-patch-id: 2387ec5af1cc03614d3dff5a95cefcd243befd65
prerequisite-patch-id: 75e26dd500888d9a27f8eac3d8304eab8d75c366
prerequisite-patch-id: 7f845443f373f975a888f01c3761fe8aa04b8a3c
prerequisite-patch-id: 5a9856c7363b33f0adfe8658e076b35abf960d23

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


