Return-Path: <linux-fsdevel+bounces-30221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E35987EFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5251F21B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6E17ADF6;
	Fri, 27 Sep 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SECq03ZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6A170A07
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420228; cv=none; b=HiGv0QAaKqXqS0WX3D/9n5caegRFYLfHz6XXXkhLTPidaHV5ilQRcoCwaXxCS15rp6T9tObDyv2LUOvD1cDJTZmrQrl2vT2ahV1dY8YGj2bKnjS9QZBi8UXWrQYcP5Jh++oxPAoVCZlo39ILXi4fEiGy86eAKJ4KESJ0HXnXWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420228; c=relaxed/simple;
	bh=ntPXSTn0XaL1bz+NWhec/AVUqU9BTy+XXCzoOAy9NCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjD7ZddJEQeQpDIounsA3rKKHCh9A3HcMsNNXZAEH+8bTVn58alPaadk7WWyQ2+AI8gGlpHi7V8tBOFxYjG3BoiZzTBNq0jvJ7pJStWUyc3jFoPsdIQondX/TvMqQDkoRm+TmYF5hZU0lP55yEQXJiH3JDrZ4KOTAa/mOhtUwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SECq03ZU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so15379065e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727420225; x=1728025025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqmPizVsqq4qdhBRG8AwKRaqHKBJIvPdTR51rrGTtac=;
        b=SECq03ZU2pg9DQNujkSYfZivqpvthEnMbafx09geZ4kG+VEiy01aL+XVPziekrQJ//
         DHMo4bPnWmOKIP1rZ7S1IOg2eNOAZ4iZcaH1q/SiVex7+KPjmGJRMtWnYw3RA55UQrdb
         teMm8RfyDaCYPNlBi+03Wo06oiMO5zztZI5x9bWhrCmEI8J7Z+38i4l0NIDrNjoqxLVz
         OSdz5l8Wrm1e4nDsl98RIDboD1P8GNq6wU82QIPW2pXPQcpiM7qKpuhgOf5OW1wvZ+nx
         tU+uksxDbBStzkmayixOmu0U3YZdXQ6QgeUKt0nK90PMdMgcZEQqLXPxh1xIdU9I0+Ol
         cBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420225; x=1728025025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqmPizVsqq4qdhBRG8AwKRaqHKBJIvPdTR51rrGTtac=;
        b=G3GfJuWhob8okr9uVzljW2y0xA3CdnmDKPdafLUNYqRUuh8v8o64WwPU+2EpKes651
         +ZTcl/XDNU5zjVwj1OchW34oCEXfpsglua+jdk93x5HgsqvcRo8EOQzYFNH1W173lozy
         CX23CYHaWAsnIe7c4udLy8YQabKiehdomWOsRV75o+wl0JddW3EadtHAjPBdpfj56YkH
         TXzNoKhw1W0FIQ5848QY0QFiHZTUCr1XjV7yvQ1q636I2gL0TgsnlHYLhvKElUK2ASCc
         okCrMs6GRcfqO1MbkxzJ9ikH+2cIenUqTuD5lMoOmMvM2jONl7BmzJtZO1LSN1HGOFPH
         fY0w==
X-Forwarded-Encrypted: i=1; AJvYcCWHx9K8A5u0VJiLYZ5SsbmypowG4cWiRoqPKuJ3A+JZf3aVgurkRvP4v/XPgsvyMhHrp2hfhDLxjlsPZDPB@vger.kernel.org
X-Gm-Message-State: AOJu0YynJfsRVZLEX2Nle/ek5wYDecRq+FaLS3oKnqttzmoANNudIqzq
	WWP5480rHm2VSJYY86LPwQ9sUOUkhQVDqgDjDphMTweqOs+ieR/NLLEWwZ6jSfc4DLp+ZVoczGM
	35zFxUZA2yjz2kbbKOLl6jC1PH2FWf2k7ORqB
X-Google-Smtp-Source: AGHT+IEL+etCLpk5OYw+YdsvWhveUaQTGppJFFWoWLIplEsVQRyrmKK2vppq4B4v8T1EMDfuPi9L4dAtpHeeA2VvdXY=
X-Received: by 2002:a05:600c:1c81:b0:42c:bae0:f065 with SMTP id
 5b1f17b1804b1-42f5840cf46mr13043465e9.5.1727420225137; Thu, 26 Sep 2024
 23:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com> <20240926220821.GP3550746@ZenIV>
 <20240926224733.GQ3550746@ZenIV>
In-Reply-To: <20240926224733.GQ3550746@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 08:56:50 +0200
Message-ID: <CAH5fLgick=nmDFd1w5zLSw9tVXMe-u2vk3sBbG-HZsPEUtYLVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:47=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Thu, Sep 26, 2024 at 11:08:21PM +0100, Al Viro wrote:
> > On Thu, Sep 26, 2024 at 02:58:56PM +0000, Alice Ryhl wrote:
> > > Add accessors for the file position. Most of the time, you should not
> > > use these methods directly, and you should instead use a guard for th=
e
> > > file position to prove that you hold the fpos lock. However, under
> > > limited circumstances, files are allowed to choose a different lockin=
g
> > > strategy for their file position. These accessors can be used to hand=
le
> > > that case.
> > >
> > > For now, these accessors are the only way to access the file position
> > > within the llseek and read_iter callbacks.
> >
> > You really should not do that within ->read_iter().  If your method
> > does that, it has the wrong signature.
> >
> > If nothing else, it should be usable for preadv(2), so what file positi=
on
> > are you talking about?
>
> To elaborate: ->llseek() is the only method that has any business accessi=
ng
> ->f_pos (and that - possibly not forever).  Note, BTW, that most of the
> time ->llseek() should be using one of the safe instances from fs/libfs.c
> or helpers from the same place; direct ->f_pos access in drivers is
> basically for things like
> static loff_t cfam_llseek(struct file *file, loff_t offset, int whence)
> {
>         switch (whence) {
>         case SEEK_CUR:
>                 break;
>         case SEEK_SET:
>                 file->f_pos =3D offset;
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
>         return offset;
> }
> which is... really special.  Translation: lseek(fd, n, SEEK_CUR) - return=
 n
> and do nothing.  lseek(fd, n, SEEK_SET) - usual semantics.  Anything else
> - fail with EINVAL.  The mind-boggling part is SEEK_CUR, but that's
> userland ABI of that particular driver; if the authors can be convinced t=
hat
> we don't need to preserve that wart, it can be replaced with use of
> no_seek_end_llseek.  If their very special userland relies upon it...
> not much we can do.
>
> Anything else outside of core VFS should not touch the damn thing, unless
> they have a very good reason and are willing to explain what makes them
> special.
>
> From quick grep through the tree, we seem to have grown a bunch of bogosi=
ties
> in vfio (including one in samples, presumably responsible for that infest=
ation),
> there's a few strange ioctls that reset it to 0 or do other unnatural thi=
ngs
> (hell, VFAT has readdir() variant called that way), there are _really_ sh=
itty
> cases in HFS, HFS+ and HPFS, where things like unlink() while somebody ha=
s the
> parent directory open will modify the current position(s), and then there=
's
> whatever ksmbd is playing at.
>
> We really should not expose ->f_pos - that can't be done on the C side (y=
et),
> but let's not spread that idiocy.

Okay, interesting. I did not know about all of these llseek helpers.
I'm definitely happy to make the Rust API force users to do the right
thing if we can.

It sounds like we basically have a few different seeking behaviors
that the driver can choose between, and we want to force the user to
use one of them?

Alice

