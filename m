Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D894D1A9216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 06:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbgDOE4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 00:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393136AbgDOE4S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:56:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD0920784;
        Wed, 15 Apr 2020 04:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586926577;
        bh=7/cyAEWqRIoOXcFZNvYgjU7w3cE8iC6Fh8sNAEooM88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o7nTdRDWnBos1+imCHuZl8B8uuGul0yLnN9eMfYMaDqOlB+cl/NgjLOckV0vY0hpP
         Ucm/O1A9vtop3dW0jo3wEyrWUTI/eFT4pIPVlWkKKNR0Qa5IVvC7y0T9VVsiPyVZ+6
         YcmvoJe/CEGPjhSZX5DnQnSB/tg3reced0fueZDI=
Date:   Tue, 14 Apr 2020 21:56:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 05/25] mm: Add new readahead_control API
Message-Id: <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
In-Reply-To: <20200415021808.GA5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
        <20200414150233.24495-6-willy@infradead.org>
        <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
        <20200415021808.GA5820@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Apr 2020 19:18:08 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 14, 2020 at 06:17:05PM -0700, Andrew Morton wrote:
> > On Tue, 14 Apr 2020 08:02:13 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Filesystems which implement the upcoming ->readahead method will get
> > > their pages by calling readahead_page() or readahead_page_batch().
> > > These functions support large pages, even though none of the filesystems
> > > to be converted do yet.
> > > 
> > > +static inline struct page *readahead_page(struct readahead_control *rac)
> > > +static inline unsigned int __readahead_batch(struct readahead_control *rac,
> > > +		struct page **array, unsigned int array_sz)
> > 
> > These are large functions.  Was it correct to inline them?
> 
> Hmm.  They don't seem that big to me.

They're really big!

> readahead_page, stripped of its sanity checks:

Well, the sanity checks still count for cache footprint.

otoh, I think a function which is expected to be called from a single
site per filesystem is OK to be inlined, because there's not likely to
be much icache benefit unless different filesystem types are
simultaneously being used heavily, which sounds unlikely.  Although
there's still a bit of overall code size bloat.

> +       rac->_index += rac->_batch_count;
> +       if (!rac->_nr_pages) {
> +               rac->_batch_count = 0;
> +               return NULL;
> +       }
> +       page = xa_load(&rac->mapping->i_pages, rac->_index);
> +       rac->_batch_count = hpage_nr_pages(page);
> 
> __readahead_batch is much bigger, but it's only used by btrfs and fuse,
> and it seemed unfair to make everybody pay the cost for a function only
> used by two filesystems.

Do we expect more filesystems to use these in the future?

These function are really big!

> > The batching API only appears to be used by fuse?  If so, do we really
> > need it?  Does it provide some functional need, or is it a performance
> > thing?  If the latter, how significant is it?
> 
> I must confess to not knowing the performance impact.  If the code uses
> xa_load() repeatedly, it costs O(log n) each time as we walk down the tree
> (mitigated to a large extent by cache, of course).  Using xas_for_each()
> keeps us at the bottom of the tree and each iteration is O(1).
> I'm interested to see if filesystem maintainers start to use the batch
> function or if they're happier sticking with the individual lookups.
> 
> The batch API was originally written for use with btrfs, but it was a
> significant simplification to convert fuse to use it.

hm, OK.  It's not clear that its inclusion is justified?

> > The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
> > them at some stage?  Such as, before Linus shouts at us :)
> 
> I'd be happy to remove them.  Various reviewers said things like "are you
> sure this can't happen?"

Yeah, these things tend to live for ever.  Please add a todo to remove
them after the code has matured?

