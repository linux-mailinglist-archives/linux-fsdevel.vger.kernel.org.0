Return-Path: <linux-fsdevel+bounces-40532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7369A24868
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6411887BE8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0F15574E;
	Sat,  1 Feb 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl5p14rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C905154BFF;
	Sat,  1 Feb 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738407336; cv=none; b=LANBOqkbh9SVVC4FA0247yxE+hmGYEg/J6am00lO4XD0by6pSHIkr9nummdfdfYA2/BCVnVTktsjmmrAMrBG+neDNXquuoe2n/xN2bmcugHZSJpxgiPsgnRDj7iNYcm9w5292T3Qfh5A08SozUUxC4CWYEcztBGf+vI/Cs8Qf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738407336; c=relaxed/simple;
	bh=DcVsBXMMkCLxd1sCPkpDPTWXiB9k4THUSMnTMLSxbvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erCpEveheGjnDDDww7Z/8XvzJfvvXCmjHz4ohSB5fvh65o5gxLFHD7+eWe0IAr/noVaTkK0YkoD4rJJ7bj+z6kelluWXJdjbI4rw1t/AWzEAotfW+BoHE3nvitI5qfMiFJgx8emR3dE6FchTUIwDPTecLBWwDUmvl7OIrGnC5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl5p14rh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so5773322a12.2;
        Sat, 01 Feb 2025 02:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738407333; x=1739012133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcVsBXMMkCLxd1sCPkpDPTWXiB9k4THUSMnTMLSxbvM=;
        b=nl5p14rhSWNMmHVQRQ/tWrng1klUOtrYDlCWHvnwVB8tbD4AaX4Wd/+8gwPW5ySDe5
         URVMr+arDCGyFm2o20iXaYGQnQzRz430knH4KqEq+jzUH/9VdMk5iY+wzz6C9Nfn9Y58
         IfLMetslBJHVY91/RL4tYDHGbMnYEx+AaZm/kWYw1FeBZ2TYS9pf8iYoijxspKFaAMIw
         SzXIF4vcG9otZOYTS0QHi1qK7fH7XqER4AbVsApZMA2SJcSEyuk5Au6o1Zg1G2yYNOdA
         l7VwwzwvoCjCMsdxUUvaGv11KwR3LHSL5/K+sKsNGV3zukwoYn0b7wrvAV+8WLcJbFQn
         XSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738407333; x=1739012133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcVsBXMMkCLxd1sCPkpDPTWXiB9k4THUSMnTMLSxbvM=;
        b=El1hX4oJcKYYBAT5edGWKJTM1u22dmZAyTUncibVN+ShwR37TmYB0KyGz+PiMP3Wsb
         8ASDFqyBxCeNZ+tgUwdVDhemGq6/EMAztQ25K9uZyI6xQ5cJelICaMxeW6h4OF6Eyf2X
         LLTFxG2yH/ice7h8xv8BJiz2ZLw8IWNdBiI7BxD0pQYL+6Tn/oRXpm04kCMC1UvQmGoC
         kmbF4fkKHY1YWO3fStG0NjX6wyl4SowUW9SF+lHUYDLsdEfO69YXN6b9EpY7uW7tcq8a
         B5QSJrRyalDeTwpVJs7SXRl8lXoOKykernJLYS6+5AiQS0sbgX3+LUQsaef326ayo600
         URDA==
X-Forwarded-Encrypted: i=1; AJvYcCWhZ9ZqoVGeHQdGWviQe4mQlGqS7QLSD1Mkc56gNsQpS7qcs6B7KppTXssuo+fGRQaBi/awnxaqmNdxQxh/IA==@vger.kernel.org, AJvYcCXUMDLNybVyvgsOLWebfPmDtFFO+JV4tId2P8j+A4oCWIy39m4IKsCvj6x063Nm+NvpszJcCNsi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TMz4YlUyQ9RjiaZlqP/NE+dCt+93y3H4CN0Q7j7DUmlPih1n
	XkoSQ0tqdjdIbTDbLcEWI8TcbYnsYadJNQWcHOdfwDylxtOVy2i99tlhcdcJnJE3sXI2OU109mN
	rHlsvbFzzOccrpu9/EmBVGWfIuXXemOPLAyc=
