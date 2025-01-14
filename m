Return-Path: <linux-fsdevel+bounces-39163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A166CA10CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CDF3A1E69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B6148FF6;
	Tue, 14 Jan 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTVmhxiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60C1B5EB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874152; cv=none; b=pPX0ZK0Ee8uR/UOVM5o5+PY6AyOphs1qkLqa7PuKCMtdNOuhQaFpIhbM2xo8IhgrKkEormWbnBMB91TL6gj45MeIuL6r/G+Kqo8PCdJAMas8XaY4osaoF2jfFw3WgVsocRyoX0GkVM8Daj6lfPJKU0LChs4uL6tkU+sEykF5HyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874152; c=relaxed/simple;
	bh=J6uEQzZcylwtUsZHDXV5clkEHTBFI9vrV8x9KgLEz18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRPQyH0s8aK51N37JPQMQveXaYfVcKZ0eh+yGjoG51xkXyzU3EQg6NOsg7rdOmK7jfzWFf0lQkqKoeaWINuiABCKmM3gCQVmsS7LPY67cKGgkAuPdXaKg09yJO0FvuO0vgZ5ev86j0CuWEDLtdCtpbFnxfRtg6qgnK2HSybGmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTVmhxiw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be3f230436so193613085a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736874149; x=1737478949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pwRPv3AC50iLCk2Zf2oVFdf10HsOLZLViQlkbWzupw=;
        b=RTVmhxiwAKKCpP0RjGqjaev1/93aAc6gMtFfVwsQjNHYGyfX7WgUeFHWFEvsTn1Jvg
         3x+regxlB8cTX1HJ+f40pVpuubiBGaB3TVFHGDdFn0Mquwed6mKZsfCP/xvgj2B3y3+M
         lOFbCkSnzj4kbNPQhxabrO5cgyDPN7BHGbA6ks6zKsRWdasT1KFeIZ0QKwPkGKKm0ZK3
         dmgYvlWn4WCIKFaQAARXykEoN10ggaWgalCw3IFZ7qQxq3/SG3eukB/Z35I86V0hLyL7
         JTr/kRi5FbyOuBrpsgOQg73whbUfah4D/kz7/rzreWKAQ/QsnlDGvJPgP3I3wyf4TY7X
         pTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874149; x=1737478949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pwRPv3AC50iLCk2Zf2oVFdf10HsOLZLViQlkbWzupw=;
        b=oUrG8U/RDrNUuvw7p6gJJriIsGpaCh9602nD3i9yQrj0/JArvrc2ijXyM3F0lx/TKw
         GvZ0lO+l8EbpUd6oBmkMrLyHQJjkChh3DX+jWjmll3wuU9bYYLsiVvCSPlU2tDMUH1gu
         QnOUxyA3/rUxQMu+4x7cqdQ0bS7QwSVV7SqsiznSetBrdVmbVPHmgMy5RTE9en3M4bcL
         nWtAqgFDjQlcTHPeVoGI6RoURGRTd3zXRgmzFUj9mdLnnidyNCsqdSoZ61Xl/Pg7JofQ
         Y4enuvh+UQmWz5I09m81O2hunEFxiZaJ48b4syF4zKd/nGkHVKy4pUo5mtVyISzkOb3m
         C5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXR+SnPv0Y3lL8bvrZbUAgQ4RxdsUbAsUVBMk1QyjM5DjIDzv/1IhmULh5g9wntWO4WYGrNDxY3k97KKv0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKiW/qnT38qRPLZ5junuCh4NukYzMy2wYOISjeiV4jxtqT3Fl
	rDkEqTtkpkD8QU+nYR76Ti+ZQSghKEJ7one2nS5QVehS/1MUajEO36B7e2KEG2cAY0Dtn91wzeJ
	r6a+4TbScNNLhAqN6ZaLvLxauXBTkRCNqHCXs
