Return-Path: <linux-fsdevel+bounces-64786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2EFBF3E75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9BC488257
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E22F5461;
	Mon, 20 Oct 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuH0pr69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002ED2F5302;
	Mon, 20 Oct 2025 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999287; cv=none; b=AxF2Cn+qUBUTbWaSyzW/V0knikxDYUOLPgOEgcCFdklsAyEsUglJVmAEAN4Xvu0dI+Fus1bnNc+5wGlON49PEyAqBoFc2Qnbs4zTT3o2t9Hwu418lO5Ql80ouhG4JZo/j8CN5iVg3SArFbG/7RyW7qOWrfbfMtzGQYEho5/ZJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999287; c=relaxed/simple;
	bh=fTnm6MK2+nTWBIam9Jhr5x+RdCc6bwT4/1OMzKgp8cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi6NIEbPa/qWuC1eMLmlSU8X89QCqF7ZDPiPua/4fCQpqnfvHKn073Dxg/9MTMagtR9PRg/CyAjlMlF47uzb1aFFjIz5iRRL6YT17G8wHhXO3SzPcBG9D/TV0xw3jOslAMt1xYeqAR5UScnEh7F3qsywuVhVu+GaEssIVYNd4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuH0pr69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68464C116C6;
	Mon, 20 Oct 2025 22:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999286;
	bh=fTnm6MK2+nTWBIam9Jhr5x+RdCc6bwT4/1OMzKgp8cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuH0pr69F5bMwQtBWeUA7qrkb7+n1YrYbMVuWu4THKJ37QjXSH2AjZZNsTP4+2kGz
	 IKEcHnUmxJKuKjPeu8YleIgYYQcDEMygZSxHPNGP8l29YMBCMnIalWO0N2VCirXGbZ
	 u6yV1PHjMJXdVe+Mh6K9xBYCPxHbyt6RH+m+AqB8P6286VFP+vhrwbZtVqqjoLj0d6
	 IkaZHEfzHzvmx+CvqZhc9yvaTZcdDZb579k58mU0HxIf+UpCfkpyfvHeGpQpM0ej74
	 FCSfZ+dkaXqVfr8stPZtYmmPPVH7qarwLIpAu3X4/QoB4EHymkIY8hq1aXJRzioQZe
	 3ck6BmzKjS0LA==
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
Subject: [PATCH v2 6/8] samples: rust: debugfs: add example for blobs
Date: Tue, 21 Oct 2025 00:26:18 +0200
Message-ID: <20251020222722.240473-7-dakr@kernel.org>
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

Extend the Rust debugfs sample to demonstrate usage of binary file
support. The example now shows how to expose both fixed-size arrays
and dynamically sized vectors as binary blobs in debugfs.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


