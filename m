Return-Path: <linux-fsdevel+bounces-22590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A0A919D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 04:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E64B22473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAEA8825;
	Thu, 27 Jun 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX4Y9+eW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC85234;
	Thu, 27 Jun 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454054; cv=none; b=soPsCosQwhFwKh5VMDEKRX6+mBb05PYHYaF2btNEgPldQKWpKYKK9AVQSuUxE/JgO04Z6KGayr51nm1iKwKg4yYeqaKC8vdjSTir6sJVycTZIgW5OxqJpHUZefiEvV53YRtI+PjUpvNKODEIbi5qGY3C2YYo9FRkzQDvRkJrQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454054; c=relaxed/simple;
	bh=uAsxrwWqe0dEgc71aHZyVKCndm0KywjOXYB9+MFspEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUqdQW8jTL4Bks7zRLBbef6fhaJMEc9NzGff2Uri38V5Mla77P2JTNLenkmgRxxLTQ6GiCSp2YZhbo09X5+mqj7oWQjaYZILIoNwqCGaEpaZBjsAkL6XWvSXjaHrED2avH81agWnKrgfhDR7n75kIZxkSAPdvOeCD8xrgsNd/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX4Y9+eW; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d562930e0bso179089b6e.2;
        Wed, 26 Jun 2024 19:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719454051; x=1720058851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAsxrwWqe0dEgc71aHZyVKCndm0KywjOXYB9+MFspEk=;
        b=FX4Y9+eWL5AMgiARPr8/22+PW3wkwGj5MT8+OExjng8T4hiTiF3QZXkRcKLaeThAdr
         d4bm/j/C+m4MAH4eQLZrXLHrcf+CXJ63U/PAK4dcclLbdKZmaa9q1rq9BslVt2P6kF/K
         eq6ZU/tZr7WjDoj0wUZeo9rK2j8PpcYLUPnvI8wmBYZbmwEJlaHDJAaSlwF2chQMhCsS
         DMhJ27j5kID5+E+fDJAh7KG4EGbt3/Y6FuIaIIhAmjmBDzcPrL0SNP5OfuPYjlyyh+W1
         MijNL9DAuDWcJKZQN4O4l/3NHD+gvIJkIFC85jTsxgBxflhTPL+SksdwBTxm7A8w8lqn
         y3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719454051; x=1720058851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAsxrwWqe0dEgc71aHZyVKCndm0KywjOXYB9+MFspEk=;
        b=abxBw2w7Y12yCzAGmtRc66qqdQBI7vg7VvTUBIPB7dIiabVq+qhvywGLCio8KTI2+1
         KpCk7h41A80+bxzRaLTGVxFAkAztjoL5/1SFEw3Eg+7hiLdu2CTIa3siuGq/O893mtcS
         6wzuHhfGdoRDscP/Y2SgmaFL6nHFy4OpWOFf8KOvPfQersgIVgMSxSz/OcVtsb34ZIbo
         mPKB2sD5pHRKubdQ96odo85dtk8LxpODazJH7Z8VrmIIf6cqLG0N1nOVXXEiKipQ6kcz
         WDn1s9/gRMDRdvZm2bUc/y5ZtYcxoCu9kqyX+YemUdotPPdrnY74KC35RmM4ORu+qYMU
         TfOw==
X-Forwarded-Encrypted: i=1; AJvYcCVgYewnifMl6A/KxuSnFPQnDrK38ga7L2X5SrGjR+LEnlmSm4VUVIzDkyJGyJHzHzAv/qNTLdiOzSbZ8Zawys8IOZSiinej5fxqdbYSvxSh+m9O460GgXIAU0uZdNEoQ2GtQvcFXNUoWqnIfA==
X-Gm-Message-State: AOJu0Yy1kstXjTWoJXi/2h+27g7t0BdAEPJXOHcyTCPv5iHI4XRHVZQq
	HsTNO2JE0Crwk3I4gYfYrcOoSBi+67QnaOHX7PXAyeX6/Dm9VY4K/jRurQ/KJ9dMyHB56hAhEEQ
	1kScCJTdHKJIbi40mTvyWCQzztzU=
X-Google-Smtp-Source: AGHT+IGptgGnnp3aDtiA/7Klbpt7M7ONzLx2jQSVj7o5D4wFUkR9yYJM1L3Fe69J7bvjS53cnaXX3sx6YBvTj+vBTi0=
X-Received: by 2002:a05:6808:10d0:b0:3d2:1b8a:be58 with SMTP id
 5614622812f47-3d53ecf3880mr19322117b6e.3.1719454050480; Wed, 26 Jun 2024
 19:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com> <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com> <Znwwrnk77J0xfNxu@casper.infradead.org>
 <5a31d145-19cd-4a35-9211-dc5091069596@arm.com>
In-Reply-To: <5a31d145-19cd-4a35-9211-dc5091069596@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 27 Jun 2024 10:07:19 +0800
Message-ID: <CABzRoyYyZ4WN0Z2oCM78F3sAuekn_Eysy02YcZMuf9tMTkS-eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn, baohua@kernel.org, 
	peterx@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:18=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 26/06/2024 16:15, Matthew Wilcox wrote:
> > On Wed, Jun 26, 2024 at 12:07:04PM +0100, Ryan Roberts wrote:
> >> On 26/06/2024 04:06, Zi Yan wrote:
> >>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> >>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>>
> >>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> >>>> pages, which means of any order, but KPF_THP should only be set
> >>>> when the folio is a 2M pmd mappable THP.
> >>
> >> Why should KPF_THP only be set on 2M THP? What problem does it cause a=
s it is
> >> currently configured?
> >>
> >> I would argue that mTHP is still THP so should still have the flag. An=
d since
> >> these smaller mTHP sizes are disabled by default, only mTHP-aware user=
 space
> >> will be enabling them, so I'll naively state that it should not cause =
compat
> >> issues as is.
> >>
> >> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for a=
ll mTHP
> >> sizes to function correctly. So that would need to be reworked if maki=
ng this
> >> change.
> >
> > I told you you'd run into trouble calling them "mTHP" ...
>
> "There are two hard things in computer science; naming, cache invalidatio=
n and
> off-by-one errors"

Totally agree. Naming things can be surprisingly challenging ;)

Thanks,
Lance

>

