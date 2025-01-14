Return-Path: <linux-fsdevel+bounces-39165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CD9A10F4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F96164A19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CAD225792;
	Tue, 14 Jan 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qmv3qgFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A51225771
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877818; cv=none; b=XSZw1qDdSLfEQNDNDfb6YW/XgLwutWb16639+O470ucPWc6/e/M1Af6tMpZoSvELaBQnu5ucD4yY2N07Ve8nLDyHd+Kqm1BIfoakbhZJm/qJAh4t+7qETaIN/ixreNoB3jlNBHGr6zUjjGx/v/7R95H5fmTUQEB/7KXbLT+LoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877818; c=relaxed/simple;
	bh=Xis4m9NUF4RvqFT2ixotNDRdla/lGDQAY24VlW1v4t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTG5J0BJ2lvH4VBjkln/+skp4A7NFgE0s8IknfPaYZxGoD2iYVFU0hbm2n1/YRicEzkG/MvmaO4POxOA8um5YSKwdz8HmeRzlPi6HhvbPjwEYmrQB5aR2f42tLXWi2KFpQBXQV//bzMSt5atXYdrtLn6eJp8cTTfG++jBLY6cUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qmv3qgFC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so55069176d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736877816; x=1737482616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCDM3nH5nsddwHhx2RaJOUmEIWUcGJSFM1b2iKFUASA=;
        b=Qmv3qgFCrok4EhoU5dVtp8PLHedKBSkwLKRVPiNH5Qrfnqtgdeb06Jd2kRoU6LRyWe
         /f3VCi1amaUZyPNBcmnWONma+vjA2wIyKc4Y6UdJGIr26WbZhgBbLqOR2VgMriFNcJyd
         SqSSHDagcu1vipo8xfTogmt46OArW3cNJT0OK1Rvf7wMPA9rjKbUxsFr6M5cphr+LD5d
         o3i1uf6tZ59gKvUyjnVkVLlxt45w32GotPOLOnJ0TNJR1tUCAwtG8EwyUVLEgTgHV2ha
         cfdlDwAJP6eL4x5H4id8Lgsn3Tm3MIXbizOHlAC4Bsv6uJX5BBqqEjMByRFBouszMCgP
         0VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877816; x=1737482616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCDM3nH5nsddwHhx2RaJOUmEIWUcGJSFM1b2iKFUASA=;
        b=nS5GoSTeafbrqBiTjiDuYs2hnTP0qWvo9XxzUHQzYnciREEPDJbBqu31LuhtmuBxeI
         Pc71T8KusCbojQdehUa08VEi/NAGzzBFsUbayYTRO302rCcIKQNgm3NFDLHewq4YuIyw
         22Gs8uJ+DjdLIig/+7J7Lrc/GYTWN0bDAxB7qIq4ZI2H/m5xoEr254NTcH2WEMFxfzvj
         DQjNykNXC6jCy7k1dE8whl3+YPoOiv/exr6WLVMI/i891QVWNI21UGXtTZLmaVtiY67M
         iiRuJoBxzB7dfCaG0NC7u0GOpid1m6Qb8hoWm3SRyj04rX1MlGNZ1RxolOn/uRE0tsfd
         41Fg==
X-Forwarded-Encrypted: i=1; AJvYcCViyA1Uavw15KRxWjvHKBGAFtbpzxL4VRCWR6cmnkdqD80zhOv9U3PVT0sHNXKMsoaMhfplaadjbzaHFyhr@vger.kernel.org
X-Gm-Message-State: AOJu0YylfSWOcp8pmSj4Kqn6LDJiVgckvN4Ltk3ebHq57Y1xh9+dKV+V
	wmaElhuijS8+sHtW3qQaNWi5aMe0Q4WhIkl2Jbs1JgpS006Hu8OYdaq2VtBs0DHkkvnVDjMKUgS
	Y8W7Wn2hM7DaHTS8ctI6AJAoULQDQrnK5RtoU
X-Gm-Gg: ASbGncuU9bB2RNCx58+8MDVufZWVm/Q4wQZfpcdKcBMyL7cb0Q+ZEQ3QMt5Z0Ys3Rts
	92UJdh2jbqSY4YYYMZCDL+2yRavUumGJln7UVO1Eca1wz/pvmxotnI//zs1GdmCQrzfKX
