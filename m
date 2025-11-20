Return-Path: <linux-fsdevel+bounces-69250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A253FC75376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D940831431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A703546FC;
	Thu, 20 Nov 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2PUna/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285D21420B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654590; cv=none; b=gfalmIanYEX7MjoN4WdZfL4vf++emEbYBixztgfPUlY9W+ckjCgtkiEd1tjwqHs9DdjYEVg/7CVxz0GfgypVbzW2pVO1SfEmY1ShC97rsLtb9FPrNx/vTYI7wds3yPLyu5wbRV5lU8aOSKgMwBpq71wF+5inFYsuJuiJWw6baBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654590; c=relaxed/simple;
	bh=03JP2KGY2QAaatdwtpbDBWGq9N0k/1yStFqHeV94MXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiahLZ1y9z9LLS4qkFtFoDVLSXvVibCietO664GQjuir/6xsHASFyoPdgVxXWOgAICKshXLtGoyQA60rXsBD/dqu9fA7D6rUjw/xc/4uPQwLJNeLpYjXCYto3sRMngEa3ZwR08OZ/b/kSYIskLgco8pSbK8h7ONcx0XpfUyLi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2PUna/o; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37ba781a6c3so8667181fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 08:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763654586; x=1764259386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KKGNrhZBJxzXvm6ww1JNhDsEs7Z2q+zASFncssfYAM=;
        b=Z2PUna/oMyO8UFDs/Kms2yEIS/tY/7LqUBDaHSwNX8HWclQvdEUz/67VUPggXKUu+L
         n2EBplRnLgVbUtQ6rdQOJp412BnBpwCYKdkOT5+GXw65M80xUc9p3WcAeQKsjeKOSd3g
         RRBJqGdLBd7CqHyU43GKBhZjOh1y+p+lof3v6ZoN4NSw1CZzZXkRkCgt+w/rswhNdKao
         qSrmBJM2MNw6tg+VLTCEnMYTedp1lJdA/JQCrj3G+EiW0NIl1H531PR4Z4Sv6leFd6qf
         kH06LTDU5AkDUKCrGCQIpAm7cYlu5yf1TuBNmGhOvkFckzbAv6nNsTfrQusQpWH2MWlD
         4/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654586; x=1764259386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KKGNrhZBJxzXvm6ww1JNhDsEs7Z2q+zASFncssfYAM=;
        b=JY7UPcIfocZaDYEpmwi0VftqnTVkLx34YsBim5UWz7F2Dj1G/J2NC999GmRsKFRtgq
         JBz7kqCLUTF/iKkG/aAQ8aIliqicxwiQx8UF++/ywrpgfCpasM6/W4dqymrOliIuMbZu
         +Xr+QNIGCYZxzXJHjbBlEVg/MPvAK5Pj3rGn1pguK0AQJAWP8xmD/TZhd1BWHkBPk51C
         5OXJ5mDFJsBe1N0apQAFifZrlz0zTImeMNLfN86GEMmFFtS5hTENYPrBRli5zFh499ms
         W+BFIBsscic+lO96Pi9zEpYJUwsjYsRtPQHO102t9IWvm9M7S2U/bOGSrM4pHKIMUNN2
         BBeg==
X-Forwarded-Encrypted: i=1; AJvYcCUARkCKNhfpknt3Z80bgf3kPtubdRXtC9+oxTIXijL/rrwZTY9TuqgDN/YEIVgvmBpVWLc+qNaO86tuuwUK@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqpH1UYUyx9fvgZtCLO88P2u+jn7iZnUY8lbnRpOzvhaxn+MW
	g14aBHTUtlXYYT1FJwcfni0MypQzsutOzzgL9ed615I8yk3XoMARJXhNbXN6XaAbmycTOgkreq+
	1qcd4Y/Ezr1oum3XvLwYCAQWY0k80dE8=
X-Gm-Gg: ASbGncsU2l8sW/HfpBWXA8Q8WAt7CDWszHUiWtiIeVJbNjYoVkedFJTF0m62AEnWf9D
	lWWr/4KqWeVXnNXz6QrDKIcspAvAdrtWoAo9VlW3BIMQhiK2rB6GU6sQ45zMEZu/Shclwme+IAW
	uvFIzKqZICSUFhOEKYwUxTdkT9Fh4j6ja7Kc3DvwFU+fYTY/WamPuUHw6RrhSL7XGS5KC09YgCB
	ANglsYb46ELByBYCy4hF9Ktyu/0z6MxQ5fzIp+LiQY9ZNIaGOKxWtRYd1ukUHJ2RkY4DSGQPBcz
	RgU7
