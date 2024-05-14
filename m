Return-Path: <linux-fsdevel+bounces-19435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2791A8C56F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB44E1F233F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B9156649;
	Tue, 14 May 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxj6gUQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AF154BF7;
	Tue, 14 May 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692674; cv=none; b=bobyU1dqXvwt8GqzZFAGq0tBkPSv2y4AV60j+IFuuo+5x8mfSYT/Bkkrv6GkjnxS5FFqULMzvulwtnp3N44qZDM7ZSoPBTJrLwbVDTjayar4WYH0XB1Uup6PFVCcX/MGfbaJUBqO46NJGSJ3dX0TJeng6L3wwkhQVQ/C4PazOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692674; c=relaxed/simple;
	bh=kKoj43kcpdB4g3eGetsZvcZ682MK2Cdc/C4K6JHs0D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kC8dt+/inpeqWj+StXS0Wbh8fiRbeq3egpdP/y3P14EzNum89EupqTubs/SmmvvUEzIoWWnkkBIfjcwaFIt0CNGV9uB+SvC0MS5Cr29/0E9jHp2l6zW7VYPgPjWbQu8A1nwI/ZhIyRGjdcXujcq4zRGLUCRDIIJl7tfPRpcDCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxj6gUQJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so48931195ad.1;
        Tue, 14 May 2024 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692672; x=1716297472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cg/flIhVL4ROGj8221a6AJ0d2eWqZBDXs4XmumwzXA=;
        b=hxj6gUQJb6Tag+KIDmXd974CfLRaMZWfpVcYwpI7oO5uZ6WUVXXFjE1KjqzAVCxK9L
         i7nzgnJkLy0RjCdV/csTcl0y5PcQoJYedLRXe+5w5vwTTRg/AIef+UUXuyyPpZcnVftT
         SICpU5yArnjwyxStrugubwhPlNk9hV+Fsx8f1IYZC2KE1150VWC8KAJCwS914gkOQvE/
         vznN+S1qX3aFw/CbjSQYFb1EzW2D2eJwZ2usqNUtXiTe1h/CiGL1Kf23MUIUsE+RCp2j
         KemWN6028qlZ4pkqn58qV9ec0bdaUJm+wVXWfoJlW+mX3bTq+9FZCDxZKlQakAwZ7uG1
         jbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692672; x=1716297472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cg/flIhVL4ROGj8221a6AJ0d2eWqZBDXs4XmumwzXA=;
        b=EdZUIK/L/rbSEMCo1VI3vafa/35D9hEwtnqMm1wx5mLnPDWn6UDl9/zF4qGbHbBHMq
         iUIWEdiJpDjjYoDZCLxcA7jhRBohXJelN4+72WcwIXa0hd5MV1cEOmtFknpSQZcy8Iqz
         g/E0NFUewehbrE9nj4gO/TXwkSkqSBZXFWBy785SQB9xv/pVEjvUh5Lf2g4d1P5oIv32
         7gig3u8CqB5Ql4+/Svk/Nd5cUvF0J+KZ0m7ANj0dVTjVF7mKamymN7q0mtPIqDCGfY8h
         FVmFuXS5qF9TEWFlmxaZLDg4D+uXm28A+PszhaQOKTWvkDPv4rMrGQ87BYtHoKrFl8yi
         XaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCb0vV3vHOXp8W+8COSXOUfvw9NotIHiPVOMi+mOGjOB67y/wDmT8iqBnx2rAI9mRSjTIIWO8JAeK42ProazHLSc7Zo+7aU0Nl0vgG/GDOrhD0U5nYqZqMzW+My8l9dCRggqveFjglv3HFbIBwSqGDgg4C5Ay5LNdbkdHZjiwcuXOxKxRWtUGCMNey
X-Gm-Message-State: AOJu0Yww6p97ckM1DBAcKRxAZYSZFAnLF6eqiu/FEHE0ug40upgoUECr
	4m1/7nMQHNcfFM6cFiUcyaGx76+hLT+QMTFsdC3VUnNHLiz4mpA1
