Return-Path: <linux-fsdevel+bounces-30172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC2987556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59991F27672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDF14A615;
	Thu, 26 Sep 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jiy55qnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642B148833
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360408; cv=none; b=hsz5bmdd/dgfEfkm9WlxEFPltt2tBJZ01cbkSyEWQdZ5tROD7Bm3bkqskqGzv0ZEusEFrDYAFyA5aObj3QYvGCtVT9xLAqUNcQmgegcshsdyRD/qt+uQ3SoT2mHc84kjuEyuQnULacVnh1KsjJKNGTxN4VsUyHJmLxEyuDt5dUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360408; c=relaxed/simple;
	bh=fsBejCLuikqVjJuRyFztdr0Xv2VonpPl0X1UtIzWwQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9abrt6GQyR/fB7g01Nf34oMe+UrQIo2KbPrvXMUc6BN0inob4BlUchViJZdKTXircwDJcM4XxEU6fU4Y43iiBBb5GSctSXKTeZ61k2JQtOIRAwc0STmFMwoKudLR/sFzNi0lakVOQM16O5FKuosPejaTKshYN7YxUk66nwmi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jiy55qnf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 723C94064B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727360399;
	bh=fL59POmvaFxcf8qmycNokQKGCX9wZGI3HSvbyTNhbxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jiy55qnfyHqurWt5l+t+gQLBIcjAKlPrirDCffv7dLhYJ2KSKp/xFDjtYESpbRne1
	 jWVDHVtRvOmxbiMj4kTW0aIKP6QF5us6c8UM5M7xLyWWIkBu7D78fqv/wefSHIh5jv
	 aFlBpopU2gs0K+qlLkRuRARoOn2Soxt0N1aI4KI/wQOETejtVAC26wciZcFZsfzKYi
	 g1p2qTjgX8kiUPIW49u3V+ANj2/pZqunjK8BDnIwXGQcxwYeSudUFZ7hemCsw51Hy5
	 EBTX1JqIEASMK1iYirehe2cAQnrBw1N0QukQO2pwdF5TLoH1SAsbi5U8oLRmU1t5S1
	 OtFpPe2abSoJg==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50108c1f034so294161e0c.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 07:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360391; x=1727965191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL59POmvaFxcf8qmycNokQKGCX9wZGI3HSvbyTNhbxk=;
        b=Er0Z1MAH0/Oz9yos/7TVs1UzDBR7eNnZic2oB5/Rd4LwfU7rtpR7GGwDCKjuQVeYw1
         N0+KgE1vOpq5cp4x1PA2jJK3lyCbsuBdR6qmRvNBpoj744+U1PTT4cFh5V6rXecLMfdx
         8mUhlFUumeAAVdir+ZhSemAxKSX9RNhO2FJ6jnfT7Y6cCfAKFDInBjN3NKOwo2obDTLM
         xAGWJSpgy3dcu4a78y4Noa+k9j6wY3plYaN7HSxspf+go8Xk9Mp4/uz7S62aLSc26j6I
         8Dd2es15vio/vliEzeIyhiTnmqXZjWY4O8hRCxpEC792qxy3XdMyGpu4sbPSY54QFkWY
         sykw==
X-Forwarded-Encrypted: i=1; AJvYcCUQymOnMsRgegdKx92ZFWUO1P6bjBKZo8y/OPWTWqe5czBYkt+8yNcq4tFTMwG89KcjppraabQi6fVmrS9j@vger.kernel.org
X-Gm-Message-State: AOJu0YywRtLoPa6IbKiAdQrB1b7EQQrHSc55gy+as1QKOU0ebEwIPwKH
	/rrMhnJWUYtC441ijZtubzioAX+YPHoE3HwLhpAxjCWnFhPxXJrMgXzuFZ6FOTtRL6gByjDx/eC
	u9DjADgzPI7gDJ9K4pc296Vw8xsFUzi5Y8ByQ5I4/2aHhKc/S2sKbEDKMlHphVKC/FUpDWUV9y3
	QIf1DKyTBb6coyB4I2tBeqOMnI/yYtprkkynu274sINKvVVxtgTCB6n4UsP5IJpn6Z
