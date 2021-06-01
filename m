Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A033977A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhFAQNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 12:13:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:40749 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFAQNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:13:45 -0400
IronPort-SDR: 6Dkv8BuOKeY+L7xXcEHmzPTLyKWGWDZixwFkq9yD2vweJlIYLn6oQPK8dNSfT9EL/8mStwBcrJ
 oD1Tl+0XTZhQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="200564663"
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="200564663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 09:10:50 -0700
IronPort-SDR: p6iGhjR6RZGIaThSJIMsrDMkBC2yTJlyRQMHAQQu9Ss7eIs9YVt2ec8zXDcXUzwZchHJzXPSuv
 K1tCePzPVo4Q==
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="549777277"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 09:10:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lo6yX-00GTkz-TQ; Tue, 01 Jun 2021 19:10:41 +0300
Date:   Tue, 1 Jun 2021 19:10:41 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Justin He <Justin.He@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFCv2 2/3] lib/vsprintf.c: make %pD print full path for
 file
Message-ID: <YLZcAesVG1SYL5fp@smile.fi.intel.com>
References: <YLDpSnV9XBUJq5RU@casper.infradead.org>
 <AM6PR08MB437691E7314C6B774EFED4BDF7229@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YLEDwFCPcFx+qeul@casper.infradead.org>
 <AM6PR08MB437615DB6A6DEC33223A3138F7229@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YLEKqGkm8bX6LZfP@casper.infradead.org>
 <AM6PR08MB43764764B52AAC7F05B71056F73E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YLZSgZIcWyYTmqOT@casper.infradead.org>
 <CAHp75VfYgEtJeiVp8b10Va54QShyg4DmWeufuB_WGC8C2SE2mQ@mail.gmail.com>
 <YLZVwFh9MZJR3amM@casper.infradead.org>
 <YLZX9oicn8u4ZVCl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLZX9oicn8u4ZVCl@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:53:26PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 01, 2021 at 04:44:00PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 01, 2021 at 06:36:41PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 1, 2021 at 6:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > On Tue, Jun 01, 2021 at 02:42:15PM +0000, Justin He wrote:
> > > 
> > > ...
> > > 
> > > > Just don't put anything
> > > > in the buffer if the user didn't supply enough space.  As long as you
> > > > get the return value right, they know the string is bad (or they don't
> > > > care if the string is bad)
> > > 
> > > It might be that I'm out of context here, but printf() functionality
> > > in the kernel (vsprintf() if being precise)  and its users consider
> > > that it should fill buffer up to the end of whatever space is
> > > available.
> > 
> > Do they though?  What use is it to specify a small buffer, print a
> > large filename into it and then use that buffer, knowing that it wasn't
> > big enough?  That would help decide whether we should print the
> > start or the end of the filename.
> > 
> > Remember, we're going for usefulness here, not abiding by the letter of
> > the standard under all circumstances, no matter the cost.  At least
> > partially because we're far outside the standard here; POSIX does
> > not specify what %pD does.
> > 
> > "The argument shall be a pointer to void. The value of the
> > pointer is converted to a sequence of printable characters, in an
> > implementation-defined manner."
> 
> All nice words, but don't forget kasprintf() or other usages like this.
> For the same input we have to have the same result independently on the room in
> the buffer.
> 
> So, if I print "Hello, World" I should always get it, not "Monkey's Paw".
> I.o.w.
> 
>  snprintf(10) ==> "Hello, Wor"
>  snprintf(5)  ==> "Hello"
>  snprintf(2)  !=> "Mo"
>  snprintf(1)  !=> "M"
>  snprintf(1)  ==> "H"
> 
> Inconsistency here is really not what we want.

I have to add that in light of the topic those characters should be counted
from the end of the filename. So, we will give user as much as possible of useful
information. I.o.w. always print the last part of filename up to the buffer
size or if the filename is shorter than buffer we will have it in full.

-- 
With Best Regards,
Andy Shevchenko


