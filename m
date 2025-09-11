Return-Path: <linux-fsdevel+bounces-60937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD9B530E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D792A021DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62131E0E2;
	Thu, 11 Sep 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbgcjOFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4ED31D39B
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590604; cv=none; b=ja+oSAlkR6qSOr7aRbuZ5RgXMyqrzGIJ2iAbDo1qJEoRIg7soz5dyuanVkwCQggyrUAfJQPEs0oKQILTmtK9DI5DEIM+nUY68sf2GkXTn/b1NLnIMoztzi/ErGSKR9B1freEyGuV5WcSBmitKbcLN47LfjDuE4efgAGJd2oiUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590604; c=relaxed/simple;
	bh=l3WS5mh3b7m+0CGnd7HwPGEX6fOXJSXSic0gzbaETOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPdh5yvZZB4VMPcnrXyyTIRorPPrttfbVZXXGsLegWmOKpvjCD0q0+fTWpB4LUNyDyE7nqmEhbH7Q+WqmfKYtq/WWrQMPjgwT1bHoy6hezHtmBMPYc3kPXU6XisfMS4LutwdtShjB9warvE1iommjvGeWeD000nUgnNaxSwCc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbgcjOFd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so904578a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757590601; x=1758195401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3WS5mh3b7m+0CGnd7HwPGEX6fOXJSXSic0gzbaETOY=;
        b=QbgcjOFdQCEX77z/FdlRwnzEmGsALvq3U9SOMI0CS5/Coz9cwTG3pr8H10coBpZ0ZT
         ALfxzqhBFvmTlunvaBg5eojquIU2M0Jaj6+Hd0e8iXqgKuOZqpt4Pv6GARREjVuH73n6
         hdS/4L12c0LlPui/1Ra+uKktXYpezhtgeFeBAindj/qegG++n014aPkSXSpYqw+JJt2x
         5d9AacMrKkjsMmKaZ0myeESD6BMVT92frcJGeyabQR1LDI54v2GGB/cQhRWnOlA2P3pb
         1nosawlRTBFeGlzHK360D6IZGmPAf3T+Q0SiPG4HX3udF0VqG3qAdTsBxdNsQnMuetky
         AnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590601; x=1758195401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3WS5mh3b7m+0CGnd7HwPGEX6fOXJSXSic0gzbaETOY=;
        b=c/P/RzajomDRM2bD6bBmwGOYgsd0voj2q28iU7x/hzykY99Hh9n4J4apgCi8I4+eex
         VX1kWXZMRNJ06qbG7gJn++AX/1BfUkgwtPW5XJxt4/mnU/6+vHbqD/sf608AQEBqLTbT
         Wf9WxltdTLvkQTXKJ3y2HYBDgKwxHbcDLnZJzLOoCcIBu8ajDiveU7kf5Mz9T2h5Z/V3
         H3N35OEWNMmDr06TO0iyR+93bnfeOaBnqoz0i9hxz3eulHGGIDsilDYJ444wdyYkojJn
         I5BRfZTQtUbsw0qZsPAJTrVl1xPrvM39U9x/oqnA517yLZ6n0WTGxgACpc1D39WhJgNe
         glNw==
X-Forwarded-Encrypted: i=1; AJvYcCUjgyA2J9VvVDEBhzukhaVeXauWpBT+0PmKvKxAeFdqpKFGyOnE9KUwLAFzA9/noqenwlEdHj9LT6oG9U8r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy475f7D8tB/X8hyzfuePZWDdZXbVJA28dlDfuFiiZNsiEfsoCz
	1vP/iklkJ7HvA4jc2ILatQHODn1wlYTZ5+bErp1sF2h2Vx0a074sTVcZok3nY8uAz8WhszMjlmU
	1Y6YDAiBSkcG1mzQ+gw47MIGNHNgvLo8=
X-Gm-Gg: ASbGncugdK704SSgPvQoKviSp/HZpCaQ2vNVBQgPc8S5Qe2WDPQDfFxR2C54Ti82JcI
	tNfPZditmtNKQBEOxn7Yxqz04UT8u4vpH9sSGbK4PU7aXo+7uBwoh6kLSJvWs1cBFWeZ3+lbPYE
	5lNEtEZx1Uk2fVSsXnJEwA6ST8fZYcQqVib2Fn09yWbjOFdQ9FZRcwXMhgi7GQzbphGKWk3dWjS
	ICvV6W4WmNiQWP+bQ==
X-Google-Smtp-Source: AGHT+IFTNKY6jjRUaK+95vjWoIXWhr+sTjejTLV8OOCQsfjrobYVHw8JMmZi1nhLUH2mOW0HugLlXyiAfLiI1n/62Pg=
X-Received: by 2002:a05:6402:2685:b0:61d:dd9:20db with SMTP id
 4fb4d7f45d1cf-6237c048793mr16217741a12.31.1757590600743; Thu, 11 Sep 2025
 04:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org> <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
 <20250911-werken-raubzug-64735473739c@brauner>
In-Reply-To: <20250911-werken-raubzug-64735473739c@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 13:36:28 +0200
X-Gm-Features: Ac12FXxRFt9Ctd5Cl_pR-FdI4tarLWVQlbT7aCbaq2ftodBoMLqTaIDo5wMZnik
Message-ID: <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>
Subject: Re: [PATCH 27/32] nsfs: support file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:31=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> > On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > A while ago we added support for file handles to pidfs so pidfds can =
be
> > > encoded and decoded as file handles. Userspace has adopted this quick=
ly
> > > and it's proven very useful.
> >
> > > Pidfd file handles are exhaustive meaning
> > > they don't require a handle on another pidfd to pass to
> > > open_by_handle_at() so it can derive the filesystem to decode in.
> > >
> > > Implement the exhaustive file handles for namespaces as well.
> >
> > I think you decide to split the "exhaustive" part to another patch,
> > so better drop this paragraph?
>
> Yes, good point. I've dont that.
>
> > I am missing an explanation about the permissions for
> > opening these file handles.
> >
> > My understanding of the code is that the opener needs to meet one of
> > the conditions:
> > 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> > 2. current task is in the opened namespace
>
> Yes.
>
> >
> > But I do not fully understand the rationale behind the 2nd condition,
> > that is, when is it useful?
>
> A caller is always able to open a file descriptor to it's own set of
> namespaces. File handles will behave the same way.
>

I understand why it's safe, and I do not object to it at all,
I just feel that I do not fully understand the use case of how ns file hand=
les
are expected to be used.
A process can always open /proc/self/ns/mnt
What's the use case where a process may need to open its own ns by handle?

I will explain. For CAP_SYS_ADMIN I can see why keeping handles that
do not keep an elevated refcount of ns object could be useful in the same
way that an NFS client keeps file handles without keeping the file object a=
live.

But if you do not have CAP_SYS_ADMIN and can only open your own ns
by handle, what is the application that could make use of this?
and what's the benefit of such application keeping a file handle instead of
ns fd?

Sorry. I feel that I may be missing something in the big picture.

Thanks,
Amir.

