Return-Path: <linux-fsdevel+bounces-30161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C19872D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABBA1F25CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57E14B08A;
	Thu, 26 Sep 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k8fyNGgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB113DDDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350358; cv=none; b=rr4PIPpCDBb6df+fa2wpjFFfpaIuF+WkpWYW9pWD5U3E17DNJBivFVDFu98nldhSMoZPPHXYXoCJgg2vnUOW+daIZrhOUxcKsZBtpYasYet+6950N83QI89APBusNn3ijiQcIGDbFXXZrHLR1rGuYwRw9MU6ywhN7d9OQ89xstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350358; c=relaxed/simple;
	bh=xKiXZK3qa6f566IlLibrHNHgeg+38FWO0YqBNklGEVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URixcqYYct4xmmNjLS4OikXnZlwp/VHuPkhPGFrjwvsLuYsp69/02YkapeKg+qHhysqu/o3uxN+HZlKbfjxiKDykwpAROhRFaSqnCBvdWp7IYm2Y3UeyP+8iLl9xVONviwBeyGohsPhog9UQCrS3p3HWKGmqVqwGH59JFlb4KfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k8fyNGgu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55CB03FB75
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727350353;
	bh=zPpF9aDmC+Mnyu4DVOZ2Pa9ex2ANZ8Mr+tKqw0+7zXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=k8fyNGgud6xffURWvwn739NqVehhu9ytHaJySTZfYyMXzPficg/JZ1GZGk+npc1vp
	 l7FNFWSIPBxdSVvIGGzpQ79Xnp/7PaqAN3RA+CEnrVux1HCprj6/DGCc+mGgNcNANe
	 3auhXDKDSlGbWb+kXwb1qucKdMD7xvwZkRCSSZgmXtYavmMv4VLBSI5tfIxzjhn+rm
	 wkxp2DUSt8A0vFzcLcxpBZkpdQP16RFzgPg5Ow8GSZDykbcELe7+UeTJAPJ3nR5VZx
	 oPyp8mQekgKAefb0gLe317FkaspDVksJzGP0Osbh+bAbobkmoXREftBRngtNSATDYw
	 5uaFKaGSdnaPg==
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-501a273e3bdso224502e0c.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 04:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350351; x=1727955151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPpF9aDmC+Mnyu4DVOZ2Pa9ex2ANZ8Mr+tKqw0+7zXQ=;
        b=U94bIzNMSn1oW5+Y2q1QFUT1a1L4UFNhXdjl/OwOJ4vXRqTzTJe5f141FmhJbofCLF
         OHRqF5PSi4/PKCf26xCFWqz/fcyPViRUYUJry/9alWV9KFOfxBIPj0Df9F9vjbzcoupy
         07vwxP5YqYHFzBW5+zU6R+S6P+ejSlLLRtzK0ODHx+KM3UV7NeSagcmxPMHGrQhBx0sY
         B3sBTYEdZ5aoGAuOE0Po3oWokrh4wfdXDvz6nWKANwZol/66V9EZY0iYMGD/GtDATgiL
         YcaPtY0Xk0HkLktYSW+3DV2zIp001TxGvbvEX99ECca5teK64x+sAtmJj2CHTBmDw9EB
         jV2A==
X-Forwarded-Encrypted: i=1; AJvYcCWIRNEgY2d30/U/+Bai1HcK6sJJsjXk2ESql2PSdXQvP3fzWZfN3U4XMmkeKX2hUvnKPMAMicneUvpo9Lld@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIta1Nnx2zn9F9cXK2OJl3p/QqpP4y6gd9EuG0NwCZ4wUE75o
	Dlj47wnxk06oht3bflNlYGJBLA9vBEqUKzWRuT3nZ3l5Cekiv5EIgf3k23X+rtSIWCkGN8yLKJB
	vVzwUWa4KJCVhGQ8I7MYWfXRWoSafYnYfvZHST9FEziVIbLPCfK8LKaDSBRZraPUXdKeX/RwnzY
	mmmZCGPtxGbLTcRh7MZ2UEgnvmZ58LYFV2WaQW52fHeUW2rCyuvARLdw==
X-Received: by 2002:a05:6122:1dac:b0:4f5:202b:6220 with SMTP id 71dfb90a1353d-505c199c949mr4820585e0c.0.1727350351320;
        Thu, 26 Sep 2024 04:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5d0qCzTsLa+yY4RvWO1He7An170Y7lxw70RCK4Y01gROAsLBp+vUbl6SD/qSHuicDsRxCqT4xsHz05zLJQpQ=
X-Received: by 2002:a05:6122:1dac:b0:4f5:202b:6220 with SMTP id
 71dfb90a1353d-505c199c949mr4820541e0c.0.1727350350968; Thu, 26 Sep 2024
 04:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com> <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
 <4ce5c69c-fda7-4d5b-a09e-ea8bbca46a89@huawei.com>
