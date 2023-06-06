Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C94724B14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjFFSTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbjFFSTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:19:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D21702;
        Tue,  6 Jun 2023 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SzEzfD8o9MmMZbtTJMh/O3FVpegfomMJ8VE5KDe97bU=; b=CEhhzhsm3xgw7fNAWhMuqkGg1T
        w5cHgMaODp27e+j24Yg/Kef06hUoOHuswZ8as3MqXUTn0CHbZsTzEhlxDsT2SeacGu585XeVxNdeh
        7rrPrNvkf7tlJdum2sWdk2OME6Vg2JtA8xeh08i40GFZJUYjls+19V7hrZ/onGmCYHar4swC8aqv4
        Lrdf71hRtEBCkwQa1FpAIyKKnKpHWhNaRgPGaWMxXuBQy+qfqYJQXRw1iZwvSuqBsRST0ZHzoFK0L
        MffVAUK6PGOrHA8rgpmwGc1jrjTKIsD+xzB6wWKqXWfeSXWsVtFvES4CWTJ0GVz+nVwjWfrtCqZXg
        eHMqIAvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6bGy-00DP19-Az; Tue, 06 Jun 2023 18:19:12 +0000
Date:   Tue, 6 Jun 2023 19:19:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ceph: Convert ceph_writepages_start() to use folios a
 little more
Message-ID: <ZH94oBBFct9b9g3z@casper.infradead.org>
References: <20230605165418.2909336-1-willy@infradead.org>
 <4ca56a21-c5aa-6407-0cc1-db68762630ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca56a21-c5aa-6407-0cc1-db68762630ce@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:37:46PM +0800, Xiubo Li wrote:
> This Looks good to me.
> 
> BTW, could you rebase this to the 'testing' branch ? This will introduce a

Umm, which testing branch is that?  It applies cleanly to next-20230606
which is generally where I work, since it's a bit unreasonable for me
to keep track of every filesystem development tree.

