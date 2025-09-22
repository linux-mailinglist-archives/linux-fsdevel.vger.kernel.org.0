Return-Path: <linux-fsdevel+bounces-62353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E4B8ED0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB53189CAEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 02:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844E1940A1;
	Mon, 22 Sep 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S/Y1+Kxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9922AD3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509149; cv=none; b=WekeWEKTp3RQjUNq0lOkub5YLcuardYXdgRa1u84KTfh8NfPqmkjvHCRbSh8BUTXPkwyuUB5diT9mRkW1p/hIomPTNv671gEroPZN1nyyPTGo9v91SqhDXQ5QoHX9oxtyE461/4P3QaeOkJcVf33pjyZGe15xt1+olAOu3l9MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509149; c=relaxed/simple;
	bh=OHE48olg519spvFlWFIeEJNbuS0jmy3zVtKbGyHkqJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFkMDrZ5NtyaycHSDMca/Ajz+Z8xWo2cgdLBsFJy8x06xWUu24/zvSpc5v8cDk4gKi3gIMC6koOlxXJzlaHERGEpUxVijfS5zs4mBugmJaUVVXYVRXLxyJnIFBXn2xS6bRH2R7WPd3IByRnBAxPU9doORJVA49tHuk4tFcwZZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S/Y1+Kxq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso1002597a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758509142; x=1759113942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5yco6RQ2dd+Ews268XrBumZVhE08ntx5AK0Kf4JXDI=;
        b=S/Y1+KxqbkPnKVzilsAmklHGJCqUoFZLXO9Vn9TUpcv/J9HhcFHFN42ekhScfnwT64
         LI0p5LqAnEHgFd9fmrElOj7h1ldiCpKmlG+Ihnc979tX4P/D1Ehu6gLHY7FwGtQw0vpO
         DHl1QpupJMk/2apSKn5oKaMAc0OkZEhsNgRT+UO/kj5WDaTLcUJar1jGGittqyAohxsi
         0xgmxfKqh/g/w36Ps5N6HZ7qByf6K3ZtkrSsiYWOKFU2l51c1rVz98jP5wult//DyRQO
         Cl9L05MGwI5QpopdpYaRWn6ttJQe+vrUSAgWCO2yEloCwRXLJlO6i6IZsuODwKu4D5Wt
         6TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758509142; x=1759113942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5yco6RQ2dd+Ews268XrBumZVhE08ntx5AK0Kf4JXDI=;
        b=bxboNtQtOaWT92pEkaN262Q3WTkHp7YE0dSj27gVIVlWg3B8z6lvhNL9grgREJdBki
         bnilJnEojkbVvR6H1x6yKBhSG5aDVuv0pO4JdBk8GFOmukIwPMYKqOCRBemzujn2Yi5v
         pSoMARu9XvxilAsGPMuFWF4JpLwgbB7DwH//jg3IpbLyRRydRKzrDL/73owR7mroa0/B
         gryMm5nSIxPStcvLNNAOIaQmxluJAi+seCFhxy95flGHwROyMTXX3iV9Q4R7k0ig7YEX
         zskGB7UggpZ1z81vhi6U4RrDkQTR+Lej0Q4UuG+t+HBAo3YD+hcked+Dw+dxlNl42UtW
         Ozfg==
X-Gm-Message-State: AOJu0YyMGs/Lvx+e5Z+vNU4bAJr5rXU7K+wBLTe8EyOiR+kF1tOwQ81x
	C6bw0txVHS7e5jfJdLonQFYL1AH6ztHsRLS56D4HNVwQaSSVwBJLxuHS4kEQVDM97CgF1q7FViD
	XK1FpEWj9VZCdDdvgM+2wynO9ceN9maXrn61RZy0W
X-Gm-Gg: ASbGncv7BnR4OfZHFtCea94odB5990OhFw0Pawiol1t4VearYTL9XEgoA/ylPzX/TJf
	tEa4yJ4KbynKsKWaAq686xaa76vXEOcJTTXjHpfv/vgTumW6SmSy/gZ90NXl5U9YzIEmae/3TIl
	l3yYdXtSWUVJtC785s37kWFPkGs+Vbc6w0H98vdvK3syBApX9c3rzitWGMTVxVbVGyR1ma1Opl8
	wJFTfs=
X-Google-Smtp-Source: AGHT+IEQyRXg1l8K42z9GbLLsdJuiyluA15xPpywWswDmAxZCo78QiyFuNoZntuVqZOjN2SIw824qpjzx0zvEHbgdFY=
X-Received: by 2002:a17:90a:e18c:b0:32e:ddbc:9bd6 with SMTP id
 98e67ed59e1d1-3309836e606mr12959586a91.27.1758509141924; Sun, 21 Sep 2025
 19:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV> <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk> <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV>
In-Reply-To: <20250921214110.GN39973@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 21 Sep 2025 22:45:30 -0400
X-Gm-Features: AS18NWCvL9IvxmO_xFeAz1bpOPNMU2283UQ2z-7po2tvqlqTgOAFSSkKcG2Pr5s
Message-ID: <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, casey@schaufler-ca.com, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 5:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
> > > +       dput(dentry);
> > > +       return dentry;  // borrowed
> > >  }
> >
> > Prefer C style comments on their own line:
> >
> >   dput(dentry);
> >   /* borrowed dentry */
> >   return dentry;
>
> Umm...  IMO that's more of an annotation along the lines of "fallthru"...

Maybe, I still prefer the example provided above.  The heart wants
what the heart wants I guess.

> > > @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_block =
*sb, struct fs_context *fc)
> > >                 goto err;
> > >         }
> > >
> > > -       fsi->policycap_dir =3D sel_make_dir(sb->s_root, POLICYCAP_DIR=
_NAME,
> > > +       dentry =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> > >                                           &fsi->last_ino);
> >
> > I'd probably keep fsi->policycap_dir in this patch simply to limit the
> > scope of this patch to just the DCACHE_PERSISTENT related changes, but
> > I'm not going to make a big fuss about that.
>
> Not hard to split that way.  Will do...

Thanks.

> BTW, an unrelated question: does userland care about selinuxfs /null bein=
g
> called that (and being on selinuxfs, for that matter)?  Same for the
> apparmor's securityfs /apparmor/.null...

That's an interesting question.  The kernel really only references it
in one place after creation, and as you've already seen, that's easily
changed.  It's more important that it can be uniquely labeled such
that most any process can open it, otherwise we run into problems when
trying to replace fds when another file that the process can't open.

I'm adding the SELinux list to tap into the folks that play with
userland more than I do, but off the top of my head I can't think of
why userspace would need to do anything directly with
/sys/fs/selinux/null.  There are some comments in the userland code
about not being able to mount selinuxfs with MS_NODEV due to the null
device, but that's the only obvious thing I see while quickly
searching through the code tonight.

> If nobody cares, I would rather add an internal-only filesystem with
> root being a character device (1,3) and whatever markings selinux et.al.
> need for it.  With open_devnull(creds) provided for selinux,
> apparmor and whoever else wants to play with neutering descriptors
> on exec...

With the ongoing efforts to push towards better support for multiple
simultaneous LSMs, we would likely need to make sure there each LSM
that currently has their own null device would continue to have their
own, otherwise we potentially run into permission conflicts between
LSMs where one could end up blocking another and then we're back to
not having a file to use as a replacement.  Not sure if that is what
you had in mind with your proposal, but just wanted to make sure that
was factored into the idea.

--=20
paul-moore.com

