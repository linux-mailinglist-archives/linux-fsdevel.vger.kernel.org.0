Return-Path: <linux-fsdevel+bounces-41038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F32A2A259
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 08:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF67A13CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6D224B0B;
	Thu,  6 Feb 2025 07:34:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26513AD18;
	Thu,  6 Feb 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827274; cv=none; b=DDMFfFclHssV9tEVWcWXajWsl6qiQk1pGmwPV7Ni9Acb/0yyq1zS0mq6OUnDMHNd4dQXG0A8yIwMdo2RY5caiFHYdzLmFsP/B5bgc4Bk9X7+cbqB/nqpEQFN0HXf/0OFaQwxrdy6PveCMKz85NITV/VaWsFj6jqc907PkpucRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827274; c=relaxed/simple;
	bh=ZqC215pGfYAb7flXSAc08+IrFcFj62WGS6CVa6R7k4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRj70tATdZNtogNYh83igyOMIjqstO+CqiMwmYGLfLUkmYvPbWz7PC0/RxAVANmpS/W1V4i74gGUJFbXBVHZxFL1lg7aw6ga4DN/ds6xLtWRg6GUj6w9Iv3ZtwEjQIkYALtZ9ome381aH4UT1IIRPuhz2LGezTQIBw6wtH1v7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51f2830aa01so19822e0c.3;
        Wed, 05 Feb 2025 23:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738827269; x=1739432069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYqxjen2ckyh6AMFJqNUH79gwyV2vSuAN69CefkfgXQ=;
        b=X/f3ogkiJEQqtMGb1heI0ygtjfdNZ6as9aXYxUp9zWRI7su4sXGj44MqyYDTJ/meNf
         iyta9+yw+76XXVS3JnNbWk7L1AZzQNpMIn1iWICfYwzK0RewyVjvejPCVH29Iq8aSHXX
         cisYUegs+bJdW850sgv70HUp7Wjk2FOADMAxjURtHCiQuGhjygdzhVHAoj0QB6BBNO0c
         J+bKw0XojJNIC5HXBIIHD02dqKSxH/R2wTlbNEXkZjP/o45FPKcNv1KPkN8atqIK9s2G
         XlY455PuqaekMeSyINfv3HMrjFmzl+QxcF5QHqKmSebiC/RUdF2rX+vbwGQbsfkz56pA
         xBxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUFAkGzmbH9WFngC5R1qWjZENsq2lMJwOewBuO8tODOpZmPnjNfkQoYFx+N8sSUa859H1t4DyIHLjn@vger.kernel.org, AJvYcCWCBJD+qcJ7oKEPvhAhB1WMaeRtIgZ95ujy1Vty5XkUw0/4dDqrLWp6TFNJw+zQn6ZuQsV54eJyFm1jnMib@vger.kernel.org, AJvYcCWJ8jYk/jTdWJdV2IMB5J/tZrq2bdQ15DFstZTiwZT38kCumKSZdI+z1nzK1TUI0g0ze4vzfL4Bv+wBq915@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNKG3HaeATfUQQLCWp26xMOnwVaSeBAjY+h9YtXctsL4PalDZ
	uLjDLRPAIz4qOtOLsy4sPF3v3PAHIQWhizU0GXZygDztco+sGbNb1Fw5rGDm
X-Gm-Gg: ASbGncuVJLpGpf6RV/Ciu+qv1cMNKSEqjnRDzc0l+1NkIFxT1hkWA3EGF5yuiy6ya9H
	2EUNdqV8tffGkUTNoBJ5JM1P/9iasMYhUiet2i9f2BKB81FkF3BkKJlFsFjG3nwA+SNPrKQiblp
	M2LL00Wyh9rTn7S4u5IQDY6Kv/J+pROq6tyX+FA19QiLUWGSAqnU2yXYdKScvR8YPWrKYS8Ccyl
	Yn/yoXzFcbsmN4SkR4mnuTkdn6UFb3lYJ2RdxhLHJYmnrWRMb1J1RYrZbBu9xVwsM1OhUpu7qFP
	oD7fryKsRGLYxgqzW1DfShbsUWj2EwUR3rlO9jFgQ8tUsmfyaCjttg==
