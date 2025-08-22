Return-Path: <linux-fsdevel+bounces-58751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE555B3120F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AD31CC731D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556622EE294;
	Fri, 22 Aug 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJ5uOW/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997722ED17D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852178; cv=none; b=sNG2w/ykp7qoqqV1SSseerCfmVUMF0pj29776rx9Z6LpN6MlBVXL9ymGjTwa3B51Og82PgmPAHA7c7ojZo2PzXdahrnqLJEfIQVlPA2UcuPDT9/bfOj21cJ0h52CU3zBrnibl1NbRDUHRAItQqhXmvPVDTIXKbLy+cve6wglGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852178; c=relaxed/simple;
	bh=rB/mZF8xBrMCzSbeYYPQ0DaqjXVp8y/1e3Ssslw3iIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0yXlIPRa4sJdCY28Dhtj/EAB8o1p/hGKQTmLZ3nRXrrtFs2fvpxOZhQeBdIFfQImkmJEN3efrvRh8+nzvAIO4nbZyEqCxqVzdkKinAw6y5gjqOafE/zip4YsNfZ8P+el+JXz3baEGn7YDfRoimTbCoqF6ssY+BG6+fnLTHbDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJ5uOW/T; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c68ee43c76so75971f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852174; x=1756456974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/u4XDf1WVNqmU+JT0FI8dpt88Rxm4l0HCKQQVKeyjc=;
        b=VJ5uOW/TP1Cvi9Enkf1+80K6kfkBZX1+OOVJNSjcqW44TazKoLzBkzc95nP1OD/hoN
         t4M8vfjxKSGxUPg6fOrXtOQaMm+Bb2cWiq7Y331WfhMs7q4fqz8J3/6JOPTItWoGd2Cz
         9PtIhSWQCjo/q3LlOWkOLk92wugG0KUv08/Wu+nSuhW13pqtSESdwyQCRUGwDFJU/s6q
         SmAMP/nqtShPp8WQEzmiBJaCWRGeLWTl932wnDEyITtl5fZKB6KNSQGBeQdnWwLP/IOQ
         6a8YrYaBLfR0AcKtY5szHFXt+3fhNbZeO7yRwU+a6fLrfxr91J5nzOqH5bz4dpGgb0A6
         J5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852174; x=1756456974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/u4XDf1WVNqmU+JT0FI8dpt88Rxm4l0HCKQQVKeyjc=;
        b=c+Hhh+doFt7FvLBGfgb0jccI5pdurcTAbfife2Eq/opEw3DcSy+tbN8Fs79uWr7QtH
         IiVwGdvaXnGiPByGuXjw3Yh1UD6At5HCBmwl7nI15xyMLxcqoD7tswzFHvydlgiUkCfd
         KWH6+xBcp3mBPy2/T2fDdNkg5H5MlZQGR78t7B1FR2Uqd+6I62asXIkxOIUOa/ostYhO
         RKOVNjjFWVxQ2XwjwI0FI7eUHqwSTzzUP1Y5JqnwTOai5HMt66iS62OB4bWvxeNfuPhk
         FGRvEEbl0G9ze3cR0nO/rlln57MV1mTGfN//DfjI7mH8m4cOm6aVVSeQxCvhFRftobsj
         8I9A==
X-Forwarded-Encrypted: i=1; AJvYcCWpLdtTFpjc8jKO9w7skE7o5YhRyvdw0PahFVThevrR1d6o7ZfZQTBudIbdy6qSJZkzuIyY/WkfVgxRfHPE@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVl66/nncVrDK+FVWG7pxYuUh40AE57+fpwV0H0pfBn8sI4Kc
	okuDdQKjRKQXGWDViIFp6iWCtkN5+sSbR56CVLvjQmhcraRz3aeKY6Wwk0hE3dRTvrrOBnCSOpr
	MhJ6jnz36C/P0DggpXA==
