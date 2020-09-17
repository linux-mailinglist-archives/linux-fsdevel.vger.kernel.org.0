Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2B26DB56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIQMTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 08:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726850AbgIQMSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600345092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5pwbMLEsViJmn+EwXFmMFAOXinBm5HFZNemqmzs6bE=;
        b=dKNmdrQ1EKo2n+K7d2Ay5fNNtPS2vBGltVwuFHcYJ8PtNi7rfQLAa9c6wrzP5B429t174j
        i9QIg723DxfRWLp/+fFW/6C56DQ0WLyGNRr0utyVkkBE4LW+guGPC7Br45k0Ols1EFDb+x
        2LSSFIAg5Aj85ymev2umWuJRJSGeBtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-rkJLU2RJMSmNxZKHK4MfIQ-1; Thu, 17 Sep 2020 08:01:38 -0400
X-MC-Unique: rkJLU2RJMSmNxZKHK4MfIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE9C802B79;
        Thu, 17 Sep 2020 12:01:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6886075132;
        Thu, 17 Sep 2020 12:01:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Sep 2020 14:01:36 +0200 (CEST)
Date:   Thu, 17 Sep 2020 14:01:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Hou Tao <houtao1@huawei.com>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200917120132.GA5602@redhat.com>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/17, Boaz Harrosh wrote:
>
> On 16/09/2020 15:32, Hou Tao wrote:
> <>
> >However the performance degradation is huge under aarch64 (4 sockets, 24 core per sockets): nearly 60% lost.
> >
> >v4.19.111
> >no writer, reader cn                               | 24        | 48        | 72        | 96
> >the rate of down_read/up_read per second           | 166129572 | 166064100 | 165963448 | 165203565
> >the rate of down_read/up_read per second (patched) |  63863506 |  63842132 |  63757267 |  63514920
> >
>
> I believe perhaps Peter Z's suggestion of an additional
> percpu_down_read_irqsafe() API and let only those in IRQ users pay the
> penalty.
>
> Peter Z wrote:
> >My leading alternative was adding: percpu_down_read_irqsafe() /
> >percpu_up_read_irqsafe(), which use local_irq_save() instead of
> >preempt_disable().

This means that __sb_start/end_write() and probably more users in fs/super.c
will have to use this API, not good.

IIUC, file_end_write() was never IRQ safe (at least if !CONFIG_SMP), even
before 8129ed2964 ("change sb_writers to use percpu_rw_semaphore"), but this
doesn't matter...

Perhaps we can change aio.c, io_uring.c and fs/overlayfs/file.c to avoid
file_end_write() in IRQ context, but I am not sure it's worth the trouble.

Oleg.

