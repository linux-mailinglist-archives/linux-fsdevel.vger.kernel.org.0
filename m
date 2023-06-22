Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C87395A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 04:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFVC4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 22:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVC4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:56:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039BC6;
        Wed, 21 Jun 2023 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtSJ4+V5YXDJtcUG1UAUgd4mT3PAUroEXWopFI1UU4s=; b=S+UdIInqoq25X8hzomGmVbw375
        h7+H+pLjVqAoHq3VHd3tTCkOXT8h35BOeeAio7Bd4nCKWWuwCBoKXjPSg2IVNZn1mI/lB+M2arwh8
        eSHFVvXgrkj6IgsMSzzPMcOdMOb+jl50+mNJVA8MwOkNESteSnlMeipmMlWsCOi1eiVo/Xwe0IkCu
        qRw+ThrgJI7/YKYdXJYbDuOGl8KOfV8cqKslEkAsbcVgiq/hC0LXeuBgMT9rptQVoD9dQZPynnF9E
        nf004CvPAIEavw8olFWhHbTzu+6ZTG8CT7dvNkEXQxcstE2aYfbMauVade6OTmMWz+lkZlGA1h+hb
        De2d47aA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCAUC-00FCyw-E3; Thu, 22 Jun 2023 02:55:52 +0000
Date:   Thu, 22 Jun 2023 03:55:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <ZJO4OAYhJlXOBXMf@casper.infradead.org>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <ZJOO4SobNFaQ+C5g@dread.disaster.area>
 <ZJOqC7Cfjr5AoW7S@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJOqC7Cfjr5AoW7S@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:55:23AM +1000, Dave Chinner wrote:
> Ok, so having spent a bit more thought on this away from the office
> this morning, I think there is a generic way we can avoid deferring
> completions for pure overwrites.

OK, this is how we can, but should we?  The same amount of work
needs to be done, no matter whether we do it in interrupt context or
workqueue context.  Doing it in interrupt context has lower latency,
but maybe allows us to batch up the work and so get better bandwidth.
And we can't handle other interrupts while we're handling this one,
so from a whole-system perspective, I think we'd rather do the work in
the workqueue.

Latency is important for reads, but why is it important for writes?
There's such a thing as a dependent read, but writes are usually buffered
and we can wait as long as we like for a write to complete.
