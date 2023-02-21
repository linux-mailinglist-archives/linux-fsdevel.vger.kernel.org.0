Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8B69E8AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 20:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBUT6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 14:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBUT6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:58:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF192129E;
        Tue, 21 Feb 2023 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3m7BCGAEZNjDasZrz2wufh7wDwBRXOZCBbm7SGl9TRc=; b=IHbWhPII7qYnTuhitFCv7e8Ptx
        +DDIa91/rALCRuXZ3Y67WQ3Sf7pMxTt3xXHQ+0yy4i3B8bbi6qqT+JWr+3wQ2C7OMw5IZOMeyvMvE
        hGMoCoqSMp+aoBcnhOLm3FdWMwC6OrUvR8P65lm/ufn8IvmmsJJN5hhc50tBCz888s5FvEOxZCdek
        yE6Oma0hpMqRqM+rGYSIZ/cbZhyIiW7KmnMr5/mfRsBNUFmPxn/593lUZDWT0+Dj+NjtO0jm2SaUD
        Ch1AGOvX1J2BRTlv26sDVzx8QV5VcCkfwO9yvzMKgfeuV66IT1iHF+0/Rx6/Vju4FziwY/8lcwkyF
        lgzryj5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUYmR-00CsKI-Cd; Tue, 21 Feb 2023 19:58:27 +0000
Date:   Tue, 21 Feb 2023 19:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Y/UiY/08MuA/tBku@casper.infradead.org>
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 22, 2023 at 02:08:28AM +0800, Gao Xiang wrote:
> On 2023/1/27 00:40, Matthew Wilcox wrote:
> > I'd like to do another session on how the struct page dismemberment
> > is going and what remains to be done.  Given how widely struct page is
> > used, I think there will be interest from more than just MM, so I'd
> > suggest a plenary session.
> 
> I'm interested in this topic too, also I'd like to get some idea of the
> future of the page dismemberment timeline so that I can have time to keep
> the pace with it since some embedded use cases like Android are
> memory-sensitive all the time.

As you all know, I'm absolutely amazing at project management & planning
and can tell you to the day when a feature will be ready ;-)

My goal for 2023 is to get to a point where we (a) have struct page
reduced to:

struct page {
	unsigned long flags;
	struct list_head lru;
	struct address_space *mapping;
	pgoff_t index;
	unsigned long private;
	atomic_t _mapcount;
	atomic_t _refcount;
	unsigned long memcg_data;
#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
	int _last_cpupid;
#endif
};

and (b) can build an allnoconfig kernel with:

struct page {
	unsigned long flags;
	unsigned long padding[5];
	atomic_t _mapcount;
	atomic_t _refcount;
	unsigned long padding2;
#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
	int _last_cpupid;
#endif
};

> Minor, it seems some apis still use ->lru field to chain bulk pages,
> perhaps it needs some changes as well:
> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com

Yang Shi covered the actual (non-)use of the list version of the bulk
allocator already, but perhaps more importantly, each page allocated
by the bulk allocator is actually a separately tracked allocation.
So the obvious translation of the bulk allocator from pages to folios
is that it allocates N order-0 folios.

That may not be the best approach for all the users of the bulk allocator,
so we may end up doing something different.  At any rate, use of page->lru
isn't the problem here (yes, it's something that would need to change,
but it's not a big conceptual problem).
