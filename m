Return-Path: <linux-fsdevel+bounces-70017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C56C8E612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD27F4E638F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098C25A2C6;
	Thu, 27 Nov 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsbKnSTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0422F74D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249134; cv=none; b=hMj5cNxvjPFgKT+6OKhyMNq+2zmNAM3TVF5LiFuTiW1ETfF5VFSRIEiFndI6IAiBbPnXal0FY2zlr1vzG7CRd8US1nyBUp/QB73Bwf1s9l8wIWEgeBvlVFZ6hsm6lZ/kQg2xRaFGr+Jvec2+6WFUur3Fz8eo1BSpt96K8cnzOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249134; c=relaxed/simple;
	bh=lNqxHXcUth33TG9lYBjfpjY9dusk00l25lAi5+q1QCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4BOM7tK4z8gGpZBWxJoSUZfeHaTLJPaLYQ3csTLQShIlPnsx7Vs3tAooMcbplN2U3iKFLbVdA9UPwDj7uO6moub1hwblU3blYITgxgeR6kTla5ocAzsvz8SQYanvW/Tsd5OwV/oDBwsGqZgbaWxD0oTzY7TSdH4FYm6OmLNASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsbKnSTO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so1353932a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764249131; x=1764853931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj/XAPLEM8u0Ig+KySlVUv6bTCtgB0YfUe8Zvz1U7ZI=;
        b=HsbKnSTOcmJf/pq5AWdOGTNzaHi54navAhf3DuO+YI+MaQOYmOSlzCxMx15M96K1q9
         J4sBHy3n6NXvPg1nsDZNNdL68bFp1oM+YoIjkol0rFXoDcQ0e90/w4tXEnqKz7PfysIi
         5/evKU6kA8LAVkGAy8NK57QHpy6Bg2YQMW/0/tL1m57HvZ6ZBFe5OeCDfRskCvdlGQwY
         QjTc3WY27AacdHOtDmxFGi30qsVEdUHCwW7j0z8N3xiDehPzoJoDJ6zRmt8QQZg0lVT7
         Ubgh62QaqRTDnOZ/3Ih1BmTz8u18jTmXxCz6SuvqbK+hCfPn32SIj0N88NV0xAgvyCJ0
         XzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249131; x=1764853931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cj/XAPLEM8u0Ig+KySlVUv6bTCtgB0YfUe8Zvz1U7ZI=;
        b=HYB/FYq3Wt7AdWWw2l+5wPGJ1cRWNfOJour2FUDoOMWt1n6w8me/k8OMcYAu/1OKUo
         99yWNMWdcboC0uBNK7Q8Qu7x2tN5wPFHe1JPuVyIne1ozQge9yxApUZCTN5ck4+ebS3P
         UipB34OUPDPyiCNI4Fr0hp2XaJRATX3/lMdXfkDuVnPA3mt0RlSmwLwjmkNShuz/nkX8
         RlvWbpPGHNBQmtXn1cnqgJ8Or80H0yG1gFulvnboCCiGfLM+SEfi87zDatO/uwEgJyGH
         EOZ458z/ehco6HKocCbtQEinr9oKmwzlqYh6ibvAPms5MJl+kCpT0f5tpjNxhEqJh2tw
         tLBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1eJEUuTpDP9KzIuMW8fIxpB+sy9RixTCuhIuuKJQIrxhghpdBLEJpi5bSDKLYbPu+ALcrcURnPTJrL8s5@vger.kernel.org
X-Gm-Message-State: AOJu0YwStg3/btzi125g+AXToyeDhvs8BBFglaZYoaJlah01c4d0F+Mt
	rY8lregIu5FU98BWJ1LxZrOWAIbsDbfSkcAsp0/Je3p1vikcNnzv3I0XT5rsX9nsdOLp5YZUZuz
	KVtLrhhAcWB2bcSiM9APB8tvCJ4MDgWk=
