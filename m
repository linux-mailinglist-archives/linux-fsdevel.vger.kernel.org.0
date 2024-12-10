Return-Path: <linux-fsdevel+bounces-36900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9E9EACAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEBE188540C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A8223E8C;
	Tue, 10 Dec 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5x6Bsd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1B22332D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823563; cv=none; b=OmNujAlQazvi+wDrf83ihv436auz5MGaSUZZME473VnuvNH+Y3KR7esdYKwSG8r4A6IljYNQS9VVcpPI1UWLZ00ZLggt30jc5nP+ArOh+5bC+HTNTeb7GMMiXJ3YEzsq024+3SmmUf3CheQS1+MQzlTQEVtHONQtbF8QP5PN6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823563; c=relaxed/simple;
	bh=aek/y/cbvMTTZ9r/rORZzJl2SZOCrcfNQ8ty0c60zNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aDQV3oRT1b2cW7Vk/U2b99SfrqolY0DEfUgM+kumrQN09sCutAozkKhvGtL1xrPA006FQVAD5McpNhX79FpeK+H3nnmbeqlGjhvpSTG4YceMwHBR94S0Le5TsAzAah4yOkKe7q0by/rw7ONmHNcyW2WXWwkJh9bpQ2TBoNsOVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5x6Bsd7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434ed7f596aso23765225e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 01:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733823559; x=1734428359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kWaVy45L0tBSJtf9uYr4OfEOAz7jglrJk5DHXJ8wYs=;
        b=p5x6Bsd7FIFan08ers5gnAoYLzMrAhPEOIvQFiskbLZxDXWfuzYhWY42cogynbUzLb
         0Qyt+vzOlC+lHq6lPja+TTFsTLiQuMp0RtMZTwjzb2EmU5iCNaJ1WoiPHCTyWh5uorG/
         5prSbbYETswWzG/pBIhNJFlZRwUVE1tprwjxKfz/fiwAmCAUPwLIhrTD9d3pdxehhv/O
         A9Av19QcQnQvmsquBozkVidQC27dGC4B3WJGeaeZMrM8AzKHVtbUMAiJzFWEHZmtmuK3
         7s04Zt+ChXFHVbxvmHa/CZIdETBtlxWjjyZVSX+QGkpVIcZNvr0zYT2zgUo2T09vvY8a
         ESXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823559; x=1734428359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kWaVy45L0tBSJtf9uYr4OfEOAz7jglrJk5DHXJ8wYs=;
        b=t/khRpBjk9Fj0H9fW+ii0ITAHX14m8akrkMhqKUiixJ8QrfCFyNmhuFky6Eb22/nz2
         lwOG3bhnSqMDhXIdxNFH6qh2X7Rn8LYoPubyc4C0YdM5pzuCZvdIqf0AU5pxrndr+/Fv
         aT7YemSeR641dU+fRDzczikWzv14rLTmRvQMy2emLaQir3sgIdRFQ0aNiMPJhJwHsCBz
         E0QJHOHr4uTTPEwV313LA03Lwa5tm9I0FqguhgKgP28z+vwOFe76WYCUhflnMzGTsdJy
         4ib8VjhdUx6Ql8PaYcYrGfEVa7UomXLQO08ON7THK7++QYx7zRibnQNnunX4yuUlT7F8
         fYkA==
X-Forwarded-Encrypted: i=1; AJvYcCWItkiBU5JOJq9eWvV3suNnBCZys0OCMC7jL5yFb+5mdjAOvhaYkKYla+FxbVhjPu2+Q3zINbcX5jWN8bnO@vger.kernel.org
X-Gm-Message-State: AOJu0Yykgz/suaIkzmo6N8livk8St/qHXoeVxcfMN1xvvFCLdfhErY27
	KGrd+t+fIF8ryFvp+jECXE8om95G60/gjV1KLN0wmfqOq2vaxlbWpGXWK140Wmfz4S1BTrtpVdU
	D8A3eciJg/FKjMQ==
