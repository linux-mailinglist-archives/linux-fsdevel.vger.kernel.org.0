Return-Path: <linux-fsdevel+bounces-65115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3CBFC903
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C636C4E4217
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38834D912;
	Wed, 22 Oct 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLSEXdYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B85340A46;
	Wed, 22 Oct 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143545; cv=none; b=uu3YGKTtEQ98QvNNanehJgYcrxrZY3KDkBpFqFfNXjgfAPAN8mT8mdb0u5JcIo1W0vs2NgVMj2ucIADNoLo0iQOfRysxPmmtzDaaxObpkOuHUQ/AYXxSUVVe+qbHv6+olh64HFTu7QK7LQk9qy9Kngv2rOGESrnfYev86o9PSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143545; c=relaxed/simple;
	bh=IjkceOxT7mX6S46hQJcyZaSydb0B4zMU/6D0t86Ia5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD3E10aSfd0BdtdvgzayHzdMvbW5uIHShhyIADUAePvKkiY2a7ldnkDSJ30UbPKW/dGYftI5Pq5t/A4trtYjotdk95kIpHrhnewo6Yz0Xd6tgj3MP+6ZuxlQCxrCdM/QOD2NojXwWFzrecQ5gLYGUTSjixIuPL+/h0ZbOzhL9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLSEXdYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D0FC4CEF5;
	Wed, 22 Oct 2025 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143544;
	bh=IjkceOxT7mX6S46hQJcyZaSydb0B4zMU/6D0t86Ia5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLSEXdYGGnnQKMHlIsMMU/6vO4EsNm0LQeUkCgtTwqLIondi1fYHYEUGALY7LAjKE
	 COGYQ5lVVxPpa6RGvaw0G41aSLTYBXbU7Xmn4a2u12qtvkyt6sKXLH0R3EKXZwS9mK
	 Rp9R/uTJNm8QOexsrc9CSbIApjnZAeI/NrkKSNseqOBOIIoXXkigeKXgGGNMvUb3Bp
	 Hc/fHC+l6BgtdIhQvqzP1h/IIYQqjVXBHtW64HhESSOHp+YhLYheRaADOOthOdYXWD
	 QzGhSBNPk1G8uekbDjMQ4wG5MA+Uf6IFOdi4vR0nqrK58ViJJ9OaRVSjqQzu+kcLL5
	 UX6/3UluAJVeA==
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
Subject: [PATCH v3 04/10] rust: uaccess: add UserSliceWriter::write_slice_partial()
Date: Wed, 22 Oct 2025 16:30:38 +0200
Message-ID: <20251022143158.64475-5-dakr@kernel.org>
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

The existing write_slice() method is a wrapper around copy_to_user() and
expects the user buffer to be larger than the source buffer.

However, userspace may split up reads in multiple partial operations
providing an offset into the source buffer and a smaller user buffer.

In order to support this common case, provide a helper for partial
writes.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index c2d3dfee8934..539e77a09cbc 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -479,6 +479,22 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         Ok(())
     }
 
+    /// Writes raw data to this user pointer from a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
+    /// truncates the write to the boundaries of `self` and `data`.
+    ///
+    /// On success, returns the number of bytes written.
+    pub fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usize> {
+        let end = offset
+            .checked_add(self.len())
+            .unwrap_or(data.len())
+            .min(data.len());
+
+        data.get(offset..end)
+            .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.len()))
+    }
+
     /// Writes the provided Rust value to this userspace pointer.
     ///
     /// Fails with [`EFAULT`] if the write happens on a bad address, or if the write goes out of
-- 
2.51.0