> lots of conflicts with the fscrypt patches, I'd prefer this could be applied
> and merged after them since the fscrypt patches have been well tested.
> 
> Ilya, is that okay ?
> 
> Thanks
> 
> - Xiubo
> 
> On 6/6/23 00:54, Matthew Wilcox (Oracle) wrote:
> > After we iterate through the locked folios using filemap_get_folios_tag(),
> > we currently convert back to a page (and then in some circumstaces back
> > to a folio again!).  Just use a folio throughout and avoid various hidden
> > calls to compound_head().  Ceph still uses a page array to interact with
> > the OSD which should be cleaned up in a subsequent patch.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   fs/ceph/addr.c | 79 +++++++++++++++++++++++++-------------------------
> >   1 file changed, 39 insertions(+), 40 deletions(-)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 6bb251a4d613..e2d92a8a53ca 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -888,7 +888,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   		int num_ops = 0, op_idx;
> >   		unsigned i, nr_folios, max_pages, locked_pages = 0;
> >   		struct page **pages = NULL, **data_pages;
> > -		struct page *page;
> > +		struct folio *folio;
> >   		pgoff_t strip_unit_end = 0;
> >   		u64 offset = 0, len = 0;
> >   		bool from_pool = false;
> > @@ -902,22 +902,22 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   		if (!nr_folios && !locked_pages)
> >   			break;
> >   		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
> > -			page = &fbatch.folios[i]->page;
> > -			dout("? %p idx %lu\n", page, page->index);
> > +			folio = fbatch.folios[i];
> > +			dout("? %p idx %lu\n", folio, folio->index);
> >   			if (locked_pages == 0)
> > -				lock_page(page);  /* first page */
> > -			else if (!trylock_page(page))
> > +				folio_lock(folio);  /* first folio */
> > +			else if (!folio_trylock(folio))
> >   				break;
> >   			/* only dirty pages, or our accounting breaks */
> > -			if (unlikely(!PageDirty(page)) ||
> > -			    unlikely(page->mapping != mapping)) {
> > -				dout("!dirty or !mapping %p\n", page);
> > -				unlock_page(page);
> > +			if (unlikely(!folio_test_dirty(folio)) ||
> > +			    unlikely(folio->mapping != mapping)) {
> > +				dout("!dirty or !mapping %p\n", folio);
> > +				folio_unlock(folio);
> >   				continue;
> >   			}
> >   			/* only if matching snap context */
> > -			pgsnapc = page_snap_context(page);
> > +			pgsnapc = page_snap_context(&folio->page);
> >   			if (pgsnapc != snapc) {
> >   				dout("page snapc %p %lld != oldest %p %lld\n",
> >   				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
> > @@ -925,12 +925,10 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   				    !ceph_wbc.head_snapc &&
> >   				    wbc->sync_mode != WB_SYNC_NONE)
> >   					should_loop = true;
> > -				unlock_page(page);
> > +				folio_unlock(folio);
> >   				continue;
> >   			}
> > -			if (page_offset(page) >= ceph_wbc.i_size) {
> > -				struct folio *folio = page_folio(page);
> > -
> > +			if (folio_pos(folio) >= ceph_wbc.i_size) {
> >   				dout("folio at %lu beyond eof %llu\n",
> >   				     folio->index, ceph_wbc.i_size);
> >   				if ((ceph_wbc.size_stable ||
> > @@ -941,31 +939,32 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   				folio_unlock(folio);
> >   				continue;
> >   			}
> > -			if (strip_unit_end && (page->index > strip_unit_end)) {
> > -				dout("end of strip unit %p\n", page);
> > -				unlock_page(page);
> > +			if (strip_unit_end && (folio->index > strip_unit_end)) {
> > +				dout("end of strip unit %p\n", folio);
> > +				folio_unlock(folio);
> >   				break;
> >   			}
> > -			if (PageWriteback(page) || PageFsCache(page)) {
> > +			if (folio_test_writeback(folio) ||
> > +			    folio_test_fscache(folio)) {
> >   				if (wbc->sync_mode == WB_SYNC_NONE) {
> > -					dout("%p under writeback\n", page);
> > -					unlock_page(page);
> > +					dout("%p under writeback\n", folio);
> > +					folio_unlock(folio);
> >   					continue;
> >   				}
> > -				dout("waiting on writeback %p\n", page);
> > -				wait_on_page_writeback(page);
> > -				wait_on_page_fscache(page);
> > +				dout("waiting on writeback %p\n", folio);
> > +				folio_wait_writeback(folio);
> > +				folio_wait_fscache(folio);
> >   			}
> > -			if (!clear_page_dirty_for_io(page)) {
> > -				dout("%p !clear_page_dirty_for_io\n", page);
> > -				unlock_page(page);
> > +			if (!folio_clear_dirty_for_io(folio)) {
> > +				dout("%p !folio_clear_dirty_for_io\n", folio);
> > +				folio_unlock(folio);
> >   				continue;
> >   			}
> >   			/*
> >   			 * We have something to write.  If this is
> > -			 * the first locked page this time through,
> > +			 * the first locked folio this time through,
> >   			 * calculate max possinle write size and
> >   			 * allocate a page array
> >   			 */
> > @@ -975,7 +974,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   				u32 xlen;
> >   				/* prepare async write request */
> > -				offset = (u64)page_offset(page);
> > +				offset = folio_pos(folio);
> >   				ceph_calc_file_object_mapping(&ci->i_layout,
> >   							      offset, wsize,
> >   							      &objnum, &objoff,
> > @@ -983,7 +982,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   				len = xlen;
> >   				num_ops = 1;
> > -				strip_unit_end = page->index +
> > +				strip_unit_end = folio->index +
> >   					((len - 1) >> PAGE_SHIFT);
> >   				BUG_ON(pages);
> > @@ -998,33 +997,33 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   				}
> >   				len = 0;
> > -			} else if (page->index !=
> > +			} else if (folio->index !=
> >   				   (offset + len) >> PAGE_SHIFT) {
> >   				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
> >   							     CEPH_OSD_MAX_OPS)) {
> > -					redirty_page_for_writepage(wbc, page);
> > -					unlock_page(page);
> > +					folio_redirty_for_writepage(wbc, folio);
> > +					folio_unlock(folio);
> >   					break;
> >   				}
> >   				num_ops++;
> > -				offset = (u64)page_offset(page);
> > +				offset = (u64)folio_pos(folio);
> >   				len = 0;
> >   			}
> >   			/* note position of first page in fbatch */
> > -			dout("%p will write page %p idx %lu\n",
> > -			     inode, page, page->index);
> > +			dout("%p will write folio %p idx %lu\n",
> > +			     inode, folio, folio->index);
> >   			if (atomic_long_inc_return(&fsc->writeback_count) >
> >   			    CONGESTION_ON_THRESH(
> >   				    fsc->mount_options->congestion_kb))
> >   				fsc->write_congested = true;
> > -			pages[locked_pages++] = page;
> > +			pages[locked_pages++] = &folio->page;
> >   			fbatch.folios[i] = NULL;
> > -			len += thp_size(page);
> > +			len += folio_size(folio);
> >   		}
> >   		/* did we get anything? */
> > @@ -1073,7 +1072,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   			BUG_ON(IS_ERR(req));
> >   		}
> >   		BUG_ON(len < page_offset(pages[locked_pages - 1]) +
> > -			     thp_size(page) - offset);
> > +			     folio_size(folio) - offset);
> >   		req->r_callback = writepages_finish;
> >   		req->r_inode = inode;
> > @@ -1115,7 +1114,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   			set_page_writeback(pages[i]);
> >   			if (caching)
> >   				ceph_set_page_fscache(pages[i]);
> > -			len += thp_size(page);
> > +			len += folio_size(folio);
> >   		}
> >   		ceph_fscache_write_to_cache(inode, offset, len, caching);
> > @@ -1125,7 +1124,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   			/* writepages_finish() clears writeback pages
> >   			 * according to the data length, so make sure
> >   			 * data length covers all locked pages */
> > -			u64 min_len = len + 1 - thp_size(page);
> > +			u64 min_len = len + 1 - folio_size(folio);
> >   			len = get_writepages_data_length(inode, pages[i - 1],
> >   							 offset);
> >   			len = max(len, min_len);
> 
