Return-Path: <linux-fsdevel+bounces-19436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF408C56F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6C71C219CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AACE15698B;
	Tue, 14 May 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUlh17V4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2501552E3;
	Tue, 14 May 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692675; cv=none; b=VPIimG6F3cx7mZE2ftuah9A2ffddQSw166rgarCbSYiwGZm0bOe+1PmPvC80RI5eVEN6HEzuSIGDw6rswn9vyLiMI0EnWk0MMfQ1Bat6WzDao0GGSup3jHsp3bRREmPWuh+2vrH7BB4FFwOLQwk2foWyMbeherDv8MhmCMGq6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692675; c=relaxed/simple;
	bh=Bsu4aVsU1f2mWSnfl7Emzs4XvgDxaKv2CMGwS96ITvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdgJQ6kTFZBLBFX1m1kr4Vg1QgDw/BP3IRP3HrGAS7E3KBHoGysE1Y3BvVyXPVBm7934boG2WzhqRC1kTGatXgOQYc4y+VPFItGte6DOuJO7Ai8iT+NBRpg8yHynYeiKE83mH8kgiuvIC+/l8pk5E01Od2x9ViYFaYWnWQhKZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUlh17V4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee7963db64so46677245ad.1;
        Tue, 14 May 2024 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692673; x=1716297473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41lZAkvFJI0TX2nT3AaHdmxxznrE9S1HoBUIRdkD6nE=;
        b=RUlh17V4wjRJ1kQSmp0MKdAvpp4G1qSbILV+6ZHUM7uIjixB5PFedlr4w3ujEQE/iq
         9ARQFL80UfpqP1mbaV7XJux1ftFo85jPkjoFGP/msbTzfzMSBZpiVKdSOrPXdaH4chpR
         ntgVEeDTgV4X7i2zWY7+revUhsbhdfM4aYaJdqIfDg5Ib++ANEZeSYrGdN75AT1HAsjh
         6uIbAjrETf5P2Rds6RJpe02ata+/7c3HgBb7E10Emzt4nl4LNsR2DrgJhCK2ojMnLcOR
         dokb5fdN65niHJY0C8otopQJSPfnYlXX0MbM/GUfKkmH3x5rt08jWlrgLQB764QmBUHK
         ux1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692673; x=1716297473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41lZAkvFJI0TX2nT3AaHdmxxznrE9S1HoBUIRdkD6nE=;
        b=fpCQeksSen/SkBpSJuFkvTBKk7F4NGl2UIaoyR5GIh/SmMxN0ZYjqSyWSDYN1kNDoB
         OVhNRzu03DUdMCit9ba8sL21r8ez1MZLk50nJ2UqzyXEQwS3qcWw25uLpqVq952u3oVg
         gIVSQlNaMpH/EUAs6yGg+YyTv2C83aFFZHEPjolnAmPdxxggszqc6sAOhY0lvtK5yrOR
         xfHLRJBypdKm9esbc2ntc2cGwJVpZmCk/7xT44IuCvgzLiYx5efubWPB4cpVOrDYnYaU
         CUHinDXu4IEQ7Ko+vZ+AVvcNKycwhpBgRwh+3gbAdJNxJnpgkysGbN+8ZC0ttlEcV/HX
         lYRw==
X-Forwarded-Encrypted: i=1; AJvYcCW77v0H5eu7YSKqgX5I3G9u1i09SKLh1uHhXsir7d31JdLTvUYoPWfmfc7ryqfkXditBmiOIQtt41R+si2pbSZoEZo/SssTeoqMh1njZQ5ZccAXSfGbqnvI+uAxVwLcfB7ssP1DEbIml9YGNUaohWPLMzzPm9B6nIcr4NDPnqHqwjNhfGztLzLOtlvB
X-Gm-Message-State: AOJu0YwlsO1bt+KUkT6YWVifsk4bjzhbuLFiUlB0DnM+A5n1aibQbEiV
	50Cp8HlLF3VO3AL3W3QxTElgA+Ck/1h+3UM0y+0Yzu5jaK5bxpM7
X-Google-Smtp-Source: AGHT+IHacAzjvn03qQrbcW6J1nRF6deOobtxlsm4HKKcWOwaYTYmM/7tK9YZHCcX+VFKi94xCoRgvQ==
X-Received: by 2002:a17:902:e804:b0:1e6:401a:bd91 with SMTP id d9443c01a7336-1ef440596d5mr156775655ad.57.1715692672772;
        Tue, 14 May 2024 06:17:52 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:52 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/30] rust: fs: add empty inode operations
Date: Tue, 14 May 2024 10:16:55 -0300
Message-Id: <20240514131711.379322-15-wedsonaf@gmail.com>
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

This is in preparation for allowing modules to implement different inode
callbacks, which will be introduced in subsequent patches.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs/inode.rs | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index d84d8d2f7076..3d65b917af0e 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -12,10 +12,18 @@
 use crate::{bindings, block, time::Timespec};
 use core::mem::ManuallyDrop;
 use core::{marker::PhantomData, ptr};
+use macros::vtable;
 
 /// The number of an inode.
 pub type Ino = u64;
 
+/// Operations implemented by inodes.
+#[vtable]
+pub trait Operations {
+    /// File system that these operations are compatible with.
+    type FileSystem: FileSystem + ?Sized;
+}
+
 /// A node (inode) in the file index.
 ///
 /// Wraps the kernel's `struct inode`.
@@ -203,3 +211,43 @@ pub struct Params {
     /// Last access time.
     pub atime: Timespec,
 }
+
+/// Represents inode operations.
+pub struct Ops<T: FileSystem + ?Sized>(*const bindings::inode_operations, PhantomData<T>);
+
+impl<T: FileSystem + ?Sized> Ops<T> {
+    /// Creates the inode operations from a type that implements the [`Operations`] trait.
+    pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
+        struct Table<T: Operations + ?Sized>(PhantomData<T>);
+        impl<T: Operations + ?Sized> Table<T> {
+            const TABLE: bindings::inode_operations = bindings::inode_operations {
+                lookup: None,
+                get_link: None,
+                permission: None,
+                get_inode_acl: None,
+                readlink: None,
+                create: None,
+                link: None,
+                unlink: None,
+                symlink: None,
+                mkdir: None,
+                rmdir: None,
+                mknod: None,
+                rename: None,
+                setattr: None,
+                getattr: None,
+                listxattr: None,
+                fiemap: None,
+                update_time: None,
+                atomic_open: None,
+                tmpfile: None,
+                get_acl: None,
+                set_acl: None,
+                fileattr_set: None,
+                fileattr_get: None,
+                get_offset_ctx: None,
+            };
+        }
+        Self(&Table::<U>::TABLE, PhantomData)
+    }
+}
-- 
2.34.1


