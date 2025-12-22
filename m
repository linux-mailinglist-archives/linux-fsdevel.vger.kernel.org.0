Return-Path: <linux-fsdevel+bounces-71827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D855CD6601
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE323303FA5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128F2F616A;
	Mon, 22 Dec 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TRjDYwUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FC2D738E;
	Mon, 22 Dec 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413964; cv=pass; b=fnEMwCjiZ78Rz1R55vgRduqgVmY/FQk1Jh66IqEPpjGXwfbkww5BySbxXEL/sz3LykSxqJLxmJ/u7u2ozNhn65va6HAo8epsrk6A0FhdI0dagiyQDuHCCA4BUPzzB2g2jIGRGGf6Tclu8acNxV3zKyTB8mVF/u3qQ5BAN1JGFis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413964; c=relaxed/simple;
	bh=xHQA30nq/9OWMxphyKsKsbr1ItGgYEOcffQ4phEwvHM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hoN63VYCa98iuTPYQT2PlSoxCsT+y6NJuNp3dbmruM0kIkLjW0h18DiRCHI88CYRTKt6L/Rn6gwUIDXAvHC2BAryDmat1/xhTjM1rZnZ11Wy8+Ij8TzdkLf7MeomZRhIlzYWeS/OzW5biIyWSyeK0paZACTEapDeUZ3C90fxnq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TRjDYwUL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766413935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TF3d24BYfzI3d1cXZPOUxy1Kt7yhIDjKDmhMgFoAVLjj59af3DeE4OHkrnSGgep/L9BTmx2YYhQdcwUBDSV5Pfy9bNDnEDsoUfUZGHSGMdrR7Qe/qyl6quWw9sqzm/tDfUy3PA+3QXKGdncjbjFn0Ed6ANwJWxF2e2XeY1G+jrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766413935; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MIsebt+0bW61I/ZAHjyZRH22/kuuWpq+aRZENXzI4ss=; 
	b=DJ5c7J6HM2N+HN05vrsXjT+URBRJUUDUd0no1jdPzE26FH/WusjWZ0AhawuBtvzJuERKCp3iTZemNP0uy05MUcfqf4Ps/hPRBWK8NpWFcqTYuCJfI6YKCVfXvzhuyE8GSmsoP0ZvUfLGmD0GyFRfgol0Ta/SPig3bEsgsQ+8y5s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766413935;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=MIsebt+0bW61I/ZAHjyZRH22/kuuWpq+aRZENXzI4ss=;
	b=TRjDYwULCFJHHqehnDRLU6wUbi7vkT4D58/qj9qLat+kf0FTXu4HMHJpDd6emHHf
	DeY41iKV88Ka86M4e39dgSzWRKkgMDH/9rkAiVwrbiUcTVSC0pMBvieeH+mfsxetqIG
	y6pOHWUMgkppOXyteWMXESNdb9cLFMT+lh9N1LtI=
Received: by mx.zohomail.com with SMTPS id 1766413933869679.9055953780143;
	Mon, 22 Dec 2025 06:32:13 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
Date: Mon, 22 Dec 2025 11:31:57 -0300
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tamir Duberstein <tamird@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F4AEA7B-65E3-41E8-90BB-7F5896041FB8@collabora.com>
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Dec 2025, at 09:18, Tamir Duberstein <tamird@kernel.org> wrote:
>=20
> From: Tamir Duberstein <tamird@gmail.com>
>=20
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> rust/kernel/seq_file.rs | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> index 855e533813a6..518265558d66 100644
> --- a/rust/kernel/seq_file.rs
> +++ b/rust/kernel/seq_file.rs
> @@ -4,7 +4,7 @@
> //!
> //! C header: =
[`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
>=20
> -use crate::{bindings, c_str, fmt, str::CStrExt as _, =
types::NotThreadSafe, types::Opaque};
> +use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, =
types::Opaque};
>=20
> /// A utility for generating the contents of a seq file.
> #[repr(transparent)]
> @@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) =
{
>         unsafe {
>             bindings::seq_printf(
>                 self.inner.get(),
> -                c_str!("%pA").as_char_ptr(),
> +                c"%pA".as_char_ptr(),
>                 =
core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
>             );
>         }
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-vfs-55ca2ceca0a4
>=20
> Best regards,
> -- =20
> Tamir Duberstein <tamird@gmail.com>
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


