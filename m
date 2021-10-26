Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA443B257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhJZMZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 08:25:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33594 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhJZMZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:25:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9AB3A212C0;
        Tue, 26 Oct 2021 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635251013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ag1WYrKgf7O+uS5MAQ9kuHiEe3JugxwL2psMaHfGAI=;
        b=OdzS67F9XXi9aZf2JlXLYFAKkcabf3eI66g2bLe8q2i+iNazdT6GLx70IWRRWBQ4PW7WVQ
        jg/5ExTWnbTwpFuDVSWrny8wTfh2tn248Rg38UqjbDni+mvgQIH+6Qdu5plUWX7VzJGzsZ
        JPM7kNiwXyBXgJ+MvccUgGTIWok8rzg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 69994A3B81;
        Tue, 26 Oct 2021 12:23:33 +0000 (UTC)
Date:   Tue, 26 Oct 2021 14:23:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 4/4] mm: allow !GFP_KERNEL allocations for kvmalloc
Message-ID: <YXfzRNIwE2q/hKgO@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-5-mhocko@kernel.org>
 <163520487423.16092.18303917539436351482@noble.neil.brown.name>
 <YXerCVllHB9g+JnI@dhcp22.suse.cz>
 <163524528594.8576.8070122002785265336@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163524528594.8576.8070122002785265336@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 21:48:05, Neil Brown wrote:
> On Tue, 26 Oct 2021, Michal Hocko wrote:
[...]
> > > GFP_NOWAIT is not a modifier.  It is a base value that can be modified.
> > > I think you mean that
> > >     __GFP_NORETRY is not supported and __GFP_DIRECT_RECLAIM is required
> > 
> > I thought naming the higher level gfp mask would be more helpful here.
> > Most people do not tend to think in terms of __GFP_DIRECT_RECLAIM but
> > rather GFP_NOWAIT or GFP_ATOMIC.
> 
> Maybe it would.  But the text says "Reclaim modifiers" and then lists
> one modifier and one mask.  That is confusing.
> If you want to mention both, keep them separate.
> 
>   GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the
>   __GFP_NORETRY modifier.
> 
> or something like that.

Fair enough. I went with this
commit fb93996c217cea864a3b3ffa8a8cd482bf0a1f62
Author: Michal Hocko <mhocko@suse.com>
Date:   Tue Oct 26 14:23:00 2021 +0200

    fold me "mm: allow !GFP_KERNEL allocations for kvmalloc"

diff --git a/mm/util.c b/mm/util.c
index fdec6b4b1267..1fb6dd907bb0 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -549,7 +549,7 @@ EXPORT_SYMBOL(vm_mmap);
  * Uses kmalloc to get the memory but if the allocation fails then falls back
  * to the vmalloc allocator. Use kvfree for freeing the memory.
  *
- * Reclaim modifiers - __GFP_NORETRY and GFP_NOWAIT are not supported.
+ * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
  * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
  * preferable to the vmalloc fallback, due to visible performance drawbacks.
  *
-- 
Michal Hocko
SUSE Labs
