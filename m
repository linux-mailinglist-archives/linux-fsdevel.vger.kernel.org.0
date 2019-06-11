Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D980D3CEA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfFKO0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:26:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfFKO0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ujK9xvqc/Khwr/vA4mMnQS5gEEU74b5dyLkwMVnQPDY=; b=QTsKv6O+qNziL76M31WriMxyG
        PFfkMgwSeSdMilX9+E4LG9LiS3v3bMfIif8HUK6xYHuzU7qhoOVBmLr9TpDte4+VEXUTkepIcTesL
        77fcy/NM7Wg4wjCAn7UOvujV4t3NgUDn5RGKkanJi+3e4MZ42BUIE35ESnUm439LZCg9/o+fVzmf0
        /j5bd1szS4WHD80KMA5Q1f0uBTbS26GyPPZYyqWjST/WDgbONwrud6FeFXqTBIpMd/GrJ6AmCvo3e
        Mtb1H7WqBhMLT/PrD8wKAHSNgf519a+4Okcf4P2t6B1DHX5GsrJtn8Oz7jdJQpAnlArlQqzBCVe8t
        q1CMWvFeg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hahjZ-0004ZB-4A; Tue, 11 Jun 2019 14:26:45 +0000
Date:   Tue, 11 Jun 2019 07:26:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker
 merged)
Message-ID: <20190611142644.GC32656@bombadil.infradead.org>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <CAHk-=wizTF+NbMrSRG-bc-LyuT7PUJ1QRAR8q_anOd6mY+9Z4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wizTF+NbMrSRG-bc-LyuT7PUJ1QRAR8q_anOd6mY+9Z4A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:55:15PM -1000, Linus Torvalds wrote:
> On Mon, Jun 10, 2019 at 3:17 PM Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
> > > Why does the regular page lock (at a finer granularity) not suffice?
> >
> > Because the lock needs to prevent pages from being _added_ to the page cache -
> > to do it with a page granularity lock it'd have to be part of the radix tree,
> 
> No, I understand that part, but I still think we should be able to do
> the locking per-page rather than over the whole mapping.
> 
> When doing dio, you need to iterate over old existing pages anyway in
> that range (otherwise the "no _new_ pages" part is kind of pointless
> when there are old pages there), so my gut feel is that you might as
> well at that point also "poison" the range you are doin dio on. With
> the xarray changes, we might be better at handling ranges. That was
> one of the arguments for the xarrays over the old radix tree model,
> after all.

We could do that -- if there are pages (or shadow entries) in the XArray,
replace them with "lock entries".  I think we'd want the behaviour of
faults / buffered IO be to wait on those entries being removed.  I think
the DAX code is just about ready to switch over to lock entries instead
of having a special DAX lock bit.

The question is what to do when there are _no_ pages in the tree for a
range that we're about to do DIO on.  This should be the normal case --
as you say, DIO users typically have their own schemes for caching in
userspace, and rather resent the other users starting to cache their
file in the kernel.

Adding lock entries in the page cache for every DIO starts to look pretty
painful in terms of allocating radix tree nodes.  And it gets worse when
you have sub-page-size DIOs -- do we embed a count in the lock entry?
Or delay DIOs which hit in the same page as an existing DIO?

And then I start to question the whole reasoning behind how we do mixed
DIO and buffered IO; if there's a page in the page cache, why are we
writing it out, then doing a direct IO instead of doing a memcpy to the
page first, then writing the page back?

IOW, move to a model where:

 - If i_dio_count is non-zero, buffered I/O waits for i_dio_count to
   drop to zero before bringing pages in.
 - If i_pages is empty, DIOs increment i_dio_count, do the IO and
   decrement i_dio_count.
 - If i_pages is not empty, DIO is implemented by doing buffered I/O
   and waiting for the pages to finish writeback.

(needs a slight tweak to ensure that new DIOs can't hold off a buffered
I/O indefinitely)
