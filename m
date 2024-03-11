Return-Path: <linux-fsdevel+bounces-14161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39AB87887A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 20:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330301F23056
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6CE40847;
	Mon, 11 Mar 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fdHFbK8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AF3F8F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183884; cv=none; b=KHfu1wBGxbZhjk+ykPkJSirO/OiTF75HMQykUXnKr/RrtDonpe66YFH2LOPAIGhg8sOmK4NGwkmUVN3dH0/uBcaug5FwyLfIvSEZmwF3OIyn9fZMH/P75iOvYY58tP4QCsU0HryFY/puj1AfqvOtBBwTQ/RklPCP/4SFHUoSi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183884; c=relaxed/simple;
	bh=a34c1W8UxJqLqwodwsx3ke0IIehjsmsB0sZpvh8qj64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCd0UZB7H8vitkAbgAAB9uEL7M7nRXluDWVoRw4NEz8KcoeCrudhiFNlB87awFdhOw7wrxiRKKHIP7biRrHJofy+XMByRjOOA7e9ziTcvoRb9kw9iCtujqvHQp77q1ci7pvtFPPSIlgTlmisPzW+zI8qvIbMQkx+4J0G3e2UWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fdHFbK8x; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so3357717276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710183882; x=1710788682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip6FW2J49TWgHtgl/4Gc7SJljeLMdRFy5mwJ9+2h64Y=;
        b=fdHFbK8xQ9AvsWL/UtBi7QjibUgrVRSUdEcyV1WWy9iOJOWMKt2uEGDMiGRGMkHVpR
         Yx/0iOGJ5JkPV+YdUJmOIhIng5277NKRUZ66SWfbyqFIvbP7d88rAQdhZMkiG70oBwI7
         Dx7Gw+9FIglqn2FeShQAQaP6xL0JtJYaH7z8hhbLgkAVy2tuWMrL/ZzoKJL9icSbRJSR
         l98k/je7B4BByvcFA9jmbhnDYgjXVoeBm7GmPSdOypwAYfLhWGOMiBSNY8XTP44hEvdS
         PbBOqfp7/R7YT9DdLBzGK17Nx74IS6EjMgcN0iu92xiBoaXUD9MMZFW/WLnxWycv4hOL
         mjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183882; x=1710788682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ip6FW2J49TWgHtgl/4Gc7SJljeLMdRFy5mwJ9+2h64Y=;
        b=FKPaH42SOGDJPYH0OUW+vf7nsKnPBjHPILlv2YIOJm2KgSjjSO7EUWhV5EYrqmYSdd
         c9KvWm7jPadSewdm2fH+lo2tYzKjMTqdZL3Za/QVYTbsXLnj06iYkLT4PwsrZbZTtJ6K
         f0Lr16rz4x27KfXxMzYDgO6hNTyJDCb701oOPblBEnzFO/pQw6DCzLux4dn1SmzCGY0U
         4CxFWR8TJKSLECyqfRCtETZZAE6OQU2EJCHLAgLYlnwjVbwQpv8fb94VOBezXI7/2AZC
         nP9oyoRzA8Ee3Uafav3ZGzVKsmP+N0teIGxWZdOvbZ+gUhPd9SoQ+uW+tt++AFXfTTWs
         AfZw==
X-Forwarded-Encrypted: i=1; AJvYcCU3A/dN4XoOhonZ/KGWd4pNb0XpoBogzHAjd+2VnmUC2upTh8k4T7H9eVkGwY2KlIe21OtQxZUukTUXyFMGHYz1WIL4UG+gKWGOzx5JBA==
X-Gm-Message-State: AOJu0Yy31ckeyGfrVRhzDe00Q35O/f7TCxH99Bg7Kxf1+MRNgKZhqK1Z
	XbCu9/qTcYYhFB1YfKr1N1eqigO/BATsSm8A61/OFXjhiu0C5+8EkvpcfDLbP/z/hfBrdSvtTFq
	l0FlltNLVlnBrvPF5CLRdfMONpMO6kP2gChx1
