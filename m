Return-Path: <linux-fsdevel+bounces-73058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A78D0AC93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 16:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC0F305FE1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DE319877;
	Fri,  9 Jan 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxBfn8P8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EC312816
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971010; cv=none; b=dmFxsyM99+KvF+JT5OF8wOtI4HMVWtA8cmg0ER2SFoPsojmjsnsyBkuTkVRkZ27PRsR+Uv61dmaqlB97qpEwzvLgKRsWWCNqh4kIWtU/ql4rvfdSAZuDMTDS4KD47kJX2Xettkay7GziSwreZtle7kds4PnK7VyLkCnG7HYdA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971010; c=relaxed/simple;
	bh=hXxVXVaouU1m7bKeW90B1Cx0EW6q69cKmYxcFEdXAGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jusc/9S4EPyfWm1BJJ45PMjpgIVqhKaPFATQlETJcHqHe8zsaPkZvDQ1CCd1amEUl++O7UtUW3h3YhrYD3mmQr/ZmP4IcgtzXcczMF1hUHKhzzYrH5kbyMvR2dlHwIcDxqPxx2u713yDb495jCmN2ILz/DVv2mEvrAedh9TiFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxBfn8P8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso2568026a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767971007; x=1768575807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLz1QdCXIkvGA9Ksv1Gt+nsYTAK9kqraMEt2aRWqXY8=;
        b=WxBfn8P8KOR85tSmIf4a2Iejelk+kDCl26jqDwDQ+oVru9BEDiNZA7kRmGcbay4Ewu
         UlGDOcl407m7QMgnzPCl+lTU3O/p6E0KOV5CB7Z1IY36hFLrzkAMHCa0Qj7HgPddqgnz
         1RzTwP6BJTluA9+kJD0xcdm+Iflzv5UdnSvkcEnpjEFwrXKj5Yhayzbpdd9HYPpqetOU
         BsWekrbKOFz8nnLopX9Cs/j+MXXW7J2q5h2Md4GZHCFhi7OcUJfMNzpTo/YasouYD1yg
         nzTutNMw1mwK51DKvtn8dlJqvAYL9P/mEDEJlEuBYczpsDJqAgI592ARUDwB/TQ7VtXz
         EjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767971007; x=1768575807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLz1QdCXIkvGA9Ksv1Gt+nsYTAK9kqraMEt2aRWqXY8=;
        b=LArC2nUVLInNCyy9rkM2DrToyHpRFdT7I8a0evN1beWB/tFG5AVpBBE6iYQ9o1szJu
         EK24/88pqdxg9i/KKas4Rek7d+DjofM6BA1+5uovlt9Ot1glFppjPPm+BexYGeSaLksG
         oTuGwL/iBaI97OajK8e+6TJgmrtB9fDz8Jw0XF6mCkNDvWHW7WKQnXe0sSPV0DSWZO2w
         9iQUz2Msr7m+Iq1cN/AzDf1gDgAn+dPGsWf4/O5cjyCXEV9BzdO+TA4PWB0Rf6A59kl0
         5d54BRBAFdB3tzC76/rG9wCwJ2/vM5IOIHvvWtzr6MRvtuak4g1QSHlxo9QA4a+kJr/5
         P4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWIVo3Njab9vGxcramU3v3fCKJCfJ8a4xTb8gRhrzJ00EZM0d7t5CJcYhsBZGUWwB+VFEJNCqyc6S2Qc5ya@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQlFBRCrSxuPAtX1vaOHyWQRte5/4RWkv5dCB8MPtUvEW4HGy
	8A///9OzTEIm6MS6gQQqti5ANVB7818MMCxBj8iIrqfHwEYZr1tlv8PGDJAQ2eSFel5wxoouGGY
	6l4ao7D4m5WZm+jW/WuW2QSu4sMMsgNg=
X-Gm-Gg: AY/fxX5Acq70rJmQ7ua0AgkNDiSCwjqNl+rR2tOYNk4ghOyhuJGF2/VAYWVMVdTbnvq
	4/RidURiJbTKP8ba6eHCLDh0NY3CWLRa16gwDnOWdCjzU2Shbtx/bFPOYVwZ3Q1eajWxFWy165Y
	ExhNz66yZve+RtnDUeIlDShmieIrG2UZ1nFYHcoAVXGcosNxFpExPUh0vwzuUyBd3wLx9XX4bgR
	qh5QWmto/qwTcno2rInhRkCskxNjq9V38ocr31uu9+aNRJT7ZN/EY+LmP4rD3tqx0tN4UZynQkk
	T9qlZXC6agF7zdd1mMFERXnymCTqjQ==
X-Google-Smtp-Source: AGHT+IE5AtQRM9lTlFMz0mzpOfJaEwbxVP5DIXCiavFmJUuGO+dxJlvx5R5E/fqRPLX0B+QiLBfSqwrvNCiI3mtqfmg=
X-Received: by 2002:a05:6402:50c7:b0:64d:1294:42e8 with SMTP id
 4fb4d7f45d1cf-65097b6085amr9948005a12.6.1767971007282; Fri, 09 Jan 2026
 07:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
In-Reply-To: <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Jan 2026 16:03:14 +0100
X-Gm-Features: AZwV_QgmFLPAy8wto0nuHpXSZmUatMPCHTGjqKmIpaCDyR9d_wRAgWeJCiA84iM
Message-ID: <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 1:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 Jan 2026 at 12:57, Luis Henriques <luis@igalia.com> wrote:
>
> > I've been trying to wrap my head around all the suggested changes, and
> > experimenting with a few options.  Since there are some major things th=
at
> > need to be modified, I'd like to confirm that I got them right:
> >
> > 1. In the old FUSE_LOOKUP, the args->in_args[0] will continue to use th=
e
> >    struct fuse_entry_out, which won't be changed and will continue to h=
ave
> >    a static size.
>
> Yes.
>
> > 2. FUSE_LOOKUP_HANDLE will add a new out_arg, which will be dynamically
> >    allocated (using your suggestion: 'args->out_var_alloc').  This will=
 be
> >    a new struct fuse_entry_handle_out, similar to fuse_entry_out, but
> >    replacing the struct fuse_attr by a struct fuse_statx, and adding th=
e
> >    file handle struct.
>
> Another idea: let's simplify the interface by removing the attributes
> from the lookup reply entirely.  To get back the previous
> functionality, compound requests can be used: LOOKUP_HANDLE + STATX.

What about FUSE_CREATE? FUSE_TMPFILE?
and more importantly READDIRPLUS dirents?

How do you envision the protocol extension for those if fuse_entry_handle
does not contain fuse_statx?

Thanks,
Amir.

>
> > 3. FUSE_LOOKUP_HANDLE will use the args->in_args[0] as an extension hea=
der
>
> No, extensions go after the regular request data: headers, payload,
> extension(s).
>
> We could think about changing that for uring, where it would make
> sense to put the extensions after the regular headers, but currently
> it doesn't work that way and goes into the payload section.
>
> In any case LOOKUP_HANDLE should follow the existing practice.
>
> >    (FUSE_EXT_HANDLE).  Note that other operations (e.g. those in functi=
on
> >    create_new_entry()) will actually need to *add* an extra extension
> >    header, as extension headers are already being used there.
>
> Right.
>
> >    This extension header will use the new struct fuse_entry_handle_out.
>
> Why _out?
>
> It should just be a struct fuse_ext_header followed by a struct
> fuse_file_handle.
>
> Thanks,
> Miklos

