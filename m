Return-Path: <linux-fsdevel+bounces-74439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACBBD3A986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 13:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC764305D925
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC63612D8;
	Mon, 19 Jan 2026 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqPi62ZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C835C1B8
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827217; cv=pass; b=o5lZWthYv296LwjC6sUHx0I5VC7I+VRlHdeOqGneA3V3jRHLPugZYeOC59BWuj+g9+tP/zDkwhPg2S1X5omO7t6IjNJa6GlIPW2HBRhyOz/SXNfN45sBeDgcLx01KIIa88iNQadtXQFItr3QEjpb9D6T+3CRcH87XHcqZ+gWJgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827217; c=relaxed/simple;
	bh=YZwcfNScRsx1/EsPon5hCX7NfuMYhsvwgxsgFvy0h1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfHTbAaRLsEE5amA7ZBMIw5BrMlOVji2EO6PjG10CGUa7gGF5MVb4jdUzovWBS1brYuKPj18J22p96rlOCKGmNGBxlcxUU5WEQTUu3dhbRultFAD0XcvnImPyCE5FkS7vUP3M2rC4zhtNMJovhp9Tu0fnZylr5UeVgnOq/ydOZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqPi62ZK; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b679cff1fso3809526e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 04:53:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768827214; cv=none;
        d=google.com; s=arc-20240605;
        b=EVBiykyflS3g8MAW340YYuS6YJ/k/PFb7IkgXdg7iI+FE1mdctW4V/A2ilxgZt8iy/
         nbO1tUKw4heWCg100CXnAsdHXQlw1Ga+0vdkI/lOJzsjtkN4+MYJpD5g4PbMigxlHUPr
         W5vl1KljIK2hk3PJzZAYO+uartrGN9d9tcn4AZ7cqNGk3+CKJ4mFkBHrqla9TT140Bxf
         Zz4eTvICSDGdrR1vczst3Lj3E6bikw2f8wGmHy+Eu/AdMlDVVNnIiDsGRIdLhGggZfpp
         WQMUTs7vOBdjnAOAN4BuHR6x5o9l00fRPqqEyvHBnJm8/YBEH5Dbcmpip3b3E5FpENBj
         Obfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=snwDSZWY2CM1IgkVFFgRZzAyAPdnSLxoi9J0awy7G58=;
        fh=4xdoWg6KGkYu0BalEUGa+kx8YnhUIuBKSzZH15Y0F/g=;
        b=dSgQYYJXRsJGnZaZgPdfJ+DuUKozU8E9fGiWF5Vqi7xE5UzZQBGvr/oUkmjLwh6/wi
         E5dbeQ4J+y2Jcz2k3e7qUj10MZro9/xUH0AEME4+SiGXZQvdgZXeU7v0KnY9vhbUWaHx
         10+Oq5hmjI09+ydJmyAZBx9/5n3TjdEb4o07MHa1TCVDq/gIgaqnKw3eYAhgZ9bPmiHC
         CxRbmDE9CmTBQI/4A0QaNL5m+CE4Kpp4eao+KESiPEhvmxULTXEbp+9vSg9EhnhXj9oD
         U8fB6Y56qmHZp5kXwd+qmip8dZyKhNfzJ4uCVvvEHRp7gXUWZdzBKLibQmW8/OBOMTyT
         3ExQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768827214; x=1769432014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snwDSZWY2CM1IgkVFFgRZzAyAPdnSLxoi9J0awy7G58=;
        b=EqPi62ZKvsVugyHv7g3/t1rcjeKCMbPrjdualZnBdKvrG4nyPQri8lSKXC3cL/xITe
         Pbuny+JtQqKRnUMVBO/lUr8Iig6IMlMA1NqSnAECocPV87P8ucUhGDslVIAJIdE9VqTY
         MDTt/TyDNlxMAKoyx0stc1Cs6ItH0qhG2Z9aRe4DV3QlYidrnZruhoYb+Dhsoyjto4E2
         g1KfYHuoW+b1dEdRCB72HGIJ97Okg7IrjZT95oD79lV6IT4V+kjDU58YJZFEwyYlVpx+
         /PQZwENF7dP+9gMyoxJKIngeMg3fd3mLDvK2KJGN4O0aWkeh7O4y7pkcHZwOg+T/2iXz
         GYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768827214; x=1769432014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snwDSZWY2CM1IgkVFFgRZzAyAPdnSLxoi9J0awy7G58=;
        b=fkigBxS7rXoqdLnes3RkaKFcGJvqIC6NgIGorih+YZnr73Y3frZiUfvZSjPKrrH7Ye
         ajhxCmKaOtTwOBPmfrJ+vHcGvgQ1H7RZmHYUIEGEiZ7JH7sqQ1Rwb0aAu1uEPASK1LU2
         hUN/M56PSW0aoU5tHj8zwruz3003MgAN84KQFUQpy1UkffEyDQ5rZvC6KuAiBc1giUpo
         oEWgJcbWt6my0/12XwuVqEimF0amv/SQP5ZKST61Rn12A+j75xIjwp2rrmiwZTMMzn7b
         MenDU0N7OSetV/eE10cDZ9YJh0+aywSw/Co5+Do78xc2pfvnxAxyZZo9xUBoUdVvWvsI
         GyaA==
