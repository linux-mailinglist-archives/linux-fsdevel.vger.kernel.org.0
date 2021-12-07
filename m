Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520A146B86D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhLGKLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 05:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhLGKLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:11:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A825C061574;
        Tue,  7 Dec 2021 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k4cqfgZUBrtx1BceHIgbZ0d9UPpCS0+xdvzE9oekXbg=; b=CDwU+nNZT3EtFIjv+TJuhMTy5Y
        /0lr+ZBt7ydncCs2yhu+XJA4vSk3/ff/D6iYotqp3O7uOm1t/tpvYWMw91M91tGeqBsfYGjszZzCS
        SiWrUvykr/vBiJyaffxjesO7oK7uTqO/Ofo+DCoIXg5En7BWO/MeryMko116jYILWDLDJPZHwIOnp
        8uU5a2a4ig2Exw6rcIDMOG7fwp73y3eB6jOqmlhQjINFe9KniuYGIe+qSe1h4TBdnSGtVML1K1EXE
        voAD9KsOCLShBHOtL9CN25tRPud65vO6zpQZg3VfMwmprFg94F2KNH2ta1BvBG4O46S09QbMferH+
        qarmFZhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muXNx-002k0b-IU; Tue, 07 Dec 2021 10:07:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81E1830002F;
        Tue,  7 Dec 2021 11:07:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CA0A202A40B1; Tue,  7 Dec 2021 11:07:44 +0100 (CET)
Date:   Tue, 7 Dec 2021 11:07:44 +0100
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
Message-ID: <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:07:45AM +0100, Miklos Szeredi wrote:
> On Mon, 6 Dec 2021 at 09:47, Pradeep P V K <quic_pragalla@quicinc.com> wrote:
> >
> > The synchronous wakeup interface is available only for the
> > interruptible wakeup. Add it for normal wakeup and use this
> > synchronous wakeup interface to wakeup the userspace daemon.
> > Scheduler can make use of this hint to find a better CPU for
> > the waker task.

That's a horrendoubly bad changelog :-/ Also, if you need it for
UNINTERRUPTIBLE that's trivial to do ofc.

> Ingo, Peter,
> 
> What exactly does WF_SYNC do?   Does it try to give the waker's CPU
> immediately to the waked?
> 
> If that doesn't work (e.g. in this patch the wake up is done with a
> spin lock held) does it do anything?
> 
> Does it give a hint that the waked task should be scheduled on this
> CPU at the next scheduling point?

WF_SYNC is a hint to the scheduler that the waker is about to go sleep
and as such it is reasonable to stack the woken thread on this CPU
instead of going to find an idle CPU for it.

Typically it also means that the waker and wakee share data, and thus
having them share the CPU is beneficial for cache locality.

That said, WF_SYNC is 'difficult' since not all users of the hint keep
their promise, so there's a bit of heuristics sprinkled on :/