X-Received: by 2002:a05:6122:3d0b:b0:4ed:52b:dd29 with SMTP id 71dfb90a1353d-505c1d53c06mr5728818e0c.3.1727360390716;
        Thu, 26 Sep 2024 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVXaX4QPQm+moOngoVdPlVhd3WRkw/NbU43aKvdUv71fZhsvtLbbDFgTOG2KujfW9HaeMmgltFHBuD5DMLxWY=
X-Received: by 2002:a05:6122:3d0b:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-505c1d53c06mr5728792e0c.3.1727360390399; Thu, 26 Sep 2024
 07:19:50 -0700 (PDT)
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
 <4ce5c69c-fda7-4d5b-a09e-ea8bbca46a89@huawei.com> <CAEivzxekNfuGw_aK2yq91OpzJfhg_RDDWO2Onm6kZ-ioh3GaUg@mail.gmail.com>
 <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
In-Reply-To: <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 16:19:39 +0200
Message-ID: <CAEivzxcR+yy1HcZSXmRKOuAuGDnwr=EK_G5mRgk4oNxEPMH_=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:58=E2=80=AFPM Baokun Li <libaokun1@huawei.com> wr=
ote:
>
> On 2024/9/26 19:32, Aleksandr Mikhalitsyn wrote:
> >>> Question to you and Jan. Do you guys think that it makes sense to try
> >>> to create a minimal reproducer for this problem without Incus/LXD inv=
olved?
> >>> (only e2fsprogs, lvm tools, etc)
> >>>
> >>> I guess this test can be put in the xfstests test suite, right?
> >>>
> >>> Kind regards,
> >>> Alex
> >> I think it makes sense, and it's good to have more use cases to look
> >> around some corners. If you have an idea, let it go.
> > Minimal reproducer:
> >
> > mkdir -p /tmp/ext4_crash/mnt
> > EXT4_CRASH_IMG=3D"/tmp/ext4_crash/disk.img"
> > rm -f $EXT4_CRASH_IMG
> > truncate $EXT4_CRASH_IMG --size 25MiB
> > EXT4_CRASH_DEV=3D$(losetup --find --nooverlap --direct-io=3Don --show
> > $EXT4_CRASH_IMG)
> > mkfs.ext4 -E nodiscard,lazy_itable_init=3D0,lazy_journal_init=3D0 $EXT4=
_CRASH_DEV
> > mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
> > truncate $EXT4_CRASH_IMG --size 3GiB
> > losetup -c $EXT4_CRASH_DEV
> > resize2fs $EXT4_CRASH_DEV
> >
> Hi Alex,
>
> This replicator didn't replicate the issue in my VM, so I took a deeper
> look. The reproduction of the problem requires the following:

That's weird. Have just tried once again and it reproduces the issue:

root@ubuntu:/home/ubuntu# mkdir -p /tmp/ext4_crash/mnt
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
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 6400 4k blocks and 6400 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/loop4 is mounted on /tmp/ext4_crash/mnt; on-line
resizing required
old_desc_blocks =3D 1, new_desc_blocks =3D 1
Segmentation fault

My kernel's commit hash is 684a64bf32b6e488004e0ad7f0d7e922798f65b6

Maybe it somehow depends on the resize2fs version?

Kind regards,
Alex

>
> o_group =3D flexbg_size * 2 * n;
> o_size =3D (o_group + 1) * group_size;
> n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>
> Take n=3D1,flexbg_size=3D16 as an example:
>                                                   last:47
> |----------------|----------------|o---------------|--------------n-|
>                                    old:32 >>>           new:62
>
> Thus the replicator can be simplified as:
>
> img=3Dtest.img
> truncate -s 600M $img
> mkfs.ext4 -F $img -b 1024 -G 16 264M
> dev=3D`losetup -f --show $img`
> mkdir -p /tmp/test
> mount $dev /tmp/test
> resize2fs $dev 504M
>
>
> --
> Cheers,
> Baokun
>

