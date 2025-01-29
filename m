Return-Path: <linux-fsdevel+bounces-40345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9AA225DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5442188733E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5121E3793;
	Wed, 29 Jan 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj8yJsPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170122619;
	Wed, 29 Jan 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186271; cv=none; b=JPWoAs72cjLYWvwvSiigHocClhc+PTj4FLxqLSWB06Xxa9ln4vV/r19dktVn0/dDu62Q2AcM4kFE7dcOBPy3VycI/iQP4+mNJ5MkOaM9OJdAkP3+CsH/t6LGv/1XUI3dJRWC61LprK7+s8L0x7bUmInBimc82lDY0TdxqfMvjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186271; c=relaxed/simple;
	bh=XOPhAyMINDBxOdOWfa8NSmmOFwzOegM22M4vc+Ci4pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDlK2DMY3dfOlzSRfId8es9Du/oLYZxPmtH51GPC7RIL5AdCaaF8bjmfSGU/KXvmqPhIw6w4ECcSrEfnMy7E2OWFbqNYKSmtHfDYE9XJ9gKm+13Y7Aq5SrnNFhwtpfQdrBDW85NUp5++dtsmQwq5QHpJzziDQrUEFC5l9yHb2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj8yJsPq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439a6179a7so60187e87.1;
        Wed, 29 Jan 2025 13:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738186268; x=1738791068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmQghTxrSNZIJicf8St9hkhO8RNvDDXNdb0xqgUBNEQ=;
        b=kj8yJsPqaLn3iStmp4b8g2FndvG8wpLgJGBq43Zc1ZMKCT4RpRkJZKHV4sPuNTOx87
         +a8C59mp313F7Zd354KnxC9a972QC/c5Ua32E7d0qQayFRKsCSPWcGY9+UEN+8Q1aLKm
         qqi7hvqW95ZvZtHJ/OjOBrsuVMpEIYvn2YaR6ZeJIWROk6C5iqpgU2uqxSANCLUhkiUU
         vF+n3zGv7IxQd24AJ9pOEPQNMQFPMWoHR8/WsgSmyOxtbReqiQt9Ylto4rexEPXnFPV/
         i+feGmvEl6UYHKlAXLOdH1Sf6zBImb6+EGxiwEm46NlI0Q9HQ21ubTa6Mnt5i7UCi2jb
         FXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186268; x=1738791068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmQghTxrSNZIJicf8St9hkhO8RNvDDXNdb0xqgUBNEQ=;
        b=O5vplB57vU+KezRDomccp0ICd0v6THXM8XzR7/IBfnjmIZZmTcFzWVlObNwRKQt0Py
         jLAuAxOyJKG6lMDVhdbcCVhgGywR7+4gp9xy1QTV87e+zIQYjJJOaQCezb5ZS9tCSnL3
         4fHjXMLlt/zD9tcsH6Xd+rA2swODDf75/B9fFnRNq2QvBYqCu7aWY7D7rJekGnulDKmI
         7kRBpx/LtUHnLyzIF8btO+KwmaqKywk7N23cfQmVaAPLjQ+2WQCfSPsq4RIQwaf7AFaE
         xVjGngiPduBb5aDBAu41lLKODEGQFiCTr9ebmZ4+BuevahjU3FsL4qHz5dvJVM834Cbj
         KixA==
X-Forwarded-Encrypted: i=1; AJvYcCVoVRSdWgtbaC+yH5OCUhhkJaFJ1j5PXk6BcBO7xTV3qwqcpEVkCsExkaAD9AxDHDaNRkrYT4sY5Ny2pllcKw==@vger.kernel.org, AJvYcCXKhXdY5I/t9rAB+DrCk4Co/iMFsGK6jwcA29wPy5jg79GKRGNw306j6nrae1/XokfhlQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjPD7OUPG3oVrsj41uZ0mhjpcARpihFhGvaKNlFNqmm4xfsrQ
	pDDFZWi/reqZDx2lDtHPV7/KY9mxMh8J+D8Nz93nDGMMxrCSOHAIPAl0WuVDC9YrnlI9Y+4jv3Q
	QNE3x8Ptu2mocVPpERQScMo+aMnJnQ9Hh
