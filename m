Return-Path: <linux-fsdevel+bounces-50287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7DACA9A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D7E188DB1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1619F49E;
	Mon,  2 Jun 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN6rN5Ij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0828EC;
	Mon,  2 Jun 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748847593; cv=none; b=VDzJjljm7Ji2PAFgy0hmDOQWON1Uob5T2wVw+W4Y9aH3sQ8sqNq0+nJpav9vp4oa4vjtcNcAfFaevDT7ULb9qcGSVIjTttbTJJ7DAjwZ9lG6PUGITzqIhzuAZ4nPlXTW3VzTwW8ccgLcjRxEetFmH9Uli/Zd/45dxxnWDG3K6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748847593; c=relaxed/simple;
	bh=jxLvdSQfjpjraAy1U7bB2SZvmoQH0xC1M0IxT0RSiqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoba0zXooE5n2gRyPd35n0IqfqddVNEVH5Nuf0uqC+7EBMwnUJRac4XTilpl+ezK+o6VXa480+54XGZioVbYXooIq3Vg2g7uO7lHyCkjVSx/bcHqHBFx3pXj9VDSg/r+xViF2/etzIqkznYdUFKfOPpfmlyC95jH4H13OIDGQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN6rN5Ij; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312028c644bso3160700a91.0;
        Sun, 01 Jun 2025 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748847591; x=1749452391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0V/AOR2l4gEGuJ+3dcsr5h2QAW63hL+ESB9rqV8Im8=;
        b=QN6rN5IjT13Ml20Y4xp/djJclaysXztXRNOwfjfnlVnpz74ouIXUGjkZYwRcP3FJYP
         TvXLjdSmnbK2WfDspXGFfCl1APU21h8crjQ4NARqqWlcZilQPqnUhHymkKZeaQ+djmrT
         u2amAb8r1aYNTz70ac4WOT9/JkZQu/1uYL81dhh2jghH9nT7L+dmjSOKPchBj6iOl9do
         nrFedwSlwZraWGhD5fFAs1/pWSHxc/LGfdy8ogbZ6gMNWuaPH3+ATq2RiyFtQ42E45wj
         cK0BnQPOeCjgyxlNj7/qE176nsF/R03gIdH36Y9VQvAngQbtryhZ1lXQZDnnWCO98fhx
         glag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748847591; x=1749452391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0V/AOR2l4gEGuJ+3dcsr5h2QAW63hL+ESB9rqV8Im8=;
        b=OKuUPYrY0kmtCllAUJtWGWj3USdMWqBithvsZoKOHbcS7NJJFdu56T168ykUB6yerx
         55qcrpGMJYRjv65Sj0k/IrZHvlTTLkiG7I+s2yhppEx/dSSdEt2M1P/Q+JMlTScgLkkQ
         BtQk5SPQYSv0FHaclPT2xzLLDwcCP2oLjIaScf7655bGYZzAATeu2Vyf9wg6/Mu7JVw8
         62hoW8x/93twDUWGq6Z48C/Iw5Jgr4HBzFScYjg0V+Uyhq0KCE++DQInQy3NU14YipB+
         354SQA37I8Ed3+H0gWZ7B6bLKvy3GY+TDH/D0yraaXDz1HPWCNQ3skoncdBgxYbNlQ6o
         /fhA==
X-Forwarded-Encrypted: i=1; AJvYcCVYgY3ZZj+iel1x5eX82fQaaiDiyFIoQr4zGGNuTgRr9FNd+fGsVWvZAcmfKnTmimBb/FPKSUVQlZqhzDGbGQ==@vger.kernel.org, AJvYcCXCebsuPNjoJLkGqA87cBy/pHO0n0/CIjIBO0Q2LBnasSJLfFn8DxjJT6a0vVVfD5QjYDB/bnnZn9Id@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0bUfGg48MsYop/7LEZXBzKBYd+1s057XP7YiDyFAx1MItF0S
	z+41dujFRcFIH6SxkHN/eF4bvwWLRE7gUMn6i7tIqF6zO0cESk6bdfQvnfnPMZwELCQAEvIH7ON
	lqP/egGEQIKOVEhdG3f59rgedVql1VCs=
