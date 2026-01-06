Return-Path: <linux-fsdevel+bounces-72561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA42CFB5BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 00:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E923053BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A62FF14D;
	Tue,  6 Jan 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2N8GO03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30B2E62B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742654; cv=none; b=cKUy8RybEdiVBKRmRgvGbA8Cl0ad1X0tO7sQ6Q9M1copOY588ry213xtfk7ru4b7XFdtoPEE08Ib3uLgEzwLaWbndtGM/XGfT3OxoMc2KdSrTyCriFV/1DJl6SYDt3uAkOFGQKUtjBhubqYGfg+fXzYPcbP6+KAUdnbFlJ8NZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742654; c=relaxed/simple;
	bh=Sa5e1jtjskq0hylSmOvNf9zp1Q4WZyhgLH98rg0h2hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzCr3ddszFPyztduAKkNigrdBJY4ICmhUKn/HO/PGvaruTZwrji8FRIzFbZRG8AQiIv434lpBx+ijvOPcMuh6Hkf4N1f5KEfZr1CekWd2AAywb4oLoCyJwZ66kCm3np6jsRy4OFNWH7ahjccJHhTcsSh3waFkZ/r0LkMu62BhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2N8GO03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13293C2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767742654;
	bh=Sa5e1jtjskq0hylSmOvNf9zp1Q4WZyhgLH98rg0h2hU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I2N8GO03aY0mrFcDgGYuDFPDc3R6VbDkYk8u8ietxUHAkZYc4ro3QvG0vJ6v4kjdZ
	 GSMwwuIP1+57YiOh6E79AtAmVzpbkJqA2nknj15NdvmdP4cg0VIUdXpzSTjYB2VoJR
	 h2M27kk8eKCcwyuLhHBBRVRI/BjgNqH1Wiw8mmNfMutdHhAX8hK8pwlAwGwPO+dIiy
	 XSmGs6vocv8U5IkqaMVlcJqWXryRrg3RJSHddilR7T53iRd9PNCZLT/v+yCcOwWlhE
	 8PdmJlGEQ69imQawxUgoXzc3T0HFHkTSS8n/qOAzxWmnpifwCfv/npXh4wPwgYlaY6
	 NYriVim9d+87w==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73161849e1so264990666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 15:37:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1F5MZ2rS0UZu5WvIGqwQidkCXxD8FHYVfQ0xjAS0GT0N9wrkgV2kyEf2bfEDmVCO4K8HVVy7607rgfz5j@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1S1zBq+LEz+kyTpypx6ak45ZaYluxcZRxAeQ+0F4ubNGyBPMk
	+sb+Pyj56VhLHmLxovaFz40rsd7YxhRfkrf+Pp8v9Z6unlX1EusQo5lyYwZQgLAi88ChIKy+M38
	ISJ+Vu1TzuYu6JlbQdaSggwCfNccsZ4U=
X-Google-Smtp-Source: AGHT+IFqxomT7uegndZ+6NkI2sqJ2zo9eXTuNZyXYIyou9F671yC4uUMQ0j9Y+yhPZrCvTGOZOpQzY4sXmbhl6dmnMM=
X-Received: by 2002:a17:907:1c94:b0:b73:70db:4994 with SMTP id
 a640c23a62f3a-b844535ec0fmr71814866b.34.1767742652619; Tue, 06 Jan 2026
 15:37:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106131110.46687-1-linkinjeon@kernel.org> <20260106131110.46687-15-linkinjeon@kernel.org>
 <CAOQ4uxg+fWKPjknumG9Ey0ACTGXzx2dfeUbBxAiob4JJdHjw=A@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+fWKPjknumG9Ey0ACTGXzx2dfeUbBxAiob4JJdHjw=A@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 7 Jan 2026 08:37:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8A8DThH5ukPM3GV-5M3Nc4eJjiRwMfTCF9HkL9KMucRg@mail.gmail.com>
X-Gm-Features: AQt7F2rFpmdEnieqpyjvQZ_GAITo6hs7J7HuaX3Vkr9ndsRRMAJXTFTMraUavs8
Message-ID: <CAKYAXd8A8DThH5ukPM3GV-5M3Nc4eJjiRwMfTCF9HkL9KMucRg@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] MAINTAINERS: update ntfs filesystem entry
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> courtesy CC to @Anton Altaparmakov
Okay, I will Cc him in next version.
>
> On Tue, Jan 6, 2026 at 2:35=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
> >
> > Add myself and Hyunchul Lee as ntfs maintainer.
> > Since Anton is already listed in CREDITS, only his outdated information
> > is updated here. the web address in the W: field in his entry is no log=
er
>
> typo: longer
Okay, I will fix it.
>
> > accessible. Update his CREDITS with the web and emial
>
> typo: email
Okay, I will fix it.
>
> > address found in
> > the ntfs filesystem entry.
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Thanks!
>
> > ---
> >  CREDITS     |  4 ++--
> >  MAINTAINERS | 11 +++++------
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/CREDITS b/CREDITS
> > index 52f4df2cbdd1..4cf780e71775 100644
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
> >  S: Belgium
> >
> >  N: Anton Altaparmakov
> > -E: aia21@cantab.net
> > -W: http://www-stu.christs.cam.ac.uk/~aia21/
> > +E: anton@tuxera.com
> > +W: http://www.tuxera.com/
> >  D: Author of new NTFS driver, various other kernel hacks.
> >  S: Christ's College
> >  S: Cambridge CB2 3BU
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a8af534cdfd4..adf80c8207f1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18647,12 +18647,11 @@ T:    git https://github.com/davejiang/linux.=
git
> >  F:     drivers/ntb/hw/intel/
> >
> >  NTFS FILESYSTEM
> > -M:     Anton Altaparmakov <anton@tuxera.com>
> > -R:     Namjae Jeon <linkinjeon@kernel.org>
> > -L:     linux-ntfs-dev@lists.sourceforge.net
> > -S:     Supported
> > -W:     http://www.tuxera.com/
> > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.gi=
t
> > +M:     Namjae Jeon <linkinjeon@kernel.org>
> > +M:     Hyunchul Lee <hyc.lee@gmail.com>
> > +L:     linux-fsdevel@vger.kernel.org
> > +S:     Maintained
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/nt=
fs.git
> >  F:     Documentation/filesystems/ntfs.rst
> >  F:     fs/ntfs/
> >
> > --
> > 2.25.1
> >

