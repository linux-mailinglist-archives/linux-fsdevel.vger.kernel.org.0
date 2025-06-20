Return-Path: <linux-fsdevel+bounces-52300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1308AE13A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 08:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDBE19E2E60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B2220F31;
	Fri, 20 Jun 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ecETjg4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304F30E844;
	Fri, 20 Jun 2025 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750399994; cv=none; b=XpSHPShLHS0ftuoR/X4kXHSY/ZKL6nITWOgUIh52orHJTvqvHTDyPKVDpEHOUjbx4rTg5B887n/GF6VczeCMTlGMdpFDLoD2hzFbnJ9GwPIh+FmgtM52Dz6Epp0apBE8QKcO6YeCOb0VsZTmMhKaqZIQSynT4RPQib+M8XM56j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750399994; c=relaxed/simple;
	bh=9jfUOsm6NSHlB/N6fCbO5hdv+arXnKMmrWO7xCDgZIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlHA4yFUj4nER71q981ZMnxfiuj4SFimb8l+uLoehOHyVCc+gJhPNmE0Rixg8NLqsVNLFle/sBD18ekYAPv5UeLgb0VePpAh2OwFkmYZM/BSsAatYLL1bWaFhqgwJCe+2D69jufLO6WGgaunZg2gLNt/k8oaT01aCSfkQM1O6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ecETjg4Y; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750399941;
	bh=/IrNu0yVN4ulrPssvOrfHRnzPOjCVbxU5gqSCW6krCE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=ecETjg4YxKbohC9LCNBiCq8AvJnCYBp3qi7KVl4RsRpEcWaJ+cVTSo7hY+oCXIVVz
	 Ux4uDTW1n8Umc1sw4xJmB1ojDa0sOtpmFHXC0vjAZ9HK7SPAqzcPIOwm/U6xVvmA2g
	 LdtRYxMmEXYvgFRNt0piCWqcDygipuUytv8tEkZ8=
