Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ACB6C04DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjCSUr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCSUr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:47:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17347136DB;
        Sun, 19 Mar 2023 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLso9CqfYCyg061D5wJXbbp0BELJ+NatQ0Cb1mhb6E0=; b=n6sHupCPJxrkAJx1Ff2AslPhMX
        084FCS4Y17DPH/qXsaDHcvkxd9TPgzoWbdz+sHBOqVljZNwfJFHyctiBMA+L0FDyEqKXVrCMpqjTt
        SRK9Sa75H3UZEwxTGDb8e13ar8PY09qC0HTUBANpcVae2t4/BWvqwJMaTDw5LmdlJMN6kSHT7oj8m
        Hr+zkhVUlqTdUM8bKXCfdJOfCoOeTsLSZy2fwglwz2Vov/ncnV15K6mcitMUI/LANIl0Tl4VrgBEo
        LtS9oaaV0LFVUR/lB0Cpaj9c4SYFqC4bBF8dT9MQxc+Q40BfwzNHr7qLPkJEAgNunDmm5V+O+QkQH
        vwbTe0+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdzvu-000O0l-D0; Sun, 19 Mar 2023 20:47:14 +0000
Date:   Sun, 19 Mar 2023 20:47:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBd00i7fvwrMX/FY@casper.infradead.org>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <20230319131047.174fa4e29cabe4371b298ed0@linux-foundation.org>
 <fadd8558-8917-4012-b5ea-c6376c835cc8@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fadd8558-8917-4012-b5ea-c6376c835cc8@lucifer.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 08:29:16PM +0000, Lorenzo Stoakes wrote:
> The basis for saying asynchronous was based on Documentation/filesystems/vfs.rst
> describing read_iter() as 'possibly asynchronous read with iov_iter as
> destination', and read_iter() is what is (now) invoked when accessing
> /proc/kcore.
> 
> However I agree this is vague and it is clearer to refer to the fact that we are
> now directly writing to user memory and thus wish to avoid spinlocks as we may
> need to fault in user memory in doing so.
> 
> Would it be ok for you to go ahead and replace that final paragraph with the
> below?:-
> 
> The reason for making this change is to build a basis for vread() to write
> to user memory directly via an iterator; as a result we may cause page
> faults during which we must not hold a spinlock. Doing this eliminates the
> need for a bounce buffer in read_kcore() and thus permits that to be
> converted to also use an iterator, as a read_iter() handler.

I'd say the purpose of the iterator is to abstract whether we're
accessing user memory, kernel memory or a pipe, so I'd suggest:

   The reason for making this change is to build a basis for vread() to
   write to memory via an iterator; as a result we may cause page faults
   during which we must not hold a spinlock. Doing this eliminates the
   need for a bounce buffer in read_kcore() and thus permits that to be
   converted to also use an iterator, as a read_iter() handler.

I'm still undecided whether this change is really a good thing.  I
think we have line-of-sight to making vmalloc (and thus kvmalloc)
usable from interrupt context, and this destroys that possibility.

I wonder if we can't do something like prefaulting the page before
taking the spinlock, then use copy_page_to_iter_atomic()
