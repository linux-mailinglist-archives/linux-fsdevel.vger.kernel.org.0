Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4226B2BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgIOWw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:52:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727425AbgIOPl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600184479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RqHEMu+/F04jCZWSSn74ZbgvenbyaRZICGZsnEHkLjI=;
        b=BSDjnsap83fLOIIfvkoGxCJOnvRaAqAux4PrQUtlMD+92S+mIrNRMuUJRjkfifYC95+9tR
        L/7CUZtnjvmw+tvOYaNH10nGxxHrz00wEVsWJyqS0iLAd/03h1ZGzNngk4/OFKJBHWvSSC
        YrkGoFevNvkTCcOnBVGMdA1EE4pX8wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-yolI7o9WMJuNa5I1wC5obw-1; Tue, 15 Sep 2020 11:33:05 -0400
X-MC-Unique: yolI7o9WMJuNa5I1wC5obw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B058C2FA5;
        Tue, 15 Sep 2020 15:31:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id B23EB75138;
        Tue, 15 Sep 2020 15:31:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Sep 2020 17:31:17 +0200 (CEST)
Date:   Tue, 15 Sep 2020 17:31:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     peterz@infradead.org
Cc:     Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200915153113.GA6881@redhat.com>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915150610.GC2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/15, Peter Zijlstra wrote:
>
> On Tue, Sep 15, 2020 at 10:07:50PM +0800, Hou Tao wrote:
> > Under aarch64, __this_cpu_inc() is neither IRQ-safe nor atomic, so
> > when percpu_up_read() is invoked under IRQ-context (e.g. aio completion),
> > and it interrupts the process on the same CPU which is invoking
> > percpu_down_read(), the decreasement on read_count may lost and
> > the final value of read_count on the CPU will be unexpected
> > as shown below:
>
> > Fixing it by using the IRQ-safe helper this_cpu_inc|dec() for
> > operations on read_count.
> >
> > Another plausible fix is to state that percpu-rwsem can NOT be
> > used under IRQ context and convert all users which may
> > use it under IRQ context.
>
> *groan*...
>
> So yeah, fs/super totally abuses percpu_rwsem, and yes, using it from
> IRQ context is totally out of spec. That said, we've (grudgingly)
> accomodated them before.

Yes, I didn't expect percpu_up_ can be called from IRQ :/

> This seems to be a fairly long standing issue, and certainly not unique
> to ARM64 either (Power, and anyone else using asm-gemeric/percpu.h,
> should be similarly affected I think). The issue seems to stem from
> Oleg's original rewrite:
>
>   a1fd3e24d8a4 ("percpu_rw_semaphore: reimplement to not block the readers unnecessarily")

Not really... I think it was 70fe2f48152e ("aio: fix freeze protection of aio writes").
And iiuc io_uring does the same.

> and is certainly an understandable mistake.
>
> I'm torn on what to do, using this_cpu over __this_cpu is going to
> adversely affect code-gen (and possibly performance) for all the
> percpu-rwsem users that are not quite so 'creative'.

Yes, but what else can we do?

Oleg.

