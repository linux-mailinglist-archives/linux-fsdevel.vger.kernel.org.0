Return-Path: <linux-fsdevel+bounces-16300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52889AD20
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 23:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA931F21AD4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED04F616;
	Sat,  6 Apr 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArScyxrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA84E1BA
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712439777; cv=none; b=G7NfMfGVLNyGIPw21CGtQPcbD+JF7OBSwOrstmllrNz03NqQKPbFKFbrpxICyjHG5l9FiIIyih7BaL5gnJOyFQI59TrZw6hccNCqNFR6b8JYx5QRqGn4INgbIJRUnhbj41SnNrDEZlMHH9e6L0TGxOQW6jE3hNFrcj64UtyiMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712439777; c=relaxed/simple;
	bh=fYYeF3MecFw24NiAZ+QMoa0g1C92UzUGo1u5gHhYFXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZfTC2zsT3ndKkzpGNaw7Zl3fdUfSfEH51CT5i4SUFCBTSje1oaFoIzohFFAh8xWY/qTQwP5Gml0/uThj0allyamDjwUbwEE5vbP8uWZrTLEQC9IigyV/bUsKsR5f7cTsgsfFCQU/jZrQLyGXAREQJfteLedRSYSB9N2FFB4Dug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArScyxrv; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c3aeef1385so2183595b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Apr 2024 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712439773; x=1713044573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1G9gUrNc9dGzPe7AYM33DPZfjgc9cVYEl/DEKm89Aw=;
        b=ArScyxrvfDWduVY/F8RejzGRYbuEijxm5/8n92WYtfUl5vp1jQ1vsGr/rGbZpBlBxZ
         J6kz1YqYIYQ7RCwWhEdKndv6GK/Crx44nF8gZ8xxlCc2q0y8GqRWWgkmTg7YZNDcMdxQ
         0ckBbVjtgW6qTsxXOKggz9Csb/hW8tx8TEtd8Dws8cG8nErJ5gqkA0pTuYO8yqlVRwOw
         sqI6UmpY9+CLGPZyCdpTpNkWiJTP4ee0wzqhNPR7KWylbD7V+uyqn01BShAUoRiCQ/qO
         ui8N+sVN/ptI7J/TNHBcshtflTCbc2H1dw+T81NJOB5eP3I4kRgTWlAlyRZF+a8VyDd/
         AESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712439773; x=1713044573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1G9gUrNc9dGzPe7AYM33DPZfjgc9cVYEl/DEKm89Aw=;
        b=MoY9NG4hO/2nn7tlqc+fEnfh3yhLA8XS0y6hVzufk2bdFLBV33fl01IRXQrla+Ud0D
         +O+iLEl5xl2k8pYzubqXc944KFGGvfkrWVwZMpM7NhQ3t4IjyghqW/cZyEfV/rl2V1Fz
         JyKz6TYJTYSEZ7TVk7fgl3Eu+e1TUzp8K7iGCBkSNwp+W1Us0+oTaEnsDl0I9s7Wo7mY
         HnMaI8SkegCCyg6QmRavjzTQiPNnauy4OWAfofHNAyU6Ncq6cZci8zBIzLKB4eNvCuCv
         iIY/0gHyOffkUcRSCHoJSwMT2uWI5/Y4iNSJl/2YwzTHX7RARF4NKTMstrcd29ZB3A9h
         lbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+3+C1dofRgadRxtHbOOf1A925KSWnCPYpPquH5bAmINRnQVV04Hqc1n8OjICf4LAcyIM754kO5F7IXK07KErT/3HESC3O2YNmuvY4g==
X-Gm-Message-State: AOJu0YzGy1Mywe4CD/hPYLULSQx9UgM5EBrb4uhQmMKv5bR7fKBaVgUm
	RXaaWkJSHgKsZcmPsTmylA1zZhsCdf2LPEutGPlsbyzro67p0TScR5mEkwJjVB+64q1X6F+aWEG
	e9lCd6nD6Caz5ovkjLSW+zJwg8hHvnVAF5enC
X-Google-Smtp-Source: AGHT+IEy/KQG2Rqx5HErdblj8QUCCqwueXsecSytEtIs4U2W0lIYmqOxwok485xQsC2WwPFvE/PMCfWXWAWd2KQRtS8=
X-Received: by 2002:a05:6808:3084:b0:3c3:dcfc:f694 with SMTP id
 bl4-20020a056808308400b003c3dcfcf694mr5989197oib.47.1712439773006; Sat, 06
 Apr 2024 14:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <c14cd89b-c879-4474-a800-d60fc29c1820@gmail.com>
 <CAJuCfpHEt2n6sA7m5zvc-F+z=3-twVEKfVGCa0+y62bT10b0Bw@mail.gmail.com>
 <41328d5a-3e41-4936-bcb7-c0a85e6ce332@gmail.com> <CAJuCfpERj52X8DB64b=6+9WLcnuEBkpjnfgYBgvPs0Rq7kxOkw@mail.gmail.com>
 <3d496797-4173-43de-b597-af3668fd0eca@gmail.com>
In-Reply-To: <3d496797-4173-43de-b597-af3668fd0eca@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 6 Apr 2024 14:42:40 -0700
Message-ID: <CAJuCfpHXr=183+4AJPC_TwrLsNOn0BZ1jSXipoP0LE+hd7Ehfw@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:38=E2=80=AFAM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
>
>
> On 2024-04-05 17:20, Suren Baghdasaryan wrote:
> > On Fri, Apr 5, 2024 at 7:30=E2=80=AFAM Klara Modin <klarasmodin@gmail.c=
om> wrote:
> >>
> >> On 2024-04-05 16:14, Suren Baghdasaryan wrote:
> >>> On Fri, Apr 5, 2024 at 6:37=E2=80=AFAM Klara Modin <klarasmodin@gmail=
.com> wrote:
> >>>> If I enable this, I consistently get percpu allocation failures. I c=
an
> >>>> occasionally reproduce it in qemu. I've attached the logs and my con=
fig,
> >>>> please let me know if there's anything else that could be relevant.
> >>>
> >>> Thanks for the report!
> >>> In debug_alloc_profiling.log I see:
> >>>
> >>> [    7.445127] percpu: limit reached, disable warning
> >>>
> >>> That's probably the reason. I'll take a closer look at the cause of
> >>> that and how we can fix it.
> >>
> >> Thanks!
> >
> > In the build that produced debug_alloc_profiling.log I think we are
> > consuming all the per-cpu memory reserved for the modules. Could you
> > please try this change and see if that fixes the issue:
> >
> >   include/linux/percpu.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index a790afba9386..03053de557cf 100644
> > --- a/include/linux/percpu.h
> > +++ b/include/linux/percpu.h
> > @@ -17,7 +17,7 @@
> >   /* enough to cover all DEFINE_PER_CPUs in modules */
> >   #ifdef CONFIG_MODULES
> >   #ifdef CONFIG_MEM_ALLOC_PROFILING
> > -#define PERCPU_MODULE_RESERVE (8 << 12)
> > +#define PERCPU_MODULE_RESERVE (8 << 13)
> >   #else
> >   #define PERCPU_MODULE_RESERVE (8 << 10)
> >   #endif
> >
>
> Yeah, that patch fixes the issue for me.
>
> Thanks,
> Tested-by: Klara Modin

Official fix is posted at
https://lore.kernel.org/all/20240406214044.1114406-1-surenb@google.com/
Thanks,
Suren.