X-Gm-Gg: ASbGnctuuXvRuSTsYV2l2jJcBb49njVkN1FJgmHT2e3tIR53lS7eXWT0hpanB03E8oJ
	9LYaAo3dsSpfci8YPXqFxIS+dL/dIE9E8dJFM3StfEH+A5LG9GQHJJLtyfFR1OkxPyRyiPG2p
X-Google-Smtp-Source: AGHT+IEBGwB23rborskxzA4KFILlvubMz9LTFxq7qUdNdXQohhHPpB7ObVSyC3+3goPahJXRZTfTGeYV2c+uaP+vEus=
X-Received: by 2002:a05:6512:104b:b0:543:e4de:3e12 with SMTP id
 2adb3069b0e04-543ea3fa8f9mr283827e87.18.1738186267536; Wed, 29 Jan 2025
 13:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzHzzNU_1D0gsVoaA@mail.gmail.com>
 <itmqbpdn3zpsuz3epmwq3lhjmxkzsmjyw4obizuxy63uo6rofz@pckf7rtngzm7> <CAOQ4uxhgiUw3b2i7JYm5qZX1qPvYJshrCWy_i0BkPVtmzKo1AA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhgiUw3b2i7JYm5qZX1qPvYJshrCWy_i0BkPVtmzKo1AA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 29 Jan 2025 15:30:56 -0600
X-Gm-Features: AWEUYZmV6e0eAXyKiyCo4qRehtAjNyn3DW8G2A8fcAPW2dyfbmWc7iZoU1McASU
Message-ID: <CAH2r5muKu3p6jgjMeQHe=Jq_v0dhpNGWQSS=5u+rzYPb152RRA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] fanotify filter
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 8:42=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Jan 16, 2025 at 12:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi!
> >
> > On Tue 14-01-25 11:41:06, Song Liu via Lsf-pc wrote:
> > > At LSF/MM/BPF 2025, I would like to continue the discussion on enabli=
ng
> > > in-kernel fanotify filter, with kernel modules or BPF programs.There =
are a
> > > few rounds of RFC/PATCH for this work:[1][2][3].
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Motivation =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Currently, fanotify sends all events to user space, which is expensiv=
e. If the
> > > in-kernel filter can handle some events, it will be a clear win.
> > >
> > > Tracing and LSM BPF programs are always global. For systems that use
> > > different rules on different files/directories, the complexity and ov=
erhead
> > > of these tracing/LSM programs may grow linearly with the number of
> > > rules. fanotify, on the other hand, only enters the actual handlers f=
or
> > > matching fanotify marks. Therefore, fanotify-bpf has the potential to=
 be a
> > > more scalable alternative to tracing/LSM BPF programs.
> > >
> > > Monitoring of a sub-tree in the VFS has been a challenge for both fan=
otify
> > > [4] and BPF LSM [5]. One of the key motivations of this work is to pr=
ovide a
> > > more efficient solution for sub-tree monitoring.
> > >
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Challenge =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The latest proposal for sub-tree monitoring is to have a per filesyst=
em
> > > fanotify mark and use the filter function (in a kernel module or a BP=
F
> > > program) to filter events for the target sub-tree. This approach is n=
ot
> > > scalable for multiple rules within the same file system, and thus has
> > > little benefit over existing tracing/LSM BPF programs. A better appro=
ach
> > > would be use per directory fanotify marks. However, it is not yet cle=
ar
> > > how to manage these marks. A naive approach for this is to employ
> > > some directory walking mechanism to populate the marks to all sub
> > > directories in the sub-tree at the beginning; and then on mkdir, the
> > > child directory needs to inherit marks from the parent directory. I h=
ope
> > > we can discuss the best solution for this in LSF/MM/BPF.
> >
> > Obviously, I'm interested in this :). We'll see how many people are
> > interested in this topic but I'll be happy to discuss this also in some
> > break / over beer in a small circle.
>
> Yeh, count me in :)


I am also interested in this topic, especially how we can better
handle fanotify for network fs
(or perhaps cluster fs as well) that already support notify at the
protocol level.  I had
added fs specific ioctls for allowing apps to be notified about remote
changes (SMB3.1.1 change notify
e.g.) but was interested in how to make it easier to wait on changes
(e.g. to make it possible
for fanotify/inotify to work for network fs)

--=20
Thanks,

Steve

