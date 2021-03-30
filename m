Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CCD34E1C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhC3HIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhC3HIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:08:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB916C061762;
        Tue, 30 Mar 2021 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X166VgoQn02EMb3f8ykwCC49d3dYou3bLIcu1kP5us0=; b=mEIz6zmnoSAw3j1Qd+Moj7BPqA
        o1FPHvH8HA4uTXQgWju4LxdFzthKOCG4xQqrL5iK/DtsvNE48oHsIcpR4rDrTiLBm3iiBRrTlZTBN
        CC8MY7tkotNFjxLmxv93ek4JzPSVR8fsaIhcAiUNmewBwq2a5sb9LM+WhRuum7nv4oxK/QaW/WVyX
        PlfPdvhdFBiscnR/2IR8k05yLYzcxvS1h5uzsDwpA+Tr+RKs2MYbGuJT5frmJkmdcb0PPABLW7sem
        +RW8E4axAPeY1QUxI69MN73T2kthyGMY+UiChulnX3Ic4YzdxLYFtMSFNCb/eT2TnJD6dbNbkURhT
        GNOoFsZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lR8Qa-002ddk-BT; Tue, 30 Mar 2021 07:04:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3363307001;
        Tue, 30 Mar 2021 09:04:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBF922B960A7F; Tue, 30 Mar 2021 09:04:36 +0200 (CEST)
Date:   Tue, 30 Mar 2021 09:04:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
Message-ID: <YGLNhKnx4wR38XpE@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com>
 <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <20210329142705.GA24849@redhat.com>
 <CANpmjNN4kiGiuSSm2g0empgKo3DW-UJ=eNDB6sv1bpypD13vqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN4kiGiuSSm2g0empgKo3DW-UJ=eNDB6sv1bpypD13vqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:32:18PM +0200, Marco Elver wrote:
> On Mon, 29 Mar 2021 at 16:27, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 03/29, Peter Zijlstra wrote:
> > >
> > > On Thu, Mar 25, 2021 at 09:14:39AM +0100, Marco Elver wrote:
> > > > @@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
> > > >  {
> > > >     struct kernel_siginfo info;
> > > >
> > > > +   /*
> > > > +    * This irq_work can race with an exiting task; bail out if sighand has
> > > > +    * already been released in release_task().
> > > > +    */
> > > > +   if (!current->sighand)
> > > > +           return;
> >
> > This is racy. If "current" has already passed exit_notify(), current->parent
> > can do release_task() and destroy current->sighand right after the check.
> >
> > > Urgh.. I'm not entirely sure that check is correct, but I always forget
> > > the rules with signal. It could be we ought to be testing PF_EXISTING
> > > instead.
> >
> > Agreed, PF_EXISTING check makes more sense in any case, the exiting task
> > can't receive the signal anyway.
> 
> Thanks for confirming. I'll switch to just checking PF_EXITING
> (PF_EXISTING does not exist :-)).

Indeed! Typing be hard :-)
