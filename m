Return-Path: <linux-fsdevel+bounces-11724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609F8566BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9948B1C23823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37A1332A8;
	Thu, 15 Feb 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCSBC1fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8061132C08
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009138; cv=none; b=g72hrfo15iBaywaBpbY6I2SKrKUddeu2ji1kxngRN9zPbvaKl24npnXZFJpcAVbXF6+5PE7M6YEgojlBZHRF2CqcoWOheUbs/Z6DB5j1BxQhKq2du03S+iCZ73DwDJF40Dm6CLtTVQwrLQGnpLr547RNPt3Z9mwgejcwh4K6gWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009138; c=relaxed/simple;
	bh=6IMij2aMCDzlI1InstPj/0SjhHnSgb7se0txHOjqYec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1v/H9CnwgbcIlreQPtPOt7i+oj8a4D2OWeChEXKNnKGMu9UP+lUjuWNJnM7hsjn0DHz8sMd5v2YqibNVyN458u20SrXD6c1CfdT1bhv7X/zbrEaICCZ2PvHtVTnOirHQWUThOQfCgjsPYWWHraPkPg9TxpAUF7zcF1QRKuXkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCSBC1fn; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso930212276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708009135; x=1708613935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw/wN6EwhF1l4GL2nZ/ht1qejqJOWh5ecVMENBzDBDY=;
        b=QCSBC1fn1Ka2h7g6fyuo/iR+OmsxJN+44ewMiK7TnEvXLUwE54/Fla7TeargSAD7FL
         K4XY0N++HOd/XQR20ySjDvDEt4AT0wRqIA6SonOzfFP5z8DdEIZqaTEQUNCb8KPaAgTi
         KuGZZAXkpnbLQ8uo8Gzowy4mMy4fIf8FjABi8dPX6Dpz9E5EvFoaI1UKe7ERn4Wuu7vW
         9RpviaBpJWGkU607Q3RTsx1Q9BMnNxYkHWLkp9p4vl9Ttstb/nKLi8MMIMkJ5YhE7prP
         AqX5xmoXXbk2RV4MOgo4U2hdSmx6j9jUjLVFg+6dNyF4KktkZz5uVsTEJBtCoOEQfFva
         7uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009135; x=1708613935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw/wN6EwhF1l4GL2nZ/ht1qejqJOWh5ecVMENBzDBDY=;
        b=oign7mjV+Ki9rSkkO8Jv4+OuY+T1Q+2yMJJpl6+4P7xIBlAH129QsqYDpmG3f69Ahj
         BXD/+rVlxg7gJ1NXGLKnT4XuzeI4QkTZT+I/YLZCTlo2gzYadQI8096oyhdG7QEY0ulJ
         QdRX+qfJBjHKKoxcFGHXXBlE1NcV1ttk5IdKqAZn63gWbL8eENihx6tS5fJrMoONTnaa
         u/6IdyyBpYN6qGJGdbm3zQ4GEjqtGHaKIqjdkJ5ozzZT12WeUeJ4hQg3HjY+glIeyB0l
         qbipMOFXiEhhceqH/5eC0WS+R+Gho1Q4XV0+Ze4W2PIZ1piIHImBXakX25AIHDgVwRDE
         y89Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEPdjS4z5NoYDsSgm4LMKSGIzEWisQHcDjiQ0WL3HDWFRLlHfejlljlBbGxnm5qH5hAnsxBVDvfHODGbd/ggsY8n9IADUyJyuTHuNUow==
X-Gm-Message-State: AOJu0Yx3Z6XNca1B+iNhTli3dt2+lFiOyYOFiPKqFDOncZektGMB2bEq
	8HdCLlP6rupHp37eKdoZ4JAXjNcqOCPnJJs4lNtL4/ro0APN/tpCNafpYzhfHciXPvBoPtglvjc
	OZ6EGej9aZ5BOlDy3L7E7YR1uA6135krmTBqd
X-Google-Smtp-Source: AGHT+IHbdGXWcfbi3sM7zNcX3xbLXT1pZZDBplduLx68NqKeXRGL2TAUM4SLA4O1Gc053VxRA9U/P0Ad1H3i0YzTDwI=
X-Received: by 2002:a25:8750:0:b0:dbe:9509:141c with SMTP id
 e16-20020a258750000000b00dbe9509141cmr1821330ybn.30.1708009135319; Thu, 15
 Feb 2024 06:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
In-Reply-To: <Zc3X8XlnrZmh2mgN@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 06:58:42 -0800
Message-ID: <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
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

On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> [...]
> > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *n=
odemask, int max_zone_idx)
> >  #ifdef CONFIG_MEMORY_FAILURE
> >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_p=
ages));
> >  #endif
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +     {
> > +             struct seq_buf s;
> > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > +
> > +             if (buf) {
> > +                     printk("Memory allocations:\n");
> > +                     seq_buf_init(&s, buf, 4096);
> > +                     alloc_tags_show_mem_report(&s);
> > +                     printk("%s", buf);
> > +                     kfree(buf);
> > +             }
> > +     }
> > +#endif
>
> I am pretty sure I have already objected to this. Memory allocations in
> the oom path are simply no go unless there is absolutely no other way
> around that. In this case the buffer could be preallocated.

Good point. We will change this to a smaller buffer allocated on the
stack and will print records one-by-one. Thanks!

>
> --
> Michal Hocko
> SUSE Labs

