Return-Path: <linux-fsdevel+bounces-64782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F7BF3E5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54F43345144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8332F363B;
	Mon, 20 Oct 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thuDzfkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD22F2600;
	Mon, 20 Oct 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999272; cv=none; b=h+HPMzS0avoC0RvVdc94sqb/p1kB/pMQ3t7qBNnoMCKvpVTVOcAtt3315CDeeVlMNGaaX7sdgKAbcRRy3PXJ5lLwPyQmuxSFAmdOLfzibjGwepdmO08Y+Loz87KnOh9SNkb6Vbxbyfu6VrBnh5v01xiklXS8fqIjepgrNkLFl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999272; c=relaxed/simple;
	bh=3B8nq0CwvoD/AdyMj2PgZskKxSiqWROgJMFJns/RM0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgnsSg/QrJS6oKB+Udufc+RnFLxRKMGH0hEIORXEotbN7znrUfoD0KuQTtguAzYnPJKxFWjB7T/Xa7mc90dm+h0zv0jKx+vOIKt26TJNarWQIOVl11Im8YCUTqqSIWcifbYaOoqXzUOfEH+JiOL/WHB7wFHVIDSxGB5bfeQTPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thuDzfkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFADC116D0;
	Mon, 20 Oct 2025 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999272;
	bh=3B8nq0CwvoD/AdyMj2PgZskKxSiqWROgJMFJns/RM0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thuDzfkQOww0DVlQMcW7LQ47E6Z8uJT1MJV9Npu4kLgO1tsq1M6GWu/goSGeAGD4u
	 VZwvAc3LtPQdzxKo6gXFkwB21/rGNbW0TqZofROJaamKWcQMi4gX+A9+Umm6BwFqZT
	 hUbkpQ062nobvzFPuW1a23iZ2ZDLksv3V9e3imZMCHZO8m/LC8Fi3ceZFB3f+poP8H
	 devUpY5Y4HqEaBI9eq1gCdEZMyd+mdM7ReVfPERrPtJcxyKHrqnpzd1Lu41QL62i9q
	 9Udh6nf8m0qrOXcbxZr8WgBwVdtcxiaUOfUo/9Vqc9xt+oVRjY4XekhDreTP7Vfca4
	 aT4hLGg7bTgOw==
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
Subject: [PATCH v2 2/8] rust: uaccess: add UserSliceReader::read_slice_partial()
Date: Tue, 21 Oct 2025 00:26:14 +0200
Message-ID: <20251020222722.240473-3-dakr@kernel.org>
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

The existing read_slice() method is a wrapper around copy_from_user()
and expects the user buffer to be larger than the destination buffer.

However, userspace may split up writes in multiple partial operations
providing an offset into the destination buffer and a smaller user
buffer.

In order to support this common case, provide a helper for partial
reads.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index a8fb4764185a..2061a7e10c65 100644
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
@@ -287,6 +288,30 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         self.read_raw(out)
     }
 
+    /// Reads raw data from the user slice into a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::read_slice`] but considers the given `offset` into `out` and
+    /// truncates the read to the boundaries of `self` and `out`.
+    ///
+    /// On success, returns the number of bytes read.
+    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: file::Offset) -> Result<usize> {
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


