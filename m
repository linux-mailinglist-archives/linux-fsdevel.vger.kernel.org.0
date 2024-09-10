Return-Path: <linux-fsdevel+bounces-29041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7014E973D79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 18:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29FF1C2528E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567C1A0B1D;
	Tue, 10 Sep 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyoOe2Az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875901940B2
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986225; cv=none; b=bOKAPnF6Dd17Dju8HMDl0hcZbuKzjpPhZG1Q7vzBG/YZq+F1KVHmVvnjl7BNZDKdlfIYfnc+de+8riYd5DUUxRKhrqWXzjiXVHjFzOspKh7M28GNFeUHItAkbrsn8EDI8jfByCeT1grZNKsTgWn4TAweN25712dmkcVQ74QdfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986225; c=relaxed/simple;
	bh=P3I44p7tNC3MlzAjab2i0g6X/YAtV+yJpFzK/hFJXCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmbwYH15atZM+yrMqeTk3qkELivkszNrE5EgWDeF9bmacAUp8aA/HMStPgyRxcKIBQ30/uhFnnvkN7PtxvIE+wPSPsG9uAQuwwNTlaGeETvm31jV+A9wiBv0R94sNXLBzPoeW1A1fRr8zkYP0lpVu/GAIibBkDfoVZnhRwdoX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyoOe2Az; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2056129a6d7so3099705ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725986223; x=1726591023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lATwDGFeJ+qRWtCHldgAPm/E2odi0ls4dzip5e6x6e8=;
        b=EyoOe2Az+3hzwjhVNZH9a1RD8/d5lktEi6l41lTBUak/aPlBJyPwBO90H626DwUmZ5
         7cpDsMRm6iPZ31HXcx13Waz00s+sK+z/PHmk2PV4x8LxTwiF81diUTl+o7m2QLtXDRiB
         XlB9lqPqxyll0yvSom7HTyI2Q0OwOOleuo2gwSAObD0n9vh4tVDBMfLsJqr3dBfN5Vrl
         607bERs/I8yq/ykwbCNAwYrBl1g+RIA5DtaM8ItsEki2f1sxW91Vi/HWk5j073plUHDj
         5GxE2IqmGc2xNIj5VVfpAMs7dGWo5WL3OY1RW/mX5lNdngyVLIQhHrKCsZ6ZTEDPBSNg
         VSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725986223; x=1726591023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lATwDGFeJ+qRWtCHldgAPm/E2odi0ls4dzip5e6x6e8=;
        b=e9RmMuzLLMmNIB+XNx6q3rw1RYThBzL3ZKxwAjbkvLsTE5PzULbWErvOvDseyryz1Y
         2c2Tn/bncSIEilXzV1LY3avbe+n2l/mPIkFTj2rLNdnnjKL13Ds3C99+suBVCv8NXW2c
         ww/TgIgugxvNiQa4et+FNqyaoGcNINrSojFKDDDZG0zJ/8RIpryIE4QakaKwCogSpiJf
         LaGAlIxeldkJ4GuzTABPp3vTq+XzRylN1FZob1aQUpAEmSjnCCifOQkxtvQh82p1QtJo
         MnwIi+Fl5FuMbSq/doD5TNNFdIDKJJzDS3p6OYHqauiozD8rSzouOkP9ravWgMHidJBP
         QQig==
X-Forwarded-Encrypted: i=1; AJvYcCUXTt2RykMv0gPSccqbVmBPjKH6naPpp20u1ZAPKM3hxqMUAeJPKygWL1Q9m8Wdf5MImX3M6M3X7do9Xhfe@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIMFvu8COZvxzyw5JB0tUWdJ/RTUyg1NuGI6OxOPX6Ev2VHR2
	XDYh4pQ7fA1aG/as5q6Fh5Pkcwr+2kd9q2b0g9LcA2oDSIvljJn1NZusXiNTakV5Fmp/Tx5+L8k
	e4aG9Dd9UUgb+F7jzrTePQAgU4Yk=
X-Google-Smtp-Source: AGHT+IHPTQ2JXj6SfhMfrfcG/POT/OFolYS5tLjGM55IyUhR09RlxqVBqzO4qOkZODU36a/D31prVXKsvOwKe7zNexE=
X-Received: by 2002:a17:902:f542:b0:206:ad19:c0f2 with SMTP id
 d9443c01a7336-2074c5e61f1mr7305625ad.1.1725986222667; Tue, 10 Sep 2024
 09:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812065656.GI13701@ZenIV> <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de> <20240822152022.GU504335@ZenIV>
 <20240823015719.GV504335@ZenIV> <50379388-302d-420a-8397-163433c31bdc@suse.de>
 <20240823075331.GE1049718@ZenIV>
In-Reply-To: <20240823075331.GE1049718@ZenIV>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Sep 2024 12:36:51 -0400
Message-ID: <CADnq5_P+xddzv4WvV71sZwXStTg+g-AfwQbPBcbVg9NaV7p_Rw@mail.gmail.com>
Subject: Re: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks.  I cherry-picked these to my tree.  Sorry for the delay.

Alex

On Fri, Aug 23, 2024 at 3:53=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Aug 23, 2024 at 09:21:14AM +0200, Thomas Zimmermann wrote:
>
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> > Thank you so much.
>
> OK, Acked-by added, branch force-pushed to
> git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #for-drm
>
> In case if anybody wants a signed pull request, see below; or just
> cherry-pick, etc. - entirely up to drm and amd folks...
>
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fo=
r-drm
>
> for you to fetch changes up to 30581926c42d1886cce2a04dcf615f551d829814:
>
>   amdgpu: get rid of bogus includes of fdtable.h (2024-08-23 03:46:46 -04=
00)
>
> ----------------------------------------------------------------
> get rid of racy manipulations of descriptor table in amdgpu
>
> ----------------------------------------------------------------
> Al Viro (4):
>       new helper: drm_gem_prime_handle_to_dmabuf()
>       amdgpu: fix a race in kfd_mem_export_dmabuf()
>       amdkfd CRIU fixes
>       amdgpu: get rid of bogus includes of fdtable.h
>
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 12 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 64 ++++++++++++----=
-
>  drivers/gpu/drm/drm_prime.c                        | 84 ++++++++++++++--=
------
>  include/drm/drm_prime.h                            |  3 +
>  6 files changed, 106 insertions(+), 59 deletions(-)

