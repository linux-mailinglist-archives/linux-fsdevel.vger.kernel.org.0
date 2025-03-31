Return-Path: <linux-fsdevel+bounces-45336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF6A7653C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9837A1F06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331BC1E2823;
	Mon, 31 Mar 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrdYWfI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056681E104E;
	Mon, 31 Mar 2025 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422126; cv=none; b=p/5XcqgkDe0Z84prH7d+4sHQ1aTNxUW3HjVLY7fvTJ0CGiDbU8oc+8vdpEWHEJw+opyQrIlg7gw9aDLjKfIP47mvVnaJR0bVgB5MR7QY+WjtfTwaDc0XosEuBp1WdtpjClzTUSnCAQYDe5g8JhM2sRpl4lfCGP6UwiYSPpSpBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422126; c=relaxed/simple;
	bh=gnE0aJ1VVzUwUivX4cBUoiVysJWw2QPie15h4Uw5KUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IY5qIN+OquLlTCmPsJnP76qKud0rmXcz2rqjFhl5Nvy1uOLlM8S7BBdRGpMisPCIT8qOPy1kxSk3digHygHi/POdfozxJkhHuOJu3DL2atjrzM3zlK1nf1/pV5YFx2q5JrQYISAPk0po24mQhSFLQE39VEWEQemryUp4Goi+Cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrdYWfI1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so702222766b.1;
        Mon, 31 Mar 2025 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743422123; x=1744026923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ6usaPKx4+5g/jBWHZJmyt0joZa/x6NmzVp5+ew24I=;
        b=jrdYWfI1wAHsogqEYNdG6aZsbRwMz6LY/d+TXiaVAoHs8lQ5O8v732wB/Zg4IjrJeh
         1x6of9KLLPYybJXhh020BySgZVx81oA5wAdCSeaFYvarmn1tasmbKx1NA26KDsqNnZyg
         H13f8QWaslxi2DOZdOy8JdjwhZfbg/do1NmDj0LD2dRaeMJpA9G2dH0ypT876w6ZijbX
         M1OM/q9Vd3dS7pvXgh/vOtIfVABJU/MhNcSSGmFkn7mjV77VQKoKPWJBMOKfLjPlnCGY
         NkG6dDKBYQjLccN7mpOw7px95DCjKuoY5O3c8aUMJ/K/Nz7N8hUlO8JWx2zlCq02EqVu
         cTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743422123; x=1744026923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ6usaPKx4+5g/jBWHZJmyt0joZa/x6NmzVp5+ew24I=;
        b=UH9HGEP0O7Fg/L0AvVPPLrxzfqMRC6LBoqugZ5/2pbAMg6+eLWaXEQ20E2Q/dxUghi
         TYYtXYLc3Xp6SC8Hab/IsHy0ftt4f45VK6GNi3uGKwD1FEOMi5QmAoKl0NNnXah6a3JT
         zjcVaZ2h5BNUkYTOXug6xJOut8tSVdOTCtQKNfoI5CqsTwRLdCHaqwQsdCHKT/rjjfN4
         qdvfeu9OFPLcYI45qXg2bGkMiHAaIoU1h7HMmfXTvkDjxINVOlrgIal4S1ck5Hib3Bz+
         PhadWDEOEcc7J94poZO7o8P74KXEg8Ebg0EZI0KwVaABEqAsfPWkeT9pzuiq4nMvJGie
         7dCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwq3lr8019Qz8MjpjgG5KNxjBwG2yfBYqaimK/JL11lOAt/eov07IiAYVahZYtHL573fMkwSTvSZyc@vger.kernel.org, AJvYcCXUwv9cDlks7VQtVhjGh9+D3G9qNU8+RrnKjzGe1kevu8KJ501PysezX5FRK1dxTBN7xP7sIGRFnEUB+zAP@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwmU2fbqKDsOn0mHrXg82FSJuRKHeCHqN7PaOF8FAkqq6UXlJ
	bLLMLloi8yVTXZEdE1H/Hy8MozYsO+EeaZMkv1xsxO8xsCNEMfqM9yRgk/Z2mWs6zas84H/2Vep
	yUwIygaavrAJMgaQV74gNs/MmLfr9tXzwmaE=
