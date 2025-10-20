Return-Path: <linux-fsdevel+bounces-64783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C455BF3E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CEC54107D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CB2F28E2;
	Mon, 20 Oct 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGVPmQaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF62F2600;
	Mon, 20 Oct 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999276; cv=none; b=p7NWEQH3vB/xrix59wqD9MH1OI2t307bHeLkrTrMVvWkHG93Mhqbo5AayuVLAWNSgTBqikGGOS3s3gBIvrx7uhIERCM7WqdYQjrPyUJl+OoID4QvPESQhVvMKu/cepF1/1QdNw0RHE3nmRIgTlH/0EK2srZjN93u7CJRc5duQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999276; c=relaxed/simple;
	bh=RC1zQ7X2UtMkt1my+xGkQGKDxGQQ3DGT5+QmAnulaHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwYik02/zHRvpBS1nMAF4HYNIBUk6hGgF5UbgdYWR53nSRQcvBfSW1NAVQtA18TSGlMDdt7OMNIMreKDZd8G3TkLUIebvmABGM5NRNcsWjRk3g2CHw5d0w+xP0VY/Q7KiwrZQ6d3Vs+k0Xgc/Yzgo946EisJ7LxH9JQQyHBGt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGVPmQaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8535FC116D0;
	Mon, 20 Oct 2025 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999275;
	bh=RC1zQ7X2UtMkt1my+xGkQGKDxGQQ3DGT5+QmAnulaHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGVPmQaCbEHugzTy6RLizt6TtekbJlRz9Ua+iDLOu9CEOrG/tYTVS4us1PsSf7sxl
	 TXCm/vYCLgc7mEXnUWnwRx0i12HsTE8Dc/a0qayu0DzdZML7PhBRGcIpz8z4n8xoXA
	 qV0srdwyTsuBFfIur8VXOFGZX2mdVg5RmcwGZjYTcu/xAARpNaJFSyY7ut9n8oFuqz
	 brh3ZqgNZywHqEKCbE4eORDohB1MyaPEuYvHsYaXJwwPMMuzmuPwnA9ut8ZcFC7vV1
	 ZBjqoCVv2MPdN9Ab62pDaEmlTGPEHCL4FokXLmUvouE6hbOJgU/re6SSqxHaeapfna
	 fbIRnrPT8dgPQ==
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
Subject: [PATCH v2 3/8] rust: uaccess: add UserSliceWriter::write_slice_partial()
Date: Tue, 21 Oct 2025 00:26:15 +0200
Message-ID: <20251020222722.240473-4-dakr@kernel.org>
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

The existing write_slice() method is a wrapper around copy_to_user() and
expects the user buffer to be larger than the source buffer.

However, userspace may split up reads in multiple partial operations
providing an offset into the source buffer and a smaller user buffer.

In order to support this common case, provide a helper for partial
writes.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 2061a7e10c65..40d47e94b54f 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -463,6 +463,30 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         Ok(())
     }
 
+    /// Writes raw data to this user pointer from a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
+    /// truncates the write to the boundaries of `self` and `data`.
+    ///
+    /// On success, returns the number of bytes written.
+    pub fn write_slice_partial(&mut self, data: &[u8], offset: file::Offset) -> Result<usize> {
+        if offset < 0 {
+            return Err(EINVAL);
+        }
+
+        let Ok(offset) = usize::try_from(offset) else {
+            return Ok(0);
+        };
+
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


