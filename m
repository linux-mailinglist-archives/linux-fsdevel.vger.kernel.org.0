Return-Path: <linux-fsdevel+bounces-27607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62BB962CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBCC282261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8F1A2C32;
	Wed, 28 Aug 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN3m+9vT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86583A18
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860296; cv=none; b=XHeTeLrOyjvOaohXITZlCbAfpoPDRYBJPRuZ/4LIQg9rMpUOuq+5ryqYfnrJwXozPz2CS2XgtDdk4Xr0FltadmeJFseK/1gnsNdVr6vwFfpsqgRI1KRTjjl7HLmLHWnfbaa5CUMBoj1tNfXVWCDT6y375h9ZLzntPRhxC+C4fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860296; c=relaxed/simple;
	bh=OFFj1NEy5g3i6vGCQ/1G2WW7fCe1HDsr1xX6gfPYgSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9o8nWHGPLGVJMeE4Qv3NAY+2qhpjvbVPpueaH9DKJe021hD24e33lt7TedaL/n8wCc3jHs9lMOtwxWsmV6X3iIw4sTBPsj7FZ3+sYBiW3KUmJcGt6Zc2q7zWjiLueHuaZLrFSI2CTgm4DV8At4NMOJID3EGkstN1zS6/jJueSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN3m+9vT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567edb7dceso220621cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724860294; x=1725465094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7ms7TuhcUGP2Kd6Iyh+E63IDbeeFTrHgWyCubmUSMg=;
        b=IN3m+9vT6u83cfoedtTrw9F5vjROOZrtJ7p5UB5qqihQ/Rgm51Xf8iOgmJTV0CwpfG
         rKUPqEMrpEOfYHj1M0vUE9fMqrkxCtXCIwyaWg2fyrd+dFAxk9cstrB3u1OEKLQEgWQp
         jHAXh86T62rw4IFsLR9uBAgZb6iN0JroW6UPy/dFLIfdmPaeDXOQzT1F9SYIaawzUt+W
         /N6PL5LFTh/i5+ZkKKsVNqgRRA8eF3Fi5WitOqAWzcDR7ifcIciI4lEVbAquaCl7GwYX
         UvN6gpGj76Os9T+3iPGXUkOJs2m97PTjqJqFis38Y4y0bLKIVd4D4cyN6XzkbTsDM/pc
         1q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860294; x=1725465094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7ms7TuhcUGP2Kd6Iyh+E63IDbeeFTrHgWyCubmUSMg=;
        b=GLZ0PJ1MGHMGsGeRywt+QcOxzA1T7A750ljklVZoBuHG8ljiJ5HwbHgkxBaeHrRhar
         nRHxpmof2GVwcvpdoOLjP0d5TV9ZM0z5C7lmgDYBuVh1cW0tuCf1lmbsDRV6B3bQhStg
         aF2kOLcnlvHFhWudGH/WgeHaX2+UmFjfjm5hooa/Owpj9ufag13hpdu12xiKnYIshPHL
         56VFukVszgfzS/8o06IQ08aqdvSEjIK0mb6A48zEltiGZUzKm+Qv+XVKp8iW9+QAAAkh
         hDrZP+8WNUNIPHXgV+rUxTMmeONGeM50t3HEo4YMR3KLb01tTRH7Us5zOsChl1+jczVL
         /fUA==
X-Forwarded-Encrypted: i=1; AJvYcCUF3KJ2Bg8eTqXmY5gnIacndGjgsO/hC2Zg9/J9R2yrV1/nvAqXOMiC0SJUiccCIsTonLCDMgZmdCkuF3UB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Y3/k8lGBZUeuwQADnPNMpzqzleXH6qsZ2dxX76u5VvICMb5/
	FQ4F1GVM9wRIfk/ms/rzECXzIIs8Lm0EgnTXOK6jigb5AUQr/+STtFW5eNj1xjoQ8AvdawIeJPo
	K+V0wErTvInVFfkIbkVfLyQmgzsU=
X-Google-Smtp-Source: AGHT+IEGoKWC4F/OJCQkBY+n2LoGZU9WkWOA8kAbisIXzU03+K4zrmT76a+W6VlyWt3PPU/6qDA5iMrh5CsysucEsn4=
X-Received: by 2002:a05:622a:17ca:b0:450:3eb:cb30 with SMTP id
 d75a77b69052e-4566e6a81f2mr27575271cf.42.1724860293793; Wed, 28 Aug 2024
 08:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826203234.4079338-3-joannelkoong@gmail.com> <202408280419.yuu33o7t-lkp@intel.com>
In-Reply-To: <202408280419.yuu33o7t-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 28 Aug 2024 08:51:22 -0700
Message-ID: <CAJnrk1Y3piNWm3482N1QcasAmmUMYk1KkoO9TyupaJDBM8jW9A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: kernel test robot <lkp@intel.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 2:52=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Joanne,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on mszeredi-fuse/for-next]
> [also build test ERROR on linus/master v6.11-rc5 next-20240827]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-=
add-optional-kernel-enforced-timeout-for-requests/20240827-043354
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git=
 for-next
> patch link:    https://lore.kernel.org/r/20240826203234.4079338-3-joannel=
koong%40gmail.com
> patch subject: [PATCH v5 2/2] fuse: add default_request_timeout and max_r=
equest_timeout sysctls
> config: arc-randconfig-002-20240827 (https://download.01.org/0day-ci/arch=
ive/20240828/202408280419.yuu33o7t-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240828/202408280419.yuu33o7t-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408280419.yuu33o7t-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> fs/fuse/sysctl.c:30:5: error: redefinition of 'fuse_sysctl_register'
>       30 | int fuse_sysctl_register(void)
>          |     ^~~~~~~~~~~~~~~~~~~~
>    In file included from fs/fuse/sysctl.c:9:
>    fs/fuse/fuse_i.h:1495:19: note: previous definition of 'fuse_sysctl_re=
gister' with type 'int(void)'
>     1495 | static inline int fuse_sysctl_register(void) { return 0; }
>          |                   ^~~~~~~~~~~~~~~~~~~~
> >> fs/fuse/sysctl.c:38:6: error: redefinition of 'fuse_sysctl_unregister'
>       38 | void fuse_sysctl_unregister(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~
>    fs/fuse/fuse_i.h:1496:20: note: previous definition of 'fuse_sysctl_un=
register' with type 'void(void)'
>     1496 | static inline void fuse_sysctl_unregister(void) { return; }
>          |                    ^~~~~~~~~~~~~~~~~~~~~~
>

I see. In the Makefile, the sysctl.o needs to be gated by CONFIG_SYSCTL
eg
fuse-$(CONFIG_SYSCTL) +=3D sysctl.o

I'll wait a bit to see if there are more comments on this patchset
before submitting v6.

>
> vim +/fuse_sysctl_register +30 fs/fuse/sysctl.c
>
>     29
>   > 30  int fuse_sysctl_register(void)
>     31  {
>     32          fuse_table_header =3D register_sysctl("fs/fuse", fuse_sys=
ctl_table);
>     33          if (!fuse_table_header)
>     34                  return -ENOMEM;
>     35          return 0;
>     36  }
>     37
>   > 38  void fuse_sysctl_unregister(void)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

