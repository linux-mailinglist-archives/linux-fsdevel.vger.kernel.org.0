Return-Path: <linux-fsdevel+bounces-25215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609ED949DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAD01F21D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427C335B5;
	Wed,  7 Aug 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKAf0wNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59591C27
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999735; cv=none; b=ZTTQEAzf5rxWvUO/vTRxbCGutmY21a+yMPcc4xsqET9ZU/BOA+u7HOvyr+6i9+OERN+ALpXU5uBdHEnQMJxC6fxmaM26zuQEsUp4UHqM/wwYudfb02AX2lAkhr4kAxL3uvlFgeUhVuMglLbayVy+i3SpuR3e2Lte4vbhzQ+aeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999735; c=relaxed/simple;
	bh=tku6txlydy/2BQzQCvlZw52N87jU/BEOVNGofJz3r88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e15VzB1H9jMHrpI/ekwsf60fQjL66tOIDkrnLWu76kOI5+nFE6s7MO2DNDlVNGTJOVL97AJPs6f1wi+13wPWmoowFAhV9jGZKGwsyaHu+1we009YO5CsKyTxuAtLqjg4U6qNcd4JT8vOaVYqERxAI9LT7XLFr0/OVDJKx52in4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKAf0wNu; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d829d41a89so781666eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722999733; x=1723604533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5qZv39EG8kYLMcw6SSx1reFN0g5X2uPZqtqamN1rmo=;
        b=hKAf0wNuaQgAmQ54an6uS6FGjAO1f0wAxQwjVt2XR981i9ej4bNIfFP30tgxwjIPjy
         eGSp1XT0jgu5QD5PxTmCexId7vanRMkAL+Ke08j8+iwaDs3vlFkfOH3qMr5jgKSJFQU+
         2AhlkAq+LnIK2nH9ml3m8uKGw5YwpjOB6PSxtpydJFelJqFhduLQoXOOSYipXG7Rkvbd
         BKehJMnqe/aRpEdqC1dRRIlxdtikIS3IBJ1Coeakwv+Uqm4q2k0MlUadTmHdah2Y84FW
         /QKBVHTqVQsLjH2HqTYYyhFUquOEgDuOPzAw+9iT+acVPok0llCo6j1sD3fsqDMg938E
         GNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999733; x=1723604533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5qZv39EG8kYLMcw6SSx1reFN0g5X2uPZqtqamN1rmo=;
        b=fxFjERsK4BXzOwdlfANK2bmWw3tRJBgAITgcLwdp5/WMJm9E+ZCbrDFdEb+xX9Rz1f
         uEp1MydA6oRMBsBGOklzLgAMA5pb8FX8J+9nzRL9WsKDHgRGPb43mIhPEUrASLECAoZl
         VZRh+mkORcJ9a0tHuxKuyc6zdl6tB8ojlhZ2GPXRQ3rVYrS3Sk+A+krpwJuEw3aj9geb
         RO1vsuNQ/ywkYWnwffmLDorQcsjKyK0DebO3r/VUXD3dTskaknAqfLTPGix8YA8padwW
         BCeUJYECKFiV2LbRiaZwpWzI7khAAigH3JGllUaqbeqB+VS34wHWa3bkPqdViXAhjHs5
         QGEA==
X-Forwarded-Encrypted: i=1; AJvYcCVuIn/0mkpbnRP8G4Zhj5P2xoQBFuOB8A0co2rQH4cU7yjkK8f4647gOdoFFhnjWHIw3TzPBthg9ltWzzIbvcXrkBWWTpBdsIi7Xq+tEg==
X-Gm-Message-State: AOJu0YyuTAHwNt+2nVhrSGiDaPyxlJVNlEZXQ5b7WsB7cY1dykf331jT
	WeNhZ2mIfxN8KuHe253MuvaG1iHAiXMT37BWi3OUF7oWyAb/RwS4hjqgkCqODOS4l/FJiwnMk8U
	xiYbp59QF7tLnmQ8pkBK+FXS2TmI=
X-Google-Smtp-Source: AGHT+IG8E2q7JXkVADOTX1/ajjqfUcmCnT7bMRWDl6uRUlp2WJC87nEFjTQ4SL6OMgQWYGP3ugB05wfnsSK0pBqDZ34=
X-Received: by 2002:a05:6358:3421:b0:1ad:282:ab1f with SMTP id
 e5c5f4694b2df-1af3baab1bbmr1858077155d.7.1722999732895; Tue, 06 Aug 2024
 20:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804080251.21239-1-laoar.shao@gmail.com> <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
 <20240806132432.jtdlv5trklgxwez4@quack3> <CALOAHbASNdPPRXVAxcjVWW7ucLG_DOM+6dpoonqAPpgBS00b7w@mail.gmail.com>
 <ZrKbGuKFsZsqnrfg@dread.disaster.area>
