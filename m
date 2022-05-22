Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687695302BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245122AbiEVLps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiEVLpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 07:45:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716B252AA
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 04:45:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B611668AFE; Sun, 22 May 2022 13:45:40 +0200 (CEST)
Date:   Sun, 22 May 2022 13:45:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20220522114540.GA20469@lst.de>
References: <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk> <20210621143501.GA3789@lst.de> <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk> <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk> <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk> <20220522074508.GB15562@lst.de> <YooPLyv578I029ij@casper.infradead.org> <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk> <Yoobb6GZPbNe7s0/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoobb6GZPbNe7s0/@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 12:15:59PM +0100, Matthew Wilcox wrote:
> > 	Direct kernel pointer, surely?  And from a quick look,
> > iov_iter_is_kaddr() checks for the wrong value...
> 
> Indeed.  I didn't test it; it was a quick patch to see if the idea was
> worth pursuing.  Neither you nor Christoph thought so at the time, so
> I dropped it.  if there are performance improvements to be had from
> doing something like that, it's a more compelling idea than just "Hey,
> this removes a few lines of code and a bit of stack space from every
> caller".

Oh, right I actually misremembered what the series did.  But something
similar except for user pointers might help with the performance issues
that Jens sees, and if it does it might be worth it to avoid having
both the legacy read/write path and the iter path in various drivers.
