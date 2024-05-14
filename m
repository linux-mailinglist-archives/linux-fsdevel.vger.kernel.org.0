Return-Path: <linux-fsdevel+bounces-19434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32078C56F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771271F22CC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1E155393;
	Tue, 14 May 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4P4ewg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546D154440;
	Tue, 14 May 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692673; cv=none; b=I+l+GOnilySu2qIISU9rU62jxPxGiiVBjq/tBzqv2aavxJ0KLM6zBIYuCZw4wLd/r+StGvEWtv/wOvGG9drv+LFhqm6nW9tESir8qqw4i+BpQAk7zEWllUSaRGVVuDXjigCEZwPX678uvfQT5Ji1DO2iskoLC4t4X49XlKr/ggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692673; c=relaxed/simple;
	bh=wuB3It+TBAp7wnBu5M8JzEodoSWd6CPbneTQkHAhkdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBxuLhqmcMh+6cDAXnbZmyKiLdY/ZSKBmYb9FZhIghRgvJxEWHrQ1oKdrCjAiVx4KwEi8a3cyNzEajPlM/7kHlqKt9uaFCPLx+CBUO+LPw0HoIWss69SCozzOEmvkUIgk0WZNkTvZ1rkWb9mEsMRd9Ac6Q4pwjEBGYzZF/GO4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4P4ewg+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec4b2400b6so46104505ad.3;
        Tue, 14 May 2024 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692671; x=1716297471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+bYrCazLpxO9BHsH1eQHGRSngtjj3DrEG5TYkqZ9Eg=;
        b=Y4P4ewg+1CdWqJpkxhliNdEt/nv485OtRLBsPBC3J16Q9rJ8u0VsaVSk9JPJfkguZn
         sirU5/hCzlaPzzrWlEQOGXXxQXv+YxwabB0pHnFZ9z8SpsRIgBTSSfv9s2oeiPTqGYAE
         rwErYy+fS95yZKvpjkiJKvKGPeP+dKGdpVEZFPRngGENq7bNQSNPnxqmDHez1VQWEc6m
         KdYIU8mlf+nPP9c2nYYvRccmcgfJZ8IQ6/Lf/9Ysh3KiHvCRbOrG5FFGwjCSrSuGpYNy
         rrgSBC9E3FuvVZpeYAYJS8kDmuKB5BFrEA/JXYTke0Q2tNGP7flJbtNWwPzBs1+rsDIB
         dzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692671; x=1716297471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+bYrCazLpxO9BHsH1eQHGRSngtjj3DrEG5TYkqZ9Eg=;
        b=V81dODsNLYE63Dtb1ibAx2mw58BWluyVesrbGqW6rYMYwqTJVan1B30M/1CUF95PxL
         hduWHPxTFz4jjqx94egqihtIDZd8TgUqhqXHReKkWAwA6weDSlxtNMf8gHcsXFSCGnIs
         gfEjT4yh1WK4ND7aSmdJY1+UrATerKxhDJVOCHN8XirsDARYN1I6AFBVnPP/Hjr9XQ+N
         S6P3s9dkw0TZu1ksDCcK/jeTzLetA6enDY7n5vKNN10qhvxK1iBi+DK+8tKUsUA7K46S
         PuRYuEmBDcI0iA7ZOnuWW+vwk7Xg1gXykQjEI1Hx5OSlGA91HqACw/I32GfuzSNsx4uE
         nSfg==
X-Forwarded-Encrypted: i=1; AJvYcCXGEBZx+6UtadFtMTutaGrSkPaXxwZ1Ci2cw7JSxLqz5qXwFel888kkIt06rUZRPUJX+izwJLht2aPreD5RueUqMi+79fEppiCfnzz+rQjg2GDNdrFuP2B/StVEJlSv0r91KGSXEgkCWNjuTfeAzWwlqC1jXHQZRMHcFbJRPPvbpSo90xhZN+rkXR+N
X-Gm-Message-State: AOJu0Yys4kBrsS21PGTcpUGbYJbc0/xq0LKMsVrVmLb0V2BV1GJNjQnj
	rchJzzx04BqX8Y16v5Wvp5hCW9bpGQ07gGxNn5yERdq41Ik4g2NC
X-Google-Smtp-Source: AGHT+IEuUtcs7ZCUJg+RWNBMdj2mRL3TnlznFWMlAE2CI2Rq0C6LUGI6l8XrGMrJgbIgQVugTU8ZnQ==
X-Received: by 2002:a17:903:228f:b0:1eb:152a:5a6e with SMTP id d9443c01a7336-1ef43c0c9b5mr170815675ad.3.1715692670896;
        Tue, 14 May 2024 06:17:50 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:50 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/30] rust: fs: introduce `file::Operations::seek`
