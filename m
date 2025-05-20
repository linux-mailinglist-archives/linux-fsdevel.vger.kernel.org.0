Return-Path: <linux-fsdevel+bounces-49527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CDABDEC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B266C174F82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB40252293;
	Tue, 20 May 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ8EfIRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6524C06A;
	Tue, 20 May 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754033; cv=none; b=K7EOhYg+JGszFMYKk7reMeKaneQwkbjpt7YqRCcupOBkJe/PONe18N5PAMzU2MGhFMhpiGsHOrapN0JZ7rrIb/TIdo1nEVr3aW5XOkp+zj6hgKt8ORlzZFLTljEPU8sYLggwbecprd5hi50IRwp4GP8M59Gf8hhMSb/3kuy6TmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754033; c=relaxed/simple;
	bh=r+3Yg8OTnXieQ3ZcgC5Xn6TWot3V0vt7EhVQGkfTru8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoAEqERsVSRJJb2dcngyuiU85Ov/T6vYyWmhmrbZiE7Yk3nCW3csAzaREoa68T7Dt8R3m7TfR+eQrrbjZsxsoani3aKWiMDCkWKw8Aetj86aukvYoHd3gjCqlLe9mr4vL47xQMQ3MKExxCgabD35THhJg4QeSckBgNQR4zGgF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ8EfIRL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so915065766b.0;
        Tue, 20 May 2025 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747754030; x=1748358830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+3Yg8OTnXieQ3ZcgC5Xn6TWot3V0vt7EhVQGkfTru8=;
        b=IZ8EfIRLJvipR8c19pzbLTreP5dK55+CBFN4HdjrjaYubD2U+Y2nNsNOuJyL0ve6qz
         srgQpA2PyHb83kA2qr9tTlZkGvpOy2aFdcz04VznTeFd4WgiyrLM/SKghG2gxHp4F40g
         BuOClCaEewITTWrO6iU7GkPPMMDMdrNrXaYbT7xOgLXfZDg5VwV5jARPwioLvVqAeYDD
         ZjIKd50n5UgyPd0/IHRnTe3RjtLVijlkvaIhAD0Z+MJD/mMbwn0p1ruwTFs82eJEbrtR
         oWhGAs3lgwULo1moA3IEzEVYMMqfLvgVmGBbWD0zjFcbIKLnGYfuqmlnV01vFfI3+7Xj
         76mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754030; x=1748358830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+3Yg8OTnXieQ3ZcgC5Xn6TWot3V0vt7EhVQGkfTru8=;
        b=VNlMFl2JG2A8pWKvJ+z49xybVRl0G2iAcPqiJ42i9hnPDpoXH2ZlqopVhy9aCQDUfc
         02rAvCSyRXuME0u6vmDHHH3/PUfGcnQnKXKu1DZmY6YCI80tu3rFoMeGnPdj+TCZ8BNe
         MFQlb4v4lclreVFYFKl4n28e4CkVwgcHpMxSmomqIWsrdiQDkHkYd6xOufU39WU+9gey
         2D4YvszMKv7MhLMUfPzntV+msC6bPpqAIsjMQWWcY5ifObvIz0x4lKbEj1bPbjGYcC/j
         wPKvtkqSJshWJNwszlxbK7J9xqjHh2LNmV+7ecFEVyc8NvEXpRO71BS5fycTn1QckMky
         fFhw==
X-Forwarded-Encrypted: i=1; AJvYcCUR8azdpn8rn66DoOfzHlxQ1B5IEnHJEjGxza27iMwMOsb0Bm4ModHlJxlQE4I8edR/UWYusjljkymEKbjycg==@vger.kernel.org, AJvYcCX5O7qPi9sK916j3zhjK+4MgVsu9PmJ5BL4JEgLaW3lUVwxDtdCAx/53iEn//X4lLYfwYj4YPQYCP175VWGNQ==@vger.kernel.org, AJvYcCXCWnOE5/wY37UzQEI4rHx0KUeN+7T2m8Jp9snPVTJOCbXwCMMbvSTxkz28TErZFhJpAbg5gTWDB83199Tk@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBlpJ1UCG6q/8qswmk49RRTPobae+smXlhFZRTHCvSlUA/SPX
	S1j2/VPzZNtGg1ibq9NKfChNn9XTSKpsWGsz38bD5kYmmjW1+rB5IExpi/1qN9qsJSHUlRCBdmA
	ALz/yRkRWw+DVCQarj5mz4Kb7m7+6qUI=
