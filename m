Return-Path: <linux-fsdevel+bounces-27871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B696497B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E43B2A635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548DA1B29B8;
	Thu, 29 Aug 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YxyICWLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097291B2524
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943905; cv=none; b=gAiBi8PKZcsK9z8puHUIDgooCP9gm6IXT1GiaFbdiG6/iyTdJCE6+uPIKawwwodprR9iNBihrM/f2J8PXuUuztohNc4gr8/X9KRUQ0eSn4BbLgHXRWiwxTITyz7Ezx6DDsftGXYxPMihD+bo6Lp3JEX854s7H14pAmKQ/DGHsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943905; c=relaxed/simple;
	bh=DsJ4bZcfJKBvtNEIQaWZaz6y5C2wq+VgDv3ekEf69NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAEI9RLlC6dXbW3o5VW9fJ7H6ouGi87pK94zhtIxtyxfLIr/hFCTgI8gqaBlFYl3u8VgnPxUQudJ4r0SiIpUtGd4UjoKzTwnotKfeU6LtX2q0c+pfTB78YUlLexb2rZesXnDe+M0jmNCt771q7tMNuXJrwmIsuehZRX2wF/YLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YxyICWLK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so884220a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724943902; x=1725548702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTKBAD4B1Yj171/JDWLju2+zytOazWI1J+O0ary/GQg=;
        b=YxyICWLKsTycSZ+iAqjFHLtR1pdoao5Uq5llXE9mIIUmkWmsPZbxIwx/eH38JcMSr3
         WsXF5VUz88E89MJ5DAlAVQlcGIwydHfVEHe73Ky7Nwyaw0FXwF+d+G1M+IcYfQt/9EXf
         qvD+zUCHdt0/KUjj+LzhV29bP/NKOPeTDNoEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943902; x=1725548702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTKBAD4B1Yj171/JDWLju2+zytOazWI1J+O0ary/GQg=;
        b=I2hzfW7OSF356RpBii8DLcoxcYaCnbZO6R/WVisjbfhV2Zcn4KvkPQPlD3VqHciGWu
         2lzGkSavayJYPEiAekdz7jaUW/+rzDpnMu3eI+A2kVOcrH4JD0XXH0QT7l88p0uGcie2
         H4KsQaSa/Rp8yBv2T4VH9WoXaOW+30ImcPwMdQDFRz7klWBWiz3q4av11igUzcG0U5XQ
         nb+tZegn2uVlgC2Wfa3VgYx67I5gtuqNbpnzd0EadNCdTVJ4TS3lFGUjHP8MDgRLOjnj
         pPr2Vz8eJaANxk+g+AktI8IlplX11Qeq/YkXpSb0zT1YxDt89Z1FEv3QrvLfKWUwaMVP
         oUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Xz0AALAWkrAH0cBCrFcdwCUt9COplX4dDsoRozaOJPbWcOf/Z+Axacusk/mP5zwHcCd7qBwYhkSWND13@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuaVQx8tLOogU3aGFZFroW10xg1g4twVrJKduOVlgXy2k/ur5
	5HVHE94MUfB3cBapao/ghNGOIyvU7b7cd23bO0jSGri4Z6ijbNPrDlJgCrbF4Jd4v2KvV5vy1Fq
	IHWMNobRWYUOOujOGdTT1sbxH7y8XFrAWHDLAIg==
X-Google-Smtp-Source: AGHT+IFpGowd+Q+ZG451Q3joT2SLkB4g5Q4YqUCCmWpN3XktmKBsb64iumCrsbOfqFfuWLzE0N3Udyal8WmTI229cDs=
X-Received: by 2002:a05:6402:2550:b0:5c0:bab8:7910 with SMTP id
 4fb4d7f45d1cf-5c21ed96fd6mr2853555a12.27.1724943901113; Thu, 29 Aug 2024
 08:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
In-Reply-To: <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 17:04:48 +0200
Message-ID: <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 16:39, Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:

> So, your point is to set uid/gid to -1 for FUSE_{READ,WRITE,LOOKUP,RELEASE,...}?

Yes.  Not sure what will happen with those servers that check
permissions based on these values, but my guess is it's still better
than sending the unmapped value.

Thanks,
Miklos

