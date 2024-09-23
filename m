Return-Path: <linux-fsdevel+bounces-29915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD2983A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 01:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2232283973
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE1E7350E;
	Mon, 23 Sep 2024 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VYud4bmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96484A4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135367; cv=none; b=VPyRa4KxjfqFU3sHCv+nXxUNEta83ZerXoZ83fpQXMSTZfPSJ874gfnK5BAncDsruZ/XZxf8ZJWTi2keJ4cAWmnOBvV5oDzVUsWMeumn0Wag5AvyPnEF2ZoAlAntPHmodS+/WuE0jMsaEQuGsSoTt2sn9OTOEtWNmLwwISCsG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135367; c=relaxed/simple;
	bh=HU43nzvVNk9+05verNfvUGl1WsBlPAb0vAlHXWXhn18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCK7aykayU+EJWa83KIcz23f63kG+3QPRVyW4rcp3BgRxCDpJZlSMXUVmByUaM0yEcMxCQCzN/Iuq/DP0kOKjqust84fHtADcZ9IQc+EViQUtGPSb9pK9Zfai471gTvRpFMsOi7rNxZ22GSsuMg/O9ZVhQLwS1TERVkVxbt3Usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VYud4bmU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1f139b97b5so3343278276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727135365; x=1727740165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cLjKvwxneJcBR6J40T7jZrecVgD/PcilkfSszPFN14=;
        b=VYud4bmUy11hl6eocVPRUBzHEeWNF2jCk+CLIxDwRJusg4y6VjIRwOBe3RZQMkHrTX
         KwZTp1dObixddpjjNJe3APe4gdffd5UuzzrrTGJbMX6kCCh2QZiJPcxdN6c0GF0ll0Xe
         OZRynlUJci3AiUv5VYXo9nuH8bISs0Ibge/emNM6KekRYk3qZ0d99rUhpyP/fZqayrE0
         zwrRpGWzXSYJsHwE1TtPyt69/0vUwKsHEOuULdIqumbgsD+JhFdarFtOzjQau0HHl3pd
         gXFiImLHaTYhKHQoAe8xbyTuxyv1KEmCf9zHv4BmKgRRrXCU5j2lok2350Qh8y3pkFDY
         jsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727135365; x=1727740165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cLjKvwxneJcBR6J40T7jZrecVgD/PcilkfSszPFN14=;
        b=SVmUPo/3+ZyVSxF1FjjkVQdzURwI8j43mDNQ1TghLk05pTCnj3TbmJ8PaKuqtXBJLm
         uPf0odQ3Iu+dLBHnELTaAQ8+dR5d6WDE+1dQQwvKSVhC9Zkti533kSlcbJcflf00qPiN
         sI2Qxk+OaVJMTPMlz7uhwzM8poKiFJLTofcgg9elCESa3bm/N5w1AOEmsqvIeVYpifH7
         ChW0O37ZPA+qDgO/w5b3zR+jfUup8xJrPDbB/iSFW2ia9aZ4CbiaU+V+p+kt82p5K3CX
         Fjue8mfyotYMz/g8F6obN9yWYxs5zkbGkeouURSQNKtmtyDraayrmIVjCCRGne7XYF4X
         twKg==
X-Forwarded-Encrypted: i=1; AJvYcCXj6ek+bfJ0YZltK8onke1uYaxaEbEBY9iLecw0M0EW4Y6HxHMbUv5uJNPu9Ox3l9/mmfgIJxTFiiduEAVH@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbZ7Yqsh7gIZGk7NbImc62fHms4QPLGi54tiP26buTkZA4WIQ
	jwRrC44hVDxayh4YVBBK2HlP7wT/aL3KKodcdnnhAaiuu8W/PSRzX/CueUQ00WrbJ2YGBhHhQer
	pkTCVmr+t7X29C+S8PiZS3g2XJbLJailObBRZtw5IX3rWXC0=
X-Google-Smtp-Source: AGHT+IFw7+U6BIUQhoB56ZTnhfxp4VWC9o3g7D5THvWYs9Gj/WYzoDtYtT/PRTbyV9s5j2eII9uhk4RoLsH6JASzdhw=
X-Received: by 2002:a5b:b89:0:b0:e1d:9f6d:2eab with SMTP id
 3f1490d57ef6-e2497901e8dmr981637276.26.1727135364823; Mon, 23 Sep 2024
 16:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk> <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV> <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
 <20240923181708.GC3550746@ZenIV>
In-Reply-To: <20240923181708.GC3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 19:49:13 -0400
Message-ID: <CAHC9VhRBLxOCwU1aBY6yu2H0YwmvQdJBDy9OJ8cG36JCc7GkJw@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:17=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Mon, Sep 23, 2024 at 12:14:29PM -0400, Paul Moore wrote:
>
> > > And having everything that passed through getname()/getname_kernel()
> > > shoved into ->names_list leads to very odd behaviour, especially with
> > > audit_names conversions in audit_inode()/audit_inode_child().
> > >
> > > Look at the handling of AUDIT_DEV{MAJOR,MINOR} or AUDIT_OBJ_{UID,GID}
> > > or AUDIT_COMPARE_..._TO_OBJ; should they really apply to audit_names
> > > resulting from copying the symlink body into the kernel?  And if they
> > > should be applied to audit_names instance that had never been associa=
ted
> > > with any inode, should that depend upon the string in those being
> > > equal to another argument of the same syscall?
> > >
> > > I'm going through the kernel/auditsc.c right now, but it's more of
> > > a "document what it does" - I don't have the specs and I certainly
> > > don't remember such details.
> >
> > My approach to audit is "do what makes sense for a normal person", if
> > somebody needs silly behavior to satisfy some security cert then they
> > can get involved in upstream development and send me patches that
> > don't suck.
>
> root@kvm1:/tmp# auditctl -l
> -a always,exit -S all -F dir=3D/tmp/blah -F perm=3Drwxa -F obj_uid=3D0
> root@kvm1:/tmp# su - al
> al@kvm1:~$ cd /tmp/blah
> al@kvm1:/tmp/blah$ ln -s a a
> al@kvm1:/tmp/blah$ ln -s c b
> al@kvm1:/tmp/blah$ ls -l
> total 0
> lrwxrwxrwx 1 al al 1 Sep 23 13:44 a -> a
> lrwxrwxrwx 1 al al 1 Sep 23 13:44 b -> c
> al@kvm1:/tmp/blah$ ls -ld
> drwxr-xr-x 2 al al 4096 Sep 23 13:44 .

...

> Note that
>         * none of the filesystem objects involved have UID 0
>         * of two calls of symlinkat(), only the second one triggers the r=
ule
> ... and removing the -F obj_uid=3D0 from the rule catches both (as expect=
ed),
> with the first one getting *two* items instead of 3 - there's PARENT (ide=
ntical
> to the second call), there's CREATE (for "a" instead of "b", obviously) a=
nd
> there's no UNKNOWN with the symlink body.
>
> Does the behaviour above make sense for a normal person, by your definiti=
on?

I never said that there aren't plenty of bugs in the current
implementation.  Really.  Audit is a train wreck for so many reasons,
most of my time spent with audit is spent making sure it doesn't
panic, or some other subsystem hasn't wrecked it even further.

If you're looking for someone to justify audit's behavior here, you'll
need to keep looking.  Personally I've got plans to burn the whole
thing down if I ever get enough time to work on it, but in the
meantime I want to try and make it as usable as possible.  Patches are
always welcome.


--=20
paul-moore.com

