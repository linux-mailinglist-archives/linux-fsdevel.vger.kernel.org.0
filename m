Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C70132D46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgAGRmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:42:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gOiFIlZRVnOoBxSXmVwGYFu8Oc2PBoCKHWX6MtqQFiU=; b=kBxKQv05tR88yHPqmZPS9DjdT
        JiNHmm/82p+m9xZTf2dKIujfr9khftReZFdNEXbbHz3w73EarWaoi09SEmqxnSGza9BkXGMBZcKQV
        oF0+/9JEt35FM/7l+CED0sZhx2ZgyyVZ76L3zzH5O0rEBjoBGu+N8fFR1m40Ku7L9cxLg3srHGU6w
        WUN+5uPadqjbIfB6BgQpTZS79lnlE4H/AMVAFJ+y02AgL63hfkIlwU3jSqoE5qY1/oMVjApl2yyX1
        VPzJUfGURFGxrIqPiUViXhqwt59ZQ4Ws539heX5WcP2EVd8rnTMC63qp0wmCTPwk2yDdoUcrFsI7c
        oevsLctfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iosri-00046i-4n; Tue, 07 Jan 2020 17:42:02 +0000
Date:   Tue, 7 Jan 2020 09:42:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20200107174202.GA8938@infradead.org>
References: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <20191212221818.GG19213@dread.disaster.area>
 <C08B7F86-C3D6-47C6-AB17-6F234EA33687@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C08B7F86-C3D6-47C6-AB17-6F234EA33687@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:32:10AM +0000, Chris Mason wrote:
> They just have different tradeoffs.  O_DIRECT actively blows away caches 
> and can also force writes during reads, making RWF_UNCACHED a more 
> natural fit for some applications.  There are fewer surprises, and some 
> services are willing to pay for flexibility with a memcpy.  In general, 
> they still want to do some cache management because it reduces p90+ 
> latencies across the board, and gives them more control over which pages 
> stay in cache.

We can always have a variant of O_DIRECT that doesn't do that and
instead check if data was in the cache and then also copy / from to
it in that case.  I need some time to actually look through this series,
so it might be pretty similar to the implementation, but if defined
the right way it could be concurrent for at least the fast path of no
cached pages.
