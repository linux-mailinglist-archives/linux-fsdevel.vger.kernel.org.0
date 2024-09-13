Return-Path: <linux-fsdevel+bounces-29307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD873977EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1528EB267AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E731D88A4;
	Fri, 13 Sep 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3BxI+al"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA11C2DB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227877; cv=none; b=VdsjLxItzMR1QnbckXsA7p1yn9itOuey/R7igYMcNqRZMjY9XmKEDJ4RuWqJ5LQ8VDEcH7mHSOgjPAB8DvvlX1NGThclCxbEAN5MFSKElm4YSIn8jZQK+VsDp7Zygw9GcTB9bd8Ix2ltXU9P4FNm2tI262oH0Us55sdDgka3ngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227877; c=relaxed/simple;
	bh=+tpSDPnevWyiZPggkNLvlKAmCDHpSB1Bo8HcQgmBsY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJLqZox5YgiG1OUhyH9g0t82bXo3Si0Wpk6P+85nZpRMaPj979XfcBgXnITp2hVIMpWte2S4FuD+dSp4qJCnqY6Yi4OT4Nf6LlGWH5Qpj3mPvaVNBQ0kth50WqrlAVEmxhMhbO3w9R8F/nGqHZZdFcnSHRbSYxKCeEzPf39A3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3BxI+al; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99e8d5df1so84173585a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726227874; x=1726832674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0QIGtxY7qWU2jhcQemjXf7assN63pYx6mJjX3mOCAg=;
        b=e3BxI+al+PCMHb1vMOMyG/fnVTYmSWpmlmjk5V7L/vfLeubVbfTS/o6NTDruNLpUTK
         YyhQQJoInGsPoZudIzauk5s5wEUtj8yjgOt2TqI3aCiRLp3SHj0FFRyhDJ0Wo6agvxsa
         RKLRtu6hlnLftivy4K4TOLuqlqjGJWaPdU/OQp+tCYvQEJ+Thtv6UaMTbIGqM+OQMsha
         11s8VDY/drNe/kkXXG6J4nP75zOeKuTvTN7fT5zdBrpC/10Tr62lg3gvNkoa0ur9XjLg
         Kj6gE2c1pC/nR/y22vVDTXQdeHsGuYZQ/VOeOXgHmZT7LOz5dUgH2sfya2WyrhwBK6k5
         kWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227874; x=1726832674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0QIGtxY7qWU2jhcQemjXf7assN63pYx6mJjX3mOCAg=;
        b=LGXxifpXZs+cC2YkyVdR2pPI0W3L0DSfzSnyHQnFyvvNppNEpITN8Ea+4HaYNFiH2T
         1pib27mjQAmbIiIACZ7RGgTf2agwSbMRSgmYWnHW99lKF7g5bn3A9MIyMbApcacyzLVw
         3iwJJEnkyiVcHCYyvqDO/UOPOKoWHRf6+XvhWldqtSfbAl1/jXFvN9CO+p313WA6uKWx
         vqON6cktF++NRnnBlGTHztfTPBBRfjov/BNmMPvlVFWefxDGZHzMlAo2biGCCytmea0r
         Ng119nWBTORRruZHm8W8SM/BuexB//VdAwCFxrJOx2EzshQcy3FJ8+NCF4qDoL4WQu7H
         gn5g==
X-Forwarded-Encrypted: i=1; AJvYcCUkoTjfvKX8SPbWnmZUKZHrAV2RpsocjrYKT1zdPKhMXY8/KPv6p6Ku2d2PksudmXl+UjdjJJcIX1Lb20ny@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/xRsF3d1STK6cxCxBuESGmuHzjLyXQDyXAix742KrX2ea9vl
	ZWpKSG9vyilpaUAA8/hSTk1UmSA6pe8NGw227py78hp3wK6IanxoIoJA8RXiP1runhc7C2F4n1L
	J/wYabUfGwqIuiMbgJXK3WL2WbXg=
X-Google-Smtp-Source: AGHT+IFJ5cC+xrpc+8fXpk822fdu9OOQ5LmBR0iDhooO8XL4QdnglQtSznFdYI24T1s6aP3ipPTwR81RbYlrz3i/IBM=
X-Received: by 2002:a05:620a:404b:b0:7a9:bd0c:ba81 with SMTP id
 af79cd13be357-7ab30d4c93dmr351848585a.31.1726227874424; Fri, 13 Sep 2024
 04:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913104703.1673180-1-mszeredi@redhat.com> <CAOQ4uxiQxQeAd6oEWkKTyEj1SttkWhOC+uPZMZX6+ziV1FVc+w@mail.gmail.com>
 <CAJfpegsfrfwgqfeap7VkJkxsPzjW+WhjJqjYfDVyCa9WF-40Cg@mail.gmail.com>
In-Reply-To: <CAJfpegsfrfwgqfeap7VkJkxsPzjW+WhjJqjYfDVyCa9WF-40Cg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Sep 2024 13:44:23 +0200
Message-ID: <CAOQ4uxgobGJMASEesrsCt447G_=sU5ompBvfq+Vrfc4Ag_aBYA@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 1:13=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 13 Sept 2024 at 13:05, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Sep 13, 2024 at 12:50=E2=80=AFPM Miklos Szeredi <mszeredi@redha=
t.com> wrote:
>
> > > -       res =3D -EOPNOTSUPP;
> > > -       if (!file->f_op->read_iter || !file->f_op->write_iter)
> > > -               goto out_fput;
> > > -
> >
> > FWIW, I have made those sanity checks opt-in in my
> > fuse-backing-inode-wip branch:
> > https://github.com/amir73il/linux/commit/24c9a87bb11d76414b85960c0e3638=
a655a9c9a1
> >
> > But that could be added later.
>
> This is the wrong place to check the f_op.
>
> We could do it in backing_file_open(), but this isn't going to be a
> common error, so I guess just returning an error at read/write time is
> also okay.
>

Yeh. works for me.

Thanks,
Amir.

