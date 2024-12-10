Return-Path: <linux-fsdevel+bounces-36886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF679EA750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 05:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07141672CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452A19F436;
	Tue, 10 Dec 2024 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWqDUp6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE413A865;
	Tue, 10 Dec 2024 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733806135; cv=none; b=bF+IOHCTMrkHSWxNa6NvBNE1dxM8SZOfuQ81dP1d7GQcbl8c2A9GXd8NbW0JxPOS1o3N8ufXM9THrpZSMdV1VLgM1moKZUlbKYwCVP2W5+AQnUDOMegCuOllkkgc3Vy+/WNAZ82XbWl5X4CLlTaKnTzJVmuoy0po+mvavit3YG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733806135; c=relaxed/simple;
	bh=fmuHub6i/UU89iJ3zmI8M0zPA8LOY2hfDA7Kp09iC4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At5NYm294cGa7qdCJmCkJLgkhzdqOsWIKOG7DSizj6xLcWxPlIOfYUGfhc41PLoTkgHTMSIhAihQE+LaUMbru5/AD0r7rzy8YlIKUiSa7yPrFkhARvGZmIIYICRwnox+WGMFXGsTzSMfg3lbydpWo0x+AiPQ4f5HW+iwprpOOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWqDUp6T; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3ea065b79so3474915a12.3;
        Mon, 09 Dec 2024 20:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733806132; x=1734410932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRhudRntXMdMCmvTCWHy+R0vrWQamPgM9djZeqqOOGk=;
        b=JWqDUp6T0+SBmHbjjRV18IYsuMP1fR184k/jhfMJ8SCAa5rlCqlJiQutajFr7HngxA
         V8TAEHFcDeMTcLr6KUcEwvVYPZ4U7JJB4fFn1aRrsOjS3N/+PYlEBTfHIbeJFOSpVgf6
         EwBABaiGcZqa0SSVDWyo9BciDNKPDQAJ79KLNIpDEsKcgDCQjSJIQouh529U186I2aHg
         RsPzj3ZJIPjKJZdtpMtXBVrnftAePSqd2hwg2y1tJo+isncQgS8b/WU2QvpsS583e5Ql
         3WuphfQhU3xT8Ym/Fauvnax9rudST0Sou2XhcHiZeLbPhVxfQULyRJKMlS9RtgEdTYPl
         +HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733806132; x=1734410932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRhudRntXMdMCmvTCWHy+R0vrWQamPgM9djZeqqOOGk=;
        b=L2n+a/96yv3nV1WYj7do+bR53K1kiWxMzCAe4y4PneEg7MMfrJiYediMc37g6GenRc
         9YF6MzLfs/uZgB7V1zZVVemRYNXtaxt7jhuEGQuFmv4Lk75PYJrQnOxapx9suUCpC0be
         vBBtQsbzOzvkSIZcyIgk9w/+1ttW/i9CSXcjSzLmbe9hmHIg9Z7rqie6zU+IUz5HcRnv
         8rn1lA1iY9nRTqfpuLUuvtdaIUCXglHIfEspb72Kh7qnE/+R7d5cEO2OpDjWHLpIyrMX
         P1MfWzSBfn+FboQ6D4+v2mRHdW/KYIVD4i/ushgLxuTjQBq2IhZqm3mivJ58UDeA+itw
         VqRA==
X-Forwarded-Encrypted: i=1; AJvYcCU8XG678TKO7TZcBFxpzjbDQ0DwXKHdgCjLav3A8iF9HD7z2b33VH/YrTk2kpn3eoHKHEE9THnJgsuJvFQC@vger.kernel.org, AJvYcCXeJEaPOqKSPdjO3Gftdk18si29tBMHMDDxuxCQ8YClWUt9Ba8JnT5KOdM6qOYEoC0/Vxg6hZwOft+QHNGp@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKYix9k8q9cwoqg/5UyBFukdb5G5diHQUtXypv2FNmZwDXIL8
	fTDYo2T1FkEdjMU70R+zRpsM7EhcX2huOLufn1QneLPQDLCndFP4aTa67RedfurbM/FVYtKDayB
	vdiFe14CSMOHmkqRiz6PMlUFuPAo=
X-Gm-Gg: ASbGncsGCzzrjjH+reWtcaCIwEpCuECxuxwOeMUR3ByO9kwDKd9nii4lps/jTeknvob
	HzgChwKOS7LPj/6EAlCEbzP9LA90V3FT1E2c=