X-Gm-Gg: ASbGnctv3klVB7hGzMwFVDcSy06LCBkyKAeNbLqMipt4FmXz/y8kplrKZFi54ggjK1F
	/Kf8NRxhyL8t2U/TvrgZ9RCnziJx6jicAeq7p3l6ICsmtsfHxL+d9LRor1zUKNek2muAAG67DLU
	nVBg3z8nn0MLyCteoTLvxkLSklLg==
X-Google-Smtp-Source: AGHT+IEzh6cHoJcmNkSO7vswR79cQw8m1DlGRP7j8gWJGQk4QdjjA1o5aMo6QlmVOLrPAspPTeoxooBf1okfBbuAXXk=
X-Received: by 2002:a17:907:97c9:b0:ac2:8a4:b9db with SMTP id
 a640c23a62f3a-ac738a644bdmr808496366b.16.1743422122868; Mon, 31 Mar 2025
 04:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330125146.1408717-1-amir73il@gmail.com> <vflts4w73gy23iquev6yxrvbzguxkvlx7ccrcuww3hhvjbuw4q@dqr3up7qjwgx>
In-Reply-To: <vflts4w73gy23iquev6yxrvbzguxkvlx7ccrcuww3hhvjbuw4q@dqr3up7qjwgx>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Mar 2025 13:55:11 +0200
X-Gm-Features: AQ5f1Jrhr4HQT0MM9_8SwEg9RCyqmyL7RmPXiw7O3CK3RyykzhBRM3aU2QuTCDQ
Message-ID: <CAOQ4uxhDR8s5yHc-=xoWCeP5AA49dGoGhk=SU=9ykz+ajOco4Q@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Document FAN_REPORT_FD_ERROR
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Krishna Vivek Vitta <kvitta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 1:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 30-03-25 14:51:46, Amir Goldstein wrote:
> > This flag from v6.13 allows reporting detailed errors on failure to
> > open a file descriptor for an event.
> >
> > This API was backported to LTS kernels v6.12.4 and v6.6.66.
> >
> > Cc: Krishna Vivek Vitta <kvitta@microsoft.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> The text looks correct to me. So feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Just two typo corrections below.
>
>                                                                 Honza
>
> > ---
> >  man/man2/fanotify_init.2 | 29 +++++++++++++++++++++++++++++
> >  man/man7/fanotify.7      | 12 ++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> > index fa4ae9125..23fbe126f 100644
> > --- a/man/man2/fanotify_init.2
> > +++ b/man/man2/fanotify_init.2
> > @@ -364,6 +364,35 @@ so this restriction may eventually be lifted.
> >  For more details on information records,
> >  see
> >  .BR fanotify (7).
> > +.TP
> > +.BR FAN_REPORT_FD_ERROR " (since Linux 6.13 and 6.12.4 and 6.6.66)"
> > +.\" commit 522249f05c5551aec9ec0ba9b6438f1ec19c138d
> > +Events for fanotify groups initialized with this flag may contain
> > +an error code that explains the reason for failure to open a file desc=
riptor.
> > +The
> > +.I fd
> > +memeber of struct
>    ^^^ typo here
>
> > +.I fanotify_event_metadata
> > +normally contains
> > +an open file descriptor associated with the object of the event
> > +or FAN_NOFD in case a file descriptor could not be opened.
> > +For a group initialized with this flag, instead of FAN_NOFD,
> > +the
> > +.I fd
> > +memeber of struct
>    ^^^ typo here
>
> > +.I fanotify_event_metadata
> > +will contain
> > +a negative error value.

Right.
I also changed the phrasing to

The
.I .fd
member of the
.I fanotify_event_metadata
structure will contain a negative error value.

and formatting of:

in case of a queue overflow, the value will be
+.BR "" - EBADF .

As Alejandro requested in another review.

Will post v2 soon.

Thanks,
Amir.

