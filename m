Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFD3E5A02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbhHJMfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 08:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhHJMfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:35:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66288C0613D3;
        Tue, 10 Aug 2021 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Eibxde9ggx54b5TBpNP+oBpZ0ThMzYJ1OQ+F+Hf7IU=; b=r1eXHXnv/xi2nTA4IlUEdZL/gl
        aiAmEz31byi7ERD4xN/iaW8IozUq8x8hAecNx1Rc73WW430UhZWuAkryy1uMmmqTbW1TnHZuvXrqK
        FsjVrILygugSexALlOacSKdxYERbCfNYhOM3P5mt8bhYxoZK1aiPM0wDWTIvJ1X9LxQb23wKxYT3v
        1f5K/5a+LiW0cMjtZrxKrwjFb4TqsLxNVld7nMi4oY06na7TTAATHxj8YgLPexLuF9RvQlYJmdpbJ
        ay0NuZjJDP/0RIlwLpJiDJFAULErz5D1AKSPwQNyDnaQ+HWVKn5xtvD5h4T+hyhvqM/jTw+5f+KjW
        lWhn0SGQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDQwi-00C6cz-GN; Tue, 10 Aug 2021 12:33:52 +0000
Date:   Tue, 10 Aug 2021 13:33:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vishal Moola <vishal.moola@gmail.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Page Cache Allowing Hard Interrupts
Message-ID: <YRJyGMLAFKoB1qUQ@infradead.org>
References: <20210730213630.44891-1-vishal.moola@gmail.com>
 <YRI1oLdiueUbBVwb@infradead.org>
 <YRJsiapS/M3BOH9D@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRJsiapS/M3BOH9D@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 01:09:45PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 10, 2021 at 09:15:28AM +0100, Christoph Hellwig wrote:
> > Stupid question, but where do we ever do page cache interaction from
> > soft irq context?
> 
> test_clear_page_writeback() happens in _some_ interrupt context (ie
> the io completion path).  We had been under the impression that it was
> always actually softirq context, and so this patch was safe.  However,
> it's now clear that some drivers are calling it from hardirq context.
> Writeback completions are clearly not latency sensitive and so can
> be delayed from hardirq to softirq context without any problem, so I
> think fixing this is just going to be a matter of tagging requests as
> "complete in softirq context" and ensuring that blk_mq_raise_softirq()
> is called for them.
> 
> Assuming that DIO write completions _are_ latency-sensitive, of course.
> Maybe all write completions could be run in softirqs.

I really don't really see any benefit in introducing softirqs into
the game.  If we want to simplify the locking and do not care too much
about latency, we should just defer to workqueue/thread context.
For example XFS already does that for all writeback except for pure
overwrites.  Those OTOH can be latency critical for O_SYNC writes, but
you're apparently looking into that already.
