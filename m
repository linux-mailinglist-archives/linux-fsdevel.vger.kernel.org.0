Return-Path: <linux-fsdevel+bounces-72354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86014CF089D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F2E301D598
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45552857CC;
	Sun,  4 Jan 2026 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvnXBvWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C532472A6
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493791; cv=none; b=ty0sGBYhqU7d7Gh7NjeiQudfh+yu27ltoh/V2J4wlY4aYiWB6X3byIFiY31KAU3hWug+w4xfaia2DUBkJAMyq2QaZIFkbP4cxPEfS7buOqOxKvIGyjyZzfQcOhvgAokDIRGV+KPDBV4mzloxzlMGXzO0zAZhIiEpJyVetC0YCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493791; c=relaxed/simple;
	bh=P+PY7OymFb/4N9KP/lPDwhjGpPFBU+3pNPlDxFn26VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0NZZPPtdJD3Ou3ICTEdG+fP48Q6LJ4eWN2cqxDwgWlXEUM+tW3jb7POvmYgrX8TPHklxitKYnKryvIVvZkGeBUFHXU23VkfM8Ndekgp5yctU6F04qe/NBplKo+bShumY9x9qoQgS+KlwHnpUqtGFMnWaG1dbuhK/TB+Spv/1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvnXBvWV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37cd7f9de7cso110762971fa.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 18:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767493786; x=1768098586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zETYNPHIFMkBIdZl2aEi7jhtGoaurx1nMtILAMqUgkk=;
        b=YvnXBvWVLwnx1+vlD/gL81JguU8zhSBJygXKVNwQMKQvs18Oh8kfzfSyUCJTU+yjRT
         693InVHfuQOkOe3b3dPQ30Pbn7Lb+3A+uwPRazcuQgrD28Ja7rvJ/vqOwpVdc9RtWk3u
         XtBlcvoA0wdxiv6Ec3KM2m1bVCrZyd3wBtO4TVGeLiCGJFozZBc0vneRwRiNpYivoFjb
         rmC8aFVdGcSfDaWIgjPUbC8Tqi5JJX7VhGRN+oxUg+D83V8rD09VNTMH/8ljBu0Aeonn
         1tU4FlUwiOhCHmvbMX7OIWM3B7Usqn1z5nDTBlLNfo0GUwEFYVKtqpMl6txLYEIBAbim
         ikjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767493786; x=1768098586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zETYNPHIFMkBIdZl2aEi7jhtGoaurx1nMtILAMqUgkk=;
        b=l0euUNyWKT0LinaYs8XVk6Y2L7g5bAlV594zh/r2f3Ia4GTHDDecClCA3+WK0RqVxN
         ehiHYMGjEcz3ZBleaeMCq39/Ytx9At26uDieHIpA/hmJTccElQEFFRYcCg0gGbSu6iiJ
         sSEPSJ5FpL9s5Z8SuxH8p0FUE5GMl3zgUOjC7PzqFfKPZAtlTI7g+szhbxMue7QjQjfT
         7Z2u2Fg+GCzOCek86V10MBi+442q+w0jwoQWwpfVb4A3INfBzrOOmgA3qUzcTmMwInDW
         WaLj+LG3+O14I0Vjk173zWVREaDjJbcdFG2o1kmh+QiFiKQcYDja9CJUOFvOLNoanGMD
         Qmig==
X-Gm-Message-State: AOJu0YwOTf/xyA02WjJgSQQ2wjpLq/qqh5CEQVDNo9HtTknTSixGr3NO
	9XlRrORKs3LnA4w3dOseh6L8PGFj9s2DeeAunzFsMnT7sDQPNqqLVA/e4FAK6CbXl1e/uS1T+aF
	9cqWxUzb4F5ytd0BGPmWC4AFJ8NazbH4=
X-Gm-Gg: AY/fxX4JfR0uHIoId5S+EDGUk5zUwSvfRr+Q9Jw6t2yVjCEbV+YEt+a3sFznYQvGT+e
	DpIKWUS4xrGh9HtSJSF/Gu6E9/4/u5wCq715tw0PZYAGpxLFN3n34zpZ9vlCwUi0U+eeSnkCb++
	rxMLtndTpUdXLYgBGcDof6NESXmv+IYvJpGXnTEyYPg96FjYeuUa6imBnJgxtbsI02Dv6zlLc24
	V5+a2QllDk9EbeUQEhLztHbzzTrrAIcOcxr2Gz1UYj6JazidX6z2klWJLV/coYUY/w01nMD1BAl
	SfIaMibRpTweJc9/cb+ktHhUmCp/Sv/S4DpkR8Hh9GTCu8lMtUIaL02+XixqacRofEkhWaJK6bp
	/XDdIlSlRs0XGoo7tL0GVQc3FJxWGX8iyjL7ZEnBVUQ==
X-Google-Smtp-Source: AGHT+IEkeF149vCKkv131U29TT7uWwUvDBTWyqILbhkq8xrmcL3uGcHe6zXBC00ZBwP4ptWq6LmgDctKC/u+p834rdw=
X-Received: by 2002:a05:651c:a0a:b0:382:8844:2080 with SMTP id
 38308e7fff4ca-382884420e0mr60448961fa.25.1767493786271; Sat, 03 Jan 2026
 18:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
In-Reply-To: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 3 Jan 2026 21:29:10 -0500
X-Gm-Features: AQt7F2qv5FlJRZgMoO2uW18PvkkkOZyVxcSR3j5bBanFQJE8sULbQYbFPqIB6Qg
Message-ID: <CAJ-ks9kDy2_A+Zt4jO_h-=yzDjN024e1pmDy4kBrr5jsbJxvtQ@mail.gmail.com>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 7:19=E2=80=AFAM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/seq_file.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> index 855e533813a6..518265558d66 100644
> --- a/rust/kernel/seq_file.rs
> +++ b/rust/kernel/seq_file.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_fil=
e.h)
>
> -use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSaf=
e, types::Opaque};
> +use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, type=
s::Opaque};
>
>  /// A utility for generating the contents of a seq file.
>  #[repr(transparent)]
> @@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
>          unsafe {
>              bindings::seq_printf(
>                  self.inner.get(),
> -                c_str!("%pA").as_char_ptr(),
> +                c"%pA".as_char_ptr(),
>                  core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
>              );
>          }
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-vfs-55ca2ceca0a4
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

@Christian could you please have a look?

Cheers.
Tamir

