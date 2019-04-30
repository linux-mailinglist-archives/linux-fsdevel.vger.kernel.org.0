Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0410157
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 23:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfD3VBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 17:01:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39198 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3VBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:01:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id n187so12449110oih.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 14:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxeD0t/KcIvQA7AtfwSjOeFDBlvqqlxzBx10CN2QVNI=;
        b=sfT7KVA1enCXgEMX41coNsvfXgduOQl6MLoaMM7nucfOeYLAP9gAcduFLiUdhGLlLH
         QcgvX4Zmgx9MNFJcppcgUO2ynZ7AuMtnQlEjIS6OwfEMfItCq9AHW8xhMWA3bO3YkiVs
         oXX7JGM7WG8QrcX9+82VvL5Zicy+8SY8bxiG2tqHNponPGfUAx8i1W2exgPoMDHpPSDb
         MsGB8j3Cp9vp6dg0ZVS7KbhzhPh1vgIIvfhfyERQGadZgBZMeVILy/VB17yH4kOE62yQ
         H17lf9LubGRPfoOA0w8tgCEuwHLxk2H1dHMyb5n7GH+dVGWNbE5OsdnqY09Xvh+cu2so
         vpAw==
X-Gm-Message-State: APjAAAWAfHO6qgZuCIMnkloGMOZv2r87XiQUzaAWhmDIEQUAQiTd0AWM
        AM8p9+hvPHuVP/LXKnCkklYzEb+01ueNJDmTVIeRhg==
X-Google-Smtp-Source: APXvYqxRuUf+raV6b8zHMVgYZA8M5K6WNhMbasniUIohb8+PqskX0Mzkcnx52S0Dm0GyIPBkL/f+1mP6Gz3mbT67VvA=
X-Received: by 2002:aca:61d7:: with SMTP id v206mr4682848oib.97.1556658092881;
 Tue, 30 Apr 2019 14:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <1556305328-2001-1-git-send-email-jsavitz@redhat.com> <20190427214522.GA7074@avx2>
In-Reply-To: <20190427214522.GA7074@avx2>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 30 Apr 2019 17:01:21 -0400
Message-ID: <CAL1p7m6rp3LOX=B_UdcvFMdOAYtPNudQtYyFLi=Jv0dTUxsjyA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/proc: add VmTaskSize field to /proc/$$/status
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good point Alexey.

Expect v3 shortly.

Best,
Joel Savitz


On Sat, Apr 27, 2019 at 5:45 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Fri, Apr 26, 2019 at 03:02:08PM -0400, Joel Savitz wrote:
> > In the mainline kernel, there is no quick mechanism to get the virtual
> > memory size of the current process from userspace.
> >
> > Despite the current state of affairs, this information is available to the
> > user through several means, one being a linear search of the entire address
> > space. This is an inefficient use of cpu cycles.
>
> You can test only a few known per arch values. Linear search is a self
> inflicted wound.
>
> prctl(2) is more natural place and will also be arch neutral.
>
> > A component of the libhugetlb kernel test does exactly this, and as
> > systems' address spaces increase beyond 32-bits, this method becomes
> > exceedingly tedious.
>
> > For example, on a ppc64le system with a 47-bit address space, the linear
> > search causes the test to hang for some unknown amount of time. I
> > couldn't give you an exact number because I just ran it for about 10-20
> > minutes and went to go do something else, probably to get coffee or
> > something, and when I came back, I just killed the test and patched it
> > to use this new mechanism. I re-ran my new version of the test using a
> > kernel with this patch, and of course it passed through the previously
> > bottlenecking codepath nearly instantaneously.
> >
> > This patched enabled me to upgrade an O(n) codepath to O(1) in an
> > architecture-independent manner.
>
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -74,7 +74,10 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
> >       seq_put_decimal_ull_width(m,
> >                   " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
> >       SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> > -     seq_puts(m, " kB\n");
> > +     SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> > +     seq_put_decimal_ull_width(m,
> > +                 " kB\nVmTaskSize:\t", TASK_SIZE >> 10, 8);
> > +     seq_puts(m, " kB\n");
>
> All fields in this file are related to the task. New field related
> to "current" will stick like an eyesore.
