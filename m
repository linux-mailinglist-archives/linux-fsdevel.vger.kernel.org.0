Return-Path: <linux-fsdevel+bounces-37366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552469F1731
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE1188E573
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0801F4714;
	Fri, 13 Dec 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+6FQ4s0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB518FDBE;
	Fri, 13 Dec 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120217; cv=none; b=RM9XerXCIml8YHjFVvKIE4/tNZRwEzgrcFsxFMfkDK9NNDGsLId0Fnq17zpPCCWuUwu0617E6Fyi/FIqM7Q662kImfgWTnJ2Tx2BTuMSGWtXOLX8qbfER08itTZW6TPeDqPWKLt+xYPro67gtrExT1qHaCCUeXhRdt54C1qrIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120217; c=relaxed/simple;
	bh=j4kPs/JBdLhbr6ncy/xNIw0shwfwxeIrOWwdpPcsjVc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SiDlk0i6ys3sLEYaxiNY3j6/X1quVakpFgR384i47vIw4GZxqw70FwI0BLgtDgP+Va61GKeBIQSVcb5u60AxtUfGOp9VsWJmeMxtHsCJfMPEzydp6NTBvnBh5V6c58+B0QsOf78A6CdASdCMdgBrUozU/Q520YDcp3FN1EAUMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+6FQ4s0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21636268e43so27567745ad.2;
        Fri, 13 Dec 2024 12:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120215; x=1734725015; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3TCyZVkFUVpdORonsx7EBY8Dsis6k7gzxh2ZR3Pwck=;
        b=a+6FQ4s0moy6Om96c/axOVN7uodCFSmzYHdlJxaX/2Dki1Y/fugejRqZ4EtFTBGiGg
         eHrqYmAO5avNqKdwPwPFzsH273jWIQpRaZNWYpsBorF+ntgeQn18JpxcXX6EZhgl+Gja
         lUt6PjWWzyNJa5U7k5+FZ2/ByenS5SYshvT9Q5TXp+j7DlKfe6h5Diq/qt7PWwQPEG+p
         sSzr7rXGLF4CAzY+q5Q1BPugP1MRjrQruIQjnRAhvfB65XqVvC1JN1EWfdm3uTjgRbD2
         ND6uSTKeeFM3UlDQFmX4mxJUtn+tGT2slZJAe3jtVgGPoWXWOa6MFhi2EU/KCzBlaWf4
         wYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120215; x=1734725015;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3TCyZVkFUVpdORonsx7EBY8Dsis6k7gzxh2ZR3Pwck=;
        b=PXl0C1+sWGUcQZXNalyjWXisiVvNApTsNi+AdKwIWSIQ6w/JUBo8ku3VK4ZYiEr2jH
         ND/CbAST03FLd+s9o7L+yHiJTnRwuqS3lLkQZ/N5IomaOeAkfipluXfzHxVPtMQEC19+
         wDfqaZyRNOuj8AlqJNTIl5jKXci92zd6lOccYNYB5Nmkac3VFmz8T+EPry2lFzSjpMKv
         4EY3SyyVsQWWi0XfhkO5o1Dg65kj+hk/6tYobhY/R85twi1wOAtAlJR+KEMLTxY82LNs
         nCTxYolncRQss5pn+0uZw4/9OBhUcns5fgRDA24AY5U3+ho75UoMIxOVxi8OnPjEnkH4
         4rUg==
X-Forwarded-Encrypted: i=1; AJvYcCVCcCWHnO427TtNKnO9AcGR9S0Y8V6X4mUzhflSM8GlYRjpxxjav3rCbi0iAC9Wfz+E1G8AdUbaImp/daSK@vger.kernel.org, AJvYcCVL/Uden3islrMAMMXZRudbq98cs3L0pcgSxLYTVsQ0f9UUYxX6tpZTVdK5P4lbKMGiiMSgXnLeFCKMLbUoWd4=@vger.kernel.org, AJvYcCWvPa5MHLTFaiQU1/QXMZOPSlltg73Bxw8LUvL0reyQicCTlLiu4e+L1P0H1cTRhdfz8DcbycnQn9tif1iF@vger.kernel.org
X-Gm-Message-State: AOJu0YzCO26E+mgwKfGh605v0GDhPaO30OdeCNBQtj9exlrq/4unwCNo
	fp/661y/pMbXZIGnkQeKNsPP3cBeYuO11Mz3L+cFoGEJe+cdSAYzYOldbkUP
X-Gm-Gg: ASbGncsZlM59OgXmsLaDxBzxbJRoYUgpq2N04VBgX3ABYbpKas/8ToLNwRk/zLvmDPm
	IytNOz1eLILPp2jEZaYF75AD+tS/jsvFZ4i2D4Lzk+ys3M86mmOEZYbv8PXxq8GwtLykz7u22mS
	QDK8xmnLd85IbpIJzSJccw3gF6tx9iR413akqG27r3y+fVIse/fvUoYGhTDLhgJdKAJO3GNmZ/j
	+Kqi+FcMukt3HUCCcSO1ue7coscKQOQ6O1cuNsTxBOnYK0NxC1BdDVJNBWaTj+L2aY3Seslme2+
	AI8uwNISfq9xfuahKEHd+evdJqQIw6WwcE3WAOoUbpLAYoPse06BOghuH6fu
X-Google-Smtp-Source: AGHT+IH7ELbNIin+RNK255GnS58J4n4YRcN0FMhLP0C+34xT2+eVQMrFsOxbQLKST5Wjkj1nEr/z4g==
X-Received: by 2002:ac8:7dd3:0:b0:467:492b:617f with SMTP id d75a77b69052e-467a5803c40mr67584901cf.40.1734119736785;
        Fri, 13 Dec 2024 11:55:36 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e1cd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca087esm1047261cf.28.2024.12.13.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:55:35 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v13 0/2] rust: xarray: Add a minimal abstraction for XArray
Date: Fri, 13 Dec 2024 14:55:16 -0500
Message-Id: <20241213-rust-xarray-bindings-v13-0-8655164e624f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACSRXGcC/3XQy26DMBAF0F9BrOvIM8aAWeU/qi7GL2IpQGseT
 RTl32tI1URKsxzLPnN9L/noYnBj3mSXPLoljGHo0wDiLcvNgfrWsWDTQY4cC+DIWZzHiZ0oRjo
 zHXob+nZk2nkJBRSoyjpPTz+j8+G0ue8fafZx6Nh0iI7+MC64QiEVVjsoawWSIesM9XTch5aOg
 XZm6H6t6L7mFG26gfdgTXaLJTjTQ4zDN+vmiVXSQw3eOV+YZilXQ9PoWPK6MDWZJ8ML5400lRL
 WGG155dBKRV55xXXlDbeGinxNfgjjNMTzVtCitvXbToD6/yoWxTgTCMpYLUVZy33bUThuv1nBB
 fiD8qrQdCsxhFKj5trLGp8YuDPIxSsGEiNrUtKCqJx5ZvCBAXzF4Moo0kqDLyy6R+Z6vf4A96W
 hDkgCAAA=
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
 rust/kernel/xarray.rs           | 289 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 396 insertions(+), 45 deletions(-)
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


