Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E678A3DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjH1BT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjH1BTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B1106
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693185525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lo/qwGlASNgjwZN1ZcYZMm77/Y/UVTy6Lh/rIRtGSfM=;
        b=gpQ23In7WocmdnMhFbs1mqZQ7vMMkU8H+o/prt5WvmAcL28ZN8tBzaiN9EBRSWWZ1+IQEb
        Ljug0HTRiXBEpSrQ3EFNYHH0jiiz49Hi3RENuE2k/hZgH54Vll5RYRhdnD3TBuVjJVJZ7Y
        zZPOdWRUZ4ZyQzMP4+s65g5XURbap9Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-v7YDMlOVMa6AjjjrOVD2mA-1; Sun, 27 Aug 2023 21:18:43 -0400
X-MC-Unique: v7YDMlOVMa6AjjjrOVD2mA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bf6e47b5efso23631035ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 18:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693185523; x=1693790323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo/qwGlASNgjwZN1ZcYZMm77/Y/UVTy6Lh/rIRtGSfM=;
        b=aM4bfZDsMLsRmZc2nP+FDfs8vljoKuam5CBOMUzsLqIzuIs9PFxGSgT5uI1UAJms3y
         HB26C/z90HPX1Cv7YNE763DN6lOi4qgC/x6dXQL/sFMnL5EamBtPZFo9oVtxLdTaeve9
         3XMfKo9XVE28C9Hz4V4a+6/xJedNE8AR31ytnh/Dl34jHWykiSkZXyCu9x+q9/M4cQzc
         66fKoXWiaSYO9SMFgyEGUWnXL8JoEUpxuz3f/WfCgcInDECaR5Wgj2jjHMWzf97oQ/G1
         c/1dC7R91P986Dr4Nq1Rk5ziFPKGKZjizelb3sKndFhntdohcDytP/RuZgjzoqSysnx3
         dUbg==
X-Gm-Message-State: AOJu0YzQ06wcLQyhWqmZhU0xbhsP5kFWZj+Vj88xAW8vAh6kvGGZPbJt
        wcME0TLAhRzq9IMfad2IXiZLaGblIO/cOWyl+7Hpb7T95SFWosCd0c7ZrxLNq4o9adeM1Pw4FXO
        jSvp/PomsoHuSJmXtBZTelAHjHA==
X-Received: by 2002:a17:903:2441:b0:1c0:9d5a:9b06 with SMTP id l1-20020a170903244100b001c09d5a9b06mr14030549pls.63.1693185522887;
        Sun, 27 Aug 2023 18:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiD/bp7yU3A1gMsmBvXdDIRGeuFZg+R8TD/tQZEeA4+sLck7OanAwxl79Ewk3OMsukqoJUhQ==
X-Received: by 2002:a17:903:2441:b0:1c0:9d5a:9b06 with SMTP id l1-20020a170903244100b001c09d5a9b06mr14030539pls.63.1693185522480;
        Sun, 27 Aug 2023 18:18:42 -0700 (PDT)
Received: from [10.72.112.71] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902900a00b001b850c9d7b3sm5880394plp.249.2023.08.27.18.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 18:18:41 -0700 (PDT)
Message-ID: <467fef8f-8383-1385-dedc-b97ea7c56e47@redhat.com>
Date:   Mon, 28 Aug 2023 09:18:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/15] ceph: Convert ceph_writepages_start() to use folios
 a little more
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20230825201225.348148-1-willy@infradead.org>
 <20230825201225.348148-2-willy@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230825201225.348148-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/26/23 04:12, Matthew Wilcox (Oracle) wrote:
