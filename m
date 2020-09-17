Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B763926E5A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 21:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIQTzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgIQO6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:58:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73AC061351;
        Thu, 17 Sep 2020 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e46ZxCmYJpeJz6E3Pq9hIabq8Ncj/V4WuCKu6cUX04k=; b=GgmJhYxu8pKJ+ZfpFhuO/KjJyt
        FmOkSlVuFX6W5Ke0+UtWhFqTTiIXtAiUEvVAWpz2n9qUDej5ce/P1keOJeOGFxleNC9illwlgVVZZ
        Tziy+vgLb9Ad+ITL5FA+fQXPPHX/PLCT6k9Z+wY4iDW4aWNHH5zEptwGHkknAhpkHD/oRBQMbGNhN
        4UyBy6tUH1GvypyIWQdwGc2d0d8n0ZmbDOcwv3Qo2JWgFmCwEVxT9QQd/Tu1VMYK2ZQfIT6Iqcr09
        3o7Y7VVEN4q74E53lqMa0sVs7MEkyCl55hYnMBUzdM9A1Ci7Dvfr6wtUkqGIyNhHcrylB/hwjDgY+
        YUnPjkew==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvBQ-00088r-K0; Thu, 17 Sep 2020 14:46:48 +0000
Date:   Thu, 17 Sep 2020 15:46:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Hou Tao <houtao1@huawei.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200917144648.GA31086@infradead.org>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200917124838.GT5449@casper.infradead.org>
 <e25a3354-04e4-54e9-a45f-7305bfd1f2bb@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25a3354-04e4-54e9-a45f-7305bfd1f2bb@plexistor.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:46:38PM +0300, Boaz Harrosh wrote:
> From my totally subjective experience on the filesystem side (user of
> bio_endio) all HW block drivers I used including Nvme isci, sata... etc. end
> up calling bio_endio in softirq. The big exception to that is the vdX
> drivers under KVM. Which is very Ironic to me.

NVMe normally calls it from hardirq or IPI context.  The only time it
would use softirq context is if you have a single I/O queue, which is
very unusual.
