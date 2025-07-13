Return-Path: <linux-fsdevel+bounces-54772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42860B030EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566F33A303E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833F827932B;
	Sun, 13 Jul 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K67vPt5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC727702C;
	Sun, 13 Jul 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752408373; cv=none; b=ulAojMrEO5ACHkGquP+WvTBsQyEqPeILrZMtToS3qbc5AGCaqq5BsvBS4bCEvfPDtespJl6pZSeVAUf6niRDn4w6XWUEgquX6O7Xj+bJU3HM8VbFEGOOB6lRjIx38vEcRDgjLb/ltGqFrOna5J84OnMTZCEibF/C5s0SFLdiaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752408373; c=relaxed/simple;
	bh=sMBWADz3OrR1HFnmTQ194V9CuxYDFBofBK/9zDengrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfBmUY0zXJgZ+8PU7txjKMg8FmmJzukRz6uojXBENUE+AinSRuSMPdE3OvyiD2ulFCEkJiFjQjn26gxgEvIDTpK79mAvhktijuaTU5aJf3UyuJEb1avRn5dPVFLUPcyioONND59aN54dtFhYT5nJHvzo7tWfC1f/3hFTLU/B3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K67vPt5S; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a8244e897fso37929891cf.1;
        Sun, 13 Jul 2025 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752408370; x=1753013170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRvk/gKqPp0H+/o0LknBTtFAKaaMNgQuOJT2JRQ+iCI=;
        b=K67vPt5SV7/YsnZOtaXjM/1bahKau3BY6jC2sD5HU5OdsYXdNsKB983+YTcZnDOEXx
         P3O3/UoTy4f5yoMDMBdF04m7gExffFZcDGF+pvnKdfUPeaxTyvy5Um9URRepKjuOZa+R
         28fd4B8eVHjfe4lJX+qWgUgYp2tsBMImNAvSRvozk7qbClyNY0HuZL9xb4F/yUiwri9K
         FaQpJ8WZHuI1lq0s64W+qm/Fs4ctBc8+Tvm62Xw84nrnm4XVKrRNP361UlzUxGPXlGat
         i7xEe4ifaSLZcef8Px0jzAdWTnyqKPw9up1nHVgRXHEOMBj2TgaEmFHD+7+gbLdIcXa/
         5g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752408370; x=1753013170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRvk/gKqPp0H+/o0LknBTtFAKaaMNgQuOJT2JRQ+iCI=;
        b=hAb68MOP5LdR1XBPqg02Q1dWDq4dhUkkK6//OE/7ZGBUZ+hz8oxS+/572eveiiAl5E
         /b9zD5qu0qfBiARRKO8sRMsafr43g0ObUY1Pt6Tja81y+dR8BeIwxjGV5ZerYS25o8Rx
         xyXH5QF2v7KG+t0bVLQtDygskexOakQEnC8IgHOLFI+1ZkXiSPPrwt5CUZQL2VQrivIO
         XE20EmVykYeX+19NedahaR3iPvnm31eSqUVLJVx8jI9FrzE+aHb4F08QxqWvlf+jbtNq
         AWHb4t8jJhmycs+hrsMSDeRVBvcFVONzNJDIQcRy/cFswj+f6+wmCAasObsr/MnLLgk1
         jK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX14FLeNLfbO8jbBMkQSxiNUVfzOaUzgaPx4ai56XikrACmpqv3y/hfiR1L2Af5G43I8tqrkNr6fPl0Rcjs@vger.kernel.org, AJvYcCXLeI90jFOJlJUeQnSrymVCo+K7cn3mA70DxroNxrP3GK4qut2PrYeo+haJLc/2L/Zttu4iNu9sFuABEm4j@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRNAxM/EgCeu/JdKr4525uUDr2QrcB43WI5XGRRdUQBNEnI+J
	zdStU905GzoDU+LLKV2pM+G8uivGpVqy4iuqw4kOi9u15XdUXC1+sgJE
X-Gm-Gg: ASbGncuDc4CfeeUZJmd8R+fPWX2aCK0Fy5mKd3Gsf3PGmFB/c4a9nG/610ZlUiPWkvJ
	mMJLF8q1g4WwXmTeaLUlX3X6Il2aOhOSBfEPto1vlS7JGIxEJ9dhQpk5KIHAMkbaye1a8GQN/7M
	/zslzRor1t7/PSdSepLGW6kTw2p8T+6xb6+k6Hd3AwxfqjmbSy3eA9xaCSQ23pkDSUVK7Yi/Fj7
	pfBdRMTAEksjvVMtcGY+u6vCT8EwcgdSWS/UuxDWyuQHYjzP8CcuDPbnvZbupZLIs86A5u+OW9r
	rCE3HbsJm9LiRQWaar99GhZT710i7Sz1xFg3JijWHnmgnurIFDlPV8zbkA4YGz2Avf13zf95AZp
	BTiBBfPLixuVC/DQYhmqm6Pm0265D9crd/Q==
X-Google-Smtp-Source: AGHT+IFln+GFKH6+++NgYgJ12Wx1R/TBgoLL0Hi3cILhth+wXJLpUugmDirB/WfhdzAEuDcxI/eRzg==
X-Received: by 2002:a05:622a:2a15:b0:4a9:8232:cb24 with SMTP id d75a77b69052e-4aaa5d56063mr127825191cf.7.1752408370190;
        Sun, 13 Jul 2025 05:06:10 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2desm39706261cf.72.2025.07.13.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 05:06:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 13 Jul 2025 08:05:47 -0400
Subject: [PATCH v2 1/3] rust: xarray: use the prelude
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-xarray-insert-reserve-v2-1-b939645808a2@gmail.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
In-Reply-To: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
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
 Tamir Duberstein <tamird@gmail.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752408367; l=2724;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=sMBWADz3OrR1HFnmTQ194V9CuxYDFBofBK/9zDengrM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHGrLq5R05r27Zf9Dflurdmo6aH81ql4hx9/3DsHm3W+cf9P3LMJlhj0mWbqd4nhlzQXua++zi0
 iZe/9wymEjgU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Using the prelude is customary in the kernel crate.

This required disambiguating a call to `Iterator::chain` due to the
presence of `pin_init::Init` which also has a `chain` method.

Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/xarray.rs | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 75719e7bb491..b9f4f2cd8d6a 100644
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
@@ -105,15 +104,22 @@ fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
         let mut index = 0;
 
         // SAFETY: `self.xa` is always valid by the type invariant.
-        iter::once(unsafe {
-            bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
-        })
-        .chain(iter::from_fn(move || {
-            // SAFETY: `self.xa` is always valid by the type invariant.
-            Some(unsafe {
-                bindings::xa_find_after(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
-            })
-        }))
+        iter::Iterator::chain(
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
2.50.1


