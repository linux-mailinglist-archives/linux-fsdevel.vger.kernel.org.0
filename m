Return-Path: <linux-fsdevel+bounces-29997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8E984B86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9C81F22313
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996631ACDF5;
	Tue, 24 Sep 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eSyd9mhF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE601AC8A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205877; cv=none; b=WjxkNsvHASVWHlCvGLxpOjxFuhtFe6Ly73JoXbZPKvZsy2mr5AsJ4ZoHgy9azdZZvEsmdzUQOG2gbCI2t7LqfVGqCeWAJ1JvvTu4i2jRv5JHfBQpNucPXtSzVUW5kCCsUlMhV6+YWU/N0nb0ySoh7yKgIhX31sBBfEzN2aL4hkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205877; c=relaxed/simple;
	bh=SIeQoyCxYAQebwPctse0ec/xuA/Q6FV0i8cdsXtARic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJMbqiNvE8AMRbuKE4ELxK+BxczgumPhV1lKb+qW9UtpjGjLI1hT9NRedkOG8S3Z/H/h0/7lNsSWJWyhAfEZ3SjQQT+VeNsf18teoLfJf8EKjHlgPwgdD/A64vE1j7qFCkoyQwB7mpfBTQdL5Xmvrnfi43Qh5Ot0qWl0BKRTNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eSyd9mhF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso7812800a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727205873; x=1727810673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3AEQwCgf5wgX6ZTyJ9aWNB159Y5/5DzJz6MiCsxsiWg=;
        b=eSyd9mhFdtmsq3dEfWRKP5ZMJdd0egIpa3MuPtXvCvm0GeTBw3AGpd8v0eqBZ9Ouwm
         VjzPrXseWGXNRss6ChzLXcZuP2YUNy77dC1keB0SQ+D040jNoPG2pmfbcUPPayaqOPdH
         VttoI3U4Ub8/RXc8k6dd4+sxzBHRxJSFWz3ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727205873; x=1727810673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AEQwCgf5wgX6ZTyJ9aWNB159Y5/5DzJz6MiCsxsiWg=;
        b=GQkl97w8rieLzGxrypXLax2GLNYdVJrAObV9BTiF5lnzLm0GNO2dDIuNpNZC6/Doz3
         DSVviG1Y3TamGnKCMVc3lvMem9ZTRnsP0zGx4KnMWBoKWUITNWfkV/QUQyJcA54AP3NC
         wL83na9JfYlP7HS6/LI70boo4IVNkv8xXmIo58Gs13c4PVPdyA1qDbKqFHtPVtSNS2c/
         UqgoJNirXl1U4hikCnLuF0GqO/PugSlxB2qnlBIcjtv/NaOHWQ3N7noli8Km4JgaC3Zy
         c17cjuMArmHy+fhv/sBL9aRKpWoX1AbU/iEwX27nCEL4hMM+a1+OYAaONDrDK5Ghu+pC
         w5GA==
X-Forwarded-Encrypted: i=1; AJvYcCU4OU4TMgN1r1kUizcRkSN7fwsE0E4xyAXKz8Xozn/yennVhheSbfEsIBVay21xvtEbZGwwsLWkGI6RAZ/C@vger.kernel.org
X-Gm-Message-State: AOJu0YxNa7cQcH1cdf4aEnizFxot2/j/P68G0mKspohR1E0CqRQ8XAc9
	Sb+7LdmZFMibNdZ718Nlr+CxTSycEeaNxUtJWHl/j66s8oDV4a2WFoAFPFMSipqRYsBb6gzR7Et
	QIW/otA==
X-Google-Smtp-Source: AGHT+IFI1XlxlTTHljxYVrRrEAEjFhggFMaJ3ncfBgZspwt+BTkblMtyzRp6Rf/fZO8ez9kqvGxPCw==
X-Received: by 2002:a17:907:86a7:b0:a8a:86f8:4eed with SMTP id a640c23a62f3a-a93a03421d3mr31362466b.10.1727205873036;
        Tue, 24 Sep 2024 12:24:33 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393138af7sm119823366b.206.2024.09.24.12.24.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:24:31 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d24f98215so788384466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 12:24:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYGDhucoVtZjo8c3IbhYHZjjhFLB+j/r/kQT4wVdr61u3QtgCic83A1O4PAGum1NmyRDcVviDI/F8rGvTU@vger.kernel.org
X-Received: by 2002:a17:907:9726:b0:a86:799d:f8d1 with SMTP id
 a640c23a62f3a-a93a06333edmr32505866b.47.1727205871314; Tue, 24 Sep 2024
 12:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZulMlPFKiiRe3iFd@casper.infradead.org> <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org> <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com> <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area> <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk> <ZuuqPEtIliUJejvw@casper.infradead.org>
 <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com> <15f15df9-ec90-486a-a784-effb8b2cb292@meta.com>
In-Reply-To: <15f15df9-ec90-486a-a784-effb8b2cb292@meta.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 12:24:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAQ23ongRsJTdYhpQRn2YP-2-Z4_NkWiSJRyv6wf_dxg@mail.gmail.com>
Message-ID: <CAHk-=wiAQ23ongRsJTdYhpQRn2YP-2-Z4_NkWiSJRyv6wf_dxg@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Chris Mason <clm@meta.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 12:18, Chris Mason <clm@meta.com> wrote:
>
> A few days of load later and some extra printks, it turns out that
> taking the writer lock in __filemap_add_folio() makes us dramatically
> more likely to just return EEXIST than go into the xas_split_alloc() dance.

.. and that sounds like a good thing, except for the test coverage, I guess.

Which you seem to have fixed:

> With the changes in 6.10, we only get into that xas_destroy() case above
> when the conflicting entry is a shadow entry, so I changed my repro to
> use memory pressure instead of fadvise.
>
> I also added a schedule_timeout(1) after the split alloc, and with all
> of that I'm able to consistently make the xas_destroy() case trigger
> without causing any system instability.  Kairui Song's patches do seem
> to have fixed things nicely.

<confused thumbs up / fingers crossed emoji>

              Linus

