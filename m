Return-Path: <linux-fsdevel+bounces-29677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD197C314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865761F21D00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF993168BD;
	Thu, 19 Sep 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RJ/sfF39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEEA10A19
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726715602; cv=none; b=eTu35CTRh4Q7gCJ6uP2VByixwZTYL0ADWrK+T4EQz+odmfwwQKDRSyi8PvXZ9VQ/LyzuMWuXnkycPigQyiTnqDeJtMiGHs4/orsle8mo1LYEomi+a3zTS3I2U/WEKDYJ3Cxp1QVoCHvE6Jm6xoAThqTIqCFGBXC/W89soZGctIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726715602; c=relaxed/simple;
	bh=9V2+zbwm8Yz+r58UL9q8WQFB/wy+TQMYxqZgi3T/d3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpmfXPyDHzpol9bWT5P211ebtD7exwdMIctpQUTo+HqAuihu5sVZKcVWjROoS2nYzuM+jvAvZPrygsAeI5qSwsf1NeOmOR6jP/LV0swdMITapQGqHCMVACsG+GoZwDVu/Ap4ByLQImmPuH8N3w5NErX7+lJ3Z3JECftxMOlHqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RJ/sfF39; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2daa2262so34621166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726715598; x=1727320398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcLLwAFuhFyJrwjWn6iH7R74N7ls/NAjmWUt4uQ7SSo=;
        b=RJ/sfF39DaRUHCo5CBtUGZanSKrd6zH7j4mawltWbeSqSq1oFyP4E8kdISSMdIFqIF
         nGZHe1EuT4dzzeqdBy+mAFWfjI9j4sbE9nFKWCAzFhWerIVZveJCJ0OqBzdAgQ1dmges
         kzo/nLVPG015w+BKiTRS2o8DDiQLXggQNhQ+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726715598; x=1727320398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcLLwAFuhFyJrwjWn6iH7R74N7ls/NAjmWUt4uQ7SSo=;
        b=kHRkYzUCwLSvpb+afg/h2mJuoc78ZWHMXfXTAPqLYdZwg9Bsf+vYVWKDa+W6GLb2TW
         cC5n7/6YsVBT2lLZEtpgwcXrOY4Emjnu2jLNP3oaj3l4STwtFvt53KCgvuhZeDfZ4iVj
         LvdvXTv3R2FZto5JlEyiV/EkzQMFOIKyE3VYKieB5G/VG9TolDMAug0Cd1w0yTCiNumw
         3LVGtBdPTeTyndMP/1g0Zw1fJDmKHiDi0P13aH9SZ2371ph2MTyp9nmo9JmK5DWPyAnF
         eSM4xRnQxb/HKJPXh0m1N35k5X1G/MmYXUatWYTwRmeiXUVvlmbp+NFk4qCP9EVZsNhe
         jXCg==
X-Forwarded-Encrypted: i=1; AJvYcCW9m+OU/uALxZpGTLycDQtsXl1S1xmZI+x64kTpSPvyijIBulLCSifLN6r1mqaQCYgTngEPdYN0YhYTr5ov@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVqB1uxDvp0OTf1zvWxjNtee71XAeNMUy+6/xsw6n9ZKBOCsB
	Sbx9oLfPj9E441IfbYHAV6ibyNabdyCm+FEs8zWMw3xhemkNglSINlv8aBVP6qHJPpXFcl6GGCV
	Mvnljlw==
X-Google-Smtp-Source: AGHT+IHgTtqsPKWmvWG2iDtaAXyUYJOzMQ3KbAosTAx36Iq0CE+hg57ErSeXLZkkduee8kfYUJABBA==
X-Received: by 2002:a17:907:3e1f:b0:a8d:5288:f48d with SMTP id a640c23a62f3a-a9047d1ade9mr1854537466b.32.1726715598194;
        Wed, 18 Sep 2024 20:13:18 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096694sm673694566b.19.2024.09.18.20.13.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:13:16 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so32467766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 20:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1iqUIhPkGs9L9MjPw/K2Qf6qFTpxLbJpfekQNfOAlwPTqlQuaiQIBAcQtDrDC91DXuhlRGIBrlKLyCSi3@vger.kernel.org
X-Received: by 2002:a17:907:6e8b:b0:a89:f1b9:d391 with SMTP id
 a640c23a62f3a-a9047c9c504mr1768413466b.14.1726715595791; Wed, 18 Sep 2024
 20:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 05:12:59 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Message-ID: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think we should just do the simple one-liner of adding a
> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
> xas_split_alloc()).

.. and obviously that should be actually *verified* to fix the issue
not just with the test-case that Chris and Jens have been using, but
on Christian's real PostgreSQL load.

Christian?

Note that the xas_reset() needs to be done after the check for errors
- or like Willy suggested, xas_split_alloc() needs to be re-organized.

So the simplest fix is probably to just add a

                        if (xas_error(&xas))
                                goto error;
                }
+               xas_reset(&xas);
                xas_lock_irq(&xas);
                xas_for_each_conflict(&xas, entry) {
                        old = entry;

in __filemap_add_folio() in mm/filemap.c

(The above is obviously a whitespace-damaged pseudo-patch for the
pre-6758c1128ceb state. I don't actually carry a stable tree around on
my laptop, but I hope it's clear enough what I'm rambling about)

               Linus

