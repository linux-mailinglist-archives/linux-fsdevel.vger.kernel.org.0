Return-Path: <linux-fsdevel+bounces-13066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385486AC52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7709A1C225AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F8129A96;
	Wed, 28 Feb 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elvRkRKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D558109;
	Wed, 28 Feb 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117074; cv=none; b=Jeycb2t6gbRf1PX/CO1MONbtRls8LtMbDgiM+rlXQEAVqYDSYwrlUkaFfQ8I5dfS8gtg5DpYkZk43Mlfoj212opFBZ2gVrer0qeIAgVL/WdIsi3//+AA0kKFoUM377ufFu+bdfJS1y8C/xacm9xF0Z8krllDbALcYWGcTH1Uhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117074; c=relaxed/simple;
	bh=eAEAf+3/cTqSfefPuAIn0EFwcvK6fQ9vrTIgIRspf0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNkl58sd+4iVwvQRAOnOYpsQcIpYulnESRmpZ7AJ7aDf03254p9LihezG9waC5BjMxqyTQMkC1RtgdjzwBQFNaEY0Gv2IuyvClE15w0yDlqdlymMHkEYZyW2mjWrexgLXji/zK53Ch56SvasbowcJBtk3tgKTocveY5bWAjT9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elvRkRKm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7881b1843so40411975ad.3;
        Wed, 28 Feb 2024 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709117072; x=1709721872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9vfSgvkXQz+Zjx8h8IZTfVZY7/XwdE9jptIo84wCVM=;
        b=elvRkRKmnQd1DrgsqZRRBMxfms6cXDMMExwSJ+lWkWaouOO9yZ/UM89wetgaaPp5LX
         ZIO3Tzz+D+U2gTvHNFo9NOM2yUV79zxZ1bKiQGJxfu3MTViVdMNL+vsLmJLRxnY/4bH0
         fB327TS7QxZ7v8CpUgnZtpI7XH+a1/Kgckeyb42Yhl8Vx2SvbqukAKRxJjuCcXO35PCj
         ttoQQxwqzMhVBLExQ8Itq3rXaPVGntxkYm2C5GfbiA4ZZS6zuKKlGnCw/KURrN3tU9vn
         s+FdD8xEk7O2HVe6N9gUQaLBYp/pSqrp0GiytMQyGS6d2lY0u2Hxf2ZIklNEdoHCawYX
         wpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709117072; x=1709721872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9vfSgvkXQz+Zjx8h8IZTfVZY7/XwdE9jptIo84wCVM=;
        b=SgJ/n6NxZkOujEca3sMEdHMXuPiDxjnl1DpN+jbMnxkjGBIMw2Rhw9uKZM3tWAlldF
         pKSkcvbyBQbqsYdT4Yp0u/9Qkq+S8SCZTSn5XvczEOlzdMjokz8bMQcR3tQkB8V+8BFM
         OM11f2+tFRNQ1FPVKgcz6uGwa7ncJXYCpEzta4B/W65ugdhyf+Q91wBQJxbcbQLG1XrF
         IiCUvUtMYMHbov/jpkkfbYRftdrJFdxicXOfdpVptuBAyBJv1SxDQ4+cYxKpySfVmdGn
         yzURe+2obIeFUGEB/uhDuP1d13ofvJhQj7KMiR1TbRMT0ApaGDUjf7MAohYusIjxgaLx
         Gxbw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDMApY1LrsIPQU3bjXd3IGd7Axkff/nwu7URke5YET5wC63Z3dTPHBWltryXB68Dl13/JHeXBo5KpPtEJ73tYAzHVSTjBOEVMrogzk0ZGQSA5QD91eR9gVmT9dn5Q12A3DAAMGwFCEV+WAmUY
X-Gm-Message-State: AOJu0Yw76xPB876o4lBvEvUT44Di1TnpQBxzsiEAke9tOMJqfUqih/QW
	no1PlAf5Lm9mjGSDuqTEE7fsnRYPKFDrS+ImctaxenZxdtgP3W8I1ALYuX8kiXqKMZxJPl7koI8
	uTrdTqsaMmZo86XV7aBc6XN9e92KSVIriwLU=