X-Gm-Gg: ASbGncsI5aPx9kPQZR9o3GIA5NJArBqJhnmay62t9deB85SxsGrubTbxDiF9O6gdsPJ
	1i18kW7ST9bajwlvaOr62tli8VxuYSDpSLBLphg3a6SwfVuyR+ThTk91L09ni+xKlAGv5XKhIM2
	CeUHBBCEc8+xP25Yrf3ZnSK49dYgnPjLIp2ucw0J1RlZthUeEtdREbphDeCzCBlrwV5PVHyUcKA
	XydN9Yh2y9bz2mqaqeHIokttSedg2LwwzCFNR9xefrCNyBl8KM6jvUYcAoSudHZe3/cyCaSLu44
	1cfGw6InzTMujHzsYADm+GR1TmQ=
X-Google-Smtp-Source: AGHT+IFYkbL0VYgSHDbvuEJfOhI/obu/02EjCS++JDjYWQCsfJgIMmmYuvX6a7dMMoi99gtAL4UqUr2e+3JXMhH24wY=
X-Received: by 2002:a05:6402:1e8a:b0:63c:690d:6a46 with SMTP id
 4fb4d7f45d1cf-6455445989cmr21428153a12.13.1764249130405; Thu, 27 Nov 2025
 05:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
 <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com> <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com>
In-Reply-To: <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Nov 2025 14:11:59 +0100
X-Gm-Features: AWmQ_blLbATxRa2HO4lHQ-O5ErLu4Mrq_RiP_h6_1kjJIrIjn_5rGUKFPDuEvt8
Message-ID: <CAOQ4uxiGMLe=FD72BBCLnk6kmOTrqSQ5wM4mVHSshKc+TN14TQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:40=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Thu, Nov 27, 2025 at 8:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.=
org> wrote:
> > >
> > > This adds the Kconfig and Makefile for ntfsplus.
> > >
> > > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > > ---
> > >  fs/Kconfig           |  1 +
> > >  fs/Makefile          |  1 +
> > >  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
> > >  4 files changed, 65 insertions(+)
> > >  create mode 100644 fs/ntfsplus/Kconfig
> > >  create mode 100644 fs/ntfsplus/Makefile
> > >
> > > diff --git a/fs/Kconfig b/fs/Kconfig
> > > index 0bfdaecaa877..70d596b99c8b 100644
> > > --- a/fs/Kconfig
> > > +++ b/fs/Kconfig
> > > @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> > >  source "fs/fat/Kconfig"
> > >  source "fs/exfat/Kconfig"
> > >  source "fs/ntfs3/Kconfig"
> > > +source "fs/ntfsplus/Kconfig"
> > >
> > >  endmenu
> > >  endif # BLOCK
> > > diff --git a/fs/Makefile b/fs/Makefile
> > > index e3523ab2e587..2e2473451508 100644
> > > --- a/fs/Makefile
> > > +++ b/fs/Makefile
> > > @@ -91,6 +91,7 @@ obj-y                         +=3D unicode/
> > >  obj-$(CONFIG_SMBFS)            +=3D smb/
> > >  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
> > >  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> > > +obj-$(CONFIG_NTFSPLUS_FS)      +=3D ntfsplus/
> >
> > I suggested in another reply to keep the original ntfs name
> >
> > More important is to keep your driver linked before the unmaintained
> > ntfs3, so that it hopefully gets picked up before ntfs3 for auto mount =
type
> > if both drivers are built-in.
> Okay, I will check it:)
> >
> > I am not sure if keeping the order here would guarantee the link/regist=
ration
> > order. If not, it may make sense to mutually exclude them as built-in d=
rivers.
> Okay, I am leaning towards the latter.

Well it's not this OR that.
please add you driver as the original was before ntfs3

obj-$(CONFIG_NTFS_FS)      +=3D ntfs/
obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/

> If you have no objection, I will add the patch to mutually exclude the tw=
o ntfs implementation.

You should definitely allow them both if at least one is built as a module
I think it would be valuable for testing.

Just that
CONFIG_NTFS_FS=3Dy
CONFIG_NTFS3_FS=3Dy

I don't see the usefulness in allowing that.
(other people may disagree)

I think that the way to implement it is using an auxiliary choice config va=
r
in fs/Kconfig (i.e. CONFIG_DEFAULT_NTFS) and select/depends statements
to only allow the default ntfs driver to be configured as 'y',
but couldn't find a good example to point you at.

Thanks,
Amir.

