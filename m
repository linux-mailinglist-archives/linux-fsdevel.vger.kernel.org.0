Return-Path: <linux-fsdevel+bounces-62676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C9B9C733
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6EF2E6E12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F728851C;
	Wed, 24 Sep 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT6ohyE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D82557A
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755556; cv=none; b=QVQLDucSVeBvKj5rx1Qm6HZvjLP1YuN1qadV8Yzvx7xrNGSnY+lYGUgjONkKfks0GNeoQsYwgB/lSMxUmd1hoK+p0HmZzHuO4yKr0eY4VMdVOV6cCq+gLxaSBmtzHnuIlx4mOkdcWgMKTrmB9hzayjHgA6H0tRla62//omnPOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755556; c=relaxed/simple;
	bh=V3NpRvW9bDS8Px6ewZhXBsJXI4FZyxfkPen8qdeBDls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4in50Y+JrpwJ9znnyI3hcmqOLxg87qF2pVbZ/cfGd7tIV/Id7dvS4UQqNIswhLQGImsna8IZ3Jo7vVeBmLuwkM4Rtu0HASyyyRqCnIwOhZwHuMCvHasNNLgLTKriPSZb5JdSyE1ASSmuHYonusyc9XZK2Eke6paa/tIAT2U/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT6ohyE6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b38d4de61aso4983811cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758755554; x=1759360354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wgF3EXW2n5jzxxpEDCh3f6sbRv5p5MtrNgzg6BXcr4=;
        b=lT6ohyE60JBfvPm+x6zX4Oex9jlt/EI6qns2Iqpn1JwjHEXXObAAY78PNGnR+NXbMe
         /Hf4IotQ6YE4hJFpspnzk7GCskHp+dxcI8S2fTgvg2UcmQf6G24ZMQaYWu9cH5ArKe00
         ibjC0sp2Cohb9/DTLxjQYbGj4gSFOfIrKvrMESKsZS60Xv/eLFh9eIyVQPtvROkTvBnX
         Q9MPNgpDvoPBD/YjhSCfwP8a+L93J9JHaM55qOlXaCyzdC0j2h579M4UFrFMfPaIgGSt
         UIpMGbczytjJAG4Hal80IZx0QVwEeYnMxM4RKtRC/ngmgwnim2K367GrclTW1kGUNw8H
         08ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755554; x=1759360354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wgF3EXW2n5jzxxpEDCh3f6sbRv5p5MtrNgzg6BXcr4=;
        b=SkijwgHYXjWj2BOvpGrrRyFvdS9z7CprRgp8p7IHQAN47S1H0nvnPbsOIWakuGkvrB
         Zo5JyIMxhvaaxQgS1I1DP1sSMWP4NrjAenkm9aHnUlru95EenPQRdSOQWFTn7+Lys+B3
         dhIBOS23sJLjUCYIQ8phM26eVr0RHLG5M4yfWDWrCmRTwZmVWeP0sbErHKIiYYhbF573
         TPL3cndSLGda394eRkReCBxrm+BIBmrc+Q6ni1r8xnfRzH7+7WKjtKoAuePr1UCEA6Qz
         mfRG5sxKA1cABh6fz+dsNz7w/+JY1YnVlz7kR+rqT8efmv1SoFmz3lqMhBfMTze7cESX
         Bb1w==
X-Forwarded-Encrypted: i=1; AJvYcCXiRx/6RC5uAKxFDdp3SnTPy+ZkOT1cjmYcU5dZ39glnCfNbOT6n05rysafNbCnRx0cg9n3QHxr/owm951b@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLLAsii3snI4Iw57gwvlUDx9Khh66IStqKlTLngGs5+Gc49ir
	vJpMJv9RTGm1ITrar+BS1WIq3H901bjFKCxVdWbZBBTR94EFMCZeSLi4I8SPhxHoZJ9TvngMvlt
	sJ564rSUtwgvwFuH9ZSLSfez5ZyrkOyU=
X-Gm-Gg: ASbGnct0Okx8zemRTd1jh9C3zzTN04HOP1sT31cIqhYetpjU7L8PzmLxAmKONiNMoow
	JCQkcpjyb6rc24pVWWTbXA2h4WMZWpyafpiUBax+6tTZuUgPCniaYnyAvO5ktTbPX7739lG2wcm
	9AR3/OmI2sD2naeLzPJ87Mn/zyf665aAQiboT5JhJbOYuM5Cy2k/MSCMv0m9nWER++eyOBWM64K
	1f6Hzqi8GA7V6V97V9lnNByiGO5B1r/niavZ1c/
