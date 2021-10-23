Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4239A438289
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 11:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhJWJLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 05:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhJWJLr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B45761057;
        Sat, 23 Oct 2021 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634980169;
        bh=0qKIie6rK3heoVu9MUJbsWqFihiTgEXSv9xNYLKhEfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLfDWxeBaflKAIgJLwkqC1h0eYRpV7nX8LpHHWfCq/8t5e6o7CpaORPhQHsSS9ghL
         s9sRE4U6zX+erTLUqYaEfrYF/0raGSVHZlYNExRW08ma2L3N+mCcQ5AWz7lr9TyYyR
         IevdlXwx5gOQ9Zvgl5iWjmg3eh7eNa7Fc/c5w+lc=
Date:   Sat, 23 Oct 2021 11:09:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
Message-ID: <YXPRQV1BT2yYYOgN@kroah.com>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <YXBSLweOk1he8DTO@infradead.org>
 <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk>
 <YXBWk8Zzi7yIyTi/@kroah.com>
 <20211021174021.273c82b1.john@metanate.com>
 <e39e7f45-1c1e-a9bb-b413-1dfc21b1b20f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39e7f45-1c1e-a9bb-b413-1dfc21b1b20f@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:44:32AM -0600, Jens Axboe wrote:
> On 10/21/21 10:40 AM, John Keeping wrote:
> > On Wed, 20 Oct 2021 19:49:07 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> >> On Wed, Oct 20, 2021 at 11:35:27AM -0600, Jens Axboe wrote:
> >>> On 10/20/21 11:30 AM, Christoph Hellwig wrote:  
> >>>> On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:  
> >>>>> It's not used for anything, and we're wasting time passing in zeroes
> >>>>> where we could just ignore it instead. Update all ki_complete users in
> >>>>> the kernel to drop that last argument.
> >>>>>
> >>>>> The exception is the USB gadget code, which passes in non-zero. But
> >>>>> since nobody every looks at ret2, it's still pointless.  
> >>>>
> >>>> Yes, the USB gadget passes non-zero, and aio passes that on to
> >>>> userspace.  So this is an ABI change.  Does it actually matter?
> >>>> I don't know, but you could CC the relevant maintainers and list
> >>>> to try to figure that out.  
> >>>
> >>> True, guess it does go out to userspace. Greg, is anyone using
> >>> it on the userspace side?  
> >>
> >> I really do not know (adding linux-usb@vger)  My interactions with the
> >> gadget code have not been through the aio api, thankfully :)
> >>
> >> Odds are it's fine, I think that something had to be passed in there so
> >> that was chosen?  If the aio code didn't do anything with it, I can't
> >> see where the gadget code gets it back at anywhere, but I might be
> >> looking in the wrong place.
> >>
> >> Anyone else here know?
> > 
> > I really doubt anyone uses io_event::res2 with FunctionFS gadgets.  The
> > examples in tools/usb/ffs-aio-example/ either check just "res" or ignore
> > the status completely.
> > 
> > The only other program I can find using aio FunctionFS is adbd which
> > also checks res and ignores res2 [1].  Other examples I know of just use
> > synchronous I/O.
> 
> So is there consensus on the USB side that we can just fill res2 with
> zero? The single cases that does just do res == res2 puts the error
> in res anyway, which is what you'd expect.
> 
> If so, then I do think that'd be cleaner than packing two values into
> a u64.

I think yes, we should try that, and if something breaks, be ready to
provide a fix for it.

thanks,

greg k-h
