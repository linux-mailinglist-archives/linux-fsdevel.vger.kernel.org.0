Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9F530559
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiEVTEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEVTEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 15:04:41 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074F337BC1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JGKLTC8oQR9alh9QZ+lP2q9IYvsxt7/ZtV57iruQK4=; b=DJM94kXoSynv4yg/abPW8Bvc68
        TcUv7akbhzJARL4Ym/WLKRSsZWt5iT+UmVJ+J2jKvE0k4di1giEJVG8aa+UZONPFa3c6VWLAmMGRC
        S4O6qrKxABGeW5DdilKfLakk5Sea82jRl9GNiX1Kr9sfZpT4MWIRet4LO1Xv6j5BJkn/HTN7fEdBr
        In2xhfB4JBPZUu5HG7LwSUDu042nVxDpT+eIQLh/rTJlhd3vUlmmsSiig6f63/DxAbOQhKO/EUO+b
        o2+qKDXWaZ+SXkq58p1nwoUguGriHFnuR+HqOoAUVQEo4qdpHC3va2bWGuqHctsyGdpZCejDBz6Bg
        KeL84Njg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsqsW-00HGoU-HA; Sun, 22 May 2022 19:04:36 +0000
Date:   Sun, 22 May 2022 19:04:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
References: <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 12:48:20PM -0600, Jens Axboe wrote:
> On 5/22/22 12:39 PM, Al Viro wrote:
> > On Sun, May 22, 2022 at 12:29:16PM -0600, Jens Axboe wrote:
> >> It was sent out as a discussion point, it's not a submission and it's by
> >> no means complete (as mentioned!). If you're working on this, I'd be
> >> happy to drop it, it's not like I really enjoy the iov_iter code... And
> >> it sounds like you are?
> > 
> > *snort*
> > 
> > Yes, I am working on it.  As for enjoying that thing...  I'm not fond of
> 
> OK great, I'll abandon this sandbox. Let me know when you have something
> to test, and I can compare some numbers between non-iter, iter,
> iter-with-ubuf.
> 
> > forests of macros, to put it mildly.  Even in the trimmed form it still
> > stinks, and places like copy_page_to_iter for iovec are still fucking
> > awful wrt misguided microoptimization attempts - mine, at that, so I've
> > nobody else to curse ;-/
> 
> And it's not even clear which ones won't work with the generic variants,
> and which ones are just an optimization. I suspect a lot of the icache
> bloat from this just makes things worse...

???

copy_page_{from,to}_iter() iovec side is needed not for the sake of
optimizations - if you look at the generic variant, you'll see that it's
basically "kmap_local_page + copy_{to,from}_iter() for the contents +
kunmap_local_page", which obviously relies upon the copy_{to,from}_iter()
being non-blocking.  So iovec part of it genuinely needs to differ from
the generic variant; it's just that on top of that it had been (badly)
microoptimized.  So were iterators, but that got at least somewhat cleaned
up a while ago.  And no, turning that into indirect calls ended up with
arseloads of overhead, more's the pity...

Anyway, at the moment I have something that builds; hadn't tried to boot it yet.
