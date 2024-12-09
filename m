Return-Path: <linux-fsdevel+bounces-36731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F799E8C24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9871885FE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE09214A93;
	Mon,  9 Dec 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0wAD4YSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C18215057
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729275; cv=none; b=kLz6lwZImOWfJsn68T8WkgTRaQ/8I7go4rcqkGqF5x0ostXozjQmWGQLJk8fG2L9zR2ndf8fm/BI/tf93w5yFWtvIxFaNE0zj6s9O8b24yfnVDimBMppo4jJobh3ZWxgDm4IQbE6ujAOVH7R7xj+NVeyL6PS72Tko5PTZej8n8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729275; c=relaxed/simple;
	bh=4Wv8XaavpPEkhYsV9Ea5hOf7zaXq9QQ7WtxjCJrCTT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f7EYnjPXoBohwuEqkscY5pjl12CX5Xt2qzsnBkkd/fuD4p8KFecCMMJBQhYqVbLRV71Gn+hoKMZOR7bfmlvHDJ/SPBU69aWJy6DnEh4v926GUtiLVhut8lXAgvj0DAZ+9NUGzTKgwnBkHjWePjQffSyyKm/DNmLFNxCwCyRKQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0wAD4YSC; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385ed79291eso2458017f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733729272; x=1734334072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/S+CUGTEWVFRiC7zZipkdW5Fs9z3rjt6UxWYN0Sev4w=;
        b=0wAD4YSC8D3r+QHTF5Aey6xdT9so0ScTEyxJ4Rf5tWTF2zkrQHQBnP7csvJ3vSkq7A
         fJX7E65J/eTSEhoBSKq/U8STh8AygvaM3ANfcDANf6e8saPOMHjdWVgtqB6HH7X1FRcn
         DnQT2bTw4AQ12g+9PUxQAhhlvDhyMP4Q13feo76gYFq11vgkhxpptoPmy8ITJfOmoedU
         I/GOBz3QuEnFSumG6kFRuX1mlOt061dNaJUuU8tsjF4baCIr9V9cPz9lNt6EQOT77eHv
         ryMXBkFXMabDz+sskq/iomBKRWB+W57W3OiRvglcXECxaqxl9JkKrpiVSAYVsCFrmUiR
         Dk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733729272; x=1734334072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S+CUGTEWVFRiC7zZipkdW5Fs9z3rjt6UxWYN0Sev4w=;
        b=Y3RpTcVbTCuaN/bxEGb+o1czDsFTwLctNUFVIGZoiQ9guDdrtlYlNlX3Qc7GtiOJ+X
         vNEyXHxDRsReO0LZOW1Byy8CFcLneh24zG6J7nGhMEzxaGl4YKCO9nnfwxCYMEI8GVTk
         aPpIw19pcI9lpjdVMfcjT3XSgYMzbh0MZL7Q5KNku78K9WGpH0wZS/eryseuEWnVqQ2d
         Pez2cdQhRRizIBkRblkgwFpRO2dmeVlpwckI/SrBaTDgtfb22rxTB5AphjAtmZ05CY1j
         CeEzgYPWzl+8iHYJst5Q+tIUxd6vXXAjO0Wy90o8Y7dT8C/hSjhH3YURuZyA+OxfDyf1
         K+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCViYWyj4RTbuo3bqO9a4KDd3uKoqD8K0iSflR+Gl+ZjdbdZEwzZjYutckPn4w+aeocJv58mkTiNxqSPaL1R@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9NaQUysIuju3/qhU24iZ48DQzCKHlcOYjmsBiDN7fbtB7fRL
	vnNBF/p8bC2m0cdHZW+V8UTgDZ5HDDh38+e5QwtQ0Y90fZbf+OV3adWwX5xxCw6Lk6qed6jAfE1
	oYNGn6fnS/RNimg==
X-Google-Smtp-Source: AGHT+IF4fXcegEacu/CEqu7D13ezG4G2Jp3/NH06VIcf5I8sePb0lG3RnpXzlOzTCeTlh2Jn2mA5dk9zEBliIBE=
X-Received: from wmbjz10.prod.google.com ([2002:a05:600c:580a:b0:434:a10e:91b5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4d:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-434fe3cc9d8mr1637385e9.12.1733729272035;
 Sun, 08 Dec 2024 23:27:52 -0800 (PST)
Date: Mon, 09 Dec 2024 07:27:46 +0000
In-Reply-To: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4Wv8XaavpPEkhYsV9Ea5hOf7zaXq9QQ7WtxjCJrCTT4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnVpvyrUjxyVkMoE8OuerED5jSUGVlD3r+ZHL01
 HkkyF49nx2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1ab8gAKCRAEWL7uWMY5
 RpcfD/sHaTU4u+iSb8IEIAjxXOQLmHD2uiKdzbATrwH/DrWuC6jpN5wp0szwgcTGjP1fBSkWv9c
 c0x2fDlE2/8QCHdfeaNNVZUi2H9VY489h16ZEJB8TaTiWIh4ot6fO9SMH8nGWbSVQpKTWXIFRcF
 jJNk4YOeeIsenfKem2FvZ0lWoqw0QcuuRDxTOb6ZfahUPb8jSdr1HvBVhQffCNehosVGoNm05/y
 Jkps7qk/1NiQWxMveJmny1NQtf40VqvnoCy2iyflATfT7r3+3SUdEQ1qyW8RVItd8Hn39qkR+SP
 CmnBY53Ei5W0IQ/T0fpprPqDupoWQQw0w7aChO9I4to6Wu6h2pxbTBPI2mNr8Zn3H3KYsQhw/0g
 Wyw3qj0dZc5o4vsz4KUMAVnNUWLjsuy6fMuphGAvG+TPwYBfh4SC+zwytQYUJOwiQpb87R7UoY9
 IXuol4uu1M6gF8sMM8QIoMBc3ws3M9oHimxO2KNOqZM+LqPQDPEe09qPGKHiugVyc//u3dbcxQw
 RnZMZK2u8+FgWDpV0UQYXKl5/Rl4ItTKt+NVWlxV3XuHASmWVjbdfVt9xhVnQBGTCz+2L1FVsBZ
 7kr4GjVbHNVxQmAjErRMfaZl/PlicIM3OguWXEEJg/+owL8A8ubv/hUHJw2GfyN6A0M5yBUF1To 1GBJkGjguSDwFSA==
X-Mailer: b4 0.13.0
Message-ID: <20241209-miscdevice-file-param-v2-1-83ece27e9ff6@google.com>
Subject: [PATCH v2 1/2] rust: miscdevice: access file in fops
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
2.47.1.545.g3c1d2e2a6a-goog


