Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CF71A90D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392915AbgDOCST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbgDOCSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:18:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A68C061A0C;
        Tue, 14 Apr 2020 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9KHPxu7QAhV1u3S2ZqCIoyxy4Ym3v0RLTChLW2Oikv4=; b=b6QEUePWGS20adBA91jd/5eoL3
        1qB1boh/lSdpZeSbJhBYeTpNJWWSCLq/Ywu3dBodJxi69s/hE26m1v0lWCZh7exlrHGttrDxBld0R
        o0U22RBR4IM2REf02o5LLzkjtrvAsrb1SUhVA+XUN1jZuoZiPyNDNgaCQZNFu+XzGieExeS3WoTq2
        HzrFZ6dcg3d7xLfboVDKIEwwlftwgdF2HBHdSLAnbd4RZD6VJwLdDQuDS9fhums2rjg8iZoJwG8r3
        xi29XIpXU8O6p96+bY4jKHquY1oQY/ApSWHiG2HS0U86jqAf8CD/BieGTpXmH+rAb1cb1EZx8mhzT
        VkdvlHpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOXcu-0000tf-4k; Wed, 15 Apr 2020 02:18:11 +0000
Date:   Tue, 14 Apr 2020 19:18:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 05/25] mm: Add new readahead_control API
Message-ID: <20200415021808.GA5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-6-willy@infradead.org>
 <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 06:17:05PM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 08:02:13 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Filesystems which implement the upcoming ->readahead method will get
> > their pages by calling readahead_page() or readahead_page_batch().
> > These functions support large pages, even though none of the filesystems
> > to be converted do yet.
> > 
> > +static inline struct page *readahead_page(struct readahead_control *rac)
> > +static inline unsigned int __readahead_batch(struct readahead_control *rac,
> > +		struct page **array, unsigned int array_sz)
> 
> These are large functions.  Was it correct to inline them?

Hmm.  They don't seem that big to me.

readahead_page, stripped of its sanity checks:

+       rac->_nr_pages -= rac->_batch_count;
+       rac->_index += rac->_batch_count;
+       if (!rac->_nr_pages) {
+               rac->_batch_count = 0;
+               return NULL;
+       }
+       page = xa_load(&rac->mapping->i_pages, rac->_index);
+       rac->_batch_count = hpage_nr_pages(page);

__readahead_batch is much bigger, but it's only used by btrfs and fuse,
and it seemed unfair to make everybody pay the cost for a function only
used by two filesystems.

> The batching API only appears to be used by fuse?  If so, do we really
> need it?  Does it provide some functional need, or is it a performance
> thing?  If the latter, how significant is it?

I must confess to not knowing the performance impact.  If the code uses
xa_load() repeatedly, it costs O(log n) each time as we walk down the tree
(mitigated to a large extent by cache, of course).  Using xas_for_each()
keeps us at the bottom of the tree and each iteration is O(1).
I'm interested to see if filesystem maintainers start to use the batch
function or if they're happier sticking with the individual lookups.

The batch API was originally written for use with btrfs, but it was a
significant simplification to convert fuse to use it.

> The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
> them at some stage?  Such as, before Linus shouts at us :)

I'd be happy to remove them.  Various reviewers said things like "are you
sure this can't happen?"

