Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818AF565F6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiGDWdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 18:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGDWdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:33:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B085F4C
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wNv+mAHIEYTxBKTSCrBKwj6ihQdxFPr9Eq4u+a2w8RE=; b=YrYocJq8L7g0gg3DoG0rE4tBNU
        pNOqj7FrlZwBBGl4UP+IfFFeJffa3aNFYeJqZjRsNp0l3Y14J9VpP4lY85lwA76vRsOZAc6XAa1dy
        IYcFagQJQBZaaWDGa2dzj20gK4PKcq5jhTmNCN2+R+loQYgY90+pa+rpBYEqRjv5Jnu718H0AGNjZ
        yDBSTuL5BEG1Z9qeVogOsEMJNQK3o9levFbXhKztoQO7+/3uHBASmHgE/0fH48DoQj6cDWnbATk6M
        aeJQ45pwlRu0Rp402j2xcrZUscpfyPGgjokVdQ/nLL9d8fWXixCd7Zk+Ynf7Ulv+RqvxDbK7OVyPy
        LSQ11UOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Uci-0002Xr-Fq; Mon, 04 Jul 2022 22:32:56 +0000
Date:   Mon, 4 Jul 2022 23:32:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: XArray multiple marks support
Message-ID: <YsNqmIQP7LTs/vXB@casper.infradead.org>
References: <Yr3Fum4Gb9sxkrB3@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr3Fum4Gb9sxkrB3@zen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:48:10AM -0700, Boris Burkov wrote:
> I was reading the XArray documentation and noticed a comment that there
> is potential support for searching by ANDs of multiple marks, but it was
> waiting for a use case. I think I might have such a use case, but I'm
> looking for some feedback on its validity.
> 
> I'm working on some fragmentation issues in a space allocator in btrfs,
> so I'm attempting to categorize the allocation unit of this allocator
> (block group) by size class to help. I've got a branch where I migrated
> btrfs's storage of block groups from a linked list to an xarray, since
> marks felt like a really nice way for me to iterate by size class.
> 
> e.g.:
> mark = get_size_class_mark(size);
> xa_for_each_marked(block_groups, index, block_group, mark) {
>         // try to allocate in block_group
> }
> 
> Further, this allocator already operates in passes, which try harder and
> harder to find a block_group, which also fits nicely, since eventually,
> I can make the mark XA_PRESENT.
> 
> i.e.:
> while (pass < N) {
>         mark = get_size_class_mark(size);
>         if (pass > K)
>                 mark = XA_PRESENT;
>         xa_for_each_marked(block_groups, index, block_group, mark) {
>                 // try to allocate in block_group
>         }
>         if (happy)
>                 break;
>         pass++;
> }
> 
> However, I do feel a bit short on marks! Currently, I use one for "not
> in any size class" which leaves just two size classes. Even a handful
> more would give me a lot of extra flexibility. So with that said, if I
> could use ANDs in the iteration to make it essentially 7 marks, that
> would be sweet. I don't yet see a strong need for ORs, in my case.

Unfortunately, I don't think doing this will work out really well for
you.  The bits really are independent of each other, and the power of
the search marks lies in their ability to skip over vast swathes of
the array when they're not marked.  But to do what you want, we'd end up
doing something like this:

leaf array 1:
  entry 0 is in category 1
  entry 1 is in category 2
  entry 2 is in category 5

and now we have to set all three bits in the parent of leaf array 1,
so any search will have to traverse all of leaf array 1 in order to find
out whether there are any entries in the category we're looking for.

What you could do is keep one XArray per category.  I think that's what
you're proposing below.  It's a bit poor because each XArray has its
own lock, so to move a group from one size category to another, you have
to take two locks.  On the other hand, that means that you can allocate
from two different size categories at the same time, so maybe that's a
good thing?

> Does this seem like a good enough justification to support finding by
> combination of marks? If not, my alternative, for what it's worth, is
> to have an array of my block group data structure indexed by size class.
> If you do think it's a good idea, I'm happy to help with implementing
> it or testing it, if that would be valuable.
> 
> Thanks for your time,
> Boris