X-Google-Smtp-Source: AGHT+IHs9v/uAfsfRjkW5AgULW5XdYuVday9qIJmZI1dl3llnLjW9rifR5daSxgoRHhxHneWExKOyw==
X-Received: by 2002:a17:902:76c4:b0:1e4:3909:47c0 with SMTP id d9443c01a7336-1ef4404e0c5mr153954985ad.62.1715692671864;
        Tue, 14 May 2024 06:17:51 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:51 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 13/30] rust: fs: introduce `file::Operations::read`
Date: Tue, 14 May 2024 10:16:54 -0300
Message-Id: <20240514131711.379322-14-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This allows file systems to customise their behaviour when callers want
to read from a file.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs/file.rs    | 35 ++++++++++++++++++++++++++++++++++-
 rust/kernel/user.rs       |  1 -
 samples/rust/rust_rofs.rs |  6 +++++-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 77eb6d230568..2ba456a1eee1 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -12,6 +12,7 @@
     bindings,
     error::{code::*, from_result, Error, Result},
     types::{ARef, AlwaysRefCounted, Locked, Opaque},
+    user,
 };
 use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
 use macros::vtable;
@@ -324,6 +325,15 @@ pub trait Operations {
     /// File system that these operations are compatible with.
     type FileSystem: FileSystem + ?Sized;
 
+    /// Reads data from this file into the caller's buffer.
+    fn read(
+        _file: &File<Self::FileSystem>,
+        _buffer: &mut user::Writer,
+        _offset: &mut Offset,
+    ) -> Result<usize> {
+        Err(EINVAL)
+    }
+
     /// Seeks the file to the given offset.
     fn seek(_file: &File<Self::FileSystem>, _offset: Offset, _whence: Whence) -> Result<Offset> {
         Err(EINVAL)
@@ -356,7 +366,11 @@ impl<T: Operations + ?Sized> Table<T> {
                 } else {
                     None
                 },
-                read: None,
+                read: if T::HAS_READ {
+                    Some(Self::read_callback)
+                } else {
+                    None
+                },
                 write: None,
                 read_iter: None,
                 write_iter: None,
@@ -407,6 +421,25 @@ impl<T: Operations + ?Sized> Table<T> {
                 })
             }
 
+            unsafe extern "C" fn read_callback(
+                file_ptr: *mut bindings::file,
+                ptr: *mut core::ffi::c_char,
+                len: usize,
+                offset: *mut bindings::loff_t,
+            ) -> isize {
+                from_result(|| {
+                    // SAFETY: The C API guarantees that `file` is valid for the duration of the
+                    // callback. Since this callback is specifically for filesystem T, we know `T`
+                    // is the right filesystem.
+                    let file = unsafe { File::from_raw(file_ptr) };
+                    let mut writer = user::Writer::new(ptr, len);
+
+                    // SAFETY: The C API guarantees that `offset` is valid for read and write.
+                    let read = T::read(file, &mut writer, unsafe { &mut *offset })?;
+                    Ok(isize::try_from(read)?)
+                })
+            }
+
             unsafe extern "C" fn read_dir_callback(
                 file_ptr: *mut bindings::file,
                 ctx_ptr: *mut bindings::dir_context,
diff --git a/rust/kernel/user.rs b/rust/kernel/user.rs
index 35a673ebcd58..20fb887f4640 100644
--- a/rust/kernel/user.rs
+++ b/rust/kernel/user.rs
@@ -11,7 +11,6 @@ pub struct Writer {
 }
 
 impl Writer {
-    #[allow(dead_code)]
     pub(crate) fn new(ptr: *mut i8, len: usize) -> Self {
         Self {
             ptr: ptr.cast::<u8>(),
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index abec084360da..f4be5908369c 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -4,7 +4,7 @@
 
 use kernel::fs::{dentry, file, file::File, inode, inode::INode, sb::SuperBlock, Offset};
 use kernel::prelude::*;
-use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either, types::Locked};
+use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either, types::Locked, user};
 
 kernel::module_fs! {
     type: RoFs,
@@ -80,6 +80,10 @@ fn seek(file: &File<Self>, offset: Offset, whence: file::Whence) -> Result<Offse
         file::generic_seek(file, offset, whence)
     }
 
+    fn read(_: &File<Self>, _: &mut user::Writer, _: &mut Offset) -> Result<usize> {
+        Err(EISDIR)
+    }
+
     fn read_dir(
         _file: &File<Self>,
         inode: &Locked<&INode<Self>, inode::ReadSem>,
-- 
2.34.1


