Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39E255721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 11:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgH1JH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 05:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1JH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:07:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB9C061264;
        Fri, 28 Aug 2020 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OCLR/ZgRgIDU1Za+nMPcFKSe6wyAHENv7Vfjt1vEDMw=; b=RhkXHhTgpEKihLf7pqcWWdluts
        Z6WqG43HsDDIIzVJQBmDVRhvwC9UzJbGS+n2FCoaAjVhrQXv9f95QvnYGU1tBZ9TX7BdAQ7vePARc
        dhQ7Rgb8OpHOd9t/7fFiMdhW1ZPQjhEU5Nebu6KdyNy3QmXMF3kgrcmh3Yr9cckw4c1Zici2EnC95
        cBeyQriv90eHJ1CKJWTLdbEGPtkFzX2ws3+pgciKBNNbLO3jo63pp6bV4TBh0XpPvKbY0EzRtUVlh
        3jXYFUkHISKa6/UPhSBTDe1zXYkhIv7HexpNfz3jx9n3SyhV3xNIRF6B0b8aH81j/mQWkN5JtOGAD
        2j0LspSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBaM6-0006F1-6X; Fri, 28 Aug 2020 09:07:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 655113003E5;
        Fri, 28 Aug 2020 11:07:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44CAB2C56E664; Fri, 28 Aug 2020 11:07:29 +0200 (CEST)
Date:   Fri, 28 Aug 2020 11:07:29 +0200
From:   peterz@infradead.org
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     <viro@zeniv.linux.org.uk>, <bcrl@kvack.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aio: make aio wait path to account iowait time
Message-ID: <20200828090729.GT1362448@hirez.programming.kicks-ass.net>
References: <20200828060712.34983-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828060712.34983-1-tian.xianting@h3c.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:07:12PM +0800, Xianting Tian wrote:
> As the normal aio wait path(read_events() ->
> wait_event_interruptible_hrtimeout()) doesn't account iowait time, so use
> this patch to make it to account iowait time, which can truely reflect
> the system io situation when using a tool like 'top'.

Do be aware though that io_schedule() is potentially far more expensive
than regular schedule() and io-wait accounting as a whole is a
trainwreck.

When in_iowait is set schedule() and ttwu() will have to do additional
atomic ops, and (much) worse, PSI will take additional locks.

And all that for a number that, IMO, is mostly useless, see the comment
with nr_iowait().

But, if you don't care about performance, and want to see a shiny random
number generator, by all means, use io_schedule().