X-Gm-Message-State: AOJu0YwMNWqc08GrPX2hsbGLmbEo8PPBsx2jVa9hIgicvXPGEOPPxcOi
	uYkrtyoP1NUeeEhpE1QdXG2GeIxLwdvB+VV9yzEKw0sxh9AKqu54g34iwYW3xWl2Tfu/xuABB0T
	JYlFADw2R6kmcGm7Md59+WBAoaj83Q/o=
X-Gm-Gg: AY/fxX4Hs8HCzEva5YzRoEc/kjFF4WTdovUF+OTssN6owgnBNl3RM21mWc3I4ADLcjE
	GZuXHsRd7hyY8/9iY54V4TWWQk5DvjlZr/u+451ZbSfuvFnVbLYwajmfdD1ToGFv6/0Sl0FUqnQ
	67nymeE9ax5nTazvGUJqaicAnbGOpQkEXT4hVm58R1rh7Lr8Ru0jwzQuyd1y+E5Ty0kvr+twaZP
	ccSIp6X6hInjp66U7UQJF0dlSqZw0QwSavbIaOiyuotekBtGWQ4aVZtUG7vEc4whmjKvii9xGHt
	xW+Pk+yKZHhMGi3CxeRI4QLYEUVLiC/JQ2WTlQ7NnaP9ZbF/YadbRNafWGobIUtLneHW/9JJK29
	fhHzU7Fv+CXEILHTHizSJUZgJvMcAuPfRk2KFOyN4MA==
X-Received: by 2002:ac2:4f15:0:b0:594:25a6:9996 with SMTP id
 2adb3069b0e04-59baeec5a5amr3541217e87.10.1768827214250; Mon, 19 Jan 2026
 04:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com> <CAJ-ks9kDy2_A+Zt4jO_h-=yzDjN024e1pmDy4kBrr5jsbJxvtQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9kDy2_A+Zt4jO_h-=yzDjN024e1pmDy4kBrr5jsbJxvtQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 19 Jan 2026 07:52:58 -0500
X-Gm-Features: AZwV_Qgn2I6o91taUKgGtxPmZ_aVxaQ6vxTGrdMI9tisi8uORrSygvdMrRfrp20
Message-ID: <CAJ-ks9nZA84HYL_7+raFvcS1G77O7FyHk7_fsPMYuv2K1Ecp8w@mail.gmail.com>
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

On Sat, Jan 3, 2026 at 9:29=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Mon, Dec 22, 2025 at 7:19=E2=80=AFAM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/seq_file.rs | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> > index 855e533813a6..518265558d66 100644
> > --- a/rust/kernel/seq_file.rs
> > +++ b/rust/kernel/seq_file.rs
> > @@ -4,7 +4,7 @@
> >  //!
> >  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_f=
ile.h)
> >
> > -use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadS=
afe, types::Opaque};
> > +use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, ty=
pes::Opaque};
> >
> >  /// A utility for generating the contents of a seq file.
> >  #[repr(transparent)]
> > @@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
> >          unsafe {
> >              bindings::seq_printf(
> >                  self.inner.get(),
> > -                c_str!("%pA").as_char_ptr(),
> > +                c"%pA".as_char_ptr(),
> >                  core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(=
),
> >              );
> >          }
> >
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251222-cstr-vfs-55ca2ceca0a4
> >
> > Best regards,
> > --
> > Tamir Duberstein <tamird@gmail.com>
> >
>
> @Christian could you please have a look?
>
> Cheers.
> Tamir

Alexander or Christian: could you please take this through vfs or
would you be ok with it going through rust-next?

