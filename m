Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172EA5F0FD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiI3QZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiI3QZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:25:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920187C326;
        Fri, 30 Sep 2022 09:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97139B82961;
        Fri, 30 Sep 2022 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34001C433C1;
        Fri, 30 Sep 2022 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664555118;
        bh=HfryIVQEi40xvQXwrJl8CfAncvkl+ZvfmZlPGLHKmOU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ajy82hxgkWKU0fCRPn3LOIG+V5rH+e4Z6H3uknEhh8LJEy4lvQqxSdAIfIlRPaJrX
         Yf2Z/DegQRUs7ZvVlFfIkSCOEprURa1Hop+5qtvR8OUYsecLi+H8XzdYrFaxyXtWZI
         6dDx8mKJnzbf7RPEu7N4rHIH6ou7SIHy/V7xRAiCxuDOm9YWip6i0KXXfDLk/cL8Rh
         psuylMR2Kec/kCUMG1k76eUB/oV9B06OHKlaCfVrM1PFNNL8mincNUwD3AZC6UryBC
         DMV7+ZKSX30eew9qRXZUQxtreztqRd/7ZHOYDTp9hk9EWNyD9bCJ6gbxu5E6E3mbEI
         TRd55hCTbqpkQ==
Message-ID: <35d965bbc3d27e43d6743fc3a5cb042503a1b7bf.camel@kernel.org>
Subject: Re: [PATCH v2 08/23] ceph: Convert ceph_writepages_start() to use
 filemap_get_folios_tag()
