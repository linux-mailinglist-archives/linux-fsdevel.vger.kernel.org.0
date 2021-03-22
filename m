Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E051344791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCVOlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVOlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:41:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0FC061574;
        Mon, 22 Mar 2021 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RaCtvaHwo/TZn625kVRWBgdSA5no54J7WgYPxjdoG7E=; b=SBc/ON5tkAeoJz8M87KOQ19vrw
        pnuWSCSN/BuNgJ+CWCe/pwoQtp6ETfywBh/717fidsZmO2NyhCTYf/NJv13xHd/PjtpgrNamKbVFH
        vlEZfh31D8qSobxBbpQG5m9Tiw1nuMFjPL+s+3qreV7lYaAW6refD51xr+hOOL8PPZiNkLtfOqIfw
        cCU+1LbS6gcak/jVmi4WDUUnPCn7apvJvyX/AX7xO9oT9rSq29/O9rlZt0i5XRL6cRBVBF5In3p4E
        nWiJaLsxIR7N/PXp9+jpOQtWHBdMQySi1wiYvoEfTXTUpiaMPUpF1VILs3rDuGGGtaxmWsqWxxfJ1
        2gbarSiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOLjW-008epC-Iy; Mon, 22 Mar 2021 14:40:43 +0000
Date:   Mon, 22 Mar 2021 14:40:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        hyc.lee@gmail.com, viro@zeniv.linux.org.uk, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <20210322144042.GO1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <20210322081512.GI1719932@casper.infradead.org>
 <YFhdWeedjQQgJdbi@google.com>
 <20210322135718.GA28451@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322135718.GA28451@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:57:18PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 06:03:21PM +0900, Sergey Senozhatsky wrote:
> > On (21/03/22 08:15), Matthew Wilcox wrote:
> > > 
> > > What's the scenario for which your allocator performs better than slub
> > > 
> > 
> > IIRC request and reply buffers can be up to 4M in size. So this stuff
> > just allocates a number of fat buffers and keeps them around so that
> > it doesn't have to vmalloc(4M) for every request and every response.
> 
> Do we have any data suggesting it is faster than vmalloc?

Oh, I have no trouble believing it's faster than vmalloc.  Here's
the fast(!) path that always has memory available, never does retries.
I'm calling out the things I perceive as expensive on the right hand side.
Also, I'm taking the 4MB size as the example.

vmalloc()
  __vmalloc_node()
    __vmalloc_node_range()
      __get_vm_area_node()
				[allocates vm_struct]
	alloc_vmap_area()
				[allocates vmap_area]
				[takes free_vmap_area_lock]
	  __alloc_vmap_area()
	    find_vmap_lowest_match
				[walks free_vmap_area_root]
				[takes vmap_area_lock]
      __vmalloc_area_node()
				... array_size is 8KiB, we call __vmalloc_node
	__vmalloc_node
				[everything we did above, all over again,
				 two more allocations, two more lock acquire]
	alloc_pages_node(), 1024 times
	vmap_pages_range_noflush()
	  vmap_range_noflush()
				[allocate at least two pages for PTEs]

There's definitely some low handling fruit here.  __vmalloc_area_node()
should probably call kvmalloc_node() instead of __vmalloc_node() for
table sizes > 4KiB.  But a lot of this is inherent to how vmalloc works,
and we need to put a cache in front of it.  Just not this one.
