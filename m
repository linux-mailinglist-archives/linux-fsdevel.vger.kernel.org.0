Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C04725121
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 02:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjFGAcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjFGAci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FF10EA
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686097914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0Mctuhjyu4X/RFmiqN/rM9nxa2yIrdMSLWcbUaMckc=;
        b=jERw11Acjm2VuwDY8NYJk64lO/7zUS8JK1hqvCpY+FjdtGWlqjUkb5EYUvjQM6dvcecQIb
        Mn7gTCxtg18Aykyxyw24P2oeUoRQdlMkWltw3v72KZJBsjAcb4+8KWm1dkYXyQviqhywjQ
        9fdAKTUVJdkLWwnAF6fhd1mKieRlfpA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-1Up7QQ46N-yAUEfIx4qD0A-1; Tue, 06 Jun 2023 20:31:53 -0400
X-MC-Unique: 1Up7QQ46N-yAUEfIx4qD0A-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-395ff4dc3abso6623867b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 17:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686097912; x=1688689912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0Mctuhjyu4X/RFmiqN/rM9nxa2yIrdMSLWcbUaMckc=;
        b=bORxQMCUYHr0iLSWasqLdxxg2ph6ag7unW1uKmb/v6CVopRBnjpHoYVOSo28h+afLm
         wbFStB320zYGLq5zKYeHuE1kk7Z3pJ//LwCgMXTNfpDC3HOsrcimJjvSbXStEbDJcSae
         pixBmD/o7xi+qlaNbZIYP205JFnGlU/IvKGUf7qAjtJ9hcVEBgUc3yOImxNodNVQBt+d
         Qj8RxfqoXOxElKrJT1ObabLaD6yqunhe89a8KfkWaN3SawTzVRvLJ9eLkLNHsdbsq59f
         ZqOL7zqnLCU2Hq9puyYd5vhlPpShKuQxO+qzzc6oiu8nHui6BvxYR1Ju15KdImTnuA+e
         saTQ==
X-Gm-Message-State: AC+VfDwdtsXGQh2aS8RtnnEwaU6T3V6TjukMxoZ8z2PUPl0iDkptEI8q
        QDKzzpGCBlktTTaP0X+yncK2dQYvDlXbzdmkNVMLTCB9vHAHLf23rhZPOHEIjyhTuAuAYWoZBtT
        cJtApHrSI7GOMM9YXqxzyIjWl8A==
X-Received: by 2002:aca:2b13:0:b0:398:5a28:d80f with SMTP id i19-20020aca2b13000000b003985a28d80fmr3937915oik.4.1686097912288;
        Tue, 06 Jun 2023 17:31:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EzKqs+X51Wo2AJRb+0nZ6za+JnXX0S8W8YrKwbVoDYVx43s/m4XK0ETyN+AM3bk1M72kVDQ==
X-Received: by 2002:aca:2b13:0:b0:398:5a28:d80f with SMTP id i19-20020aca2b13000000b003985a28d80fmr3937900oik.4.1686097911958;
        Tue, 06 Jun 2023 17:31:51 -0700 (PDT)
Received: from [10.72.12.128] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q66-20020a17090a1b4800b002533ce5b261sm149359pjq.10.2023.06.06.17.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 17:31:51 -0700 (PDT)
Message-ID: <7d5d87ac-bd4d-60c2-ca26-70a52c7fbdc8@redhat.com>
Date:   Wed, 7 Jun 2023 08:31:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ceph: Convert ceph_writepages_start() to use folios a
 little more
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230605165418.2909336-1-willy@infradead.org>
 <4ca56a21-c5aa-6407-0cc1-db68762630ce@redhat.com>
 <ZH94oBBFct9b9g3z@casper.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <ZH94oBBFct9b9g3z@casper.infradead.org>
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


On 6/7/23 02:19, Matthew Wilcox wrote:
> On Tue, Jun 06, 2023 at 01:37:46PM +0800, Xiubo Li wrote:
>> This Looks good to me.
>>
>> BTW, could you rebase this to the 'testing' branch ? This will introduce a
> Umm, which testing branch is that?  It applies cleanly to next-20230606
> which is generally where I work, since it's a bit unreasonable for me
> to keep track of every filesystem development tree.

Here https://github.com/ceph/ceph-client/commits/testing.

Thanks

- Xiubo

