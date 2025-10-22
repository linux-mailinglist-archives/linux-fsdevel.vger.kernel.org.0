Return-Path: <linux-fsdevel+bounces-65119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C8BFCA02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68726E406F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75D34F46B;
	Wed, 22 Oct 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyJx6jm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF634EEE7;
	Wed, 22 Oct 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143559; cv=none; b=rSu6vc/GSNwfj7qxxsmslp90j1BCLiftEdgV5wY31I02bSZ4nSbcPXYQkgVgIyortsvhOU//W+r0uL1tLp6aK+er94UHhA+tm6utq2j7GYVBinD++1gfSOkheIYa1k86U23vILTm/Q/pe2vNvMS1VKLxR45DORfJfwqUSyP9/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143559; c=relaxed/simple;
	bh=UiYQVhMhKBMwUHEEnbixnK+CAax+JdOjsup4OFpkgLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APma1YMKQQjsgFJRNEGzzcq+yjjfmWdexC6f37afnfFQZgT54HRa+qzdJZLJyMW6qIC5y/EWHWON937CsuPqfhwSwEa+wBLoXGzQkUenGXcbF9dTQ5/ktW6g/jKZkJq7YRTxRnU7EYDT5X3ny2LTzy5hR4mBUT3jTbbYbhVBBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyJx6jm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B41C4CEF5;
	Wed, 22 Oct 2025 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143559;
	bh=UiYQVhMhKBMwUHEEnbixnK+CAax+JdOjsup4OFpkgLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyJx6jm96seBnPio01CuTd82mPYCrrzyv+7k48YvfCtSa1hspYosn51Spo6BXJSgB
	 ceuNhGJV5hGELg9KLY16Kbg4IlozSnoEBHjRZY+uX8SXqC51qg477VuCi3SxL9Z057
	 1JfB4wM+VO01LxvzQbFs34MIZbfaSzPtpVXOc3JN8Si4MUM0G9wqrfV8PXKpDgdQT2
	 IdjCqZgHTz9Zbea/PkzZRy3JhQiS2hizH+TBTC//1s7MXWgXpmJ/eny1rPlaQzOV7N
	 26EUYckMkWVe8yT4A1gHmuX7D4VqYwGQoohM18ewl+4VKGno3meZFnQ1lSl3AKoVFK
	 /Yl282QslIy0Q==
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
Subject: [PATCH v3 08/10] samples: rust: debugfs: add example for blobs
Date: Wed, 22 Oct 2025 16:30:42 +0200
Message-ID: <20251022143158.64475-9-dakr@kernel.org>
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

Extend the Rust debugfs sample to demonstrate usage of binary file
support. The example now shows how to expose both fixed-size arrays
and dynamically sized vectors as binary blobs in debugfs.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_debugfs.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 82b61a15a34b..75ceb95276fa 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -38,6 +38,7 @@
 use kernel::debugfs::{Dir, File};
 use kernel::new_mutex;
 use kernel::prelude::*;
+use kernel::sizes::*;
 use kernel::sync::Mutex;
 
 use kernel::{acpi, device::Core, of, platform, str::CString, types::ARef};
@@ -62,6 +63,10 @@ struct RustDebugFs {
     counter: File<AtomicUsize>,
     #[pin]
     inner: File<Mutex<Inner>>,
+    #[pin]
+    array_blob: File<Mutex<[u8; 4]>>,
+    #[pin]
+    vector_blob: File<Mutex<KVec<u8>>>,
 }
 
 #[derive(Debug)]
@@ -143,6 +148,14 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
                 ),
                 counter <- Self::build_counter(&debugfs),
                 inner <- Self::build_inner(&debugfs),
+                array_blob <- debugfs.read_write_binary_file(
+                    c_str!("array_blob"),
+                    new_mutex!([0x62, 0x6c, 0x6f, 0x62]),
+                ),
+                vector_blob <- debugfs.read_write_binary_file(
+                    c_str!("vector_blob"),
+                    new_mutex!(kernel::kvec!(0x42; SZ_4K)?),
+                ),
                 _debugfs: debugfs,
                 pdev: pdev.into(),
             }
-- 
2.51.0


