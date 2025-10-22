Return-Path: <linux-fsdevel+bounces-65121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDDBFC98A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126CD188B7A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03831350298;
	Wed, 22 Oct 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZPzkN26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722D34BA3B;
	Wed, 22 Oct 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143567; cv=none; b=QsrE2Y+RYVOMIUD4tcpWJft4qi3FTd+9Y8yTTJmIdTg3x9C/LIBjSiQ/hR3AKn87i/3ZjapygxBIEpgPSxDPXL46rDfpmKsDdyUxCgdUxbal8EVYyb2E0uXphQvhLIv/eM4ElxIQuFeMqLv2k3tYETU1NAfsPwfLiGxRL5UGsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143567; c=relaxed/simple;
	bh=sXQXAVOh9j2HCBx/MA+oC29Av/we7cIMQpnGv/8+4vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brNkr3aadAzUf99beXxkwnAAdlfJDWAUUGzhfRNTvocIXWov611FscMCb+yK7s+pO7RX1bI09kejASvRj9axCGxDZCrd3ClJ6zty75OmfR6wpoXAkNJa3GxUKU5vW2M2vFOdMMN6QbELOziuzcuuv2gSX+LaveW1EwIJ85zWgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZPzkN26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DFDC4CEF5;
	Wed, 22 Oct 2025 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143566;
	bh=sXQXAVOh9j2HCBx/MA+oC29Av/we7cIMQpnGv/8+4vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZPzkN26cxvO1tn1HrD8/If7jFUGomb/f3RR3j9EWQLuKFJXp7QiZU7gRFXCWGjKd
	 c/riLK/YZkX6QNHXjlNtLtSunc3SCkti0oOBlt1qPsjxxctGq9fyCcVh0Ft2dbMflM
	 VrfyqIo4gfcbfvsU4Om0tnDduE3o/f+Lu6Vtoepzj+a4SL4S7xCcuFQ2ppW1guf9EK
	 pq24bQTSu3J1KHvU5oeiVlWVRPDQd7g425J/vTUxp/myzWg9ubg7uW0bod2+K2C5/U
	 gOal/fzzMIEf54h4Bz6mgNiyRF5/UWx+qzYz+Qx6XD7YQFp5xZE2c8prnZR5V8LbRt
	 CRXWYrx0FZrqw==
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
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 10/10] samples: rust: debugfs_scoped: add example for blobs
Date: Wed, 22 Oct 2025 16:30:44 +0200
Message-ID: <20251022143158.64475-11-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022143158.64475-1-dakr@kernel.org>
References: <20251022143158.64475-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the rust_debugfs_scoped sample to demonstrate how to export a
large binary object through a ScopedDir.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_debugfs_scoped.rs | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/samples/rust/rust_debugfs_scoped.rs b/samples/rust/rust_debugfs_scoped.rs
index b0c4e76b123e..c80312cf168d 100644
--- a/samples/rust/rust_debugfs_scoped.rs
+++ b/samples/rust/rust_debugfs_scoped.rs
@@ -9,6 +9,7 @@
 use core::sync::atomic::AtomicUsize;
 use kernel::debugfs::{Dir, Scope};
 use kernel::prelude::*;
+use kernel::sizes::*;
 use kernel::sync::Mutex;
 use kernel::{c_str, new_mutex, str::CString};
 
@@ -66,18 +67,22 @@ fn create_file_write(
             GFP_KERNEL,
         )?;
     }
+    let blob = KBox::pin_init(new_mutex!([0x42; SZ_4K]), GFP_KERNEL)?;
 
     let scope = KBox::pin_init(
-        mod_data
-            .device_dir
-            .scope(DeviceData { name, nums }, &file_name, |dev_data, dir| {
+        mod_data.device_dir.scope(
+            DeviceData { name, nums, blob },
+            &file_name,
+            |dev_data, dir| {
                 for (idx, val) in dev_data.nums.iter().enumerate() {
                     let Ok(name) = CString::try_from_fmt(fmt!("{idx}")) else {
                         return;
                     };
                     dir.read_write_file(&name, val);
                 }
-            }),
+                dir.read_write_binary_file(c_str!("blob"), &dev_data.blob);
+            },
+        ),
         GFP_KERNEL,
     )?;
     (*mod_data.devices.lock()).push(scope, GFP_KERNEL)?;
@@ -110,6 +115,7 @@ fn init(device_dir: Dir) -> impl PinInit<Self> {
 struct DeviceData {
     name: CString,
     nums: KVec<AtomicUsize>,
+    blob: Pin<KBox<Mutex<[u8; SZ_4K]>>>,
 }
 
 fn init_control(base_dir: &Dir, dyn_dirs: Dir) -> impl PinInit<Scope<ModuleData>> + '_ {
-- 
2.51.0


