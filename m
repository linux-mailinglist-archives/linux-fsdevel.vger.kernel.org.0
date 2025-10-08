Return-Path: <linux-fsdevel+bounces-63605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D3DBC58F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 17:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A3140517C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86228642B;
	Wed,  8 Oct 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="wH/TZyCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9F24DCF9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936974; cv=none; b=lbzt6Oh5z0AdRLYMiSwn0orqb8mmzt56uBoTDS/NE89CpENP2m90DGkRcMtp36HOBAcd+toxbd1AipTUdsLgxKsOnDak+PYDBmooOfpV33b6KRaGyIWX5wnyiqDD3NTz85yVukK7vClfl4BpABrn9IQAFcEW6AdY+HzblTr0f64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936974; c=relaxed/simple;
	bh=X1j6nGmDxjSgXJyZIZHORQDEpRM8U3EkbVPt5CtrEb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f08HfRjerLTDnlddUTaoG/ZJqhxIpo/Q2JiabHD5eGVkY8mU0apKu/9Y/AyGWew9K8zxDVOKTj1zKD88GCz27ChzXD/E1U9f/vUGH3C82eypTE4BLSjD0QtAxM7VMLIY870eEPVy6F1Po5MOE4l5WvDT6hPwQzRcPi5iPLuT3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=wH/TZyCi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so8898166e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1759936967; x=1760541767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ46KU8vSJ3Y3y6MyDJK8NolTC55ZuDRWc/GesIulFg=;
        b=wH/TZyCiKjKv7+x1usMnk0IwMqV76nioJGeK3SB6TgBjtGUaOjVjO2oLMrtB/aW9Ll
         3ipjaBaXOtWsuDOFE1oK5N0VTnHWK8gQIe9JQBRNiHK7+Ml/T9UQxiJebMfWzdqEeU9q
         rRXR/6OkTFyrrxfYVovb4xylvPM2i57hw1vh4tFL/ym+zb/5DE+ueg8AqnsoXOo0esd7
         RaRxzHqEfeRIOCEEp9EM5mHhllqnY/Ybco4Ez88jrxn0xfu2vOieDe5wNYC705RLC8jn
         p7NwpIFk4ctnPptyJVofvapoQk86CjKIPxpY8sIrDRqfpgkR9eVaWad6N7f7zF+3aCfk
         FqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936967; x=1760541767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ46KU8vSJ3Y3y6MyDJK8NolTC55ZuDRWc/GesIulFg=;
        b=c91LGca1+e2IlGzxYgzO1FUiaie5iRJmL522vUn85BTZA+rN/FEkONpA5n4T4VyG60
         AZmxyM1Noh/M1mB7/xoUkUMLy6hILQhnAKgfyqfmn8+Gf6NQgh9sq0rgO6DwSP8whaxl
         /jufvmmtZfD8FN3B8Mh+pJcl/Ce5yFleA4ruOvcUVG5OW/uj4ooLZIPoG7HpM9I00ud8
         jIvWNOlJkhsgTnfFvDPVh4ASgDfA+YGzZQ9fx4zCh+KtjFIfqBtIrJEx5wqRoA5BaHyo
         xbee1LfLuQDH6nYfSmEfJzjUYoO5zXT/doItydSY/i6yIr+QQt5R6JtLW6Nr5/FRldcv
         6mSw==
X-Forwarded-Encrypted: i=1; AJvYcCVh3lZd1CVw15qGNZU25GT4HRllIGio+Eh/9mOol9Dib6tO02aSHG4ALrvP+eco2ewiuAjJgzI7o3LukY5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4AwXy634jaRo2N/P5UpF6V2UuRxE4SPiPfPHTqHJIBPQFbyG
	ydOH2R4IzMn7oRFkXbDo4Zycbixm/PcV1w2KWbkZIXLPdhxelBxm/l34y7+aEAx7eYr8WY9+2uH
	J8yEOYYXDMgMYtZslJvY/yxMGcZZCvvIxEZ3ySBk4
X-Gm-Gg: ASbGncsVHxUihfYmf2gJRq/+ZxAHbYsBMcbHLqlkh/xH7VX/RrmB7ZaiJhh9XfEYpyk
	cySYGI4EXFaVy4EBWFtUqgrBwnzvUTT9fg3dvxab3eAQlCHQtX746+H734P6hsS1PYibOT7OzW7
	MbAmyAQNf3J57mBQ+HooRsQuov/ufOZrblKUD5yK6KQrfpE68kETLAvG72zlmXlgLEGoQGXBAOt
	v6EK4jzmNAb9R/juDnSd2LiUJNv2Q==
X-Google-Smtp-Source: AGHT+IFiyi5CBclcY4eFXl0Xxb3EcgxnRGKFTun8v5zZ9i8QJErjRPfdIvpLd3dkdEHbDYaPjeMr0Oet9rEeTUSZwKA=
X-Received: by 2002:a05:6512:1294:b0:57d:d62e:b212 with SMTP id
 2adb3069b0e04-5906d9e7470mr1160546e87.38.1759936966762; Wed, 08 Oct 2025
 08:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003093213.52624-1-xemul@scylladb.com> <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com> <aOSgXXzvuq5YDj7q@infradead.org>
In-Reply-To: <aOSgXXzvuq5YDj7q@infradead.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 8 Oct 2025 08:22:35 -0700
X-Gm-Features: AS18NWAsAb31TZfXWvQWDBORzAjx40tnBrYMOReEbyFX0MlBOKne28k_TQuZOBg
Message-ID: <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>, linux-api@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:08=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> > > Well, we'll need to look into that, including maybe non-blockin
> > > timestamp updates.
> > >
> >
> > It's been 12 years (!), but maybe it's time to reconsider this:
> >
> > https://lore.kernel.org/all/cover.1377193658.git.luto@amacapital.net/
>
> I don't see how that is relevant here.  Also writes through shared
> mmaps are problematic for so many reasons that I'm not sure we want
> to encourage people to use that more.
>

Because the same exact issue exists in the normal non-mmap write path,
and I can even quote you upthread :)

> Well, we'll need to look into that, including maybe non-blockin
timestamp updates.

I assume the code path that inspired this thread in the first place is:

ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from=
)
{
        struct file *file =3D iocb->ki_filp;
        struct address_space *mapping =3D file->f_mapping;
        struct inode *inode =3D mapping->host;
        ssize_t ret;

        ret =3D file_remove_privs(file);
        if (ret)
                return ret;

        ret =3D file_update_time(file);

and this has *exactly* the same problem as the shared-mmap write path:
it synchronously updates the time (well, synchronously enough that it
sometimes blocks), and it does so before updating the file contents
(although the window during which the timestamp is updated and the
contents are not is not as absurdly long as it is in the mmap case).

Now my series does not change any of this, but I'm thinking more of
the concept: instead of doing file/inode_update_time when a file is
logically written (in write_iter, page_mkwrite, etc), set a flag so
that the writeback code knows that the timestamp needs updating.
Thinking out loud, to handle both write_iter and mmap, there might
need to be two bits: one saying "the timestamp needs to be updated"
and another saying "the timestamp has been updated in the in-memory
inode, but the inode hasn't been dirtied yet".  And maybe the latter
is doable entirely within fs-specific code without any help from the
generic code, but it might still be nice to keep generic_update_time
usable for filesystems that want to do this.

--Andy

