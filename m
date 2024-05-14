Return-Path: <linux-fsdevel+bounces-19439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9658C56FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD411C22372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7F915886C;
	Tue, 14 May 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzbChkMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C7157A4F;
	Tue, 14 May 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692678; cv=none; b=g1ngXYoWjd7ZhdQW9adUBDyGJDRpMZIthM7qJpanGZnXtu98ZfVeggEBxowTZvQIh+vCZAIdtDUsW3RAMwce06pqX8uHMwma+Vigvn0C/hlevnH9y70Qk/K3FhBgwYCrxRLngB2+DKRJmnkXNMuAx3nlqgIQI6PmhNV4adr0Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692678; c=relaxed/simple;
	bh=8SY2/SxS95If8t/1X4ktPCyr7ZVvSxGtAjJMfTRXBa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quRconoO+XUS6fJwYNAfk4XtRWVhz39pNx/DCtTljALBacbFZ7yVbpjWE74i9PNVUr7d5HIUjw0THPc9pNmSbvQ/BdK4ScQKyn459XJgeoCzXgaj5FGa2K4F+T7sLs7MIdpOHnJgqwEwqe2OhJYfGK7LpFFs9gw8ez34jWSd0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzbChkMt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee0132a6f3so41405355ad.0;
        Tue, 14 May 2024 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692675; x=1716297475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw29FmbYY/ZMdqp5jn6wzGeMh2AecAQ5bSa0KGNtRuc=;
        b=HzbChkMtUYjC59WF2jE9wCl6NW+XMDj06hEl6AQcznhEjLAMlJ9Qq4O2VBzMvOyRCf
         qYL58RLffuKUuBra4zYc0It7mKd2eZaWB1BUCPKvGDeKp5mNMNHGx4W4Jwo2PgUslt6e
         VeUfRv3c6HLiTW+xk3dKis6QfWCgPyGho6jD1EDxb6ioFTSq0htXMIcM0r+9Qe+qFcG4
         NHMTPwW/fv6ncxVTTufDmaOHU26yNN9u79STgksS7jFhd3Tefj6XoO2ANFPsNiK97qmg
         Vfc8PArmjcveCLpn5m3wbLcDIZnbnQ8VD4JFx6k7wr544qIRBDxzjje+T399nBhzv9kn
         FCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692675; x=1716297475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw29FmbYY/ZMdqp5jn6wzGeMh2AecAQ5bSa0KGNtRuc=;
        b=p2dJBbxMiq3z11KpodkOTXhbTr3ZR5/okYeLGKTsnNogN8K5yF+axynonDDMb3u9C/
         hM2tI6Q6pfYYRD1rsSgpz/luqY6Ieramg9zh6xrMlvzvBm7VdyY5XGm3yhWIPFzbSAba
         Xb+bQBw6Mw0o15LdXiOwQj3EhPGHhgzjW6CIRGN5WDPPyhFfxEuIiZ4VeHIujjXooBhU
         7t+hQC6bUL2rpMShiNEg+Eh9gepUQpmFx4o9iqniVGMGxauoRumzJH0yPezKWc1AV+Rb
         vcj/CYmR/Obm6XbidyqnQlbxk57lxP8DN8Mpc8LQJ6WnJJr/6d6tvpfZ+CEOhCEnbHj2
         stHw==
X-Forwarded-Encrypted: i=1; AJvYcCVGjcbhWCakZthuiSuCpuNvNOnWGxGmS4yAwqxvyR5T3PCtCD0ZEn3oLyGq9JSLLZYijEN2Vt7I8FWZXTBOAfILqKyzuZ4WIh3ShqeGmXE3dycBlUQPksmQ6mTQPdOK4mhKot0VRqn2EPFzZCme9LADNHHa1+/A2x2KCnXSgSA0F2OLWJKJKfkFXHK1
X-Gm-Message-State: AOJu0YxHr6bEpls8PjJcfCAr5bVc5XXX5xqncbb3driCGjpPAL/kn/sX
	vOBarqzmeoIIyMx/akZesMjwohIx1ERB99dUW2TAXzAg0cPdHtKh
X-Google-Smtp-Source: AGHT+IFZxNMcBaAuKtiyDp/33ySTFIbK5YEZkhbCNH3USgPgh/uhBfrgBSxSOCZl5HRb3sHbNnEdjw==
X-Received: by 2002:a17:903:245:b0:1e4:4000:a576 with SMTP id d9443c01a7336-1ef43f4cf7cmr141689345ad.43.1715692675632;
        Tue, 14 May 2024 06:17:55 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:55 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/30] rust: fs: add empty address space operations
Date: Tue, 14 May 2024 10:16:58 -0300
Message-Id: <20240514131711.379322-18-wedsonaf@gmail.com>
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

This is in preparation for allowing modules to implement different
address space callbacks, which will be introduced in subsequent patches.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs               |  1 +
 rust/kernel/fs/address_space.rs | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 rust/kernel/fs/address_space.rs

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 20fb6107eb4b..f1c1972fabcf 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -13,6 +13,7 @@
 use macros::{pin_data, pinned_drop};
 use sb::SuperBlock;
 
+pub mod address_space;
 pub mod dentry;
 pub mod file;
 pub mod inode;
diff --git a/rust/kernel/fs/address_space.rs b/rust/kernel/fs/address_space.rs
new file mode 100644
index 000000000000..5b4fcb568f46
--- /dev/null
+++ b/rust/kernel/fs/address_space.rs
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system address spaces.
+//!
+//! This module allows Rust code implement address space operations.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+use super::FileSystem;
+use crate::bindings;
+use core::marker::PhantomData;
+use macros::vtable;
+
+/// Operations implemented by address spaces.
+#[vtable]
+pub trait Operations {
+    /// File system that these operations are compatible with.
+    type FileSystem: FileSystem + ?Sized;
+}
+
+/// Represents address space operations.
+#[allow(dead_code)]
+pub struct Ops<T: FileSystem + ?Sized>(
+    pub(crate) *const bindings::address_space_operations,
+    pub(crate) PhantomData<T>,
+);
+
+impl<T: FileSystem + ?Sized> Ops<T> {
+    /// Creates the address space operations from a type that implements the [`Operations`] trait.
+    pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
+        struct Table<T: Operations + ?Sized>(PhantomData<T>);
+        impl<T: Operations + ?Sized> Table<T> {
+            const TABLE: bindings::address_space_operations = bindings::address_space_operations {
+                writepage: None,
+                read_folio: None,
+                writepages: None,
+                dirty_folio: None,
+                readahead: None,
+                write_begin: None,
+                write_end: None,
+                bmap: None,
+                invalidate_folio: None,
+                release_folio: None,
+                free_folio: None,
+                direct_IO: None,
+                migrate_folio: None,
+                launder_folio: None,
+                is_partially_uptodate: None,
+                is_dirty_writeback: None,
+                error_remove_folio: None,
+                swap_activate: None,
+                swap_deactivate: None,
+                swap_rw: None,
+            };
+        }
+        Self(&Table::<U>::TABLE, PhantomData)
+    }
+}
-- 
2.34.1