X-Gm-Gg: ASbGncuQT3W86oNTvWaNaev7ccxpJoe4OIaWsmKGyqUMHvWxvX1QocqtpWjJjZxJydM
	SR1NDY+oLDOT5nFqKgNoXnv6BujwQ71/r7QRgjzoyn81dsBuLMfmCg2S/FclbFlVsPPCHu9pn
X-Google-Smtp-Source: AGHT+IGPMMYzWlXIpuBTIvXI4BoB4DqKuV7FHMN+zeTg2Yl4SYkun220FnVnFqIopzt8DbxEpYaIjWb+4WmGRB06MLE=
X-Received: by 2002:a05:6402:5106:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5dc5effb167mr14090363a12.31.1738407332386; Sat, 01 Feb 2025
 02:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org> <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu> <4044F3FF-D0CE-4823-B104-0544A986DF7B@ddn.com>
 <CAOQ4uxgpDy-WFJgpha38SQxSYZDVSaACexJ5ZMr2hN7XkzsBqQ@mail.gmail.com> <1A60CCB2-5412-4223-849C-F6824F82B1B2@amazon.com>
In-Reply-To: <1A60CCB2-5412-4223-849C-F6824F82B1B2@amazon.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Feb 2025 11:55:21 +0100
X-Gm-Features: AWEUYZnddcI9ZXUP-_OND4xrMEgOvXFasxQFqaCCsp13gOFyK-vdpFw4VYO5geA
Message-ID: <CAOQ4uxjR2fD1gUY6NnJa75+ACm_nANNPajmH5aaVSN7FoD8ukQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
To: "Day, Timothy" <timday@amazon.com>
Cc: Andreas Dilger <adilger@ddn.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Christoph Hellwig <hch@infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"jsimmons@infradead.org" <jsimmons@infradead.org>, "neilb@suse.de" <neilb@suse.de>, 
	fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 12:01=E2=80=AFAM Day, Timothy <timday@amazon.com> wr=
ote:
>
> On 1/31/25, 5:11 PM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
> > On Fri, Jan 31, 2025 at 3:35 AM Andreas Dilger via Lsf-pc
> > <lsf-pc@lists.linux-foundation.org <mailto:lsf-pc@lists.linux-foundatio=
n.org>> wrote:
> > >
> > >
> > > As Tim mentioned, it is possible to mount a Lustre client (or two) pl=
us one or
> > > more MDT/OST on a single ~3GB VM with loopback files in /tmp and run =
testing.
> > > There is a simple script we use to format and mount 4 MDTs and 4 OSTs=
 on
> > > temporary loop files and mount a client from the Lustre build tree.
> > >
> > > There haven't been any VFS patches needed for years for Lustre to be =
run,
> > > though there are a number patches needed against a copied ext4 tree t=
o
> > > export some of the functions and add some filesystem features. Until =
the
> > > ext4 patches are merged, it would also be possible to run light testi=
ng with
> > > Tim's RAM-based OSD without any loopback devices at all (though with =
a
> > > hard limitation on the size of the filesystem).
> >
> >
> > Recommendation: if it is easy to setup loopback lustre server, then the=
 best
> > practice would be to add lustre fstests support, same as nfs/afs/cifs c=
an be
> > tested with fstests.
> >
> >
> > Adding fstests support will not guarantee that vfs developers will run =
fstest
> > with your filesystem, but if you make is super easy for vfs developers =
to
> > test your filesystem with a the de-facto standard for fs testing, then =
at least
> > they have an option to verify that their vfs changes are not breaking y=
our
> > filesystem, which is what upstreaming is supposed to provide.
>
> I was hoping to do exactly that. I've been able run to fstests on Lustre
> (in an adhoc manner), but I wanted to put together a patch series to
> add proper support. Would fstests accept Lustre support before Lustre
> gets accepted upstream? Or should it be maintained as a separate
> branch?
>

Up to the maintainer (CC) but in any case, you will need to maintain
a development branch until the fstests patches are reviewed, so I do
not see much difference for the process.

My own vote would be to merge lustre support to fstest *before*
merging lustre to linux-next tree (to fs-next branch), so that lustre
could potentially be tested by 3rd party when it hits linux-next.

IMO, if lustre is on track for upstreaming with all the open questions
addressed, I see no reason not to merge fstests support earlier.

I was going to recommend that you consider adding lustre support to
one or more of the available "fstest runners" to provide a turnkey solution
for the standalone test setup, but I see that you already contributed to kt=
est,
So that's great! and one more reason to merge fstests support sooner.

Thanks,
Amir.

