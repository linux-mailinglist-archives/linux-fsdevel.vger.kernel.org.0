Return-Path: <linux-fsdevel+bounces-67017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B398C33788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D94F34F34C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438E2459E1;
	Wed,  5 Nov 2025 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdYsHi2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F79EEAB;
	Wed,  5 Nov 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302244; cv=none; b=eI8iOaC+EJSWoRd9YS6F6nXbKlZJWeYPi4M7ZyuuqxziTE1bs9eQt9hPPHP7pMH6ZTQrApV+fxGRlBXiYQrW3aAhnrdu+4Pbr0UqZUNteMi6hpWvLYxdr6JinFmDanHrb9zgKlbx375MaIHAX170MrXgQAWmi8KnCGYS2Q8qC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302244; c=relaxed/simple;
	bh=Q8uoW7zjflY+EA41C3j47knpA15afWUIqZU0cMZKBBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAQpRPGIamyO+qJmnyy4jNvqDAWrstKY1z/lf6tvs+/fyV6Eab325A2vrmR5dV1bRfamAsUpa4TlvBDkmm6Vd8Us+f9zm02J7VCjXPTDxdDOmm56wEVS2rsZ5JFg/vTdbEL6hbi2k59kd2x6j00P/iyvrwt/FuToj3MOxPdO6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdYsHi2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F3C116D0;
	Wed,  5 Nov 2025 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302244;
	bh=Q8uoW7zjflY+EA41C3j47knpA15afWUIqZU0cMZKBBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdYsHi2//dPyrG18fJ12rNvIkZyhlxtcCqWjugRjmbKWFFi2La5CJmcl66mZeP42w
	 +bOsvafzYg5KaEay+kcOHGFGBQpiZyQb0bSJYWP+FX6/JYMDTJ972faD580klagofk
	 ttD45D7VrIONStXsVnRGskRWj884Gf9Ex/TN8Tcgwky2B9nxutqBySnSg6YIHbUweu
	 QR3zHOvL6KAmKX6yZRTKR3dEWRfEPrmFKhnG/qTUQT8G/xn8eyNFYko5WmzrleTDUC
	 3RHPGB1RasmDg0hCxf02q/WSgOJDvYLlWlxopVu76Ft2uJrqlUY48D98UBmwcjytmJ
	 U0Lfc/lkOo18Q==
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
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/3] rust: iov: take advantage from file::Offset
Date: Wed,  5 Nov 2025 01:22:50 +0100
Message-ID: <20251105002346.53119-3-dakr@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105002346.53119-1-dakr@kernel.org>
References: <20251105002346.53119-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of file::Offset, now that we have a dedicated type for it.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/iov.rs               | 13 +++++++++----
 samples/rust/rust_misc_device.rs |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
index 43bae8923c46..a3b1233441b6 100644
--- a/rust/kernel/iov.rs
+++ b/rust/kernel/iov.rs
@@ -10,6 +10,7 @@
 use crate::{
     alloc::{Allocator, Flags},
     bindings,
+    fs::file,
     prelude::*,
     types::Opaque,
 };
@@ -292,8 +293,12 @@ pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
     /// that the file will appear to contain `contents` even if takes multiple reads to read the
     /// entire file.
     #[inline]
-    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Result<usize> {
-        if *ppos < 0 {
+    pub fn simple_read_from_buffer(
+        &mut self,
+        ppos: &mut file::Offset,
+        contents: &[u8],
+    ) -> Result<usize> {
+        if ppos.is_negative() {
             return Err(EINVAL);
         }
         let Ok(pos) = usize::try_from(*ppos) else {
@@ -306,8 +311,8 @@ pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Re
         // BOUNDS: We just checked that `pos < contents.len()` above.
         let num_written = self.copy_to_iter(&contents[pos..]);
 
-        // OVERFLOW: `pos+num_written <= contents.len() <= isize::MAX <= i64::MAX`.
-        *ppos = (pos + num_written) as i64;
+        // OVERFLOW: `pos+num_written <= contents.len() <= isize::MAX <= file::Offset::MAX`.
+        *ppos += num_written as isize;
 
         Ok(num_written)
     }
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 6a9f59ccf71d..edbcc761b4a2 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -187,7 +187,7 @@ fn read_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterDest<'_>) -> Resu
 
         let inner = me.inner.lock();
         // Read the buffer contents, taking the file position into account.
-        let read = iov.simple_read_from_buffer(&mut kiocb.ki_pos_mut().0, &inner.buffer)?;
+        let read = iov.simple_read_from_buffer(kiocb.ki_pos_mut(), &inner.buffer)?;
 
         Ok(read)
     }
-- 
2.51.2