X-Gm-Gg: ASbGncsjvAPlMjlhqvjA0ypmj/qfdj+jh5gm5ta2dyQroniTYb7xoOyb3X/9zl/aI+w
	vJGCOqgiK8E5iDhNXz2Ory4fZqzYGesHJQRN2b5EF7RoR1GW+thVaGFC7NGP2hKnOk3ntvks=
X-Google-Smtp-Source: AGHT+IEmCebGY2XiXiMSHiPH6lyzErlM2sxmSzBWB4EBYHNDzzHKKbPlbhF+bpXyENdSkK3zvR6V00VYB1KaeeKmh74=
X-Received: by 2002:a05:620a:244d:b0:7b7:142d:53b8 with SMTP id
 af79cd13be357-7bcd97c97e1mr4649151185a.53.1736874149139; Tue, 14 Jan 2025
 09:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-9-kirill.shutemov@linux.intel.com>
 <Z4UxK_bsFD7TtL1l@casper.infradead.org> <vpy2hikqvw3qrncjdlxp6uonpmbueoulhqipdkac7tav4t7m2s@3ebncdtepyv6>
In-Reply-To: <vpy2hikqvw3qrncjdlxp6uonpmbueoulhqipdkac7tav4t7m2s@3ebncdtepyv6>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 14 Jan 2025 10:01:52 -0700
X-Gm-Features: AbW1kvYQkyXZbUdcH1QNEYpQQw7S18-Qu-i6iGpqw5vVBDdyuuTWt_dBq2WlT1M
Message-ID: <CAOUHufY+BViSYS14tfN8EOhuE05KneG2syHhVCyFPppkmDH=aQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] mm: Remove PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
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
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 1:30=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Jan 13, 2025 at 03:28:43PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 13, 2025 at 11:34:53AM +0200, Kirill A. Shutemov wrote:
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index caadbe393aa2..beba72da5e33 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -686,6 +686,8 @@ void folio_migrate_flags(struct folio *newfolio, =
struct folio *folio)
> > >             folio_set_young(newfolio);
> > >     if (folio_test_idle(folio))
> > >             folio_set_idle(newfolio);
> > > +   if (folio_test_readahead(folio))
> > > +           folio_set_readahead(newfolio);
> > >
> > >     folio_migrate_refs(newfolio, folio);
> > >     /*
> >
> > Not a problem with this patch ... but aren't we missing a
> > test_dropbehind / set_dropbehind pair in this function?  Or are we
> > prohibited from migrating a folio with the dropbehind flag set
> > somewhere?
>
> Hm. Good catch.
>
> We might want to drop clean dropbehind pages instead migrating them.
>
> But I am not sure about dirty ones. With slow backing storage it might be
> better for the system to migrate them instead of keeping them in the old
> place for potentially long time.
>
> Any opinions?
>
> > > +++ b/mm/swap.c
> > > @@ -221,22 +221,6 @@ static void lru_move_tail(struct lruvec *lruvec,=
 struct folio *folio)
> > >     __count_vm_events(PGROTATED, folio_nr_pages(folio));
> > >  }
> > >
> > > -/*
> > > - * Writeback is about to end against a folio which has been marked f=
or
> > > - * immediate reclaim.  If it still appears to be reclaimable, move i=
t
> > > - * to the tail of the inactive list.
> > > - *
> > > - * folio_rotate_reclaimable() must disable IRQs, to prevent nasty ra=
ces.
> > > - */
> > > -void folio_rotate_reclaimable(struct folio *folio)
> > > -{
> > > -   if (folio_test_locked(folio) || folio_test_dirty(folio) ||
> > > -       folio_test_unevictable(folio))
> > > -           return;
> > > -
> > > -   folio_batch_add_and_move(folio, lru_move_tail, true);
> > > -}
> >
> > I think this is the last caller of lru_move_tail(), which means we can
> > get rid of fbatches->lru_move_tail and the local_lock that protects it.
> > Or did I miss something?
>
> I see lru_move_tail() being used by lru_add_drain_cpu().

That can be deleted too, since you've already removed the producer to
fbatches->lru_move_tail.

