Return-Path: <linux-fsdevel+bounces-33742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601949BE56E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909031C2177B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC901DDC0F;
	Wed,  6 Nov 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L1Rb7MuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25918C00E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892045; cv=none; b=rlGX/wBc2qEIh7ABqQosXZ8JlNWXwiUkGKERj+q7TdeHzMe9wVoTTAWVA+lYTxudHSXxxUlY3OJgaU8JLUyekfBrB2IaH5ihZyQNhxkC7Djtp9Jghp+D/mleV8rSVHhWLQ0fL+aFuEd6C4wPMobtogqd6b8tNfnd8LGhrG4vM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892045; c=relaxed/simple;
	bh=DPJ62CAo70tPzsla/d6FuvCexmrUSWA/iy3HPUrhiNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p22i1+iYrQwN1u+Tie4CJD+R2IRADRzeR/lE8zD4dqkYrFUVu/McuavzDivPKPIdtzEX94zmANtXeCir+7xuKkzDbjz2kfUwKrCxy1AyiraECHLwJvasWms5T5RXMjr3YwtgLrdsdJinzBIKjpXDXdhCV7YZH1c9eyzbqAefMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=L1Rb7MuH; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84fb1225a89so2287911241.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730892041; x=1731496841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPJ62CAo70tPzsla/d6FuvCexmrUSWA/iy3HPUrhiNw=;
        b=L1Rb7MuHqizu4at9RHb9C1Kxz0vN28WVOzhfshe1Y8q80guTG9QQzWj5APqMlPj2/H
         fTZB0QAzmI7ypXfU6d1Lqo7xY745a0tKQ5LiiY4yhJK4qK1OF5bMR+i2zjQVydb5wXrr
         c/UjbmSINfFzIuFyQ54Gd3IWr8xix4eQfSz+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730892041; x=1731496841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPJ62CAo70tPzsla/d6FuvCexmrUSWA/iy3HPUrhiNw=;
        b=nB6iTKKWH4Z3U0CJ+wugyhM2Mve20bNkLriVX6dA+j7aDSpmQLx/l/wJ8VXoc1Ohtz
         LX0V7DlWQvdrgb0ldzTEUkGn3TfTvg+JuGuemIORmggqxAXkUgLurHeRB+fSPLvJDdPG
         5HfK8uwQqTzD3aYn3ObHRI8Ixy20NFZeWVtNDT7tf7d2hCaoleaOv640nUGv7Fs2sqVW
         In8p4sFAO5VSycutEcvrNOHadATm0heUJHmKgmMakpoKpnPFPgEcPO+a9tDFM6zwoXd8
         anLocr1/689vOFKlwaB0jZfGJk8Z/YQCIDw91+deFONwgY5QREnz9EahF6jUNfyx6vrH
         5j1w==
X-Gm-Message-State: AOJu0Yw6tweCoNBtQCJaMnkk5iXUGROZz2ycxhcp/C8MF+/bdW7A62rj
	y01UEMA5WCtzuasA+pf8156Gk0K0cIApqeSoGhYKIStVWCz2yntVd9dkJuhmo81kyGlGqVFHVA9
	ZfHDu0a7pnMYTrvupn2femPIgH4qJOP6RKl/AjA==
X-Google-Smtp-Source: AGHT+IGjiGBWlN/fAJKf+yEM4Q4VergK6/4ywktxZxlrocDo603earPPuRWFStojX3j5t7+GsZv7+TeyaD/R0pe3xMs=
X-Received: by 2002:a05:6102:3753:b0:4a4:9363:b84f with SMTP id
 ada2fe7eead31-4a8cfb25e4amr38513570137.5.1730892041208; Wed, 06 Nov 2024
 03:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Nov 2024 12:20:30 +0100
Message-ID: <CAJfpegsgegiqM4i=Ev=8WmB01KB2Dt+M5bbFLbc+RTCA_HqB_g@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] fuse: use folios instead of pages for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 19:21, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patchset converts fuse requests to use folios instead of pages. Right
> now, all folios in fuse are one page, but a subsequent patchset will be
> enabling larger-size folios on fuse. This patchset has no functional
> changes. Any multi-page allocations for requests (eg ioctl requests) will
> also be optimized in a subsequent patchset as well.

Applied and pushed.

Thanks,
Miklos

