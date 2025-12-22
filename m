Return-Path: <linux-fsdevel+bounces-71824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B58CD5F6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 13:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434C8308ED35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D62580FB;
	Mon, 22 Dec 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlVvOY1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501242222C5;
	Mon, 22 Dec 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766405949; cv=none; b=jVn8AEcluXkqQ3TISJdKTBX684+ErUF+BqXW3LmqlYGkVouN+tbX1JxtLjZqivnrbA+30/1h/YkgJxk0j0kERSGl9RRAILEIdMN5isVdV685tQMxhJDwyZYEIQy04zLIDGH4U1QdSsvFdpJFqgSUD+iNubEVEpd6ktR4BGMDMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766405949; c=relaxed/simple;
	bh=TPbyqQH9BsyIiHjEr95xubMy8k7vEEdQaYOxEVZo++I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ODEuL5ke1XjlPhPaks0hTuDTIuAP73/V6JxcVVMx5AHYvBNpWtbzPCV0mQGbsvKhgXYiKxhHLzVjIeuasg4+gKwa11ZYlu2YZyDpddhX+N3JrYYfeACugrB615mXF3a9+PaQMbk1GE2Mh55DnpHUsPRZEmc68YIZMMZOEX0kjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlVvOY1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F264C113D0;
	Mon, 22 Dec 2025 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766405948;
	bh=TPbyqQH9BsyIiHjEr95xubMy8k7vEEdQaYOxEVZo++I=;
	h=From:Date:Subject:To:Cc:From;
	b=JlVvOY1mZQIpwrBeSKsJHIUBAHRmvaEgUw/p7ZXXygV9j0rE7GMHNDkNtOjZFIKU/
	 6K1UJ0vYEZuhY7WVLaIMbGhcr6gd96lQoxUAG9bU05w+5xKacvmq0BeOgmZdnfNs7a
	 VWR/XLaVP4FuIHb244jUhJJS9Sdbm9fABrQPCnpo1dcql6OXCekGvmHWAvX1HLd1xh
	 WgPVqkjWnXLAZCoPqHcqGUpcyDOEskQR4nXvM8v2Aace3G/+zgq+M9JXETS5VCEEIn
	 nK8JGNedQrpu3aW2m0JBlY3AnJOI8lFUcz6M8j+EqOxbjxY5Hw0mGX30+EFT5o7DZw
	 ZLnoHb3z7aMig==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:18:57 +0100
Subject: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVhohtXEYsaU8aipINIGndXL
 L/kfy+BchRWaIsEkU9RWUNGXRZAswsTGxmzASu0NSIa0j2a06uxlhwSk6tcAznfInu5vquu/63
 HsDDt7x7u+wG86FpvbAAAAA==
X-Change-ID: 20251222-cstr-vfs-55ca2ceca0a4
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766405944; l=1478;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=KIAEsN6qlKLrsaTs5IDsy7JU6lVxNMINIA9KHD2MASE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFY8pKmNnEMbBOpMbzMNkyeabRzpGc50mGhfIxfDT5osZBiJO0Yr6H6xe1eCG3VXIvBV4/DEGIY
 xiRm45rJl6A4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..518265558d66 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-vfs-55ca2ceca0a4

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


