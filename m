Return-Path: <linux-fsdevel+bounces-19298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EE8C2F71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188331F212BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 03:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4CC3716D;
	Sat, 11 May 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEx3kdcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54215288DB
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715399531; cv=none; b=WSqvjCqla0NDoL9ZYviQ0m4ZkwHog/x0zx6uu3kKsRT62weNEtMdzgxOjD6Q4+UBxQuBr3X6Aa+7c3Xr92ui1G8sJF/f5Nce/YsLSXk5uUQKSdb1BYODsSJdxU8l6AAp9YMBQZzgaui+bYvNVkYXfrHUZ/1sViMap1Eiz2lNmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715399531; c=relaxed/simple;
	bh=LqjQ1Fx77ijtCw2rJ99YJH/gretoVA8HsHxzCWR6UA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+LL/EYlfROFx+Msj7aD1tJFEmZ0WHOvgyr7mubvj06VUige6wzwU5kSNJ/pmCWTCgXa8S/IyolWIU8XDmtBYcBEg7aq7e1v8sBV1jRK61qCqWWFpGQDVZQUH5SDxvnIYryE4t7NJWMo425imG1B7p/YdZ8YhFcqDSuVeP4eCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEx3kdcz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b47833dc5so13411646d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 20:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715399529; x=1716004329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBP6PZgsthFJG0gO2E+xRrvuab/jvd7S3uZA7HmrTNw=;
        b=gEx3kdczR+0dWDmu9TIyJOw4wBCSZ86DOFW6eA1uRIYThIUu2WrCPEco8lCccULV+I
         kgLK4ph7naYMMTLvjVVT7iil0jAOjKZT6tTmeTtlsZbxYtpKWvBvqTtS63lJpKo+dyiY
         b/UM3A97MtUr9YiXb2Ya+0mhKxYDIW8oZn+d6hKfiK/e7VnSApreLdRNbNYMURKgXoG9
         bZ/3lGBhqzbKtNpkE0Y/UDhbZVy8nNsM/J1qOcZgbuQSIeHjVG4vTg1E3qZ3Bnu4Bc5B
         6QNUt6L0MA60DOU26j2QlPvceLFD3XiOl3gpFJtH0oFSBdOK7CJy/sBcodd6zGrYPoh3
         B3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715399529; x=1716004329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBP6PZgsthFJG0gO2E+xRrvuab/jvd7S3uZA7HmrTNw=;
        b=FbnRE+1z75QuUbjQOK4+kHLkN+nXwb69lPDo4ZAs5SpsZOU8wFH/ovA2CU/rfZOdqs
         t91QzkEY81Lht0+OCt8Ibj5itoy4pbGu3gE+/qmKLLv8zels5s5HZdnmfR5SztF2fHt9
         f5x26lNkrwcBNjtPFjLOsXildGLY+tjLLg3Xf1T8kiMYf/JjzmZQaUqu7uPqSHqUDNFX
         46c5UyYp/wsr+HjOqffs+46NpkwXxdUgN8xUircPMHpOc8YouCpuW0qs0tRiSpO7gzdD
         kkBIA5EpijPYbHDZVilQJ7gxDc4/p824+Y2kphmCxqRpkM5wR5CeXlj0DPJDJPlgqyAu
         CF+g==
X-Forwarded-Encrypted: i=1; AJvYcCWwEjHEtF0cTvirGxXMDgFx7uSb0nFYDCehOXsxWzdO8iB0rSYhkX6iTR/qTBNA0LYoCL3lilt61Fdqinm75z9UiduL/pbZCPkYwshLVA==
X-Gm-Message-State: AOJu0YxUWEdCZnLCQCzN4SLl96+5d23B5t5B7i3lwWGbmQrizG/XLblH
	JvrHVZgTyVg8St1mpEU1J0IGu46V52d3lFoLjF9XDfJO4Uwz05HsGQrTjlW15z96CsFAin/STNf
	/edvz7rYQIcNKAtOppCXBuEqtzcU=
X-Google-Smtp-Source: AGHT+IE5NJYbfVzPVKdDHZt67Rly9yNd90WmDOe9tku2JYtb4k67xZ9OzWpCppYhnHJh+dkWHwf5vTE0Lm5Byc/qrBs=
X-Received: by 2002:a05:6214:3a85:b0:6a0:936e:4f93 with SMTP id
 6a1803df08f44-6a168243ff1mr53782806d6.60.1715399529205; Fri, 10 May 2024
 20:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <20240511033619.GZ2118490@ZenIV>
In-Reply-To: <20240511033619.GZ2118490@ZenIV>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 11 May 2024 11:51:32 +0800
Message-ID: <CALOAHbA45hjUih0x5NfyHxud-d9JGz+8XAX51imc6GT=EPGcjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:36=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Fri, May 10, 2024 at 07:53:49PM -0700, Linus Torvalds wrote:
>
> > although I think Al needs to ACK this, and I suspect that unhashing
> > the dentry also makes that
> >
> >                 dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
> >
> > pointless (because the dentry won't be reused, so DCACHE_CANT_MOUNT
> > just won't matter).
> >
> > I do worry that there are loads that actually love our current
> > behavior, but maybe it's worth doing the simple unconditional "make
> > d_delete() always unhash" and only worry about whether that causes
> > performance problems for people who commonly create a new file in its
> > place when we get such a report.
> >
> > IOW, the more complex thing might be to actually take other behavior
> > into account (eg "do we have so many negative dentries that we really
> > don't want to create new ones").
> >
> > Al - can you please step in and tell us what else I've missed, and why
> > my suggested version of the patch is also broken garbage?
>
> Need to RTFS and think for a while; I think it should be OK, but I'll nee=
d
> to dig through the tree to tell if there's anything nasty for e.g. networ=
k
> filesystems.
>
> Said that, I seriously suspect that there are loads where it would become
> painful.  unlink() + creat() is _not_ a rare sequence, and this would
> shove an extra negative lookup into each of those.
>
> I would like to see the details on original posters' setup.  Note that
> successful rmdir() evicts all children, so that it would seem that their
> arseloads of negative dentries come from a bunch of unlinks in surviving
> directories.

Right, the directories are fixed. We've engaged in discussions with ES
users regarding changing the directory, but it would entail a
significant adjustment for them.

>
> It would be interesting to see if using something like
>         mkdir graveyard
>         rename victim over there, then unlink in new place
>         rename next victim over there, then unlink in new place
>         ....
>         rmdir graveyard
> would change the situation with memory pressure - it would trigger
> eviction of all those negatives at controlled point(s) (rmdir).
> I'm not saying that it's a good mitigation, but it would get more
> details on that memory pressure.


--=20
Regards
Yafang