X-Google-Smtp-Source: AGHT+IGBiffJ5X2iaWC0nwpDNkAHhlszy1HhQEUv64YxBZjY2IAnPM4N3S8MjfXyUDtvLqL91fcR3OhcyBd47zZ6puU=
X-Received: by 2002:a05:6402:1e90:b0:5d0:bcdd:ff9c with SMTP id
 4fb4d7f45d1cf-5d418502c73mr3460582a12.2.1733806132161; Mon, 09 Dec 2024
 20:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205154743.1586584-1-mjguzik@gmail.com> <20241206-inszenieren-anpflanzen-317317fd0e6d@brauner>
 <20241209195637.GY3387508@ZenIV>
In-Reply-To: <20241209195637.GY3387508@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 10 Dec 2024 05:48:40 +0100
Message-ID: <CAGudoHH76NYH2O-TQw6ZPjZF5ht76HgiKtsG=owYdLZarGRwcA@mail.gmail.com>
Subject: Re: [MEH PATCH] fs: sort out a stale comment about races between fd
 alloc and dup2
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:56=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Dec 06, 2024 at 01:13:47PM +0100, Christian Brauner wrote:
> > On Thu, 05 Dec 2024 16:47:43 +0100, Mateusz Guzik wrote:
> > > It claims the issue is only relevant for shared descriptor tables whi=
ch
> > > is of no concern for POSIX (but then is POSIX of concern to anyone
> > > today?), which I presume predates standarized threading.
> > >
> > > The comment also mentions the following systems:
> > > - OpenBSD installing a larval file -- this remains accurate
> > > - FreeBSD returning EBADF -- not accurate, the system uses the same
> > >   idea as OpenBSD
> > > - NetBSD "deadlocks in amusing ways" -- their solution looks
> > >   Solaris-inspired (not a compliment) and I would not be particularly
> > >   surprised if it indeed deadlocked, in amusing ways or otherwise
>
> FWIW, the note about OpenBSD approach is potentially still interesting,
> but probably not in that place...
>
> These days "not an embryo" indicator would probably map to FMODE_OPENED,
> so fget side would be fairly easy (especially if we invert that bit -
> then the same logics we have for "don't accept FMODE_PATH" would apply
> verbatim).
>
> IIRC, the last time I looked into it the main obstacle to untangle had
> boiled down to "how do we guarantee that do_dentry_open() failing with
> -ESTALE will leave struct file in pristine state" and _that_ got boggled
> down in S&M shite - ->file_open() is not idempotent and has no reverse
> operation - ->file_free_security() takes care of everything.
>
> If that gets solved, we could lift alloc_empty_file() out of path_openat(=
)
> into do_filp_open()/do_file_open_root() - it would require a non-trivial
> amount of massage, but a couple of years ago that appeared to have been
> plausible; would need to recheck that...  It would reduce the amount of
> free/reallocate cycles for struct file in those, which might make it
> worthwhile on its own.

Oh huh. I had seen that code before, did not mentally register there
may be repeat file alloc/free calls due to repeat path_openat.

Indeed it would be nice if someone(tm) sorted it out, but I don't see
how this has any relation to installing the file early and thus having
fget worry about it.

Suppose the "embryo"/"larval" file pointer is to be installed early
and populated later. I don't see a benefit but do see a downside: this
requires protection against close() on the fd (on top of dup2 needed
now).
The options that I see are:
- install the file with a refcount of 2, let dup2/close whack it, do a
fput in open to bring back to 1 or get rid of it if it raced (yuck)
(freebsd is doing this)
- dup2 is already special casing to not mess with it, add that to
close as well (also yuck imo)

From userspace side the only programs which can ever see EBUSY are
buggy or trying to screw the kernel, so not a concern on that front.

Now something amusing, I did not realize I had a super stale copy of
the OpenBSD source code hanging around -- they stopped pre-installing
files in 2018! Instead they install late and do the in dup2 returning
EBUSY, i.e. the same thing as Linux. I do have up to date FreeBSD and
NetBSD though. :)

Christian, would you mind massaging the OS entries in the commit
message (or should i send a v2?):
- OpenBSD installing a larval file -- they moved away from it, file is
installed late and EBUSY is returned on conflict
- FreeBSD returning EBADF -- reworked to install the file early like
OpenBSD used to do
--=20
Mateusz Guzik <mjguzik gmail.com>

