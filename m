Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F301A61191F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJ1RVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1RVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:21:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404161BE402;
        Fri, 28 Oct 2022 10:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE879629D1;
        Fri, 28 Oct 2022 17:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8D6C433D7;
        Fri, 28 Oct 2022 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666977661;
        bh=uyJa1FWOnVe5QL+ophLah4CnDuHIHyRvZavEqx4wGzs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VAkIZkvbXAh6N0rVrNS2/2gKTqiw6CWJfN/vnT/v0od4lCqyF0FdxSMtViQBVo+YN
         KcRG899/aEVyj6k7GZ+lmntXgyE9D/SphU9cNVSr0SKp/crjPSV7c2nwszvC2fQQ78
         ReMCimKePZr4BYBR7fARCrs/A/A6/6hIdQcWumULtGFlLdVDfr9GtafAqGGRaagahA
         9xNWFRX/z8kjgJStzDo2keSKc/oqfvWRb0OQ53/4eJm4dtdVCBmspSpKDHd6MZ2Fl4
         pQhJN91cWwJ0N1BpR98RnSDMBEzGhh8KuUi5TSgNwsfjwyhkll6mRBGpekINVKt3uY
         hIDfCjcCHzMsA==
Message-ID: <95e1afd00e550ee227dd5d76a5947a2176730e1d.camel@kernel.org>
Subject: Re: [PATCH v3 08/23] ceph: Convert ceph_writepages_start() to use
 filemap_get_folios_tag()
From:   Jeff Layton <jlayton@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 28 Oct 2022 13:20:58 -0400
In-Reply-To: <20221017202451.4951-9-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
         <20221017202451.4951-9-vishal.moola@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-10-17 at 13:24 -0700, Vishal Moola (Oracle) wrote:
> Convert function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_range_tag().
>=20
> Also some minor renaming for consistency.
>=20
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/ceph/addr.c | 58 ++++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index dcf701b05cc1..d2361d51db39 100644
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
> @@ -869,7 +869,7 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
> =20
>  	while (!done && index <=3D end) {
>  		int num_ops =3D 0, op_idx;
> -		unsigned i, pvec_pages, max_pages, locked_pages =3D 0;
> +		unsigned i, nr_folios, max_pages, locked_pages =3D 0;
>  		struct page **pages =3D NULL, **data_pages;
>  		struct page *page;
>  		pgoff_t strip_unit_end =3D 0;
> @@ -879,13 +879,13 @@ static int ceph_writepages_start(struct address_spa=
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
> +		dout("pagevec_lookup_range_tag got %d\n", nr_folios);
> +		if (!nr_folios && !locked_pages)
>  			break;
> -		for (i =3D 0; i < pvec_pages && locked_pages < max_pages; i++) {
> -			page =3D pvec.pages[i];
> +		for (i =3D 0; i < nr_folios && locked_pages < max_pages; i++) {
> +			page =3D &fbatch.folios[i]->page;
>  			dout("? %p idx %lu\n", page, page->index);
>  			if (locked_pages =3D=3D 0)
>  				lock_page(page);  /* first page */
> @@ -995,7 +995,7 @@ static int ceph_writepages_start(struct address_space=
 *mapping,
>  				len =3D 0;
>  			}
> =20
> -			/* note position of first page in pvec */
> +			/* note position of first page in fbatch */
>  			dout("%p will write page %p idx %lu\n",
>  			     inode, page, page->index);
> =20
> @@ -1005,30 +1005,30 @@ static int ceph_writepages_start(struct address_s=
pace *mapping,
>  				fsc->write_congested =3D true;
> =20
>  			pages[locked_pages++] =3D page;
> -			pvec.pages[i] =3D NULL;
> +			fbatch.folios[i] =3D NULL;
> =20
>  			len +=3D thp_size(page);
>  		}
> =20
>  		/* did we get anything? */
>  		if (!locked_pages)
> -			goto release_pvec_pages;
> +			goto release_folios;
>  		if (i) {
>  			unsigned j, n =3D 0;
> -			/* shift unused page to beginning of pvec */
> -			for (j =3D 0; j < pvec_pages; j++) {
> -				if (!pvec.pages[j])
> +			/* shift unused page to beginning of fbatch */
> +			for (j =3D 0; j < nr_folios; j++) {
> +				if (!fbatch.folios[j])
>  					continue;
>  				if (n < j)
> -					pvec.pages[n] =3D pvec.pages[j];
> +					fbatch.folios[n] =3D fbatch.folios[j];
>  				n++;
>  			}
> -			pvec.nr =3D n;
> +			fbatch.nr =3D n;
> =20
> -			if (pvec_pages && i =3D=3D pvec_pages &&
> +			if (nr_folios && i =3D=3D nr_folios &&
>  			    locked_pages < max_pages) {
> -				dout("reached end pvec, trying for more\n");
> -				pagevec_release(&pvec);
> +				dout("reached end fbatch, trying for more\n");
> +				folio_batch_release(&fbatch);
>  				goto get_more_pages;
>  			}
>  		}
> @@ -1164,10 +1164,10 @@ static int ceph_writepages_start(struct address_s=
pace *mapping,
>  		if (wbc->nr_to_write <=3D 0 && wbc->sync_mode =3D=3D WB_SYNC_NONE)
>  			done =3D true;
> =20
> -release_pvec_pages:
> -		dout("pagevec_release on %d pages (%p)\n", (int)pvec.nr,
> -		     pvec.nr ? pvec.pages[0] : NULL);
> -		pagevec_release(&pvec);
> +release_folios:
> +		dout("folio_batch release on %d folios (%p)\n", (int)fbatch.nr,
> +		     fbatch.nr ? fbatch.folios[0] : NULL);
> +		folio_batch_release(&fbatch);
>  	}
> =20
>  	if (should_loop && !done) {
> @@ -1184,15 +1184,17 @@ static int ceph_writepages_start(struct address_s=
pace *mapping,
>  			unsigned i, nr;
>  			index =3D 0;
>  			while ((index <=3D end) &&
> -			       (nr =3D pagevec_lookup_tag(&pvec, mapping, &index,
> -						PAGECACHE_TAG_WRITEBACK))) {
> +			       (nr =3D filemap_get_folios_tag(mapping, &index,
> +						(pgoff_t)-1,
> +						PAGECACHE_TAG_WRITEBACK,
> +						&fbatch))) {
>  				for (i =3D 0; i < nr; i++) {
> -					page =3D pvec.pages[i];
> +					page =3D &fbatch.folios[i]->page;
>  					if (page_snap_context(page) !=3D snapc)
>  						continue;
>  					wait_on_page_writeback(page);
>  				}
> -				pagevec_release(&pvec);
> +				folio_batch_release(&fbatch);
>  				cond_resched();
>  			}
>  		}

I took a brief look and this looks like a fairly straightforward
conversion. It definitely needs testing however.

The hope was to get ceph converted over to using the netfs write
helpers, but that's taking a lot longer than expected. It's really up to
Xiubo at this point, but I don't have an issue in principle with taking
this patch in before the netfs conversion, particularly if it's blocking
other work.

Acked-by: Jeff Layton <jlayton@kernel.org>
