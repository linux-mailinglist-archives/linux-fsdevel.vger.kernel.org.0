Return-Path: <linux-fsdevel+bounces-36732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C259E8C25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D74164494
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A5215177;
	Mon,  9 Dec 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eewrZq4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC800215075
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729277; cv=none; b=NEukC7osCSbeU792/0w+EoZoEH4dIMdq2j32ryqJi58dxmuNC3PoS2zB+Dl0jqUleL+fgh14jlmcxFofMP6V7FRqZU2uGNtjutz7HgZOCw1Ne2ZSrGAIZRiySYA+oLSyA1FgIAZrfKfGpHllbJRtPSs1FDyxY0uBRykVXaDxmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729277; c=relaxed/simple;
	bh=FWr1r4ozOgDQM//rzpJtuNZonQdDYCyJwDGoBu/nO3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxyc0mDb6P+dbXEPN7YlH4JH7ptrYo5CJkx/iHXrA6QaRP8pY0uQRhVEEru1qIMKvGWapzEW8VgdMcGqt16iZ0v93HW9gXcOSk9itCMQkcmFRD0tutnDQLekV4ES5DNOa+h+PAsnSYQk3vuB89QUnqbSV+G6f7kGaLpB97uWdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eewrZq4X; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso2228192f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733729274; x=1734334074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XPOCESBsP0vZv1p3EyO3nbPR+4ED4LDct2uLEPo3zM=;
        b=eewrZq4XXgwyfTZV+aY7SaMRFMUDnPAUaUU/GkxMRavWzRpEsOcOc86SlCb+HFGxkn
         1whA5wmUAwhGxzgxtn6gyau/sl8eteN26gCme7DpWv29YXhU2GBajLy2sf0n8AZTw5et
         iQipwDgkI7urJUYFtVKatdjv5pS1s448KIksXdcUFDer2FTygMrRj+dPZFJV/+HEL2TM
         2fsdy6xXs/lJ8H2o+h1iiM3aIrT/iUQwvcD0vah7YMZCv8dzk3BeWUgufRmClk5g7fdx
         neRQabyqwnXDLv3R+le56mDmHZWSBfexD6nQV4HNhzjjCgRXRZSElYooqjil8VKntq7b
         VAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733729274; x=1734334074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XPOCESBsP0vZv1p3EyO3nbPR+4ED4LDct2uLEPo3zM=;
        b=ORQvaSlkPVzxdTE4vXlrS0Dga1+J3clc5/Z4Tlzml+SXQXmijzMrSQyPCEFATC/836
         8PrX9k1s6g4N2gUmnpAhivnkgEPgiH1+JwOJh3FuhXqtiUxj6aLIvyY31O5yVKJHqm2V
         uUvJ8W2xqdFT5oyoxaDoT4/AeyqQ9vhRdij9vc6kE1606/E/iLL5aEXk97a5146NcvA6
         LGMsun7XolK+9JBzNOkEgBdAldMojARQ+AW9Lsuag9PxDHaUhddKsUgXrhiXLfH+iDkt
         wZhFuMw6OQkmSq9zp8a2+T4aQb8sWiaUvKHy6uS6DREqF+Pn0gjcgBnhOSIwvA9dGTcd
         bg/A==
X-Forwarded-Encrypted: i=1; AJvYcCUL7XI/ZKYjjeYTXriSxiGfTxmpjTOS31qhQZNZ29AgbnAV0Ot3Z/VKxxXHrVNi5gt6Jo55u9LM6D154eyi@vger.kernel.org
X-Gm-Message-State: AOJu0YzemO5Pzd2rQXbojwQpOX78jDLUgagXT9pW8zqR4RldBNAAl530
	c21yLq7thns3IJabLH2yFA5f7SmLMOpoTZEM57UpP7Y9xtVVHCK9z0jp7vpdN4TwqSdzHDFFTvT
	UR189O9E1zsjafA==
X-Google-Smtp-Source: AGHT+IE+8n+YNaesbwQgkF7DuZhPvB/qUurkVyjBccXautnlKjRjbmYOfixA2dZ4HsDJ8MCVrCjM+1C8pCdaZw0=
X-Received: from wmbjx11.prod.google.com ([2002:a05:600c:578b:b0:434:a0d3:2d57])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1886:b0:386:32ea:e70d with SMTP id ffacd0b85a97d-38632eae7d6mr5955297f8f.50.1733729274252;
 Sun, 08 Dec 2024 23:27:54 -0800 (PST)