X-Google-Smtp-Source: AGHT+IFdbQG06mL4djqGnWfaVrxqq+mwF8rQ3ANrX5c4HMRCbMuXtKqYaZ70urXFF7iZEe1k85pBlEuWNtpXZ2J2Eg4=
X-Received: by 2002:a5b:391:0:b0:dc2:398b:fa08 with SMTP id
 k17-20020a5b0391000000b00dc2398bfa08mr4965860ybp.31.1710183882181; Mon, 11
 Mar 2024 12:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com> <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area> <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net> <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
 <20240308.eeZ1uungeeSa@digikod.net> <CAHC9VhRnUbu2jRwUhLGboAgus_oFEPyddu=mv-OMLg93HHk17w@mail.gmail.com>
 <ZewaYKO073V7P6Qy@google.com>
In-Reply-To: <ZewaYKO073V7P6Qy@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Mar 2024 15:04:31 -0400
Message-ID: <CAHC9VhR45QyWj5+P67Y6M4BJ98ymLirGr724OEjb+8faLCkUzw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 3:14=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
> On Fri, Mar 08, 2024 at 05:25:21PM -0500, Paul Moore wrote:
> > On Fri, Mar 8, 2024 at 3:12=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Fri, Mar 08, 2024 at 02:22:58PM -0500, Paul Moore wrote:
> > > > On Fri, Mar 8, 2024 at 4:29=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mi=
c@digikod.net> wrote:
> > > > > Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlo=
ck
> > > > > sandbox".
> > > >
> > > > Which is a problem from a LSM perspective as we want to avoid hooks
> > > > which are tightly bound to a single LSM or security model.  It's ok=
ay
> > > > if a new hook only has a single LSM implementation, but the hook's
> > > > definition should be such that it is reasonably generalized to supp=
ort
> > > > multiple LSM/models.
> > >
> > > As any new hook, there is a first user.  Obviously this new hook woul=
d
> > > not be restricted to Landlock, it is a generic approach.  I'm pretty
> > > sure a few hooks are only used by one LSM though. ;)
> >
> > Sure, as I said above, it's okay for there to only be a single LSM
> > implementation, but the basic idea behind the hook needs to have some
> > hope of being generic.  Your "let's redefine a safe ioctl as 'IOCTL
> > always allowed in a Landlock sandbox'" doesn't fill me with confidence
> > about the hook being generic; who knows, maybe it will be, but in the
> > absence of a patch, I'm left with descriptions like those.
>
> FWIW, the existing IOCTL hook is used in the following places:
>
> * TOMOYO: seemingly configurable per IOCTL command?  (I did not dig deepe=
r)
> * SELinux: has a hardcoded switch of IOCTL commands, some with special ch=
ecks.
>   These are also a subset of the do_vfs_ioctl() commands,
>   plus KDSKBENT, KDSKBSENT (from ioctl_console(2)).

One should be careful using the term "hardcoded" here as I believe it
is misleading in the SELinux case.  SELinux has 11 explicitly defined
ioctls, with an additional two configurable on a per-policy basis
depending on the state of the SELinux IOCTL_SKIP_CLOEXEC policy
capability.  The security policy associated with these explicit ioctl
checks is not hardcoded into the kernel, it is defined as part of the
greater SELinux security policy.  One could make an argument that
FIONBIO and FIOASYNC look a bit hardcoded, but there is some subtlety
there that is probably not worth exploring further in this context but
I'm happy to discuss in a different thread if that is helpful.

All the ioctls that are not explicitly defined in the SELinux code,
are still subject to SELinux policy through both the file/ioctl
permission and the extended permission (xperm) functionality.  The
SELinux xperm functionality, when tied to an ioctl operation, allows
policy developers to allow or deny specific ioctl operations on a
per-domain basis.

> * Smack: Decomposes the IOCTL command number to look at the _IOC_WRITE an=
d
>   _IOC_READ bits. (This is a known problematic approach, because (1) thes=
e bits
>   describe whether the argument is getting read or written, not whether t=
he
>   operation is a mutating one, and (2) some IOCTL commands do not adhere =
to the
>   convention and don't use these macros)
>
> AppArmor does not use the LSM IOCTL hook.

--=20
paul-moore.com

