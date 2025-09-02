Return-Path: <linux-fsdevel+bounces-59957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C677B3F8F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D3F2C0603
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC972E9ECE;
	Tue,  2 Sep 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoUiB0fg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A272E9EA4;
	Tue,  2 Sep 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802713; cv=none; b=pqOvoilw9Q4DXtpoUyK12hZzJk9TaNZhbLlg98Ss41FDHAxARw9y8i7o8ZwQu6GoM+juhehuSqfgATaihS02zFpZe1kVL9gYKnUfEPlBK4Hy+USRnTK7g57zh8Tou7jDS7f9qvHOrgVEHAjRboOnNdYy0dbx9YfkhmjE8GtbwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802713; c=relaxed/simple;
	bh=pHMmGYoGlJbB7WFIeGZ7N5f575iJJiVTHUPoSvca+54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGwprhickI3mGtpGD3w/9OEPb9eAL2wUWJmpgUP32nZ88owcp7ZB0DLbZ/qAG7rusdyJIaTGlSSwaOgtZTHf+A8WaLi5LvP/sGR9n4nVloKkaMyoIDZv21JO6bauCwoPaM/gn226N27xZMroUqj1LndRVD7bWxhO5ZSO5npI3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoUiB0fg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61e930b27bcso2396365a12.0;
        Tue, 02 Sep 2025 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802709; x=1757407509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVrfdXyH/4C0Wr0YHZaw6gV8VgGdQhG3sK6jQ9dFmeA=;
        b=MoUiB0fgUbkP/zuwR8Nh7yeNFyhwFWKsz2aT6nptKyiOV7n49rCOXOGWvQRW3piIx4
         PgrIQI9KdE8fMRzQr5CN9fsGRjNTEH/7GNYsyzY5hCPHcwIggZSvfvUW1y5/XSMlJop1
         V/jh82Vz8VF+hfekmfNS/kMBrHl8iSBWI9z3g/2DKxjQHtcY1kmNIiToPBxxuDurr8Ec
         q7+ilQm6udA+BAAf5G7WbmrFDZ+X1xs+rezJnkp0oNMYDzOdroTahazeWTYBlbVfRi+x
         sp5DXhLNSH4VfjOHuhecGfZIlxuQpCVBdUPgPEMRCa5vN7Q6fGR+1l+DJdY6SLkreP4d
         W5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802709; x=1757407509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVrfdXyH/4C0Wr0YHZaw6gV8VgGdQhG3sK6jQ9dFmeA=;
        b=B8TyRrdAVJVkXldLST1ZLdzHlJ+pDNrK8vOiQm3r4F34se6J2ClU4oaZjUGx7AfYb6
         QHGuXOMV09zZazgYc8gOlL8usPIc8xJTXKbYshNQ8OFB9yjbGojCgZ1jhZkjJ8YXn2dJ
         KkNwJb7E8rYXdC828EAPZorALDXjG20J7fU9GBV627+OmvnTSozudbsYviFvCXQIkNDA
         8dlj3me/5Czjfe0J5oyQv9cG3e0MJYO74vGpsGIFESh5ccHKFte5N760RekAXwW4syKo
         N77J9iQuiOTLXRzJWQZ3yPzoX38V+O2sOU1YOGtRawyRnTBfVsgKylgz8lBXXahvqHpK
         x5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUp6D47mov7Dj5th+MK//mj2mZYUN1bM6KM857za1dH/PG2xwYHqrL0AKjegD9+dC9fM2TAHp97zmQOLwKq@vger.kernel.org, AJvYcCXU/UBETk26g5fdhwL0kYpVnYLL4P8MpE5k7DzMvEwsujiWMA0uYwRGi/Kcv+wW/C/13FagOYvEvjuC8kzu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63Yf8hlWaltxJi5CKbEZThQW4IR9x83XIISW4ZiPE06+nVVqt
	WipMBDj4BP6d1Dmt/rRkkE+E+wijL2Ek4+JaqwvdCLgDG00fTcD1v3ZR7N5BC02rE+MYjqlTXsh
	lRezcLYIOJyasULOpk6Cr4CZyZFsqSKM=
