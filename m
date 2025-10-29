Return-Path: <linux-fsdevel+bounces-66317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E4C1B87A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAFD1887517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D92DAFAC;
	Wed, 29 Oct 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8pSUfFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A572D321D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749868; cv=none; b=iQ1SMhLi1cQscBm5xmO5RgUSAWsSywy6NyxKvq9J278oXjB8jzPqE4V7VGgy1vtwi20k4Nc3/cPNuaJBU0XBfOrruwiEBS6r52o5Q77pVFGPwiaMlX09KezzTa4RVvL5llqctEK9dhFICAVuUxtVugh00CqE41hPaYmSt50YnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749868; c=relaxed/simple;
	bh=sW0fcO523ng4pGFY9aQJooiGcb2xLELRhF6pvb9Out4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZn2ig1cU1VFwxEuDG41aYELizkea3W4vOxFpqxzuFYMVT7anMB+VOe4zy7Kpx4lW06IYFMfGAYopRf34NP00/torGD04Rwh1C1SCINuc2Cj1Rh9pXDUBsAyqfHAf81zc+oGWYarVj7bB2Kjn7dFlED3E5cCtJhcF0EuzG2baBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8pSUfFi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ea12242d2eso340611cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761749866; x=1762354666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=P8pSUfFiXDPDvWHmEXuinZOCNdErarnp4POZ0SOm+Nft/ANiXqnl82D1ltOuvaxP2s
         RH0K4kWiEOjHoyP3J6XC7Vv3EFYLm+P9ul8yKQuoRy8/xTCUNl6MSBeb+CmCWHSPd3Sb
         JcTJlOBlIgMdppqp1oVg9pEjoUbvzy6XrklLosfX6s5Kb0Cu56C8gBleV0aVVFRKDPe4
         sJZU483KkhPOrqeiIjJFnj4l5NNwWSxVfdReZGU7PYWWlG3Kzti3eXuhCBOq86OLRrlz
         7wCz5egdwKvC6zV5PHkrbqNTTZPrHe55bfZvOf9W1rE+KJAu9Rm6qI+EOx5Ke3jEFoDT
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749866; x=1762354666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=LmH9S31g+wV7ZlQ6J1zhp4ETzMBuAv4s6k1J68/n8QOJx3prVPQx00lyzveCpnmySj
         rAwDER2LTY5IPaNEFcgCKNTe9N1ydpwU+HPGkhha60AEEZR8kBXWkk0E4M4smDzHkBCt
         xB7hhAltDW9/HnFtQ5Ho6qcBdzreQ2rkFsrCVkYg9y2xRZoP/RHBLj3O/9fU/pRP/eKh
         LWjKaw20bERfNiFO4MLtOO09Oie7vUWtZIgskhbJ28u/f+7W5ScTByUv1nLu+1xEQf/4
         /9TYpOvPwprxM0qSwZnF4UGxqWLOui8D2871cNIL3iXAiBpMUiX1kFy731UD6yBH5pfR
         FNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVns/ih8tKpe5cBvOakux6FckgpJE/H/4HQif5hx56i3/aMJIN9dtpOx5Pk9rrgL9BYzHLqQFK4O+Nez3Qt@vger.kernel.org
X-Gm-Message-State: AOJu0YwNw67mZfbAwOfzcGRRFE9SlpmGwEM61kC3juWDa9xhl/WTPo8a
	n/M7Gdcgk2onkUP6yUTobFSYwwQMfWNiPRXGwW29uWEVDyDRBEIlxKgrlM1iOnyeUN8d0ztj8q+
	mrF6bAs71ZICH3TdsJq/FLAlXayvDYA8It4Vx9gGU
X-Gm-Gg: ASbGncuMO+leDAJ2ATCW71zEJ/1CLZ9q0WWDItF1UdzO4M1at+7RxdMwW1oTg4+44JO
	c8EYZNVDFIpNMcbRE1QokPkadxX7j4vzgmwhCryS3RSBUDrc3D/zG7VujesKB09h7c0zSTf7dK0
	vrfS8upiM+AYcKJvoebsd0RT+nqAW1OjWhPQmrQ1IJHtym3zmx4T3x2GdpXkuB8cFtml+7fACK3
	GhtdYgK9KOEsdvGCEeuYWZLmV9droifoChbOwnURpvNl6tXn39DaVklmvVyNHN9C5GDwuDwciyX
	aRLc+MMgRq3OOv28xHjgDe+ppg==
X-Google-Smtp-Source: AGHT+IHJk1Z4xsEEl6nhEK364d+WNrqkglBzi78RQdt59uckdBYZ7htllhsIgZwt9bC5EN7/2oXDuEWCE2gLHAXeC4U=
X-Received: by 2002:a05:622a:11c8:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed165a8088mr6994811cf.13.1761749865638; Wed, 29 Oct 2025
 07:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com> <aQHdG_4yk0-o0iEY@infradead.org>
In-Reply-To: <aQHdG_4yk0-o0iEY@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 07:57:34 -0700
X-Gm-Features: AWmQ_blGYfe_lFn4eY8RCcDjRQso5Ijs05VisPx1zbBZudE9r4ISvY1EtlCdvh4
Message-ID: <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:23=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> > I'm guessing you missed my reply to your comment in the previous
> > submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3De=
ukTuS2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
> > Please check it out and follow up here or on the original thread.
>
> I didn't feel to comment on it.  Please don't just build abstractions
> on top of abstractions for no reason.  If you later have to introduce
> them add them when they are actually needed.

Ok, if it makes it easier to review the code, I'll do it. So, I can:
1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
way all the logic will be together.
2. . LRU additiona (patch 2) and readahead support (patch 3) can stay
as incremental additions to GCMA, sysfs interface (patch 4) and
cleancache documentation (


>

