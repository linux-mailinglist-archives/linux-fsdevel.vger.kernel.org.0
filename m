Return-Path: <linux-fsdevel+bounces-64787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14ABF3E7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8295418EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3392F60A3;
	Mon, 20 Oct 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di4v0AZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD42F3603;
	Mon, 20 Oct 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999290; cv=none; b=d98NF9ji+v1CSv8gV2D/QXLcgwBV2NToKvy1zc3TzdXF0iXTlpyfHIcT4Fu0U5M+HhyKLji+0eCSnkt5WU5pprLwWk07bSOZslraCFyFlXSCVFpOAfQgmBSWlYSn6U/9zcxNL1GhcLoVKUHa0In6Tox9GhxO0Zzu/1LPsWklrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999290; c=relaxed/simple;
	bh=UrU3oqiQVbLXWgz1IAPAfei+4kGipnhSamz0dMggNe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqgYx7MoPtTGqdNjXQJqUSb9KfG8HOHmHywjI5/ljbVfD8s3/on3/JAfulvf1L0md5mm66MC6jqHQEFt5x0kDNtPskgweSi/TImPbr3kKJbSv/RHYjGvJemQWwPw2bKJOd5T/pVOQoFFI3rvNyzPB6DUfYl5c8x3e7PKWuNGk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di4v0AZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0249DC113D0;
	Mon, 20 Oct 2025 22:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999290;
	bh=UrU3oqiQVbLXWgz1IAPAfei+4kGipnhSamz0dMggNe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Di4v0AZs3unRma5LwGH0CN0NavK9tewFwGV9cG3sf9CBVwVEV3e/X3d6JCQomSI5l
	 k7KbOaCyvDu1OC/nQIhylFitVoS3qq+RPJve0kE7BbaHMfLh3BjB51N207TLDRG8p6
	 NHox1EeqoK1lTk2ctZp5/w/Kfgcbjn2tAIZ3/BqU9CMGSeEXngkyHGpQTcR4odsQuJ
	 ghXuLgvqcDuqzJyQu2Xv4PuLDfcfHmM2hmyo74KK/lXBQGyECAIs5vpA+uQe2+bXSa
	 4sT3ptjLipYsi+ji2925wznxC8pzO+BL4ZMEdi8du369s7dPitrNggnykOHwiZwC4L
	 DWrKQbFrIuMBg==
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
Subject: [PATCH v2 7/8] rust: debugfs: support binary large objects for ScopedDir
Date: Tue, 21 Oct 2025 00:26:19 +0200
Message-ID: <20251020222722.240473-8-dakr@kernel.org>
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

Add support for creating binary debugfs files via ScopedDir. This
mirrors the existing functionality for Dir, but without producing an
owning handle -- files are automatically removed when the associated
Scope is dropped.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs.rs | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index d2bc7550d81e..e8139d2e5730 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -530,6 +530,20 @@ pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name: &CStr, dat
         self.create_file(name, data, &T::FILE_OPS)
     }
 
+    /// Creates a read-only binary file in this directory.
+    ///
+    /// The file's contents are produced by invoking [`BinaryWriter::write_to_slice`].
+    ///
+    /// This function does not produce an owning handle to the file. The created file is removed
+    /// when the [`Scope`] that this directory belongs to is dropped.
+    pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
+
     /// Creates a read-only file in this directory, with contents from a callback.
     ///
     /// The file contents are generated by calling `f` with `data`.
@@ -567,6 +581,22 @@ pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
         self.create_file(name, data, vtable)
     }
 
+    /// Creates a read-write binary file in this directory.
+    ///
+    /// Reading the file uses the [`BinaryWriter`] implementation on `data`. Writing to the file
+    /// uses the [`BinaryReader`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created file is removed
+    /// when the [`Scope`] that this directory belongs to is dropped.
+    pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        let vtable = &<T as BinaryReadWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, vtable)
+    }
+
     /// Creates a read-write file in this directory, with logic from callbacks.
     ///
     /// Reading from the file is handled by `f`. Writing to the file is handled by `w`.
@@ -606,6 +636,20 @@ pub fn write_only_file<T: Reader + Send + Sync + 'static>(&self, name: &CStr, da
         self.create_file(name, data, vtable)
     }
 
+    /// Creates a write-only binary file in this directory.
+    ///
+    /// Writing to the file uses the [`BinaryReader`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created file is removed
+    /// when the [`Scope`] that this directory belongs to is dropped.
+    pub fn write_binary_file<T: BinaryReader + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
+
     /// Creates a write-only file in this directory, with write logic from a callback.
     ///
     /// Writing to the file is handled by `w`.
-- 
2.51.0