X-Google-Smtp-Source: AGHT+IE5u46q2ovqlyhPbtk/dk/hRqSZeU8jqAMVNQO0XqbMQ+axszRmaUtUOaxYLJnXNLO/QWACCPdcwwPlmMvToVs=
X-Received: by 2002:a17:90a:a417:b0:29a:6f66:db with SMTP id
 y23-20020a17090aa41700b0029a6f6600dbmr11356458pjp.5.1709117072199; Wed, 28
 Feb 2024 02:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209223201.2145570-2-mcanal@igalia.com> <20240209223201.2145570-4-mcanal@igalia.com>
In-Reply-To: <20240209223201.2145570-4-mcanal@igalia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 Feb 2024 11:44:19 +0100
Message-ID: <CANiq72nNAYERpeOx5Q4bMGizQfx=RCpR8NukiYCbRHx3-93Vpg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] rust: xarray: Add an abstraction for XArray
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ma=C3=ADra,

Thanks for keeping up the work on this! A quick "nit review" on docs/commen=
ts.

On Fri, Feb 9, 2024 at 11:32=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> +//! C header: [`include/linux/xarray.h`](../../include/linux/xarray.h)

This can be migrated to the new `srctree/` notation:

    +//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.=
h)

> +/// Flags passed to `XArray::new` to configure the `XArray`.

Please use intra-doc links where possible, e.g. this could be:

    /// Flags passed to [`XArray::new`] to configure the [`XArray`].

Sometimes you may need to help `rustdoc` a bit -- you can check how it
is done in other places for those that may not work. Of course, if a
particular instance gets too involved/hard to read for plain text
reading, then you can ignore it.

(Same for other instances, e.g. I see `None`, `Vec<Option<T>>`,
`Arc<T>`, `ForeignOwnable`, `Deref`..., also methods like
`into_foreign` etc.).

> +/// This is similar to a `Vec<Option<T>>`, but more efficient when there=
 are holes in the
> +/// index space, and can be efficiently grown.

This line seems wrapped differently than the others nearby -- in
general, please try to keep comments at 100 columns if possible (or at
least try to be consistent within the same file).

> +/// INVARIANT: All pointers stored in the array are pointers obtained by
> +/// calling `T::into_foreign` or are NULL pointers. By using the pin-ini=
t
> +/// initialization, `self.xa` is always an initialized and valid XArray.

Shouldn't this be in an `# Invariants` section instead?

> +/// `Guard` holds a reference (`self.0`) to the underlying value owned b=
y the
> +/// `XArray` (`self.1`) with its lock held.

Should we use "pointer" here?

> +        // SAFETY: By the type invariant, we own the XArray lock, so we =
must
> +        // unlock it here.

Please also use Markdown in normal comments too (like you do elsewhere).

(Same for other instances).

> +            // Consider it a success anyway, not much we can do

Period at the end.

> +///
> +/// # Examples
> +///

Is something missing here at the top of these docs? Or what is the intentio=
n?

> +/// use kernel::prelude::*;

This line can be removed -- it is implicitly added in examples.

> +/// let foo =3D Arc::try_new(Foo { a : 1, b: 2 }).expect("Unable to allo=
cate Foo");

Please consider using `?` instead to simplify the example, you will
need to add a line at the end for that (see e.g. `arc.rs`):

    /// # Ok::<(), Error>(())

> +    /// The type is `unsigned long`, which is always the same as `usize`=
 in
> +    /// the kernel. Therefore, we can use this method to convert between=
 those.

This comment sounds like an implementation detail, rather than the
documentation of the function.

> +        let mut index: core::ffi::c_ulong =3D 0;

This is `use`d above, but here the full path is given.

(Same for other instances).

> +// SAFETY: XArray is thread-safe and all mutation operations are interna=
lly locked.

Ideally we use different comments for each `unsafe impl` and we
explain the rationale for the bounds on each case (e.g. see `arc.rs`).

Cheers,
Miguel

