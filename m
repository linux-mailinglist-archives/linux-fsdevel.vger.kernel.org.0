Return-Path: <linux-fsdevel+bounces-63991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64361BD4EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE01547597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E4314D0F;
	Mon, 13 Oct 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5HycyPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2E314B85
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370210; cv=none; b=AejbAiDIjkkvt2o38nMG1koB3qvRA5LzcMZsaxIbMoXjYi6YqHTfjW9JDe1Lkp/aV4wElmEu3S4y7TUatwUKaIr3zX3J1nnWgzUevTDAImNaBJBHk1CZTird+YhjhI7SJpq998Y05wIhpbug/iCETRn+boblki0jInQG4tqPUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370210; c=relaxed/simple;
	bh=kIVPmCT9kaUq2YA1N7gOyA1JcTYZFNkXFcLBy2dOX+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBOANK2v/98RTDF5EQOHKGy2KG+37JgrUZXbNNEFQmYM0IWpHdVveE2rLnxl7K5f6ksW0Ls7HQ2T7fFKGgbFdHhd7zat4CtvbXo++GBqOHjLyCtCfE3O5WdqcT2Gto4eddG/PIOv4ZljpLeF5XYBA+ZVZxCYhrRRLdVQQAXDayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5HycyPM; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4308afd43f0so1374455ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760370208; x=1760975008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvE2QaubCaNe+b2bi3Ii9pwdFgyDED1xYIH2KKqTA4w=;
        b=f5HycyPMTH8rgVXgmQyTiokCXEZEUXPC7ztFDYuZh5VzPNxNZeu2Rt563ptKcRa2Oi
         iclOKSQ/2x29qvifa/uMyBvXW1XemFrAbEqgk82kkPxoYqgsZsc0sxFysITyih+38/JO
         dW9xmyl383ZTkEkqxIzzaG1rw/qWB9ClSp947Dz21GpvD9vFJQowdo7dvR8C3LgteHbE
         Y9JImsi4S5TSpk4goUl9dRFm43rf8xcapzv9+WQ3dWXX4LX2jPruekr+uNatluT3t9ry
         ht4Y6Y/k6aKum3kd2Qjhmuqy72ssxE8YayuiRVd47O+XtSaaf7NmyjaEarlFVI5Znsak
         yRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370208; x=1760975008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvE2QaubCaNe+b2bi3Ii9pwdFgyDED1xYIH2KKqTA4w=;
        b=m7u2E96OsrYB+L4uvLVBALpy1fQg/5LsY3T0wV98RM6NoRGuropKHGUYRcLmj2KYA0
         AKJ0ubzHX4RDClRrtvkA+Jbn+yGsTuSYxeikQOyvJede93EsHuJNf9mSvSQE8ElSgE03
         2KidB09DN/dP1QVPFImF6Chh5s9VvWu+jHm1dfH2xjZlP8m+T/pQq++s+YxtVsmxEBmd
         2KwwB6w+jBuTpfG7ivXosc8e+biVVAKNy3DO3VK9JEUEkqHG/44CTE1E1MLEJWXIwQCv
         KqUw2lv2E1D93ZFrxlq9QeJ5ZIGyBZjxrJv8Bkc0AkNOp6yn/jTcU8B1A8a9CcjSaGqI
         wY2w==
X-Forwarded-Encrypted: i=1; AJvYcCXpDbpYy94yH1U+3aZqr9wym7bsUylN48UHbkmTxgF8Rv/QgkNZSJN2ZTKeZwSiaw4btHrKUtcQBQwLjTwp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67p6iFzp7J8AeBHIbX7yuqqHfXOTDhMpYDqTGVNEFqPt418cS
	O6nK53hxB+6r0fgSihEkzmft/pVUosIC7urdp/jz+kJsXgtflejArr8nmipyIJR7tF/UKy1bY8/
	mRlqhdRbN6XzCw6Iy0Tnkyt+8KOu/uqVIsSu5KZxD
X-Gm-Gg: ASbGncvxcoxjrfzzOrQCC3uU2dAM1oicGmnMvxP9rFGnUSelTvU9Woun0jHlblrm4kS
	m22habytsK048e+KokpKqqAWvaz7JoDB4uUY5DVqhDQkDAaaEqOlaftpVAZz1KnfUQ0J6Od5uzp
	Ee3WkgT5w397SwA6VLF66M9pqmzNulcnb0GKfhQh+OzjKUcO/JbRH9aZ7b5UyTpimj0KLOikJVC
	P+Ar3JDaW3upjk0J3/QX1MEMNZeO2QabZRaVt7BBREL7D4H507S
X-Google-Smtp-Source: AGHT+IGi9WTnaWtP/uIr7PgRC+0JilLcGDbVVnkS9tGZZgbSezgQwLrXzu3IZ+mvJsC1St6EdcqZZFWTwoYrtUBb1Hk=
X-Received: by 2002:a05:622a:808d:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4e6eaeaaf5dmr26573411cf.3.1760370207737; Mon, 13 Oct 2025
 08:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <aOyf5FxH8rXmCxLX@infradead.org>
In-Reply-To: <aOyf5FxH8rXmCxLX@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Oct 2025 08:43:16 -0700
X-Gm-Features: AS18NWAw--9GoJimKYZPU6XtnCpJ2t59ru9kAaQP92i8jW-vrfiHymNpWuM0LSo
Message-ID: <CAJuCfpFs5aKv8E96YC_pasNjH6=eukTuS2X8f=nBGiiuE0Nwhg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
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
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 11:44=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Please don't add abstractions just because you can.  Just call directly
> into your gcma code instead of adding a costly abstraction with a single
> user.  That'll also make it much eaiser to review what GCMA actually
> does.

Are you suggesting to fold cleancache into GCMA? GCMA is the first
backend donating its memory to the cleancache but other memory
carveout owners can do that too. The next two on my list are MTE tag
storage and memory reserved by kdump.
Also note that the original GCMA proposal from 2015 [1] used both
cleancache and frontswap to donate its memory. We don't have frontswap
today, but this shows that it doesn't have to be a 1-to-1 relation
between GCMA and cleancache.
Thanks,
Suren.

[1] https://lore.kernel.org/all/1424721263-25314-4-git-send-email-sj38.park=
@gmail.com/

