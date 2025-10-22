Return-Path: <linux-fsdevel+bounces-65113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FFBFCB3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D051974039F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCA34C9B5;
	Wed, 22 Oct 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDLUCFES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E835BDC2;
	Wed, 22 Oct 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143538; cv=none; b=GFHmeSxZWcDjbVzeOhMwNEbT9eJLaNWLb/O1QFI7hUo4tYw1aBrviLBB+aCF1XMENjoLNmmNZsGQbCXcMrr9ogJyOAHU+O/o/zxrSacYiBUoXNYCWpM9CZymdPYQCu9AKLktfe1uXdfexV6LE5EOEghb9GjOp6r7tpMBL5536V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143538; c=relaxed/simple;
	bh=Di/BVFP/A6eAj6AbOpvDza38/C8Y5MoWi9JhFxRdUSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoO0XE4QgMcu6OQjkaYBx+kvpg37kGqRiAm4TkOu9O4Xakt6eQznZZjjHpUDaY1OZeM22ZLXTjjuH4jXXrbj4kfmL1VunglgY9bc4+sp79UpsBzNh+AGFXspWLP7o/3e8DCwZSoilkhLN1NSTgLysSqleH8xD6wOLJzxrW3D1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDLUCFES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C64C4CEE7;
	Wed, 22 Oct 2025 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143537;
	bh=Di/BVFP/A6eAj6AbOpvDza38/C8Y5MoWi9JhFxRdUSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDLUCFES73ySQD6VG14PY4NK8VQJC96FXEuYKhw0O+UVhoHxS/Nm2jKaqge3TJZw9
	 I3G9fD4WrbTjXiQKEU3+4XvfOD1PRddoyL14P31ewmCLNYzKDkCy3WD1WrkW2uxcuR
	 1GgEGzd7VUgqsJgEa5O0w85EC27JhtYiFiuucb7nAJplSQOQs0MJkTj0aKhigNJSZn
	 MbSMgkF/5qzzMgG6ynx1+LnFEtAjDgo2CR6B63NB0g4CW+SDfAxZUG/wjImkm7QD1z
	 nY7alD7Gr7uX2Ee2c+3pLKZ7T7bVBb/nvovCzoSLb/Z2AQpcKrbjJj/vkGxa7GQq3J
	 +VZGnWULrmDUQ==
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
Subject: [PATCH v3 02/10] rust: uaccess: add UserSliceReader::read_slice_partial()
Date: Wed, 22 Oct 2025 16:30:36 +0200
Message-ID: <20251022143158.64475-3-dakr@kernel.org>
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

The existing read_slice() method is a wrapper around copy_from_user()
and expects the user buffer to be larger than the destination buffer.

However, userspace may split up writes in multiple partial operations
providing an offset into the destination buffer and a smaller user
buffer.

In order to support this common case, provide a helper for partial
reads.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index a8fb4764185a..c1cd3a76cff8 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -287,6 +287,22 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         self.read_raw(out)
     }
 
+    /// Reads raw data from the user slice into a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::read_slice`] but considers the given `offset` into `out` and
+    /// truncates the read to the boundaries of `self` and `out`.
+    ///
+    /// On success, returns the number of bytes read.
+    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize) -> Result<usize> {
+        let end = offset
+            .checked_add(self.len())
+            .unwrap_or(out.len())
+            .min(out.len());
+
+        out.get_mut(offset..end)
+            .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len()))
+    }
+
     /// Reads a value of the specified type.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address, or if the read goes out of
-- 
2.51.0