>> lots of conflicts with the fscrypt patches, I'd prefer this could be applied
>> and merged after them since the fscrypt patches have been well tested.
>>
>> Ilya, is that okay ?
>>
>> Thanks
>>
>> - Xiubo
>>
>> On 6/6/23 00:54, Matthew Wilcox (Oracle) wrote:
>>> After we iterate through the locked folios using filemap_get_folios_tag(),
>>> we currently convert back to a page (and then in some circumstaces back
>>> to a folio again!).  Just use a folio throughout and avoid various hidden
>>> calls to compound_head().  Ceph still uses a page array to interact with
>>> the OSD which should be cleaned up in a subsequent patch.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>    fs/ceph/addr.c | 79 +++++++++++++++++++++++++-------------------------
>>>    1 file changed, 39 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>>> index 6bb251a4d613..e2d92a8a53ca 100644
>>> --- a/fs/ceph/addr.c
>>> +++ b/fs/ceph/addr.c
>>> @@ -888,7 +888,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    		int num_ops = 0, op_idx;
>>>    		unsigned i, nr_folios, max_pages, locked_pages = 0;
>>>    		struct page **pages = NULL, **data_pages;
>>> -		struct page *page;
>>> +		struct folio *folio;
>>>    		pgoff_t strip_unit_end = 0;
>>>    		u64 offset = 0, len = 0;
>>>    		bool from_pool = false;
>>> @@ -902,22 +902,22 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    		if (!nr_folios && !locked_pages)
>>>    			break;
>>>    		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
>>> -			page = &fbatch.folios[i]->page;
>>> -			dout("? %p idx %lu\n", page, page->index);
>>> +			folio = fbatch.folios[i];
>>> +			dout("? %p idx %lu\n", folio, folio->index);
>>>    			if (locked_pages == 0)
>>> -				lock_page(page);  /* first page */
>>> -			else if (!trylock_page(page))
>>> +				folio_lock(folio);  /* first folio */
>>> +			else if (!folio_trylock(folio))
>>>    				break;
>>>    			/* only dirty pages, or our accounting breaks */
>>> -			if (unlikely(!PageDirty(page)) ||
>>> -			    unlikely(page->mapping != mapping)) {
>>> -				dout("!dirty or !mapping %p\n", page);
>>> -				unlock_page(page);
>>> +			if (unlikely(!folio_test_dirty(folio)) ||
>>> +			    unlikely(folio->mapping != mapping)) {
>>> +				dout("!dirty or !mapping %p\n", folio);
>>> +				folio_unlock(folio);
>>>    				continue;
>>>    			}
>>>    			/* only if matching snap context */
>>> -			pgsnapc = page_snap_context(page);
>>> +			pgsnapc = page_snap_context(&folio->page);
>>>    			if (pgsnapc != snapc) {
>>>    				dout("page snapc %p %lld != oldest %p %lld\n",
>>>    				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
>>> @@ -925,12 +925,10 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    				    !ceph_wbc.head_snapc &&
>>>    				    wbc->sync_mode != WB_SYNC_NONE)
>>>    					should_loop = true;
>>> -				unlock_page(page);
>>> +				folio_unlock(folio);
>>>    				continue;
>>>    			}
>>> -			if (page_offset(page) >= ceph_wbc.i_size) {
>>> -				struct folio *folio = page_folio(page);
>>> -
>>> +			if (folio_pos(folio) >= ceph_wbc.i_size) {
>>>    				dout("folio at %lu beyond eof %llu\n",
>>>    				     folio->index, ceph_wbc.i_size);
>>>    				if ((ceph_wbc.size_stable ||
>>> @@ -941,31 +939,32 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    				folio_unlock(folio);
>>>    				continue;
>>>    			}
>>> -			if (strip_unit_end && (page->index > strip_unit_end)) {
>>> -				dout("end of strip unit %p\n", page);
>>> -				unlock_page(page);
>>> +			if (strip_unit_end && (folio->index > strip_unit_end)) {
>>> +				dout("end of strip unit %p\n", folio);
>>> +				folio_unlock(folio);
>>>    				break;
>>>    			}
>>> -			if (PageWriteback(page) || PageFsCache(page)) {
>>> +			if (folio_test_writeback(folio) ||
>>> +			    folio_test_fscache(folio)) {
>>>    				if (wbc->sync_mode == WB_SYNC_NONE) {
>>> -					dout("%p under writeback\n", page);
>>> -					unlock_page(page);
>>> +					dout("%p under writeback\n", folio);
>>> +					folio_unlock(folio);
>>>    					continue;
>>>    				}
>>> -				dout("waiting on writeback %p\n", page);
>>> -				wait_on_page_writeback(page);
>>> -				wait_on_page_fscache(page);
>>> +				dout("waiting on writeback %p\n", folio);
>>> +				folio_wait_writeback(folio);
>>> +				folio_wait_fscache(folio);
>>>    			}
>>> -			if (!clear_page_dirty_for_io(page)) {
>>> -				dout("%p !clear_page_dirty_for_io\n", page);
>>> -				unlock_page(page);
>>> +			if (!folio_clear_dirty_for_io(folio)) {
>>> +				dout("%p !folio_clear_dirty_for_io\n", folio);
>>> +				folio_unlock(folio);
>>>    				continue;
>>>    			}
>>>    			/*
>>>    			 * We have something to write.  If this is
>>> -			 * the first locked page this time through,
>>> +			 * the first locked folio this time through,
>>>    			 * calculate max possinle write size and
>>>    			 * allocate a page array
>>>    			 */
>>> @@ -975,7 +974,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    				u32 xlen;
>>>    				/* prepare async write request */
>>> -				offset = (u64)page_offset(page);
>>> +				offset = folio_pos(folio);
>>>    				ceph_calc_file_object_mapping(&ci->i_layout,
>>>    							      offset, wsize,
>>>    							      &objnum, &objoff,
>>> @@ -983,7 +982,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    				len = xlen;
>>>    				num_ops = 1;
>>> -				strip_unit_end = page->index +
>>> +				strip_unit_end = folio->index +
>>>    					((len - 1) >> PAGE_SHIFT);
>>>    				BUG_ON(pages);
>>> @@ -998,33 +997,33 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    				}
>>>    				len = 0;
>>> -			} else if (page->index !=
>>> +			} else if (folio->index !=
>>>    				   (offset + len) >> PAGE_SHIFT) {
>>>    				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
>>>    							     CEPH_OSD_MAX_OPS)) {
>>> -					redirty_page_for_writepage(wbc, page);
>>> -					unlock_page(page);
>>> +					folio_redirty_for_writepage(wbc, folio);
>>> +					folio_unlock(folio);
>>>    					break;
>>>    				}
>>>    				num_ops++;
>>> -				offset = (u64)page_offset(page);
>>> +				offset = (u64)folio_pos(folio);
>>>    				len = 0;
>>>    			}
>>>    			/* note position of first page in fbatch */
>>> -			dout("%p will write page %p idx %lu\n",
>>> -			     inode, page, page->index);
>>> +			dout("%p will write folio %p idx %lu\n",
>>> +			     inode, folio, folio->index);
>>>    			if (atomic_long_inc_return(&fsc->writeback_count) >
>>>    			    CONGESTION_ON_THRESH(
>>>    				    fsc->mount_options->congestion_kb))
>>>    				fsc->write_congested = true;
>>> -			pages[locked_pages++] = page;
>>> +			pages[locked_pages++] = &folio->page;
>>>    			fbatch.folios[i] = NULL;
>>> -			len += thp_size(page);
>>> +			len += folio_size(folio);
>>>    		}
>>>    		/* did we get anything? */
>>> @@ -1073,7 +1072,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    			BUG_ON(IS_ERR(req));
>>>    		}
>>>    		BUG_ON(len < page_offset(pages[locked_pages - 1]) +
>>> -			     thp_size(page) - offset);
>>> +			     folio_size(folio) - offset);
>>>    		req->r_callback = writepages_finish;
>>>    		req->r_inode = inode;
>>> @@ -1115,7 +1114,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    			set_page_writeback(pages[i]);
>>>    			if (caching)
>>>    				ceph_set_page_fscache(pages[i]);
>>> -			len += thp_size(page);
>>> +			len += folio_size(folio);
>>>    		}
>>>    		ceph_fscache_write_to_cache(inode, offset, len, caching);
>>> @@ -1125,7 +1124,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>    			/* writepages_finish() clears writeback pages
>>>    			 * according to the data length, so make sure
>>>    			 * data length covers all locked pages */
>>> -			u64 min_len = len + 1 - thp_size(page);
>>> +			u64 min_len = len + 1 - folio_size(folio);
>>>    			len = get_writepages_data_length(inode, pages[i - 1],
>>>    							 offset);
>>>    			len = max(len, min_len);

