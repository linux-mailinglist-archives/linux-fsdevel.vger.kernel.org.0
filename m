Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8B3F8CD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbhHZRVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhHZRVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:21:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E0C061757;
        Thu, 26 Aug 2021 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=850eODxTDWhlzYrQXf9CJDPvv6/dK0ZOGDmXnwCIfCw=; b=WitDMPFARIeZb/2HdADSmvN0nL
        i6qhaTu0DvVO04CFVVI77gsq453qxaOtmXZhmYH+cFfiNcwvf64mt5ng3/3dV5qEzqW4fCVa7Av8V
        1yyz/UGTkRVk6OPTZgVasbPNmti+H2rSARy60noi5EDQMJui3yT8MDwGZLPDYsZi7jfiN0AQv6w1G
        2WabPLTtzY9RsT6M1j1xzBfEGwLeBPykQUmKlpvC5S2Drtuweoe58tFVpEkqik5m1Z1MxXzM53p2c
        CaOuvCZf+mxz3sTekftji0jLtGy/1ZEypJa23c5iZKpsLN1/v8pASBQvwxqOXC7syIhvRttbLuM5m
        nP8VZoLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJJ1l-00DVgd-Gv; Thu, 26 Aug 2021 17:19:04 +0000
Date:   Thu, 26 Aug 2021 18:18:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSfNATLcGI4haI89@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
 <1966106.1629832273@warthog.procyon.org.uk>
 <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
 <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
 <CAHk-=wgwRW1_o6iBOxtSE+vm7uiSr98wkTLbCze9-7wW0ZhOLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwRW1_o6iBOxtSE+vm7uiSr98wkTLbCze9-7wW0ZhOLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:48:13PM -0700, Linus Torvalds wrote:
> On Tue, Aug 24, 2021 at 12:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > "pageset" is such a great name that we already use it, so I guess that
> > doesn't work.
> 
> Actually, maybe I can backtrack on that a bit.
> 
> Maybe 'pageset' would work as a name. It's not used as a type right
> now, but the usage where we do have those comments around 'struct
> per_cpu_pages' are actually not that different from the folio kind of
> thing. It has a list of "pages" that have a fixed order.
> 
> So that existing 'pageset' user might actually fit in conceptually.
> The 'pageset' is only really used in comments and as part of a field
> name, and the use does seem to be kind of consistent with the Willy's
> use of a "aligned allocation-group of pages".

The 'pageset' in use in mm/page_alloc.c really seems to be more of a
pagelist than a pageset.  The one concern I have about renaming it is
that we actually print the word 'pagesets' in /proc/zoneinfo.

There's also some infiniband driver that uses the word "pageset"
which really seems to mean "DMA range".

So if I rename the existing mm pageset to pagelist, and then modify all
these patches to call a folio a pageset, you'd take this patchset?
