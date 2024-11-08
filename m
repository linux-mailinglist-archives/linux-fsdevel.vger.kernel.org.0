Return-Path: <linux-fsdevel+bounces-34105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242D9C2744
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB4284F9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2DB1EF0BD;
	Fri,  8 Nov 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMxSiAP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3F233D92
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103182; cv=none; b=HEIW00Df1JsLH3U2w2CFCv0j6D8x2Pv/xJ6wlxzPy4sVByURCIr6bwNJDX4ZY9iDMxUTBBeFQ1xa1NlQx/XIPHRNqRVuv1Wnxj8gjbKb/ceXaAc1JtnIRAykLo4/DqBXmJhAzGCmbRl2ejUFbtpz9J51u+/qE/EEgmvi9s2e4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103182; c=relaxed/simple;
	bh=QA0EnJnSW2B77NDfyX2mYuv2RcjPiiZ/V+Qw9tqZI4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVo/epet6k5JPoDk5D6p6sZ5ZADCoJGCPByrwSqKStGwKK1tr9L/AYPKpjeZxoC1rNs+hjmEUUrhCVrgi4G3TMhuUovVip1jSMEOA3itfyAx4DPIPaxQQbBdN/PVTeaOpSUrm4oNCHcM5WL1afoSVsWTd2/56Knvu2MORmi2Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMxSiAP7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a23ad00eso32173731cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 13:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731103179; x=1731707979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EmE/xkKMxXBW1hJZW1gknUNBtQNSTs3M2bOiwkKXiE=;
        b=SMxSiAP7mrtxty4ug8WknVjSqLNTx/dYf6oB7gfywPMbcDod7+mfh0N59nC3S1j2TS
         yTvp7GpTuQ51yIqLs4oPTtaxZ2bAejjVoyJWiwGbLMnJ/rx0JX0dT5zKHrwlaai5cvuA
         pmAcpO/xv2wLt4UKF0W3aNFPpYMxF3fwDqKZe5IPoQiioHzKoPtJHjIhtcRN1NwCGtmu
         qOSM/AE+y+Q8znZCL9Ek1XwziGx+msWxhgnXldZ+Q4Qep2obQjtuykazuBY8Em9838T7
         q1iXnu4kH+FpW2UuLVR7fY2uVepXad30//d/hY/Ei2F+LmNks5Y4c6V9z9u4QWILPveE
         dbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731103179; x=1731707979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EmE/xkKMxXBW1hJZW1gknUNBtQNSTs3M2bOiwkKXiE=;
        b=LIsJ0Vb4PZgl2/bT7LdnF/qVSg8+duhqeGjB9+fJA31xgfZJa3WmuDI4WDIHcbpKHU
         BDfGK7cNsWOnqIxlGGRtI1pSgD+bcxzKIOq32iR/4hnGsX1pYq4oSvqFTI8VOu7qqJ1z
         jeDQP02t8No4Vf585f9UjLnV2r6CR2SVJSaqlBxFqnT4xQ7BO0EffUgTkpkcip3kCB2N
         JVgYGw++eCJoLpoLsSi6f5/AfM+6WNa6dFJKTP2IfCxlXW6rSNRrBpUF32zahWBUtj+G
         1UIWkw66olvIkkpOuZs4YPQbt2kjwGKmqRUWBw1OH3H2mgco4AbwUblpTXyeqOo2JqFN
         w5mA==
X-Forwarded-Encrypted: i=1; AJvYcCXz2/fJc+/M3geuNcIb1tOQ122YrU3S2HfUoPi6wO2eM4rjJrZXotpKYiAh3ldEMsE+ZTbki/inejAKsQbH@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGn2D2tdPB6+ggg9Szen+Lv6VR6mse0ZZumFK0iEPoD0OMpqV
	gEEHjT4ck4ybKM0Qw/5l0D7H2r6f+6n37pbRUTaZ52tNtzStbxcn9OhgTm1W1wzPxTU9G+omPT+
	y/ZzyTt97emIFwuIFswq8yxG9kXQ=
X-Google-Smtp-Source: AGHT+IEaVgqOaiDInJrP3kyBLWVE6eHkRkjvc+Mp0Kw0OiaUGY2GRb4AfWE8fZEb1u/d2Ey1zFuwCi+nzKiVJCoc0Ag=
X-Received: by 2002:ac8:7f44:0:b0:461:7558:892f with SMTP id
 d75a77b69052e-463085f5466mr78904531cf.15.1731103178783; Fri, 08 Nov 2024
 13:59:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-5-joannelkoong@gmail.com> <20241108173309.71619-1-sj@kernel.org>
