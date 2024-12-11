Return-Path: <linux-fsdevel+bounces-37098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB969ED812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C16280E90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FE20A5F9;
	Wed, 11 Dec 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDs4/3cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FD18BC3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951098; cv=none; b=cPysXW1PGwGqjTZrB798NbJVl0ZeMiNEMzUd2o5fg3rcXeVLNTP7f3c9heFNkobNplPsRaPEwHo8/H9yfOyHVK3IYV2eid1y63BPR21XuzYNVwaq2EF/mCwGWW8Segz40ZCBUA8+tIxIWVUzdEV+njzeXE4VKqz2ZdBZoZcbLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951098; c=relaxed/simple;
	bh=+Cf3oovlm/ZExOMcqgcORqmXKuiXzEZv/52+o8tLHL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDVGgh1RZnT8VzFXp24TjDmPEGO/VwuhNl/+q634YRaLqyzwdWTqUPUROH9XpnQUmMpJliHj/ItYl5qkOojKucQZqT3IXnKYKFV1M1Uk+HRrceSzHv0zltFAyx1zXgnlLiyZ960hiJhRl0ioLYRmjLAW5maApiX6L/N+Yw122k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDs4/3cw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4674c597ee5so38344711cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733951096; x=1734555896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q2I4zy3M6EeJd/ZyPKlx+FRhFml4U9G1EufQ6UzLoc=;
        b=nDs4/3cwwQnFk3Lb9kZ2wLPvMzZg7pnRLBsqTh3aCShR2FrgBfE8mL4LuGFMhfL/g9
         wCa1Of3ikHpRu0L9xdNA95c9ANiT5XFV5lKTaB5XPy7rEqTV0C60ytQYWIJXmg33X2+6
         LGd24wGeBPtGyO1nfYhet5Rv6MYgBdUt/w6ZMRUBE8RM96auRK39jYcJb7zaRP4/HCa9
         L3bKGGkmmATprWXqWlA+k2/8Ah0jxa/K+TwgTdoa77BrC3tD6w3TNriqBMLhKUXQ7g57
         mJP9Bg4xSNJPMJ7hfYqXB1FyJK6sn5db0W+ZuEs4G1xkEbbweSqhjlH1L/4pYHgfT9Ov
         WPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951096; x=1734555896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4q2I4zy3M6EeJd/ZyPKlx+FRhFml4U9G1EufQ6UzLoc=;
        b=FP0PUkyBENZGmM5xK/E1Od4f4HdLYGccphwZpVChwk+UlTWTDGWvfzNlhaUOAPos4y
         B9OTdObnNtxDHAcaU3/7ghPj7/fCrYyONuGulcTji28/gmwKQKqg4UxC9fELls3p/t75
         +qypLvhDMJmPcRlzqTu1tDpGQb953ntEdl6S/o/8hPsdXS5Nq/pS8WHBvyaJXWTRMxDC
         snlfm3ZYx1DrA3n0YzG8Qo1iWaY97qGn0SYxK1Ck9x3ftgNpQvouD6azw1jIv7ScqrsE
         yHJRuPi6EAidBfBtHsllYQLFyzMstHy9RpPv3veBBLj0UpzFj3i0u1LGMwkbyGJGZmyN
         Wt7w==
X-Forwarded-Encrypted: i=1; AJvYcCWKu//pMOgAdYW3/xU/qu3by8Tq7BYcvV6wiSm/X3wgUuz2SUuGR4zo/Xg3xbxugCT3seYI2a+M9iN9OTXS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Y62l4pwe5VZeUTOrqjD5GJRQPXyRtfFxkPQlz34IziKT8F0q
	bVi5shYJ77CecgZpMiImgLTaSskZD8ty0YMkz68SwAC/z0XePxIHyntWTs/N8ZrO1T3Y66sgN1x
	MtKLWM0jXNtZyalIhWaxz/tN4JEw=
X-Gm-Gg: ASbGnct5iEgyHuNb3F28qbYrM31ycGXr0/YaQMy9Iknblt7fewS9sW9QzV5jMnv6leI
	uEOAp5sUoJJzLIoTSwJVSOYAiFSHvIohODH5G6YcV9yiNLWaKUTo=
X-Google-Smtp-Source: AGHT+IGAxn/wHS8B+fK5V/yrvTJ4vPqFYTYT3vfCTyCR9BD3AtZBquPwERjl/tHmV9k/48JTXOpyRePD4bBNsdB4seo=
X-Received: by 2002:ac8:7dd0:0:b0:467:706f:14b1 with SMTP id
 d75a77b69052e-4679615af71mr15636351cf.2.1733951095817; Wed, 11 Dec 2024
 13:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <20241125220537.3663725-11-joannelkoong@gmail.com> <20241209155042.GB2843669@perftesting>
 <Z1cSy1OUxPZ2kzYT@casper.infradead.org>
In-Reply-To: <Z1cSy1OUxPZ2kzYT@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Dec 2024 13:04:45 -0800
Message-ID: <CAJnrk1YYeYcUxwrojuDFKsYKG5yK-p_Z9MkYBuHTavNrRfR-PQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] fuse: support large folios for direct io
To: Matthew Wilcox <willy@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:54=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Dec 09, 2024 at 10:50:42AM -0500, Josef Bacik wrote:
> > As we've noticed in the upstream bug report for your initial work here,=
 this
> > isn't quite correct, as we could have gotten a large folio in from user=
space.  I
> > think the better thing here is to do the page extraction, and then keep=
 track of
> > the last folio we saw, and simply skip any folios that are the same for=
 the
> > pages we have.  This way we can handle large folios correctly.  Thanks,
>
> Some people have in the past thought that they could skip subsequent
> page lookup if the folio they get back is large.  This is an incorrect
> optimisation.  Userspace may mmap() a file PROT_WRITE, MAP_PRIVATE.
> If they store to the middle of a large folio (the file that is mmaped
> may be on a filesystem that does support large folios, rather than
> fuse), then we'll have, eg:
>
> folio A page 0
> folio A page 1
> folio B page 0
> folio A page 3
>
> where folio A belongs to the file and folio B is an anonymous COW page.

Sounds good, I'll fix this up in v3. Thanks.

