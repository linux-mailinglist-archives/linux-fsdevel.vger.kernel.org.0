Return-Path: <linux-fsdevel+bounces-57778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFFB25232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A41568198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD12882DB;
	Wed, 13 Aug 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3LT7bT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DB1F582E
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106856; cv=none; b=FQ9mGSsIBz0QEdATrY773pFoo5Rt41S0O5Fl5Afab142HStJju2SUGLhKdh6iQjBDx8phlKxZU4xUosULY/Zzfr84NWG6mWy286RrPsNfUGIXsFT/AQCjoWN6DSHPPlwTPjDKzTcBy3sLLL3Q4i8zm0ERCC649pqUGZLrn+bUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106856; c=relaxed/simple;
	bh=eXxDZAoTn5xWfe0nQlwIXYbEU3z3bGSpg+SUbCtWELA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqzKmYowBuqbduyDXlyIwvYEqJEDltXOU9pBsdEnoopGktcIXzQkS2PK8BMuauBYZrZEM4LsvN0tlBgDt7bDdXXCi6Tt5phuKy7HIn835IpHQDzikXG2lELh+ZrnbWybOazcMviyeUmSjXDkXtyUHapkyfTNMgY9swanx7N/+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3LT7bT2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b1099192b0so2127791cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755106853; x=1755711653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXxDZAoTn5xWfe0nQlwIXYbEU3z3bGSpg+SUbCtWELA=;
        b=I3LT7bT2Rsk1Gqq13SYB+1u2x8cLrD6J1s23cBxBp9poUl9SSa6bvKICEDwUoJl4nb
         um5QpQ5/mklL9pLJlEfrgKBWFaZz7moaXyf2QjPpqwscR8XbONqQngarHJi8jCOaYK1E
         D9KdSeKlV6q+aCmdO9pWoep1M7Yjti9JSVPWcXRcBNNI/qHya7Qi4nj4dKOltesqe+qb
         R/goueScWAvCxjXEPvSUu+GJIXiFOOoqY46+KyuLtqotKDMLxEgMdLU8cZQN32W6MHsu
         h5IFEla2QLxFd1rSTimgXgZEZNUj0xCm5STRyx0AiaGXoj9o1r1a+FfpQe3gYPkPHKrd
         rYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755106853; x=1755711653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXxDZAoTn5xWfe0nQlwIXYbEU3z3bGSpg+SUbCtWELA=;
        b=L9VtQJWevF50XnUxzL1Afxl332wIcPNyDNgivNVfMWbO4m8tGuJlhhYoZdBydD7vkf
         tZCqthMFfRg7CYrXhc8XGnpFSLCZ8Vr3Qsh4L7DSBXnKrML8/MDMd/ATUayLdBYj+yy1
         BMrujxvW/Qktc9xxFZjFzC0aasTjYYMV43vllNAqwx15Ca1Yx64CzUcMoyz/pyiSNEPF
         bFBOeIoyFa5xyM6B2jegm+A1IPcgqW5O0seTmEYpUG3IJixO+pWo6NGU1qCcwA9H6KSq
         6UnHleWXE7Sy9PrW9jwDo6IhSfNq8N3bv94JnIHqtTAoTtCxlrHDyhCQoejlxlrI8NAg
         KrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrUifBE/lkL8x/lRfKGS6BrdQTCUNDcbTVCTWhX0M6wuDW4yKAuWW4F3B4ZVZOaAacWTyerHzgT/36J4Hr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZliXAWDszCUAhiRSvdgeb4rAXbZxXf7S7YG0GN++ytNW+QwY
	0YOgNf5/sM9rm/EyIGcUGkr63ux7xitzWY+JTHSC76jySGQos18S66a8030WIa5ptoATCQbovWU
	aYX/PzLfqzjVUAwoEOQ2u9LQ4CjndvnTU9DXv
X-Gm-Gg: ASbGncvJTdhFB68dN58lTrENItCZfdn4W1liMDXpiUhMjBuwpNXnmA7XSNf54k0El0j
	KdQLIraj2Yk5HtipNOwozKSJWu53VC22PrCEH3l2YMbeV4sWKTTP1IIi7v1N9MvQ+YI0ULQHWKx
	MKa440hDacygUTH+0a510sXLVxPeYHS9thBhuWv7FN17GkYbxC7PbjcJg0aFgtrdc24+poQkq/0
	W8CAtcr
X-Google-Smtp-Source: AGHT+IGdPNG+DH0IR2onYU9pfrlA9o/kheM/uX8IXYL7v73L1IBw9J7MIps8yeDPjqGIuEjz6boiZAl0VG7H30zUKJo=
X-Received: by 2002:a05:622a:588c:b0:4b0:8845:5669 with SMTP id
 d75a77b69052e-4b10aa786f1mr730851cf.30.1755106853522; Wed, 13 Aug 2025
 10:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
 <20250812193842.GJ7942@frogsfrogsfrogs> <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>
 <20250813012017.GM7942@frogsfrogsfrogs>
In-Reply-To: <20250813012017.GM7942@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Aug 2025 10:40:40 -0700
X-Gm-Features: Ac12FXzlxYMeSRaRELHfwboHMhuFZLIIXCHFQY8JN6IS1iPSIen7bj29Z-yelLE
Message-ID: <CAJnrk1b74j2YETzVJ83cdsyojye5bwmUYAymCFrAcDjsOLcDYQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:20=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Aug 12, 2025 at 04:02:12PM -0700, Joanne Koong wrote:
> > On Tue, Aug 12, 2025 at 12:38=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > My understanding of strictlimit is that it's a way of preventing
> > non-trusted filesystems from dirtying too many pages too quickly and
> > thus taking up too much bandwidth. It imposes stricter / more
>
> Oh, BDI_CAP_STRICTLIMIT.
>
> /me digs
>
> "Then wb_thresh is 1% of 20% of 16GB. This amounts to ~8K pages."
>
> Oh wow.
>
> > conservative limits on how many pages a filesystem can dirty before it
> > gets forcibly throttled (the bulk of the logic happens in
> > balance_dirty_pages()). This is needed for fuse because fuse servers
> > may be unprivileged and malicious or buggy. The feature was introduced
> > in commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit
> > feature). The reason we now run into this is because with large
> > folios, the dirtying happens so much faster now (eg a 1MB folio is
> > dirtied and copied at once instead of page by page), and as a result
> > the fuse server gets throttled more while doing large writes, which
> > ends up making the write overall slower.
>
> <nod> and hence your patchset gives the number of dirty blocks (pages?)
> within the large folio to the writeback throttling code so that you
> don't get charged for 2M of dirty data if you've really only touched a
> single byte of a 2M folio, right?
>
Yeah, exactly!
> Will go have a look at that tomorrow.
Thanks!
>
> --D
>