Date: Tue, 14 May 2024 10:16:53 -0300
Message-Id: <20240514131711.379322-13-wedsonaf@gmail.com>
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
to seek to a different file location, which may also be used when
reading directory entries.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs/file.rs    | 73 ++++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_rofs.rs |  6 +++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 6d61723f440d..77eb6d230568 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -270,12 +270,65 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
     }
 }
 
+/// Indicates how to interpret the `offset` argument in [`Operations::seek`].
+#[repr(u32)]
+pub enum Whence {
+    /// `offset` bytes from the start of the file.
+    Set = bindings::SEEK_SET,
+
+    /// `offset` bytes from the end of the file.
+    End = bindings::SEEK_END,
+
+    /// `offset` bytes from the current location.
+    Cur = bindings::SEEK_CUR,
+
+    /// The next location greater than or equal to `offset` that contains data.
+    Data = bindings::SEEK_DATA,
+
+    /// The next location greater than or equal to `offset` that contains a hole.
+    Hole = bindings::SEEK_HOLE,
+}
+
+impl TryFrom<i32> for Whence {
+    type Error = crate::error::Error;
+
+    fn try_from(v: i32) -> Result<Self> {
+        match v {
+            v if v == Self::Set as i32 => Ok(Self::Set),
+            v if v == Self::End as i32 => Ok(Self::End),
+            v if v == Self::Cur as i32 => Ok(Self::Cur),
+            v if v == Self::Data as i32 => Ok(Self::Data),
+            v if v == Self::Hole as i32 => Ok(Self::Hole),
+            _ => Err(EDOM),
+        }
+    }
+}
+
+/// Generic implementation of [`Operations::seek`].
+pub fn generic_seek(
+    file: &File<impl FileSystem + ?Sized>,
+    offset: Offset,
+    whence: Whence,
+) -> Result<Offset> {
+    let n = unsafe { bindings::generic_file_llseek(file.0.get(), offset, whence as i32) };
+    if n < 0 {
+        Err(Error::from_errno(n.try_into()?))
+    } else {
+        Ok(n)
+    }
+}
+
 /// Operations implemented by files.
 #[vtable]
 pub trait Operations {
     /// File system that these operations are compatible with.
     type FileSystem: FileSystem + ?Sized;
 
+    /// Seeks the file to the given offset.
+    fn seek(_file: &File<Self::FileSystem>, _offset: Offset, _whence: Whence) -> Result<Offset> {
+        Err(EINVAL)
+    }
+
     /// Reads directory entries from directory files.
     ///
     /// [`DirEmitter::pos`] holds the current position of the directory reader.
@@ -298,7 +351,11 @@ pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
         impl<T: Operations + ?Sized> Table<T> {
             const TABLE: bindings::file_operations = bindings::file_operations {
                 owner: ptr::null_mut(),
-                llseek: None,
+                llseek: if T::HAS_SEEK {
+                    Some(Self::seek_callback)
+                } else {
+                    None
+                },
                 read: None,
                 write: None,
                 read_iter: None,
@@ -336,6 +393,20 @@ impl<T: Operations + ?Sized> Table<T> {
                 uring_cmd_iopoll: None,
             };
 
+            unsafe extern "C" fn seek_callback(
+                file_ptr: *mut bindings::file,
+                offset: bindings::loff_t,
+                whence: i32,
+            ) -> bindings::loff_t {
+                from_result(|| {
+                    // SAFETY: The C API guarantees that `file` is valid for the duration of the
+                    // callback. Since this callback is specifically for filesystem T, we know `T`
+                    // is the right filesystem.
+                    let file = unsafe { File::from_raw(file_ptr) };
+                    T::seek(file, offset, whence.try_into()?)
+                })
+            }
+
             unsafe extern "C" fn read_dir_callback(
                 file_ptr: *mut bindings::file,
                 ctx_ptr: *mut bindings::dir_context,
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 9da01346d8f8..abec084360da 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,7 +2,7 @@
 
 //! Rust read-only file system sample.
 
-use kernel::fs::{dentry, file, file::File, inode, inode::INode, sb::SuperBlock};
+use kernel::fs::{dentry, file, file::File, inode, inode::INode, sb::SuperBlock, Offset};
 use kernel::prelude::*;
 use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either, types::Locked};
 
@@ -76,6 +76,10 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
 impl file::Operations for RoFs {
     type FileSystem = Self;
 
+    fn seek(file: &File<Self>, offset: Offset, whence: file::Whence) -> Result<Offset> {
+        file::generic_seek(file, offset, whence)
+    }
+
     fn read_dir(
         _file: &File<Self>,
         inode: &Locked<&INode<Self>, inode::ReadSem>,
-- 
2.34.1


