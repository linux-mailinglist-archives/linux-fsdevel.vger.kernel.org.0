Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE753D7967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhG0PJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhG0PJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:09:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003EC061757;
        Tue, 27 Jul 2021 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=if0rmoNdsjqdDvKzPb7qzjBTpEMMoDykIDrsQyZj1ys=; b=Akl8BbOMZbXEwcHBgls9UBFsd3
        NripSbN4KGTNJepBzfoVqabp/r+17VqxHxs4QVnMIiK8SaMkyh6rX4egoirxQ3L3T3vqqrChRDRhA
        9SO1YzC/0uG/8d0iBVhP7BqpgSnj911iF6Rz50C7ilQ24jmfZ9olgkjPLaKsH0k8uL/FmqnqBZLr6
        4E3g3lZsPuizes+tygzcg4z8fHHHzG3yGD8qt0mjFO1idkqVIWWKaf/Ny+QD6R2T88AYPnUZJLHqj
        1alVi+Z1aupvjuHK+JP9KeBTneOhBXJ/pSWTTUb+xBa8MrlNgJPZHFguXbprsaJ/SP1LiuPUxSP+J
        JNeN98AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8OgN-00F82l-FR; Tue, 27 Jul 2021 15:08:11 +0000
Date:   Tue, 27 Jul 2021 16:07:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAhQ2dYWCmnFMwM@casper.infradead.org>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
 <YQAdK0z5jFdw6cLz@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAdK0z5jFdw6cLz@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:50:19PM +0000, Al Viro wrote:
> On Tue, Jul 27, 2021 at 12:36:25PM +0200, Greg Kroah-Hartman wrote:
> > When running static analysis tools to find where signed values could
> > potentially wrap the family of d_path() functions turn out to trigger a
> > lot of mess.  In evaluating the code, all of these usages seem safe, but
> > pointer math is involved so if a negative number is ever somehow passed
> > into these functions, memory can be traversed backwards in ways not
> > intended.
> > 
> > Resolve all of the abuguity by just making "size" an unsigned value,
> > which takes the guesswork out of everything involved.
> 
> TBH, I'm not sure it's the right approach.  Huge argument passed to d_path()
> is a bad idea, no matter what.  Do you really want to have the damn thing
> try and fill 3Gb of buffer, all while holding rcu_read_lock() and a global
> spinlock or two?  Hell, s/3Gb/1Gb/ and it won't get any better...
> 
> 
> How about we do this instead:
> 
> d_path(const struct path *path, char *buf, int buflen)
> {
> 	if (unlikely((unsigned)buflen > 0x8000)) {
> 		buf += (unsigned)buflen - 0x8000;
> 		buflen = 0x8000;
> 	}
> 	as in mainline
> }
> 
> and take care of both issues?

umm ... what if someone passes in -ENOMEM as buflen?  Not saying we
have such a path right now, but I could imagine it happening.

	if (unlikely(buflen < 0))
		return ERR_PTR(buflen);
	if (unlikely(buflen > 0x8000)) {
		buf += buflen - 0x8000;
		buflen = 0x8000;
	}
	...

