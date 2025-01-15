Return-Path: <linux-fsdevel+bounces-39225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1AA1187C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 05:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F2D3A064E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 04:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72322E3FD;
	Wed, 15 Jan 2025 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkZxzf3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C091157485
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915325; cv=none; b=sgF55gKDzdlbXV72Kwe+Hgqy5r2gSUSz6ssc0C70qBWUaQoKdJqc3KoleHZp5trR/Uh8Q0XTAvdjNmZTZYvQ925xyG28q/2oG7dg66umgZwRGxSm4nF/qkGf+ROw8o7fOFrUVNBhy2sXlFD9Kz6HejotoIj4p7EU8td4XoQ/Uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915325; c=relaxed/simple;
	bh=783HrnEPNNGNV/kyA+i9KO9899/eCKw5+Lq6r8ALp90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRz+dGNLxfeNo57iFiyBxb9Kth09pssyy/VroUtzW9CoeK515WEwPrqUX/dD+3hHnaXL5X6cOsU9ATqt7wSJdb1AHh7yVngjYg2Pw4tkUBXjHHeBrqCF2FpNq+s3YC0djbd6y6aHMUpwrgSux1gqkt24O0n3D5N1zyIBqPfGWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkZxzf3k; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afdd15db60so1953378137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 20:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736915322; x=1737520122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiaIVXIhhM1sp+r10z/vJyY+tzDQMN+pj3uAuSz6ZII=;
        b=xkZxzf3kO+ucI+RFL7UuLBOeSGbC5hgg08xwZY2GffJ4gm/EhDK9fOA0VcNgsJ1hQe
         E7pjupmq3n+TKEQqz/3WuT6+fdtbaC9iauXrjkYof/BZX/aMxgqbJkHCuW6e8FUAx/Gb
         zU0BkYVrSoJh2RknFS/VGuIlvWFtcmoPY6uXWbyO0BmO1TGHAOOA0YPELm32ExNxyuPV
         6Jss8E8IburXOGY8Y/4imL+mtxQkdifs+JSh6IvOBoUPUs+BwvMVqXbs0xh4g/AIq2+V
         XOAGKJetWuTm90Xr1AgIDDAihCQPi62bLS9jW/yt6aid9S+4aQwcZvGpJlqtt0qRMJr6
         BLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736915322; x=1737520122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiaIVXIhhM1sp+r10z/vJyY+tzDQMN+pj3uAuSz6ZII=;
        b=HdnAgFokySja1q4XfI+AyLvlct9qw6n2t9/omRwep3ubl/nqP6SYPj8UttEpEyRTu1
         /3IjV3r21MNWxO6pud5qj/y4FWTMWm0DTomVPIitK2b+L0/RwiSJNXWTKVRJiifqzs7Q
         uSh6VYZKXNAdSrGVM2vw1tB825QmEPmUMJ1yoBGZSu7rMASk3kdojmoM+q5cOV31qRsD
         aFgA3MWLtqzrr7ItqQae+gAoOXEgT187a6pHcA+MccDws6BcqvwhU3YsHNQRpZEl7Aic
         ZzntWi4gW81hQ7cxRvXePtcLph8Gqzgdhh4J4qPYSO8PcOk8az+7bH6bmWQzEUevQldP
         W8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxq/pRdM+gnAGBa5lmOEdfuTgkDga+Z63RV5gPAllpejdNFsfoc7VhQAezGBieTchjjRzU3FRXzCG4akl/@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqV9ra+EUx8+8Z1oeevYcAVR0scOCQq0Sdklme5UsNfovxmve
	zF7p3HkCsrwU0Z+4YWjvQ1/rZJvVHwslLkuWcC9iNSzcJS398/mSGJCN0Kkk5J/zkT3MvUKULky
	nCZPk02+R285RDHWmgx99OaBHW8ml4sufNJU/
X-Gm-Gg: ASbGnctX4ZCE6K2vduy/oUojEC5T+CT/QQODhUGyHAP73b4OgBd/ltEH38sLopdMwm0
	q4Z9V+n+te7OuHisDS3FCwJwJ3rE0w+DmE/F7qXSaWHPgk3+swCMB3VEp1nWyG9+3gDVF4eE=
X-Google-Smtp-Source: AGHT+IH/FRwv1gjMQVdrZyTpxRo/2P7ZfMOmxND6HntPtKv8PRHbhPpC3eKReWiv2QbmErnwLgBIFI50EeMrfGttcP0=
X-Received: by 2002:a05:6102:370f:b0:4b3:c658:2a36 with SMTP id
 ada2fe7eead31-4b3d0f8f840mr23231900137.8.1736915321756; Tue, 14 Jan 2025
 20:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
 <CAJD7tkYH8KO8NLJY564PRAmW-mtMfDCMTECGKyYyVAf+JtTcRA@mail.gmail.com>
 <sct6vvupd4cp6xt66nn6sfs7w3srpx6zcxxsn6rz5qo4tz3la6@btdqsbicmrto> <CAJD7tkZwgKRc2kbY9WutC8meOV+CpQSpxKSpkUorEneJJuX9og@mail.gmail.com>
