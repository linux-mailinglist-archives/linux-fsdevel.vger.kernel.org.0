Return-Path: <linux-fsdevel+bounces-65120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39BFBFC97E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572CD188BA48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92534FF6C;
	Wed, 22 Oct 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmfVeuyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019434BA3B;
	Wed, 22 Oct 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143563; cv=none; b=jx2nbjpTFqhtXQPdts8pQDDEV1/B0bDfCJwxP9SAT7+2G06Iw3/GXBrRSxR4+PTYVMC/zAca9ds1lW+Yjrle+6hkCTjNkZQHGu7Yp8tDRD4EO3Gzi9cnkZw/cHRHb+x48F3wALOXddqnC0eo1sbZUPQrKWqHduhx9RSG/hHnjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143563; c=relaxed/simple;
	bh=Ipum7kJkezFIgHm8Gfyw8Db+qj/jWCJbUkbWlz7IoMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+IAxA2BBKIiLlqw61ggVY+8TPf7jr+8AsZwe9w4KUUneoxlF06x9rs41johpw7hlD0S07999k6BN533Dwc7MzZyW0qcNM1g14L49srg79sg24nX+QvF/atTMfxi/Ijd9I3t3RRK+xLDS8iItCUimBMTApViH0Ddp00yXCHIBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmfVeuyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB1FC4CEE7;
	Wed, 22 Oct 2025 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143563;
	bh=Ipum7kJkezFIgHm8Gfyw8Db+qj/jWCJbUkbWlz7IoMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmfVeuypxtV/EeXVPVAXWUe9BIpYu0N/bRw2nYWv6ZYkS6ZdRecnByBAqxBZJdLsO
	 jMhzqNOkZ22MhYNjDqGNsa4qIcmCiEf3mNQZLyba5WfQRw11jwds+ff/xsy1446Dzt
	 VDyPKawaLWKgz81T8XGivU0habnZXTQ85UPyeaAnXufSw2gZgtOhZsrPCX8qQ4IAiy
	 M0wj9id2XPF0a12Hk8KBYjGwXG/lVkdO6aU7jgulXzPRRD3hyp3X+rxcFZ2wJ2OJRg
	 +8UcCpHbAyjR19Faq9zZZjNedSBzpy4ZIqllgXHcevZxDOPBykjwDteHCV8izrqOwE
	 95rrLz2YBNXcg==
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
Subject: [PATCH v3 09/10] rust: debugfs: support binary large objects for ScopedDir
Date: Wed, 22 Oct 2025 16:30:43 +0200
Message-ID: <20251022143158.64475-10-dakr@kernel.org>
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

Add support for creating binary debugfs files via ScopedDir. This
mirrors the existing functionality for Dir, but without producing an
owning handle -- files are automatically removed when the associated
Scope is dropped.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
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


