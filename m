Return-Path: <linux-fsdevel+bounces-35173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9589D2067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 07:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBBDB21A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9513B7B3;
	Tue, 19 Nov 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+rzBn1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5A4A35
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998722; cv=none; b=bFxhlHfqHO/Nt46Sm+g4tm0izYt8gp9nRRspYQBXj0+olch0yEWAkyThCrfs+IlHYU3qHdzfqa0EZu4c0jnp0HV7PerY4S+Ob/FnYm7A+tM+MfjXhD1aRLV6pAZGj8DqCVQZh0TPv/yHUu/HcIqozUrPx7Cr7FAwxXF7+6QtF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998722; c=relaxed/simple;
	bh=eMMP5rz2BE42egv5BZe9LSGHOhRMuAI1yJxJ1dG22wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLXkMsKUS16HMA4hlgx97ZV7Ya0aL8r7tPtPbutpArRIOlP2uI7w8ppY4AmnX1AOWMjGWCaByT1uH8jjtgM1ykNL/JL2pzW/0HZ76Ft5ce7xVP7ucqx70mrx+GIIzkH1NnbjBiX37A3mKHjlGcC/5/OHsh7yZN+PBoKfV0kyebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+rzBn1y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a850270e2so546433566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731998719; x=1732603519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDmRB5ClgJpHFr+fT43VEyIex40kGdWvjXQFf2Qtd4I=;
        b=l+rzBn1yXV6A7Id32PSssi1DmLCD+gN5frdoZg64URsoh4peRG0Xai2VcA91zAeLvQ
         1K/9AcxZJksYEtfTjrCQH52TwQ77imCoVfhuTrfwRmgZBXM8hkebUTsjDGxAjjHgM8yb
         f0y0HK3h4omIa/kZocosxQo6aFovM1N4dah39fmIj9G/5g8liieTmTbpPMN+a8G6hwXd
         GcJfxnic0vq//wQQLFMIfFrNqx/f+RSvyjGjDOg6EAscaP2gMmb3dMZRZJSHVVmZ1Xr2
         MXGfFh/pV2EGpnOqVwC+cUdESGkO8wEu72VIHrvH2XAAYv11PRNxkhdNaWBn7g0sSXt2
         vMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731998719; x=1732603519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDmRB5ClgJpHFr+fT43VEyIex40kGdWvjXQFf2Qtd4I=;
        b=JaJLlE56WVYH39BCd3/MhNd1pIkBf7jcJRVbdhvQpS2CEz+05fqO/+u0ZWMd0HujAd
         iI1qwfz7OdtZz0ySFeiShPt/6IgVN4Ijwp+5iuPKqR71541LmhVsOX1wxmR0/9U9Ynrc
         n+Q/wGp5MIoOELelPF9grJ1jBvbfufyb82c80v8jaFbPtTzm422xBXZBc7QsH+9cHYNY
         WOW8D87fW/PzS7WpBqN5QA52KzmoMjC/rFOK6J018yezCUA+rQ+eR+iBpeL27ypeKu9G
         r79yaORgr7vWDqabbkQdpQewrSsUgwMiTqZzOGWluRf4u8kaO34hOVV48wmUCsIGch7K
         HGvA==
X-Forwarded-Encrypted: i=1; AJvYcCV9hcEvWBhLfBnlxtM/uP64HIbGcYJ7E7Lnl/ZhWaERtQ8xYuEHf71S4IPrFEfsD4Sh4hU/CkgfCkX9X9xD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Z4wxfabLkPXiw5EdiOvt01KVTsPEZE6PERDUUbeguA22mkQ3
	Sv514HAAL4aIsI3OPtuJx7N2DmPadBh6DSMxG+mkE3vSUN01dS8uu/+3vugOUPA1eNUD84XvlkM
	ZcgozmGSM/6m5aq5swHWuC8ffKFk=
X-Google-Smtp-Source: AGHT+IETr8ZW3iGSUCpNPmZjIUyx01m4KQKrxOLyiCOAZZMrYeYdHbDlG7UwmhPFIsJrU4mdGlPKR83UaJJmZp2OueE=
X-Received: by 2002:a17:906:ef08:b0:a99:3c32:b538 with SMTP id
 a640c23a62f3a-aa483528a6fmr1391898666b.42.1731998718649; Mon, 18 Nov 2024
 22:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411191423.eEl9yEsr-lkp@intel.com>
In-Reply-To: <202411191423.eEl9yEsr-lkp@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Nov 2024 07:45:07 +0100
Message-ID: <CAOQ4uxhsyuyd9=iJ1GLYXPrtfUqsdWaxObLUGngKV8bwhbK1-A@mail.gmail.com>
Subject: Re: [amir73il:fan_pre_content 19/21] ERROR: modpost:
 "filemap_fsnotify_fault" [fs/xfs/xfs.ko] undefined!
To: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:25=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://github.com/amir73il/linux fan_pre_content
> head:   a2b4aa2a63d555f7b7d22f6f54583dff35a1f608
> commit: d3e0f4f0a419a7012bcdc60530619ba2cdf96e85 [19/21] xfs: add pre-con=
tent fsnotify hook for write faults
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241119=
/202411191423.eEl9yEsr-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241119/202411191423.eEl9yEsr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411191423.eEl9yEsr-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "filemap_fsnotify_fault" [fs/xfs/xfs.ko] undefined!

Jan,

We need an empty implementation of filemap_fsnotify_fault() for
!CONFIG_MMU to avert this warning.

Could you add it on commit?

Thanks,
Amir.