X-Google-Smtp-Source: AGHT+IFFtuwy+yogl4Rvq86OO3WJJFALn4fYSGUxxF/eUSawTJbcT2xkIbbC6moZAvGFuUvJ9q3JDTEHYIaoDExSp48=
X-Received: by 2002:a05:651c:31da:b0:37b:ba8d:c0db with SMTP id
 38308e7fff4ca-37cc6748a43mr12812891fa.4.1763654585698; Thu, 20 Nov 2025
 08:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202511201341.e536bf55-lkp@intel.com>
In-Reply-To: <202511201341.e536bf55-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 20 Nov 2025 08:02:52 -0800
X-Gm-Features: AWmQ_bkL8vtVqgeeMqbrJKtpz5TwYXV5_u4GIilB9KlXY8DANeZx9GC7p7CHbe8
Message-ID: <CAJnrk1aHXUimdF2MZYXU9C+t0OE=QsmYuQn7P==gn2OfsPLnnQ@mail.gmail.com>
Subject: Re: [linux-next:master] [iomap] f8eaf79406: xfstests.generic.439.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:01=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
> Hello,
>
> kernel test robot noticed "xfstests.generic.439.fail" on:
>
> commit: f8eaf79406fe9415db0e7a5c175b50cb01265199 ("iomap: simplify ->read=
_folio_range() error handling for reads")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master fe4d0dea039f2befb93f27569593ec209843b0f=
5]
>
> in testcase: xfstests
> version: xfstests-x86_64-5b75444b-1_20251117
> with following parameters:
>
>         disk: 4HDD
>         fs: xfs
>         test: generic-439
>
>
>
> config: x86_64-rhel-9.4-func
> compiler: gcc-14
> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake)=
 with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511201341.e536bf55-lkp@intel.=
com
>
> 2025-11-19 08:42:31 cd /lkp/benchmarks/xfstests
> 2025-11-19 08:42:32 export TEST_DIR=3D/fs/sda1
> 2025-11-19 08:42:32 export TEST_DEV=3D/dev/sda1
> 2025-11-19 08:42:32 export FSTYP=3Dxfs
> 2025-11-19 08:42:32 export SCRATCH_MNT=3D/fs/scratch
> 2025-11-19 08:42:32 mkdir /fs/scratch -p
> 2025-11-19 08:42:32 export SCRATCH_DEV=3D/dev/sda4
> 2025-11-19 08:42:32 export SCRATCH_LOGDEV=3D/dev/sda2
> meta-data=3D/dev/sda1              isize=3D512    agcount=3D4, agsize=3D1=
3107200 blks
>          =3D                       sectsz=3D4096  attr=3D2, projid32bit=
=3D1
>          =3D                       crc=3D1        finobt=3D1, sparse=3D1,=
 rmapbt=3D1
>          =3D                       reflink=3D1    bigtime=3D1 inobtcount=
=3D1 nrext64=3D1
>          =3D                       exchange=3D0   metadir=3D0
> data     =3D                       bsize=3D4096   blocks=3D52428800, imax=
pct=3D25
>          =3D                       sunit=3D0      swidth=3D0 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1=
, parent=3D0
> log      =3Dinternal log           bsize=3D4096   blocks=3D25600, version=
=3D2
>          =3D                       sectsz=3D4096  sunit=3D1 blks, lazy-co=
unt=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=
=3D0
>          =3D                       rgcount=3D0    rgsize=3D0 extents
> 2025-11-19 08:42:33 export MKFS_OPTIONS=3D-mreflink=3D1
> 2025-11-19 08:42:33 echo generic/439
> 2025-11-19 08:42:33 ./check generic/439
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.18.0-rc1-00033-gf8eaf79406fe =
#1 SMP PREEMPT_DYNAMIC Wed Nov 19 16:30:42 CST 2025
> MKFS_OPTIONS  -- -f -mreflink=3D1 /dev/sda4
> MOUNT_OPTIONS -- /dev/sda4 /fs/scratch
>
> generic/439        _check_dmesg: something found in dmesg (see /lkp/bench=
marks/xfstests/results//generic/439.dmesg)
>
> Ran: generic/439
> Failures: generic/439
> Failed 1 of 1 tests
>
>

I ran generic/439 locally and can confirm this crash is fixed by the
patch in https://lore.kernel.org/linux-fsdevel/20251118211111.1027272-2-joa=
nnelkoong@gmail.com/.

Thanks,
Joanne
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251120/202511201341.e536bf55-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

