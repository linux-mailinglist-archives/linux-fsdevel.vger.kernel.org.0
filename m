Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8893F3CC4F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhGQRnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhGQRnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 13:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2484C061762
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jul 2021 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DcoB5AK+oNf7jtGcvYpmjtox9/yKj0Ghaxmo8XeiH4Y=; b=OJ1rg0Y44Tb0p/GihnVaJ0OVkn
        mCUZ80J3EEZtlQ1xQetEvzO4QEtf6FDIqHHOOCZcCje6/jKMtCol1vYqdqJaZe6fN//vXjq7tfkwp
        0UGtXOFhT9Z91Am1UWzrefxqHbBPKRlNE4+Ik55+U75CAwUnuiTAcelH9zngkspnHO1fVq4S2DKEy
        /SY3bdEweoM2/jwuIpGReH9FOMbx5Ieowd4LCKE2n1Ak0qt9JuGqbjDK3S4wMj0et/q/gQppyO10O
        Y92IDzx/nA+5Oej4ty3cogPnuvvn4gLHfQXkWuHs/1A9rm10UoMtr1m/NQokT6DXDb9n9WmL2ulby
        QBbcKJ2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4oIP-005RiN-1t; Sat, 17 Jul 2021 17:40:22 +0000
Date:   Sat, 17 Jul 2021 18:40:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <YPMV/Vo8lX7dzeP1@casper.infradead.org>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
 <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
 <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
 <20210717171713.GB22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717171713.GB22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 10:17:13AM -0700, Darrick J. Wong wrote:
> I experience the same problem that Murphy does, and I tracked it down
> to this chunk of inode_do_switch_wbs:
> 
> 	/*
> 	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
> 	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
> 	 * pages actually under writeback.
> 	 */
> 	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> here >>>>>>>>>> if (PageDirty(page)) {
> 			dec_wb_stat(old_wb, WB_RECLAIMABLE);
> 			inc_wb_stat(new_wb, WB_RECLAIMABLE);
> 		}
> 	}
> 
> I suspect that "page" is really a pfn to a pmem mapping and not a real
> struct page.

I think you're right.

Running scripts/decodecode on the original report, that's:

   0:	48 8b 50 08          	mov    0x8(%rax),%rdx

RAX: 0000000005b0f661

so rax is not a struct page, it's a PFN (/DAX) entry.

We shouldn't even be calling inode_do_switch_wbs() for DAX inodes because
we don't do writeback for DAX inodes (at least as far as the kernel's
writeback infrastructure is concerned; obviously the CPU does writeback
from its caches to PMEM).

Maybe some check at a higher level would be appropriate?  I don't know
much about this part of the kernel.
