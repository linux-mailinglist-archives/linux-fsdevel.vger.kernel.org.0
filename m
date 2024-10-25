Return-Path: <linux-fsdevel+bounces-32929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D299C9B0D86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761F31F23D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B53185E50;
	Fri, 25 Oct 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMdwQHrz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1E1D8E10;
	Fri, 25 Oct 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881553; cv=none; b=OWqF16S9nnvSjykSkvml6l1GwqbzTstNVuVaqKQAv0l2Jf81n0Wmvw+4d1tGfk0uyFIyOXCknsIYRnTPPD+J5MvCXEuxKOTK7yQ2uqIpvqp3ZCTtNjc6B6A0g8LD1D3Ap/JvYoj8JW2OPMF9IAsYGsRBwdExETTkTjH5s9bxdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881553; c=relaxed/simple;
	bh=Bx1WolEnd/YIJN1S54UWNZpg5E+EUTLa0+1yugHcioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKiHCtYoAPE8qoV6duQy0Hvr7linSHoNjb6hiTGByYnnov2uP1lLGbn5Hzqp1bH/dj0BqPFyEdm6vBzP9F+zT27wLEsxTWlIqPSm0bN90ODD+OWthqWiBEauZifMUMUE8IGEE1G3ncw5VfNzBHDLnkt6QtSeXXIjmv4/3bTgIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMdwQHrz; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so717887241.2;
        Fri, 25 Oct 2024 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729881551; x=1730486351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrkqYuMSqbUzEQhPW44lBubxGtAuzrgS+e75bGGESs0=;
        b=PMdwQHrzxVXjPZ8zI7u435ZgkpE+/YpHKAo9w1rzThsOKCz4tDK2oM62faGjsIDBWs
         l/xjZzKtoMuSjRIvN03hK7MDbqGRw8ZJDAv5SeHs5GAHMo59vLs/vpwHh26UjOs1FENu
         QgbteoryNSFzs38sZLiucaIvmTMf6wAKXfhLpsoBVknr+BtcieQioUM4N7i37BGlrLqC
         s7oOkkedN6KtMub+G9FMVvtU1ejMkmZj//kUJBa7lOx5E4UPPGyU9rTdhRjGPIdOO/AT
         CuA8nqrBjwXWOQFgNRp1488cVlHgVejWJAbar6o/OFK/k//5kSVbNwmwcIOQ7KkxX4Wb
         ZwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881551; x=1730486351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrkqYuMSqbUzEQhPW44lBubxGtAuzrgS+e75bGGESs0=;
        b=fRHfHJF5BiCOlxMZaTaNSDlZXmv8ogdvscGwjIjoYCbVWoANcP2d2gJiOEDnk5aMXG
         L+JAUW4DkoBm6Qb9vpF2Mjv1AmWK8pih07uh3B+aHvxBvbLFTwjrW4a0F1teYI6Csuif
         9rdQGBXq/JW4XZ5MwhA8TSCUp4Py2gg3wLrrJOwKkOb9WBDWCCuRrHvFx3+JrFDCizQv
         fmOniAp3DVx9zatZYCrjD2Fha4C1XSLFxNqU8RwPvnUHfHdi11F6AmK1Nlrm1mP+pRru
         kCmbWqPV8WIFkv2qc1RSvg2Sn28ThBz3KDnDlYaqZPozXzfNXclmiy9w21/lgxPLPKfo
         DgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDhF8p29GsCLVUPyUXKZWA5/JU5lBwS0RKUaj8yrsoxlxRtvxY42JmnGyvf6bWTYT0DHgN7yVu0E1xgS2LMX5Q@vger.kernel.org, AJvYcCUYcHGt/738n2xHYX1PZoohp4GNoBh25qXrVgXVpo/cb/IC0CMd/XKgTrDSgXhDudmwXcRuZZD9s5moHf/l4A==@vger.kernel.org, AJvYcCW1Uh94J7AjG77UdfQlYnR8Qo7phEwiZTYbo/xrr67olkGFHUw2Uo77pQ0f/J1iwZbiwMPu3hxnpRk=@vger.kernel.org, AJvYcCXwLPGANVUY81yVpaO+jzIhyX+Mi55Dcmf2kK5JT3S2kQK52o5E4DDn4RR/4RVxGtn2vDrH3QUsz0iBZSRb@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYnd10d6jsEu+VDkIq2EpEznNUJ66vBGcHRQYXfXOk4r+F7qC
	TQsFKu4DJLTi8AfyCUXzBHrT3isZX68QO3cBD62RuSX7HpswBzSYf/9YHtYvFlfY2Tl0HScoHr8
	utCr2v3lyRA4UMycFk75eAq2s5bd26OMy
X-Google-Smtp-Source: AGHT+IEVUq57VuR5XJDhYVOCvnCwTfmEHGvoTOOB+teIWs3F3TJQh8yeiHRLwccdv5kTX5+vj5zTsLfWMZ4F/nufsZs=
X-Received: by 2002:a05:6102:32ca:b0:4a4:7609:35f with SMTP id
 ada2fe7eead31-4a8cfd6d7bemr401289137.24.1729881550725; Fri, 25 Oct 2024
 11:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com> <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
In-Reply-To: <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 25 Oct 2024 19:38:59 +0100
Message-ID: <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
To: John Hubbard <jhubbard@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 6:41=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 10/25/24 5:50 AM, Pedro Falcato wrote:
> > On Fri, Oct 25, 2024 at 10:41=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> ...
> >> +static inline int pidfd_is_self_sentinel(pid_t pid)
> >> +{
> >> +       return pid =3D=3D PIDFD_SELF_THREAD || pid =3D=3D PIDFD_SELF_T=
HREAD_GROUP;
> >> +}
> >
> > Do we want this in the uapi header? Even if this is useful, it might
> > come with several drawbacks such as breaking scripts that parse kernel
> > headers (and a quick git grep suggests we do have static inlines in
> > headers, but in rather obscure ones) and breaking C89:
> >
>
> Let's please not say "C89" anymore, we've moved on! :)
>
> The notes in [1], which is now nearly 2.5 years old, discuss the move to
> C11, and specifically how to handle the inline keyword.

That seems to only apply to the kernel internally, uapi headers are
included from userspace too (-std=3Dc89 -pedantic doesn't know what a
gnu extension is). And uapi headers _generally_ keep to defining
constants and structs, nothing more.
I don't know what the guidelines for uapi headers are nowadays, but we
generally want to not break userspace.

>
> I think it's quite clear at this point, that we should not hold up new
> work, based on concerns about handling the inline keyword, nor about
> C89.

Right, but the correct solution is probably to move
pidfd_is_self_sentinel to some other place, since it's not even
supposed to be used by userspace (it's semantically useless to
userspace, and it's only two users are in the kernel, kernel/pid.c and
exit.c).

--=20
Pedro

