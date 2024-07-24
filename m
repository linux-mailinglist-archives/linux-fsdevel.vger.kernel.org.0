Return-Path: <linux-fsdevel+bounces-24185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B093ADEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F7D1C20B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765114B97A;
	Wed, 24 Jul 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0brDYT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC0482FF;
	Wed, 24 Jul 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809655; cv=none; b=tKqeBhacLc94vPurpnH4Yw56N1sbQmCt3zl+1W+shHC1bsHa0QLTACF3V6LY220xW6L2tjoJaTzO8XEPiv9wB6L7jq+WIj0Nwvr5aSRWwjroNGjF65USKeH8Fq38gN91i/AaWoxjSG7SnXYHJGG4CRG53hJBZ/SggPIlNkKCFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809655; c=relaxed/simple;
	bh=iCadzRN7q1oxj17/Vi050lKGeT/f8UmGl1bJVtuZZTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKY5OriLJt7gFZ9JUzcsCUysYyQKNzTL0Hd8ekCjBV59mQukf7IWMpnfpxFU1otBIkTiOjfnw01nFLqL/DhKt+CLiJKg4hluwVALdjcYYJynFTLYHWxXmEoHVkF7zvOucdN7uPMvjvFEg2K10+MnljI9tPhX/YQlVBt9KYJM10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0brDYT2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44e5538a3e6so32547781cf.0;
        Wed, 24 Jul 2024 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721809652; x=1722414452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLUS9YAso7wPPj22WDBjpSi7iwZptGRJCxszxsuDwAc=;
        b=B0brDYT2j1tGlJXddArb6G3762N17VABtskv3FKEqcAoXN4gIik7PLgOIdHfC91d8I
         91rokoceR0KUGPgCTwamnASHpiEMRENoAEvREKcIvKaYa11zvKUdIGGAmf5v3mfK9Pwl
         /glwmtSfEKNhqfEptl1xmM6LopEoGDG4w57d/xEGql/OD96wPeBnRt7+Fh4LpmcIUnTV
         bujg0X8cfk+NUVcg+WC4SOxULlpNML5Ge7AnWuyKahYa5LM66j5Y3ewDCVYHoyqMspXv
         UkYzr6j5VTv/PRMNYJAwWVU/svMXk42bYp73+Dt7FGiP7stmlHw6c9HRKrNS4ElU9DoC
         vNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721809652; x=1722414452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLUS9YAso7wPPj22WDBjpSi7iwZptGRJCxszxsuDwAc=;
        b=nTguVpDYaC7HQo25PDsAAhQnaNI3Ewosr4KbfHJO4lEsyzEstp5iOkMq7i4YNBIbc9
         vKeVwzBnjeAZaokNA7+Wf8uuegkNZXVI+rGtdyTsSQRGYdHl1G+StfbhNKKUf+R/64gk
         B55/5TR2rTJA4HKJSJ4pYja7rF4euHbdW3uNec2PU0eD8NKQgQttWhdhPtigmU8+1prw
         FFcFnNwuTOWS6Otp5SUBlhZuEOP3jMenVlC9/hvDOuOztsYGz+521WJXT0PzRfkjAmX/
         VyiOTOT+oYy4mMVHb5g1qFRRa27beQaf5oZ41tTouiQ92czKSyIyDDE96r9N26I5v+x1
         xftw==
X-Forwarded-Encrypted: i=1; AJvYcCUTZY+ORCsnLG0EykwBdU95XwP5o61B8RQvxyeD4b1woKqjDVAkg8Ph+rCVHwV8CjkJ0154A6oDBRzhgkfbN7IjIpFaOLhzDNCynfWOoVhL+m+IGeqABp0ILliist0iArJ/hc9L8eWXgWP0vQ==
X-Gm-Message-State: AOJu0YxiqBp8JXprmdaNtG2vxCR14hvp+wc1NcX6J96fL+hNKHzEpMX5
	eVLHSa2UfShXIA3tn1LgUuYqBPJoxdAb34qYhIfFpUx/CJN2/keky8FGJzJN0Ea3eRXJyMSPh43
	+OHQz3q01vhB3RNZnzEitWFiq+4o=
