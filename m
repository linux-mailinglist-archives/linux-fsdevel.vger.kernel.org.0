Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54047EE80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbfHBIMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 04:12:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403902AbfHBIMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KjfLNU0SyqIyVrAxHzlRCdRO4H2dKobiLNT7ypOiSiU=; b=J4P9XXFF6r79xI9pt/gvdN9oA
        X2BwcCJGTOUfq1Js4lh22cDe6AkfCTnwQVmhlxluksQvNyI5oF9lpPy5MckRL2x9WShvEg2EGleyc
        pilujzQ40oIUsYl7Cd0HiAVfsD2LNRfimYy7A2AWWnE5cNuUYlfJoUISYSIQ7WGGauYbZ4KKLUOsw
        ZShxaJJyNljB1jTZLdCyTON4yE+V7sW94y0xtokoq4FUgM56q+Q4z5tYxT/ID2b1bjIQqDGRYUTtY
        rPEW3iODyLo8ESy8fFTBdNddfZI4K6k8qCDYVZSYYKnH3NAVbnCkynp0MrsiOL0OBLFFbBEf9Awve
        V3qlCc83g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htSfl-0004Xd-Uu; Fri, 02 Aug 2019 08:12:22 +0000
Date:   Fri, 2 Aug 2019 01:12:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Message-ID: <20190802081221.GA15849@infradead.org>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
 <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
 <20190801235849.GO7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801235849.GO7777@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:58:49AM +1000, Dave Chinner wrote:
> Which simply reinforces the fact that that request type based
> throttling is a fundamentally broken architecture.
> 
> > It feels awkward to have one set of prio inversion workarounds for io.* 
> > and another for wbt.  Jens, should we make an explicit one that doesn't 
> > rely on magic side effects, or just decide that metadata is meta enough 
> > to break all the rules?
> 
> The problem isn't REQ_META blows throw the throttling, the problem
> is that different REQ_META IOs have different priority.
> 
> IOWs, the problem here is that we are trying to infer priority from
> the request type rather than an actual priority assigned by the
> submitter. There is no way direct IO has higher priority in a
> filesystem than log IO tagged with REQ_META as direct IO can require
> log IO to make progress. Priority is a policy determined by the
> submitter, not the mechanism doing the throttling.
> 
> Can we please move this all over to priorites based on
> bio->b_ioprio? And then document how the range of priorities are
> managed, such as:

Yes, we need to fix the magic deducted throttling behavior, especiall
the odd REQ_IDLE that in its various incarnations has been a massive
source of toruble and confusion.  Not sure tons of priorities are
really helping, given that even hardware with priority level support
usually just supports about two priorit levels.
