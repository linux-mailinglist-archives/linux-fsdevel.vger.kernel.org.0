Return-Path: <linux-fsdevel+bounces-36902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D69EACB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA167188BA95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114C22332E;
	Tue, 10 Dec 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehDkAlUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9031991B6
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823566; cv=none; b=g4Mm7PKo/0NGWmhde7UMaLtN4GV4lKtobX4oWg3JErgC3gzMNFUMpuP+4SohuIJw5nMl1CG+AMOeZ77xdooiIex2NCn2lq4kzqG3ZJ/LsvlBEE6I91zvjJqG8Bm6gmXXfSTZ+fcq/L1EbcgPz1xBhImsqqarDbDj6SnLQWVzqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823566; c=relaxed/simple;
	bh=lnFOkiQFTcM8+coi/kR1zS+3K3Kh9pdLRZYdj3FBLXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hltWettDsV6e0wtKZKSW9Uylfs+dPrtLfYqbCLb5p09j3d1HuiRggMNPqf7CI6JxzQP09J2pBCQT/2nvH385W3+Zbh8xTw2T3SvLgXt95g9sTJtxSBGFkvAW+r+905Zdb4ph9xg2lC+Uxf4NMC+h7xHBo9o2gydmJZAk7ddW0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehDkAlUV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so3716915e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 01:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733823564; x=1734428364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tOk4o16vH2wNnu69cAh5eCtJYr7jGfSK8UQRzizxqM=;
        b=ehDkAlUVBBEmIxy5Hy9P/t41SAa+BGGRlAtAUw2E/1y6UGdTdzFeqRZD4l7fAp/heO
         6yfOe41hSbUQgioI9rkq9Kucr8zqUpCepMuwGTecgaN6jMso3Gn0ozlbUUIxdKBQgBrp
         i2udg8MrrfWa36ulG4Y+OP2g7NQv07GzEy6jGjPdGz3zpq1RjzHnRgI8EfQgGe+eZDuf
         3Rw12XeIWQ7aMkHBSA7xOOuW3JaKRXSUynz2dBoVhDHMj9+l0nOhOzZhnINz5Ira3lno
         jQpopv1qoRagfJQfVmxzlstI7I+exM9+S5rk0IjL9AXk2ihjsDIP9LdG2wSP4d23nksJ
         +8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823564; x=1734428364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tOk4o16vH2wNnu69cAh5eCtJYr7jGfSK8UQRzizxqM=;
        b=Hl3sWgDAxLzY8PudxwNdZdG3N+Mq7HmjF7IVUoFx4NHJS9zfk/AS6y/vWIAdAlX8fN
         AO/9HZjj+SXflIbggjAyZjKL23fH3tJRMvkIdCAy2XnuTa6lJk0GAeSIzsP08P8Fy2l7
         JDEpOCcnNkuK8H29S4NdCsStLyMZ4Ia/kLNHIsS9lvoMEqI/ulFy+5uNHuHFSQzcBsLD
         2xiS3EzVBJdAich7DIF1dbFB+RvbOt1aFO7D8Nw0xTNrbNeG1ZOlNByNwkkaXjCJGRta
         fzpSyBJWMod7VrXmEclr/1UtcqsbRn9N2PmvO8Bttq2Dvx17d52fHv4soccRgHwi+tnx
         iFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXA54p534J/5BJHhl6vGSCMGujkPt7ZiyFMKyph3SB9ANtXH6+LzIrNiJMcFyOTb7UIl8oBbY9ZPTYA6GFb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BZnwzd5hJiFnaOpMFpxZgKgw0XjUV4sXCJ63Kkwsctb0cbVo
	V08VTNxcwjb3toqJtk8bAVqdo0Z5Z+1I6ibejGeIwH6VLYpGGp/NDbQwYVjOpq2eLxf7HiHF+2y
	w/yzAPbtAzi3N+A==