X-Google-Smtp-Source: AGHT+IFRqfTKzalQ6+46o/6dd/6ZzlSXb39K7YFtX7awoKbA7o1IcHAbzxKd5Zdh5YP8Ghi6YePJvxNSzfGtPgC3MQQ=
X-Received: by 2002:a05:622a:1386:b0:44f:ca27:ccad with SMTP id
 d75a77b69052e-44fd410ac75mr22826421cf.24.1721809652556; Wed, 24 Jul 2024
 01:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723105423epcas1p4d4ee53975fbc4644e969b5c9b7514c9b@epcas1p4.samsung.com>
 <20240723105412.3615926-1-dongliang.cui@unisoc.com> <1625601dadd97$88eca020$9ac5e060$@samsung.com>
 <CAPqOJe3mdz_heMQe09uZTf-E40ZBTMDuf49jE+hd10qYOjURmg@mail.gmail.com> <162ee01dadd9e$19cbaa40$4d62fec0$@samsung.com>
In-Reply-To: <162ee01dadd9e$19cbaa40$4d62fec0$@samsung.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Wed, 24 Jul 2024 16:27:21 +0800
Message-ID: <CAPqOJe1Zb76YJA7mjY5i61pS7EHTRCHfWDciUr4-Q2RuExAsiA@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: check disk status during buffer write
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 3:50=E2=80=AFPM Sungjong Seo <sj1557.seo@samsung.co=
m> wrote:
>
> > On Wed, Jul 24, 2024 at 3:03=E2=80=AFPM Sungjong Seo <sj1557.seo@samsun=
g.com>
> > wrote:
> > >
> [snip]
> > > >
> > > > +static int exfat_block_device_ejected(struct super_block *sb)
> > > > +{
> > > > +     struct backing_dev_info *bdi =3D sb->s_bdi;
> > > > +
> > > > +     return bdi->dev =3D=3D NULL;
> > > > +}
> > > Have you tested with this again?
> > Yes, I tested it in this way. The user side can receive the -ENODEV err=
or
> > after the device is ejected.
> > dongliang.cui@deivice:/data/tmp # dd if=3D/dev/zero of=3Dtest.img bs=3D=
1M
> > count=3D10240
> > dd: test.img: write error: No such device
> > 1274+0 records in
> > 1273+1 records out
> > 1335635968 bytes (1.2 G) copied, 8.060 s, 158 M/s
> Oops!, write() seems to return ENODEV that man page does not have.
> In exfat_map_cluster, it was necessary to distinguish and return error
> values, but now that explicitly differentiated error messages will be
> printed. So, why not return EIO again? It seem appropriate to return EIO
> instead of ENODEV from the read/write syscall.
Yes, indeed.
I will make the changes all together in the next version.
Thanks=EF=BC=81
>
> >
> > >
> > > > +
> > > >  static int exfat_get_block(struct inode *inode, sector_t iblock,
> > > >               struct buffer_head *bh_result, int create)
> > > >  {
> > > > @@ -290,6 +298,9 @@ static int exfat_get_block(struct inode *inode,
> > > > sector_t iblock,
> > > >       sector_t valid_blks;
> > > >       loff_t pos;
> > > >
> > > > +     if (exfat_block_device_ejected(sb))
> > > This looks better than the modified location in the last patch.
> > > However, the caller of this function may not be interested in exfat
> > > error handling, so here we should call exfat_fs_error_ratelimit()
> > > with an appropriate error message.
> > Thank you for the reminder. I will make the changes in the next version=
.
> Sounds good!
>
> >
> > >
> > > > +             return -ENODEV;
> > > > +
> > > >       mutex_lock(&sbi->s_lock);
> > > >       last_block =3D EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb=
);
> > > >       if (iblock >=3D last_block && !create)
> > > > --
> > > > 2.25.1
> > >
> > >
>
>

