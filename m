Return-Path: <linux-fsdevel+bounces-19442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A78C5705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D7D28673E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F715920B;
	Tue, 14 May 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoqW3Kt4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA615887F;
	Tue, 14 May 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692681; cv=none; b=NbqPZdoHQW5dxfXnKp7qCkt98Sq1HrwvbPDe03k4/Y7anyTDHtZFwMsPSAKtDBmO7VYQeCGhSy+eSL1mRi6Apmw1hFoL95UyRb6QbvUca5ho70AxSYx/uXkGpbTxi+dZeuLMszXZ08xzaT8/x96FTJIUrpr3w3l/as95zMX4F+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692681; c=relaxed/simple;
	bh=sbOCEX61ofppF4aNBQ7FMDtOYlb/Aj76VyesYf1uaYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFQukpUi91lV19mkvrV7TicxAj3pT3gTM2qGa/j8sIjg4krldGd9Ne1xfBebAiQKFOAYhdh7QqEi7WOAOvpc3BkMvyvkh82uHzMkySjDGhUyw8zJrxFOiiEiAIiNxfGcbYnFdzyoy7hxCiGN/r+1d3czolklAGFeM0cobq8eiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoqW3Kt4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f082d92864so8597835ad.1;
        Tue, 14 May 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692679; x=1716297479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlWuS83qckqBozbqSeNOt3eZOxNv3j8cNRYJL66TP/4=;
        b=KoqW3Kt4/Vfb5nCBWZLWZZOsPgjZoFn6MPaa/oYEzbFJqo48lkaUfhtl631QH/Tr4p
         aASCCW7qS3/GtlIkF5irktWDm/BKdE4t4aeVkxk31SN9ROV9wkAb3u+r2zSF6ACLggAf
         LDT4VB0/Bjt8v+Jr6kGdkFtkg0rrjtmea2g82WZmOias9UoiW8WiFkjxS7Nz+7zw5P2L
         DOKitWbXISOyC1HzuFWztRsmDeJjoT2XUGFlukgnrTIWLb+9IsdWwJhl/cL/EZygPpcp
         29alaBg0ynXyS60KPPX4AULdlvWRV5GLXFs3AoJiNeZAi1W4xtPzK5CbkLzgwfkmMPBO
         USUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692679; x=1716297479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlWuS83qckqBozbqSeNOt3eZOxNv3j8cNRYJL66TP/4=;
        b=P7wbyxnAKAw6st4uG7bbuQjRuknRt0ANurGUC/TIQC9uHM4ZVEh+2ocqIvZK4gq8gm
         ogmDQRSnUUZ5MOffwrdzy6202Yvbie5hEXjEEgNSwwvqIeSBVs8wWg6aRy1UFtewmc9I
         bq4BMpaiT20kDexq+9SkdjNJ7sjhKMOHMeSap/gEFS0XovZsFipafBjk2bT6QEHwyAHP
         ivNzn3jPVma1tXkZ68PQSbpUDA1kyA9vFBZj+X3uIhcCgYz27YizShRoeTcuQhWPDyEW
         SOfHhEj3qYmQ/smgKCa5pv5UCZA9/Fl/4DrRjkjXWNUMsgSoEOjdWGKsqk7fOcxBpvMl
         k9xg==
X-Forwarded-Encrypted: i=1; AJvYcCV7BRCiei0PUToYDaoFkfFtD2tsQgqHvi8cBrxouwhva97x+at4DEHLc9421cRRVkZVmJzdL7qat0byCQ3IgLurR01YR6Y9lzlirDhA9pQ/xGqyc14q36HBtnD/UVnPNJ9BjYtdKjEu6TynriQSz+OEz+vRrZmqTdnuTnL7sPwWwkUCbVTAuk5NeIRQ
X-Gm-Message-State: AOJu0YxUpMlib3VHKJmzhUWT1Ye+XwyfeZZXGmkb3zbGRoOkL2wMpUQU
	cklJSxu8mgnXLyTVm7jKYUVvLmEbVzkiZBnAJBL7x+5lrQojE2ml
X-Google-Smtp-Source: AGHT+IEauAuZv2HzfNt0arOphxLzv/8JrunpucjwNHMIob3iHZeXW1iAL5fdZ1GlSL+SvlHGAsBncA==
X-Received: by 2002:a17:903:234f:b0:1e5:5c8c:67ec with SMTP id d9443c01a7336-1ef43c0f5d1mr148271385ad.5.1715692679049;
        Tue, 14 May 2024 06:17:59 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 20/30] rust: fs: introduce `FileSystem::statfs`
Date: Tue, 14 May 2024 10:17:01 -0300
Message-Id: <20240514131711.379322-21-wedsonaf@gmail.com>
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

Allow Rust file systems to expose their stats. `overlayfs` requires that
this be implemented by all file systems that are part of an overlay.
The planned file systems need to be overlayed with overlayfs, so they
must be able to implement this.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/error.rs            |  1 +
 rust/kernel/fs.rs               | 47 ++++++++++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2133f95e8be5..f4c7c3951dbe 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/statfs.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xattr.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f40a2bdf28d4..edada157879a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -79,6 +79,7 @@ macro_rules! declare_err {
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
     declare_err!(ENODATA, "No data available.");
     declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
+    declare_err!(ENOSYS, "Invalid system call number.");
     declare_err!(ESTALE, "Stale file handle.");
     declare_err!(EUCLEAN, "Structure needs cleaning.");
 }
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 5b8f9c346767..51de73008857 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -61,6 +61,31 @@ fn read_xattr(
     ) -> Result<usize> {
         Err(EOPNOTSUPP)
     }
+
+    /// Get filesystem statistics.
+    fn statfs(_dentry: &DEntry<Self>) -> Result<Stat> {
+        Err(ENOSYS)
+    }
+}
+
+/// File system stats.
+///
+/// A subset of C's `kstatfs`.
+pub struct Stat {
+    /// Magic number of the file system.
+    pub magic: usize,
+
+    /// The maximum length of a file name.
+    pub namelen: isize,
+
+    /// Block size.
+    pub bsize: isize,
+
+    /// Number of files in the file system.
+    pub files: u64,
+
+    /// Number of blocks in the file system.
+    pub blocks: u64,
 }
 
 /// A file system that is unspecified.
@@ -213,7 +238,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         freeze_fs: None,
         thaw_super: None,
         unfreeze_fs: None,
-        statfs: None,
+        statfs: Some(Self::statfs_callback),
         remount_fs: None,
         umount_begin: None,
         show_options: None,
@@ -231,6 +256,26 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         shutdown: None,
     };
 
+    unsafe extern "C" fn statfs_callback(
+        dentry_ptr: *mut bindings::dentry,
+        buf: *mut bindings::kstatfs,
+    ) -> ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `dentry_ptr` is a valid dentry.
+            let dentry = unsafe { DEntry::from_raw(dentry_ptr) };
+            let s = T::statfs(dentry)?;
+
+            // SAFETY: The C API guarantees that `buf` is valid for read and write.
+            let buf = unsafe { &mut *buf };
+            buf.f_type = s.magic as ffi::c_long;
+            buf.f_namelen = s.namelen as ffi::c_long;
+            buf.f_bsize = s.bsize as ffi::c_long;
+            buf.f_files = s.files;
+            buf.f_blocks = s.blocks;
+            Ok(0)
+        })
+    }
+
     const XATTR_HANDLERS: [*const bindings::xattr_handler; 2] = [&Self::XATTR_HANDLER, ptr::null()];
 
     const XATTR_HANDLER: bindings::xattr_handler = bindings::xattr_handler {
-- 
2.34.1


