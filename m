Return-Path: <linux-fsdevel+bounces-13173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD886C430
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D679328335E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7354F8B;
	Thu, 29 Feb 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvfu1ilU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB55381A;
	Thu, 29 Feb 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196731; cv=none; b=pZH4bFsVyMg1Akmj8AvxZ6Z/9HmxHRwcvE4n8WGB35Kcxkkf7sWUEb16XlieyyQ0QIa0gMKe+yZgbsGHWbyTPXgdEZSkdSyTmMlSwDRGx1JdAI3v9cpmAUoLDlKU/OfhY9+qGhwdAPehf4XtAQFeFMFlyHCLhqLi0HPBW/ltdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196731; c=relaxed/simple;
	bh=20v3pbDLj+0vuW/PFqJzrozAySUE9HJJ6FDYFXVg5aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftdTOVQfSEyPDXCzUr1AEA5BnNzwPc2K2dyBgF2xhdeGIG4fbD4LupBKo9wlSTahdJP+kkkuOfsofPD8FZHyR0nWdgqoEAFMJBBS7KC1PEV9QT46bjoJP8EpOflcXO2pbjiQwrekMwxmDFWKpNahRQGlbLJfySAGm85qvaEVV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvfu1ilU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131c48055cso642510e87.1;
        Thu, 29 Feb 2024 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709196728; x=1709801528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUHqj8/wEOYa04u1FeURXJn8BqPJVGE7RkK+VT965fM=;
        b=kvfu1ilUhCvmbGcAWxNW77391gtsmu+cNcwnf/Lv2pdS9CoWIm04qcdMHBtUb3jw3Q
         b340Ow0z3RjML8o76nLq+OhRvy54NwLsv2kxp2zDdnlX7/be4/6agM6gUnkfzdGXplX5
         BPq62A6Ta96Z7g8d9NgIywyCv6LMUzIfsRgmwKnA/JtN2JWdjh5hkEi2hqaVdmQo8M43
         XbF+fAf4NVEjzexDmdQf3qJ3nJjR++c10GgNyjiYLIDDvf7mlcsVq6buZ8McuRVwqtTZ
         UHbiEoiaRF+BpOkNUHCBpLqqRQqU5MULdSWEzkxC7UFm4Kb31ED2nTvEOR4tDXMIlLys
         ERhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196728; x=1709801528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUHqj8/wEOYa04u1FeURXJn8BqPJVGE7RkK+VT965fM=;
        b=AjwwzXVUqWJDEG9ONTkRR2Eyjody3FpQWiS3l2GvfGsnDyKBpJTF+6YkP/cqA/zy6H
         qFFE2OEaIhI9oAgrLJSnGk3Gq/qLI/jiwwYUxQ3k1gUtSVQs4bHrcs39AJpikEGF/wXz
         v99qHJcY2/wVZUzWe6Jncsgmf9HrnCUr4CM5OxPoXNsMlsa7WNQRjuFn+IAyZlfs8L7R
         c2ZlnDyRXmeTOv4v0VcrYrMrZDVLdHfDq1zMfMd4by7C+sn+ulOsWK8qDfjsCswy+ldw
         99K1asrCfq4e3OA6RLW4DqbP+daEEAeiwoYI8DZvYuzBlbQRdu2RhYK30D+GO26/oyib
         FVQw==
X-Forwarded-Encrypted: i=1; AJvYcCUIcZnhbRfRU7K884I4/+ppVcOg3fMivL3rrs5ySUVVc8J5O1KdnPK941tv32xwWUMSdhn3ygt7du4tarvxJkQDXx0abirfH+mkhFSj5vS+E/7SThEWWzeoupmQZmkPvGMJlb0xOZcgaAuoRA==
X-Gm-Message-State: AOJu0YyBf68OfrWKITW2Mh/8+A/U1AQYeAWFY8kgUcouuu4icwRar7SN
	cj64Sv/g6HvljggrVg3gPiigFbefWoGJsd6jHCMgk1oaU4f4ObubQn/WGz7REiqRflEls8jvHfD
	b+KrkNsmvtPpjFPWj0ZOSdyOPBUY=
