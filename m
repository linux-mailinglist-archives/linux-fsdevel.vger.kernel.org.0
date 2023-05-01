Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2F6F331F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjEAPq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjEAPq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 11:46:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A53BC;
        Mon,  1 May 2023 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MUFWRQzN2U7B9NovRPIUdnOItgaF2BM1nA/v8zJpK0=; b=ZaYHCOGzMIq2mcPn5wQKmGHwqc
        dEaQSi8ys2wSEWQrqILZhJ2E3A5yM+ZBDgUmG4S1N/wj6Iqje0McnUMuERPO4Cm38WIS/MBxM3rwh
        I8qJ2kkdbPvv/cgRTjGc/qugwfraL2/bDWcH697S80ypbfipuIuTB4vHRmbpbSJ/0h1rlcZ0n6Oga
        f78qWjBf+nRjYL+b87AUjZ88xZZSzlYC+e+nEJYVSzyI3caXusPZt8MNxLpC34ZSXYjRTYEVBiqIH
        yHgXirJrykwoZHkRDNMuK1Q2zhGhTljIDoMOrmEL+wFzEVnpwKbugMpon2NXMzkmZMpdG/f7BkzP2
        DsjSuXIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptVj9-007SZI-Oz; Mon, 01 May 2023 15:46:11 +0000
Date:   Mon, 1 May 2023 16:46:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] fs: add CONFIG_BUFFER_HEAD
Message-ID: <ZE/ew1VpU/a1gqQP@casper.infradead.org>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-18-hch@lst.de>
 <ZExgzbBCbdC1y9Wk@bombadil.infradead.org>
 <ZExw0eW52lYj2R1m@casper.infradead.org>
 <ZE8ue9Mx6n2T0yn6@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE8ue9Mx6n2T0yn6@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 30, 2023 at 08:14:03PM -0700, Luis Chamberlain wrote:
> On Sat, Apr 29, 2023 at 02:20:17AM +0100, Matthew Wilcox wrote:
> > > [   11.322212] Call Trace:
> > > [   11.323224]  <TASK>
> > > [   11.324146]  iomap_readpage_iter+0x96/0x300
> > > [   11.325694]  iomap_readahead+0x174/0x2d0
> > > [   11.327129]  read_pages+0x69/0x1f0
> > > [   11.329751]  page_cache_ra_unbounded+0x187/0x1d0
> > 
> > ... that shouldn't be possible.  read_pages() allocates pages, puts them
> > in the page cache and tells the filesystem to fill them in.
> > 
> > In your patches, did you call mapping_set_large_folios() anywhere?
> 
> No but the only place to add that would be in the block cache. Adding
> that alone to the block cache doesn't fix the issue. The below patch
> however does get us by.

That's "working around the error", not fixing it ... probably the same
root cause as your other errors; at least I'm not diving into them until
the obvious one is fixed.

> >From my readings it does't seem like readahead_folio() should always
> return non-NULL, and also I couldn't easily verify the math is right.

readahead_folio() always returns non-NULL.  That's guaranteed by how
page_cache_ra_unbounded() and page_cache_ra_order() work.  It allocates
folios, until it can't (already-present folio, ENOMEM, EOF, max batch
size) and then calls the filesystem to make those folios uptodate,
telling it how many folios it put in the page cache, where they start.

Hm.  The fact that it's coming from page_cache_ra_unbounded() makes
me wonder if you updated this line:

                folio = filemap_alloc_folio(gfp_mask, 0);

without updating this line:

                ractl->_nr_pages++;

This is actually number of pages, not number of folios, so needs to be
		ractl->_nr_pages += 1 << order;

various other parts of page_cache_ra_unbounded() need to be examined
carefully for assumptions of order-0; it's never been used for that
before.  all the large folio work has concentrated on
page_cache_ra_order()