In-Reply-To: <CAJD7tkZwgKRc2kbY9WutC8meOV+CpQSpxKSpkUorEneJJuX9og@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 14 Jan 2025 21:28:05 -0700
X-Gm-Features: AbW1kvaBboGLsqdjopVloMA7j9dnfG52vbiddOAszVwHNFJf23o0CFxEnOZVFVU
Message-ID: <CAOUHufYFKZ=agWpS3mFHyDjXs_Tq7VhM=qBayL0FtJis=W0+Tg@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm/swap: Use PG_dropbehind instead of PG_reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:03=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Jan 14, 2025 at 12:12=E2=80=AFAM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 08:17:20AM -0800, Yosry Ahmed wrote:
> > > On Mon, Jan 13, 2025 at 1:35=E2=80=AFAM Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > The recently introduced PG_dropbehind allows for freeing folios
> > > > immediately after writeback. Unlike PG_reclaim, it does not need vm=
scan
> > > > to be involved to get the folio freed.
> > > >
> > > > Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> > > > lru_deactivate_file().
> > > >
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >  mm/swap.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/swap.c b/mm/swap.c
> > > > index fc8281ef4241..4eb33b4804a8 100644
> > > > --- a/mm/swap.c
> > > > +++ b/mm/swap.c
> > > > @@ -562,14 +562,8 @@ static void lru_deactivate_file(struct lruvec =
*lruvec, struct folio *folio)
> > > >         folio_clear_referenced(folio);
> > > >
> > > >         if (folio_test_writeback(folio) || folio_test_dirty(folio))=
 {
> > > > -               /*
> > > > -                * Setting the reclaim flag could race with
> > > > -                * folio_end_writeback() and confuse readahead.  Bu=
t the
> > > > -                * race window is _really_ small and  it's not a cr=
itical
> > > > -                * problem.
> > > > -                */
> > > >                 lruvec_add_folio(lruvec, folio);
> > > > -               folio_set_reclaim(folio);
> > > > +               folio_set_dropbehind(folio);
> > > >         } else {
> > > >                 /*
> > > >                  * The folio's writeback ended while it was in the =
batch.
> > >
> > > Now there's a difference in behavior here depending on whether or not
> > > the folio is under writeback (or will be written back soon). If it is=
,
> > > we set PG_dropbehind to get it freed right after, but if writeback ha=
s
> > > already ended we put it on the tail of the LRU to be freed later.
> > >
> > > It's a bit counterintuitive to me that folios with pending writeback
> > > get freed faster than folios that completed their writeback already.
> > > Am I missing something?
> >
> > Yeah, it is strange.
> >
> > I think we can drop the writeback/dirty check. Set PG_dropbehind and pu=
t
> > the page on the tail of LRU unconditionally. The check was required to
> > avoid confusion with PG_readahead.
> >
> > Comment above the function is not valid anymore.
>
> My read is that we don't put dirty/writeback folios at the tail of the
> LRU because they cannot be freed immediately and we want to give them
> time to be written back before reclaim reaches them. So I don't think
> we want to change that and always put the pages at the tail.
>
> >
> > But the folio that is still dirty under writeback will be freed faster =
as
> > we get rid of the folio just after writeback is done while clean page c=
an
> > dangle on LRU for a while.
>
> Yeah if we reuse PG_dropbehind then we cannot avoid
> folio_end_writeback() freeing the folio faster than clean ones.
>
> >
> > I don't think we have any convenient place to free clean dropbehind pag=
e
> > other than shrink_folio_list(). Or do we?
>
> Not sure tbh. FWIW I am not saying it's necessarily a bad thing to
> free dirty/writeback folios before clean ones when deactivated, it's
> just strange and a behavioral change from today that I wanted to point
> out. Perhaps that's the best we can do for now.
>
> >
> > Looking at shrink_folio_list(), I think we need to bypass page demotion
> > for PG_dropbehind pages.

I agree with Yosry. I don't think lru_deactivate_file() is still
needed -- it was needed only because when truncation fails to free a
dirty/writeback folio, page reclaim can do that quickly. For other
conditions that mapping_evict_folio() returns 0, there isn't much page
reclaim can do, and those conditions are not deactivate_file_folio()
and lru_deactivate_file()'s intentions. So the following should be
enough, and it's a lot cleaner :

diff --git a/mm/truncate.c b/mm/truncate.c
index e2e115adfbc5..12d2aa608517 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct
address_space *mapping,
                         * of interest and try to speed up its reclaim.
                         */
                        if (!ret) {
-                               deactivate_file_folio(folio);
+                               folio_set_dropbehind(folio)
                                /* Likely in the lru cache of a remote CPU =
*/
                                if (nr_failed)
                                        (*nr_failed)++;

Then we can drop deactivate_file_folio() and lru_deactivate_file().

