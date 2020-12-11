Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290352D6E34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 03:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395020AbgLKCrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 21:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389383AbgLKCqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:46:36 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E2C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 18:45:56 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knYRN-000Sz8-U8; Fri, 11 Dec 2020 02:45:53 +0000
Date:   Fri, 11 Dec 2020 02:45:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201211024553.GW3579531@ZenIV.linux.org.uk>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 02:06:39PM -0700, Jens Axboe wrote:
> On 12/10/20 1:53 PM, Linus Torvalds wrote:
> > On Thu, Dec 10, 2020 at 12:01 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> io_uring always punts opens to async context, since there's no control
> >> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
> >> just doing the fast RCU based lookups, which we know will not block. If
> >> we can do a cached path resolution of the filename, then we don't have
> >> to always punt lookups for a worker.
> > 
> > Ok, this looks much better to me just from the name change.
> > 
> > Half of the patch is admittedly just to make sure it now returns the
> > right error from unlazy_walk (rather than knowing it's always
> > -ECHILD), and that could be its own thing, but I'm not sure it's even
> > worth splitting up. The only reason to do it would be to perhaps make
> > it really clear which part is the actual change, and which is just
> > that error handling cleanup.
> > 
> > So it looks fine to me, but I will leave this all to Al.
> 
> I did consider doing a prep patch just making the error handling clearer
> and get rid of the -ECHILD assumption, since it's pretty odd and not
> even something I'd expect to see in there. Al, do you want a prep patch
> to do that to make the change simpler/cleaner?

No, I do not.  Why bother returning anything other than -ECHILD, when
you can just have path_init() treat you flag sans LOOKUP_RCU as "fail
with -EAGAIN now" and be done with that?

What's the point propagating that thing when we are going to call the
non-RCU variant next if we get -ECHILD?

And that still doesn't answer the questions about the difference between
->d_revalidate() and ->get_link() (for the latter you keep the call in
RCU mode, for the former you generate that -EAGAIN crap).  Or between
->d_revalidate() and ->permission(), for that matter.

Finally, I really wonder what is that for; if you are in conditions when
you really don't want to risk going to sleep, you do *NOT* want to
do mnt_want_write().  Or ->open().  Or truncate().  Or, for Cthulhu
sake, IMA hash calculation.

So how hard are your "we don't want to block here" requirements?  Because
the stuff you do after complete_walk() can easily be much longer than
everything else.
