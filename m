Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41FE3B1C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFWO3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWO3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:29:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F8C061574;
        Wed, 23 Jun 2021 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DDDhkKoOSvn2SSqNME1lq0AiPIJcymhF4xvIun7LjzI=; b=tXCs140TX5Dp/CQfrgnASXfijn
        78PTLXbWv37XLx1RsZQh3kUkN2I4QGm9SlH7fyJdRRJdFqALd1gUZ4eOd6o7+J03FvMM/2qILobp7
        +mZgYskd6ChXuoDA5zGCjPiXTXMpI7yJMuaYkK25dNQ5sF3swAXX1ZTijJDfcrt9mllz7XgOq4Rlg
        WPZZyEaVkreWGJ4vBi7dpRJRrpkumYhDaFZijUS8Dyj+wUiZ8F4cJKqP21BxaWEGYzbFtbcJ/HsIJ
        wBO8Irhv87qkBTwWW6QTbulmxkMO5Dq7DpguJCdCERlRS2z4fcS17JitCT2Ksy5I1sz3+ZPTa9rYP
        2+LiLb+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw3pF-00FW9x-Rd; Wed, 23 Jun 2021 14:26:08 +0000
Date:   Wed, 23 Jun 2021 15:25:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 6/6] loop: increment sequence number
Message-ID: <YNNEdbr+0p+PzinQ@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-7-mcroce@linux.microsoft.com>
 <YNMhwLMr7DiNdqC/@infradead.org>
 <bbd3d100ee997431b2905838575eb4bdec820ad3.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd3d100ee997431b2905838575eb4bdec820ad3.camel@debian.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:13:25PM +0100, Luca Boccassi wrote:
> On Wed, 2021-06-23 at 12:57 +0100, Christoph Hellwig wrote:
> > On Wed, Jun 23, 2021 at 12:58:58PM +0200, Matteo Croce wrote:
> > > From: Matteo Croce <mcroce@microsoft.com>
> > > 
> > > On a very loaded system, if there are many events queued up from multiple
> > > attach/detach cycles, it's impossible to match them up with the
> > > LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the position
> > > of our own association in the queue is[1].
> > > Not even an empty uevent queue is a reliable indication that we already
> > > received the uevent we were waiting for, since with multi-partition block
> > > devices each partition's event is queued asynchronously and might be
> > > delivered later.
> > > 
> > > Increment the disk sequence number when setting or changing the backing
> > > file, so the userspace knows which backing file generated the event:
> > 
> > Instead of manually incrementing the sequence here, can we make loop
> > generate the DISK_EVENT_MEDIA_CHANGE event on a backing device (aka
> > media) change?
> 
> Hi,
> 
> This was answered in the v1 thread:
> 
> https://lore.kernel.org/linux-fsdevel/20210315201331.GA2577561@casper.infradead.org/t/#m8a677028572e826352cbb1e19d1b9c1f3b6bff4b
> 
> The fundamental issue is that we'd be back at trying to correlate
> events to loopdev instances, which does not work reliably - hence this
> patch series. With the new ioctl, we can get the id immediately and
> without delay when we create the device, with no possible races. Then
> we can handle events reliably, as we can correlate correctly in all
> cases.

I very much disagree with your reply there.  The device now points to
a different media.  Both for the loop device, a floppy or a CD changer
probably by some kind of user action.  In the last cast it might even
by done entirely locally through a script just like the loop device.