X-Google-Smtp-Source: AGHT+IFGbuWEbA/VXL6JtTCiH5khxzq5smFlxJG6dJ+DoVw7dHdiOta9Wy11BiH/OhRxCrhzSnn1aPsUJ6zkleOgF28=
X-Received: by 2002:a05:6214:4002:b0:6d8:b3a7:75ba with SMTP id
 6a1803df08f44-6df9b333a5bmr404226066d6.45.1736877814969; Tue, 14 Jan 2025
 10:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
 <CAJD7tkYH8KO8NLJY564PRAmW-mtMfDCMTECGKyYyVAf+JtTcRA@mail.gmail.com> <sct6vvupd4cp6xt66nn6sfs7w3srpx6zcxxsn6rz5qo4tz3la6@btdqsbicmrto>
In-Reply-To: <sct6vvupd4cp6xt66nn6sfs7w3srpx6zcxxsn6rz5qo4tz3la6@btdqsbicmrto>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 14 Jan 2025 10:02:58 -0800
X-Gm-Features: AbW1kva-gyu4zE6Wcq68qpyyzNdu3annXYt-FkuQBdGnmZoPJXjoi47oGp9e6C0
Message-ID: <CAJD7tkZwgKRc2kbY9WutC8meOV+CpQSpxKSpkUorEneJJuX9og@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm/swap: Use PG_dropbehind instead of PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:12=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Jan 13, 2025 at 08:17:20AM -0800, Yosry Ahmed wrote:
> > On Mon, Jan 13, 2025 at 1:35=E2=80=AFAM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > The recently introduced PG_dropbehind allows for freeing folios
> > > immediately after writeback. Unlike PG_reclaim, it does not need vmsc=
an
> > > to be involved to get the folio freed.
> > >
> > > Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> > > lru_deactivate_file().
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  mm/swap.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index fc8281ef4241..4eb33b4804a8 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -562,14 +562,8 @@ static void lru_deactivate_file(struct lruvec *l=
ruvec, struct folio *folio)
> > >         folio_clear_referenced(folio);
> > >
> > >         if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
> > > -               /*
> > > -                * Setting the reclaim flag could race with
> > > -                * folio_end_writeback() and confuse readahead.  But =
the
> > > -                * race window is _really_ small and  it's not a crit=
ical
> > > -                * problem.
> > > -                */
> > >                 lruvec_add_folio(lruvec, folio);
> > > -               folio_set_reclaim(folio);
> > > +               folio_set_dropbehind(folio);
> > >         } else {
> > >                 /*
> > >                  * The folio's writeback ended while it was in the ba=
tch.
> >
> > Now there's a difference in behavior here depending on whether or not
> > the folio is under writeback (or will be written back soon). If it is,
> > we set PG_dropbehind to get it freed right after, but if writeback has
> > already ended we put it on the tail of the LRU to be freed later.
> >
> > It's a bit counterintuitive to me that folios with pending writeback
> > get freed faster than folios that completed their writeback already.
> > Am I missing something?
>
> Yeah, it is strange.
>
> I think we can drop the writeback/dirty check. Set PG_dropbehind and put
> the page on the tail of LRU unconditionally. The check was required to
> avoid confusion with PG_readahead.
>
> Comment above the function is not valid anymore.

My read is that we don't put dirty/writeback folios at the tail of the
LRU because they cannot be freed immediately and we want to give them
time to be written back before reclaim reaches them. So I don't think
we want to change that and always put the pages at the tail.

>
> But the folio that is still dirty under writeback will be freed faster as
> we get rid of the folio just after writeback is done while clean page can
> dangle on LRU for a while.

Yeah if we reuse PG_dropbehind then we cannot avoid
folio_end_writeback() freeing the folio faster than clean ones.

>
> I don't think we have any convenient place to free clean dropbehind page
> other than shrink_folio_list(). Or do we?

Not sure tbh. FWIW I am not saying it's necessarily a bad thing to
free dirty/writeback folios before clean ones when deactivated, it's
just strange and a behavioral change from today that I wanted to point
out. Perhaps that's the best we can do for now.

>
> Looking at shrink_folio_list(), I think we need to bypass page demotion
> for PG_dropbehind pages.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

