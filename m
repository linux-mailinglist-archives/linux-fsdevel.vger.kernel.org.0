Return-Path: <linux-fsdevel+bounces-65116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F1BFCAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC311740D03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B034DCE4;
	Wed, 22 Oct 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQOCSdAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107842FAC0C;
	Wed, 22 Oct 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143549; cv=none; b=VRulrYOYwk/euB0ckc+m1vvOYgRmgtU6iQ6wkwqMuI4+qmvtTqg9b9qvZRSxfXrOSwRoasx8/tPWUTJysBiQ2RLuYEqbCDmwsX/hbF9fG6E+tSMuM6cni0u28QiH6wW1r5ddOGfkv4rEUlUfzJMKEzEL+IlkKSSQPRlTccrJCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143549; c=relaxed/simple;
	bh=3cFpxpxpPxPs/cBsHHXElxYbWoxDVBrn7wce7vGXY5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWdsZ97TMi6ch10m3ni4GLqdiSN8D5lXnIIYQYo1BKALOyEjWqjkEJnwXKCEonTON4F9L0LGi0sorxY+dmiqLzm9TgmxfcpYdy2KSQAAQ5D/FrruJDBeUmGzpnfsU/Xtft6Tr7shrtG2IYLViiev7570rHEdwiFT9rXfQpN+n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQOCSdAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600BBC113D0;
	Wed, 22 Oct 2025 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143548;
	bh=3cFpxpxpPxPs/cBsHHXElxYbWoxDVBrn7wce7vGXY5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQOCSdAJnDVoKKmIxk1n9f8P6hZBGUlF03Nnr4mQHUa1oyHXjtS0yGQF+RDkuMHfO
	 A+18SGQevTcphtT69TWpktl+qUBPBLMp4YN4zHih11H4ZnWqg4RJZNJktLWMaY5vuD
	 x5dPmaWhW2S1lonT5j4m4QVlm1e8pINScAw6j2L5TXOSKlLo8dso3uGMHd6zMGLieT
	 Posrw2naMnOW2ilQqPgKGsYYXI2NLyHhe956AHSZqlkZ9fOgO1jTQ0Er+Y+jz2V6CL
	 3R/2P36Sa+QiYElWvD9YHgl15N2AOd3hcbZYHPjPrGhBATgmtg3zYmsKyMGr1gGeFV
	 sMYlXe37I+Y7w==
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
Subject: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
Date: Wed, 22 Oct 2025 16:30:39 +0200
Message-ID: <20251022143158.64475-6-dakr@kernel.org>
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

Add UserSliceWriter::write_slice_file(), which is the same as
UserSliceWriter::write_slice_partial() but updates the given
file::Offset by the number of bytes written.

This is equivalent to C's `simple_read_from_buffer()` and useful when
dealing with file offsets from file operations.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 539e77a09cbc..20ea31781efb 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usiz
             .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.len()))
     }
 
+    /// Writes raw data to this user pointer from a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::write_slice_partial`] but updates the given [`file::Offset`] by
+    /// the number of bytes written.
+    ///
+    /// This is equivalent to C's `simple_read_from_buffer()`.
+    ///
+    /// On success, returns the number of bytes written.
+    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file::Offset) -> Result<usize> {
+        if offset.is_negative() {
+            return Err(EINVAL);
+        }
+
+        let Ok(offset_index) = (*offset).try_into() else {
+            return Ok(0);
+        };
+
+        let written = self.write_slice_partial(data, offset_index)?;
+
+        *offset = offset.saturating_add_usize(written);
+
+        Ok(written)
+    }
+
     /// Writes the provided Rust value to this userspace pointer.
     ///
     /// Fails with [`EFAULT`] if the write happens on a bad address, or if the write goes out of
-- 
2.51.0


