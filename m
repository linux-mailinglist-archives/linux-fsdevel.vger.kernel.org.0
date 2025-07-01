Return-Path: <linux-fsdevel+bounces-53535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D9AEFFBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047FB164FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81E27D770;
	Tue,  1 Jul 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHo058GP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818291F428F;
	Tue,  1 Jul 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387244; cv=none; b=nqdwRP0pJcQIkw6bdGM0QdECew3MC2okkG+vX/3gmsZQbnn47maeK/HWiibmslZe6vgS3EuzT85S3N/kT4cuKjdUD/CoDeCnp1z7Vq9dI1oXWZC9mI378cGotvy8y6RbFIO5usmVWP9sN65lVs84alRrZht5WWKvpwyg2en+9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387244; c=relaxed/simple;
	bh=6+JWHRQrsJr9x2ppc7qmssdLhjjYvIA6rjRIQSQBx6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVQID7eQJZjqxo8sp9dIUHYO+ktTQOa4q+ITUuqzv71/qcufSbae/civ574NnNLLN6dTPuerTZifYLDGn4klXqP3G9/ibZAHkyWVuWqvkr0lHTzudcy0YUmbFjQJvM9DCjWigZi4yEFzccEQAg9WXf+FZ5z8GdssqVMmsw5r4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHo058GP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a5903bceffso80258821cf.3;
        Tue, 01 Jul 2025 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387241; x=1751992041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLU+YZa8/2fX3jeZYFHTBUPRRth7cMW0M2466qiW6WY=;
        b=UHo058GPTo46PblhyH+yBeOa6/6EOYMq08FgxXwrZTDvPN8WMkUFFZkSdCfqI31wUX
         4Ca1Gm9B5ixYXmfBPYMpydsN9eM+XiOv8gf0UjFuEB+ARHtYgsjPWGx1gNjfI4eyIEn+
         zB2zrhFoT1zLQac0rbHPDcNYrTruy0BGBPZ0zcBGsAGmqarmeOKzI+gRQ8eFkSLyL/u5
         thsHO3NcSrRZ06JcgYS0SJ4WxVF1x5M3qNc2KU0i3Bezdv/F7XpR9QhMEbTjflMdzKDq
         hPM8za/87Qd+QNmCVPBtwJOzuYSKW0djweLz5zIjgJ0gpo0si1fL2Zj8shGrByQpe9W5
         F+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387241; x=1751992041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLU+YZa8/2fX3jeZYFHTBUPRRth7cMW0M2466qiW6WY=;
        b=nwbg8m9czcm5lRJjqH9V1arCbVJ0TpcYHZUMFhMJ9b+0XPzp242gfJft7avD9YyRx6
         KbvNRmNGPSLEWBMJRf83GMCYgyolrGh/dkmqa/Hju4YinBi6Q4eBGWc/tKrhiSgSA9ou
         rWujLxALTnQePau/ukvssL7es6a6iJIxXU9myXOcGjAm2r+uS6yg706sGdnzusSL08Q6
         FwX1qY4gLy/y4PK1U7l1LqcBqCATPPraJCvNwbgs+xIsIxIXI8nOWOP2LpRo6TzG2UFA
         4BH2B8ahaPqy2v225WBRoA/+cEZIAodzxiGfGwOuJKdJ/H1AKDU/uaOf+EV8qUdWHhYv
         pA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVAq/VZtpNcT+soC4km8RWWCgB+YrSDZQLYdFx5hBlMLp8xoU1Y02/yFmFWUbfrG5vWZsSiKYRjKhe/KAZV@vger.kernel.org, AJvYcCViB4nthllPBbrU07aXl58mYHT7ms3x4EyoX0bWV+BHju0QSehuyzbkhUvbJd+ZuR15zpqLyHIw04KV/6Dx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WEMjCEUZwa9eYwKje3aZlI2jj0yQq90QM9th5/AQujk0sD26
	4tDM8z7Qgcd0pvkRZ2XwYwVLDJrX0HuuCi9GawGuUAten9ssPEm5Po9V
