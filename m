Return-Path: <linux-fsdevel+bounces-19432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CE8C56EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DCB1C220F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9469154449;
	Tue, 14 May 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VABahaYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0BE14A601;
	Tue, 14 May 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692671; cv=none; b=JbGm5htwgFP9ZEmpyNAwG7qmzvo/e7WxQHq9lJXdxlFhc+aaZAE5jbXCP1dUVrqyvqbFiaW7yazeMhaxilnRfTkRUvz8nKsYUP7ahhSNzDme/j4Vt0YAVF7nH9TPILHjyiEJNE6X29z5xbl9bxxqWGTq1IgL+mlNPZhqA7u7EAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692671; c=relaxed/simple;
	bh=h30CdDcKy1aa9nOwMaEOcIznaigfbz3L1bFiMg+w6P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSbbB7FZr6VFPY5SUtM46q+dlLDPLg+Y4MTbUv/BV75rB/ltB8iImhEqiNbArust9uzMazuwsepMpZXniiu4pyhJSeyS2ohs3T03T71Ffeqd4pIQjZDZGM2vLLWc0KnVBejo+ioucGkTKFJcwIcp+MLsp2P/9J/w/kvlAQBAR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VABahaYF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee5235f5c9so42972365ad.2;
        Tue, 14 May 2024 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692669; x=1716297469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UswTy1g0h8WhpaF1uYYHqxzWfUsMnuzmqG3fJ4x5ZR4=;
        b=VABahaYFQ7nuVgf1tdqMTn/HJ0FPosc+BwUoUk2JrybQVELWa+rPyJI4AePTBR9C1z
         +cjcyXg3RLlnKHSJSJglPIbeszkN/TXF+EC7EZnHxZVQn0MnPSD6Z1K66uh8dY7uZ7K+
         JJiGrM7/vuNfUutpYbj8axRVpiwQ9x6lwRM83KfBT5VOSgur6FXp40Kmfi71zREkOf80
         72sfoEvwQYvuXezUJ4a8A3KWrtrjBO7BMsaKNkPMN/aHoGYK3SHEM6ggEEUsUHLGJyAP
         2CCpO+m+/wCqIYk4osVkDZRuuqmTrFUe6VleTCFTbsnpUyij+KKz73gyqFZMi4+He1pM
         a4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692669; x=1716297469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UswTy1g0h8WhpaF1uYYHqxzWfUsMnuzmqG3fJ4x5ZR4=;
        b=dY1ZHF29hZnXIqbn0ULCF8v56QHaIA5acH8RVCbL/APzO6acovXwDSmSCmBD0j5nxS
         2dPpVZ/o09d5Ax4TBpl9KkNFjQv1v5vN9uUz73AuvP7AQi3tm50T2xr4chMm2rsuuHvW
         avxpPziMnuujn0eI2Wf7YCxt/VaYQN1aVmOtlFvQyfHkbzr41DDEzHeUrINhKBZ1lrNr
         rNQAVb5I6QPfoDgZCoSWcf4G9sl+XLzNR3WORh7rFynaZCIJFoPSuyToF83adcyFrsU7
         Xu5qLx5a/uMkB12ffwE0LbnDDxTbiuRn8FjllSoIpS9cjwGnq4ednHqs4D8ASHyq5WxX
         slPA==
X-Forwarded-Encrypted: i=1; AJvYcCUcTIDrQMZzvDQuBmf8fyIlhL02eXpBp/O5I/ztCDnZ6YS31VAo7erdQPD/fjO6eRpms3+m8zIX7D9lrfZnPq0kKjbEG1g9Fe7C65jfTN0tAKL3FoV4HLSCg4/4qROV/beh0l7H/7LUo4hzZcn17l/o0Gv9FPb4iZRdzEUzIgGSEF96TdULK5ljMvqW
X-Gm-Message-State: AOJu0Yx2sKkxmJ6mn5/b+JVoTRUqV0mH0ZsojV+IpIfwImcyiSwUrlCV
	oOqt4PLzTHmnC2nughZE+OCYOqxTrk4rFTZh3Rrfdyy18FZZfvsu
X-Google-Smtp-Source: AGHT+IGXZ7t2RoJZuqSV7ivH2R4Y+O4hlmvY+r3Qs37Cap83W+F43/fSEwpRoAr96KAI/09AwX/U0w==
X-Received: by 2002:a17:902:bd86:b0:1ea:5aff:c8ce with SMTP id d9443c01a7336-1ef43d2e1cfmr117956635ad.29.1715692669005;
        Tue, 14 May 2024 06:17:49 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/30] rust: fs: add empty file operations
Date: Tue, 14 May 2024 10:16:51 -0300
Message-Id: <20240514131711.379322-11-wedsonaf@gmail.com>
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

This is in preparation for allowing modules to implement different file
callbacks, which will be introduced in subsequent patches.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs/file.rs | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index b8386a396251..67dd3ecf7d98 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -14,6 +14,7 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 use core::{marker::PhantomData, ptr};
+use macros::vtable;
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -268,3 +269,59 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         f.pad("EBADF")
     }
 }
+
+/// Operations implemented by files.
+#[vtable]
+pub trait Operations {
+    /// File system that these operations are compatible with.
+    type FileSystem: FileSystem + ?Sized;
+}
+
+/// Represents file operations.
+#[allow(dead_code)]
+pub struct Ops<T: FileSystem + ?Sized>(pub(crate) *const bindings::file_operations, PhantomData<T>);
+
+impl<T: FileSystem + ?Sized> Ops<T> {
+    /// Creates file operations from a type that implements the [`Operations`] trait.
+    pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
+        struct Table<T: Operations + ?Sized>(PhantomData<T>);
+        impl<T: Operations + ?Sized> Table<T> {
+            const TABLE: bindings::file_operations = bindings::file_operations {
+                owner: ptr::null_mut(),
+                llseek: None,
+                read: None,
+                write: None,
+                read_iter: None,
+                write_iter: None,
+                iopoll: None,
+                iterate_shared: None,
+                poll: None,
+                unlocked_ioctl: None,
+                compat_ioctl: None,
+                mmap: None,
+                mmap_supported_flags: 0,
+                open: None,
+                flush: None,
+                release: None,
+                fsync: None,
+                fasync: None,
+                lock: None,
+                get_unmapped_area: None,
+                check_flags: None,
+                flock: None,
+                splice_write: None,
+                splice_read: None,
+                splice_eof: None,
+                setlease: None,
+                fallocate: None,
+                show_fdinfo: None,
+                copy_file_range: None,
+                remap_file_range: None,
+                fadvise: None,
+                uring_cmd: None,
+                uring_cmd_iopoll: None,
+            };
+        }
+        Self(&Table::<U>::TABLE, PhantomData)
+    }
+}
-- 
2.34.1