X-Google-Smtp-Source: AGHT+IFsvYdHV4/lLRj0b7l8g/4es08yFobDgfpUGx3RVdmcuZme238QYK2UJaceJcGeVU7iLpwV8UZBNenTMvo=
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:459:db77:fc89])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2485:b0:3b7:664a:8416 with SMTP id ffacd0b85a97d-3c5dae06637mr1497131f8f.23.1755852174560;
 Fri, 22 Aug 2025 01:42:54 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:36 +0000
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=bBziUhAZe2zo8uvOtUQGB4HG8Cb4inbaTy33bNyXEno=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqC2GKQ0nWwuudCr7dtkC0pIcAouFTgw+Q0UhT
 L0+6NKp0XqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKgthgAKCRAEWL7uWMY5
 RqF6D/95Phco70OrE20deLCWG0QdG/eE5+5DqPpoBcT+MJq3+9eOOi4AARuy+Cic2AEwQxy2I4Y
 Xts0hr+n8ywXlGL5VNdWQ0CcHYyu3GZQsHZ9jYav1NGxUSiPSey9c4CFOMYGXXLL3I9ZNMj89jn
 CJPsl4w8nNaVgTiELlk90Jv/LCIg6XVCNUl5pvzRQbm3wpMlDheeo4xAGpXuLK5tM2J4C4Sotqz
 N7bZNG/QPWooMk25aGm7V1gYkeAEVrHy4tzXmsPaQesB9a8UGp0sgaiUf0b+NTqhM6k3fX/G17g
 vZqmtEgi9nzO2+v2oBatMrDlwbtXpZg5Vqs7rv2l9yMMbe9XwjPR4I/IIUVSrVZWnVZcBeK3cIg
 PkgUTXqPFM2njh1sNUKnUS6TA6cjWBdnQQDs8rmo4FKcZ6n6LhMnu8Lqy/CcxMZ8m6ZNXAQDpls
 JPO/28dOrkJLNeG76JnIKPRtumnC/oMbjsBe3sRSlY6ycw8XBo8m/XYGCaAYAsGb2y8auRPH6s0
 /aEdeYeeXxPJb1/PVS6zTaBtpAKwxbKJlw1y2j7l/hj5YfU0FqYvY25xSZ1Ni1jEaVMtcN2UgBS
 m4wguwcAqSpBOrARfDb8DtsBsSl36cfz5qw2iv5bqkw4gR6J1RGveIEW87ST/NYTrFtkfLC6pxl 5ESxG4XpnZ2Dh0Q==
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-5-6ce4819c2977@google.com>
Subject: [PATCH v5 5/5] samples: rust_misc_device: Expand the sample to
 support read()ing from userspace
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Lee Jones <lee@kernel.org>

A userland application can now operate on the char device with read() in
order to consume a locally held buffer.  Memory for the buffer is to be
provisioned and the buffer populated in its subsequently provided
write() counterpart.

Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 samples/rust/rust_misc_device.rs | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f754906615b6f89d72b51fa268f6c41..9e4005e337969af764e57a937ae5481d7710cfc9 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -100,8 +100,9 @@
 use kernel::{
     c_str,
     device::Device,
-    fs::File,
+    fs::{File, Kiocb},
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
+    iov::{IovIterDest, IovIterSource},
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
@@ -144,6 +145,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
 struct Inner {
     value: i32,
+    buffer: KVVec<u8>,
 }
 
 #[pin_data(PinnedDrop)]
@@ -165,7 +167,10 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         KBox::try_pin_init(
             try_pin_init! {
                 RustMiscDevice {
-                    inner <- new_mutex!( Inner{ value: 0_i32 } ),
+                    inner <- new_mutex!(Inner {
+                        value: 0_i32,
+                        buffer: KVVec::new(),
+                    }),
                     dev: dev,
                 }
             },
@@ -173,6 +178,33 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         )
     }
 
+    fn read_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterDest<'_>) -> Result<usize> {
+        let me = kiocb.file();
+        dev_info!(me.dev, "Reading from Rust Misc Device Sample\n");
+
+        let inner = me.inner.lock();
+        // Read the buffer contents, taking the file position into account.
+        let read = iov.simple_read_from_buffer(kiocb.ki_pos_mut(), &inner.buffer)?;
+
+        Ok(read)
+    }
+
+    fn write_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterSource<'_>) -> Result<usize> {
+        let me = kiocb.file();
+        dev_info!(me.dev, "Writing to Rust Misc Device Sample\n");
+
+        let mut inner = me.inner.lock();
+
+        // Replace buffer contents.
+        inner.buffer.clear();
+        let len = iov.copy_from_iter_vec(&mut inner.buffer, GFP_KERNEL)?;
+
+        // Set position to zero so that future `read` calls will see the new contents.
+        *kiocb.ki_pos_mut() = 0;
+
+        Ok(len)
+    }
+
     fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


