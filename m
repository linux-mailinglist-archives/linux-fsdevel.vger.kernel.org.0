Return-Path: <linux-fsdevel+bounces-26838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA495C00B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 23:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08CA1C21AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541161D04B5;
	Thu, 22 Aug 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyzi9J8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59E170A15;
	Thu, 22 Aug 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360475; cv=none; b=KKRKDO6RZ71fUUIjgGLtpP7st58SjR+UB6tuRFiTPGrZEqpOfGoEVngX0F8FDe5zn+oAq0eXMXd7cuBT32llhj/oxggq4h7E9055Xx6QqvhYYsr0qgYw8FYiK3ixHb8G3ghyyfl6MSTeULOWbsIvCfNsio7t/E24V/beYoh7VXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360475; c=relaxed/simple;
	bh=5heL4h/R0uWgqNZ/L5ZRaKC+zTjxAEZoG1fCa7oieXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHd2Yb1mPmMK971Wn8HGSowd/ZLC4N7fpQZhjN8zfKeqL2bfLK0fRZWfdESeb0IpMDm6rc0c4CrsTowNkazFEQ/1kdCjJ/0RKlyPI7hVGB70+C1EOfP/kfoHBhrXT91Ftxjx5vftYRiaRW0fNB99l3uPbs57INpDTnZHXD4byRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyzi9J8F; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff398cefcso6638621cf.0;
        Thu, 22 Aug 2024 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724360473; x=1724965273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw/JKAnymYOmboHlkwK/DnRu8KqLmYWyOecBkJ6vDRQ=;
        b=jyzi9J8FaGrjlzyrDaRRBsYvkWTLw+eS1Q+jVLcx8liVeFYge0p5UhitpPQ9ASbhQ6
         1H4Wo0bdx5/n5ntoObMq66xudxcvgKyp25X4PLigPJYGJ+mBMkBVQSIHHJmeZutFjQSz
         3pLWi+IVa4gwAdCnzxiV2iS+oyQ9b3qtA2Iks0hpDX5K0KHgdnMWva7trbN8y9kUnwQZ
         FO8APWS2u+kgsNRsIePJO6ABNNTFLhbERbnPy7L7++K8P/6hKwe0RDANfjwPKu9lFM9X
         Osz8IM66DlCw+BE0s8Ug6/bV9nnGKiYgNXi0nx28WUskEKw6kGtYzET6I6otbgA4j2MA
         QWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724360473; x=1724965273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw/JKAnymYOmboHlkwK/DnRu8KqLmYWyOecBkJ6vDRQ=;
        b=ialgofA7VZlKreSH3Vx4kIQFfHseEX2tefYs3gSAqiUkoV/uKoiyyky4das3kHHmli
         W/DPS26Osv71sO3ZTMAzKcjhSa5OsnN5AjoGAi5OHWodVAZmeJnOLWduMG9z/CT91Zhi
         qDS835dBpePeZZr3gvpniQ8e2peAEjaN0X1u8YI4oxc+X5KR/QRrQf1M8gajBOVsagny
         Khmh9T4NG3c4RvwEkv2GC3zDBAcUIcz/jnbHyL2Qu4bsGrOAOqbZq0hcRG1rcStFGApT
         Af9OIEgDzuYRVh6nC+Kmm8+lGn4V1ClHu6VkivCHmlAC18z354ve6ijR55O1pIUmqD6h
         mjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqkELRfc50OxzJZ7JKrw26K76e0Plz7PBNnqTXWrrMZKrH8VspB4cfc7ZsSmqoNp86mW8DTIj5vfbfoYud@vger.kernel.org, AJvYcCX3cIsqmo0NqfLx+/JiWMGdRlPl0CAoo9M8r+mxekW4/Qp9kJ+POObyk+AN+9E5NV5Y72nRPEWbe4ZLmF5u@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbV3uu/+wQiD5rpSIs+4j1sWnXGYHT8uD9SafizvmrQEmG/5T
	4wmxskmA8czBua1k4yjYmpxlH03OZw301s5y18uQCyFFK0e0PbPphUpWw2zZpoT8tw0/gtRYKaJ
	DR+grm6v+dap/DHAG1Bymw1F1CAc=
X-Google-Smtp-Source: AGHT+IGHek6NPXh4EgdjVCiMwCyd89tfaOc5FG3NKZkwUAaypH6vmbvAblaiWLzo/FOWCYW0fzGjIWQT8UZpLBnIVrI=
X-Received: by 2002:a05:622a:5588:b0:440:572f:391c with SMTP id
 d75a77b69052e-455096454bbmr3131991cf.24.1724360472847; Thu, 22 Aug 2024
 14:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com> <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com> <CAJnrk1aa=fv3H7pjmerrHD1fVkrD2inPhXf8DNdfeQpfSbUzdA@mail.gmail.com>
In-Reply-To: <CAJnrk1aa=fv3H7pjmerrHD1fVkrD2inPhXf8DNdfeQpfSbUzdA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Aug 2024 14:01:02 -0700
Message-ID: <CAJnrk1bs+ADoozFPKtirqvQFJq8hQAkpbch6fbznObaWddGRTw@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:00=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Tue, Jun 4, 2024 at 3:02=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm=
> wrote:
> >
> > > Back to the background for the copy, so it copies pages to avoid
> > > blocking on memory reclaim. With that allocation it in fact increases
> > > memory pressure even more. Isn't the right solution to mark those pag=
es
> > > as not reclaimable and to avoid blocking on it? Which is what the tmp
> > > pages do, just not in beautiful way.
> >
> > Copying to the tmp page is the same as marking the pages as
> > non-reclaimable and non-syncable.
> >
> > Conceptually it would be nice to only copy when there's something
> > actually waiting for writeback on the page.
> >
> > Note: normally the WRITE request would be copied to userspace along
> > with the contents of the pages very soon after starting writeback.
> > After this the contents of the page no longer matter, and we can just
> > clear writeback without doing the copy.
> >
> > But if the request gets stuck in the input queue before being copied
> > to userspace, then deadlock can still happen if the server blocks on
> > direct reclaim and won't continue with processing the queue.   And
> > sync(2) will also block in that case.
>
> Why doesn't it suffice to just check if the page is being reclaimed
> and do the tmp page allocation only if it's under reclaim?

Never mind, Josef explained it to me. I misunderstood what the
PG_reclaim flag does.
>
> >
> > So we'd somehow need to handle stuck WRITE requests.   I don't see an
> > easy way to do this "on demand", when something actually starts
> > waiting on PG_writeback.  Alternatively the page copy could be done
> > after a timeout, which is ugly, but much easier to implement.
> >
> > Also splice from the fuse dev would need to copy those pages, but that
> > shouldn't be a problem, since it's just moving the copy from one place
> > to another.
> >
> > Thanks,
> > Miklos

