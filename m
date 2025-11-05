Return-Path: <linux-fsdevel+bounces-67016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE6C3377F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7548E34E5C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993E23EAAE;
	Wed,  5 Nov 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEIdETn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC90EEAB;
	Wed,  5 Nov 2025 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302239; cv=none; b=k3vrLfW2ADebaXsjL9oVTYMnjtzcLilr8m0BrzJwZP9O1HxoJylz2d6HxWiXIav1/PWsQvJgKfBuDu6DYYzHSrgWoOqhrxiyjh3oNHFhJUT7Z+mJZA92WeSbil7vQh1ECntAPSK6kIe4cRNoGtvDuTSSSRrKpluw3B4SCE5tawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302239; c=relaxed/simple;
	bh=SLcLuPJ+Vldp+rsvYh7VyFvQUhrfwPtge3/Zqv9TR9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCdSI/6MxMNNQJO5IurITmgxzhWmMP6XWnw4ebIZ8HcUUQWdNedfisoCG0WYqPrO7cj7oaPoPXC4IWGfxzOFHlN72/CUjbKsaCsP0XYl7E/RXBqDP11pYVI5l33oiD2z1j6jdvcS5t1dANCw1Qwv7lhsEMK1+VnT+Dz/jIPGF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEIdETn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7EEC116B1;
	Wed,  5 Nov 2025 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302239;
	bh=SLcLuPJ+Vldp+rsvYh7VyFvQUhrfwPtge3/Zqv9TR9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEIdETn6jCQUoX5yqtT+s0JhTbHNhDpDUZrYcbxdEqk417vTT5i//9NXGo+b07/+6
	 XVzGEddIlgOXO7dmwEXYpafTn3ckqwQ8E6zzClpHdJ7FJTbn7Gjbg1hflsErzhNU3T
	 jp8kvDn3P21V0tiKe7bq9BccbnWiI6atIS80nDAtYAF7r3sm0eaWQkTaiPselHf9tY
	 jQB/GvzrIM4s8mMhjqkOEvtsgpCVkEc7twB3z2nS6KqGPWDF7cy/aOCcv6gh7k6g2f
	 xXrbni1jWz1xfpb4xxhNCaoF4DRf6klk7uyRmJ0lwbIE76Fh3RUbk1SaK0g5oMQ8ZO
	 9bU+sKszfUU0w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/3] rust fs: kiocb: take advantage from file::Offset
Date: Wed,  5 Nov 2025 01:22:49 +0100
Message-ID: <20251105002346.53119-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105002346.53119-1-dakr@kernel.org>
References: <20251105002346.53119-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of file::Offset, now that we have a dedicated type for it.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/fs/kiocb.rs          |  9 ++++++---
 samples/rust/rust_misc_device.rs | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/fs/kiocb.rs b/rust/kernel/fs/kiocb.rs
index 84c936cd69b0..3159b9ac2bf6 100644
--- a/rust/kernel/fs/kiocb.rs
+++ b/rust/kernel/fs/kiocb.rs
@@ -8,7 +8,10 @@
 
 use core::marker::PhantomData;
 use core::ptr::NonNull;
-use kernel::types::ForeignOwnable;
+use kernel::{
+    fs::file,
+    types::ForeignOwnable, //
+};
 
 /// Wrapper for the kernel's `struct kiocb`.
 ///
@@ -61,8 +64,8 @@ pub fn ki_pos(&self) -> i64 {
     }
 
     /// Gets a mutable reference to the `ki_pos` field.
-    pub fn ki_pos_mut(&mut self) -> &mut i64 {
+    pub fn ki_pos_mut(&mut self) -> &mut file::Offset {
         // SAFETY: We have exclusive access to the kiocb, so we can write to `ki_pos`.
-        unsafe { &mut (*self.as_raw()).ki_pos }
+        unsafe { file::Offset::from_raw(&raw mut (*self.as_raw()).ki_pos) }
     }
 }
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index d69bc33dbd99..6a9f59ccf71d 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -100,7 +100,11 @@
 use kernel::{
     c_str,
     device::Device,
-    fs::{File, Kiocb},
+    fs::{
+        file,
+        File,
+        Kiocb, //
+    },
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
     iov::{IovIterDest, IovIterSource},
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
@@ -183,7 +187,7 @@ fn read_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterDest<'_>) -> Resu
 
         let inner = me.inner.lock();
         // Read the buffer contents, taking the file position into account.
-        let read = iov.simple_read_from_buffer(kiocb.ki_pos_mut(), &inner.buffer)?;
+        let read = iov.simple_read_from_buffer(&mut kiocb.ki_pos_mut().0, &inner.buffer)?;
 
         Ok(read)
     }
@@ -199,7 +203,7 @@ fn write_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterSource<'_>) -> R
         let len = iov.copy_from_iter_vec(&mut inner.buffer, GFP_KERNEL)?;
 
         // Set position to zero so that future `read` calls will see the new contents.
-        *kiocb.ki_pos_mut() = 0;
+        *kiocb.ki_pos_mut() = file::Offset::from(0);
 
         Ok(len)
     }
-- 
2.51.2