X-Google-Smtp-Source: AGHT+IFW3BnNsQzFJv9xXvweoZrl0STZsGsb/9OZ/j7ipAtnEX4zMq/6qndxSYkuWRRnQB92Kkbw3FDvNH4rdQI=
X-Received: from wmcu17.prod.google.com ([2002:a7b:c051:0:b0:434:9de6:413a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:358a:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-434fff500a4mr35015645e9.15.1733823559619;
 Tue, 10 Dec 2024 01:39:19 -0800 (PST)
Date: Tue, 10 Dec 2024 09:39:00 +0000
In-Reply-To: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=aek/y/cbvMTTZ9r/rORZzJl2SZOCrcfNQ8ty0c60zNo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWAxBrZpLxFs/Jyz7wOv9uc43/vuu33Sa3L2w0
 lKlxRSDAA2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1gMQQAKCRAEWL7uWMY5
 RgseD/9CLIBbvbxAG4DKD7RUsA9cRKhZzhKtiqV9EROvRgA/QuTQDhpYFU3SxObTfD3t2C37uOz
 2eHoWKIrE/0BVrnxyGbBsgnjNkikyB2EFdLJW4+Gcyl814mkSqDfluYyzKu6nUy8pbjDU/MVBLJ
 kn21x1dTIdpz6i9K507CKUW484Y3anF4drN7KGp/EpQGyY8n6VIZryB984Ex5Ab1yN7dfUFPpTk
 xIA2HlAF6RIYzVgAMGNWEhv3PssvsWX20ILGSS97RRWk5SMttfVcUnJUyhrGmDSs5XNtyFXBY3s
 JPyO7tjLwusevDOaORDhHxRSQM1dbLKK0loFifShzr2afGsD4DGxH5IFaCFwgbePs8a+wKJIk2s
 QyHDmV5HZ7EpryN0tGQwFCwSyvSaTA6s6O67EDyDmFxALamQM6zxM1miclSUwJFs6bX5HsHGMaF
 STljKqPqsi/A0509wWGSj+8PidpAxpdv/mpiY1CsDN0TmRmbyGN5WxHXLowhDJHTWsnDL/Po1kq
 8+ZYBZj1lJUKJsud4on4eluYXRe3isXw8MadI9KhYRcilP9yDIuburyP33/rAibJA9v2qsk+xQh
 0CPO17bhwSWgpky68xu5EooZaWX435c6qsBLJ5HbyuxX1DmuRBw3FIGxRcIRkCl1zaoyEHYYoG4 U6SV6eK0Lw6DrJQ==
X-Mailer: b4 0.13.0
Message-ID: <20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com>
Subject: [PATCH v3 1/3] rust: miscdevice: access file in fops
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

This allows fops to access information about the underlying struct file
for the miscdevice. For example, the Binder driver needs to inspect the
O_NONBLOCK flag inside the fops->ioctl() hook.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 7e2a79b3ae26..0cb79676c139 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,6 +11,7 @@
 use crate::{
     bindings,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    fs::File,
     prelude::*,
     str::CStr,
     types::{ForeignOwnable, Opaque},
@@ -103,10 +104,10 @@ pub trait MiscDevice {
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
-    fn open() -> Result<Self::Ptr>;
+    fn open(_file: &File) -> Result<Self::Ptr>;
 
     /// Called when the misc device is released.
-    fn release(device: Self::Ptr) {
+    fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
@@ -117,6 +118,7 @@ fn release(device: Self::Ptr) {
     /// [`kernel::ioctl`]: mod@crate::ioctl
     fn ioctl(
         _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
         _cmd: u32,
         _arg: usize,
     ) -> Result<isize> {
@@ -133,6 +135,7 @@ fn ioctl(
     #[cfg(CONFIG_COMPAT)]
     fn compat_ioctl(
         _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
         _cmd: u32,
         _arg: usize,
     ) -> Result<isize> {
@@ -187,7 +190,10 @@ impl<T: MiscDevice> VtableHelper<T> {
         return ret;
     }
 
-    let ptr = match T::open() {
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
         Ok(ptr) => ptr,
         Err(err) => return err.to_errno(),
     };
@@ -211,7 +217,10 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: The release call of a file owns the private data.
     let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
 
-    T::release(ptr);
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    T::release(ptr, unsafe { File::from_raw_file(file) });
 
     0
 }
@@ -229,7 +238,12 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
-    match T::ioctl(device, cmd, arg as usize) {
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::ioctl(device, file, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
         Err(err) => err.to_errno() as c_long,
     }
@@ -249,7 +263,12 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
-    match T::compat_ioctl(device, cmd, arg as usize) {
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::compat_ioctl(device, file, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
         Err(err) => err.to_errno() as c_long,
     }

-- 
2.47.1.613.gc27f4b7a9f-goog


