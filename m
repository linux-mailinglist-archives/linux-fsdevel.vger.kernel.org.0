Return-Path: <linux-fsdevel+bounces-30150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00455986FFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F5E1F216F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1A1AB6F3;
	Thu, 26 Sep 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pEm0n1xe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028A146596
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342628; cv=none; b=kMog/Pi92EdZ1PLIv2fSFtpNnrBlSb+GQMjsv6E821/k9MbRQpFTHIquM35zxKbcYOgVTilIT3s/pZTPx5XTujSXHZqcAv9C8BnOLjPKEklFgFGFYNXT4lWovfy0mFztc8iTIgO5iOx3v8sHsdKEMfeI99iUrANIxrxNOmGYOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342628; c=relaxed/simple;
	bh=OGmxnpcDlZNA/AYOJ/6ULikhRdvi0qFPDR/9HM1/x2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNILNc3UBuugwoaUim1QgJOanyNcBUo/IiE3TAyTsnUrzEraN3k9nRo7JJRq8jhZYOUs0Ua4Qb7D5c31+45zyMjzzHe15I0apSH62DFq8/38pYEG1SF53xVDuA/I/CTbo+LKrUR8DjbG5rhX4webQTev5sMdQIqtbp1/H7LfiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pEm0n1xe; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A40E64063F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727342622;
	bh=VuvXYjjw3CXYdbw9a5WIM2wjLWJmbAUDB5oW3X71uKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pEm0n1xeEV659gwT54DVFwTjwy9BxK4EBjnewykepV+wiFmlPczhQATQG0Q2SGSML
	 rGJhBZGZnDIK936YNbu5vZgeFDfKvTqiRQMApUGjmRWO9KxO4r0FMzKNjiEPzpf/Mi
	 PCpbJCFLmUbIA/kDsu6lntoxApXu3DeLqHTx0TqbYTuc7Wnq1zD3g88w+hU1S1PCTx
	 bwUo9YItBUSJMLPqAOYoN0gaYkE4HbgpBo6T3n1P2DnMcMmWvkR4E8ImPASKwVAwtd
	 oHBwBKBJDrDxKV4JFaUol1HRSpvG1QrZF3/n1k3Z+mTJcx+8kK/G0NHVOwKDY7fGdp
	 ArEfcGb1kC/ug==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50124ddd2d5so251669e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 02:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342615; x=1727947415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuvXYjjw3CXYdbw9a5WIM2wjLWJmbAUDB5oW3X71uKI=;
        b=qapQDi5bFotni94vcakYPHO3o3DqyfD+a9mHGXZq7TlkZFyI/jDDDQebEn5xDg1OQO
         uAyI84zaWdzc5p3BvnqwcRGp1SyIMNFY7pH1u2DL5/WTvewgGNsgMZZK0znV1KHMqlRk
         LtK0bHJq8Nu4Ti/7zJrCfFLWRI5xm+qZZ2t7al70E9hobh/Yd+slWdFOSiUbyKuRbVUM
         9PXH1ACFjrPsQplPDDvGO43nqfoazi/qNGgjhRTv0fxnJSeXr4osKMQ/eZej35Ekic23
         vqoEtg0r1S0CXPAyj4QWhXNS3OCF/eDYvtu2euva03u2Uf5pyWHkPoB0DPrf/3L8nobi
         34Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUNypi0BcD2L2a3jnO25mInhDBJC4Z0LXUsK89OPCFc1k6B4+7bKXoUyrtcYPeCAFlT3bLQQuThMoALW/kN@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1zwDX/XssidZX5H0YGP6HmhAzlD9loeQI3WwtfcBjPnsLpAF
	iIt7KGdHbBUROZo0yOh58sU1jMPkjp5dATgFNP0Ijtf/MixzLPsPIJ0RbWjxkiBXJtKOt4i3h2W
	8cxRjeWyG7rHeKtm2u2hvu4hDqewM3j1VXj5iRdmX7yMOh84gX/LALGt6SzDGf3z/CfrKlrnNNx
	5l927dl3x3f93RA1s3gAqJjNjNMg39AzSxWeLXD16wSKZ1JVNCOf3ahQ==
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id 71dfb90a1353d-505c20c9250mr4629410e0c.12.1727342615579;
        Thu, 26 Sep 2024 02:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5CdqjXmLGTfMBbg30OzbC8qJPvljC2kVMj5wKnnDPZibQ6RE8OS5y2l4s17+ZabfNSzJgl1eo11+fDbgIx2M=
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-505c20c9250mr4629390e0c.12.1727342615085; Thu, 26 Sep 2024
 02:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
