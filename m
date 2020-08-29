Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B697C256671
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH2JZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 05:25:35 -0400
Received: from verein.lst.de ([213.95.11.211]:44199 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgH2JZe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 05:25:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 217DA68C4E; Sat, 29 Aug 2020 11:25:32 +0200 (CEST)
Date:   Sat, 29 Aug 2020 11:25:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 08/10] x86: remove address space overrides using
 set_fs()
Message-ID: <20200829092531.GC8833@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-9-hch@lst.de> <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:15:12AM -0700, Linus Torvalds wrote:
> >  SYM_FUNC_START(__put_user_2)
> > -       ENTER
> > -       mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
> > +       LOAD_TASK_SIZE_MAX
> >         sub $1,%_ASM_BX
> 
> It's even more obvious here. We load a constant and then immediately
> do a "sub $1" on that value.
> 
> It's not a huge deal, you don't have to respin the series for this, I
> just wanted to point it out so that people are aware of it and if I
> forget somebody else will hopefully remember that "we should fix that
> too".

The changes seem easy enough and I need to respin at least for the
lkdtm changes, and probaby also for a pending fix in the low-level
x86 code that will hopefully be picked up for 5.9.

But the more important questions is: how do we want to pick the series
up?  Especially due to the splice changes I really want it to be in
linux-next as long as possible.
