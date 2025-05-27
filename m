Return-Path: <linux-fsdevel+bounces-49929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A90AC5B94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 22:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7134116B991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D520B806;
	Tue, 27 May 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="m/dxZvkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AA1FCFF8;
	Tue, 27 May 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378950; cv=none; b=l8Km/+KAIVM/e3R8yEs/weS2spFbgXs+xxixStmZaolT3wO8SHrC8GiswfqJm6G4vuG8bKq0kJoyokXLowQRTdikwuh6g7p4SiIDEO6rBUqVYMdTd0LGgZz80wpkquNIDpFDDcVKVhWFvtsIk38nXBQZ23zPz/ICq2bOetFMtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378950; c=relaxed/simple;
	bh=EuBia1JKE9lcqZQ6RSMNw9YtLgSStqd1ny1U8ZAlM/w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bKzFh+nivpe9k0wdDdc/T+0I6O8zB+xwDkoQsyVYK9CC45RWnZnpl7dusFsmTcH+blKXqeBxFmKhr5bnVNkgChd2VrLjA6fGizq8xAxEt8xhdB4ChPIusveON9WfeAvDZeviNQATOmpWayIHaeSnpfp2A+hsF/VtwiBQudHxjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=m/dxZvkS; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1748378939; x=1748638139;
	bh=RmF85GSTZGhzWBPEBhnVNoD6j/L15dcGwJDPHtGO6kc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=m/dxZvkSsmTMUEk993my2mD4xPXUY4O4T3/xZAJUE/EgiEF1XgHhk59yseTzPNkYp
	 c51QRxd7WKPvDPi4wWtt7PmZMg8zdQkA+PVMbikt/FmCc1m/RLsvwV9PpnZHYn+BbI
	 HDousAaQYce5GoBa38ufd4jTkmdlEatSjAcnAzbv+ogplU3QSJrq3jkoeaHczYds6w
	 aQEESDKVt/+VDJl4jG/3I/1ZTaegQZv/l5YKM7Kkrjo/IdPKBdDKnc6g7Rf7KVOJTj
	 E+N5StG0ApZ60ZGDV/l7dmVWfGHJPEsuBSTwK64NSGlE+1bgNd1Zny1d/tif0wHte/
	 nvh+l9RohTQBQ==
Date: Tue, 27 May 2025 20:48:55 +0000
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Pekka Ristola <pekkarr@protonmail.com>
Subject: [PATCH 1/2] rust: file: mark `LocalFile` as `repr(transparent)`
Message-ID: <20250527204636.12573-1-pekkarr@protonmail.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: 4eaa0b5fd5b9c7aaa1eec78bb8537d59f67462a5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Unsafe code in `LocalFile`'s methods assumes that the type has the same
layout as the inner `bindings::file`. This is not guaranteed by the default
struct representation in Rust, but requires specifying the `transparent`
representation.

The `File` struct (which also wraps `bindings::file`) is already marked as
`repr(transparent)`, so this change makes their layouts equivalent.

Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`")
Closes: https://github.com/Rust-for-Linux/linux/issues/1165
Signed-off-by: Pekka Ristola <pekkarr@protonmail.com>
---
 rust/kernel/fs/file.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 13a0e44cd1aa..138693bdeb3f 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -219,6 +219,7 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
 ///   must be on the same thread as this file.
 ///
 /// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
+#[repr(transparent)]
 pub struct LocalFile {
     inner: Opaque<bindings::file>,
 }
--=20
2.49.0