In-Reply-To: <4ce5c69c-fda7-4d5b-a09e-ea8bbca46a89@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 13:32:20 +0200
Message-ID: <CAEivzxekNfuGw_aK2yq91OpzJfhg_RDDWO2Onm6kZ-ioh3GaUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:40=E2=80=AFAM Baokun Li <libaokun1@huawei.com> w=
rote:
>
> On 2024/9/26 17:23, Aleksandr Mikhalitsyn wrote:
> > On Thu, Sep 26, 2024 at 10:50=E2=80=AFAM Baokun Li <libaokun1@huawei.co=
m> wrote:
> >> On 2024/9/26 0:17, Aleksandr Mikhalitsyn wrote:
> >>> On Wed, Sep 25, 2024 at 5:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> >>>> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> >>>>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa=
8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> >>>>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786=
432 blocks
> >>>>> [   33.888740] ------------[ cut here ]------------
> >>>>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
> >>>> Ah, I was staring at this for a while before I understood what's goi=
ng on
> >>>> (it would be great to explain this in the changelog BTW).  As far as=
 I
> >>>> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory all=
ocation
> >>>> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger tha=
n
> >>>> flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*f=
lexbg_size
> >>>> - 1) which then confuses things. I think that was not really intende=
d and
> >>> Hi Jan,
> >>>
> >>> First of all, thanks for your reaction/review on this one ;-)
> >>>
> >>> You are absolutely right, have just checked with our reproducer and
> >>> this modification:
> >>>
> >>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> >>> index e04eb08b9060..530a918f0cab 100644
> >>> --- a/fs/ext4/resize.c
> >>> +++ b/fs/ext4/resize.c
> >>> @@ -258,6 +258,8 @@ static struct ext4_new_flex_group_data
> >>> *alloc_flex_gd(unsigned int flexbg_size,
> >>>                   flex_gd->resize_bg =3D 1 << max(fls(last_group - o_=
group + 1),
> >>>                                                 fls(n_group - last_gr=
oup));
> >>>
> >>> +       BUG_ON(flex_gd->resize_bg > flexbg_size);
> >>> +
> >>>           flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
> >>>                                           sizeof(struct ext4_new_grou=
p_data),
> >>>                                           GFP_NOFS);
> >>>
> >>> and yes, it crashes on this BUG_ON. So it looks like instead of makin=
g
> >>> flex_gd->resize_bg to be smaller
> >>> than flexbg_size in most cases we can actually have an opposite effec=
t
> >>> here. I guess we really need to fix alloc_flex_gd() too.
> >>>
> >>>> instead of fixing up ext4_alloc_group_tables() we should really chan=
ge
> >>>> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never e=
xceeds
> >>>> flexbg size. Baokun?
> >>> At the same time, if I understand the code right, as we can have
> >>> flex_gd->resize_bg !=3D flexbg_size after
> >>> 5d1935ac02ca5a ("ext4: avoid online resizing failures due to oversize=
d
> >>> flex bg") and
> >>> 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_fl=
ex_gd()")
> >>> we should always refer to flex_gd->resize_bg value which means that
> >>> ext4_alloc_group_tables() fix is needed too.
> >>> Am I correct in my understanding?
> >> Hi Alex,
> > Hi Baokun,
> >
> >> These two are not exactly equivalent.
> >>
> >> The flex_gd->resize_bg is only used to determine how many block groups=
 we
> >> allocate memory to, i.e., the maximum number of block groups per resiz=
e.
> >> And the flexbg_size is used to make some judgement on flexible block
> >> groups, for example, the BUG_ON triggered in the issue is to make sure
> >> src_group and last_group must be in the same flexible block group.
> > Huge thanks for explaining this!
> >
> > Then I guess it's better if you send a patch with your fix.
> > Feel free to add my Tested-by tag.
> Okay, I'll send a patch later.
> >
> > Question to you and Jan. Do you guys think that it makes sense to try
> > to create a minimal reproducer for this problem without Incus/LXD invol=
ved?
> > (only e2fsprogs, lvm tools, etc)
> >
> > I guess this test can be put in the xfstests test suite, right?
> >
> > Kind regards,
> > Alex
> I think it makes sense, and it's good to have more use cases to look
> around some corners. If you have an idea, let it go.

Minimal reproducer:

mkdir -p /tmp/ext4_crash/mnt
EXT4_CRASH_IMG=3D"/tmp/ext4_crash/disk.img"
rm -f $EXT4_CRASH_IMG
truncate $EXT4_CRASH_IMG --size 25MiB
EXT4_CRASH_DEV=3D$(losetup --find --nooverlap --direct-io=3Don --show
$EXT4_CRASH_IMG)
mkfs.ext4 -E nodiscard,lazy_itable_init=3D0,lazy_journal_init=3D0 $EXT4_CRA=
SH_DEV
mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
truncate $EXT4_CRASH_IMG --size 3GiB
losetup -c $EXT4_CRASH_DEV
resize2fs $EXT4_CRASH_DEV

>
> Regards, Baokun
>

