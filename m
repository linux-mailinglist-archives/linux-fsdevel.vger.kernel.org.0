Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC133D79DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhG0PfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhG0PdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:33:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA7C061760;
        Tue, 27 Jul 2021 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bxXs+rq5U/PQ9lEAN+ryyoa73ZoX2dMvp8u+a+/NdsI=; b=WVIgg7au5uM9LynCTjkZtsmUoH
        fW5QpJBg9kTwNElsd0tCnsVdpq89yL1V3i7zjDC0vUB5J7tzrFXahDrbiWzjyJO18U8yvnhWEEZ0M
        Lb2XcRdXauz93SBcFR/rgsVCxWakuIpBF/c3WHSh7Dwc/PIknTwXhoTdMQhcJ6a0n20uTRUHcszYM
        Rx58+8B/cU0Vduwd5+GXonz+RT2kgVWZbxJk9j5WsnUztInqjZBUn4XcQpi6R5x+oNVNZfgtMfxbJ
        drn+KUTnEeZbfpgRNiQalLc1PF/8gmIYS5KDmjIC2IgZhgewZiahTuh8hNR9VFYqjJlJg4k+dqzW5
        SRR9bD/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8P3I-00F977-V6; Tue, 27 Jul 2021 15:31:50 +0000
Date:   Tue, 27 Jul 2021 16:31:28 +0100
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
Message-ID: <YQAm0DOAPxyah0+H@casper.infradead.org>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
 <YQAdK0z5jFdw6cLz@zeniv-ca.linux.org.uk>
 <YQAhQ2dYWCmnFMwM@casper.infradead.org>
 <YQAjdSPCwrnoc+YO@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAjdSPCwrnoc+YO@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 03:17:09PM +0000, Al Viro wrote:
> On Tue, Jul 27, 2021 at 04:07:47PM +0100, Matthew Wilcox wrote:
> 
> > umm ... what if someone passes in -ENOMEM as buflen?  Not saying we
> > have such a path right now, but I could imagine it happening.
> > 
> > 	if (unlikely(buflen < 0))
> > 		return ERR_PTR(buflen);
> > 	if (unlikely(buflen > 0x8000)) {
> > 		buf += buflen - 0x8000;
> > 		buflen = 0x8000;
> > 	}
> 
> Not really.  You don't want ERR_PTR() of random negative numbers to start
> flying around...

yeah.  the problem is that we're trying to infer what's actually going
on when the user has (potentially) passed us complete crap.  so do
we assume that 'buffer' is good if 'buflen' is >32KB?  plausible it
might be.  is it still plausibly good if buflen is >4MB?  i would say
'no'.

	if (unlikely((unsigned)buflen > 4096U * 1024))
		return ERR_PTR(-EINVAL);
	if (unlikely(buflen > 0x8000)) {
		buf += buflen - 0x8000;
		buflen = 0x8000;
	}
