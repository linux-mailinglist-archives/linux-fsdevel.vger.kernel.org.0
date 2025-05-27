Return-Path: <linux-fsdevel+bounces-49930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231A6AC5B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 22:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4573B6DCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3520C497;
	Tue, 27 May 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rRs3mHwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D1208994
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378966; cv=none; b=bqvwUaNa9LmguHZfK+xUeUxVsJWZv03r1iMttK6+ZnjcFAQNlN+hSvNeZmDyzNvF1Hv608oNrqB1ibuk4OnF2TexkcZoeSOcpQr55JZ9+uT3CllipKjPwRtYS33GlpMy0r7iFKB2xPw+Muq4c8ZNaFR3s9LBpwsdvpdOnUW3NtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378966; c=relaxed/simple;
	bh=Av5zhnPaOvNXK9AAIR9AtRQJaPh7rUw1RSw2XpERkUc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPkqDHcor5fL5lQViZTQgUqiiUO+Lqv03TxoOz5lg0tPCqz3UEJgaedqZAxU8WcwCDAQpF//WhdS2F5WI9Z5EwmiTQrj9zPDUNo+2R4tJcWVeNAArCFtshXpxGxfSPtCqIvwHOxgJhmdsWIq9RB2gIjXxS/JLZLCQgJDvsK/GA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rRs3mHwR; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1748378949; x=1748638149;
	bh=0ALUtJjOWGaXtjubOZ+S4x7kMHCyazUaC6CP6v23I6k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=rRs3mHwRi/zjv1Kjyy9IueQV+aLDcFL2vVnJQoIun/36oAEjGabm/AU2x99+w4Lwh
	 TGtiwUeVu2KO2YZjw0iIYEKW3ec6+F0weSIAw3d6rB8ov6f0jzJWE3+Q67wfLtrU96
	 sysuUbwjp+EU8jHZ/HRIdBGlx2B1pTEFpXXeiqYgqeXyDn/0ZW8iKehT+8UPyBwxtv
	 lq4kgRu4ak8/Z/+lvRrn0EH0ySXYh1OjRFlATAOXonIGaME3ZF7MhlaRd3x/54F7tj
	 ubALtUo53FFtW+mewi7Nac8nm1SIIxB1BsJYFIj78RNQ8oAZB1vTwKT/lUjTkoCXQp
	 T56liGhKXkrIw==
Date: Tue, 27 May 2025 20:48:59 +0000
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Pekka Ristola <pekkarr@protonmail.com>
Subject: [PATCH 2/2] rust: file: improve safety comments
Message-ID: <20250527204636.12573-2-pekkarr@protonmail.com>
In-Reply-To: <20250527204636.12573-1-pekkarr@protonmail.com>
References: <20250527204636.12573-1-pekkarr@protonmail.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: 7b7c468811e102d2ffbc66cb459ade023a66e86e
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some of the safety comments in `LocalFile`'s methods incorrectly refer to
the `File` type instead of `LocalFile`, so fix them to use the correct
type.

Also add missing Markdown code spans around lifetimes in the safety
comments, i.e. change 'a to `'a`.

Link: https://github.com/Rust-for-Linux/linux/issues/1165
Signed-off-by: Pekka Ristola <pekkarr@protonmail.com>
---
 rust/kernel/fs/file.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 138693bdeb3f..72d84fb0e266 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -225,7 +225,7 @@ pub struct LocalFile {
 }
=20
 // SAFETY: The type invariants guarantee that `LocalFile` is always ref-co=
unted. This implementation
-// makes `ARef<File>` own a normal refcount.
+// makes `ARef<LocalFile>` own a normal refcount.
 unsafe impl AlwaysRefCounted for LocalFile {
     #[inline]
     fn inc_ref(&self) {
@@ -236,7 +236,8 @@ fn inc_ref(&self) {
     #[inline]
     unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
         // SAFETY: To call this method, the caller passes us ownership of =
a normal refcount, so we
-        // may drop it. The cast is okay since `File` has the same represe=
ntation as `struct file`.
+        // may drop it. The cast is okay since `LocalFile` has the same re=
presentation as
+        // `struct file`.
         unsafe { bindings::fput(obj.cast().as_ptr()) }
     }
 }
@@ -274,7 +275,7 @@ pub fn fget(fd: u32) -> Result<ARef<LocalFile>, BadFdEr=
ror> {
     #[inline]
     pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a Loc=
alFile {
         // SAFETY: The caller guarantees that the pointer is not dangling =
and stays valid for the
-        // duration of 'a. The cast is okay because `File` is `repr(transp=
arent)`.
+        // duration of `'a`. The cast is okay because `LocalFile` is `repr=
(transparent)`.
         //
         // INVARIANT: The caller guarantees that there are no problematic =
`fdget_pos` calls.
         unsafe { &*ptr.cast() }
@@ -348,7 +349,7 @@ impl File {
     #[inline]
     pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a Fil=
e {
         // SAFETY: The caller guarantees that the pointer is not dangling =
and stays valid for the
-        // duration of 'a. The cast is okay because `File` is `repr(transp=
arent)`.
+        // duration of `'a`. The cast is okay because `File` is `repr(tran=
sparent)`.
         //
         // INVARIANT: The caller guarantees that there are no problematic =
`fdget_pos` calls.
         unsafe { &*ptr.cast() }
--=20
2.49.0



