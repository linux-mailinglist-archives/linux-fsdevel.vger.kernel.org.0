Return-Path: <linux-fsdevel+bounces-11884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11B858577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2CFB21C1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4B135A5B;
	Fri, 16 Feb 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mea7BVyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA79135A41
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108923; cv=none; b=oylcEQ9Y9xjXq7UzEA8IvANq0PjbccWA+CPKzuivzScHVlMsR5wcNRq+3d2pfqR7+Ig2LkbrVT335nd5k/m6Fp1TCyCZ6qINGpGZzE+OgekHpFlIUTfRz4vS5Pk66vgB/9md491/E3wp11DLG0lluFCCekGQM34nXyXYW7cfgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108923; c=relaxed/simple;
	bh=A1KZCaXPLmV5IjKi0NDr6st7BWpbT8lR31nOuGGGMbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhmTe/ZZPVEEMxjM1rX0Y66bEi3cReBU+8RT73a8tCyW79+Ir0hbcwEabnYnzCHNv802U81AaHTdVzrfPcP7OfEjNdrmBMACSCZvdQYCJ1pgr7IlG7gBu/UJB8rEw4UC9TjKzxlK8ZUwHjPgitAk0+2Hq88zrrXoYCZ5wqiPiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mea7BVyU; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2979316276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708108919; x=1708713719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faKyGS2bCJ2px0ud+d+mBkv9JBZNScCq7HyfBnLgGJM=;
        b=Mea7BVyUlXEFyCFvx4rOU9zhyLwQqcBCUmAVisqF8k+pk4wSx3YyEsA2ZMeRpC8b5w
         9A/w5iCDQNKLuSRh+HDGKX8HvZeIptQC2Z/DM3f+9DJUkNDv2fxFogmiEMWJPHBVfX8L
         NtoaJujQN7wTZ/ktPpBfYyx9k+dc0zEorMI4vlIh18OEJdx8p4ktiRKnkpnEDNxK8JvL
         rsfQBcVDFz66CI2nLusWb4O3ZHwfqXEujnJ4xU7Tx2aVyRFgbQfioOaanu7vjRs9y1Sr
         yDZ/qQFP5ThZolEK/1bFCs94Ock1+fscCgg06uR7MkHTbBAA4t5UKktqb42D6YNuGrMp
         ahaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108919; x=1708713719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faKyGS2bCJ2px0ud+d+mBkv9JBZNScCq7HyfBnLgGJM=;
        b=sq2DxhUzapSyoeIS8PsqZZYCVFmgLe+l3dbPtFLxssVXkzeCo41ggrE/GOPq0kTwZe
         GTl6mBAzE5fQnThUDfu/5wsGCPVdagd+sgFRxITNAryVUr8aYCxNVrGQo6EzSWuwCQbH
         0E/W5Uooe8rekcn8pz9cQSC980k9qtcGUs51wt9E8eTHQD0+/bYdzWloaNGDMBDcTtec
         3AkE4d2/y4OhhnhXIiBt9cV++/lC+/bSO7Gci6/2C0uOmXYVBq0dfR9xKbER5L+eLimj
         kAvheP+LUUZIIebT1fUc/MLvBoLAY/rvjtVj6Cj7yfnHfZQIWeBfJXd8QyZY4qWJfSuY
         ySWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVEWxdF7FGjVIIepgygnyP6/xEYXZ67I8ZPQXyX3DHDcC4fz6FVAAOK4SG8B6kD552Xgv8gCLRu3FFj3w37BwtaVoi6d+j9tPIpVW7zw==
X-Gm-Message-State: AOJu0YyUsOAAMZH5xwxej7JAKL/igIMOPS+inbpmXG9N1Gg5de0DzIdR
	Z7DO7Pnpsld40yn3yid51OqLSCFzySvDaSoTeL648qHdD+q9LHoXXoyZtqK1K3RjTy/OGBFfgv5
	SDIPdT84bxxkiub24zmrYE8ggwHLjoskSM43J
X-Google-Smtp-Source: AGHT+IEJnWKoDWpauMUL3nyzq5XZmrCjaSg8T+9prk1S1WBz+kj41C07IYkFdioVMXmJnJb7IpOv4ANZWqelmDdrwMM=
X-Received: by 2002:a25:fc23:0:b0:dc2:3a05:489 with SMTP id
 v35-20020a25fc23000000b00dc23a050489mr4194145ybd.14.1708108919211; Fri, 16
 Feb 2024 10:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-8-surenb@google.com>
 <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz> <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
 <ab4b1789-910a-4cd6-802c-5012bf9d8984@suse.cz> <CAJuCfpH=tr1faWnn0CZ=V_Gg-0ysEsGPOje5U-DDy5x2V83pxA@mail.gmail.com>
In-Reply-To: <CAJuCfpH=tr1faWnn0CZ=V_Gg-0ysEsGPOje5U-DDy5x2V83pxA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 18:41:46 +0000
Message-ID: <CAJuCfpGBCNsvK35Bq8666cJeZ3Hwfwj6mDJ6M5Wjg7oZi8xd0g@mail.gmail.com>
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:10=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Feb 15, 2024 at 1:50=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 2/15/24 22:37, Kent Overstreet wrote:
> > > On Thu, Feb 15, 2024 at 10:31:06PM +0100, Vlastimil Babka wrote:
> > >> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > >> > Slab extension objects can't be allocated before slab infrastructu=
re is
> > >> > initialized. Some caches, like kmem_cache and kmem_cache_node, are=
 created
> > >> > before slab infrastructure is initialized. Objects from these cach=
es can't
> > >> > have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mar=
k these
> > >> > caches and avoid creating extensions for objects allocated from th=
ese
> > >> > slabs.
> > >> >
> > >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >> > ---
> > >> >  include/linux/slab.h | 7 +++++++
> > >> >  mm/slub.c            | 5 +++--
> > >> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > >> > index b5f5ee8308d0..3ac2fc830f0f 100644
> > >> > --- a/include/linux/slab.h
> > >> > +++ b/include/linux/slab.h
> > >> > @@ -164,6 +164,13 @@
> > >> >  #endif
> > >> >  #define SLAB_TEMPORARY            SLAB_RECLAIM_ACCOUNT    /* Obje=
cts are short-lived */
> > >> >
> > >> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > >> > +/* Slab created using create_boot_cache */
> > >> > +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000=
U)
> > >>
> > >> There's
> > >>    #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000=
U)
> > >> already, so need some other one?
>
> Indeed. I somehow missed it. Thanks for noticing, will fix this in the
> next version.

Apparently the only unused slab flag is 0x00000200U, all others seem
to be taken. I'll use it if there are no objections.

>
> > >
> > > What's up with the order of flags in that file? They don't seem to
> > > follow any particular ordering.
> >
> > Seems mostly in increasing order, except commit 4fd0b46e89879 broke it =
for
> > SLAB_RECLAIM_ACCOUNT?
> >
> > > Seems like some cleanup is in order, but any history/context we shoul=
d
> > > know first?
> >
> > Yeah noted, but no need to sidetrack you.

