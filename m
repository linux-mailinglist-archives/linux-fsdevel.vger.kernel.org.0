Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5A26FB1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIRLDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgIRLDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:03:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE428C06174A;
        Fri, 18 Sep 2020 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=92sFFvsbksd+Q+ekXiuYgLRc7bHpzXKtlRe7taGQ3R4=; b=No0LQr9wd6VpEKjh9PeHsQSz46
        08Zg0cPPnvi1h/4/oT3HEARgvxxWZFm4j8DbddK73E8n0zd3+z8A6fpLBSGRuoYrJeX55XUQDlTyE
        4TF6MKskZ7lZNIdtQ30SAJcR1RPXuXSlfoppRQlIRH30xeodU01xNmPuz7EfFA8JAcQLlCCSYli3h
        b4TgzU5fr0S2IxmRXhgzE7qhefxLHtLFdMdn9Qyz0SrbUVt9xY7ZJWWPX4D9OdTaN2p7r+a9KKJgF
        CNUkbp90FFtct5VPoA0gazcQHFgQ/OG+wihno2BxPBOFwzKEAGme3/6T+jEEFV52dUY5wTHLihht/
        SBEPipeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJEAa-0008MB-4Y; Fri, 18 Sep 2020 11:03:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 680D93060F2;
        Fri, 18 Sep 2020 13:03:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4475720D4DC83; Fri, 18 Sep 2020 13:03:10 +0200 (CEST)
Date:   Fri, 18 Sep 2020 13:03:10 +0200
From:   peterz@infradead.org
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918110310.GO1362448@hirez.programming.kicks-ass.net>
References: <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
 <20200918101216.GL35926@hirez.programming.kicks-ass.net>
 <20200918104824.GA23469@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918104824.GA23469@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:48:24PM +0200, Oleg Nesterov wrote:

> Of course, this assumes that atomic_t->counter underflows "correctly", just
> like "unsigned int".

We're documented that we do. Lots of code relies on that.

See Documentation/atomic_t.txt TYPES

> But again, do we really want this?

I like the two counters better, avoids atomics entirely, some archs
hare horridly expensive atomics (*cough* power *cough*).

I just tried to be clever and use a single u64 load (where possible)
instead of two 32bit loads and got the sum vs split order wrong.
