Return-Path: <linux-fsdevel+bounces-29366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D1978A87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 23:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014EC2826A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758BBA50;
	Fri, 13 Sep 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dOXPS2ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AC433BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262666; cv=none; b=YTVSwyhDOyHQJuh4Eb0L2HWSPk9zeLCWqfamVN+iPjDXEQJNxeBR+ZdZb0Ig8yeZkxOZyPdEYM5/AmJXIVw0nuPekDswJY86F9Qa+YMbOjMr9qbvNexmJMhMfOlzJNxNvYcvqm4yQw/CqGT/LSXkh7+JaKsl1npb5l4J8DyEcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262666; c=relaxed/simple;
	bh=ZYhLlCfJubXl2lpFJkootrsMtKBVHk6xopFryr344Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWF32jXPRaD2jmp1xTCrz/+5OEyWEAjYHaPmTC9JzydiZrbzZPtnVBDccfHRbYuJMFdws+SulQkX4LcT0s24YxGZUxy/LlY31rMI8asMdIIQxs9d76WywmYwddShWLLGIZbJGBY+U/pmm9tNcvKdWxRomF8re2cjZXJ+VjBUKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dOXPS2ct; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365cc68efaso2838767e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726262662; x=1726867462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRuFfVQTrS2LaFQHsAbqiDg4XIXZJlnGtDFvh2VKrJg=;
        b=dOXPS2ctuH/ZJu0xW6+f9l/5uP8WwekX4KBkgSF9NNXokVP6l0rhP5JPeiR39fnwis
         0smUoOPmopxYjX9xHydq9PLm6KpGHuB7HngkdoX9C9Opr5jtwHAk34mA8LbH9VDjKaup
         Fk+WWYnlYtVFc5kvyB6e/Q0OApzCLqrfNjVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262662; x=1726867462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRuFfVQTrS2LaFQHsAbqiDg4XIXZJlnGtDFvh2VKrJg=;
        b=LmDO+m7w6M/tWbutlEbcsQqST9fZe43qBDP4VklHW0XMSDK3izMEiRDGhaVfD2EFag
         uZOZ6GfHqIWV1Ox7cxGdng1nSb+KzueNXcfr1roLXTbFbnk8ZQsNwRJMziukHMzNIen/
         W9/eETbAOkMLgYm6ZKXvnm0pO6eQd+7Rac6R7e2zQWC5AKDedPz0OZawPH/G33nULIkM
         xEjKHJI757Jo0+jWfOkiDSSrQ76Vg/0J4vvzm37WfjqVsKc0MmkuMaWpM2PhiuK8spcG
         jrE45k03c+JhUQDnmOlq1MgxNkaaV038q7zlmvXXDofgVYFr13QZ7f4qQJNdOHMyhd7g
         0SXg==
X-Forwarded-Encrypted: i=1; AJvYcCUSDBb+c/miq5liyYvm3kyYgE9GCkV/wiczrnyBTwhsR+943b4b72kC+MnkEmptUVVlRgObi/ZufnqnZcYE@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2IUv//xm+U5ARh7cXFqclhpFo9PVCjQ6quq0FoiKUpkqGL3D
	g2XLRl1VXed0wmCmavq10MoBBwsi2dGmk46r/t9E2MbooHIleCs+YZPmMQlSbwqt5dhSCzp03nt
	9QtI=
X-Google-Smtp-Source: AGHT+IGU/7b5dyuzfpp3rFHy/glrzfxbdzLFSC0Mht93SgOLTcGvbn1kocu1Z8ulLWP6Diks8OceGQ==
X-Received: by 2002:a05:6512:3d93:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-53678ff8a54mr4476962e87.61.1726262661147;
        Fri, 13 Sep 2024 14:24:21 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046f70sm33077e87.33.2024.09.13.14.24.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 14:24:20 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so29529971fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 14:24:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVg4ZIPYrBlSy6YqWIrZewPO4YjBHgGieOIenM9oDufW/QWINjAp2onCB5vW3u5OqbmtjOv9gQSVdJH3egw@vger.kernel.org
X-Received: by 2002:a2e:7c0d:0:b0:2f5:11f6:1b24 with SMTP id
 38308e7fff4ca-2f787dd0941mr36494131fa.18.1726262659861; Fri, 13 Sep 2024
 14:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com> <ZuRfjGhAtXizA7Hu@casper.infradead.org>
 <b40b2b1c-3ed5-4943-b8d0-316e04cb1dab@meta.com> <ZuSBPrN2CbWMlr3f@casper.infradead.org>
In-Reply-To: <ZuSBPrN2CbWMlr3f@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Sep 2024 14:24:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=_n1jfSRw2tyS0w85JpHZvG9wNynOB_141C19=RuJvQ@mail.gmail.com>
Message-ID: <CAHk-=wh=_n1jfSRw2tyS0w85JpHZvG9wNynOB_141C19=RuJvQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, Christian Theune <ct@flyingcircus.io>, 
	linux-mm@kvack.org, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 11:15, Matthew Wilcox <willy@infradead.org> wrote:
>
> Oh!  I think split is the key.  Let's say we have an order-6 (or
> larger) folio.  And we call split_huge_page() (whatever it's called
> in your kernel version).  That calls xas_split_alloc() followed
> by xas_split().  xas_split_alloc() puts entry in node->slots[0] and
> initialises node->slots[1..XA_CHUNK_SIZE] to a sibling entry.

Hmm. The splitting does seem to be not just indicated by the debug
logs, but it ends up being a fairly complicated case. *The* most
complicated case of adding a new folio by far, I'd say.

And I wonder if it's even necessary?

Because I think the *common* case is through filemap_add_folio(),
isn't it? And that code path really doesn't care what the size of the
folio is.

So instead of splitting, that code path would seem to be perfectly
happy with instead erroring out, and simply re-doing the new folio
allocation using the same size that the old conflicting folio had (at
which point it won't be conflicting any more).

No?

It's possible that I'm entirely missing something, but at least the
filemap_add_folio() case looks like it really would actually be
happier with a "oh, that size conflicts with an existing entry, let's
just allocate a smaller size then"

                Linus

