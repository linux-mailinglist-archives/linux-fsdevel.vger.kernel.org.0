Return-Path: <linux-fsdevel+bounces-65114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C22BFC93C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAB019A6271
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E734D4D4;
	Wed, 22 Oct 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXxi+3QJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99620C023;
	Wed, 22 Oct 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143543; cv=none; b=eD5+IT2wypnf2nijXb4LTd5RYpKqTjD6YGKWISWpCpqksZ3tw3p/HMnwVTd3Xjr12H47GY4Jy19V/co86KvXHdSA2l773bu2PogaZexekzCnt/JBU3M2RDwbqvb2Xj/tN4nLzz/MS243iQ5qZWeMUw3u8GF3Jb/cyteSGo0my3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143543; c=relaxed/simple;
	bh=jHmBvtWqsYI0nOoIuE4dBO1onQPA3oDKKwTK/VZOrWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnY2eRjKMuX8+pf51j76SPt9QQaEhSY9z3TVNXwjsOxlQUVxJk3bkB7PRdH2TKTOrnONLuj0FcQ8fjAqG30e7YtHLAh9xrOTul/YIKRXZMK84dfL2BDoj2gNBjF4J+8dxc7xEeXfuGwbm4mmwL4gZ4t8f8KWMKVEeSH2Jsek0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXxi+3QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114E4C116D0;
	Wed, 22 Oct 2025 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143541;
	bh=jHmBvtWqsYI0nOoIuE4dBO1onQPA3oDKKwTK/VZOrWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXxi+3QJ72t5ogUcvjNeDlp63lMgHF8xiXJ8DEPV+32dqrXksSNKM0OsRvF2VPuOp
	 /HgRGZvx8YdVvH66Eq4lDxcLECpzRbRZAEONyCNI2OC7l5kYNo+KaxB0BLtP9TE38J
	 qb0ciawsRx/QS0OrLGvivYAlFR5aXCT6ASyw1x90YKgJaFYRRQM2EbqlJ7o8hmNoIC
	 dQZOjtemeKCu1xDcWkWFfbbafb50Ofqt4dGCL43lfTDawY11/BBV67w51ie0MHKFW3
	 x8DTbi1mz8k/md6BdzXotI5kW2MpTqORgMueVOlAJdvS73V4mcBJa1+Lo9o06ITman
	 5K4YKAyFOJHgg==
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
Subject: [PATCH v3 03/10] rust: uaccess: add UserSliceReader::read_slice_file()
Date: Wed, 22 Oct 2025 16:30:37 +0200
Message-ID: <20251022143158.64475-4-dakr@kernel.org>
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

Add UserSliceReader::read_slice_file(), which is the same as
UserSliceReader::read_slice_partial() but updates the given file::Offset
by the number of bytes read.

This is equivalent to C's `simple_write_to_buffer()` and useful when
dealing with file offsets from file operations.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index c1cd3a76cff8..c2d3dfee8934 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -9,6 +9,7 @@
     bindings,
     error::Result,
     ffi::{c_char, c_void},
+    fs::file,
     prelude::*,
     transmute::{AsBytes, FromBytes},
 };
@@ -303,6 +304,30 @@ pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize) -> Result<us
             .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len()))
     }
 
+    /// Reads raw data from the user slice into a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::read_slice_partial`] but updates the given [`file::Offset`] by
+    /// the number of bytes read.
+    ///
+    /// This is equivalent to C's `simple_write_to_buffer()`.
+    ///
+    /// On success, returns the number of bytes read.
+    pub fn read_slice_file(&mut self, out: &mut [u8], offset: &mut file::Offset) -> Result<usize> {
+        if offset.is_negative() {
+            return Err(EINVAL);
+        }
+
+        let Ok(offset_index) = (*offset).try_into() else {
+            return Ok(0);
+        };
+
+        let read = self.read_slice_partial(out, offset_index)?;
+
+        *offset = offset.saturating_add_usize(read);
+
+        Ok(read)
+    }
+
     /// Reads a value of the specified type.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address, or if the read goes out of
-- 
2.51.0


