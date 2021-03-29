Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1934D667
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhC2R45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhC2R4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:56:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A3C061574;
        Mon, 29 Mar 2021 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cxw+JCcYcswc0qxSo1ev5vTzWZI927ejNHC9F/PjA+w=; b=IrghJ/yHRWb00tupxZWeZEI7N2
        vdPqRo1h4g8VyWVRkTF1LoibgO5L2icT4+NW6CQJJwx+gKCT1bUKQKRWBauWDgsoIhPh/YRuX5Lrk
        hqg11JeywdyFfKkKR3dvQ0kshQ5HRgenIDKOyQHH2ZZbfA1kLcRGBS3jdkbxmfR+oZ6NKR3aZZ6ue
        2qJgvi4PrEg2u3HHVc5U6HoW8fk/ZCsnKiqC1TSze8+Lj31GWYUDZ4iV69OwdMUP2P0PHsfoGvVPv
        /QF+fBzLRmown/q19Tic/bs/Epie96f6YiQE6MAV4SrIarJCdLZ2vZGGd/jqprCL9m5ReaQpqPnrE
        KurVKA5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQw7k-001uZf-GA; Mon, 29 Mar 2021 17:56:27 +0000
Date:   Mon, 29 Mar 2021 18:56:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210329175624.GI351017@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329165832.GG351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:58:32PM +0100, Matthew Wilcox wrote:
> In broad strokes, I think that having a Power Of Two Allocator
> with Descriptor (POTAD) is a useful foundational allocator to have.
> The specific allocator that we call the buddy allocator is very clever for
> the 1990s, but touches too many cachelines to be good with today's CPUs.
> The generalisation of the buddy allocator to the POTAD lets us allocate
> smaller quantities (eg a 512 byte block) and allocate descriptors which
> differ in size from a struct page.  For an extreme example, see xfs_buf
> which is 360 bytes and is the descriptor for an allocation between 512
> and 65536 bytes.
> 
> There are times when we need to get from the physical address to
> the descriptor, eg memory-failure.c or get_user_pages().  This is the
> equivalent of phys_to_page(), and it's going to have to be a lookup tree.
> I think this is a role for the Maple Tree, but it's not ready yet.
> I don't know if it'll be fast enough for this case.  There's also the
> need (particularly for memory-failure) to determine exactly what kind
> of descriptor we're dealing with, and also its size.  Even its owner,
> so we can notify them of memory failure.

A couple of things I forgot to mention ...

I'd like the POTAD to be not necessarily tied to allocating memory.
For example, I think it could be used to allocate swap space.  eg the swap
code could register the space in a swap file as allocatable through the
POTAD, and then later ask the POTAD to allocate a POT from the swap space.

The POTAD wouldn't need to be limited to MAX_ORDER.  It should be
perfectly capable of allocating 1TB if your machine has 1.5TB of RAM
in it (... and things haven't got too fragmented)

I think the POTAD can be used to replace the CMA.  The CMA supports
weirdo things like "Allocate 8MB of memory at a 1MB alignment", and I
think that's doable within the data structures that I'm thinking about
for the POTAD.  It'd first try to allocate an 8MB chunk at 8MB alignment,
and then if that's not possible, try to allocate two adjacent 4MB chunks;
continuing down until it finds that there aren't 8x1MB chunks, at which
point it can give up.