X-Gm-Gg: ASbGncsEhaLSRPeT8Iw7YluhMrKjepVrdRt8X0seaf4ZZNS8TECVn/xqcn4EGiX4O6y
	2FUs2YNnw1zJ/r48w5h4nZxx3xcRvgQOPYddIGVsZaFOO0XbK0GOE4OY2TQvjPdSJQUHCE2cY+h
	9ZauTpBMmTavQ98jXWxmzZqcZhu388X+jD
X-Google-Smtp-Source: AGHT+IERk5GYGEpSNc9KP6Z9MT28yUqK4OvLAax/XRbjbPtwKS6nGhIe2/S80AeyBU1r0LTh3iFkj0gMnAa4rxc+nPo=
X-Received: by 2002:a17:90b:2ecc:b0:311:ff02:3fcc with SMTP id
 98e67ed59e1d1-3127c6c6ad0mr13812170a91.14.1748847591317; Sun, 01 Jun 2025
 23:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328183359.1101617-1-slava@dubeyko.com> <Z-bt2HBqyVPqA5b-@casper.infradead.org>
 <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com> <20250401-wohnraum-willen-de536533dd94@brauner>
 <3eca2c6b9824e5bf9b2535850be0f581f709a3ba.camel@ibm.com> <20250403-quast-anpflanzen-efe6b672fc24@brauner>
In-Reply-To: <20250403-quast-anpflanzen-efe6b672fc24@brauner>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Jun 2025 08:59:39 +0200
X-Gm-Features: AX0GCFtDwrseqgbffGSO6a5YyztZ1jKErc5YwysYro0NIaFMkOUetJuzVYKyDHI
Message-ID: <CAOi1vP957QhFQnvNeJpN+v9zTYEtXaNcHMsZMheeRNNnnYdSKw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix variable dereferenced before check in ceph_umount_begin()
To: Christian Brauner <brauner@kernel.org>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "lkp@intel.com" <lkp@intel.com>, 
	David Howells <dhowells@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"willy@infradead.org" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Apr 01, 2025 at 06:29:06PM +0000, Viacheslav Dubeyko wrote:
> > On Tue, 2025-04-01 at 12:38 +0200, Christian Brauner wrote:
> > > On Fri, Mar 28, 2025 at 07:30:11PM +0000, Viacheslav Dubeyko wrote:
> > > > On Fri, 2025-03-28 at 18:43 +0000, Matthew Wilcox wrote:
> > > > > On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrot=
e:
> > > > > > This patch moves pointer check before the first
> > > > > > dereference of the pointer.
> > > > > >
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > > Closes: https://lore.kernel.org/r/202503280852.YDB3pxUY-lkp@int=
el.com/
> > > > >
> > > > > Ooh, that's not good.  Need to figure out a way to defeat the pro=
ofpoint
> > > > > garbage.
> > > > >
> > > >
> > > > Yeah, this is not good.
> > > >
> > > > > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > > > > index f3951253e393..6cbc33c56e0e 100644
> > > > > > --- a/fs/ceph/super.c
> > > > > > +++ b/fs/ceph/super.c
> > > > > > @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_bloc=
k *sb)
> > > > > >  {
> > > > > >       struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
> > > > > >
> > > > > > -     doutc(fsc->client, "starting forced umount\n");
> > > > > >       if (!fsc)
> > > > > >               return;
> > > > > > +
> > > > > > +     doutc(fsc->client, "starting forced umount\n");
> > > > >
> > > > > I don't think we should be checking fsc against NULL.  I don't se=
e a way
> > > > > that sb->s_fs_info can be set to NULL, do you?
> > > >
> > > > I assume because forced umount could happen anytime, potentially, w=
e could have
> > > > sb->s_fs_info not set. But, frankly speaking, I started to worry ab=
out fsc-
> > >
> > > No, it must be set. The VFS guarantees that the superblock is still
> > > alive when it calls into ceph via ->umount_begin().
> >
> > So, if we have the guarantee of fsc pointer validity, then we need to c=
hange
> > this checking of fsc->client pointer. Or, probably, completely remove t=
his check
> > here?
>
> If the fsc->client pointer can be NULLed before the mount is shut down
> then yes. If it can't then the check can be removed completely.

Hi Slava,

Have you had a chance to follow up on this?  Given the VFS guarantee
confirmed by Christian we don't need to check fsc and I don't think
fsc->client is ever NULLed -- the client is created right after fsc is
allocated in create_fs_client() and destroyed right before fsc is freed
in destroy_fs_client().  It seems like the check can just be removed.

Thanks,

                Ilya

