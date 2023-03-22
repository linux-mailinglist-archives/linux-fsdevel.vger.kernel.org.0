Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF636C52F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCVRrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCVRrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:47:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C15FEB8;
        Wed, 22 Mar 2023 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5U7snE0+aYLeGUT8P2wlcKvFPCtGDHM/aotSxqaNJaY=; b=kRa6Gmr61/CqeuJfus2d86d5LH
        8I7TRNzJAuYyRJK3566ZY/aV8ud0L7Ni7asXjiIcUh5tzJpC3b6SSQIz7ePhJkK1+P0qqt2Zt8CT7
        JMZDTsQaGvD9+rfE12U0lzjc6njS/SFjWftGekcZJVZV6CSNmXJTveemmLLB8VX5QptyEJOZ/Z3EV
        xSb7MtWcVltTHKnReTp5Fxcm31HwcO3vd07oB4lN455EauTZ8xm6cEdSTz3jDXf894+/8TCCXkR51
        vyTO3PFdAmHkPwon04jRo8QFkrQJ+WqbPAL4O5vt2LG1crSZBeiksKLWFm8rYua1AKscPYo/RIhPj
        /yRJCxaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pf2Ya-003DFb-CA; Wed, 22 Mar 2023 17:47:28 +0000
Date:   Wed, 22 Mar 2023 17:47:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBs/MGH+xUAZXNTz@casper.infradead.org>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsAG5cpOFhFZZG6@pc636>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:18:19PM +0100, Uladzislau Rezki wrote:
> Hello, Dave.
> 
> > 
> > I'm travelling right now, but give me a few days and I'll test this
> > against the XFS workloads that hammer the global vmalloc spin lock
> > really, really badly. XFS can use vm_map_ram and vmalloc really
> > heavily for metadata buffers and hit the global spin lock from every
> > CPU in the system at the same time (i.e. highly concurrent
> > workloads). vmalloc is also heavily used in the hottest path
> > throught the journal where we process and calculate delta changes to
> > several million items every second, again spread across every CPU in
> > the system at the same time.
> > 
> > We really need the global spinlock to go away completely, but in the
> > mean time a shared read lock should help a little bit....
> > 
> Could you please share some steps how to run your workloads in order to
> touch vmalloc() code. I would like to have a look at it in more detail
> just for understanding the workloads.
> 
> Meanwhile my grep agains xfs shows:
> 
> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$ grep -rn vmalloc ./

You're missing:

fs/xfs/xfs_buf.c:                       bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,

which i suspect is the majority of Dave's workload.  That will almost
certainly take the vb_alloc() path.
