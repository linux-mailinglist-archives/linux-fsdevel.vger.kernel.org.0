Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD246BD92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbhLGO2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 09:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhLGO2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:28:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7650C061574;
        Tue,  7 Dec 2021 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=414vNtX6glGxhHFQSQjhhJzJq+QlN/WK36DDfGe6Ypg=; b=cPxFrAMPruAe6nF6GY5r3h2ysd
        zOakQqNN8fcW8zcmKsnqJmhdZrJZGeifpl2N06WrdSuXobrLQL7euPH2M/KOQImuqXCLBlJcT/I/O
        Q55SPGx2cV1STletUFdJUZADPvCiQexJTLV+5jpvAa6VcncLMpESL4dlxt16lNFerIjMz+ZfkAoaG
        nS0DHYTZKVmV97ZzmxFl57qsIgitJuEmOtrqRYaf0++NATb3XNoelWZYjIIHBAWRTKwY6GYBQuJov
        6iEJtNkaMOuk+3PVTDI3cZCQ/B7eOqPaNIG9RGhRJXDwm13Q8uQKgCrqc4+Z79iiuI/iy5HrawRAa
        sl2gbqNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mubP3-002mHl-9w; Tue, 07 Dec 2021 14:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED05C3000E6;
        Tue,  7 Dec 2021 15:25:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D725820299B41; Tue,  7 Dec 2021 15:25:08 +0100 (CET)
Date:   Tue, 7 Dec 2021 15:25:08 +0100
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
Message-ID: <Ya9uxHGo7UJikEte@hirez.programming.kicks-ass.net>
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
 <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
 <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
 <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net>
 <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
 <CAJfpegt2x1ztuzh0niY7fgx1UKxDGsAkJbS0wVPp5awxwyhRpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt2x1ztuzh0niY7fgx1UKxDGsAkJbS0wVPp5awxwyhRpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:03:01PM +0100, Miklos Szeredi wrote:
> On Tue, 7 Dec 2021 at 14:51, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Dec 07, 2021 at 02:45:49PM +0100, Peter Zijlstra wrote:
> >
> > > > What would be much nicer, is to look at all the threads on the waitq
> > > > and pick one that previously ran on the current CPU if there's one.
> > > > Could this be implemented?
> > >
> > > It would violate the FIFO semantics of _exclusive.
> >
> > That said, look at
> > kernel/locking/percpu-rwsem.c:percpu_rwsem_wake_function() for how to do
> > really terrible things with waitqueues, possibly including what you
> > suggest.
> 
> Okay, so it looks doable, but rather more involved than just sticking
> that _sync onto the wake helper.
> 
> FIFO is used so that we always wake the most recently used thread, right?
> 
> That makes sense if it doesn't involve migration, but if the hot
> thread is going to be moved to another CPU then we'd lost most of the
> advantages.  Am I missing something?

FIFO means the thread used longest ago gets to go first. If your threads
are an idempotent workers, FIFO might not be the best option. But I'm
not much familiar with the FUSE code or it's design.
