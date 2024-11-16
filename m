Return-Path: <linux-fsdevel+bounces-35010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A632A9CFD2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BBAB27B2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFC19146E;
	Sat, 16 Nov 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+klF+xr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76436B64A;
	Sat, 16 Nov 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744077; cv=none; b=X8pa84rXDXNU6bBcv02Ut9y6U6Kc7BUzAdX6dk1CC//6JB29Rk6We7g6yN/Ei37G3Et3PckQZQ2gOWcmxkoJYNkPuuUFW2kTaaO8peVxaobP8Lx9ZYD15viO6/SEQ6dxkXQv7kCyTaWyyIfkjswkYhOTOfyVpAi3JO6sHIk12hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744077; c=relaxed/simple;
	bh=0HJM9cjcvmpdVTDGL1l6M1Dj+SmvBnR7aytq8be+/pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZYsyqFek9Y3LbJyvXEIqklvJmlIGN9aSnyu+u0MClK+tyQQ5tI53ECQkYFmE9GLErrSmR/U5MlfowsB7G/DYgx8X8WSYrVyw7rlA3iiZ/IjUUvECGWtDt7E+m3wJbiBOywPVQbNPw1M+qGM4GL2CYlc8902H/NS0QzwtHw252k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+klF+xr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so4362164a12.2;
        Sat, 16 Nov 2024 00:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731744074; x=1732348874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSXDTZ0aay8d1yiOoVnu2o6e/epgyQVcOo5da5OfdOM=;
        b=Q+klF+xr4jlG+dcd9QRLzpcFTWWQBcje8AoH5klXvmNlACFYN88OWTFpdlzcoJ+/A3
         dPgRA57TXxBzDnQJSRmQrhtrqxcqrFoRB3yedrDNVI72iFE99eBGAHKIoU4XrxX2FW22
         IG9VCa0lgu6p3sQQDG//Fugca0IsfbDR2DzNum9oNFSmR71oHimhPYMBr08GASgTRbPF
         2qweqkCxZuegWAy4NGbG+7BGDcAmd0LRT2FxiEEuvLGb5Z2pNIwrLNKJvHX4vboKEC7e
         Oa25ZwIzDxzxq1c/+03lq7SETF6WHZWpUX4uko1ZsvO4mv9o+Oi/TSid5/PmZZ7xmSbw
         Kjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731744074; x=1732348874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSXDTZ0aay8d1yiOoVnu2o6e/epgyQVcOo5da5OfdOM=;
        b=M30kdtZf9u+FWYIGkNYTlk3G5mA4CfL1ybIkuX1QP/CIKHFp19jZh3s8mYdFolrVy6
         S7slPtAuZLmLLg9jEuxxYt6JOg/1ecnN5GVvVcyfk+JhR15AY9xb1i12pTuZlSY2q87v
         ByNiW8kXHHW0Y0Iv9jzXVH9NfUjl99qhdwz3CixfgJ+sJ3ItT26N2nAJDqNpIc24nCAZ
         3YtRxgVqrjIakx7F3b/i5k5xoTX1+/8zJcZSf7nXv65EDVVupqL5RKnqyfdvaDxtYSiz
         XCa4OlGdMFTCmGzPXgDMbUN8er6NVqtXbo49Z+xBcL8qnbSbScPCvXTjglHGbWVfuBUh
         AeHg==
X-Forwarded-Encrypted: i=1; AJvYcCV7coujpF1Utl4MMEHTco5/CxxK9NXROHViSph62dJsPXqTnlFYpMzHs+BWk2j7rcB/QHzTi2guO/fg643m@vger.kernel.org, AJvYcCVpr8G54ajgjrq4U4NZvDZKp/RDV0zuw3jobEyNXGMj+4vrHCFqSzbBavsNVcYnCmt3xIVAbUvKbqtR9Y4V@vger.kernel.org
X-Gm-Message-State: AOJu0YyIY2shqGxQmtbf+DLspC+c7sGNk6QUCUh/Vn0d+2Z34rNt9L4X
	bfMpUGQvnf3PTQyfi5yFekUmA9nqdKY3oKFLFZ67qf/dBlgm22bCPvrfmHxkFKsVXMP7p9dR0rt
	nmFLjcl8AntvJYTFYISEF04tiJkSDLxxG
X-Google-Smtp-Source: AGHT+IFr7u/yrjt5Q6SDniYU7mwzeqrSSSE/z+mZgR4Wv/vU6F2I3kUGth1q6lU1BwTQujQdi2q1yvWygsEk3HeGf04=
X-Received: by 2002:a05:6402:2106:b0:5cf:a296:ac6d with SMTP id
 4fb4d7f45d1cf-5cfa296ad7dmr1298340a12.18.1731744073592; Sat, 16 Nov 2024
 00:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116064128.280870-1-mjguzik@gmail.com> <20241116073626.GB3387508@ZenIV>
 <20241116074209.GC3387508@ZenIV>
In-Reply-To: <20241116074209.GC3387508@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 16 Nov 2024 09:01:01 +0100
Message-ID: <CAGudoHH-v=eDxV0D3wU+bXmGL75UEj7z=yy7r0jx303E4aW38Q@mail.gmail.com>
Subject: Re: [PATCH] fs: delay sysctl_nr_open check in expand_files()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 8:42=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Nov 16, 2024 at 07:36:26AM +0000, Al Viro wrote:
> > On Sat, Nov 16, 2024 at 07:41:28AM +0100, Mateusz Guzik wrote:
> > > Suppose a thread sharing the table started a resize, while
> > > sysctl_nr_open got lowered to a value which prohibits it. This is sti=
ll
> > > going to go through with and without the patch, which is fine.
> > >
> > > Further suppose another thread shows up to do a matching expansion wh=
ile
> > > resize_in_progress =3D=3D true. It is going to error out since it per=
forms
> > > the sysctl_nr_open check *before* finding out if there is an expansio=
n
> > > in progress. But the aformentioned thread is going to succeded, so th=
e
> > > error is spurious (and it would not happen if the thread showed up a
> > > little bit later).
> > >
> > > Checking the sysctl *after* we know there are no pending updates sort=
s
> > > it out.
> >
> >       What for?  No, seriously - what's the point?  What could possibly
> > observe an inconsistent situation?  How would that look like?
>
> PS: I'm not saying I hate that patch; I just don't understand the point..=
.

Per the description, if you get unlucky enough one thread is going to
spuriously error out. So basically any multithreaded program which
ends up trying to expand the fd table while racing against
sysctl_nr_open going down can in principle run into it. Except people
normally don't mess with sysctl_nr_open, so I don't think this shows
up during normal operation.

I explicitly noted this is not a serious problem, just a thing I
noticed while poking around. If you want to NAK this that's fine with
me, it's not worth arguing over.

--=20
Mateusz Guzik <mjguzik gmail.com>