X-Google-Smtp-Source: AGHT+IF9+B00D50HGqOy1mIN4fzg7WnjfsZJYzaZ08kFw+IQMPZ5iF1jeQ0WRxh19V9LoKjVuuxTIg==
X-Received: by 2002:a05:6122:238c:b0:50c:9834:57b3 with SMTP id 71dfb90a1353d-51f0c383ea5mr3817133e0c.4.1738827269486;
        Wed, 05 Feb 2025 23:34:29 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51f228dabdfsm98727e0c.33.2025.02.05.23.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:34:29 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-866dc3cd96eso138467241.3;
        Wed, 05 Feb 2025 23:34:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUW8cP4sY2fjDCpyp/DEuULSHXihuVGEbVLcN1HP/3tdWRf0y16KhvbEinL9a273OYGyFJ55+gP4TNqVCNA@vger.kernel.org, AJvYcCVJ3n1AuZar6+s9gRixuQTAmnFkLbPVOVNrJcV2bcwcXRKv2lhxC4FfStyH+GZthSIi5Nkcs0Benpe0@vger.kernel.org, AJvYcCXZ/y2oqgsPeO75yxcGrDf39CWsCzbGnPCVnPRpSHWXBfK97nLK3ZYGH0ts2m+eXf4hoAtKQ6ulAT16yrOU@vger.kernel.org
X-Received: by 2002:a05:6102:cd3:b0:4b2:5c4b:b0aa with SMTP id
 ada2fe7eead31-4ba47a69fd7mr3852490137.17.1738827268953; Wed, 05 Feb 2025
 23:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218154613.58754-1-shikemeng@huaweicloud.com>
 <20241218154613.58754-3-shikemeng@huaweicloud.com> <CAMuHMdU_bfadUO=0OZ=AoQ9EAmQPA4wsLCBqohXR+QCeCKRn4A@mail.gmail.com>
 <82014768-2ea7-2a28-cade-99d5d8ebe59e@huaweicloud.com>
In-Reply-To: <82014768-2ea7-2a28-cade-99d5d8ebe59e@huaweicloud.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Feb 2025 08:34:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWT05uMjEassapuFr7podb_eH=T14SOyS4yW4Wh7DUcTQ@mail.gmail.com>
X-Gm-Features: AWEUYZlF1WKVp8XKeZEs4N8gBdQGzZtMTGkdvJadBBpYovB0_UlZtliJmtMLsz0
Message-ID: <CAMuHMdWT05uMjEassapuFr7podb_eH=T14SOyS4yW4Wh7DUcTQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] Xarray: move forward index correctly in xas_pause()
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Kemeng,