In-Reply-To: <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 11:23:24 +0200
Message-ID: <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:50=E2=80=AFAM Baokun Li <libaokun1@huawei.com> w=
rote:
>
> On 2024/9/26 0:17, Aleksandr Mikhalitsyn wrote:
> > On Wed, Sep 25, 2024 at 5:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> >>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-=
b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> >>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 78643=
2 blocks
> >>> [   33.888740] ------------[ cut here ]------------
> >>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
> >> Ah, I was staring at this for a while before I understood what's going=
 on
> >> (it would be great to explain this in the changelog BTW).  As far as I
> >> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory alloc=
ation
> >> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
> >> flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*fle=
xbg_size
> >> - 1) which then confuses things. I think that was not really intended =
and
> > Hi Jan,
> >
> > First of all, thanks for your reaction/review on this one ;-)
> >
> > You are absolutely right, have just checked with our reproducer and
> > this modification:
> >
> > diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> > index e04eb08b9060..530a918f0cab 100644
> > --- a/fs/ext4/resize.c
> > +++ b/fs/ext4/resize.c
> > @@ -258,6 +258,8 @@ static struct ext4_new_flex_group_data
> > *alloc_flex_gd(unsigned int flexbg_size,
> >                  flex_gd->resize_bg =3D 1 << max(fls(last_group - o_gro=
up + 1),
> >                                                fls(n_group - last_group=
));
> >
> > +       BUG_ON(flex_gd->resize_bg > flexbg_size);
> > +
> >          flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
> >                                          sizeof(struct ext4_new_group_d=
ata),
> >                                          GFP_NOFS);
> >
> > and yes, it crashes on this BUG_ON. So it looks like instead of making
> > flex_gd->resize_bg to be smaller
> > than flexbg_size in most cases we can actually have an opposite effect
> > here. I guess we really need to fix alloc_flex_gd() too.
> >
> >> instead of fixing up ext4_alloc_group_tables() we should really change
> >> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exc=
eeds
> >> flexbg size. Baokun?
> > At the same time, if I understand the code right, as we can have
> > flex_gd->resize_bg !=3D flexbg_size after
> > 5d1935ac02ca5a ("ext4: avoid online resizing failures due to oversized
> > flex bg") and
> > 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex=
_gd()")
> > we should always refer to flex_gd->resize_bg value which means that
> > ext4_alloc_group_tables() fix is needed too.
> > Am I correct in my understanding?
>
> Hi Alex,

Hi Baokun,

>
> These two are not exactly equivalent.
>
> The flex_gd->resize_bg is only used to determine how many block groups we
> allocate memory to, i.e., the maximum number of block groups per resize.
> And the flexbg_size is used to make some judgement on flexible block
> groups, for example, the BUG_ON triggered in the issue is to make sure
> src_group and last_group must be in the same flexible block group.

Huge thanks for explaining this!

Then I guess it's better if you send a patch with your fix.
Feel free to add my Tested-by tag.

Question to you and Jan. Do you guys think that it makes sense to try
to create a minimal reproducer for this problem without Incus/LXD involved?
(only e2fsprogs, lvm tools, etc)

I guess this test can be put in the xfstests test suite, right?

Kind regards,
Alex

>
>
> Regards,
> Baokun
>

