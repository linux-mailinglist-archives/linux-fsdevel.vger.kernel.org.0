Return-Path: <linux-fsdevel+bounces-32828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A99AF5D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D96B21E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 23:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B46218D72;
	Thu, 24 Oct 2024 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0AIdEab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFD1B4F3D;
	Thu, 24 Oct 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812720; cv=none; b=KvIARvWaeh0fNqJIpUOEkVxkWJ1MW3+v8jLAvpEEfZ3Ioa3Tq3pW9r5PBEqbeTu6kMSExnRMx/m7HpXLpairQ3eRtgpDP+pBcoaXvoxPfF+8HlrJM45x/rYapJAKwBEFcBWI3g11w16EKCJMRC9mt+nQKlT1MKB8deiaLSVHWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812720; c=relaxed/simple;
	bh=vpaxjq0c+ASyTQ4adOJFY9xir+dhGsmqtDCR+W6zZoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv+ylfZG8FBgrFwbBBbpitCZV+/SnvOVSQC2Jt5l+zIKJN1Zj8KiTbCJXjCYR1m0kwgPLiPtRhg+8yR/b8sZG7NCpennSjUI+5qgFtZ8Xr8LqmOKI/cohsxg0nfQLrRffACqf9MVQ7rDyBJIAYvR0IBjto9W5zrs/q5SjZGassM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0AIdEab; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e508bd28so13474877b3.2;
        Thu, 24 Oct 2024 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729812717; x=1730417517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJavZTiRLvTJo19dDrvDh6vz2XU+2/6WOrRvBD1wjSw=;
        b=l0AIdEabobJhg1o1l+I7modLd9EnV/1iUZwGYFP5fOgY6OGTRz3Ctj6wfTb9ocnd5B
         OKgV4jKOXxVYeswb0Oao0WsSxatAKtoRitUGAfrEdPnEBhQ4POQeSczYUuakutapjJNK
         Ya8RP8CYtLfXETtazg/clZgUcRuerRJaPNUzJpidusmJTwhJg07EVdaDFUUSn4qsYo40
         ndTSMUrzmbM1WYt5Taktk00oOKmruW8YcGJn6ZdhbMIbACqONnceb4wtWHv8rPYhIalZ
         fHWbOPWPR43inLz7LiSpDAadccCkTZQuaSXhQmdf7hNZv8Tqe9hRaxUTsYMkFICWBDKM
         dSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729812717; x=1730417517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJavZTiRLvTJo19dDrvDh6vz2XU+2/6WOrRvBD1wjSw=;
        b=gii8pb0DU3RgAVzPYAiEAUfyB10dyXniVuuBP/HHM9cBZKDKvYLZZ3UklCTaatFHR2
         ysLv/93xHyDjeVkfwoXE4P8WWDgAZHMY+IeZIloMuLIPMeayh2j1bCV16OflCnTXJR1b
         D/dMzaJD3Xx3ypix3KB61sfF+CGrc9vsY9a2DWQdouZ7pbXcJWHefZ2fof0QRzVFinIu
         PxvpDfAR3anUBtJlYX0PeR4+ew9HFVvlHktiP/vmMC3Dt3E72tM1u4n16RDuI7yNxOE8
         KfQivgA1m/wckupUzrp++Wx1HxVa4S4mUAlfXOP8mbX3aHmNonbJOMLJK5/dm6OpQ7HE
         eP4A==
X-Forwarded-Encrypted: i=1; AJvYcCU4zqkj89T29mu2+JDbIjvj34XdumoHt5Wlbi+364673YKy1p/cLkJE7fJYg6cFfG4DHUvJCOkxiHJ8+U3W@vger.kernel.org, AJvYcCXbea9mDadKW3ruu85xYOaMEX5b3+bcGYQ063oLlDW6Z5/l8QBAVeGoz2qXfFTYxBqfidOObH7w870FuIjnqBCFnymwb8ky@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aDH+HUXsfQraGoFhMdANYWyyXd3YC45K6vYLb+1ZzUjevra2
	k1CL+gDsn18PiSyA2tx5Uysu9VVrWQvQJBDYq0/jABg6HC0Mr3uQhE/X+kg1keheczvUxmVmYlu
	rVwAyw+LMA499OciDh+44BNu2vYtnpKJU
X-Google-Smtp-Source: AGHT+IEYl7sgxl6+KCzMjKZchz9so7k1dzyzXKXGekIgXFJtl3r2I4t3pY73+7MmhqiJC7f71yVIaUMG9ouFT8ifKA8=
X-Received: by 2002:a05:690c:6b09:b0:6e3:31ee:23ab with SMTP id
 00721157ae682-6e8581aed96mr45831527b3.25.1729812717313; Thu, 24 Oct 2024
 16:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
 <CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
 <CAHC9VhRY81Wp-=jC6-G=6y4e=TSe-dznO=j87i-i+t6GVq4m3w@mail.gmail.com>
 <5fe2d1fea417a2b0a28193d5641ab8144a4df9a5.camel@gmail.com>
 <CAMw=ZnSz8irtte09duVxGjmWRJq-cp=VYSzt6YHgYrvbSEzVDw@mail.gmail.com> <CAHC9VhQOY-T1hJqf+9hvdtA59ZEdrwhN9Kz-=1KbzcGTyhTQjw@mail.gmail.com>
In-Reply-To: <CAHC9VhQOY-T1hJqf+9hvdtA59ZEdrwhN9Kz-=1KbzcGTyhTQjw@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 25 Oct 2024 00:31:46 +0100
Message-ID: <CAMw=ZnSFxwpG6DztMhEq-fXHP8CCDE4dc-CBejBghP8vAXT_sQ@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2024 at 00:14, Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Oct 22, 2024 at 7:56=E2=80=AFPM Luca Boccassi <luca.boccassi@gmai=
l.com> wrote:
> > On Wed, 23 Oct 2024 at 00:45, <luca.boccassi@gmail.com> wrote:
> > > On Sat, 5 Oct 2024 at 17:06, Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Oct 4, 2024 at 2:48=E2=80=AFPM Luca Boccassi <luca.boccassi=
@gmail.com> wrote:
> > > > > On Wed, 2 Oct 2024 at 15:48, Paul Moore <paul@paul-moore.com> wro=
te:
> > > > > > On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.co=
m> wrote:
>
> ...
>
> > > > We are running a little short on devs/time in LSM land right now so=
 I
> > > > guess I'm the only real option (not that I have any time, but you k=
now
> > > > how it goes).  If you can put together the ioctl side of things I c=
an
> > > > likely put together the LSM side fairly quickly - sound good?
> > >
> > > Here's a skeleton ioctl, needs lsm-specific fields to be added to the=
 new struct, and filled in the new function:
> >
> > Forgot to mention, this is based on the vfs.pidfs branch of
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>
> Thanks.  I'll take a closer look at this next week.  In the meantime,
> do you have this patch in a tree somewhere publicly fetchable?

I've pushed it here: https://github.com/bluca/linux/tree/pidfd_ioctl_lsm

