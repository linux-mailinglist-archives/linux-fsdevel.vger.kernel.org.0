Return-Path: <linux-fsdevel+bounces-19441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD08C5700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69C51F227E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436F158D7E;
	Tue, 14 May 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fks7Bld2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAA1586CF;
	Tue, 14 May 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692680; cv=none; b=Q6bOJCWTZ6t4Co6jLYtvcgfJKmfkPuDVns4T3UUSduXEScUF8p+v4mXeWyQzZ0vIKDZuSX5P5VqBppxCx9ynfq8mVqkAiNEjFcRlplzaR826ly+VuWqiZwuseCskmIW4NNvZ/hRhSxm4MLjpAumC2QOVYwnDxLUSNuZX2TtkMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692680; c=relaxed/simple;
	bh=P1Y29bq9+LcLbOgLeKOnPMmkPqRmbdzZHebQ4PhfnTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzpDLf2g03ZXwO5aFmtO+guGXvLP5PdMYZFv5S5/0dWYnx1Amzdo3xxmAva9wgNkkqKZmMhMvQpxJC051iyzLLCD/J6l53SZgMcc0Ybpuhv4XQiNIThwGVDTZQnY2QNE+U3FFZLTYCeCo0dM9IySBOhB9/YnT9DAh6L0k1PBQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fks7Bld2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so32209515ad.0;
        Tue, 14 May 2024 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692678; x=1716297478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpGDp9fRLrURPLEmIGvXCPdUWcy0HBXB6rrBzMfqs+Y=;
        b=Fks7Bld2S0IPey/E78AtRzrFu9Wse+oU0Y9MiDj53tHw+e7YnzNpaKdTnDNlnM7Ks+
         ZWs0arnuSFw3JiwKlzlp3Q9mgPsrotY1+wV3AMbHJLoDkUfvD6HaHTeOfupiB6Ko0mQ7
         bkSGL+FKJe6gDOWNbYXoFewj3e2og2cCF+qfPdjxkshVSAGhq+v5MG+GdMf/0UDyaq1e
         Igx3SXlqCy2Bpboo0S6LUWefOzRnzD83fq5lu/F3R3Yw5E0c3931ooz599kAAJldmXmf
         sdt09e2AwZLXyVJi45Se6UA5C/LV9r0+AfS4SBsRSX2H3BRbMjGJYFQ1B93nQQtkxisv
         t06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692678; x=1716297478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpGDp9fRLrURPLEmIGvXCPdUWcy0HBXB6rrBzMfqs+Y=;
        b=O6WOA4cwjDbdaLfXZFgOts5RhkR1p7HwesuSdsynsKDzsA55iBXNwBRUPQ7lNq6LOj
         jXEQCW3hrw+v1PrXQNE66aHadtFX+U/Oc5mwNF/edjy3u3/WJM29ReCAL5z5b5BFHfMg
         HoWtbO84iZ+UvLMo3QojHtOBIit+lIFmtmyBngfGKRF0vD8jhp71t6lFTGPVBFKmQghA
         dIkUBil5RTmTjD4CqZL79cJZnHCs1GmT2hpgKdqXrrkiHXMH/TdEdop+aprhswvftrKy
         4n2uObxZWZ4Pi67Rbn5dLk6eq4e3u2likNRHhmgUNvJYoKuEK2RvufiBLk7FowwiLnXV
         JrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPWBvdelvdbdPfzwbEASdLUF6xUttEFIM2fZvm3VYKxrzYJtIHgukiEO6W8x/+ln/zFnMLoAF1YN79Xgzc30/gBMbkXSJKsytGhHfTWvgLRZJiaifkJAldNaFsnfXJLhxhy/g15uG4pWaLBOQEyFsVCtw7sDlmz1h1ZqFCUpntb1V1Y+Ggtan3H6zB
X-Gm-Message-State: AOJu0YwJkmIdBGbSX/3EgSW6aw9fAtAgxlGGp4aGZuDt0lWG9n2w+kQj
	nvuPQawqFM7E+TfJ+ePH+Vy6F8tO9KyRwoRQAKhesvMgYxCBdcFq
X-Google-Smtp-Source: AGHT+IFCD96BUC/8Um46B6V+HDUgD4CYxm17GE5CLu/u4RfVJITffTDQhxIgjjSJsyR3QuP6jH1BuA==
X-Received: by 2002:a17:902:ec83:b0:1e4:1fb8:321f with SMTP id d9443c01a7336-1ef42f7561dmr197098045ad.20.1715692677864;
        Tue, 14 May 2024 06:17:57 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:57 -0700 (PDT)
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
Subject: [RFC PATCH v2 19/30] rust: fs: introduce `FileSystem::read_xattr`
Date: Tue, 14 May 2024 10:17:00 -0300
Message-Id: <20240514131711.379322-20-wedsonaf@gmail.com>
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

