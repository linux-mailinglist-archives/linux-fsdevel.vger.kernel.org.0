Return-Path: <linux-fsdevel+bounces-49079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A3EAB7AEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 03:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C3B17DAC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370D269838;
	Thu, 15 May 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="s03GqgLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA422D4C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747272185; cv=none; b=mCqpZ1eB6hW/VHdsx1BNqov+CWQPuXCcEPZ99b1ivx+d6YSgI66Sq7NBygzGoKvLZZwbOI41sL/0PYIEH3fJJpjSa4FmkbW1xrS/G0D2rgyf0dQ02aYVIaX9GTyrKMA39Kfa7I+tzxxos/bD3vdsQkMbQgiNI9+eC4tumUBnz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747272185; c=relaxed/simple;
	bh=pGj0cEG5wc65zR8K0SxXkU2TKD17QpcnRbobuZ2pGe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihkFApTanAVNsUI9xnncO8Sgq7TG2AVbM12O3r28F+XvYqRsC3nlxsxnWwcQd+EinpBpBcJBXws0Xw+3eHKghF3WO48JagJl6PwqVlGonarOhH6smsuI7yyqr0rbl6exlORVK74fj+mi/0S2Ehd3t49oJ9xOpkAH4M8PRGvAB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=s03GqgLW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54fc36323c5so1722472e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1747272181; x=1747876981; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGj0cEG5wc65zR8K0SxXkU2TKD17QpcnRbobuZ2pGe0=;
        b=s03GqgLWydhoHBGZy+LbMJbHU4JizUc+29DVve7mKQdSHcJIdk5qXtmPAAzhC4E8NH
         XiQ3AvuHiQaKVVHyDxBmjZzOtK6b4vG9nYRWqhMJhnfs1j9i7DWNA47igGjDgIuYKaQy
         csbyOPQaQWDYND0d2ta0wamOp+6OGSypLt8JIvIdDiWk1zvRS2A7lB1Y/MHifvHfKba4
         QnZhqvzvu7t7ot4Js1Sei6tT+Gdn0uGlWmTKZV7/J90EjIqC0utLgCZ73gw42vSSq7sO
         RtKLGN/B6K/r1tlJzdL96nsnfRmAKiVAFtovh7/kiw5s6J+VOp4hkR3d89xUnnB5Gg/u
         8JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747272181; x=1747876981;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGj0cEG5wc65zR8K0SxXkU2TKD17QpcnRbobuZ2pGe0=;
        b=dWATpprshA3lIRAf1zG66CVGeto47EsiC1saxBXs2Nfvrwj/jlCKsIpuD+8JHwqFWK
         LuLNjfSNPxIbgBr1qxThnwsJ0H/p5Vsam/8IS+k0tjRQhjSA1RjZxmQfjCQNeJUDKoHR
         DBpzBIsT0Q6n443TabE7SBTRPX/2yAUgcPLNQ8V1jpmGJ50WWO9Bo4YvcjWLAGEK0W0E
         ACRZNQbGjxAhBaPu9/xyrOvtD+xaYbTv+SMj1GfMwgxgREa/1NJ4BtbAUS6ejDmFykJv
         Oedpv7x35fIKT8GErvwuC2X/7yAePwAI+QauYdp2We614mCxC29wxwzwBkLShHbSXy+w
         A3yg==
X-Gm-Message-State: AOJu0YzNZUTmQmOwlD0LSzfZ7u89XApttViqXZeAzbRjFax3hnxHd+O0
	/vjR8UQpjC7m0MoFRVqBnaZnTVr9jeZAEvdDMYtbCunspPunTKQN3KE+d2jyR9I=
X-Gm-Gg: ASbGncvM1Zg1wJUMW2zh4hAu+OTouWHIS3BdcDlgVayQ2OVXtDDjR9gIzgQCOM9RRqh
	FhyUI8dxCJKhENkSqnregOXtY5FTznZEd5qbkGqeDUcmpQv2AAqMkPdJ5hIp9inUQL8w5WEfsQc
	KoFb9kBHC30KP+iGpJsoteO1GwFrZB6m21/dw9WW97G1Xh+MWLOlPY4X7iPJbmol2Pd8EHm+Gib
	QuYs20RJbtlu8ba6ncUA2xrS0KAJJdWmaULg+RO+Kribou7t7U7zvNVedZ6Cev3JQHbXl313d4E
	vydx32JpN8o5ZV4+HdKxkyoidulrWAcMuYHc24apsONBPeqpY+djvA==
X-Google-Smtp-Source: AGHT+IEinenTYCOal04RXE8A9a0KVTDkVV4cPi1jtVXojhXDm6vALnC5HQDQ/gSdC3zTEm4/4BHAeg==
X-Received: by 2002:a05:6512:6096:b0:54a:cc10:1050 with SMTP id 2adb3069b0e04-550db931e0bmr514727e87.15.1747272180380;
        Wed, 14 May 2025 18:23:00 -0700 (PDT)
Received: from [10.24.138.144] ([91.230.138.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64bfb55sm2453549e87.180.2025.05.14.18.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 18:22:59 -0700 (PDT)
Message-ID: <6a8e52d5019df1af7fd99dcf42467ece28b5c858.camel@dubeyko.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= [PATCH] hfs: export dbg_flags
 in debugfs
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>, 
 "glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 14 May 2025 18:22:57 -0700
In-Reply-To: <SEZPR06MB52690DEB5593079DA5236655E894A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250507145550.425303-1-frank.li@vivo.com>
	 <e87e0fce1391a34ccd3f62581f8dc62d03b5c022.camel@dubeyko.com>
	 <SEZPR06MB52690DEB5593079DA5236655E894A@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-05-11 at 10:45 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> Hi Slava,
>=20
> > Frankly speaking, if we would like to rework the debugging
> > framework in HFS/HFS+, then I prefer to switch on pr_debug() and to
> > use dynamic debug framework of Linux kernel [1]. It will provide
> > the more flexible solution.
>=20
> I'll try it.

Sounds good! As far as I can see, it should be pretty simple fix. And I
think we we need to unify the code for HFS and HFS+. I am considering
to introduce HFS folder in include/linux where we can gather small
duplicated code patterns of HFS/HFS+. However, for more complex
duplicated code patterns, maybe, we need to consider of introduction an
fs/hfs_common module or shared HFS subsystem.

>=20
> By the way, I plan to export disk, mem and some statistics related
> information to debugfs, just like f2fs does. Any suggestions?
>=20

I think there is no troubles with it. But could you please share which
particular stats would you like to keep in debugfs? Which in-core and
on-disk objects fields will be stored into debugfs?

Thanks,
Slava.


