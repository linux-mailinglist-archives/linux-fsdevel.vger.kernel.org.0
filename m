Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133D9CFDC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfJHPih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHPig (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:38:36 -0400
Received: from localhost (unknown [89.205.136.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E902070B;
        Tue,  8 Oct 2019 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570549114;
        bh=gjdt14TlOZyesMNTH7/5zSE94bMrmk0OHHv7OXJGXaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6Hw1hA8MaxUCugwMm+KqWjnL4ueUeMaByU1o/g241xDYq/YvMvFCndcGgL6KBg/C
         CHK3kljSd/j9kMjl7/uRDDwzU2ShSfUUaXtN72uf53LWFMLpVY0qDHQRe7XZu0H+F7
         SbqoQhju7xWNE5hakgvm6d5VXqDy9Jl7ziRTVI9k=
Date:   Tue, 8 Oct 2019 17:38:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008153831.GA2881123@kroah.com>
References: <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <20191008045712.GR26530@ZenIV.linux.org.uk>
 <20191008131416.GA2860109@kroah.com>
 <20191008152900.GT26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008152900.GT26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:29:00PM +0100, Al Viro wrote:
> On Tue, Oct 08, 2019 at 03:14:16PM +0200, Greg KH wrote:
> > On Tue, Oct 08, 2019 at 05:57:12AM +0100, Al Viro wrote:
> > > 
> > > 	OK...  BTW, do you agree that the use of access_ok() in
> > > drivers/tty/n_hdlc.c:n_hdlc_tty_read() is wrong?  It's used as an early
> > > cutoff, so we don't bother waiting if user has passed an obviously bogus
> > > address.  copy_to_user() is used for actual copying there...
> > 
> > Yes, it's wrong, and not needed.  I'll go rip it out unless you want to?
> 
> I'll throw it into misc queue for now; it has no prereqs and nothing is going
> to depend upon it.

Great, thanks.

> While looking for more of the same pattern: usb_device_read().  Frankly,
> usb_device_dump() calling conventions look ugly - it smells like it
> would be much happier as seq_file.  Iterator would take some massage,
> but that seems to be doable.  Anyway, that's a separate story...

That's just a debugfs file, and yes, it should be moved to seq_file.  I
think I tried it a long time ago, but given it's just a debugging thing,
I gave up as it wasn't worth it.

But yes, the access_ok() there also seems odd, and should be dropped.

thanks,

greg k-h