Allow Rust file systems to expose xattrs associated with inodes.
`overlayfs` uses an xattr to indicate that a directory is opaque (i.e.,
that lower layers should not be looked up). The planned file systems
need to support opaque directories, so they must be able to implement
this.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/error.rs            |  2 ++
 rust/kernel/fs.rs               | 59 +++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fd22b1eafb1d..2133f95e8be5 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/xattr.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 15628d2fa3b2..f40a2bdf28d4 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -77,6 +77,8 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ENODATA, "No data available.");
+    declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
     declare_err!(ESTALE, "Stale file handle.");
     declare_err!(EUCLEAN, "Structure needs cleaning.");
 }
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index f1c1972fabcf..5b8f9c346767 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -10,6 +10,8 @@
 use crate::types::Opaque;
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
 use core::{ffi, marker::PhantomData, mem::ManuallyDrop, pin::Pin, ptr};
+use dentry::DEntry;
+use inode::INode;
 use macros::{pin_data, pinned_drop};
 use sb::SuperBlock;
 
@@ -46,6 +48,19 @@ pub trait FileSystem {
     /// This is called during initialisation of a superblock after [`FileSystem::fill_super`] has
     /// completed successfully.
     fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>>;
+
+    /// Reads an xattr.
+    ///
+    /// Returns the number of bytes written to `outbuf`. If it is too small, returns the number of
+    /// bytes needs to hold the attribute.
+    fn read_xattr(
+        _dentry: &DEntry<Self>,
+        _inode: &INode<Self>,
+        _name: &CStr,
+        _outbuf: &mut [u8],
+    ) -> Result<usize> {
+        Err(EOPNOTSUPP)
+    }
 }
 
 /// A file system that is unspecified.
@@ -162,6 +177,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             // derived, is valid for write.
             let sb = unsafe { &mut *new_sb.0.get() };
             sb.s_op = &Tables::<T>::SUPER_BLOCK;
+            sb.s_xattr = &Tables::<T>::XATTR_HANDLERS[0];
             sb.s_flags |= bindings::SB_RDONLY;
 
             T::fill_super(new_sb)?;
@@ -214,6 +230,49 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         free_cached_objects: None,
         shutdown: None,
     };
+
+    const XATTR_HANDLERS: [*const bindings::xattr_handler; 2] = [&Self::XATTR_HANDLER, ptr::null()];
+
+    const XATTR_HANDLER: bindings::xattr_handler = bindings::xattr_handler {
+        name: ptr::null(),
+        prefix: crate::c_str!("").as_char_ptr(),
+        flags: 0,
+        list: None,
+        get: Some(Self::xattr_get_callback),
+        set: None,
+    };
+
+    unsafe extern "C" fn xattr_get_callback(
+        _handler: *const bindings::xattr_handler,
+        dentry_ptr: *mut bindings::dentry,
+        inode_ptr: *mut bindings::inode,
+        name: *const ffi::c_char,
+        buffer: *mut ffi::c_void,
+        size: usize,
+    ) -> ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `inode_ptr` is a valid dentry.
+            let dentry = unsafe { DEntry::from_raw(dentry_ptr) };
+
+            // SAFETY: The C API guarantees that `inode_ptr` is a valid inode.
+            let inode = unsafe { INode::from_raw(inode_ptr) };
+
+            // SAFETY: The c API guarantees that `name` is a valid null-terminated string. It
+            // also guarantees that it's valid for the duration of the callback.
+            let name = unsafe { CStr::from_char_ptr(name) };
+
+            let (buf_ptr, size) = if buffer.is_null() {
+                (ptr::NonNull::dangling().as_ptr(), 0)
+            } else {
+                (buffer.cast::<u8>(), size)
+            };
+
+            // SAFETY: The C API guarantees that `buffer` is at least `size` bytes in length.
+            let buf = unsafe { core::slice::from_raw_parts_mut(buf_ptr, size) };
+            let len = T::read_xattr(dentry, inode, name, buf)?;
+            Ok(len.try_into()?)
+        })
+    }
 }
 
 /// Kernel module that exposes a single file system implemented by `T`.
-- 
2.34.1


