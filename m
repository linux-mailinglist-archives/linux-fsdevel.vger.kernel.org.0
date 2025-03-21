Return-Path: <linux-fsdevel+bounces-44719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B3A6BF63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1073AF06C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF81E00B4;
	Fri, 21 Mar 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciKoWlGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911822B5A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573604; cv=none; b=SsKFIwVSdaki7hnwI5ZkmnMpIUKztbMCdesCwdAqiRCZ1TAQJ2TRalRbmqbtdIVSuaDCaUyHs7mL7T7fFsiGW14ZjaR+Ar72lnG7FGgRTToJ28B3fM++L9wm7UtHaroqXnr6JyYBsNCpMn1enthB9Ldlyzoh+LCVKtLQ1aOkMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573604; c=relaxed/simple;
	bh=C4aK4DlSw/wJI3i7YtL8fTLyTEQqGsdWSWsribRkY1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+8j7ws5sCzBhuuG1sve8veDMLCoM+bp6bxGL/ZAsnIYEwF/3ZqGWeoYU+qyJiCKsOl/xmrsrbhO3A15ki8NmdrRTVVHCK1zoJJlxJ19Seu9taSxzMXItnlR9QWhczrSAv401oHyfm/vPOy003qOsriYkmmmxsmYM4kEAgbq0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciKoWlGm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4769e30af66so323081cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573601; x=1743178401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DB6Et2/ns18QKw/fxCT3wrpCitAogjqJ6rF7Sc/IdI=;
        b=ciKoWlGmO0mpXBvyGxsnvw5X8odjsFGhO3wgjjxYo+qS6ulwDyXudLOi68VOG4fTyq
         9s3RPfcavXJy2t7ylGYjZ1jeH0H55Ti9CIJjdBg0WJBv1WrvH94pdcUasmr/uR/q+3Bl
         VPHAKtGDa5dbp5ZK+qtGuRr1Pio8IYlPAiHnp5K4nTysOL5Zl6GFONMp0TrJEVaaoveR
         619OFSBc3T+EZV3EDJR1Db+n0l76Ub2slZ1nNhSnHyQG6l95rzCBRkFdShfYc/9nfWkc
         0lEPW3cueY+5cQaeG+LHui7qps2vmIo2FjD+cJTzPnurJkAzfzCN9YuTyh1HdfFNjsMR
         cnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573601; x=1743178401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DB6Et2/ns18QKw/fxCT3wrpCitAogjqJ6rF7Sc/IdI=;
        b=ab1FMioTF7aYML89krc+NdJjAzieP9q6k4X5TN1RVLzAAToZMJ0+fhWNJXURoBwL4U
         dB5+2pUaixzyhdGlWDvB7uYwxCRqeeFu8+tbe9uQHPgXrgvcls7Clpqirk8RFVVkY5sF
         Q+XRrYKHr93sYa6MIutDIAGa/AxWMBAYnHPXly/1xqtiy8sRAbuUMCtTcnpk6WjOngas
         O2qyZO1GVdHefn1xuI5GUA5G3ETDAWiUsP6JA75qi/Ca+7AzmPmNKVU4DLEgsxjUxEF0
         4LBp0P01pVDRankR1Fn99brxgp6Wh/RbYCV1FSbXoJIgVl/4WugOSOYUAGWDzyr0mCej
         CyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNySLZdNnpukdp4cBoWb8+zase+dfN/2DJO7cnrBdva7c5CXaMG7vdMOQgTkvHlZaKCGcjM4yB9lcV2WKO@vger.kernel.org
X-Gm-Message-State: AOJu0YwDi2Mtss1mwRHa/Ecfb7qV0zYqQih499JClIrhw0lxpd655R+l
	KfCo+In/ZM8eSjYOaIvwjOKQ65BkXZBXGFV62VGAW8UyDYlb1Sw2qQzT5u0M3EEUV6QTxi56sw2
	bjVEDA8+/jImMSPq0uw7zLueLcDsWAiqQ64QD
X-Gm-Gg: ASbGnctv0mOO9wyGqpNYRNFwdz7VBH+c+XE0KlKD38eOY4q5skvjjs68gEwYff51OgN
	pVdGd7Df8FpRnpV2iIPLbQ/V+4OpG+P0N0uIWgtcxugSo5Q5honvwQX+R0qi09XhjsKxDV/mk9k
	BHhBMCcOs7rgEUJu1J4O/2Sbx/SA==
X-Google-Smtp-Source: AGHT+IFSgyka4WC1voAzOEbVYGRfiKD2rPwZmgBJm5bmCEG2w77v71gm7DM31qNjr/YtvVbNnr/XQWUzc/NWKh6R9Qk=
X-Received: by 2002:a05:622a:4acf:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-4771e0a7e7dmr5053721cf.2.1742573600117; Fri, 21 Mar 2025
 09:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-3-surenb@google.com>
 <Z9z1w2vHfJrwSgWW@infradead.org>
In-Reply-To: <Z9z1w2vHfJrwSgWW@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:13:09 -0700
X-Gm-Features: AQ5f1Jr9bSIHVG9XyNi5uOulPdcHUxw5kGAy9us8_XrILBTKaK6kzxC5mMI3vcM
Message-ID: <CAJuCfpF=fk3=s3NLkai0GN5twjgY8AyyL1vZn3T+N7E10SgHug@mail.gmail.com>
Subject: Re: [RFC 2/3] mm: introduce GCMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:14=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 10:39:30AM -0700, Suren Baghdasaryan wrote:
> > From: Minchan Kim <minchan@google.com>
> >
> > This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
> > cleacache backend which reserves some amount of memory at the boot
> > and then donates it to store clean file-backed pages in the cleancache.
> > GCMA aims to guarantee contiguous memory allocation success as well as
> > low and deterministic allocation latency.
> >
> > Notes:
> > Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
> > Later Minchan reworked it to be used in Android as a reference for
> > Android vendors to use [2].
>
> That is not a very good summay.  It needs to explain how you ensure
> that the pages do stay clean forever.

Sure, I'm happy to improve the description. Do you want more details
about how only clean pages end up in the cleancache and how they get
invalidated once the original page gets modified? Or is the concern
that donated pages might be changed by the donor without taking them
away from the cleancache?

>

