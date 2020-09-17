Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E226DCF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgIQNgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 09:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgIQNez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600349661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAZ7GYrpBa5ucLCP/AOwHIdySIKLL/ta6t+Gc/7xpW4=;
        b=f7+EgQ4J2PhaDA1G2yv/CQgQiIF96kLEhMy+1DQOzBB3lELkCTkWpRZkUZ6UlltZatQtNk
        Sdoe/TtObHFzAqRkewM523OOIklUXQJBUbmLd823JfciOfBtxfJQ/zPpFUzl9LL0w7KNaw
        GWUL+GJ/bi1p1dicmxRxdq02NNXaeyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-2Aq0qTI6MbitNKLSTYgyNw-1; Thu, 17 Sep 2020 09:34:17 -0400
X-MC-Unique: 2Aq0qTI6MbitNKLSTYgyNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A05ACE37;
        Thu, 17 Sep 2020 13:34:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id D2FF45DEBB;
        Thu, 17 Sep 2020 13:34:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Sep 2020 15:34:15 +0200 (CEST)
Date:   Thu, 17 Sep 2020 15:34:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Boaz Harrosh <boaz@plexistor.com>, Hou Tao <houtao1@huawei.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200917133411.GB5602@redhat.com>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200917124838.GT5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917124838.GT5449@casper.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/17, Matthew Wilcox wrote:
>
> On Thu, Sep 17, 2020 at 02:01:33PM +0200, Oleg Nesterov wrote:
> > IIUC, file_end_write() was never IRQ safe (at least if !CONFIG_SMP), even
> > before 8129ed2964 ("change sb_writers to use percpu_rw_semaphore"), but this
> > doesn't matter...
> >
> > Perhaps we can change aio.c, io_uring.c and fs/overlayfs/file.c to avoid
> > file_end_write() in IRQ context, but I am not sure it's worth the trouble.
>
> If we change bio_endio to invoke the ->bi_end_io callbacks in softirq

Not sure I understand...

How can this help? irq_exit() can invoke_softirq() -> __do_softirq() ?

Oleg.

