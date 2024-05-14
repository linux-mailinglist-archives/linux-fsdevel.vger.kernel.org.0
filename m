Return-Path: <linux-fsdevel+bounces-19424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D58C56C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A0E1F237EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286FD145354;
	Tue, 14 May 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYOSYhLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C9144D3A;
	Tue, 14 May 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692658; cv=none; b=jIK8Dei5oeY9B/p4bRHnkWhr0nt7lcMoP0XeSwVXx5w7IaJGxaadB4C37/0qh7oFrGkmRzNVXrVJlxfLvRkfpSEOzw7raZAWzaqYUehYgReaLKqrWm7XyTETX24kA/VLUjg0tDuN9WwiPm8vjzfQYTY7zCh/KQUcSWqZwjdBmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692658; c=relaxed/simple;
	bh=FnRY1u4YwwnOW6PD08/fpU/dFshvY9j1Vl1jbm0E9ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaGT7y8obV6ThHrJ6I6Nj1GrREuS5S52F5IfOCUn5cutpO0BW/LRFhtSKBIPfWcEJ0BWA0pCcEye7BY53ocNEN9FYLjqNIPeMGBx+3ukyzZ4zslKCdCcEnx9R0MElgaO89tUU7Z6BnCHau52+RS7/UOHRqDPJSd2CwcOnQqdavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYOSYhLo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec92e355bfso52579165ad.3;
        Tue, 14 May 2024 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692656; x=1716297456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGJsPpk+V4pg7g+WZPwCWfXSyJlMwREYYXFaZU3M6G8=;
        b=RYOSYhLoKJEpE4Df0CLYiu02f0X6POzYBIGjHnzBqaiuoVT5tCMOzRUqfuHd+j9DqH
         ykoT2WNJ8f9CXr21VKrCENsf8XYDntp0Y/piWSCEcizpza2o8El2i8WAuDTMq2YhPoDE
         0xkDZjq+W3FmQrzH55R2N5JQ+MQD16PFSS3sCwyf1rzNhNF05BG1zN36eS/4HbGR5BW5
         IuEcMBMJ7QQgsE4vT5q3wEUjze3lCSp+N7IcSsVD/18FULZAE/Si8HRy1oAhlk2Opqof
         MYqTsoFeNPCE8hJX4oo6LXAVLZYOxCEuApxInqCgOAQgNbGZqmaF+FvhICha6sDuCgG8
         GDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692656; x=1716297456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGJsPpk+V4pg7g+WZPwCWfXSyJlMwREYYXFaZU3M6G8=;
        b=bjfG4ODxqBZtKjRnz5DbdNiv42UAqutgIXqrWsa+HPuI7CX1DRkyDkn5OBCxBendVX
         vX4Lu4vTWyoUGqr77z52Gy/5iZFJ23EyvVeOdeAzZtxjiDrYfu/ODnPQjy+Pprhj2CK0
         TFSebRrHMBBm4y+XU6vSGSX6kU7Ku/JdTGmxhNjVLmQrVjM2m4JVjHQ/53AYJDbZNYKl
         Rn5M/WUxHlo0cUo7a7SGoMLYZIaGpweKlLUNLRH0veJY3xwgEqTXtIBvuDrJ8Jhzm7zD
         /vJTIr7E9M1Q4g1M3YZRbtE5KD0hg+sDRb2TRDPLrbSV6WYpfGLOkpZWNhc1DKbr+8P9
         z0bw==
X-Forwarded-Encrypted: i=1; AJvYcCUnybLwGZtMlOD25okeK8eH0TdH5cUxsExv1t/LcPjMzcFGN1ls9VHZi0EZG0OQOwUBUqIq+AOywIvn1FmbOjezAZaRW3zMeuEZ5THyRAf0ypzfdNnuwsiV66PHY/Dib0uGb9CEECVO49G6FP9njcYEg7fjeMpJuABZ1ZO4pg42tAOmrvQMp17QWyMm
X-Gm-Message-State: AOJu0YycHY3W9kqiUavZPC7FfiOSQJJ091BVtXcp+jprVJoEFD8uZPSz
	o71r2bt8Zp2MMVA3Ku9mKIJ1WVnZ1Li/tyIKcepYwHYRmianCmFu
X-Google-Smtp-Source: AGHT+IGvQohBR+X3oXCSN6bsf4d42+dJ3p18mG6Ty4uUDbTdiA3IVkQ43Vq6nCxoQQUWu4dQl6VUSw==
X-Received: by 2002:a17:902:aa03:b0:1ec:5f64:6e74 with SMTP id d9443c01a7336-1ef43d29b65mr141454895ad.23.1715692656519;
        Tue, 14 May 2024 06:17:36 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:36 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/30] rust: fs: introduce the `module_fs` macro
Date: Tue, 14 May 2024 10:16:43 -0300
Message-Id: <20240514131711.379322-3-wedsonaf@gmail.com>
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

Simplify the declaration of modules that only expose a file system type.
They can now do it using the `module_fs` macro.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index cc1ed7ed2f54..fb7a9b200b85 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -9,7 +9,7 @@
 use crate::error::{code::*, from_result, to_result, Error};
 use crate::types::Opaque;
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
-use core::{ffi, pin::Pin};
+use core::{ffi, marker::PhantomData, pin::Pin};
 use macros::{pin_data, pinned_drop};
 
 /// A file system type.
@@ -73,3 +73,57 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::unregister_filesystem(self.fs.get()) };
     }
 }
+
+/// Kernel module that exposes a single file system implemented by `T`.
+#[pin_data]
+pub struct Module<T: FileSystem + ?Sized> {
+    #[pin]
+    fs_reg: Registration,
+    _p: PhantomData<T>,
+}
+
+impl<T: FileSystem + ?Sized + Sync + Send> crate::InPlaceModule for Module<T> {
+    fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            fs_reg <- Registration::new::<T>(module),
+            _p: PhantomData,
+        })
+    }
+}
+
+/// Declares a kernel module that exposes a single file system.
+///
+/// The `type` argument must be a type which implements the [`FileSystem`] trait. Also accepts
+/// various forms of kernel metadata.
+///
+/// # Examples
+///
+/// ```
+/// # mod module_fs_sample {
+/// use kernel::fs;
+/// use kernel::prelude::*;
+///
+/// kernel::module_fs! {
+///     type: MyFs,
+///     name: "myfs",
+///     author: "Rust for Linux Contributors",
+///     description: "My Rust fs",
+///     license: "GPL",
+/// }
+///
+/// struct MyFs;
+/// impl fs::FileSystem for MyFs {
+///     const NAME: &'static CStr = kernel::c_str!("myfs");
+/// }
+/// # }
+/// ```
+#[macro_export]
+macro_rules! module_fs {
+    (type: $type:ty, $($f:tt)*) => {
+        type ModuleType = $crate::fs::Module<$type>;
+        $crate::macros::module! {
+            type: ModuleType,
+            $($f)*
+        }
+    }
+}
-- 
2.34.1


