Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F71388F21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353701AbhESNay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353711AbhESNax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 09:30:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAFCC06175F;
        Wed, 19 May 2021 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Bdmi+WfbavVhL8XpGmBLhMXr9IXd3zd7PnmGAw2j+w=; b=BudscKV1jhcknus3ugwZB7dBfl
        zTQs4xZaV9LRJr69acbS3LorOxjUu+J8qsIfuo971yrc3ramRFqWi/7ckKFgdfDxSzbSwS062CbE5
        901YvZs4E7WqXXw8JP2xp6igF3F2lMc/3+76FQz2AuV2MCHIoS4S22OOS67jXPi8FbfeYHaKOfpjW
        buHBHxudzsLgFDoKCKBQBdyydUc7IcMlTGJmvwKm4V51oOgL6sPbbW2tsae/IjFw2phiI/lMEAjQj
        hzutvYnMUQdi0Cpq+BuImrxBpAqGnbY3DAZ8KbGpF+L0uAuZOxZpP10NbvbrqsZJFOLoD6ZG+OwMD
        EXwTXLvQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljMFb-00EyVP-96; Wed, 19 May 2021 13:28:45 +0000
Date:   Wed, 19 May 2021 14:28:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Message-ID: <YKUSh4DVMCTzlSOE@infradead.org>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517171722.1266878-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 01:17:22PM -0400, Brian Foster wrote:
> The iomap writeback infrastructure is currently able to construct
> extremely large bio chains (tens of GBs) associated with a single
> ioend. This consolidation provides no significant value as bio
> chains increase beyond a reasonable minimum size. On the other hand,
> this does hold significant numbers of pages in the writeback
> state across an unnecessarily large number of bios because the ioend
> is not processed for completion until the final bio in the chain
> completes. Cap an individual ioend to a reasonable size of 4096
> pages (16MB with 4k pages) to avoid this condition.

Note that once we get huge page/folio support in the page cache this
sucks as we can trivially handle much larger sizes with very little
iteration.

I wonder if both this limit and the previous one should be based on the
number of pages added instead.  And in fact maybe if we only want the
limit at add to ioend time and skip the defer to workqueue part entirely.
