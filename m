Return-Path: <linux-fsdevel+bounces-64584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB0BED73A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 20:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC83AEAFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681326F477;
	Sat, 18 Oct 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAH46SFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A526A08C
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810599; cv=none; b=Uz+4silwD2uDACEaYEs/MIoVLfnxaG6nVzh7Ny4xSAyzb32sS0xhdG8ElTLQQaC07J/WYjZllY20D3Zc2GM0an/s/UClwadroilowL2syxUWNiru46J9tQ/49ktnyLUcKV1nclQFSq5P1s5VQhWuv5IVZr9IYv2GGmKLAGu84RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810599; c=relaxed/simple;
	bh=hMEnshIBBCwKDA9va+C+vgTZ7D8UBppyjlBh7zEwkCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mVhlvKzlHtiSmEqrmF2rJ05aCoOK8Nq9L8uTekiPJ003uiyDwbL6Msi5mctQ7VzjaVHvXO4VE7fYKoSYZvAPlTfSC2nGZRm/jJ8S7uVohAnqqRVf20zgJarNMvkYF4PbM3vExTr0Wh21Ouz6aow/bFBSdyeJE2NlmXn8Zzyuwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAH46SFk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47111dc7bdbso24182475e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810595; x=1761415395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Xp99Syf6solx7Qtcc9CHjBfbP4dER1f+PiKli4U2c=;
        b=rAH46SFknU6g/O+c9FsM0Mynh5Na/VXbCoy0kaqhgmol+EcG+2U5WNgvTbpujC1pdn
         c135DTKP7q9wPejRxg9bkmkFs3aRlL54p4hOFLGmjUg07Hq4TU4wRgfPFJYRvekZPgrT
         T4my87GpFOArojEb1Pa9Dnbvj0Hrz+JnTEjDvYo7ojwSuhcTvPEt+fp3ypiUcdokhQMV
         gn+1evR8OlBXVQG2oA8xg7lr8JnjpzWDiIga1rLJQW6FDO658c3lQafRxG6M/wsb916J
         RK/SQWcLcaOa6+qHfY0ncZ36onzFoSDspShOjIcHyvqBwsGMhB+bIFdS03TXtou+2jZ9
         S+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810595; x=1761415395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Xp99Syf6solx7Qtcc9CHjBfbP4dER1f+PiKli4U2c=;
        b=oUwBKgMiAP8b8eWe7cgsuBuCLkYkl0hPP8mUcaB6jPKnQuMDV2D7/ORjwBu1mdXGYT
         /P3sMVfftf0f4it637a6JKNHX5wMIgL11j8AT+1H67/Z/ZP7smaAQgszc/CBH9vqElB8
         MPxK8WrInvikQ/nG+Eo82+EDlvvH2YOYYrRGd4T/PXR2NRthKpISWNgF1IkNpaeVPRQG
         mjZLP0JPpwalBXxN1Bk+C6ADinqFZJ4BL0iIMl/mDFjY08X4mZPsxN0pWDuHDiWdJzy1
         Vm+njxbSAOhEuG85O7E2ucpAjaNhCzUoiwD5Voh25ntB5yJ0skHKRRk8ei3qCf93cQPW
         RxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpvI8FyOza4C6GJ6EJHn2zuA4yCOXodiNiz4iZ31ypV+qSyPvOOjb6ZzEFwA19vMxmic9NCypm8hRyn6XZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAdhreFYdTIIrG+HcEQ4CpiSpMQveLFN0g4i/MAI64nFZulWN
	eyXX4Ojc0Nco+Ku35303e4Lw7Ajv3eNgbTUKmfqHTHW1XpV5/LnXV7GR28wbjlEgJXrOQtR3A8O
	y5AIhTs4wlfD2BgKavA==
X-Google-Smtp-Source: AGHT+IFD1cfJ8UvE+arlsN4Q/pztwM830HHKQSYiiR0oQA7gs4M/kyYn5nx3HAt5EUs2SUtbpxbRKJSK1nrxs4c=
X-Received: from wmbz7.prod.google.com ([2002:a05:600c:c087:b0:46f:aa50:d700])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474a:b0:46f:b42e:e39c with SMTP id 5b1f17b1804b1-4711794902dmr54802325e9.41.1760810594858;
 Sat, 18 Oct 2025 11:03:14 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:03:12 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180313.3615630-1-aliceryhl@google.com>
Subject: [PATCH v18 13/16] rust: regulator: use `CStr::as_char_ptr`
From: Alice Ryhl <aliceryhl@google.com>
To: tamird@gmail.com
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org, airlied@gmail.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, arve@android.com, 
	axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, broonie@kernel.org, 
	cmllamas@google.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com, 
	lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nm@ti.com, ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	simona@ffwll.ch, surenb@google.com, tkjos@android.com, tmgross@umich.edu, 
	urezki@gmail.com, vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/regulator.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index b55a201e5029..65a4eb096cae 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -84,7 +84,7 @@ pub struct Error<State: RegulatorState> {
 pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
     // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
     // string.
-    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
+    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_char_ptr()) })
 }
 
 /// Same as [`devm_enable`], but calls `devm_regulator_get_enable_optional`
@@ -102,7 +102,9 @@ pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
 pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
     // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
     // string.
-    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
+    to_result(unsafe {
+        bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_char_ptr())
+    })
 }
 
 /// A `struct regulator` abstraction.
@@ -268,7 +270,8 @@ pub fn get_voltage(&self) -> Result<Voltage> {
     fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
         // SAFETY: It is safe to call `regulator_get()`, on a device pointer
         // received from the C code.
-        let inner = from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
+        let inner =
+            from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_char_ptr()) })?;
 
         // SAFETY: We can safely trust `inner` to be a pointer to a valid
         // regulator if `ERR_PTR` was not returned.
-- 
2.51.0.915.g61a8936c21-goog