X-Gm-Gg: ASbGnctKY6u+muEMfrBN5dtIjDcSNpzvSnfBJcAMuFW2SoClGDnDPnp7E4VPnIOZi2Q
	xtnaLXOsKM75d+vCTHQl5YMuh9Hjln+oc3W0JFBW+/9AQ32DZRGVV2rUcMtVIAdwuCbHseyMWrw
	5wbNzU2DoeEacMmPXBbBH61rJqRjJMJNLO5C+XKisiBJaYEnHDfFi+GOw5kKQtMjHVnpgroS/yb
	ah3LLk=
X-Google-Smtp-Source: AGHT+IFGTaCsHR4a9P7flHhL8ZGVpHQPhnAA0INvLEVYel2rMzuNm39zgM1QxNQF79NV6M5jkKIZmj7q5oxktyZfAwQ=
X-Received: by 2002:a17:907:940a:b0:afe:f8cb:f8bc with SMTP id
 a640c23a62f3a-b01d9732721mr1067259866b.35.1756802709199; Tue, 02 Sep 2025
 01:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl> <20250902-faust-kolibri-0898c1980de8@brauner>
In-Reply-To: <20250902-faust-kolibri-0898c1980de8@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Sep 2025 10:44:56 +0200
X-Gm-Features: Ac12FXyvinFOW_EJGt3vGhfseoNJIoyCngvXL82TwH-ASLnPznf8obpH_dJti4U
Message-ID: <CAGudoHHV6U5TobvSobzSCor1nN8tb9Ez0fYKxc9+OZtP9EgE-w@mail.gmail.com>
Subject: Re: ETXTBSY window in __fput
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Monakov <amonakov@ispras.ru>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:33=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Sep 01, 2025 at 08:39:27PM +0200, Mateusz Guzik wrote:
> > On Wed, Aug 27, 2025 at 12:05:38AM +0300, Alexander Monakov wrote:
> > > Dear fs hackers,
> > >
> > > I suspect there's an unfortunate race window in __fput where file loc=
ks are
> > > dropped (locks_remove_file) prior to decreasing writer refcount
> > > (put_file_access). If I'm not mistaken, this window is observable and=
 it
> > > breaks a solution to ETXTBSY problem on exec'ing a just-written file,=
 explained
