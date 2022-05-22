Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83303530264
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiEVKXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbiEVKXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 06:23:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB4736B57
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wUubU+HmIcHpRY/X4cHdqx89+iYgGlhk+ON6D2Vbfe4=; b=AAr2/sQYQ9kWN0EW4uu/7h0ibJ
        70UY7sUv5pCWqN5I/070QYfaSGWHfoFzfCmUPFGsr6wflY6XFCGE+SY1K2DyOhCkj6xeCaPNd43Sx
        jOjUcToP2jXV0CGfUlTIYz/JRZzE5PoVVh+Kq5fuaP900eI6/KI8psjUmdpr4/q8VximUocnHQyfp
        OZdnWkQO7nlC6XT1zuQSULtbvNrNxo/9x+i/lA83R7HHnozR7F1aeBm97Dg4m+8QFzGibWOiEf6fm
        bqx9sQ7ayCnLKrw1zgCQRQUMQoRTYkJo2Lm+UDoeB582mPDE+zCPymo4FGoUy24xMGmRfznpTceQa
        J1293Q7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsikR-00FIsm-6E; Sun, 22 May 2022 10:23:43 +0000
Date:   Sun, 22 May 2022 11:23:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YooPLyv578I029ij@casper.infradead.org>
References: <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de>
 <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de>
 <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522074508.GB15562@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 09:45:09AM +0200, Christoph Hellwig wrote:
> On Sat, May 21, 2022 at 04:14:07PM -0600, Jens Axboe wrote:
> > Then we're almost on par, and it looks like we just need to special case
> > iov_iter_advance() for the nr_segs == 1 as well to be on par. This is on
> > top of your patch as well, fwiw.
> > 
> > It might make sense to special case the single segment cases, for both
> > setup, iteration, and advancing. With that, I think we'll be where we
> > want to be, and there will be no discernable difference between the iter
> > paths and the old style paths.
> 
> A while ago willy posted patches to support a new ITER type for direct
> userspace pointer without iov.  It might be worth looking through the
> archives and test that.

https://lore.kernel.org/linux-fsdevel/Yba+YSF6mkM%2FGYlK@casper.infradead.org/