X-QQ-mid: zesmtpsz6t1750399938tb751c3d6
X-QQ-Originating-IP: Wi6dihYGRE01+3cxIy1xczPSIhICDwsYajf+b0NZk6c=
Received: from mail-yw1-f175.google.com ( [209.85.128.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 14:12:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6448230986560328817
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e23e9aeefso12599177b3.2;
        Thu, 19 Jun 2025 23:12:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5zRQizZRIA6uOxXWd2swX9u/Hqfmm6FW3p7Vucb5SYd2d0GSRxLhB+WW3jffCy4ecFS/3gsRWqQHQD/2L@vger.kernel.org, AJvYcCXKSk7zQUllZORFpK0OF2bSCowFQ0w/WQqCp9ZDqP2iBHU/51A1Jw4K/9vrEmflN90RFbMwRf2LtLQmwYEb@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjq5diKIbrGZAftBD5EFN+iJHR4L9neG6d+yKaOn5n9AcZOvy
	PzSme5qBCi7bFgHSBjJHyf4aP727inrts7p0yRbysYhfUrzg589nM4lh3mXUaxQGQ5LRGDLHQyd
	VcQ4PSFit3+0fz2KQsbscQ/GZzJUz0ZI=
X-Google-Smtp-Source: AGHT+IEZV5QSeG5JU8frS+nChhNTQSql393V9rqP1xZs+fkffUbr6UKQ+4u5H8PkEmgJ7mJ5mCpBtezKKvC6Uh3lqis=
X-Received: by 2002:a05:690c:4a06:b0:70c:a854:8384 with SMTP id
 00721157ae682-712c63f3440mr26693687b3.11.1750399935885; Thu, 19 Jun 2025
 23:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
 <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
 <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com>
 <20250513-etage-dankbar-0d4e76980043@brauner> <CAJfpegsmvhsSGVGih=44tE6Ro7x3RzvOHuaREu+Abd2eZMR6Rw@mail.gmail.com>
In-Reply-To: <CAJfpegsmvhsSGVGih=44tE6Ro7x3RzvOHuaREu+Abd2eZMR6Rw@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 20 Jun 2025 14:12:04 +0800
X-Gmail-Original-Message-ID: <8A67B98B3C2B585F+CAC1kPDPZ5nw8qmvb5+b30BodNh+id=mHb8cTfJyomtL0nsVK=w@mail.gmail.com>
X-Gm-Features: AX0GCFtE6nUgXguFexTH0s7DYixSZABx4GzWZS4AjHewREzuXwd6HYM42m3KcJ8
Message-ID: <CAC1kPDPZ5nw8qmvb5+b30BodNh+id=mHb8cTfJyomtL0nsVK=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MoZqUia8aYdxiE/XGwTlcptrjfZxr617JaU72RlPeMEVufqBsIVW9yOr
	x5zKxprfd8dx11trS/mD6AfAyMAk8t11yFmpEI3TfYZhvy+jmSERWoAN7h9YMfmGbRM593R
	xZBoF9Mf63eWHBvAo6K7bKcwYqKDkv6Zm5m2i1wXDoFkmXKndiE5RLvD75j1HC0seD4HpwM
	jxG17vuxRLMvXqh606IpdOsaXkwIZQNOC1l3MCpfiEHqqR/mkp5A+3QSd/FhNvD5/cY2U+r
	8aMG7xxuUzY0gLXswtQ00BHEtZPWvCp5u5SOuWCr2z5LCYUFisDztL1N0tvtPgB0HYhM67g
	X9uQTCYb7lqZeA0d3vxHs/brPT+1kd7B0HiYapnzGPAtaKfqLEq5fHs0FcY9VGRZa5HfG04
	szD5fflvpVfUF2vg1rLemTGijC2/3jzAjFuVJjOASDONr0E5spkbAONTiykL1mEGVAexVvI
	xIInRDqo1ACZdlnLXa1fOCt8ZrnKYczbToV0v2gfa8SzcT8khx5Dpf6DlDKW8TbpKsel3Ta
	3y4apvo1N1g3QQqa+/Xa5KfMoRw4OF4Tq5m1C/6D9hF80Ze2nL5KA1cXC6+zxyNKlN4ewP8
	Owov16uxH9ANrkhKe7Yu6M6CLwAQU7wKDnCdawoLRndnzFGaVOClAmL6D0zB/N9FI1ya0hi
	Vb5t/hR55Mc9LDnROy6wYxZl7xDTcwixRz4kZGpBuTXq1K5CLn5c5oe4hmOf+UeV9dHmkcn
	+D3VP99uGaj/FET6Twgm5saT/Zw10joMmP7prTlW/3ql0Dit02R4UrnuHz9wvP0NvIrALrF
	dns7/lFTN/VrsTiBTUlaKv6hpu/Tzn1lhqtMIQOrvn8Y+PxGbYDuiwZdZRuLRMCeZeJuei3
	caBs/VmbsH3guX/CRdEPIgpeaNjDusxgD+DTkfouNpg9ArNlaqp5Ap5Umfku7AOiviyJd0A
	wDDiylLaT+TdSp+ch758Dn5B4Z1O/sToIsZslIvzYLDnsUVDPKG7e7gPME+LXSkOU931lGs
	eakNSiPJ2j11CeoIltekyl61ReVxYvK9CM+zqJsLyw3Im8FI//d2BVn5HqacPoHvDMQ3Gkn
	A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, May 13, 2025 at 3:58=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 13 May 2025 at 09:39, Christian Brauner <brauner@kernel.org> wrot=
e:
>
> > No, the xattr interface is ugly as hell and I don't want it used as a
> > generic information transportation information interface. And I don't
> > want a single thing that sets a precedent in that direction.
>
> You are getting emotional and the last messages from you contain zero
> technical details.
>
> I know about the buffer sizing one, can you describe your other gripes?
>
> > > But if the data is inherently variable sized, adding specialized
> > > interface is not going to magically solve that.
> > >
> > > Instead we can concentrate on solving the buffer sizing problem
> > > generally, so that all may benefit.
> >
> > The xattr system call as far as I'm concerned is not going to be pimped
> > to support stuff like that.
>
> Heh?  IIRC there were positive reactions to e.g. "O_XATTR", it just
> didn't get implemented.  Can try to dig this up from the archives.
>
> > Then by all means we can come up with a scheme in procfs that displays
> > this hierarchically if we have to.
>
> Yeah, perhaps it's doable.

In my opinion, adding relevant directories and nodes under procfs does not =
seem
to be much different from what I did in this patch by adding nodes
under /sys/fs/fuse.
This kind of solution would still be a somewhat =E2=80=9Cnon-generic=E2=80=
=9D approach.
For io_uring, scm_rights, and fuse backing files,
these newly added files or directories will eventually have their own
specific names.

I=E2=80=99m starting to wonder: is it really meaningful to pursue =E2=80=9C=
genericity=E2=80=9D
in this context?
Especially considering that io_uring already has its own =E2=80=9Cnon-gener=
ic=E2=80=9D handling.
For introducing a new way to expose kernel-held file resources,
would the maintainers of these two features even be willing to
coordinate and make changes?

Thanks,
Chen Linxuan

>
> Thanks,
> Miklos
>
>

