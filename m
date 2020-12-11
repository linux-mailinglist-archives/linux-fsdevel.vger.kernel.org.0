Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322532D814D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406453AbgLKVws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 16:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393027AbgLKVw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:52:28 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BDFC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 13:51:47 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knqKD-000eG0-F1; Fri, 11 Dec 2020 21:51:41 +0000
Date:   Fri, 11 Dec 2020 21:51:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201211215141.GA3579531@ZenIV.linux.org.uk>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
 <20201211172054.GX3579531@ZenIV.linux.org.uk>
 <2b4dbb32-14b0-fe5d-9330-2bae036cbb93@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4dbb32-14b0-fe5d-9330-2bae036cbb93@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:50:12AM -0700, Jens Axboe wrote:

> I could filter on O_TRUNC (and O_CREAT) in the caller from the io_uring
> side, and in fact we may want to do that in general for RESOLVE_LOOKUP
> as well.

You do realize that it covers O_RDWR as well, right?  If the object is on
a frozen filesystem, mnt_want_write() will block until the thing gets thawed.

> > AFAICS, without that part it is pretty much worthless.  And details
> > of what you are going to do in the missing bits *do* matter - unlike the
> > pathwalk side (which is trivial) it has potential for being very
> > messy.  I want to see _that_ before we commit to going there, and
> > a user-visible flag to openat2() makes a very strong commitment.
> 
> Fair enough. In terms of patch flow, do you want that as an addon before
> we do RESOLVE_NONBLOCK, or do you want it as part of the core
> LOOKUP_NONBLOCK patch?

I want to understand how it will be done.

> Agree, if we're going bool, we should make it the more usually followed
> success-on-false instead. And I'm happy to see you drop those
> likely/unlikely as well, not a huge fan. I'll fold this into what I had
> for that and include your naming change.

BTW, I wonder if the compiler is able to figure out that

bool f(void)
{
	if (unlikely(foo))
		return false;
	if (unlikely(bar))
		return false;
	return true;
}

is unlikely to return false.  We can force that, obviously (provide an inlined
wrapper and slap likely() there), but...
