Return-Path: <linux-fsdevel+bounces-64788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86121BF3E81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3464878D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4CB3112BD;
	Mon, 20 Oct 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjlPpzQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD752F361D;
	Mon, 20 Oct 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999294; cv=none; b=pUghO/w5J9GBZngq9pzZb4WHSJUp6Mslpv+Zr+POt3vLSCt7UV4encFBXUTfSyy6B2NHhULRzR2dYOlPv61OWdUUCovo7cwCTdkyDMGCBae6GD8weYT9uAtAGaNUjQLlTFWDcS7gZQyr+nG9zehZY5bFxb4nMC/pXT4TQVjJWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999294; c=relaxed/simple;
	bh=VILyRkWz6gqlTn6L+yx2B8Vtnd+jITV1zM+dX0agrB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gycm8hE50urUMIdCtkmXkDHZ+oVVQB4u5yZLMZgY+q+6LAh9tRwNONcziY7Rf+FusSvjUGQLOVDFTsLmSl7MLqaY3t/2sEI7Q/pqdEwHnGL/slC8Rn7Xfpkgm4UVgFKCy3WsCgN1vUrzupC2aBT9usnF1EinabQcaFOPDKpnT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjlPpzQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9087FC4CEFB;
	Mon, 20 Oct 2025 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999293;
	bh=VILyRkWz6gqlTn6L+yx2B8Vtnd+jITV1zM+dX0agrB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjlPpzQz5rN6H0GmKwhGhCoKotSwHx98SWE3hZMEFGoMyjlRo7/rxnXVbhOD6MQzN
	 2m6DMSTaDb2+k1JsHmA4IaApj6gQYWP8emPpLO9hsnI5IoBUq3xDGl9LliFoJQZ2Rp
	 0lB4tF6SEx006cPLvs/Pzrx8SqPR2+sdHGWDedCjKO4QI/UHBxTcgcFm8sM31jI81U
	 bWucR0ogG8XJmwXRaXIvmjfc45MxNaLj7x2SiTP06o/uON6XJoMn5C7Tr6ZyoI3EhS
	 WsGlawfXegDsOVTwKWo6/+FxRNg2t8y4dYfROD5j/IRKso1RtADZNUF90iOz/caAqk
	 AFxFjEiZY0meA==
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
Subject: [PATCH v2 8/8] samples: rust: debugfs_scoped: add example for blobs
Date: Tue, 21 Oct 2025 00:26:20 +0200
Message-ID: <20251020222722.240473-9-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222722.240473-1-dakr@kernel.org>
References: <20251020222722.240473-1-dakr@kernel.org>
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