X-Google-Smtp-Source: AGHT+IEQH+bBoeURPhgYuV58AQQWr0dKwAWYHgfBI0gpjuFffFaCPPUpJAjfEuq0+lXKGerWydf7j2auMMI0ZXc=
X-Received: from wmhf25.prod.google.com ([2002:a7b:cc19:0:b0:431:1903:8a3e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1868:b0:385:fd24:3317 with SMTP id ffacd0b85a97d-386453cf868mr3887389f8f.1.1733823563891;
 Tue, 10 Dec 2024 01:39:23 -0800 (PST)
Date: Tue, 10 Dec 2024 09:39:02 +0000
In-Reply-To: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+0BkFqw5a7yRTc6C9JLr0Z5W0YYOHlF+girdQwg1HnE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWAxC4+A+/FbfX/LfWzds/ch9RDXzjjGfkFplH
 pR0KBZZCV2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1gMQgAKCRAEWL7uWMY5
 RroJEACwpp4Qy0ibi5m1SfviuuuUdhfO1BazAv2k4RZvJi6FynNhfs7ZPZrMkEvZjKpsq5hxi6X
 O5WBedQbA+zEQ6SgR/OEkX74rnw4QupKbC1FwHUVVZtDEt4leqtz81IlAKpm8tQzD0W7yNzmMK0
 qJQS60VAwDFOmfI1FruqPwtNnWFuWAYGs1KlADKlpQtJtdEC3IN5Btis+v8iSKgdxtVJdWBylM4
 /4kP8/QzJNMfOPFaQUcNIb1aHLG/3JCCLBKRLb9p82uEloBKapX6/3K/JWyXzZYq5yPUcJCfen2
 ictX8XnnmJJaDbCm+CPzp7Wz0SCioFrnXpOVu9D02mIQBBKEXV7IaCe4Ccqxzqzt+HqnlGoe4wB
 +ZitNdCoWQwOPwlut29o7K7eGnp7uDXRjOF6SN/qgxMndAMb1OtADXsIUvqrKo75p+hP3um3prg
 30gd6nuBwGY/SazLJaAU0aUSTMpXt6AfYwaLdkw0GkE/yugdc0HsPo2u+Y/zaxMuYO1hbHOSYpw
 JP7+7GxjCIePBaYN2MOccaZFhmFOndv2CXZvii83vbhEasCbfsz/6fxbp1FnUC0FzIoxM5IPKOR
 pyNzNkq1poiOBO0kNIqsc2Vf9f3xqmtt36fVbfkg+VJ0mxZlJq/EhTnsqN4tjgYk/Wp7umSlsX1 VotSHlh+iAxfs6w==
X-Mailer: b4 0.13.0
Message-ID: <20241210-miscdevice-file-param-v3-3-b2a79b666dc5@google.com>
Subject: [PATCH v3 3/3] rust: miscdevice: Provide accessor to pull out miscdevice::this_device
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Lee Jones <lee@kernel.org>

There are situations where a pointer to a `struct device` will become
necessary (e.g. for calling into dev_*() functions).  This accessor
allows callers to pull this out from the `struct miscdevice`.

Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 75a9d26c8001..20895e809607 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -10,6 +10,7 @@
 
 use crate::{
     bindings,
+    device::Device,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     fs::File,
     prelude::*,
@@ -85,6 +86,16 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
     pub fn as_raw(&self) -> *mut bindings::miscdevice {
         self.inner.get()
     }
+
+    /// Access the `this_device` field.
+    pub fn device(&self) -> &Device {
+        // SAFETY: This can only be called after a successful register(), which always
+        // initialises `this_device` with a valid device. Furthermore, the signature of this
+        // function tells the borrow-checker that the `&Device` reference must not outlive the
+        // `&MiscDeviceRegistration<T>` used to obtain it, so the last use of the reference must be
+        // before the underlying `struct miscdevice` is destroyed.
+        unsafe { Device::as_ref((*self.as_raw()).this_device) }
+    }
 }
 
 #[pinned_drop]

-- 
2.47.1.613.gc27f4b7a9f-goog