X-Gm-Gg: ASbGncsfDxcfDYX/0Jh3DA9ezRu5byUf9RIyR/1lVyRUXG5m5mpQR4hVLveBwTCaTCs
	q0QCsXqs6Di5Zx7Zgtu3j3J7AoAxc72r8QLcyvXm5+CGtg6GC2Dsn5XptX7zyWpXlti10q7UZYO
	xm/iie+2XSTNDuG6piWt6eHhOzA8i5H7En2g1sonEo5LuHSm/vl4nmYnQwwpR7dVTOM86pQGnS0
	1Bwqm5xDG3m07GuMZD8UkFyf/omUqTZI3ynv2aHrPH2GoLtpmEZRiEdh8PQjaxzCbt7NXYS+TBW
	7i3rao+cLJFg+JdT5aCkazyDhxkJnvbNR6dFUJuuvCwEWozUTkEqjGY+EE1WlnnnwctcOMF++Lx
	IN7rMclxwc2FEelvxm+pC43PoaaYUgPSdbGqznEdxi1DgFW1efuPEvY7yBbhOXDBqwqFPo/TMEG
	98cLmZjEc9
X-Google-Smtp-Source: AGHT+IHjull5pZaZOmzFoWcLMMTVVB/TU/UDIVBB2RfCc3y0hEwP4g/cpzzoaBBku8R/IYqzsSGzTQ==
X-Received: by 2002:ac8:6908:0:b0:4a7:6be7:c0a1 with SMTP id d75a77b69052e-4a7fc9d55e3mr261092331cf.7.1751387241221;
        Tue, 01 Jul 2025 09:27:21 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d530sm78032551cf.61.2025.07.01.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:27:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 01 Jul 2025 12:27:17 -0400
Subject: [PATCH 1/3] rust: xarray: use the prelude
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-xarray-insert-reserve-v1-1-25df2b0d706a@gmail.com>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
In-Reply-To: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751387238; l=2572;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=6+JWHRQrsJr9x2ppc7qmssdLhjjYvIA6rjRIQSQBx6E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDakeJi/FwTTBDnMaXReFFgJmz/pR3aoj2VMRZA241i/MtypqGlmssWkhQAB2n1ll13P3DfXYS1
 BElXBlnovSw0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Using the prelude is customary in the kernel crate.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/xarray.rs | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 75719e7bb491..436faad99c89 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -5,16 +5,15 @@
 //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
 
 use crate::{
-    alloc, bindings, build_assert,
-    error::{Error, Result},
+    alloc,
+    prelude::*,
     types::{ForeignOwnable, NotThreadSafe, Opaque},
 };
-use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
-use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
+use core::{iter, marker::PhantomData, mem, ptr::NonNull};
 
 /// An array which efficiently maps sparse integer indices to owned objects.
 ///
-/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but more efficient when there are
+/// This is similar to a [`Vec<Option<T>>`], but more efficient when there are
 /// holes in the index space, and can be efficiently grown.
 ///
 /// # Invariants
@@ -104,16 +103,23 @@ pub fn new(kind: AllocKind) -> impl PinInit<Self> {
     fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
         let mut index = 0;
 
-        // SAFETY: `self.xa` is always valid by the type invariant.
-        iter::once(unsafe {
-            bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
-        })
-        .chain(iter::from_fn(move || {
+        core::iter::Iterator::chain(
             // SAFETY: `self.xa` is always valid by the type invariant.
-            Some(unsafe {
-                bindings::xa_find_after(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
-            })
-        }))
+            iter::once(unsafe {
+                bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
+            }),
+            iter::from_fn(move || {
+                // SAFETY: `self.xa` is always valid by the type invariant.
+                Some(unsafe {
+                    bindings::xa_find_after(
+                        self.xa.get(),
+                        &mut index,
+                        usize::MAX,
+                        bindings::XA_PRESENT,
+                    )
+                })
+            }),
+        )
         .map_while(|ptr| NonNull::new(ptr.cast()))
     }
 

-- 
2.50.0


