Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE16F8C178
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHMTYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 15:24:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37627 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMTYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:24:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so41323408otq.4;
        Tue, 13 Aug 2019 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BGADOSDNi0yEXJGYbIS7Es/7+y3WA9cMlUX5F4uA3I=;
        b=KE3GYgXjoB+OjzuGsPmiAcRayJ6zju7RPzcdKGrMzVlkey77jjZxtEP2mh1WWv9sLH
         ZLMlMjxt2wR2TGRUwQxDhztynGX3APXiJD1kSQjb2/KavbrOWht5m8t0cWuEoje6TxE7
         44Huamiy10vZn8q+9xjaKC0GYqpD8w7HhTLT6L5zQu/2cugN4hbedB1kO+xS+TyMxLOv
         bwl6kKSAXjiNinqMNDx86QfPebu18GpyViD0CXVdg4XK64TwicdGeuABSziFnP9+zdHz
         u9cFnhGSRhgcXXGSo5Rlog586C+LQL8pZqnYwNVWTh3UrfdUpF3AseKSqw2mZ/pN7lus
         rNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BGADOSDNi0yEXJGYbIS7Es/7+y3WA9cMlUX5F4uA3I=;
        b=HN5Q05tDUPsBZJGrOtCIJJ2IOHvG4tqbvJamrtvSjs/B8IKzIsMKh9fzRjgg7JsNpT
         Jg2czdvnN70YDpXFc3cUXL9tnkFcAyZKPaiuHVX3yx7T+3XJc697TE4f/xoz0NPpfLYb
         PjIZlyJDD2tXAhnD+dQd2X3NAVOckiX2sJpBb4DxDS3T+l8bV/GZDJZGZ/Ghzr4l0DTe
         glwBuAzb9eX6hELBLVh1SltLExcXoAtKLmOEqvn7SfuZZQU1ci0Rb6RGcGXKN7LG2B9T
         I1op26C7yMxFVAhifuqFac58A6ld2REl4NXdx8ymDqQkTr8/Snk8bAi/lvcvbjHGVIHw
         jsHA==
X-Gm-Message-State: APjAAAUmg0l24usH56u5cL5EE9kS5HyTGlicxIXQmEZ+Y5JYoT4imgH7
        Y1yg7d0fkCyEnQUXROJPHfZRN5quxJ64yF91soA=
X-Google-Smtp-Source: APXvYqyNWl6EB6hqtWOLBAyHMMulekRu0qD9+ndzTr07RTNTOCPXCYzvAypulGqjwsebgf4b+owsuwKVp8jgDKJPlE8=
X-Received: by 2002:a6b:f406:: with SMTP id i6mr6656iog.110.1565724258526;
 Tue, 13 Aug 2019 12:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807171559.182301-2-joel@joelfernandes.org> <20190813150450.GN17933@dhcp22.suse.cz>
 <20190813153659.GD14622@google.com>
In-Reply-To: <20190813153659.GD14622@google.com>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Tue, 13 Aug 2019 22:24:06 +0300
Message-ID: <CALYGNiOj4pxZAMvM_3fJZ0xJ0E5-FfSRQbGdxb4eFC37USCYvA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] mm/page_idle: Add support for handling swapped
 PG_Idle pages
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 6:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Aug 13, 2019 at 05:04:50PM +0200, Michal Hocko wrote:
> > On Wed 07-08-19 13:15:55, Joel Fernandes (Google) wrote:
> > > Idle page tracking currently does not work well in the following
> > > scenario:
> > >  1. mark page-A idle which was present at that time.
> > >  2. run workload
> > >  3. page-A is not touched by workload
> > >  4. *sudden* memory pressure happen so finally page A is finally swapped out
> > >  5. now see the page A - it appears as if it was accessed (pte unmapped
> > >     so idle bit not set in output) - but it's incorrect.
> > >
> > > To fix this, we store the idle information into a new idle bit of the
> > > swap PTE during swapping of anonymous pages.
> > >
> > > Also in the future, madvise extensions will allow a system process
> > > manager (like Android's ActivityManager) to swap pages out of a process
> > > that it knows will be cold. To an external process like a heap profiler
> > > that is doing idle tracking on another process, this procedure will
> > > interfere with the idle page tracking similar to the above steps.
> >
> > This could be solved by checking the !present/swapped out pages
> > right? Whoever decided to put the page out to the swap just made it
> > idle effectively.  So the monitor can make some educated guess for
> > tracking. If that is fundamentally not possible then please describe
> > why.
>
> But the monitoring process (profiler) does not have control over the 'whoever
> made it effectively idle' process.
>
> As you said it will be a guess, it will not be accurate.

Yep. Without saving idle bit in swap entry (and presuming that all swap is idle)
profiler could miss access. This patch adds accurate tracking almost for free.
After that profiler could work with any pace without races.

>
> I am curious what is your concern with using a bit in the swap PTE?
>
> (Adding Konstantin as well since we may be interested in this, since we also
> suggested this idea).
>
> thanks,
>
>  - Joel
>
>
