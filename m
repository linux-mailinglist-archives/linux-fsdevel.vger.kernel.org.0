Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD446BCE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhLGNt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbhLGNt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:49:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCAC061574;
        Tue,  7 Dec 2021 05:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CtRe9IWGea7W1qUUtSipymFANRf25cs9ub/ASOlc7Y0=; b=ZjZtjaF1ZEh6e9uHD1cGmLhpS5
        r/gy4as8+euG3R8iiCtrPexlqjtGcw0q4si5U1RPb1TvBr8HYvA6b2TbSEAY5sZBxpdWbL862DzSy
        LCaM+yJ2yWZ6e2MDoXqD8I8dLEpIisdow0PyUV9qd9z7a6GF2iTGBA54Jm+Olo3b4k7kMFJw1BvxC
        fKOLIwRY8AtoYOi/TaUx0Jfh6q4NkYTsubpPylWjSSJqHfDEQy3wfWXqHHujmcPmTIkGpC1flXYhO
        zTDJobtf5qES0Qko8wQEAhumJDs/yATV91Y0E5auSt6FGKEUEemc0um6eZWTW08KLTysmGSLjd+yF
        7fjVcF3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muan0-002m1X-5g; Tue, 07 Dec 2021 13:45:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CB81300237;
        Tue,  7 Dec 2021 14:45:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F73620239D92; Tue,  7 Dec 2021 14:45:49 +0100 (CET)
Date:   Tue, 7 Dec 2021 14:45:49 +0100
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
Message-ID: <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net>
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
 <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
 <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:44:49PM +0100, Miklos Szeredi wrote:
> On Tue, 7 Dec 2021 at 11:42, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Dec 07, 2021 at 11:20:59AM +0100, Miklos Szeredi wrote:
> 
> > > That may be good for fuse as the data is indeed shared.  It would be
> > > even better if the woken task had already a known affinity to this
> > > CPU, since that would mean thread local data wouldn't have to be
> > > migrated each time...   So I'm not sure sync wakeup alone is worth it,
> > > needs real life benchmarking.
> >
> > Hard affinities have other down-sides.. occasional migrations shouldn't
> > be a problem, constant migrations are bad.
> 
> Currently fuse readers are sleeping in
> wait_event_interruptible_exclusive().  wake_up_interruptible_sync()
> will pick the first thread in the queue and wake that up.  That will
> likely result in migration, right?

Per the _sync it will try harder to place the thread on the waking CPU.
Which is what you want right? For the worker to do the work on the CPU
that wakes it, since that CPU has the data cache-hot etc..

> What would be much nicer, is to look at all the threads on the waitq
> and pick one that previously ran on the current CPU if there's one.
> Could this be implemented?

It would violate the FIFO semantics of _exclusive.
