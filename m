Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628AE436829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 18:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhJUQmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhJUQmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:42:43 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08951C061764;
        Thu, 21 Oct 2021 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=PSTuS+2kRoxl2cZOxwy2FIn+5gaz/HAlHJRLYgxO/FU=; b=yO+7
        UjU3QZMeeIx5DkL/dLavKg+WrzAQ0+SztOxQ5QfQ+R+vi3OSIcMZ5pfRSeGgW7jrHAARTnHvpb3Wu
        5NB0tt7sD7e6o1q19dggFTCJpcXKoQkHehwg2TLJdtcsKNulTPA76DEOfwfJBXxlQJ+F6bmWYu1w6
        emCQgfWl+iQbCnRgbpNAOHn/uOEOQdRaxswKH9r/t+0X8pAcRFIBhpS7Rqvkz1ttXSH201hXG3j8Z
        lRN+MHY/rqGVOvNu/+5W3TXlNqZ1GjrtOpGPyWhlUnL4dXQU02HfIpnmnUbepkjnVEF/lUBajX72o
        ILhsJoalxyKxfncjQuJ6QnvXjGFU5A==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mdb78-0005xX-Hz; Thu, 21 Oct 2021 17:40:22 +0100
Date:   Thu, 21 Oct 2021 17:40:21 +0100
From:   John Keeping <john@metanate.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
Message-ID: <20211021174021.273c82b1.john@metanate.com>
In-Reply-To: <YXBWk8Zzi7yIyTi/@kroah.com>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
        <YXBSLweOk1he8DTO@infradead.org>
        <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk>
        <YXBWk8Zzi7yIyTi/@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Oct 2021 19:49:07 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Oct 20, 2021 at 11:35:27AM -0600, Jens Axboe wrote:
> > On 10/20/21 11:30 AM, Christoph Hellwig wrote:  
> > > On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:  
> > >> It's not used for anything, and we're wasting time passing in zeroes
> > >> where we could just ignore it instead. Update all ki_complete users in
> > >> the kernel to drop that last argument.
> > >>
> > >> The exception is the USB gadget code, which passes in non-zero. But
> > >> since nobody every looks at ret2, it's still pointless.  
> > > 
> > > Yes, the USB gadget passes non-zero, and aio passes that on to
> > > userspace.  So this is an ABI change.  Does it actually matter?
> > > I don't know, but you could CC the relevant maintainers and list
> > > to try to figure that out.  
> > 
> > True, guess it does go out to userspace. Greg, is anyone using
> > it on the userspace side?  
> 
> I really do not know (adding linux-usb@vger)  My interactions with the
> gadget code have not been through the aio api, thankfully :)
> 
> Odds are it's fine, I think that something had to be passed in there so
> that was chosen?  If the aio code didn't do anything with it, I can't
> see where the gadget code gets it back at anywhere, but I might be
> looking in the wrong place.
> 
> Anyone else here know?

I really doubt anyone uses io_event::res2 with FunctionFS gadgets.  The
examples in tools/usb/ffs-aio-example/ either check just "res" or ignore
the status completely.

The only other program I can find using aio FunctionFS is adbd which
also checks res and ignores res2 [1].  Other examples I know of just use
synchronous I/O.

[1] https://github.com/aosp-mirror/platform_system_core/blob/34a0e57a257f0081c672c9be0e87230762e677ca/adb/daemon/usb.cpp#L527