Date: Mon, 09 Dec 2024 07:27:47 +0000
In-Reply-To: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=FWr1r4ozOgDQM//rzpJtuNZonQdDYCyJwDGoBu/nO3g=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnVpvzczpItN+OHuxwE7AplYvqF8F4ygxK71kpY
 +1momvuEi+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1ab8wAKCRAEWL7uWMY5
 Rq80D/0fW3WTcWRksYkWcUvY/qViSnYfrUeKeXWmxAEGqeMdv7TEkHhe/uF8uSrsQOZoXhJvNpk
 2mHN0Ei5SXxfGjXp66h332dEJ6/H5BXQIKJRH5rQkVXH7LoqyiZzykJ2RxTmWz1mDrWQ99D1+9u
 BGvPNAOYM2kRp1FYHlKJXcTJCz1Ay6GCwyq+vC5qSbDyIFemehOFdIW5NfToeZcvop67DbMa/Mv
 70/vrALK/EqMXa4Or0xhYPS8wQKV82vRgwLjLWCt3GQzhN9OGnfw74ymRNlsgXpdJBK2anhExW0
 xeq9RDGLw/g+KI7WGzk07iK2zFQB3zto2KmVZblwZJquHekcD/X6F+k1npnt0AQFP6xmmerQfXh
 R3U7qIDzdyW0KhOz6SCSINL39hzMkihYtY0y3S2Q9iKIKFPOsDYZccN4/SU/s/7Db6hRb9xb+79
 KaHUjM8WWND6V4biwumgn+Wn8d9lnB2uOAVyIrgBf34fUCFSM1o1aDQafg+e2CyNOlEo6jybPq7
 Uvm+oDmSLf/mjnC1x46YAbMGGzPYYmz2pXLxiFrWlO2RfUM8rEZ/DhWTW0NxXnCvJMyKVDYCLJe
 IKWpfxj5s9l79z9S5xpVQT88ol0DADaNNYPQsQ1h7i3bvl9gk5icUYQ4oM5j8aJS7A68Y9uKFEV QLmXlkBJJFxY93w==
X-Mailer: b4 0.13.0
Message-ID: <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
Subject: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice` from fops->open()
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Providing access to the underlying `struct miscdevice` is useful for
various reasons. For example, this allows you access the miscdevice's
internal `struct device` for use with the `dev_*` printing macros.

Note that since the underlying `struct miscdevice` could get freed at
any point after the fops->open() call, only the open call is given
access to it. To print from other calls, they should take a refcount on
the device to keep it alive.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 0cb79676c139..c5af1d5ec4be 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -104,7 +104,7 @@ pub trait MiscDevice {
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
-    fn open(_file: &File) -> Result<Self::Ptr>;
+    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
 
     /// Called when the misc device is released.
     fn release(device: Self::Ptr, _file: &File) {
@@ -190,14 +190,27 @@ impl<T: MiscDevice> VtableHelper<T> {
         return ret;
     }
 
+    // SAFETY: The opwn call of a file can access the private data.
+    let misc_ptr = unsafe { (*file).private_data };
+    // SAFETY: This is a miscdevice, so `misc_open()` set the private data to a pointer to the
+    // associated `struct miscdevice` before calling into this method. Furthermore, `misc_open()`
+    // ensures that the miscdevice can't be unregistered and freed during this call to `fops_open`.
+    let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
+
     // SAFETY:
-    // * The file is valid for the duration of this call.
+    // * The file is valid for the duration of the `T::open` call.
     // * There is no active fdget_pos region on the file on this thread.
-    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
+    let file = unsafe { File::from_raw_file(file) };
+
+    let ptr = match T::open(file, misc) {
         Ok(ptr) => ptr,
         Err(err) => return err.to_errno(),
     };
 
+    // This overwrites the private data from above. It makes sense to not hold on to the misc
+    // pointer since the `struct miscdevice` can get unregistered as soon as we return from this
+    // call, so the misc pointer might be dangling on future file operations.
+    //
     // SAFETY: The open call of a file owns the private data.
     unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
 

-- 
2.47.1.545.g3c1d2e2a6a-goog


