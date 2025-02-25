Return-Path: <linux-fsdevel+bounces-42583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B54A4455F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA737AE0F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18918C930;
	Tue, 25 Feb 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="n6l0kFEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8F17E472
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499465; cv=none; b=bA3UFRodAejpaj6xfPZeN8YUFzK66AtQ+L+T5Uj3cLj9VmUhc/Q2YITW39cHYWU0OpNlloeluQaQ6WPxoO9Q/MDxiW+iFKo7SdJE0FbmxmSIJM4X0mcqYrchDvqwVFrYztQJBiEgIAfHfro5rYngL0HYTOM9AcxhhC7ZeWA4hzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499465; c=relaxed/simple;
	bh=VTW1IS7i/OjNtZuLaIVXuuL/aHNYaFf4pMMoQV0ML5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6UY5yCpXvbjh5Sbi4OlScOpWy2t2eQ4/vDx1DVJYKv6WSBZ5UXTqEOLl9lETnavc8i5KiNUyEc35l8UVTWlAX5zyil/s6T+lrzlzZ8kYFMxHU+5HTO7BnGqtCwZ9a4sylrWIphdBFOBNzl86vHtu9ezGK6io95KXKcp565kyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=n6l0kFEB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so11725687a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 08:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740499463; x=1741104263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRKvkOnD9TtTQxj3HCyksPuAKJutP4jLh4PJeGhnrRw=;
        b=n6l0kFEBaw1y+hHHRWpmuP2QrM99f7jt54Os7OTwZDGjWpuEiCGMbJfjDRceyhwWc5
         V0pOgELXXjut4AOQ7Ofgys+m7IVOIX4rXStLHTpxlpuMf0lVSfbV/v0IsOloOvoTDbmL
         Nlu2Zn/qqd2TdvJeQO/+AoeH3X09RKEVsW1TAbn+5X4Et/i65/c8U4cwA0J8u5VnOscN
         gUIYbpe3SQQt2KLATEN7VEt+JAZUmlk1muwj7+xDH7wF07JAPArYWnpzlp9EWrLA6jgt
         4Hw1GEW3isNIJVCdyev3YAoWCoZ80208HErHcXHbzzliUlm1XFb9KTwVRxylClvpCkDo
         vXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499463; x=1741104263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRKvkOnD9TtTQxj3HCyksPuAKJutP4jLh4PJeGhnrRw=;
        b=q8VllC2e0JXzO3VH16GTunA9Iyr0EVgDyDfcf79xqW53oVSjcpzSwNveFdFLuRCZUm
         LfpffWFc7AUgjlMQg1krKNw6c4+U4wRnHZS/+c3pdQJbILk83KFkcc88qS79ODYI8gft
         XiFd0tZbfeoiQzMJil5mVrrDPx4OE/px4PwgZ94RrK56QBHV0IwTu8T1f2yv2LbVQB67
         QqBzGU/30IF93mV8fHwB7q2AguiLDzO9YsOZAqzNOqMXlPMMHgOoO0mWueJWJgqzZOJK
         jiqtDY7r7SgxCALoO5xqmRcclkLSKJ08/H9SiMlLcDoaoQdkgGwlF4IGnnorgrnGIplI
         8/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVe7lm7KYSnt/T+qJ8/i7mFDoAMq2tInLRooRWkSGpg3Hfs/9YAXBbvcKibM1mPwu/4TMK0O8VKeUlts8+R@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk0mL7FDnB+cDGf2AlmbT8TJEM8JSCeOVv1MD3y3vexrGsVrR
	VzTeHpkdh4uBwxNWy50cZSrofsh0QJYGqnLX7oyfIuAaJTTkcS/kC8VZqZLl6JKUnLaY7AbHyue
	WCeuV3wOOV2Qg9gMeKXirN7J5qcydrsIWClkLAFgaUFDGqL8O6lb1SEtPeHHPTetURKHlU8nW0F
	wkUeKIJDUzRSw76tfIXoLPmcVhCdNW2ywhUAfDamF29kJPohFiM0c+8mzcwB7XmzzM2agCSfDdl
	ND0ebAToSPtkgIEjZIEaYkrstRkyKPes8SMJgCxsM9pxX2VtrN+1SboknpnTGelHudjsz43DrZC
	c6+8c+bKIqQVqy65Kib8g9ICqxQrhAfAKAwMqGZoB4SJ1y5Uz+K0x6WQdym9dJTCGWr+8wD7HlR
	ysmp3wl8rYf45Uz1D1pvhG8X4
X-Gm-Gg: ASbGncv0Je7bM/OmJu2dsV7PcP4CGitQbCBCeKhHccXtLlGt7xZ2pegI3OjMYSn+Iyo
	s87hOF3WQFzNAaqGJmKib7GUgUma1ME+yNVCoDAx1Dw4SKZtYN/Ks0Pu5kdq5mVFjI9e5AKzZ10
	qPWv7isRaZgx8oIPpJmrhrv6Kz
X-Google-Smtp-Source: AGHT+IGyh1jWG7kvXPe8EQRd9GcQQNFYExzpyCfQNpHjeoLN1FUP/xzECarfl4fqw7bw9I5wDY/K15SD3y8rUQxdngU=
X-Received: by 2002:a17:90a:ec8d:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-2fce78a9aeamr31654991a91.11.1740499461044; Tue, 25 Feb 2025
 08:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <20250224160209.GA4701@lst.de> <CAKhLTr0bG6Xxvvjai0UQTfEnR53sU2EMWQKsC033QAfbW1OugQ@mail.gmail.com>
In-Reply-To: <CAKhLTr0bG6Xxvvjai0UQTfEnR53sU2EMWQKsC033QAfbW1OugQ@mail.gmail.com>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Tue, 25 Feb 2025 13:04:04 -0300
X-Gm-Features: AWEUYZnSwsts3AlnyMyPnDoZIO5Ek4gNZJVOo4qq2rXtoP6hhryN1CYaV-mMojI
Message-ID: <CAKhLTr1HtH7gnSKSE+8LR9+MpNGYK0PYr8NGSTav-0sgf4y+gw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 1:15=E2=80=AFPM Raphael S. Carvalho
<raphaelsc@scylladb.com> wrote:
>
> On Mon, Feb 24, 2025 at 1:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wr=
ote:
> >
> > On Mon, Feb 24, 2025 at 03:33:29PM +0000, Matthew Wilcox wrote:
> > > I don't think it needs a comment at all, but the memory allocation
> > > might be for something other than folios, so your suggested comment
> > > is misleading.
> >
> > Then s/folio/memory/
>
> The context of the comment is error handling. ENOMEM can come from
> either folio allocation / addition (there's an allocation for xarray
> node). So is it really wrong to say folios given the context of the
> comment? It's not supposed to be a generic comment, but rather one
> that applies to its context.
>
> Maybe this change:
> -                         * When NOWAIT I/O fails to allocate folios this=
 could
> +                         * When NOWAIT I/O fails to allocate memory for =
folio
>
> Or perhaps just what hch suggested.

Matthew, please let me know what you think, so we can move forward
with this. Thanks.

