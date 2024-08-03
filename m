Return-Path: <linux-fsdevel+bounces-24912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B385C946829
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 08:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C28A2822E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB314BFB4;
	Sat,  3 Aug 2024 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUWyKag+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663A847B;
	Sat,  3 Aug 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722666573; cv=none; b=IgM7oJqXq6z8Dksbgxxje2OqUNNtin9weaXinW8ufSMu86rTdneQR3xIVrtFSPfIbvSJMwSpZRWL0iukqqPDsIbRWbfe0vlXTU/+E6nxFla0w4RoMY6HAQ9/1EBbUJB1FNzCTAU3AF0HnzU7ox9FtNWKzN+6dBLH+rd/2OYb6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722666573; c=relaxed/simple;
	bh=1tycnwI8CksGXEW6bv1nXi73bpRjLcKp6j6514Nq7i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlKUXCUltTh6R0vQXuVo+hdkZ2ngA5p7Owm+T73ufX8s7rJgfFzHwTMpkE61GGknk8MedSM3mJxF52NasGWH3M1XyvSkyl+xPx386ipfQvXB5s+OtRrNosBmprWNzV9KrjiRLlKqtjx+TP7KY+4+MUv+9NrYG7Osl6Kx0dbs+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUWyKag+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a94aa5080so245257866b.3;
        Fri, 02 Aug 2024 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722666570; x=1723271370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVBdH8r6aqubFTzoKQwMuGbkV/3y3tWnewU/Nufy8x4=;
        b=jUWyKag+Y9h8/3jGOi3aAfABdoKnRAk3xH/EhdQJn442nvcD3XlmhhIix8jyvTLHZ2
         Gw5sFf2Fbe9B23vjjVHit1W2xB3QJmKd0+RqVOUNb9LeFeEhLdxd5GDgDbuQebQwhJ7B
         obqScN6GiXDg68MjPk5Q6cFQQ95i6+eRHfUzCy+a+4UIGtSWo8JTFqjxCqDiCQbVMssP
         NIWncmoo5rX0gFkBDC/2KBEvikLRqZqs32w2e1uN0OUWTLu5MXqDZhZOUwwAuB17CBYK
         43ogmbwQI8zhKXTy3KKXzCU0AYhqYqfrcdYnU7bTK6ZORLa+0eX6prfLfpZ5B9ov1WgH
         i0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722666570; x=1723271370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVBdH8r6aqubFTzoKQwMuGbkV/3y3tWnewU/Nufy8x4=;
        b=blegVPX6ClMQQQrKAz/EoJFvQWK8LjjEchIzYtR1lsCUU1Bs1jkmwwluEgEfhBxRjQ
         yNbd22HLLvzRS+1WJSq1e6lbJQ6ZnNoNf5tpAWh+4OdP2U6GqM73Nc1csE2Gq4MYXfld
         W9jgD9v4R+GvEXEIPJeE+Yx1kEX9ApCCjshglvkwgIOh/QcMVwXB8MLNuumj+zNyEQBZ
         /1tAIGDTvRrhm8ZLtyCdjOn0gOZMY7Y4W1bZ1FxtJLzGWEhZHl/HuZvzXzTlRuqVqBTi
         3+FEWfOK9W953nMglXffs+0DMZ4rOdE+VTUfbzYavCZWExCovFna5U9Q2awVX17homMp
         qQug==
X-Forwarded-Encrypted: i=1; AJvYcCUakdvLIlScXNH01ABsYZ0XLQg6bro0AxuTZlFZfvolC7A0PklnnAhSki/gT0wIpUGJGMiMIR02eECr1RUnO+l5TX+pys6gNtCxim8V2FHTHN6dHo0JqHLp1u/muil3Alqwmw17jR3kxC3q7g==
X-Gm-Message-State: AOJu0YzQZb016uf6l0/nH4P9gSkenh+rxXUemivuQLZ1WvMSctNl+l2Y
	g3j4KHIV8XfL3yRntzsQMS7gMCdKilQEdnYbIWaarjF5SkWT3o9jvN+XqhKHA+HuNNLEm2TWesg
	0JmogjJV9WbQ8NazrNiSghfcl08k=
X-Google-Smtp-Source: AGHT+IFmv325o1+pgG/LjanSxWspk+B4AEBtVNp6UMyei/yaP0MexaEA26gqUc76kG3b6fX8prmKolVJsjEUpXwOdbA=
X-Received: by 2002:a17:907:2daa:b0:a7a:ab1a:2d71 with SMTP id
 a640c23a62f3a-a7dc51bd5cbmr396948866b.59.1722666570094; Fri, 02 Aug 2024
 23:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
 <20240801140739.GA4186762@perftesting> <mtnfw62q32omz5z4ptiivmzi472vd3zgt7bpwx6bmql5jaozgr@5whxmhm7lf3t>
 <20240802155859.GB6306@perftesting>
In-Reply-To: <20240802155859.GB6306@perftesting>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 3 Aug 2024 08:29:17 +0200
Message-ID: <CAGudoHFOwOaDyLg3Nh=gPvhG6cO+NXf_xqCjqjz9OxP9DLP3kw@mail.gmail.com>
Subject: Re: [PATCH] kernel/fs: last check for exec credentials on NOEXEC mount
To: Josef Bacik <josef@toxicpanda.com>
Cc: =?UTF-8?Q?Wojciech_G=C5=82adysz?= <wojciech.gladysz@infogain.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	ebiederm@xmission.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 5:59=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Thu, Aug 01, 2024 at 05:15:06PM +0200, Mateusz Guzik wrote:
> > I'm not confident this is particularly valuable, but if it is, it
> > probably should hide behind some debug flags.
>
> I'm still going to disagree here, putting it behind a debug flag means it=
'll
> never get caught, and it obviously proved valuable because we're discussi=
ng this
> particular case.
>
> Is it racy? Yup sure.  I think that your solution is the right way to fix=
 it,
> and then we can have a
>
> WARN_ON(!(file->f_mode & FMODE_NO_EXEC_CHECKED));
>
> or however we choose to flag the file, that way we are no longer racing w=
ith the
> mount flags and only validating that a check that should have already occ=
urred
> has in fact occurred.  Thanks,
>

To my understanding the submitter ran into the thing tripping over the
racy check, so this check did not find a real bug elsewhere in this
instance.

The only case that I know of where this fired and found a real problem
was after ntfs constructed a bogus inode:
https://lore.kernel.org/linux-fsdevel/20230818191239.3cprv2wncyyy5yxj@f/

But that is a deficiency in debug facilities in the vfs layer -- this
only tripped over because syzkaller tried to exec a sufficiently bogus
inode, while the vfs layer should have prevented that from happening
to begin with.

There should be well-defined spot where the filesystem claims the
inode in fully constructed at which the vfs layer verifies its state
(thus in particular i_mode). If implemented it would have caught the
problem before the inode escaped ntfs and presumably would find some
other problems which the kernel as is does not correctly report. This
in part depends on someone(tm) implementing VFS_* debug macros first,
preferably in a way which can dump inode info on assertion failure.

I have this at the bottom on a TODO list for a rainy day.

However, it's not my call to make as to what to do here. I outlined my
$0,04 and I'm buggering off.
--=20
Mateusz Guzik <mjguzik gmail.com>