> > > in more detail below.
> > >
> > > The program demonstrating the problem is attached (a slightly modifie=
d version
> > > of the demo given by Russ Cox on the Go issue tracker, see URL in fir=
st line).
> > > It makes 20 threads, each executing an infinite loop doing the follow=
ing:
> > >
> > > 1) open an fd for writing with O_CLOEXEC
> > > 2) write executable code into it
> > > 3) close it
> > > 4) fork
> > > 5) in the child, attempt to execve the just-written file
> > >
> > > If you compile it with -DNOWAIT, you'll see that execve often fails w=
ith
> > > ETXTBSY.
> >
> > This problem was reported a few times and is quite ancient by now.
> >
> > While acknowleding the resulting behavior needs to be fixed, I find the
> > proposed solutions are merely trying to put more lipstick or a wig on a
> > pig.
> >
> > The age of the problem suggests it is not *urgent* to fix it.
> >
> > The O_CLOFORM idea was accepted into POSIX and recent-ish implemented i=
n
> > all the BSDs (no, really) and illumos, but got NAKed in Linux. It's als=
o
> > a part of pig's attire so I think that's the right call.
> >
> > Not denying execs of files open for writing had to get reverted as
> > apparently some software depends on it, so that's a no-go either.
> >
> > The flag proposed by Christian elsewhere in the thread would sort this
> > out, but it's just another hack which would serve no purpose if the
> > issue stopped showing up.
> >
> > The real problem is fork()+execve() combo being crap syscalls with crap
> > semantics, perpetuating the unix tradition of screwing you over unless
> > you explicitly ask it not to (e.g., with O_CLOEXEC so that the new proc
> > does not hang out with surprise fds).
> >
> > While I don't have anything fleshed out nor have any interest in puttin=
g
> > any work in the area, I would suggest anyone looking to solve the ETXTB=
SY
> > went after the real culprit instead of damage-controlling the current
> > API.
> >
> > To that end, my sketch of a suggestion boils down to a new API which
> > allows you to construct a new process one step at a time explicitly
> > spelling out resources which are going to get passed on, finally doing
> > an actual exec. You would start with getting a file descriptor to a new
> > task_struct which you gradually populate and eventually exec something
> > on. There would be no forking.
> >
> > It could look like this (ignore specific naming):
> >
> > /* get a file descriptor for the new process. there is no *fork* here,
> >  * but task_struct & related get allocated
> >  * clean slate, no sigmask bullshit and similar
> >  */
> > pfd =3D proc_new();
> >
> > nullfd =3D open("/dev/null", O_RDONLY);
> >
> > /* map /dev/null as 0/1/2 in the new proc */
> > proc_install_fd(pfd, nullfd, 0);
> > proc_install_fd(pfd, nullfd, 2);
> > proc_install_fd(pfd, nullfd, 2);
> >
> > /* if we can run the proc as someone else, set it up here */
> > proc_install_cred(pfd, uid, gid, groups, ...);
> >
> > proc_set_umask(pfd, ...);
> >
> > /* finally exec */
> > proc_exec_by_path("/bin/sh", argp, envp);
>
> You can trivially build this API on top of pidfs. Like:
>
> pidfd_empty =3D pidfd_open(FD_PIDFS_ROOT/FD_INVALID, PIDFD_EMPTY)
>
> where FD_PIDFS_ROOT and FD_INVALID are things we already have in the
> uapi headers.
>
> Then either just add a new system call like pidfd_config() or just use
> ioctls() on that empty pidfd.
>
> With pidfs you have the complete freedom to implement that api however
> you want.
>
> I had a prototype for that as well but I can't find it anymore. Other
> VFS work took priority and so I never finished it but I remember it
> wasn't very difficult.
>
> I would definitely merge a patch series like that.
>

I'm happy we are on the same page here, I'm unhappy it is down to the
point of neither of us doing the work though. :-P

I don't think the work is difficult from tech standpoint, but it does
warrant some caution.

With the current model fork + exec model, whatever process-specific
bullshit gets added, you automatically get it on fork.

Something which gradually spells out the state will need a way to
figure out what was not sorted out and fill it up in kernel-side.
There maybe some other caveats, basically it would be good if
someone(tm) really thought this through. It would be really
embarrassing to end up with a deficient & unfixable API which has to
remain supported. :-P

I offer half of the kingdom for a finished product, the interested
party will have to arrange a bride from elsewhere.

> >
> > Notice how not once at any point random-ass file descriptors popped int=
o
> > the new task, which has a side effect of completely avoiding the
> > problem.
> >
> > you may also notice this should be faster to execute as it does not hav=
e
> > to pay the mm overhead.
> >
> > While proc_install_fd is spelled out as singular syscalls, this can be
> > batched to accept an array of <from, to> pairs etc.
> >
> > Also notice the thread executing it is not shackled by any of vfork
> > limitations.
> >
> > So... if someone is serious about the transient ETXTBSY, I would really
> > hope you will consider solving the source of the problem, even if you
> > come up with someting other than I did (hopefully better). It would be =
a
> > damn shame to add even more hacks to pacify this problem (like the O_
> > stuff).
> >
> > What to do in the meantime? There is a lol hack you can do in userspace
> > which so ugly I'm not even going to spell it out, but given the
> > temporary nature of ETXTBSY I'm sure you can guess what it is.
> >
> > Something to ponder, cheers.



--=20
Mateusz Guzik <mjguzik gmail.com>

