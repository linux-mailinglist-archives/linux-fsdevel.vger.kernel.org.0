Return-Path: <linux-fsdevel+bounces-29679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23897C353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 06:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3D282C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A218E29;
	Thu, 19 Sep 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NbS0EICt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B942179BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726720363; cv=none; b=SWWWFopsVqt7bic+7/Ys+3INbtIhURg+znzKBBlhOIskW8Mmsqc6q4yRW4Npb7xq+wC4PsaG75GvTyEBq+p9fOSSHrIqQUpFLj/6MqjMKO4do0cNj8oqTgMY9Sfw5FJ2T5TM9jOsBHlP0M62sDH/f82f93CWu5jPlwaT3N3QuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726720363; c=relaxed/simple;
	bh=fzixIv7mDCApwoPr19Yl5C0aFP9P4Wj7HGNtS5Rhh7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpUyeD/4WbWmh+qvxGx4OBECceLqyj3YeB9uUSvdrQqMrOiYFQmIShJU63NlPtk1xvaVYwUTHfMUOOrbZeQu3xLUpbW0993hLTlAQkZY0MlIlh3bO5BSg18biY4oBiG5acnyh4kpHtE2ksRz1ETdYTq0i55Fxzevs9THsoNJq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NbS0EICt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so48964766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726720359; x=1727325159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9yFEfRvpp3RBfmF+3PJrVEwQqIIGgrTWijYjV6RGF0=;
        b=NbS0EICtUkfCyMVBTWgRwkBawM5/rDTb457Bk8qg05EnxhREhe4uX4Nzc+TqN/pya5
         5qwIBg+AFwalt0TWx6Yy1RuqNr7Lx8rv4mctTPA/5yu5QxzmHWZ2aVgrYkDpYwUkHbse
         mJ3OKiVRVGHZrsuSjaJw+j3NQjHsp+BQxkDC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720359; x=1727325159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9yFEfRvpp3RBfmF+3PJrVEwQqIIGgrTWijYjV6RGF0=;
        b=HDEEJW1ABW+ko6bmjRQM+HSJO1TRxNvP122dD98dx/LI6Uao3x6qM8IY3pNspEBC/t
         V7vjihfDpeXwV/2txV0dHorTuJZ29IrITG0UamrKI8SzT7dQpoo2K3aMxIYnhhF4uRCD
         iLZ4IO/kBR8DvzRhfW1WIgIz86XgPpyJkKY+DpqH9/a2aCRHs+QpFy+DdG0NHtOl5mDE
         wggsk9o+AwKVV4+0dqdIgVUDCgolxMSUnP3WObOTMmJ8kvKLrXezCr5z8YwfHEBer4FN
         HNpcXBtUf0Y8EZLRoRu+IpC3mwWPbgH79lgg8GdE9nr70DJM9t6qJ+1BW5b/ynrWy8si
         Dvqg==
X-Forwarded-Encrypted: i=1; AJvYcCWxzZihOA8cewekF4yg6hKiEQGXwgom/ObuYpkhKr2VIhrTUW6AM7Q9b3cFGhKt4RFxbdS7qYih8STu7YWo@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHd9An2rz6kCaqUEH3i8kLkxvAwLucTwQatB4/ZY2XpwxWpTc
	712TSAU2ZotwYHWQlCvyTUc/3yrjgDebXZ3U/+o44FPfGoTQEysy6Wh1IZPJQ4HEwMXq596Tlc9
	NAd1sWA==
X-Google-Smtp-Source: AGHT+IGbFaq5GK9zmaQOcs0q+7SOI7ZhkLE8fxI0ppdFKzBCPc+k8OgW3fvqh2FoLmYYzL+ltPFefw==
X-Received: by 2002:a17:907:e6a2:b0:a8d:64af:dc4c with SMTP id a640c23a62f3a-a9029505570mr2596303166b.25.1726720359249;
        Wed, 18 Sep 2024 21:32:39 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm484666b.124.2024.09.18.21.32.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 21:32:37 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c42bd0386cso497394a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 21:32:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2Fdqm2A/4UPRCnacBig0SbAypbtSPBEJvkiUb6tE+snG8R53xomdWz9a2BbBkYKM2RCT49ShDWtNv3mmw@vger.kernel.org
X-Received: by 2002:a17:907:f766:b0:a8a:8d81:97b1 with SMTP id
 a640c23a62f3a-a90295a2171mr2279810366b.27.1726720356520; Wed, 18 Sep 2024
 21:32:36 -0700 (PDT)
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
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com> <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
In-Reply-To: <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 06:32:19 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjsf9eAsKf-s6Vcif8wHPFj3iycaJ89ei=K1hQPPAojEg@mail.gmail.com>
Message-ID: <CAHk-=wjsf9eAsKf-s6Vcif8wHPFj3iycaJ89ei=K1hQPPAojEg@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 05:38, Jens Axboe <axboe@kernel.dk> wrote:
>
> I kicked off a quick run with this on 6.9 with my debug patch as well,
> and it still fails for me... I'll double check everything is sane. For
> reference, below is the 6.9 filemap patch.

Ok, that's interesting. So it's *not* just about "that code didn't do
xas_reset() after xas_split_alloc()".

Now, another thing that commit 6758c1128ceb ("mm/filemap: optimize
filemap folio adding") does is that it now *only* calls xa_get_order()
under the xa lock, and then it verifies it against the
xas_split_alloc() that it did earlier.

The old code did "xas_split_alloc()" with one order (all outside the
lock), and then re-did the xas_get_order() lookup inside the lock. But
if it changed in between, it ended up doing the "xas_split()" with the
new order, even though "xas_split_alloc()" was done with the *old*
order.

That seems dangerous, and maybe the lack of xas_reset() was never the
*major* issue?

Willy? You know this code much better than I do. Maybe we should just
back-port 6758c1128ceb in its entirety.

Regardless, I'd want to make sure that we really understand the root
cause. Because it certainly looks like *just* the lack of xas_reset()
wasn't it.

                Linus

