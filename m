Return-Path: <linux-fsdevel+bounces-41860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAFA38642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C88161BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC72224AE2;
	Mon, 17 Feb 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+jYD+cy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0D21D5B7;
	Mon, 17 Feb 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802100; cv=none; b=FKUkRDzSCV6es3WWN5ykKy0sRgy8oXfLSSK4Cp2aQ1TSMDb2WwRQa0SSNpiueWP+KE4Z/kgnTdujaDIjBybLmqXLi0Pz7h3gUbypMSYb/qGVO81CD4HnPKFLYlSoFoR3rlLgim4IjqpLszKg2uwxCsyqjLHKdFiZV4K09odzeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802100; c=relaxed/simple;
	bh=b+BDOtY28PRoYUYE8yr+F9bF1GHEoL0VulzesibFOz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca/m8HsQXzpUIQ6vi8gAUPNQZTj9QTs8MJlE/bN7fMQ9dMFB6A7vZZiglrqGj6KTdGVNKqdlMSQn1hak25oqVHxMOWmy6J4lxy78RcZGMw/dDEwLJqpSAU/SYgY4RsaKZ49xDDwp1lACwFHPg6IDj9I12CpN3CeaCUu3U8QEe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+jYD+cy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5461a485aa2so1297730e87.2;
        Mon, 17 Feb 2025 06:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739802097; x=1740406897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9y3f/0SpkUJYLfXQqSfBBJ/f7tgfpTc4dQswGoOc8M=;
        b=D+jYD+cyIdo6F8YzfrrkUDusUnYWQW/GXPUW9j12F6rVxGmbs7QaZeD8HI/xewPGXn
         CfGEuH6CvX3T7yvuQ+Trtz7eaTrpVgb02lPGKlZxKjA5PbfHR4NX/ceHYNN9M3ozmtEa
         Hc/tIr6bDq/JiN3hM7ahU8EgsDV4fA7EiB03DlZit43FdB1r/dyNXNZmrND6L7ge9djG
         3h639IWPDxOeDJCUsNd540qZtGSwd+gSPUWXnaVnI8OqGmXYytab5Qs6jT4hj0y4NIu0
         ReM7kDRJGZcursTslCvjo5LftF1GSaaYdsMUjgNLyjUHmtd1nw2xRZPkhp1DDvXRpdt6
         8OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802097; x=1740406897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9y3f/0SpkUJYLfXQqSfBBJ/f7tgfpTc4dQswGoOc8M=;
        b=oU+sF8Yu/r9ngFIvjMzXCmTOUfHAhaGF3TcwAYwMvwUp9NRkwlAdITJxjRrTwnPUca
         Nkq5nrsiXJmYp93krx34ZwdrduJ1IuHLFW5KkyaBD+sQMrm/wrCY8IPRL5kCBYdcBbcB
         b/eY9x3UZ0F1DYwWmocGe3ddw9G8xEPYJKGZsfJ2VyxnycAI+FQwK2+aNuvAg4BZvUX1
         tTwIORaOAYzCyPCR87qiaqlUAO0s/K/8MR3DauSSQIWJR1J+WnvV2iDxOu+nXJrQV0/1
         WgyfPFF5tL4cgrNtswoPcnNhyLyUiWqnHXPK4wxqVBhDPytXqkS2Drs5v45c2a0vmIk+
         KwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVboVPg6kAWedoCw9zwl6nW0gNQThMlNLa2HNuY/vZptbK6TY7rsnG9+nFONvqVYqGoeui4UBcVBt+DJQ8s4s4=@vger.kernel.org, AJvYcCWVnVmVoUG7gyzx02I9VMjM9mX1BLzWUYMAh16XkLiU9WeBjtNjRwuE9JQfgqg73e6+V7JqfsVthMh9G2ul@vger.kernel.org, AJvYcCWrN7SrxunwsAzYZA+EETF2amxRrz0yNLicqIAFgUHCPFSQRYIc09vA3V4zytFVO2lVoAqti/LxqwwS@vger.kernel.org, AJvYcCXquTER0VAGj8A7jX1CXIpdwOYmC0SJq8SbfFDb++tQA9f71v4oKykdDtdwbhtSKvBJwB+B7mvGCVp92fnw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gjcLJobEoCcp1tcDtMKlz3Cnh6AFk+kZR/8lFTC04zKBbGlW
	WioVMOWxChD7UdADmwGmkFGjQbLEh4K7L9PfRwuxa19p+JW/xmN+Puu7JO5bo6VQqRV+8HJDqe+
	lfYnRjEf4o0fAaiMFKUpg+jj2hM4=