From:   Jeff Layton <jlayton@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 30 Sep 2022 12:25:15 -0400
In-Reply-To: <20220912182224.514561-9-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
         <20220912182224.514561-9-vishal.moola@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-09-12 at 11:22 -0700, Vishal Moola (Oracle) wrote:
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>=20
> This change does NOT support large folios. This shouldn't be an issue as
> of now since ceph only utilizes folios of size 1 anyways, and there is a
> lot of work to be done on ceph conversions to folios for later patches
> at some point.
>=20
> Also some minor renaming for consistency.
>=20
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/ceph/addr.c | 138 +++++++++++++++++++++++++------------------------
>  1 file changed, 70 insertions(+), 68 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index dcf701b05cc1..33dbe55b08be 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -792,7 +792,7 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
>  	struct ceph_vino vino =3D ceph_vino(inode);
>  	pgoff_t index, start_index, end =3D -1;
>  	struct ceph_snap_context *snapc =3D NULL, *last_snapc =3D NULL, *pgsnap=
c;
> -	struct pagevec pvec;
> +	struct folio_batch fbatch;
>  	int rc =3D 0;
>  	unsigned int wsize =3D i_blocksize(inode);
>  	struct ceph_osd_request *req =3D NULL;
> @@ -821,7 +821,7 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
>  	if (fsc->mount_options->wsize < wsize)
>  		wsize =3D fsc->mount_options->wsize;
> =20
> -	pagevec_init(&pvec);
> +	folio_batch_init(&fbatch);
> =20
>  	start_index =3D wbc->range_cyclic ? mapping->writeback_index : 0;
>  	index =3D start_index;
> @@ -869,9 +869,9 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
> =20
>  	while (!done && index <=3D end) {
>  		int num_ops =3D 0, op_idx;
> -		unsigned i, pvec_pages, max_pages, locked_pages =3D 0;
> +		unsigned i, nr_folios, max_pages, locked_pages =3D 0;
>  		struct page **pages =3D NULL, **data_pages;
> -		struct page *page;
> +		struct folio *folio;
>  		pgoff_t strip_unit_end =3D 0;
>  		u64 offset =3D 0, len =3D 0;
>  		bool from_pool =3D false;
> @@ -879,28 +879,28 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  		max_pages =3D wsize >> PAGE_SHIFT;
> =20
>  get_more_pages:
> -		pvec_pages =3D pagevec_lookup_range_tag(&pvec, mapping, &index,
> -						end, PAGECACHE_TAG_DIRTY);
> -		dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
> -		if (!pvec_pages && !locked_pages)
> +		nr_folios =3D filemap_get_folios_tag(mapping, &index,
> +				end, PAGECACHE_TAG_DIRTY, &fbatch);
> +		dout("filemap_get_folios_tag got %d\n", nr_folios);
> +		if (!nr_folios && !locked_pages)
>  			break;
> -		for (i =3D 0; i < pvec_pages && locked_pages < max_pages; i++) {
> -			page =3D pvec.pages[i];
> -			dout("? %p idx %lu\n", page, page->index);
> +		for (i =3D 0; i < nr_folios && locked_pages < max_pages; i++) {
> +			folio =3D fbatch.folios[i];
> +			dout("? %p idx %lu\n", folio, folio->index);
>  			if (locked_pages =3D=3D 0)
> -				lock_page(page);  /* first page */
> -			else if (!trylock_page(page))
> +				folio_lock(folio); /* first folio */
> +			else if (!folio_trylock(folio))
>  				break;
> =20
>  			/* only dirty pages, or our accounting breaks */
> -			if (unlikely(!PageDirty(page)) ||
> -			    unlikely(page->mapping !=3D mapping)) {
> -				dout("!dirty or !mapping %p\n", page);
> -				unlock_page(page);
> +			if (unlikely(!folio_test_dirty(folio)) ||
> +			    unlikely(folio->mapping !=3D mapping)) {
> +				dout("!dirty or !mapping %p\n", folio);
> +				folio_unlock(folio);
>  				continue;
>  			}
>  			/* only if matching snap context */
> -			pgsnapc =3D page_snap_context(page);
> +			pgsnapc =3D page_snap_context(&folio->page);
>  			if (pgsnapc !=3D snapc) {
>  				dout("page snapc %p %lld !=3D oldest %p %lld\n",
>  				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
> @@ -908,11 +908,10 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  				    !ceph_wbc.head_snapc &&
>  				    wbc->sync_mode !=3D WB_SYNC_NONE)
>  					should_loop =3D true;
> -				unlock_page(page);
> +				folio_unlock(folio);
>  				continue;
>  			}
> -			if (page_offset(page) >=3D ceph_wbc.i_size) {
> -				struct folio *folio =3D page_folio(page);
> +			if (folio_pos(folio) >=3D ceph_wbc.i_size) {
> =20
>  				dout("folio at %lu beyond eof %llu\n",
>  				     folio->index, ceph_wbc.i_size);
> @@ -924,25 +923,26 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  				folio_unlock(folio);
>  				continue;
>  			}
> -			if (strip_unit_end && (page->index > strip_unit_end)) {
> -				dout("end of strip unit %p\n", page);
> -				unlock_page(page);
> +			if (strip_unit_end && (folio->index > strip_unit_end)) {
> +				dout("end of strip unit %p\n", folio);
> +				folio_unlock(folio);
>  				break;
>  			}
> -			if (PageWriteback(page) || PageFsCache(page)) {
> +			if (folio_test_writeback(folio) ||
> +					folio_test_fscache(folio)) {
>  				if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
> -					dout("%p under writeback\n", page);
> -					unlock_page(page);
> +					dout("%p under writeback\n", folio);
> +					folio_unlock(folio);
>  					continue;
>  				}
> -				dout("waiting on writeback %p\n", page);
> -				wait_on_page_writeback(page);
> -				wait_on_page_fscache(page);
> +				dout("waiting on writeback %p\n", folio);
> +				folio_wait_writeback(folio);
> +				folio_wait_fscache(folio);
>  			}
> =20
> -			if (!clear_page_dirty_for_io(page)) {
> -				dout("%p !clear_page_dirty_for_io\n", page);
> -				unlock_page(page);
> +			if (!folio_clear_dirty_for_io(folio)) {
> +				dout("%p !clear_page_dirty_for_io\n", folio);
> +				folio_unlock(folio);
>  				continue;
>  			}
> =20
> @@ -958,7 +958,7 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
>  				u32 xlen;
> =20
>  				/* prepare async write request */
> -				offset =3D (u64)page_offset(page);
> +				offset =3D (u64)folio_pos(folio);
>  				ceph_calc_file_object_mapping(&ci->i_layout,
>  							      offset, wsize,
>  							      &objnum, &objoff,
> @@ -966,7 +966,7 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
>  				len =3D xlen;
> =20
>  				num_ops =3D 1;
> -				strip_unit_end =3D page->index +
> +				strip_unit_end =3D folio->index +
>  					((len - 1) >> PAGE_SHIFT);
> =20
>  				BUG_ON(pages);
> @@ -981,54 +981,53 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  				}
> =20
>  				len =3D 0;
> -			} else if (page->index !=3D
> +			} else if (folio->index !=3D
>  				   (offset + len) >> PAGE_SHIFT) {
>  				if (num_ops >=3D (from_pool ?  CEPH_OSD_SLAB_OPS :
>  							     CEPH_OSD_MAX_OPS)) {
> -					redirty_page_for_writepage(wbc, page);
> -					unlock_page(page);
> +					folio_redirty_for_writepage(wbc, folio);
> +					folio_unlock(folio);
>  					break;
>  				}
> =20
>  				num_ops++;
> -				offset =3D (u64)page_offset(page);
> +				offset =3D (u64)folio_pos(folio);
>  				len =3D 0;
>  			}
> =20
> -			/* note position of first page in pvec */
> +			/* note position of first page in fbatch */
>  			dout("%p will write page %p idx %lu\n",
> -			     inode, page, page->index);
> +			     inode, folio, folio->index);
> =20
>  			if (atomic_long_inc_return(&fsc->writeback_count) >
>  			    CONGESTION_ON_THRESH(
>  				    fsc->mount_options->congestion_kb))
>  				fsc->write_congested =3D true;
> =20
> -			pages[locked_pages++] =3D page;
> -			pvec.pages[i] =3D NULL;
> +			pages[locked_pages++] =3D &folio->page;
> +			fbatch.folios[i] =3D NULL;
> =20
> -			len +=3D thp_size(page);
> +			len +=3D folio_size(folio);
>  		}
> =20
>  		/* did we get anything? */
>  		if (!locked_pages)
> -			goto release_pvec_pages;
> +			goto release_folio_batches;
>  		if (i) {
>  			unsigned j, n =3D 0;
> -			/* shift unused page to beginning of pvec */
> -			for (j =3D 0; j < pvec_pages; j++) {
> -				if (!pvec.pages[j])
> +			/* shift unused folio to the beginning of fbatch */
> +			for (j =3D 0; j < nr_folios; j++) {
> +				if (!fbatch.folios[j])
>  					continue;
>  				if (n < j)
> -					pvec.pages[n] =3D pvec.pages[j];
> +					fbatch.folios[n] =3D fbatch.folios[j];
>  				n++;
>  			}
> -			pvec.nr =3D n;
> -
> -			if (pvec_pages && i =3D=3D pvec_pages &&
> +			fbatch.nr =3D n;
> +			if (nr_folios && i =3D=3D nr_folios &&
>  			    locked_pages < max_pages) {
> -				dout("reached end pvec, trying for more\n");
> -				pagevec_release(&pvec);
> +				dout("reached end of fbatch, trying for more\n");
> +				folio_batch_release(&fbatch);
>  				goto get_more_pages;
>  			}
>  		}
> @@ -1056,7 +1055,7 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  			BUG_ON(IS_ERR(req));
>  		}
>  		BUG_ON(len < page_offset(pages[locked_pages - 1]) +
> -			     thp_size(page) - offset);
> +			     folio_size(folio) - offset);
> =20
>  		req->r_callback =3D writepages_finish;
>  		req->r_inode =3D inode;
> @@ -1098,7 +1097,7 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  			set_page_writeback(pages[i]);
>  			if (caching)
>  				ceph_set_page_fscache(pages[i]);
> -			len +=3D thp_size(page);
> +			len +=3D folio_size(folio);
>  		}
>  		ceph_fscache_write_to_cache(inode, offset, len, caching);
> =20
> @@ -1108,7 +1107,7 @@ static int ceph_writepages_start(struct address_spa=
ce *mapping,
>  			/* writepages_finish() clears writeback pages
>  			 * according to the data length, so make sure
>  			 * data length covers all locked pages */
> -			u64 min_len =3D len + 1 - thp_size(page);
> +			u64 min_len =3D len + 1 - folio_size(folio);
>  			len =3D get_writepages_data_length(inode, pages[i - 1],
>  							 offset);
>  			len =3D max(len, min_len);
> @@ -1164,10 +1163,10 @@ static int ceph_writepages_start(struct address_s=
pace *mapping,
>  		if (wbc->nr_to_write <=3D 0 && wbc->sync_mode =3D=3D WB_SYNC_NONE)
>  			done =3D true;
> =20
> -release_pvec_pages:
> -		dout("pagevec_release on %d pages (%p)\n", (int)pvec.nr,
> -		     pvec.nr ? pvec.pages[0] : NULL);
> -		pagevec_release(&pvec);
> +release_folio_batches:
> +		dout("folio_batch_release on %d batches (%p)", (int) fbatch.nr,
> +				fbatch.nr ? fbatch.folios[0] : NULL);
> +		folio_batch_release(&fbatch);
>  	}
> =20
>  	if (should_loop && !done) {
> @@ -1180,19 +1179,22 @@ static int ceph_writepages_start(struct address_s=
pace *mapping,
>  		if (wbc->sync_mode !=3D WB_SYNC_NONE &&
>  		    start_index =3D=3D 0 && /* all dirty pages were checked */
>  		    !ceph_wbc.head_snapc) {
> -			struct page *page;
> +			struct folio *folio;
>  			unsigned i, nr;
>  			index =3D 0;
>  			while ((index <=3D end) &&
> -			       (nr =3D pagevec_lookup_tag(&pvec, mapping, &index,
> -						PAGECACHE_TAG_WRITEBACK))) {
> +				(nr =3D filemap_get_folios_tag(mapping, &index,
> +						(pgoff_t)-1,
> +						PAGECACHE_TAG_WRITEBACK,
> +						&fbatch))) {
>  				for (i =3D 0; i < nr; i++) {
> -					page =3D pvec.pages[i];
> -					if (page_snap_context(page) !=3D snapc)
> +					folio =3D fbatch.folios[i];
> +					if (page_snap_context(&folio->page) !=3D
> +							snapc)
>  						continue;
> -					wait_on_page_writeback(page);
> +					folio_wait_writeback(folio);
>  				}
> -				pagevec_release(&pvec);
> +				folio_batch_release(&fbatch);
>  				cond_resched();
>  			}
>  		}


We have some work in progress to add write helpers to netfslib. Once we
get those in place, we plan to convert ceph to use them. At that point
ceph_writepages just goes away.

I think it'd be best to just wait for that and to just ensure that
netfslib uses filemap_get_folios_tag and the like where appropriate.
--=20
Jeff Layton <jlayton@kernel.org>