X-Google-Smtp-Source: AGHT+IFI3JXzb4wb/FLOXlNqpgywkoeH7/aGkNbo/vnp3lU+rvvw0QDL0p6Eu/GxfgLHprie/Bfe3B2N/aliflsdlAQ=
X-Received: by 2002:ac8:5852:0:b0:4d9:5ce:3742 with SMTP id
 d75a77b69052e-4da4cd4aaabmr19919071cf.67.1758755553864; Wed, 24 Sep 2025
 16:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-6-joannelkoong@gmail.com> <aLktHFhtV_4seMDN@infradead.org>
 <aLoA6nkQKGqG04pW@casper.infradead.org> <CAJnrk1ZxQt0RmYnoi3bcDCLn1=Zgk9uJEcFNMH59ZXV7T6c2Fg@mail.gmail.com>
 <20250923183417.GE1587915@frogsfrogsfrogs>
In-Reply-To: <20250923183417.GE1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 16:12:22 -0700
X-Gm-Features: AS18NWA4HpZiLWRRef-i6KCQzuvd8AAyFsAqQlriSVtFgrbOhCHtzlyVTDl3KTo
Message-ID: <CAJnrk1Y=S5eP4nZ6nXKDWA646+q6gR4sXBSE732-aMa5uJnSaQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to caller
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:34=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Sep 22, 2025 at 09:49:50AM -0700, Joanne Koong wrote:
> > On Thu, Sep 4, 2025 at 2:13=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 11:09:32PM -0700, Christoph Hellwig wrote:
> > > > On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> > > > > Propagate any error encountered in iomap_read_folio() back up to =
its
> > > > > caller (otherwise a default -EIO will be passed up by
> > > > > filemap_read_folio() to callers). This is standard behavior for h=
ow
> > > > > other filesystems handle their ->read_folio() errors as well.
> > > >
> > > > Is it?  As far as I remember we, or willy in particular has been
> > > > trying to kill this error return - it isn't very hepful when the
> > > > actually interesting real errors only happen on async completion
> > > > anyway.
> > >
> > > I killed the error return from ->readahead (formerly readpages).
> > > By definition, nobody is interested in the error of readahead
> > > since nobody asked for the data in those pages.
> > >
> > > I designed an error reporting mechanism a while back that allowed the
> > > errno to propagate from completion context to whoever was waiting
> > > on the folio(s) that were part of a read request.  I can dig that
> > > patchset up again if there's interest.
> >
> > Could you describe a bit how your design works?
>
> I'm not really sure how you'd propagate specific errnos to callers, so
> I'm also curious to hear about this.  The least inefficient (and most
> gross) way I can think of would be to save read(ahead) errnos in the
> mapping or the folio (or maybe the ifs) and have the callers access
> that?

That's what came to my mind too. It'd be great to have a way to do
this though, which maybe could let us skip having to update the bitmap
for every folio range read in, which was discussed a little in [1]

[1] https://lore.kernel.org/linux-fsdevel/20250908185122.3199171-1-joannelk=
oong@gmail.com/T/#mffb6436544e9be84aa0ac85da0e8743884729ee4

>
> I wrote a somewhat similar thing as part of the autonomous self healing
> XFS project:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/comm=
it/?h=3Dhealth-monitoring&id=3D32cade9599ad951720804379381abb68575356b6
>
> Obviously the events bubble up to a daemon, not necessarily the caller
> who's waiting on the folio.
>
> --D
>
> > Thanks,
> > Joanne
> > >
> >

On Tue, Sep 23, 2025 at 11:34=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Sep 22, 2025 at 09:49:50AM -0700, Joanne Koong wrote:
> > On Thu, Sep 4, 2025 at 2:13=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 11:09:32PM -0700, Christoph Hellwig wrote:
> > > > On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> > > > > Propagate any error encountered in iomap_read_folio() back up to =
its
> > > > > caller (otherwise a default -EIO will be passed up by
> > > > > filemap_read_folio() to callers). This is standard behavior for h=
ow
> > > > > other filesystems handle their ->read_folio() errors as well.
> > > >
> > > > Is it?  As far as I remember we, or willy in particular has been
> > > > trying to kill this error return - it isn't very hepful when the
> > > > actually interesting real errors only happen on async completion
> > > > anyway.
> > >
> > > I killed the error return from ->readahead (formerly readpages).
> > > By definition, nobody is interested in the error of readahead
> > > since nobody asked for the data in those pages.
> > >
> > > I designed an error reporting mechanism a while back that allowed the
> > > errno to propagate from completion context to whoever was waiting
> > > on the folio(s) that were part of a read request.  I can dig that
> > > patchset up again if there's interest.
> >
> > Could you describe a bit how your design works?
>
> I'm not really sure how you'd propagate specific errnos to callers, so
> I'm also curious to hear about this.  The least inefficient (and most
> gross) way I can think of would be to save read(ahead) errnos in the
> mapping or the folio (or maybe the ifs) and have the callers access
> that?
>
> I wrote a somewhat similar thing as part of the autonomous self healing
> XFS project:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/comm=
it/?h=3Dhealth-monitoring&id=3D32cade9599ad951720804379381abb68575356b6
>
> Obviously the events bubble up to a daemon, not necessarily the caller
> who's waiting on the folio.
>
> --D
>
> > Thanks,
> > Joanne
> > >
> >

