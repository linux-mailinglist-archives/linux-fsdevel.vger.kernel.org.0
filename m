Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651B47236E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 07:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjFFFiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 01:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFFFis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E56E1B1
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686029880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE1oC930IjSotz3e4slqHTiXbBdlSHZvytEpW919OcA=;
        b=dmei28Yls9FNtGCSWvkb/9XVIi1wqq8wzotomXduV/rZiZc4EEghFf2paNcXxT4ZBOyyTk
        Q3qYIeJMTncN+XTCVn6KbXGh1jTi8QxazbnIBZHYfso6clTDPos0BtQRzM7WWozPJHEWf5
        vECTLUx396JITxm5VKXzaFkd5gMC8l0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-tC8lDbDtNPuixlD0rAbwdw-1; Tue, 06 Jun 2023 01:37:59 -0400
X-MC-Unique: tC8lDbDtNPuixlD0rAbwdw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b024ab0c28so54066675ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 22:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029878; x=1688621878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE1oC930IjSotz3e4slqHTiXbBdlSHZvytEpW919OcA=;
        b=fpPJWnalRoJueW4D1alplYiuWe4Ui3rsBQGMYExMU++1ZKSnd0iGVCz2Ih3LVkGX7A
         iacGuOQK5Rtgj832IfYfcfdAyvYB7gqXfFjJAwQsuBnzyo+3jtRJ4S64BuGCVuZGxP4M
         FgePQcc62xioxY2tivHlPGc4kcdLYOmXVA1P8iZ86xy8YeslTbL6/vkWskZN/kYR3aj2
         9rIKoYr79s9DO3/ag838Qjv/c0XhhCj7qKPlqN/q6+X7S4t0v4h/5hN7ORHgmkdaB/1d
         pmwXwKx9YcmZudSrop4wEGDBZg+VOahVMy9cXKUVUWcc0ZsJOIYbhdZ5bvViCprYsCA7
         HRQg==
X-Gm-Message-State: AC+VfDyyOoDTL39+TPtC+3/NAAgom0AL/e/JwXKMM2mLVAtn/8u+k3rr
        fIIh81khG6QJlCPSF3kMTgrRvR/3FH8C0eoOCzYcvfi0P3kvQO5xF3oy/a95AjmLGyQSAMmdg0I
        qP53y5czqMx7WtPDPG1jhqU12yQ==
X-Received: by 2002:a17:902:e886:b0:1b0:6e16:b92c with SMTP id w6-20020a170902e88600b001b06e16b92cmr1359054plg.54.1686029878189;
        Mon, 05 Jun 2023 22:37:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pl8kVGdN9xgeHu2vYkkLO6G7EzdcKwfNpY+YccTt3n28c6jWRtcC8MBbJ7Sx+1gaB+8HzgQ==
X-Received: by 2002:a17:902:e886:b0:1b0:6e16:b92c with SMTP id w6-20020a170902e88600b001b06e16b92cmr1359045plg.54.1686029877844;
        Mon, 05 Jun 2023 22:37:57 -0700 (PDT)
Received: from [10.72.12.128] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001ab09f5ca61sm7508722pls.55.2023.06.05.22.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 22:37:57 -0700 (PDT)
Message-ID: <4ca56a21-c5aa-6407-0cc1-db68762630ce@redhat.com>
Date:   Tue, 6 Jun 2023 13:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: Convert ceph_writepages_start() to use folios a
 little more
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230605165418.2909336-1-willy@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230605165418.2909336-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This Looks good to me.

BTW, could you rebase this to the 'testing' branch ? This will introduce 
a lots of conflicts with the fscrypt patches, I'd prefer this could be 
applied and merged after them since the fscrypt patches have been well 
tested.

Ilya, is that okay ?

Thanks

- Xiubo

On 6/6/23 00:54, Matthew Wilcox (Oracle) wrote:
> After we iterate through the locked folios using filemap_get_folios_tag(),
> we currently convert back to a page (and then in some circumstaces back
> to a folio again!).  Just use a folio throughout and avoid various hidden
> calls to compound_head().  Ceph still uses a page array to interact with
> the OSD which should be cleaned up in a subsequent patch.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/ceph/addr.c | 79 +++++++++++++++++++++++++-------------------------
>   1 file changed, 39 insertions(+), 40 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6bb251a4d613..e2d92a8a53ca 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -888,7 +888,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   		int num_ops = 0, op_idx;
>   		unsigned i, nr_folios, max_pages, locked_pages = 0;
>   		struct page **pages = NULL, **data_pages;
> -		struct page *page;
> +		struct folio *folio;
>   		pgoff_t strip_unit_end = 0;
>   		u64 offset = 0, len = 0;
>   		bool from_pool = false;
> @@ -902,22 +902,22 @@ static int ceph_writepages_start(struct address_space *mapping,
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
> +			pgsnapc = page_snap_context(&folio->page);
>   			if (pgsnapc != snapc) {
>   				dout("page snapc %p %lld != oldest %p %lld\n",
>   				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
> @@ -925,12 +925,10 @@ static int ceph_writepages_start(struct address_space *mapping,
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
> @@ -941,31 +939,32 @@ static int ceph_writepages_start(struct address_space *mapping,
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
> @@ -975,7 +974,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				u32 xlen;
>   
>   				/* prepare async write request */
> -				offset = (u64)page_offset(page);
> +				offset = folio_pos(folio);
>   				ceph_calc_file_object_mapping(&ci->i_layout,
>   							      offset, wsize,
>   							      &objnum, &objoff,
> @@ -983,7 +982,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   				len = xlen;
>   
>   				num_ops = 1;
> -				strip_unit_end = page->index +
> +				strip_unit_end = folio->index +
>   					((len - 1) >> PAGE_SHIFT);
>   
>   				BUG_ON(pages);
> @@ -998,33 +997,33 @@ static int ceph_writepages_start(struct address_space *mapping,
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
>   				    fsc->mount_options->congestion_kb))
>   				fsc->write_congested = true;
>   
> -			pages[locked_pages++] = page;
> +			pages[locked_pages++] = &folio->page;
>   			fbatch.folios[i] = NULL;
>   
> -			len += thp_size(page);
> +			len += folio_size(folio);
>   		}
>   
>   		/* did we get anything? */
> @@ -1073,7 +1072,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   			BUG_ON(IS_ERR(req));
>   		}
>   		BUG_ON(len < page_offset(pages[locked_pages - 1]) +
> -			     thp_size(page) - offset);
> +			     folio_size(folio) - offset);
>   
>   		req->r_callback = writepages_finish;
>   		req->r_inode = inode;
> @@ -1115,7 +1114,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   			set_page_writeback(pages[i]);
>   			if (caching)
>   				ceph_set_page_fscache(pages[i]);
> -			len += thp_size(page);
> +			len += folio_size(folio);
>   		}
>   		ceph_fscache_write_to_cache(inode, offset, len, caching);
>   
> @@ -1125,7 +1124,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   			/* writepages_finish() clears writeback pages
>   			 * according to the data length, so make sure
>   			 * data length covers all locked pages */
> -			u64 min_len = len + 1 - thp_size(page);
> +			u64 min_len = len + 1 - folio_size(folio);
>   			len = get_writepages_data_length(inode, pages[i - 1],
>   							 offset);
>   			len = max(len, min_len);

