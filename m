Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E57FCFF87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfJHRG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 13:06:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60104 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJHRG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:06:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHswm-0005iH-Jz; Tue, 08 Oct 2019 17:06:53 +0000
Date:   Tue, 8 Oct 2019 18:06:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008170652.GU26530@ZenIV.linux.org.uk>
References: <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <20191008045712.GR26530@ZenIV.linux.org.uk>
 <20191008131416.GA2860109@kroah.com>
 <20191008152900.GT26530@ZenIV.linux.org.uk>
 <20191008153831.GA2881123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008153831.GA2881123@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:38:31PM +0200, Greg KH wrote:
> On Tue, Oct 08, 2019 at 04:29:00PM +0100, Al Viro wrote:
> > On Tue, Oct 08, 2019 at 03:14:16PM +0200, Greg KH wrote:
> > > On Tue, Oct 08, 2019 at 05:57:12AM +0100, Al Viro wrote:
> > > > 
> > > > 	OK...  BTW, do you agree that the use of access_ok() in
> > > > drivers/tty/n_hdlc.c:n_hdlc_tty_read() is wrong?  It's used as an early
> > > > cutoff, so we don't bother waiting if user has passed an obviously bogus
> > > > address.  copy_to_user() is used for actual copying there...
> > > 
> > > Yes, it's wrong, and not needed.  I'll go rip it out unless you want to?
> > 
> > I'll throw it into misc queue for now; it has no prereqs and nothing is going
> > to depend upon it.
> 
> Great, thanks.
> 
> > While looking for more of the same pattern: usb_device_read().  Frankly,
> > usb_device_dump() calling conventions look ugly - it smells like it
> > would be much happier as seq_file.  Iterator would take some massage,
> > but that seems to be doable.  Anyway, that's a separate story...
> 
> That's just a debugfs file, and yes, it should be moved to seq_file.  I
> think I tried it a long time ago, but given it's just a debugging thing,
> I gave up as it wasn't worth it.
> 
> But yes, the access_ok() there also seems odd, and should be dropped.

I'm almost tempted to keep it there as a reminder/grep fodder ;-)

Seriously, though, it might be useful to have a way of marking the places
in need of gentle repair of retrocranial inversions _without_ attracting
the "checkpatch warning of the week" crowd...