X-Gm-Gg: ASbGnct4niDMqKQEvqjcQXn0A5m3g5DtZIOZleKrOAe178DdB3BQkXB/fnL8IoEJ4Nx
	ILl+5ECWnuOVum6KX17WeaQL1CfG744KV7B6wQR+8k+BU/HY6ZijaO9F3hdft6t2tL1VNhhFKqQ
	Sk36JajIhuv4jwirRwUobiz9JXHyf1i9A=
X-Google-Smtp-Source: AGHT+IHhtX8lyyXmg8SrYa93Wy6T7OyCMr/8E0Vv+nyULl+zxuUh3oHTtIYdD4cTdU1J+8n2uF+C3K3dJb4b0t4B/Qk=
X-Received: by 2002:a05:6512:6ce:b0:545:c89:2bc9 with SMTP id
 2adb3069b0e04-5452fe8fd0emr3279031e87.43.1739802096408; Mon, 17 Feb 2025
 06:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae> <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae>
In-Reply-To: <Z7NEZfuXSr3Ofh1G@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 09:21:00 -0500
X-Gm-Features: AWEUYZlLWtUHaT2OrSDFV3xDEpeuj4fhWmWRhd94UqW6lapme1fdjrZlxF0hTIc
Message-ID: <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:15=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon, Feb 17, 2025 at 09:02:12AM -0500, Tamir Duberstein wrote:
> > > > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > > > index 6c3bc14b42ad..eb25fabbff9c 100644
> > > > --- a/rust/kernel/pci.rs
> > > > +++ b/rust/kernel/pci.rs
> > > > @@ -73,6 +73,7 @@ extern "C" fn probe_callback(
> > > >          match T::probe(&mut pdev, info) {
> > > >              Ok(data) =3D> {
> > > >                  let data =3D data.into_foreign();
> > > > +                let data =3D data.cast();
> > >
> > > Same here and below, see also [2].
> >
> > You're the maintainer,
>
> This isn't true. I'm the original author, but I'm not an official maintai=
ner of
> this code. :)
>
> > so I'll do what you ask here as well. I did it
> > this way because it avoids shadowing the git history with this change,
> > which I thought was the dominant preference.
>
> As mentioned in [2], if you do it the other way around first the "rust: t=
ypes:
> add `ForeignOwnable::PointedTo`" patch and then the conversion to cast() =
it's
> even cleaner and less code to change.

This is true for the two instances of `as _`, but not for all the
other instances where currently there's no cast, but one is now
needed.

> >
> > > I understand you like this style and I'm not saying it's wrong or for=
bidden and
> > > for code that you maintain such nits are entirely up to you as far as=
 I'm
> > > concerned.
> > >
> > > But I also don't think there is a necessity to convert things to your=
 preference
> > > wherever you touch existing code.
> >
> > This isn't a conversion, it's a choice made specifically to avoid
> > touching code that doesn't need to be touched (in this instance).
>
> See above.

This doesn't address my point. I claim that

@@ -246,6 +248,7 @@ impl<T: MiscDevice> VtableHelper<T> {
 ) -> c_int {
     // SAFETY: The release call of a file owns the private data.
     let private =3D unsafe { (*file).private_data };
+    let private =3D private.cast();
     // SAFETY: The release call of a file owns the private data.
     let ptr =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private)=
 };

is a better diff than

@@ -245,7 +245,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     file: *mut bindings::file,
 ) -> c_int {
     // SAFETY: The release call of a file owns the private data.
-    let private =3D unsafe { (*file).private_data };
+    let private =3D unsafe { (*file).private_data }.cast();
     // SAFETY: The release call of a file owns the private data.
     let ptr =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private)=
 };

because it doesn't acquire the git blame on the existing line.

> >
> > > I already explicitly asked you not to do so in [3] and yet you did so=
 while
> > > keeping my ACK. :(
> > >
> > > (Only saying the latter for reference, no need to send a new version =
of [3],
> > > otherwise I would have replied.)
> > >
> > > [2] https://lore.kernel.org/rust-for-linux/Z7MYNQgo28sr_4RS@cassiopei=
ae/
> > > [3] https://lore.kernel.org/rust-for-linux/20250213-aligned-alloc-v7-=
1-d2a2d0be164b@gmail.com/
> >
> > I will drop [2] and leave the `as _` casts in place to minimize
> > controversy here.
>
> As mentioned I think the conversion to cast() is great, just do it after =
this
> one and keep it a single line -- no controversy. :)

The code compiles either way, so I'll leave it untouched rather than
risk being scolded for sneaking unrelated changes.