X-Google-Smtp-Source: AGHT+IHnjNRnp5vtsOCvwO52z+c/AvZOWyAhFn11cBFTobgoLqur0og3HVuYiqranbirbaZ848tgGGKvhODUZk2mQnc=
X-Received: by 2002:a19:c20d:0:b0:513:298b:73ce with SMTP id
 l13-20020a19c20d000000b00513298b73cemr397460lfc.29.1709196727385; Thu, 29 Feb
 2024 00:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
 <ZdVQb9KoVqKJlsbD@casper.infradead.org> <170848171227.1530.1796367124497204056@noble.neil.brown.name>
In-Reply-To: <170848171227.1530.1796367124497204056@noble.neil.brown.name>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Thu, 29 Feb 2024 14:21:55 +0530
Message-ID: <CANT5p=rqE5n6nyCs8pUWPaaj3=nasGKDOy9nV7_RDG04G0AzyA@mail.gmail.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
To: NeilBrown <neilb@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	=?UTF-8?Q?Christian_Brauner_=3Cchristian=40brauner=2Eio=3E_=2CSt=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:45=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 21 Feb 2024, Matthew Wilcox wrote:
> > On Tue, Feb 20, 2024 at 07:25:58PM -0500, Kent Overstreet wrote:
> > > But there's real advantages to getting rid of the string <-> integer
> > > identifier mapping and plumbing strings all the way through:
> > >
> > >  - creating a new sub-user can be done with nothing more than the new
> > >    username version of setuid(); IOW, we can start a new named subuse=
r
> > >    for e.g. firefox without mucking with _any_ system state or tables
> > >
> > >  - sharing filesystems between machines is always a pita because
> > >    usernames might be the same but uids never are - let's kill that o=
ff,
> > >    please
> >
> > I feel like we need a bit of a survey of filesystems to see what is
> > already supported and what are desirable properties.  Block filesystems
> > are one thing, but network filesystems have been dealing with crap like
> > this for decades.  I don't have a good handle on who supports what at
> > this point.
>
> NFSv4 uses textual user and group names.  With have an "idmap" service
> which maps between name and number on each end.
> This is needed when krb5 is used as kerberos identities are names, not
> numbers.
>
> But in my (admittedly limited) experience, when krb5 isn't used (and
> probably also when it is), uids do match across the network.
> While the original NFSv4 didn't support it, and addendum allows
> usernames made entirely of digits to be treated as numerical uids, and
> that is what (almost) everyone uses.
>

This may not always be a fair assumption. In today's world, Linux
systems need to co-exist with other systems.
I would take an example of the Linux SMB, which in many ways is
similar to NFS in this context. The difference here is that the
servers (or clients) that we need to interact with deals with variable
length identifiers. Traditionally, it has been Windows SIDs. In more
recent terms, Azure identity service (Microsoft Entra) has moved on to
even more generic identifiers.

I actually agree with Kent on this point (on the ability to map UIDs
to variable length identifiers). We are making an assumption here that
there is a global numerical identifier that all identity providers
provide, and that it fits in 32 or 64 bit space, which may not always
be true. Linux SMB ecosystem (kernel SMB client/server, samba etc) is
having to map these identifiers in a lot of hacky ways. And I don't
think this problem is limited just to SMB filesystems.

Having native support in the kernel to at least map UID/GID to a
variable length identifier (using user namespaces) would really help.
Of course, it can be done in a backward-compatible way, where existing
systems can survive without any changes to their design.

> It is certainly useful to mount "my" files from some other machine and
> have them appear to have "my" uid locally which might be different from
> the remote uid.  I think when two different machines both have two or
> more particular users, it is extremely likely that a central uid data
> base will be in use (ldap?) and so all uids will match.  No mapping
> needed.
>
> (happy to be prove wrong...)
>
> NeilBrown
>
>
> >
> > As far as usernames being the same ... well, maybe.  I've been willy,
> > mrw103, wilma (twice!), mawilc01 and probably a bunch of others I don't
> > remember.  I don't think we'll ever get away from having a mapping
> > between different naming authorities.
> >
> >
>
>


--=20
Regards,
Shyam

