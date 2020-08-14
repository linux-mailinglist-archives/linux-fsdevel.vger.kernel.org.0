Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D10244677
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHNIaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgHNIaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:30:15 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5EC061384
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 01:30:14 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p191so4815523ybg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FTYvzqtwTFg32oQ2R1iT/fxQYwIO5aEnRMfUKVR7Oc=;
        b=a8EXI30EnDIPpIpx03Sd32eIfrso3BfcxnHyuAmDr5hmLTex8csYsnA9uZ316d8+bV
         sOEB/63/jWXUQXNPxzlvTziNsLhCzV+LYdqyR66PA/ZKL9aedLGB3m7E4J7PJ96iMNP1
         HkdlGmEzCWqRKidgDrvMNP43EbLGV/cRtR73DUUrI0yxZ05fIi5y0fZQtvuqF76mORow
         zHCXH/esL0lg5ebyMvZHR4aV3OCvpJAPEMnkf656Epo4coILnvz6InECDbGlBQGQHcM0
         YlurOpy3r0mZ0QR5hMkDdcvD/SLUmXa1Naesw9cyAoE6/0caKGpBdG4cUvKyjsTkjI+M
         J5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FTYvzqtwTFg32oQ2R1iT/fxQYwIO5aEnRMfUKVR7Oc=;
        b=dDYgL4k1Hz2SFON5Yy9lS3qfu8/1bjzFEEVsG3MVK4u2ki/zIn9rp42pOlHw4xEEH+
         Mrj12+je008LBxp+WgVFWxtBJezt0zKPTC6DwoXyDmhlWO3Ykx/RwT0yWAvbZfqORUgo
         61fNrDFnoaSBtRYJRhY0a5aemvFjswh0NMy0GJ90yL6Iye9F9twZ06AdMnUPzQYQdwuw
         RK+LPUH+yyIUQcIJwR6BZC99B/eGxJ1iNS8vnLjF+YTLA4R+DuitR8mDU5NoX0j2s3DA
         NPlAnfTayBPM+e5oagOsUAIfew4sI+cF1Yfi6I+djnOaeBhn9ccbZmQavNexLHYFrOFM
         It5g==
X-Gm-Message-State: AOAM530xY8zLVSJNxhRWeV5TUzCE72ycVEytyV8VLtdJHIHxOG505XB0
        RDuGtrQYccZD1riKu1HBjSZNWTYkCoJnuyTdGcqScQ==
X-Google-Smtp-Source: ABdhPJw13pPX/3kPqJmeuWDN2VsAFdhKvqiSsbN8Cuj1qsFtz1LjVZiTxa/qFhrVFcgAEIezPtI+eYfXKR4LKmD5VnE=
X-Received: by 2002:a25:e684:: with SMTP id d126mr2335998ybh.332.1597393813820;
 Fri, 14 Aug 2020 01:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
 <CANN689G0DkL-wpxMha=nyysPYG6LM3Aw7060k2xQTxTA4PAf-w@mail.gmail.com> <1597335088.32469.55.camel@mtkswgap22>
In-Reply-To: <1597335088.32469.55.camel@mtkswgap22>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 14 Aug 2020 01:29:59 -0700
Message-ID: <CANN689GsiBga4a6P3JMG-iwT9WY6V_qodJxeaw0uWsTHVsW4JQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Try to release mmap_lock temporarily in smaps_rollup
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 9:11 AM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
> On Thu, 2020-08-13 at 02:53 -0700, Michel Lespinasse wrote:
> > On Wed, Aug 12, 2020 at 7:14 PM Chinwen Chang
> > <chinwen.chang@mediatek.com> wrote:
> > > Recently, we have observed some janky issues caused by unpleasantly long
> > > contention on mmap_lock which is held by smaps_rollup when probing large
> > > processes. To address the problem, we let smaps_rollup detect if anyone
> > > wants to acquire mmap_lock for write attempts. If yes, just release the
> > > lock temporarily to ease the contention.
> > >
> > > smaps_rollup is a procfs interface which allows users to summarize the
> > > process's memory usage without the overhead of seq_* calls. Android uses it
> > > to sample the memory usage of various processes to balance its memory pool
> > > sizes. If no one wants to take the lock for write requests, smaps_rollup
> > > with this patch will behave like the original one.
> > >
> > > Although there are on-going mmap_lock optimizations like range-based locks,
> > > the lock applied to smaps_rollup would be the coarse one, which is hard to
> > > avoid the occurrence of aforementioned issues. So the detection and
> > > temporary release for write attempts on mmap_lock in smaps_rollup is still
> > > necessary.
> >
> > I do not mind extending the mmap lock API as needed. However, in the
> > past I have tried adding rwsem_is_contended to mlock(), and later to
> > mm_populate() paths, and IIRC gotten pushback on it both times. I
> > don't feel strongly on this, but would prefer if someone else approved
> > the rwsem_is_contended() use case.
> >
> Hi Michel,
>
> Thank you for your kind feedback.
>
> In my opinion, the difference between the case in smaps_rollup and the
> one in your example is that, for the former, the interference comes from
> the outside of the affected process, for the latter, it doesn't.
>
> In other words, anyone may use smaps_rollup to probe the affected
> process without the information about what step the affected one is
> executing.

Thanks, that is a good enough point for me :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
