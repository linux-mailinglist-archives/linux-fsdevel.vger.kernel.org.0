Return-Path: <linux-fsdevel+bounces-18495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AC8B97E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7621F220CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FF55783;
	Thu,  2 May 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LljLcpwy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CD208AD;
	Thu,  2 May 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642704; cv=none; b=W4AOj6Z5wy3DPVG9S5jwthvQAQwqMabZ+oTjzPr8MeGH5LrTMs/Ayfm3WTKkwYOiU8nMWtEhSq+QHgIgKs7ZyMclQayzwK4N20jwGXK02tl3pc511CvrkyjlrRDOoe9Fo0Bs2epWP0c43cgTnR+/xZsh/1C9Yr7yfyME/L4+He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642704; c=relaxed/simple;
	bh=RT+IUJGXBO9C/LDd+jhtRqq7bxM9alVUycQ/IhZBCEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qenYeXYh4D8vma4JoheA8LrWRkHEgBmadBYPT2ckSE5Xz0Tti37uMbHj00PVOPsjTByHEqxWMiXf/X8nLkjgip3G3FLuyL+0j9JYBCdMuatHueKHlLNNgM17Y1G/ev3UzATyIRlzNmrtqOb6oGk5jye3+/h8vM8FAYlPpS1yzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LljLcpwy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so89849961fa.2;
        Thu, 02 May 2024 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714642701; x=1715247501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT+IUJGXBO9C/LDd+jhtRqq7bxM9alVUycQ/IhZBCEE=;
        b=LljLcpwya0Z565DBt638kV5V0Wr7BYkFUL6fq6S396+hEqPRSrSly+x8xSu5fm2etj
         k+mXRD9hTlG4qdPpMEXkz2T3bLoApPvnkp9j/FOl1aEUF9cf2P7MuRCNe3AUA/iXoZt4
         PIg+1EdDWAg7RkOWWDx7uh5Jiv+zc7vOXq8v9fUrS+3QiPQu9zAl28OPSj3M16CZEfoq
         QSdRpFTln6Z8RCrgwf5UCebxbYRCj/nbrgqStG4CHZz+4NjTFvTxCU7MvZdnHmW485FY
         RZyuy6zYm8agiTq4Av00ezQEIQxwpEVRCaxR3JheWYhr8z+Yw5kcyzgXJlwpIpUal6b+
         tTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642701; x=1715247501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT+IUJGXBO9C/LDd+jhtRqq7bxM9alVUycQ/IhZBCEE=;
        b=KUzbiiDGNXAIyh/VA8c8Yg7sy3r3NrzXhhPoCYsZr9y5MOJ3sGn92V9llb0UWwVf3u
         WMn0MT5ZKLlTEcY7DucsdWtnGa3f14jhwIBa5nPV++9GuUjZTkRD3SbRluTOHUjrP7wH
         /+jti1xWrDzpNydBhcW/k6CQ2rnpkutliTJ7d9C9AwDKR+kpplgpTP/mAZ1b4I2u6oPi
         6j6oWzTAvSr2Z06WT04ShPgsLU03QaIyVgEK9PVKEkK3/7qfUfB/zui3pdndve7orxRG
         y7bYqfDT1RX96SS47R0KVqKQ6YuDj2N9cGKLK68oUHBhJ4svnCCiK7CM86W/Tw0hHyas
         1n2w==
X-Forwarded-Encrypted: i=1; AJvYcCVAf5wKEDPsotcdl9LwDglaejWUc4YatyYNK0wRIY6h/lXdXu7T+RrM0PtBfRNqfimTIIj6JESpw28xK5pVRDDF5q6T58b/KtPUn0XdtbeHUiBBBcE4Q4KDw4D47v8ONS56UDsoW16t/AEg7Q==
X-Gm-Message-State: AOJu0YwmniDLGWCMT81CplYDc8+N2VsOyOI224eSUZzAcqVZMXGcWab5
	SZreLgTTgUXCzDcNDSux53xNFoYoAcM1Wae2IgUDyeiD5+z4oDiZjuZHa3XLBW80zvdouFX9Z8R
	NOJXYieWqAN9ApbWEXnAGqu/CFzpPRNNBVlsVqiIc
X-Google-Smtp-Source: AGHT+IG98lXtQ9cRetkzaEILNd/49VPwW0+KR5BV0I6pMw5yI7zsCaudKNFMJLInG5As2tNliEGpHB1I4xCkwHl9u7k=
X-Received: by 2002:a05:651c:235:b0:2d8:59cb:89ef with SMTP id
 z21-20020a05651c023500b002d859cb89efmr2738989ljn.24.1714642701090; Thu, 02
 May 2024 02:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502084609.28376-1-ryncsn@gmail.com> <20240502084939.30250-4-ryncsn@gmail.com>
 <7636ada9-fdf0-4796-ab83-9ac60a213465@redhat.com> <CAMgjq7CD=r9TP4PSe2MqR=r-+PnMB-N6yYbFRr9U=B5ZBvTPtA@mail.gmail.com>
In-Reply-To: <CAMgjq7CD=r9TP4PSe2MqR=r-+PnMB-N6yYbFRr9U=B5ZBvTPtA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 2 May 2024 17:38:04 +0800
Message-ID: <CAMgjq7CPkHLauHfaDweoGUHxLxvkj4Vb1hEbw==oWa6aGgSTpg@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] mm: drop page_index and convert folio_index to
 use folio
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:32=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Thu, May 2, 2024 at 5:12=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 02.05.24 10:49, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > There are two helpers for retrieving the index within address space
> > > for mixed usage of swap cache and page cache:
> > >
> > > - page_index
> > > - folio_index (wrapper of page_index)
> > >
> > > This commit drops page_index, as we have eliminated all users, and
> > > converts folio_index to use folio internally.
> >
> > The latter does not make sense. folio_index() already is using a folio
> > internally. Maybe a leftover from reshuffling/reworking patches?
>
> Hi, David,
>
> folio_index calls swapcache_index, and swapcache_index is defined as:
>
> #define swapcache_index(folio) __page_file_index(&(folio)->page)
>
> Where it casts the folio to page first, then call __page_file_index,
> __page_file_index is a function and works on pages.
>
> After this commit __page_file_index is converted to
> __folio_swap_cache_index. This change is a bit of trivial but we get
> rid of the internal page conversion.
>
> I can simplify the commit message, just say drop page_index to make
> the code cleaner, if this is confusing.

Ah, you are right folio_index is not a simple wrapper of page_index
indeed, that sentence in the commit message doesn't make sense, so it
should be deleted, my bad for this leftover.

