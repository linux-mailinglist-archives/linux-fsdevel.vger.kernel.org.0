Return-Path: <linux-fsdevel+bounces-28233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FCB9685DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330D4B214E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41376181CE1;
	Mon,  2 Sep 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OnCmY1mq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A20175A5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275508; cv=none; b=oPtEN1wUI9SUEs7Njrm+DpS2VMcePi2DdAWEioWks24h5i0MgqzHGFcueEAJUxEj0XhqeYr6HuotA/rVjPzdlle/1i99OL8aSdHN1v4CXgdoFU0tGNGqhhuVqKsx1nZQhH6/zbjJVcx82uixsqTtLx2h0syvjOoqYV2OifE3NJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275508; c=relaxed/simple;
	bh=ACYti0hxKYVlzkz96GHvJe0UCYPSKaa4OxF8s/gep5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHrP/LMGw7DiUyKKpS3eAB400V1xzDC1I9FMGE2Xq5fhaos2ELH7DN7YLgZHDuYk6O+1QyusGo28vmofbJ7dS+37m9hNfR3TZx+NJ8VeVz9ii7Vzv6DubkSmZxMl62aRBfrtlalXIfyXJUYpTEO+G5naEQidCN+hs/B1XqfrLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OnCmY1mq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a869332c2c2so812961066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725275504; x=1725880304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kuph0+9o4A1RPBphrgMO3PL8jFdGA5zKpiVVErC0F/k=;
        b=OnCmY1mqmtxMVFTFjLXpy3zZigFu0OOki2+j5xPTGH0X0rEfdXSfa+MiNxF82m2xNB
         N/0AGia4jUlm07ScatBxnkXDeN/4ooekEEnc8Fn4ypZHwZG6H016TcixqxEjlv5qIpJd
         DmM0RG40rCJnbfXTatNOK37TeNw91gTvRInag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275504; x=1725880304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kuph0+9o4A1RPBphrgMO3PL8jFdGA5zKpiVVErC0F/k=;
        b=CtiFK/KipPwFTeYBJ7LDzQGCVV0lKwebCEXLjqS2vDMAvxOYNHXjyzyyzmMdn/gpwo
         BMOHbrK0XgHVjmphhTF2wwHFpqHMA2HPG2q8Jm1PITSwrIAAd5F1Quxy/DFb0w0EVbkU
         1ofEQIrIpLorhtd42Jbsq0ULrwvHgmvW8c1hl8qPz4CominN9mxQcXGNJWAPuAUC+EfH
         9mNnXNK6HPZo/uyL6p3GIoY8KXsKec6Is6wc9cERigZwqk05KE+W2jvGHKhv0WrPFcV2
         hhqx+0woDAVn75fnEQz0yFehY9Yo0REEFzQ1ACrTEC2N07hYfm9SI6Mb+m2K//Ask0dZ
         4bwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY7LbLidmyCXRybpp7XVHkeDrJxWSbEWqV/Jv+BiDSK1ZBrBFrylyFfv0C0xzGF808bWAFTnNkD2rJaDAS@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvChY01FxV1a4DF5MNZ+clp/Y0Y4J32/I2OvacdLZ5xbVkI6y
	AaZaArN/ZPTlVAG4/I8LXzdtGoWJfroCWOFVTafMbYP1MVX7XM0bE51xbkxUvJwFOhHnHqLMSHn
	Z5B3XOjKNjbKVA1i0eLQchOkBCqUxonJklGd5d5RRdrgF4wSXkaA=
X-Google-Smtp-Source: AGHT+IFBxYjxkpMm6qbV9fEsZkagQqPFpQha8XkxW51P/F5oJ/Yydy83LAC9tU2cSwhRYQpNxEurFqLkG3Jmy8LaC6g=
X-Received: by 2002:a17:907:3da0:b0:a86:a6ee:7d92 with SMTP id
 a640c23a62f3a-a89825a4390mr1484060166b.18.1725275504209; Mon, 02 Sep 2024
 04:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <1c7c9f00-8e94-4a98-a3d4-a3610d35e744@fastmail.fm>
In-Reply-To: <1c7c9f00-8e94-4a98-a3d4-a3610d35e744@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Sep 2024 13:11:31 +0200
Message-ID: <CAJfpegsGH06H1tEbV3TDFiwC2d9Kfr-da288mqT83yo85naqGg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 12:50, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> In case of distributed servers, it can easily happen that one server has
> an issue, while other servers still process requests. Especially when
> these are just requests that read/getattr/etc and do not write, i.e.
> accessing the stuck server is not needed by other servers. So in my
> opinion not so unlikely. Although for such cases not difficult to
> timeout within the fuse server.

Exactly.  Normally the kernel should not need to time out fuse
requests, and it might be actively detrimental to do so.

The main case this wants to solve is a deadlocked server due to
programming error, AFAICS.   And this would only work in environments
where requests are  guaranteed to complete within some time period.

So if the server needs to handle request timeouts, then it should
*not* rely on the kernel timeout.   The kernel timeout should be a
safeguard against broken or malicious servers, not an aid to implement
request timeouts.

Thanks,
Miklos

