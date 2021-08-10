Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F343E5C91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhHJOJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbhHJOJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:09:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174E2C0613D3;
        Tue, 10 Aug 2021 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5o2X/hCLV7cpukH2oc7YrdoxcLinZ80KA7F0XExRIIQ=; b=G7JNfDn2E3Yqko3QMw5vmP2NW2
        ioSwGdje9u+wA6M5Y0AlzbnP1x+YGPiFcjLq8UK0nhfFiuM9R3jdBoVvhn4td7tEUywlRmqE0QwUf
        5OY2S869MiBiQMcecsZVtd9qtk4sotUTXTbKqw+1xVDaKrrsSOFhLboCKmfaJR8cMyf4/e1JtpkhM
        by1+c+X6twREHyKgD2J1Lnul+zwZJDAUu1jgiyJhLBh4QyA0Y4SNJ0+G2J3sCjwRyRCnihFH0fq/v
        KSrWIiphg7cUXidSSULbagNVzERZ9yvY4Kf44hNXeBZkPnadyyFp+LFYTbL99Ncw0QB3eBCC+wXqC
        VSIWKBDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDSQX-00CC2G-5a; Tue, 10 Aug 2021 14:08:27 +0000
Date:   Tue, 10 Aug 2021 15:08:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vishal Moola <vishal.moola@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Page Cache Allowing Hard Interrupts
Message-ID: <YRKIVZIxdirjg7Ih@casper.infradead.org>
References: <20210730213630.44891-1-vishal.moola@gmail.com>
 <YRI1oLdiueUbBVwb@infradead.org>
 <YRJsiapS/M3BOH9D@casper.infradead.org>
 <YRJyGMLAFKoB1qUQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRJyGMLAFKoB1qUQ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 01:33:28PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 01:09:45PM +0100, Matthew Wilcox wrote:
> > On Tue, Aug 10, 2021 at 09:15:28AM +0100, Christoph Hellwig wrote:
> > > Stupid question, but where do we ever do page cache interaction from
> > > soft irq context?
> > 
> > test_clear_page_writeback() happens in _some_ interrupt context (ie
> > the io completion path).  We had been under the impression that it was
> > always actually softirq context, and so this patch was safe.  However,
> > it's now clear that some drivers are calling it from hardirq context.
> > Writeback completions are clearly not latency sensitive and so can
> > be delayed from hardirq to softirq context without any problem, so I
> > think fixing this is just going to be a matter of tagging requests as
> > "complete in softirq context" and ensuring that blk_mq_raise_softirq()
> > is called for them.
> > 
> > Assuming that DIO write completions _are_ latency-sensitive, of course.
> > Maybe all write completions could be run in softirqs.
> 
> I really don't really see any benefit in introducing softirqs into
> the game.

The benefit is not having to disable interrupts while manipulating
the page cache, eg delete_from_page_cache_batch().

> If we want to simplify the locking and do not care too much
> about latency, we should just defer to workqueue/thread context.

It's not a bad idea.  I thought BH would be the better place for it
because it wouldn't require scheduling in a task.  If we are going to
schedule in a task though, can we make it the task which submitted the I/O
(assuming it still exists), or do we not have the infrastructure for that?

> For example XFS already does that for all writeback except for pure
> overwrites.  Those OTOH can be latency critical for O_SYNC writes, but
> you're apparently looking into that already.

To my mind if you've asked for O_SYNC, you've asked for bad performance.

The writethrough improvement that I'm working on skips dirtying the page,
but still marks the page as writeback so that we don't submit overlapping
writes to the device.  The O_SYNC write will wait for the writeback to
finish, so it'll still be delayed by one additional scheduling event
... unless we run the write completion in the context of this task.
