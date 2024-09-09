Return-Path: <linux-fsdevel+bounces-28955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E210971EC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98011C21E9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0F139CFE;
	Mon,  9 Sep 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XcmhxBYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298771BC39
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898162; cv=none; b=snaQHTmP0JDIEU0ZEEh7ch+9uyeZ95ZuqtwjcCQtrb4MiaYJFNX7GcEasVTDCBo8LRWQPmX0f3ok2jn8X1Xe+8QEHklvZW4xAjQ76NCTCgQgGqnhehmStMb2vbu8kHDzZH3swoV1kRnkB2npDMeL2yQFfO2ncu/Wk1CF/reMXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898162; c=relaxed/simple;
	bh=KO216CVLRph9nCQrhGA5ZJFpbAsAr3U67xWLzLBcg8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIMf6hrehdiy1+kAbd45EfwIkLkHT3RlUHnrZzCPd9wo/shj4eUmhmqGabcDDDbMcnWx1oHds1CEvvnnpdKPUuNCuIykOCkTlHMTKSIwztbYGQLoagysQ2bpAC+OOyqJHn+wjbaW+VsmGj+2QkzQorWltVVZuVRc0a+RncnvbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XcmhxBYT; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D6413F46B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725898157;
	bh=cNmpVkq4Fpi+AIwt2yz0c7jLv0EtSIXXBwFhX1ECq/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=XcmhxBYT4dmvigBSk3I8LFpmzmrISPV8k8cmv5esR5E2dwL4mRf4mt65szcy4uS1w
	 GDmIDG5vik+YwXIMaK9m8Y6gnHxd4WQzdLbMn7gCuQDUtbtqeu0M9+O50WP1WxGQmn
	 lUI6eY1E1wak1e9W8K2BkCH9gPw+J7lK9M0vEcAif7p7pjapn8w9lIAi6pkXuqPWL3
	 3y5FZBikKqoeoLPIlx++FtAFH6LRi/vxQsjUxTjxxEFHpdJRDxxPVIu7XslFR5iL/l
	 NCLm+fxPQ4VJQBEbFghzteZrF/XWEZ8dS8VKTN/HpVZ02xYI5vYtrKXi5Qg4BTnTbS
	 vz9ATPTYmYxqQ==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5e1ccb3f3f4so1751474eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 09:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898156; x=1726502956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNmpVkq4Fpi+AIwt2yz0c7jLv0EtSIXXBwFhX1ECq/E=;
        b=oUrmOuG416opnY1ZObVPhkUjbW7LVduElrcWAzw+auEsddktuEnYI2LfESexIHm4lG
         v+3nEKvII/ulOPYWeCHv2knJmGqX7wiryOrP0RJmldFUqCwCR0Qsz/OzSc1oEcqcjZFe
         Ld2a1t08EQlmKbiuh749pOsfwZP39aq27Y6HAtITDqdLJ4ENIezoP0VQxv73HRONCdoK
         tpQOUum6lYSp023I5195xFn4CP17tgwUAJs+bMGHURlGe8ECjeJos+EtGHEIFXnFeA9V
         2j8UHuu7x4r43XmGoiC15eWvWpTrq7PiB/IxGZBrPq4ZGZuZ7eHTOHyawFGmP6N9Bpcb
         8KOA==
X-Forwarded-Encrypted: i=1; AJvYcCWNZPOywVTaboq/rr7QHui5iu9bICMZh/hrXTz2hegNtU/X4G6EVatVeOiBLajMwenPRW6P2/+N6mUBlgEC@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBGFDTv2BnL34g/YDsI7L9RN7lXyBw5ehtdPY5vW46zFM4H02
	ixIcMFa4mXRt75Y9TAbOP9F6mrK7/i+2g/sIPNoTUk9NbjMeZeJHnk362rTDVOddHvICW+5VSYc
	ENyqxsy7UIMaVjXX/9joCk4xm0KmAjr/TNXm81u3HIgNQ81DAjGObCpIAdH9wHRKm7LbNe93AUR
	Hzw3xe0KLzTaKsuHCoI1aQsPbn5fnZH9SRXBqDipi1MjcPPCNMjPRLzg==
X-Received: by 2002:a05:6359:4c09:b0:1af:1b40:5357 with SMTP id e5c5f4694b2df-1b8386efd32mr536499155d.24.1725898155961;
        Mon, 09 Sep 2024 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGssdkcz6Do9xmtEwjdhYkf1iEQ/Z1pq4QSQQR4MEbhxzTfTXO+AVt/VjieiPcw5MrNhgqbn4QBYfvcEHdTGZY=
X-Received: by 2002:a05:6359:4c09:b0:1af:1b40:5357 with SMTP id
 e5c5f4694b2df-1b8386efd32mr536496655d.24.1725898155678; Mon, 09 Sep 2024
 09:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
 <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com> <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>
In-Reply-To: <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 9 Sep 2024 18:09:04 +0200
Message-ID: <CAEivzxdT+Dy7McjfebYLTk8cXNdBJAe9Wze4NSys20Fyd7LOEQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Seth Forshee <sforshee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:57=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Sep 06, 2024 at 04:34:52PM GMT, Alexander Mikhalitsyn wrote:
> > Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b=
3c1c49a2645@brauner/
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
> >  include/linux/mnt_idmapping.h |  1 +
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index 3c60f1eaca61..cbca6500848e 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap =3D {
> >  };
> >  EXPORT_SYMBOL_GPL(nop_mnt_idmap);
> >
> > +/*
> > + * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
> > + * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
> > + */
> > +struct mnt_idmap invalid_mnt_idmap =3D {
> > +     .count  =3D REFCOUNT_INIT(1),
> > +};
> > +EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
> > +
> >  /**
> >   * initial_idmapping - check whether this is the initial mapping
> >   * @ns: idmapping to check
> > @@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
> >
> >       if (idmap =3D=3D &nop_mnt_idmap)
> >               return VFSUIDT_INIT(kuid);
> > +     if (idmap =3D=3D &invalid_mnt_idmap)
> > +             return INVALID_VFSUID;
>
> Could possibly deserve an:
>
> if (unlikely(idmap =3D=3D &invalid_mnt_idmap))
>         return INVALID_VFSUID;
>
> and technically I guess we could also do:
>
> if (likely(idmap =3D=3D &nop_mnt_idmap))
>         return VFSUIDT_INIT(kuid);
>
> but not that relevant for this patch.

Yeah, I'm happy to submit that change (if you don't mind) a bit later
when this will be merged,
cause in this case we can add this likely()/unlikely() at once for
both nop_mnt_idmap/invalid_mnt_idmap.

Kind regards,
Alex

