Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027E9221BFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 07:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGPFde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 01:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPFde (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:33:34 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2782070E;
        Thu, 16 Jul 2020 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594877614;
        bh=ZeNoICWseJGDNKyU51SpHxs0uU+R8HjTKFVU8U55P8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hu2QE465llvTGLhEunjPpv09FrW/igxrnztl8vTySqUKpe+mCP1iiFHK4VC33Kl4f
         XRgK6Th83Ov21MSjfjwDyb7OfghTu/xoYuGI6m4k7Ml7Zt6jl/QzKnhMFbIDjV6N4B
         R5ZLfF7OBCVDDkBK+gKyq+B2Lq8a4ohsMydly+q0=
Date:   Wed, 15 Jul 2020 22:33:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200716053332.GH1167@sol.localdomain>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
 <20200716014656.GJ2005@dread.disaster.area>
 <20200716024717.GJ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716024717.GJ12769@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:47:17AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 11:46:56AM +1000, Dave Chinner wrote:
> > And why should we compromise performance on hundreds of millions of
> > modern systems to fix an extremely rare race on an extremely rare
> > platform that maybe only a hundred people world-wide might still
> > use?
> 
> I thought that wasn't the argument here.  It was that some future
> compiler might choose to do something absolutely awful that no current
> compiler does, and that rather than disable the stupid "optimisation",
> we'd be glad that we'd already stuffed the source code up so that it
> lay within some tortuous reading of the C spec.
> 
> The memory model is just too complicated.  Look at the recent exchange
> between myself & Dan Williams.  I spent literally _hours_ trying to
> figure out what rules to follow.
> 
> https://lore.kernel.org/linux-mm/CAPcyv4jgjoLqsV+aHGJwGXbCSwbTnWLmog5-rxD2i31vZ2rDNQ@mail.gmail.com/
> https://lore.kernel.org/linux-mm/CAPcyv4j2+7XiJ9BXQ4mj_XN0N+rCyxch5QkuZ6UsOBsOO1+2Vg@mail.gmail.com/
> 
> Neither Dan nor I are exactly "new" to Linux kernel development.  As Dave
> is saying here, having to understand the memory model is too high a bar.
> 
> Hell, I don't know if what we ended up with for v4 is actually correct.
> It lokos good to me, but *shrug*
> 
> https://lore.kernel.org/linux-mm/159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com/

Looks like you still got it wrong :-(  It needs:

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 934c92dcb9ab..9a95fbe86e15 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -1029,7 +1029,7 @@ static int devmem_init_inode(void)
        }

        /* publish /dev/mem initialized */
-       WRITE_ONCE(devmem_inode, inode);
+       smp_store_release(&devmem_inode, inode);

        return 0;
 }

It seems one source of confusion is that READ_ONCE() and WRITE_ONCE() don't
actually pair with each other, unless no memory barriers are needed at all.

Instead, READ_ONCE() pairs with a primitive that has "release" semantics, e.g.
smp_store_release() or cmpxchg_release().  But READ_ONCE() is only correct if
there's no control flow dependency; if there is, it needs to be upgraded to a
primitive with "acquire" semantics, e.g. smp_load_acquire().

The best approach might be to just say that the READ_ONCE() + "release" pairing
should be avoided, and we should stick to "acquire" + "release".  (And I think
Dave may be saying he'd prefer that for ->s_dio_done_wq?)

- Eric