On Thu, 6 Feb 2025 at 07:13, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> on 1/28/2025 12:21 AM, Geert Uytterhoeven wrote:
> > On Wed, 18 Dec 2024 at 07:58, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> >> After xas_load(), xas->index could point to mid of found multi-index entry
> >> and xas->index's bits under node->shift maybe non-zero. The afterward
> >> xas_pause() will move forward xas->index with xa->node->shift with bits
> >> under node->shift un-masked and thus skip some index unexpectedly.
> >>
> >> Consider following case:
> >> Assume XA_CHUNK_SHIFT is 4.
> >> xa_store_range(xa, 16, 31, ...)
> >> xa_store(xa, 32, ...)
> >> XA_STATE(xas, xa, 17);
> >> xas_for_each(&xas,...)
> >> xas_load(&xas)
> >> /* xas->index = 17, xas->xa_offset = 1, xas->xa_node->xa_shift = 4 */
> >> xas_pause()
> >> /* xas->index = 33, xas->xa_offset = 2, xas->xa_node->xa_shift = 4 */
> >> As we can see, index of 32 is skipped unexpectedly.
> >>
> >> Fix this by mask bit under node->xa_shift when move forward index in
> >> xas_pause().
> >>
> >> For now, this will not cause serious problems. Only minor problem
> >> like cachestat return less number of page status could happen.
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >
> > Thanks for your patch, which is now commit c9ba5249ef8b080c ("Xarray:
> > move forward index correctly in xas_pause()") upstream.
> >
> >> --- a/lib/test_xarray.c
> >> +++ b/lib/test_xarray.c
> >> @@ -1448,6 +1448,41 @@ static noinline void check_pause(struct xarray *xa)
> >>         XA_BUG_ON(xa, count != order_limit);
> >>
> >>         xa_destroy(xa);
> >> +
> >> +       index = 0;
> >> +       for (order = XA_CHUNK_SHIFT; order > 0; order--) {
> >> +               XA_BUG_ON(xa, xa_store_order(xa, index, order,
> >> +                                       xa_mk_index(index), GFP_KERNEL));
> >> +               index += 1UL << order;
> >> +       }
> >> +
> >> +       index = 0;
> >> +       count = 0;
> >> +       xas_set(&xas, 0);
> >> +       rcu_read_lock();
> >> +       xas_for_each(&xas, entry, ULONG_MAX) {
> >> +               XA_BUG_ON(xa, entry != xa_mk_index(index));
> >> +               index += 1UL << (XA_CHUNK_SHIFT - count);
> >> +               count++;
> >> +       }
> >> +       rcu_read_unlock();
> >> +       XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
> >> +
> >> +       index = 0;
> >> +       count = 0;
> >> +       xas_set(&xas, XA_CHUNK_SIZE / 2 + 1);
> >> +       rcu_read_lock();
> >> +       xas_for_each(&xas, entry, ULONG_MAX) {
> >> +               XA_BUG_ON(xa, entry != xa_mk_index(index));
> >> +               index += 1UL << (XA_CHUNK_SHIFT - count);
> >> +               count++;
> >> +               xas_pause(&xas);
> >> +       }
> >> +       rcu_read_unlock();
> >> +       XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
> >> +
> >> +       xa_destroy(xa);
> >> +
> >>  }
> >
> > On m68k, the last four XA_BUG_ON() checks above are triggered when
> > running the test.  With extra debug prints added:
> >
> >     entry = 00000002 xa_mk_index(index) = 000000c1
> >     entry = 00000002 xa_mk_index(index) = 000000e1
> >     entry = 00000002 xa_mk_index(index) = 000000f1
> >     ...
> >     entry = 000000e2 xa_mk_index(index) = fffff0ff
> >     entry = 000000f9 xa_mk_index(index) = fffff8ff
> >     entry = 000000f2 xa_mk_index(index) = fffffcff
> >     count = 63 XA_CHUNK_SHIFT = 6
> >     entry = 00000081 xa_mk_index(index) = 00000001
> >     entry = 00000002 xa_mk_index(index) = 00000081
> >     entry = 00000002 xa_mk_index(index) = 000000c1
> >     ...
> >     entry = 000000e2 xa_mk_index(index) = ffffe0ff
> >     entry = 000000f9 xa_mk_index(index) = fffff0ff
> >     entry = 000000f2 xa_mk_index(index) = fffff8ff
> >      count = 62 XA_CHUNK_SHIFT = 6
> >
> > On arm32, the test succeeds, so it's probably not a 32-vs-64-bit issue.
> > Perhaps a big-endian or alignment issue (alignof(int/long) = 2)?
> Hi Geert,
> Sorry for late reply. After check the debug info and the code, I think
> the test is failed because CONFIG_XARRAY_MULTI is off. I guess
> CONFIG_XARRAY_MULTI is on arm32 and is off on m68k so the test result
> diffs. Luckly it's only a problem of of test code.
> I will send patch to correct the test code soon. Thanks!

You are right: CONFIG_XARRAY_MULTI is enabled in my arm32 build,
but not in my m68k build.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

