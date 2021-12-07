Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6D46B953
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhLGKpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 05:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLGKpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:45:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C2C061574;
        Tue,  7 Dec 2021 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1oQJKZHOSv2BhG4vDWyjbthkHCPwKTze/ZDnKRyaT5I=; b=LCTJRsG11yf5MWLxMvWb+76AGC
        dokvLhsTHN9kJs7RglKt/OKgbl923ujv4dLcuK8Breo70r5aXLfX3pI+UXgcPNDsRkJrYe8goHTDA
        MrDdupYqc7jmBPvaXk4uhX1Q0gifU1E7+JyJZAuxPO9Maf8+GcWndQKPk2oitEpOon601/I+fJaTP
        qWIRsMKOsKfNGMLuIYGlEP/i7hEh0uSy7X6217mXBG+cJg2owiANXFCc80Q9RcLqHv1ZhJrWmV4Qu
        S4kPflF2dzBKc3L2/CL6WculFLu47dHT+ET9lUhlmy08wv7uNDzExB+LYkAieBW3COqflIGM8Bqp9
        8OoYQEyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muXv1-002kRp-Kd; Tue, 07 Dec 2021 10:41:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B698300237;
        Tue,  7 Dec 2021 11:41:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7EB920247219; Tue,  7 Dec 2021 11:41:54 +0100 (CET)
Date:   Tue, 7 Dec 2021 11:41:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
Message-ID: <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
 <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:20:59AM +0100, Miklos Szeredi wrote:
> On Tue, 7 Dec 2021 at 11:07, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Dec 07, 2021 at 10:07:45AM +0100, Miklos Szeredi wrote:
> > > On Mon, 6 Dec 2021 at 09:47, Pradeep P V K <quic_pragalla@quicinc.com> wrote:
> > > >
> > > > The synchronous wakeup interface is available only for the
> > > > interruptible wakeup. Add it for normal wakeup and use this
> > > > synchronous wakeup interface to wakeup the userspace daemon.
> > > > Scheduler can make use of this hint to find a better CPU for
> > > > the waker task.
> >
> > That's a horrendoubly bad changelog :-/ Also, if you need it for
> > UNINTERRUPTIBLE that's trivial to do ofc.
> >
> > > Ingo, Peter,
> > >
> > > What exactly does WF_SYNC do?   Does it try to give the waker's CPU
> > > immediately to the waked?
> > >
> > > If that doesn't work (e.g. in this patch the wake up is done with a
> > > spin lock held) does it do anything?
> > >
> > > Does it give a hint that the waked task should be scheduled on this
> > > CPU at the next scheduling point?
> >
> > WF_SYNC is a hint to the scheduler that the waker is about to go sleep
> > and as such it is reasonable to stack the woken thread on this CPU
> > instead of going to find an idle CPU for it.
> >
> > Typically it also means that the waker and wakee share data, and thus
> > having them share the CPU is beneficial for cache locality.
> 
> Okay, so it doesn't give up the CPU immediately to the woken task,
> just marks the woken task as a "successor" when the current task goes
> to sleep.  Right?

More or less.

> That may be good for fuse as the data is indeed shared.  It would be
> even better if the woken task had already a known affinity to this
> CPU, since that would mean thread local data wouldn't have to be
> migrated each time...   So I'm not sure sync wakeup alone is worth it,
> needs real life benchmarking.

Hard affinities have other down-sides.. occasional migrations shouldn't
be a problem, constant migrations are bad.