> After we iterate through the locked folios using filemap_get_folios_tag(),
> we currently convert back to a page (and then in some circumstaces back
> to a folio again!).  Just use a folio throughout and avoid various hidden
> calls to compound_head().  Ceph still uses a page array to interact with
> the OSD which should be cleaned up in a subsequent patch.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/ceph/addr.c | 100 ++++++++++++++++++++++++-------------------------
>   1 file changed, 49 insertions(+), 51 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index f4863078f7fe..9a0a79833eb0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1018,7 +1018,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   		int num_ops = 0, op_idx;
>   		unsigned i, nr_folios, max_pages, locked_pages = 0;
>   		struct page **pages = NULL, **data_pages;
> -		struct page *page;
> +		struct folio *folio;
>   		pgoff_t strip_unit_end = 0;
>   		u64 offset = 0, len = 0;
>   		bool from_pool = false;
> @@ -1032,22 +1032,22 @@ static int ceph_writepages_start(struct address_space *mapping,
>   		if (!nr_folios && !locked_pages)
>   			break;
>   		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
> -			page = &fbatch.folios[i]->page;
> -			dout("? %p idx %lu\n", page, page->index);
> +			folio = fbatch.folios[i];
> +			dout("? %p idx %lu\n", folio, folio->index);
>   			if (locked_pages == 0)
> -				lock_page(page);  /* first page */
> -			else if (!trylock_page(page))
> +				folio_lock(folio);  /* first folio */
> +			else if (!folio_trylock(folio))
>   				break;
>   
>   			/* only dirty pages, or our accounting breaks */
> -			if (unlikely(!PageDirty(page)) ||
> -			    unlikely(page->mapping != mapping)) {
> -				dout("!dirty or !mapping %p\n", page);
> -				unlock_page(page);
> +			if (unlikely(!folio_test_dirty(folio)) ||
> +			    unlikely(folio->mapping != mapping)) {
> +				dout("!dirty or !mapping %p\n", folio);
> +				folio_unlock(folio);
>   				continue;
>   			}
>   			/* only if matching snap context */
> -			pgsnapc = page_snap_context(page);
> +			pgsnapc = folio->private;
>   			if (pgsnapc != snapc) {
>   				dout("page snapc %p %lld != oldest %p %lld\n",
>   				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
> @@ -1055,12 +1055,10 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				    !ceph_wbc.head_snapc &&
>   				    wbc->sync_mode != WB_SYNC_NONE)
>   					should_loop = true;
> -				unlock_page(page);
> +				folio_unlock(folio);
>   				continue;
>   			}
> -			if (page_offset(page) >= ceph_wbc.i_size) {
> -				struct folio *folio = page_folio(page);
> -
> +			if (folio_pos(folio) >= ceph_wbc.i_size) {
>   				dout("folio at %lu beyond eof %llu\n",
>   				     folio->index, ceph_wbc.i_size);
>   				if ((ceph_wbc.size_stable ||
> @@ -1071,31 +1069,32 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				folio_unlock(folio);
>   				continue;
>   			}
> -			if (strip_unit_end && (page->index > strip_unit_end)) {
> -				dout("end of strip unit %p\n", page);
> -				unlock_page(page);
> +			if (strip_unit_end && (folio->index > strip_unit_end)) {
> +				dout("end of strip unit %p\n", folio);
> +				folio_unlock(folio);
>   				break;
>   			}
> -			if (PageWriteback(page) || PageFsCache(page)) {
> +			if (folio_test_writeback(folio) ||
> +			    folio_test_fscache(folio)) {
>   				if (wbc->sync_mode == WB_SYNC_NONE) {
> -					dout("%p under writeback\n", page);
> -					unlock_page(page);
> +					dout("%p under writeback\n", folio);
> +					folio_unlock(folio);
>   					continue;
>   				}
> -				dout("waiting on writeback %p\n", page);
> -				wait_on_page_writeback(page);
> -				wait_on_page_fscache(page);
> +				dout("waiting on writeback %p\n", folio);
> +				folio_wait_writeback(folio);
> +				folio_wait_fscache(folio);
>   			}
>   
> -			if (!clear_page_dirty_for_io(page)) {
> -				dout("%p !clear_page_dirty_for_io\n", page);
> -				unlock_page(page);
> +			if (!folio_clear_dirty_for_io(folio)) {
> +				dout("%p !folio_clear_dirty_for_io\n", folio);
> +				folio_unlock(folio);
>   				continue;
>   			}
>   
>   			/*
>   			 * We have something to write.  If this is
> -			 * the first locked page this time through,
> +			 * the first locked folio this time through,
>   			 * calculate max possinle write size and
>   			 * allocate a page array
>   			 */
> @@ -1105,7 +1104,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				u32 xlen;
>   
>   				/* prepare async write request */
> -				offset = (u64)page_offset(page);
> +				offset = folio_pos(folio);
>   				ceph_calc_file_object_mapping(&ci->i_layout,
>   							      offset, wsize,
>   							      &objnum, &objoff,
> @@ -1113,7 +1112,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				len = xlen;
>   
>   				num_ops = 1;
> -				strip_unit_end = page->index +
> +				strip_unit_end = folio->index +
>   					((len - 1) >> PAGE_SHIFT);
>   
>   				BUG_ON(pages);
> @@ -1128,23 +1127,23 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				}
>   
>   				len = 0;
> -			} else if (page->index !=
> +			} else if (folio->index !=
>   				   (offset + len) >> PAGE_SHIFT) {
>   				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
>   							     CEPH_OSD_MAX_OPS)) {
> -					redirty_page_for_writepage(wbc, page);
> -					unlock_page(page);
> +					folio_redirty_for_writepage(wbc, folio);
> +					folio_unlock(folio);
>   					break;
>   				}
>   
>   				num_ops++;
> -				offset = (u64)page_offset(page);
> +				offset = (u64)folio_pos(folio);
>   				len = 0;
>   			}
>   
>   			/* note position of first page in fbatch */
> -			dout("%p will write page %p idx %lu\n",
> -			     inode, page, page->index);
> +			dout("%p will write folio %p idx %lu\n",
> +			     inode, folio, folio->index);
>   
>   			if (atomic_long_inc_return(&fsc->writeback_count) >
>   			    CONGESTION_ON_THRESH(
> @@ -1153,7 +1152,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   
>   			if (IS_ENCRYPTED(inode)) {
>   				pages[locked_pages] =
> -					fscrypt_encrypt_pagecache_blocks(page,
> +					fscrypt_encrypt_pagecache_blocks(&folio->page,
>   						PAGE_SIZE, 0,
>   						locked_pages ? GFP_NOWAIT : GFP_NOFS);
>   				if (IS_ERR(pages[locked_pages])) {
> @@ -1163,17 +1162,17 @@ static int ceph_writepages_start(struct address_space *mapping,
>   					/* better not fail on first page! */
>   					BUG_ON(locked_pages == 0);
>   					pages[locked_pages] = NULL;
> -					redirty_page_for_writepage(wbc, page);
> -					unlock_page(page);
> +					folio_redirty_for_writepage(wbc, folio);
> +					folio_unlock(folio);
>   					break;
>   				}
>   				++locked_pages;
>   			} else {
> -				pages[locked_pages++] = page;
> +				pages[locked_pages++] = &folio->page;
>   			}
>   
>   			fbatch.folios[i] = NULL;
> -			len += thp_size(page);
> +			len += folio_size(folio);
>   		}
>   
>   		/* did we get anything? */
> @@ -1222,7 +1221,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   			BUG_ON(IS_ERR(req));
>   		}
>   		BUG_ON(len < ceph_fscrypt_page_offset(pages[locked_pages - 1]) +
> -			     thp_size(pages[locked_pages - 1]) - offset);
> +			     folio_size(folio) - offset);
>   
>   		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>   			rc = -EIO;
> @@ -1236,9 +1235,9 @@ static int ceph_writepages_start(struct address_space *mapping,
>   		data_pages = pages;
>   		op_idx = 0;
>   		for (i = 0; i < locked_pages; i++) {
> -			struct page *page = ceph_fscrypt_pagecache_page(pages[i]);
> +			struct folio *folio = page_folio(ceph_fscrypt_pagecache_page(pages[i]));
>   
> -			u64 cur_offset = page_offset(page);
> +			u64 cur_offset = folio_pos(folio);
>   			/*
>   			 * Discontinuity in page range? Ceph can handle that by just passing
>   			 * multiple extents in the write op.
> @@ -1267,10 +1266,10 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				op_idx++;
>   			}
>   
> -			set_page_writeback(page);
> +			folio_start_writeback(folio);
>   			if (caching)
> -				ceph_set_page_fscache(page);
> -			len += thp_size(page);
> +				ceph_set_page_fscache(pages[i]);
> +			len += folio_size(folio);
>   		}
>   		ceph_fscache_write_to_cache(inode, offset, len, caching);
>   
> @@ -1280,7 +1279,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   			/* writepages_finish() clears writeback pages
>   			 * according to the data length, so make sure
>   			 * data length covers all locked pages */
> -			u64 min_len = len + 1 - thp_size(page);
> +			u64 min_len = len + 1 - folio_size(folio);
>   			len = get_writepages_data_length(inode, pages[i - 1],
>   							 offset);
>   			len = max(len, min_len);
> @@ -1360,7 +1359,6 @@ static int ceph_writepages_start(struct address_space *mapping,
>   		if (wbc->sync_mode != WB_SYNC_NONE &&
>   		    start_index == 0 && /* all dirty pages were checked */
>   		    !ceph_wbc.head_snapc) {
> -			struct page *page;
>   			unsigned i, nr;
>   			index = 0;
>   			while ((index <= end) &&
> @@ -1369,10 +1367,10 @@ static int ceph_writepages_start(struct address_space *mapping,
>   						PAGECACHE_TAG_WRITEBACK,
>   						&fbatch))) {
>   				for (i = 0; i < nr; i++) {
> -					page = &fbatch.folios[i]->page;
> -					if (page_snap_context(page) != snapc)
> +					struct folio *folio = fbatch.folios[i];
> +					if (folio->private != snapc)

Here IMO we should reuse and rename 'page_snap_context()' --> 
'folio_snap_context()' instead of 'folio->private' directly. As I 
remembered if the dirty bit is not set the `page->private` still could 
be non-NULL in some cases ?

Thanks

- Xiubo


>   						continue;
> -					wait_on_page_writeback(page);
> +					folio_wait_writeback(folio);
>   				}
>   				folio_batch_release(&fbatch);
>   				cond_resched();

