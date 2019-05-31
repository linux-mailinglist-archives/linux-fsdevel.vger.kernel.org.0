Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8111D30D31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEaLPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 07:15:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 07:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0bzCcEeHXEwR7c+WQ7EMhHPHTFa6pRbMCfQNYRgGQ50=; b=TZRqiz+eB19FKOviEbwMF50eL
        tkVinge7hG7nufh2+jXjJimy3MX8tBcxRj3YQ//UpQYvtJgMfKOhWXOXbYLoPoseaA8GM16AkT9se
        Jngp47DXJ0z8Aw/MuS1HRC8U73Vd1LivUdfY5v/tC0ZNDKoBOdj6+6VODUmz8iT2gJDy2a+4tpMBx
        VO+5A3Gl8tI5ZU5dfFyOOeE7KYOq4wxlJF67H2SjwQSOphmha3VHx2Fo9JYu9EsuOvlTOySnke9tM
        z2Nkt7Oukx13QfyTJ/CxJdaCY4q6AKkM/OC82uZli8h02Sua/xANMZ4b54zPgJGxij2HRdkFUR5Ql
        hCLOaznLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWfUl-0002gF-9Z; Fri, 31 May 2019 11:14:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA181201D5AB1; Fri, 31 May 2019 13:14:45 +0200 (CEST)
Date:   Fri, 31 May 2019 13:14:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190531111445.GO2677@hirez.programming.kicks-ass.net>
References: <CAG48ez0R-R3Xs+3Xg9T9qcV3Xv6r4pnx1Z2y=Ltx7RGOayte_w@mail.gmail.com>
 <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
 <20190528231218.GA28384@kroah.com>
 <31936.1559146000@warthog.procyon.org.uk>
 <16193.1559163763@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16193.1559163763@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 10:02:43PM +0100, David Howells wrote:
> Jann Horn <jannh@google.com> wrote:
> 
> > Does this mean that refcount_read() isn't sufficient for what you want
> > to do with tracing (because for some reason you actually need to know
> > the values atomically at the time of increment/decrement)?
> 
> Correct.  There's a gap and if an interrupt or something occurs, it's
> sufficiently big for the refcount trace to go weird.
> 
> I've seen it in afs/rxrpc where the incoming network packets that are part of
> the rxrpc call flow disrupt the refcounts noted in trace lines.

Can you re-iterate the exact problem? I konw we talked about this in the
past, but I seem to have misplaced those memories :/

FWIW I agree that kref is useless fluff, but I've long ago given up on
that fight.
