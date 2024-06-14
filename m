Return-Path: <linux-fsdevel+bounces-21720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F333A90924B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B0EB22045
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89D19DF7C;
	Fri, 14 Jun 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okjh6L1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1A4409;
	Fri, 14 Jun 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389840; cv=none; b=aefE8F3m7Qh8wKxFPl6LFMHroqWU6/s+gnOPrO5PISzoAEugdZwuf9cBbJ+FaXxtVo+oVPxw4bXo0qRSLF4OkPFMhUVtpKocffhFEqk8VunucLNIUq2OsV2Nms19doyhV5WVduaL3K4ziqHgxxh+P9I4pDjeqw+EuouNw9EpcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389840; c=relaxed/simple;
	bh=kyFW8FIJrknD3f9T3QVYRnijHSMlLw00cspVmxo7BlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYos9NHsKhoKDck6WycHZxPlgFrcOFJ59L2oIfEt0EQMmt7EzBTjhVemTDUejwBVTUn161Tq5vsCakdzgaW6MboLlUk5m8I6pu4jF3XR2Sx2xyvSht+2nGf1GhzVI0q5xfJ9RhadodIlT+rdTCWc/Q7m0wmhGsgAanKIpEGeuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okjh6L1o; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so27532311fa.1;
        Fri, 14 Jun 2024 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718389836; x=1718994636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgc6c/AlVm64X+LxZJ5q+Y3/Dp2q9nBZcMIEcvsnAKg=;
        b=Okjh6L1ohNcY4QUgX0NkH3/T1yDpDe7Vkt5Hb/GYaQ0JZrs002ZKJ34wcdx1c8Aoe4
         v3q0TFgn8QJSuNZnjAgOB17QUEz/MqCaaW8/1V+jq4CQ3aBYqkIIQw44ZE4LSn2P6HV8
         HJm3PoJ4oknOLYZQ3e7ZaRyZ+bbzQliMZY5VatEQoSRHx5/m97OzTVfngDjpQUYZWfz6
         jq5LTkSDpbJj5VB8ZvO4A6ftHUGe92LbffKKYs11XmCvjTnBcGpXgZva0gHwj+baeEgo
         ZMrxoPwA5m8cX4LO7Iej0WHzYVaWq410D56D7Mrbvg2oqCSaRMP1vOV6FGqXOfABnHAv
         y9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718389836; x=1718994636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgc6c/AlVm64X+LxZJ5q+Y3/Dp2q9nBZcMIEcvsnAKg=;
        b=YBSqlqDL3CB+0HSB8mF14sJC76Kom8QUqxInCpULRR/SNChZMdUGxTmMhndyTjyrFL
         Qk8hYO3FRMk43bVuEGSp98yJc9BIZHWqZfCGdhkujnXq8J7pMiqpkQo9QBADXnnwz9oA
         oxuEtYH4c9quwT1Tn6LCNRMxGz7q/tHcnjkbSnEkq00uWwhoU7qTOOq75W9I+Sgyin9X
         fdfjxhRD1YS9/ce8tytsKNfDldlkFTqS8hOqx1ciXNP4EZf69gwpdblmucBSmtE8bydi
         SnrkMmxcpOYVm1c9geNeow5tM0DX9b1Y1amR9otYO62vdx5PCd/5Tc534+hWmR9HEddH
         LkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ftpNlspbFkIXCrDZJ7ALTAaHbskPsZH/WxT9kbr5dFZ24pWiqyu7iOwk621Jp8WuSLvkFKX8xfPIulDEI2LiwzJaPOSVuYfeZp9017nOcAIA1hfwJWjFNeXyz5I/uh8+nTV4PX+KKE0=
X-Gm-Message-State: AOJu0YyGD+sWjW6Ci5K7+DzJr59CGYd3TgEssv/joRhewYueRYDyaijl
	SZMLciU1cOn55UCEW6iJiaWBkjXYeueHOak+6tI/qeMT7mjD8mIkF00Annzs6nQfBzxqqFcfFUp
	dcAPiM+crxPVvNQwLEAfFF5C3qu4=
X-Google-Smtp-Source: AGHT+IFuCxPnWdPgZbZjnxz7le4BHJ/RAuc/8+LsBd0/tfr7kPXDMr6z8YOqeHaBhxeI+8JhzPHALYypcJVIiakDE2E=
X-Received: by 2002:a2e:2e0f:0:b0:2eb:e840:4a1b with SMTP id
 38308e7fff4ca-2ec0e5b5e75mr22786271fa.7.1718389836228; Fri, 14 Jun 2024
 11:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406141533.e9eb9ad9-oliver.sang@intel.com>
In-Reply-To: <202406141533.e9eb9ad9-oliver.sang@intel.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 14 Jun 2024 13:30:23 -0500
Message-ID: <CAH2r5msBudvQREvO1C5QB=AjHmDJEZk6KzPGjELsO8f-W7+_Xg@mail.gmail.com>
Subject: Re: [dhowells-fs:netfs-writeback] [netfs, cifs] d639a2f9ab: xfstests.generic.080.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: David Howells <dhowells@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also ran into this (mtime update bug) so did not merge this patch
into cifs-2.6.git for-next


On Fri, Jun 14, 2024 at 2:57=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "xfstests.generic.080.fail" on:
>
> commit: d639a2f9abbeb29246eb144e6a3ed9edd3f6d887 ("netfs, cifs: Move CIFS=
_INO_MODIFIED_ATTR to netfs_inode")
> https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git netfs-=
writeback
>
> in testcase: xfstests
> version: xfstests-x86_64-e46fa3a7-1_20240612
> with following parameters:
>
>         disk: 4HDD
>         fs: ext4
>         fs2: smbv3
>         test: generic-080
>
>
>
> compiler: gcc-13
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake)=
 with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406141533.e9eb9ad9-oliver.san=
g@intel.com
>
> 2024-06-13 08:02:14 mount /dev/sdb1 /fs/sdb1
> 2024-06-13 08:02:15 mkdir -p /smbv3//cifs/sdb1
> 2024-06-13 08:02:15 export FSTYP=3Dcifs
> 2024-06-13 08:02:15 export TEST_DEV=3D//localhost/fs/sdb1
> 2024-06-13 08:02:15 export TEST_DIR=3D/smbv3//cifs/sdb1
> 2024-06-13 08:02:15 export CIFS_MOUNT_OPTIONS=3D-ousername=3Droot,passwor=
d=3Dpass,noperm,vers=3D3.0,mfsymlinks,actimeo=3D0
> 2024-06-13 08:02:15 echo generic/080
> 2024-06-13 08:02:15 ./check -E tests/cifs/exclude.incompatible-smb3.txt -=
E tests/cifs/exclude.very-slow.txt generic/080
> FSTYP         -- cifs
> PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.10.0-rc2-00003-gd639a2f9abbe =
#1 SMP PREEMPT_DYNAMIC Thu Jun 13 09:50:57 CST 2024
>
> generic/080       [failed, exit status 2]- output mismatch (see /lkp/benc=
hmarks/xfstests/results//generic/080.out.bad)
>     --- tests/generic/080.out   2024-06-12 14:13:57.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/080.out.bad   2024-06-1=
3 08:03:12.373660796 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 080
>      Silence is golden.
>     +mtime not updated
>     +ctime not updated
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/080.out /lkp/ben=
chmarks/xfstests/results//generic/080.out.bad'  to see the entire diff)
> Ran: generic/080
> Failures: generic/080
> Failed 1 of 1 tests
>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240614/202406141533.e9eb9ad9-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>


--=20
Thanks,

Steve

