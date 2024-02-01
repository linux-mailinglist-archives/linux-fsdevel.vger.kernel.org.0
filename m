Return-Path: <linux-fsdevel+bounces-9858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 080438455A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F51C22A39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174E15B97E;
	Thu,  1 Feb 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5U3JXfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2915B961
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784113; cv=none; b=g3LlwWNt7Oqq+5EONgadLJknrX/AlU/arReQr8ieDDrgraEMzbpQut+BME2BkIQ56Xw8q86gY4jfLPBh1hRBp7N/Zgvd1fvGZPaJ0tssGLTEwJ85/T3VzlMREdekT9n7cqC+rdwp32jTYBZgncfjGKHjwIuC72sLmHink/6cpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784113; c=relaxed/simple;
	bh=G3PK4B/G7TI5S7RoTH00yBZOZBUAtwikxhzyCcmhOu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixf5+cBCa03E92GhtWjum3XGTFfyfiyJPuNyT8u7jAgQUSRNMbThV0CkeIYyaf2tdnsKmYKoeP3+V8JVs/dGtYAWn+EhkKHeAMooutOTxcPZz7/eakNE0btAmCTnQfzin7HOpWSLRASo4iwmFfuby0ZqEfXsqjlRVWJLMJQbRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5U3JXfu; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46b1f6c0aecso293013137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 02:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706784111; x=1707388911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3PK4B/G7TI5S7RoTH00yBZOZBUAtwikxhzyCcmhOu8=;
        b=d5U3JXfuDvj2XtDgnfYF8colbT6u+hWn4NglRT2+cVeWWRFVlaOdug+IzTGMdn7iE9
         AtkYt18iXJwyZVab/IaZVMIEP3DUkE0TXdElDyE+9tAdEqMIhtukKc8y62KwQIUoMjif
         wQfGv/d1f8JLVEbLDu523oqASm3YvcL4hPFiOqSZ/bO+XPjZ5BibutVgUWFh0INgqoUm
         ez5PsXP2wT34Jlw1zXnJ4TqVeG16Pb0zUJEtP3EQ4sia8jJN/FU09Ugj5w0xuUeSZJ3H
         ESlqByTuor+eTTP/8Bkcf9T586F1KRr5y9HUkwECqcsvRVgKRxeNgB+cppSoQx/MlkhV
         vt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706784111; x=1707388911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3PK4B/G7TI5S7RoTH00yBZOZBUAtwikxhzyCcmhOu8=;
        b=XmwqHZ0wDKDGOW+eR2EsPeGZqSyWDWV+hhukuq26JsR71FqFWDib9kySKr7Q6MWxSX
         QQihyvTZZ8EuV3cVPofHGA72lXkZtRTipsJD4Dhd1cfDZLzbqwjz1JtKGzYOQLjQcaCX
         zwoBHheNudVnUJGirC2YByumytr4Uxd4S/Ow7wMqeS9Q9PL80xlIOCoieFZvgjsCtMIY
         IiSK/SQ4/yEvvSmi3cYmqVkcKJZj6U3g7hjAXFZl5CHda4WkIEaEv0xKd3mTku4mf4Zn
         iiPhCM8ZjbaALnQ31ZayHgNPZ98z2Or3YAoCCfJg815TNmP4aKSaGLupo5STakdFhiFQ
         uOjQ==
X-Gm-Message-State: AOJu0YwkLRZAymKjP/iqCO4eOtjjF+Qv7LKEjk0xK/pqN0ocF+56g8px
	HcC2LrHDNwg7zm0/Gshiwyxz5WZwRgxRFV1KBI7lYp05/qP5XuZEQ7Dx6W9ypwHasJ+znqiM3uF
	3Zmnw5jGuCA6aeI4zzk1iup/CgjU=
X-Google-Smtp-Source: AGHT+IHHkFFWs3aQs6WxB5Uk8OGEbj+D06uFw1xoC1ouhA/luLUzVarK/RZ9vmp3unxAywcXakJCEA6yw7D/4I6E4Jg=
X-Received: by 2002:a05:6102:22d1:b0:46b:74c8:5cb2 with SMTP id
 a17-20020a05610222d100b0046b74c85cb2mr3865865vsh.31.1706784110802; Thu, 01
 Feb 2024 02:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
 <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com> <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com>
In-Reply-To: <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 12:41:39 +0200
Message-ID: <CAOQ4uxiXEc-p7JY03RH2hJg7d+R1EtwGdBowTkOuaT9Ps_On8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:29=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 1 Feb 2024 at 11:16, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I can look into it, but for now the fix to fuse_sync_release() is a sim=
ple
> > one liner, so I would rather limit the changes in this series.
>
> Not urgent, but it might be a good idea to add a cleanup patch as a
> prep, which would make this patch just that one line less complex.
>

I will see if I can get something done quickly.

> > Is fuse_finish_open() supposed to be called after clearing O_TRUNC
> > in fuse_create_open()?
>
> This will invalidate size/modification time, which we've just updated
> with the correct post open values.
>
> > I realize that this is what the code is doing in upstream, but it does =
not
> > look correct.
>
> I think it's correct, because it deals with the effect of
> FUSE_OPEN/O_TRUNC on attributes that weren't refreshed in contrast to
> fuse_create_open() where the attributes were refreshed.
>

I was considering splitting fuse_finish_open() to the first part that
can fail and the "finally" part that deals with attributes, but seeing
that this entire chunk of atomic_o_trunc code in fuse_finish_open()
is never relevant to atomic_open(), I'd rather just move it out
into fuse_open_common() which has loads of other code related to
atomic_o_trunc anyway?

Thanks,
Amir.

> Thanks,
> Miklos

