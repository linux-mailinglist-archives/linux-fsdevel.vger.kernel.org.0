Return-Path: <linux-fsdevel+bounces-28051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51240966365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B61C23167
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B31B013F;
	Fri, 30 Aug 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gBs1Lhfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F76171E65
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025767; cv=none; b=FAUkZXiRwzNd2J259Nm+0kbGCxIdkc2BF0PaFB9VbOhtCBhPCRjENP5BvOPaPfw+RsFqDj7snulvcoo1gk1xGmU+Kytk5DhzfAQqVJZahzrrlUzT8s6G70Fe4vph0VZh6inToamZGXJwYKkNvZQGVCJVbb1jIOfPwefTLMJlfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025767; c=relaxed/simple;
	bh=WhYAWmuPfLB9PmCrki5QGrdb0P+ECZUwzsPzbKY/HTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGDXRLRFCNAQIiqPksr6j5fKowGMSxmmTLb8Ih7Ypxylket7eRDZXxYmaNjSj/cXTvPVLBL/HRtcqV4bdCBG5RgeSJbhECLlDzenUVp61sqStK/VtqT6JC2UnVy2ljt8ws4Iau4G8VVNCWgGqrXnMXtZNGpLjw2dVddJ34whn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gBs1Lhfs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso3070115e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725025763; x=1725630563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhYAWmuPfLB9PmCrki5QGrdb0P+ECZUwzsPzbKY/HTc=;
        b=gBs1LhfshF/wrp8ofKgQFC6bLyjONGrzAVAMfh9VaUKC2OfSLT02K0BKHsLKcTT3lt
         QWJrc3qrVCkvHtYpW6+ZckR7fn81kL5GKfnlGAWyMd6Bip5jJ7UR5L94aAsH+zSp5yBu
         4kma/0wEjUpHipHkaMO6UKQSbOeQ/dPUECmbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025763; x=1725630563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhYAWmuPfLB9PmCrki5QGrdb0P+ECZUwzsPzbKY/HTc=;
        b=EnuJLxxuIJ4TouMkii/s7HODb8LUERrnhiMDWui1c3QhTR8+0HFhpsNFYqSpjKFuqg
         T66D/h15BJRnwrAwDWLKB2XILBnzLyY3MmQq6fN/eu29YL75Xh6A9Sx/qR8rvahFHnts
         nVd8TD+oCnr4r/aYU8nPAoPqDQRmP8kI6y9tBTqYNMPK6I4BjMdsZRFr4udaowCxHVF6
         gVFIbFomGPj/byCeo+0IHQD8yNelm0xEUmiEHMHEbIX/WQzJ0+rPGQTPGOfL7pg4hvGf
         8G9NHF3DWctftXX2gLLJwtOtGHpowpTXPxvQMderZqAFi2NjRnHeOmbjA6/35klheb1Z
         EJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5sKUkRcWfdtjsJUSm02DPrLVVg6Xe7RnMNdBm9GnoQo99c3EW4gfkghaeQI4fqIvfWtO/PNiD+c6OTgXk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6BvG3nHYjvIvlGb7jo4Gm1wH4Nab4vdxAPThk6ccNRfrBz+l
	495+0wfqb7krC5sUFnW2xH+EKAdj4V3K3Xj2/7XzMdrQ3nzm6Gghf7aPTwJtWjaSOusL1rm6A7Z
	G0ZRh+XrsAv5QHnd8Q0yZUOuvYVje7I2RGijKEQ==
X-Google-Smtp-Source: AGHT+IEYlE1kO529OqCb/ytUCO+2Rn5C5BH7HWGq3NbEl9O6Qe0vW+2kBduHAZgJUDbzAqocL3b6DkJF0W+5GkYMnGU=
X-Received: by 2002:a05:6512:b0e:b0:52e:be1f:bf7f with SMTP id
 2adb3069b0e04-53546b2dfc1mr1557562e87.27.1725025762474; Fri, 30 Aug 2024
 06:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
 <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
 <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
 <CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com> <20240830-quantenphysik-kraulen-6ca8cfcaed70@brauner>
In-Reply-To: <20240830-quantenphysik-kraulen-6ca8cfcaed70@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 15:49:11 +0200
Message-ID: <CAJfpegvFdGWuBnJzM9R_R1vrZbVE=8CcnEq4ZLmR5V6iR0vROg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, mszeredi@redhat.com, 
	stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 12:57, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 08:58:55PM GMT, Miklos Szeredi wrote:
> > On Thu, 29 Aug 2024 at 19:41, Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > > Let's think about it a bit more and if you confirm that we want to go
> > > this way, then I'll rework my patches.
> >
> > And ACK from Christian would be good.
>
> Yeah, that all sounds good to me. I think Alex just followed the
> cephfs precedent.

Okay, so please drop this patchset from your tree, then I'll have a
chance to review when Alex resends it.

Thanks,
Miklos

