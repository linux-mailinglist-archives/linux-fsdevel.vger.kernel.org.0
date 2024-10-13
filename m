Return-Path: <linux-fsdevel+bounces-31823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26F99B9DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749F328197C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63C1465AC;
	Sun, 13 Oct 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAlN7YXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC340137776;
	Sun, 13 Oct 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831306; cv=none; b=nC/uswGAFip7hGpZG4EYLLB1W3ndmDeHLATboP3JsbbVznNuPB7eEqWPw7Js6XtmXffKb4ydH5qdy6cz5+F2T31g5HG3k6VVWj2zK/A6ZZxbXY5m59fCMh/GfVMXcmzPjq39NyLOkznhD+tfiRvWqdL+wLwY0a2wmXBnFY5Bbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831306; c=relaxed/simple;
	bh=pM5SOiEzEirP9H+cJEbySFTrQC9mFsCkVRRUYnokut8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsmEYAh2gQHpr2ybflDshwSwBrc60Em2GHyVzFrAreXkSNKXdnRGvcnXZ+YkHEdKmx3fw9fqAJa4dDmfTTlti3Mhlza811SqC7D8CnC9K8ywfxFhzyr9gkwkrd0KUBa/ZSXmN2ZLFX54wGE7GCvFfWIC/o35a7oVYfx9UPyWZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAlN7YXf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1205e0e03so132542885a.3;
        Sun, 13 Oct 2024 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728831303; x=1729436103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shnRrAl3hVafFi2Hz0129yi4BiECymCDS35zo01iTq0=;
        b=gAlN7YXfYYElX+1SKnmfnRKmYqe6riHg7CVvx7ofeCStoys14X2Jb4USueSk+60Drv
         yUtdLwRsL0lQyhOITnkaUNLiT1VIYvroUUByoW/QUUOzyePhasERw/AwR0xcmcSlrCqq
         MTD3rD/2X2KQ9yYyJ22bnBbVCUIlLPaAT0K4/ai8Ac7Doiy7AAZHa18FwhlO23FJ36cr
         gL76YdyEm8cWUovBKI+SCtOmSgjCU+YCiAzVnK/dOBTHoJibuxOU0Q4dwalEZKlgh8Wg
         WQMkM49JeftjitU7pzfY0dXJPI6nBD2ce6B2zm7/DIwzoLgH2PakB2nc0DTabZbccp9h
         a3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728831303; x=1729436103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shnRrAl3hVafFi2Hz0129yi4BiECymCDS35zo01iTq0=;
        b=wLuRc/iW1VwUg4AhT+rkroMs/CdffWWvlM6Y8ZXZU+JCnQQOe1byaV1g8mgwgXiZ94
         sTInSd1LmeERlooX30YNbaN648bdBUIpy+LsXyIU/6Eud3JI4gDOHMXtvaWEsk40252m
         3rsxR+QPI3aUpuBdk2dnM6ak2OSUc6juM1dQpdr5yJsu1ePvtLxcD3u0gNxgJODKLE50
         Rrag4RDNmQkafaL+QL3T84n3eclMQnFRWeKoJPfvP36Nkyp7gkXKYhQ0D1SqoFJWNnSt
         MOOWjOhOAxnJPXsL5tVlFvYRTHJGfSBkD7ZbBh1nDLU3cmLJf2qYg15I23mwRHBYH/bQ
         /ABQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKQYAy6gzYiQRu5fWH3IPZqIk3IH7Kc60rQxVGRMpn6EuW31chTTbYM4baIq6E4uTUL84rqwAS6yVgRvDV@vger.kernel.org, AJvYcCVb3icSDs+Y6pKq1h31iCstCbkrZkYOAxE71WTadO8BGfjS+Nt63g5f1JiXDUzkRD1eJIwayYh9zb+6l/QiRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cPO/QqlF3HBacy+sia/kp9oTn9PusmTs1C7MBtPmjLeC+SzP
	bRjijKajTxxxhg2JhJnMnAraJPkUeA8JiEI0p2PpX0iLHPCjLkhtOkdWGpbIBJ+STnpPE6RbBg/
	YDpV1x193nk7JxMLGQVtUQ6aqkj3gEQ3sExW4yQ==
X-Google-Smtp-Source: AGHT+IF3sPqc21wX8DhjgXaQ2svsSRyNxjcuopyBM5mtJ1aUatI1C4OO8nhn2bFvWGd+YalN5h4RHekxYmYexCThB+I=
X-Received: by 2002:a05:620a:4144:b0:7a9:a356:a5f4 with SMTP id
 af79cd13be357-7b11a3ad36fmr1333624285a.42.1728831303422; Sun, 13 Oct 2024
 07:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
 <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org> <CAOQ4uxhhReggva_knvfTfCW4VzgiBo7w3wLMEsp7eLy36cPcfQ@mail.gmail.com>
 <20241012-geklagt-busfahren-49fc6d75088b@brauner>
In-Reply-To: <20241012-geklagt-busfahren-49fc6d75088b@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 13 Oct 2024 16:54:52 +0200
Message-ID: <CAOQ4uxg0cuwWmEE_NaGth2FoE4-MbmRtN6TnyeVFAfbtP-z=Sw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] ovl: specify layers via file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:37=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sat, Oct 12, 2024 at 10:25:38AM +0200, Amir Goldstein wrote:
> > On Fri, Oct 11, 2024 at 11:46=E2=80=AFPM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> >
> > nit: if you can avoid using the exact same title for the cover letter a=
nd
> > a patch that would be nice (gmail client collapses them together).
>
> Fine, but fwiw, the solution to this problem is to use a proper email
> client. ;)
>

touch=C3=A9 :)

> >
> > > Currently overlayfs only allows specifying layers through path names.
> > > This is inconvenient for users such as systemd that want to assemble =
an
> > > overlayfs mount purely based on file descriptors.
> > >
> > > This enables user to specify both:
> > >
> > >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper=
);
> > >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work)=
;
> > >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower=
1);
> > >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower=
2);
> > >
> > > in addition to:
> > >
> > >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper", =
 0);
> > >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",  =
 0);
> > >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1",=
 0);
> > >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2",=
 0);
> > >
> >
> > Please add a minimal example with FSCONFIG_SET_FD to overlayfs.rst.
> > I am not looking for a user manual, just one example to complement the
> > FSCONFIG_SET_STRING examples.
> >
> > I don't mind adding config types on a per need basis, but out of curios=
ity
> > do you think the need will arise to support FSCONFIG_SET_PATH{,_EMPTY}
> > in the future? It is going to be any more challenging than just adding
> > support for
> > just FSCONFIG_SET_FD?
>
> This could also be made to work rather easily but I wouldn't know why we
> would want to add it. The current overlayfs FSCONFIG_SET_STRING variant
> is mostly equivalent. Imho, it's a lot saner to let userspace do the
> required open via regular openat{2}() and then use FSCONFIG_SET_FD, then
> force *at() based semantics down into the filesystem via fsconfig().

Fine be me. I am less familiar with the relevant use cases.

> U_PATH{_EMPTY} is unused and we could probably also get rid of it.
>

Oh. I didn't know that.

Thanks,
Amir.