X-Gm-Gg: ASbGnctx11MTdcgAVuRWViLUXtmVsAdW1QAw3LqYW+tVWrzLEmQXEV7fv8QKYHyRyqm
	+qUPhw68FXp5bYpgDdRXbKaEpqpbabmQFLbR0S+yYHmDGGbF+XTCYa1rV74Rdq4js6aMkjLXtxP
	PVJp4H0uM0uqoqRSko+BWhNFYBjOkwS0Ri
X-Google-Smtp-Source: AGHT+IHhOo1I8dYhhoZqyuwMlTXOucNkuF8QBy8bK9otG1RNbGcQbpYA34dRtZv6u+hi2lp02lJ5UZiCzRcsggPSD4o=
X-Received: by 2002:a17:906:f58d:b0:ad5:4a49:4d56 with SMTP id
 a640c23a62f3a-ad54a495acdmr1424502066b.3.1747754029586; Tue, 20 May 2025
 08:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com> <7sa3ouxmocenlbh3r3asraedbbr6svljroyml3dpcoerhamwmy@gb32bhm4jqvh>
In-Reply-To: <7sa3ouxmocenlbh3r3asraedbbr6svljroyml3dpcoerhamwmy@gb32bhm4jqvh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 May 2025 17:13:37 +0200
X-Gm-Features: AX0GCFuWrzLa3iJcrg3IUMQV1OgW5T9Qo2L2W9N-xtFO3-OeSaQClitTOnNYF8s
Message-ID: <CAOQ4uxjHiorTwddK98mb60VOY8zNqnyWvW=+Uz-Sn6-Sm3PUfQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 4:44=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, May 20, 2025 at 04:33:14PM +0200, Amir Goldstein wrote:
> > On Tue, May 20, 2025 at 4:12=E2=80=AFPM Kent Overstreet
> > > Amir, you've got two widely used filesystem features that conflict an=
d
> > > can't be used on the same filesystem.
> > >
> > > That's _broken_.
> >
> > Correct.
> >
> > I am saying that IMO a smaller impact (and less user friendly) fix is m=
ore
> > appropriate way to deal with this problem.
>
> Less user friendly is an understatement.
>
> Obscure errors that only get reported via overloaded standard error
> codes is a massive problem today, for _developers_ - have you never had
> a day of swearing over trying to track down where in a massive subsystem
> an -EINVAL is coming from?
>
> It's even worse for end users that don't know to check the dmesg log.
>
> And I support my code, so these would turn into bug reports coming
> across my desk - no thanks; I already get enough weird shit from other
> subsystems that I have to look at and at least triage.
>
> > > Users hate partitioning just for separate /boot and /home, having to
> > > partition for different applications is horrible. And since overlay f=
s
> > > is used under the hood by docker, and casefolding is used under the h=
ood
> > > for running Windows applications, this isn't something people can
> > > predict in advance.
> >
> > Right, I am not expecting users to partition by application,
> > but my question was this:
> >
> > When is overlayfs created over a subtree that is only partially case-fo=
lded?
> >
> > Obviously, docker would create overlayfs on parts of the fs
> > and smbd/cygwin could create a case folder subtree on another
> > part of the fs.
> > I just don't see a common use case when these sections overlap.
>
> Today, you cannot user docker and casefolding on _different parts of_
> the same filesystem.
>
> So yees, today users do have to partition by application, or only use
> one feature or the other.
>

Didn't say there was no problem.

Argued that your fix is a big gun and not worth the added complexity.

Let's see what Miklos thinks.

> This isn't about allowing casefolding and overlayfs to fix on the same
> subtree, that would be a bigger project.
>
> > Perhaps I am wrong (please present real world use cases),
> > but my claim is that this case is not common enough and therefore,
> > a suboptimal EIO error from lookup is good enough to prevert crossing
> > over into the case folded zone by mistake, just as EIO on lookup is
> > enough to deal with the unsupported use case of modifying
> > overlayfs underlying layers with overlay is mounted.
> >
> > BTW, it is not enough to claim that there is no case folding for the
> > entire subtree to allow the mount.
> > For overlayfs to allow d_hash()/d_compare() fs must claim that
> > these implementations are the default implementation in all subtree
> > or at least that all layers share the same implementation.
>

Nevermind. Misread patch 6.

Thanks,
Amir.