In-Reply-To: <ZrKbGuKFsZsqnrfg@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 7 Aug 2024 11:01:36 +0800
Message-ID: <CALOAHbDqqvtvMMN3ebPwie-qtEakRvjuiVe9Px8YXWnqv+Mxqg@mail.gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:52=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Tue, Aug 06, 2024 at 10:05:50PM +0800, Yafang Shao wrote:
> > On Tue, Aug 6, 2024 at 9:24=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> > > > Its guarantee is clear:
> > > >
> > > >   : I/O is intended to be atomic to ordinary files and pipes and FI=
FOs.
> > > >   : Atomic means that all the bytes from a single operation that st=
arted
> > > >   : out together end up together, without interleaving from other I=
/O
> > > >   : operations.
> > >
> > > Oh, I understand why XFS does locking this way and I'm well aware thi=
s is
> > > a requirement in POSIX. However, as you have experienced, it has a
> > > significant performance cost for certain workloads (at least with sim=
ple
> > > locking protocol we have now) and history shows users rather want the=
 extra
> > > performance at the cost of being a bit more careful in userspace. So =
I
> > > don't see any filesystem switching to XFS behavior until we have a
> > > performant range locking primitive.
> > >
> > > > What this flag does is avoid waiting for this type of lock if it
> > > > exists. Maybe we should consider a more descriptive name like
> > > > RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is alway=
s
> > > > challenging.
> > >
> > > Aha, OK. So you want the flag to mean "I don't care about POSIX read-=
write
> > > exclusion". I'm still not convinced the flag is a great idea but
> > > RWF_NOWRITEEXCLUSION could perhaps better describe the intent of the =
flag.
> >
> > That's better. Should we proceed with implementing this new flag? It
> > provides users with an option to avoid this type of issue.
>
> No. If we are going to add a flag like that, the fix to XFS isn't to
> use IOCB_NOWAIT on reads, it's to use shared locking for buffered
> writes just like we do for direct IO.
>
> IOWs, this flag would be needed on -writes-, not reads, and at that
> point we may as well just change XFS to do shared buffered writes
> for -everyone- so it is consistent with all other Linux filesystems.
>
> Indeed, last time Amir brought this up, I suggested that shared
> buffered write locking in XFS was the simplest way forward. Given
> that we use large folios now, small IOs get mapped to a single folio
> and so will still have the same write vs overlapping write exclusion
> behaviour most all the time.
>
> However, since then we've moved to using shared IO locking for
> cloning files. A clone does not modify data, so read IO is allowed
> during the clone. If we move writes to use shared locking, this
> breaks file cloning. We would have to move cloning back to to using
> exclusive locking, and that's going to cause performance and IO
> latency regressions for applications using clones with concurrent IO
> (e.g. VM image snapshots in cloud infrastruction).
>
> Hence the only viable solution to all these different competing "we
> need exclusive access to a range of the file whilst allowing other
> concurrent IO" issues is to move to range locking for IO
> exclusion....

The initial post you mentioned about range locking dates back to 2019,
five years ago. Now, five years have passed, and nothing has happened.

In 2029, five years later, someone else might encounter this issue
again, and the response will be the same: "let's try range locking."

And then another five years will pass...

So, "range locking =3D=3D Do nothing." I'm not saying it's your
responsibility to implement range locking, but it seems no one else is
capable of implementing this complex feature except you.

RWF_NOWAIT was initially introduced for AIO in commit b745fafaf70c
("fs: Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT") with a clear
definition that it shouldn't "block while allocating requests while
performing direct I/O."
It was then extended to buffered IO in commit 91f9943e1c7b ("fs:
support RWF_NOWAIT for buffered reads"), where the IOCB_NOIO was not
set, meaning it would perform read IO if there was no page cache.
Readahead support was added for this flag in commit 2e85abf053b9 ("mm:
allow read-ahead with IOCB_NOWAIT set"). However, this behavior
changed in commit efa8480a8316 ("fs: RWF_NOWAIT should imply
IOCB_NOIO"), without a clear use case, simply stating that "RWF_NOWAIT
semantics of only doing cached reads." If it breaks the "RWF_NOWAIT
semantics," why not introduce a new flag for this new semantics where
non-cached reads are allowed?

--=20
Regards
Yafang

