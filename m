Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FF79A0FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 03:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjIKB30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 21:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjIKB3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:29:25 -0400
Received: from out-218.mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDB120
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 18:29:20 -0700 (PDT)
Date:   Sun, 10 Sep 2023 21:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694395758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/067N3kX+ABJDEuP6c43RBjZCPIIWi7C+j2z8M68tY=;
        b=kQNIn3zWOTrxcr9QErpabo2qo29sdXDkHwVXFQaRX5eE8vQKeFwU/PWjUoDRGRHMH603Fz
        fnapEZr8W2VrSSXqN55pf6QSlY+Q5sxxFXRiv+pD6jwt9e1MBgJcWtmc5eAbY1HEyKvcSi
        Nz2u2vAva1xNw8fHxw98SPeUOxOOKvE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
 <ZP5nxdbazqirMKAA@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP5nxdbazqirMKAA@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:05:09AM +1000, Dave Chinner wrote:
> On Sat, Sep 09, 2023 at 06:42:30PM -0400, Kent Overstreet wrote:
> > On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > > So why can't we figure out that easier way? What's wrong with trying to
> > > figure out if we can do some sort of helper or library set that assists
> > > supporting and porting older filesystems. If we can do that it will not
> > > only make the job of an old fs maintainer a lot easier, but it might
> > > just provide the stepping stones we need to encourage more people climb
> > > up into the modern VFS world.
> > 
> > What if we could run our existing filesystem code in userspace?
> 
> You mean like lklfuse already enables?

I'm not seeing that it does?

I just had a look at the code, and I don't see anything there related to
the VFS - AFAIK, a VFS -> fuse layer doesn't exist yet.

And that looks a lot heavier than what we'd ideally want, i.e. a _lot_
more kernel code would be getting pulled in. The entire block layer,
probably the scheduler as well.

What I've got in bcachefs-tools is a much thinner mapping from e.g.
kthreads -> pthreads, block layer -> aio, etc.