In-Reply-To: <20241108173309.71619-1-sj@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 8 Nov 2024 13:59:27 -0800
Message-ID: <CAJnrk1Yo56P4dJ+61Dgtp8A40Jc10H0kt4VNLBVPRH6YSPAUVw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
To: SeongJae Park <sj@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 9:33=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> + David Hildenbrand
>
> On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.com> w=
rote:
>
> > In offline_pages(), do_migrate_range() may potentially retry forever if
> > the migration fails. Add a return value for do_migrate_range(), and
> > allow offline_page() to try migrating pages 5 times before erroring
> > out, similar to how migration failures in __alloc_contig_migrate_range(=
)
> > is handled.
>

Hi SeongJae,

Thanks for taking a look. I'm going to drop this patch per the
conversation with David and Shakeel below, but wanted to reply back to
some of the questions here for completion's sake.

> I'm curious if this could cause unexpected behavioral differences to memo=
ry
> hotplugging users, and how '5' is chosen.  Could you please enlighten me?
>

Most of this logic was copied from  __alloc_contig_migrate_range() -
in that function, '5' is hard-coded as the number of times to retry
for migration failures. No other reason for '5' other than that.

> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  mm/memory_hotplug.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 621ae1015106..49402442ea3b 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1770,13 +1770,14 @@ static int scan_movable_pages(unsigned long sta=
rt, unsigned long end,
> >       return 0;
> >  }
> >
> > -static void do_migrate_range(unsigned long start_pfn, unsigned long en=
d_pfn)
> > +static int do_migrate_range(unsigned long start_pfn, unsigned long end=
_pfn)
>
> Seems the return value is used for only knowing if it is failed or not.  =
If
> there is no plan to use the error code in future, what about using bool r=
eturn
> type?
>
> >  {
> >       struct folio *folio;
> >       unsigned long pfn;
> >       LIST_HEAD(source);
> >       static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTER=
VAL,
> >                                     DEFAULT_RATELIMIT_BURST);
> > +     int ret =3D 0;
> >
> >       for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
> >               struct page *page;
> > @@ -1833,7 +1834,6 @@ static void do_migrate_range(unsigned long start_=
pfn, unsigned long end_pfn)
> >                       .gfp_mask =3D GFP_USER | __GFP_MOVABLE | __GFP_RE=
TRY_MAYFAIL,
> >                       .reason =3D MR_MEMORY_HOTPLUG,
> >               };
> > -             int ret;
> >
> >               /*
> >                * We have checked that migration range is on a single zo=
ne so
> > @@ -1863,6 +1863,7 @@ static void do_migrate_range(unsigned long start_=
pfn, unsigned long end_pfn)
> >                       putback_movable_pages(&source);
> >               }
> >       }
> > +     return ret;
> >  }
> >
> >  static int __init cmdline_parse_movable_node(char *p)
> > @@ -1940,6 +1941,7 @@ int offline_pages(unsigned long start_pfn, unsign=
ed long nr_pages,
> >       const int node =3D zone_to_nid(zone);
> >       unsigned long flags;
> >       struct memory_notify arg;
> > +     unsigned int tries =3D 0;
> >       char *reason;
> >       int ret;
> >
> > @@ -2028,11 +2030,8 @@ int offline_pages(unsigned long start_pfn, unsig=
ned long nr_pages,
> >
> >                       ret =3D scan_movable_pages(pfn, end_pfn, &pfn);
> >                       if (!ret) {
> > -                             /*
> > -                              * TODO: fatal migration failures should =
bail
> > -                              * out
> > -                              */
> > -                             do_migrate_range(pfn, end_pfn);
> > +                             if (do_migrate_range(pfn, end_pfn) && ++t=
ries =3D=3D 5)
> > +                                     ret =3D -EBUSY;
> >                       }
>
> In the '++tries =3D=3D 5' case, users will show the failure reason as "un=
movable
> page" from the debug log.  What about setting 'reason' here to be more
> specific, e.g., "multiple migration failures"?
>
> Also, my humble understanding of the intention of this change is as follo=
w.  If
> there are 'AS_WRITEBACK_MAY_BLOCK' pages in the migration target range,
> do_migrate_range() will continuously fail.  And hence this could become
> infinite loop.  Pleae let me know if I'm misunderstanding.
>
> But if I'm not wrong...  There is a check for expected failures above
> (scan_movable_pages()).  What about adding 'AS_WRITEBACK_MAY_BLOCK' pages
> existence check there?

The main difference between adding migrate_pages() retries (this
patch) vs adding an 'AS_WRITEBACK_MAY_BLOCK' check in
scan_movable_pages() is that in the latter, all pages in an
'AS_WRITEBACK_MAY_BLOCK' mapping will be skipped for migration whereas
in the former, only pages under writeback will be skipped. I think the
latter is probably fine too for this case but the former seemed a bit
more optimal to me.

Thanks,
Joanne


>
> >               } while (!ret);
> >
> > --
> > 2.43.5
>
>
> Thanks,
> SJ

