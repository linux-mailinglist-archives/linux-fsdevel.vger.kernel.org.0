Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BDD77BBF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjHNOsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjHNOsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:48:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4BC3;
        Mon, 14 Aug 2023 07:48:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D26E51F7AB;
        Mon, 14 Aug 2023 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692024483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BiBm685hzTBMar9PdbO8Taka4sGqAp1uF0sY47azg7U=;
        b=OdjitYHlIuuQN/mMeli5buRFmKB220no6BKHTamL5iKQX0/Nz/2JDdYjVldHUzGIE4PuGz
        bPQGOGhGL8Eku4QIfc1mmqR6mxcVmTvLPvbAo9QkdAa3c7qQ393R/LP/E/aFlT975/Pzy9
        xeSHVW6Q5j6C8WC+5SPnDqdiEc528N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692024483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BiBm685hzTBMar9PdbO8Taka4sGqAp1uF0sY47azg7U=;
        b=d63G25R+K9a3Zyqwd9EKktSL5tns3i+oVr++6X8qCNUJrf7KpqzX1HSHEoU3bzD13XwvKY
        NVLw9TOfS6YehBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A7B7138EE;
        Mon, 14 Aug 2023 14:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vge1GKM+2mSqBAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 14 Aug 2023 14:48:03 +0000
Message-ID: <8d0fbb63-9d2a-d16b-0644-e8ba251d1b04@suse.de>
Date:   Mon, 14 Aug 2023 16:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230814144100.596749-1-willy@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/14/23 16:41, Matthew Wilcox (Oracle) wrote:
> The special casing was originally added in pre-git history; reproducing
> the commit log here:
> 
>> commit a318a92567d77
>> Author: Andrew Morton <akpm@osdl.org>
>> Date:   Sun Sep 21 01:42:22 2003 -0700
>>
>>      [PATCH] Speed up direct-io hugetlbpage handling
>>
>>      This patch short-circuits all the direct-io page dirtying logic for
>>      higher-order pages.  Without this, we pointlessly bounce BIOs up to
>>      keventd all the time.
> 
> In the last twenty years, compound pages have become used for more than
> just hugetlb.  Rewrite these functions to operate on folios instead
> of pages and remove the special case for hugetlbfs; I don't think
> it's needed any more (and if it is, we can put it back in as a call
> to folio_test_hugetlb()).
> 
> This was found by inspection; as far as I can tell, this bug can lead
> to pages used as the destination of a direct I/O read not being marked
> as dirty.  If those pages are then reclaimed by the MM without being
> dirtied for some other reason, they won't be written out.  Then when
> they're faulted back in, they will not contain the data they should.
> It'll take a pretty unusual setup to produce this problem with several
> races all going the wrong way.
> 
> This problem predates the folio work; it could for example have been
> triggered by mmaping a THP in tmpfs and using that as the target of an
> O_DIRECT read.
> 
> Fixes: 800d8c63b2e98 ("shmem: add huge pages support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   block/bio.c | 46 ++++++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 8672179213b9..f46d8ec71fbd 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1171,13 +1171,22 @@ EXPORT_SYMBOL(bio_add_folio);
>   
>   void __bio_release_pages(struct bio *bio, bool mark_dirty)
>   {
> -	struct bvec_iter_all iter_all;
> -	struct bio_vec *bvec;
> +	struct folio_iter fi;
> +
> +	bio_for_each_folio_all(fi, bio) {
> +		struct page *page;
> +		size_t done = 0;
>   
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		if (mark_dirty && !PageCompound(bvec->bv_page))
> -			set_page_dirty_lock(bvec->bv_page);
> -		bio_release_page(bio, bvec->bv_page);
> +		if (mark_dirty) {
> +			folio_lock(fi.folio);
> +			folio_mark_dirty(fi.folio);
> +			folio_unlock(fi.folio);
> +		}
> +		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> +		do {
> +			bio_release_page(bio, page++);
> +			done += PAGE_SIZE;
> +		} while (done < fi.length);
>   	}
>   }
>   EXPORT_SYMBOL_GPL(__bio_release_pages);
> @@ -1455,18 +1464,12 @@ EXPORT_SYMBOL(bio_free_pages);
>    * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
>    * for performing direct-IO in BIOs.
>    *
> - * The problem is that we cannot run set_page_dirty() from interrupt context
> + * The problem is that we cannot run folio_mark_dirty() from interrupt context
>    * because the required locks are not interrupt-safe.  So what we can do is to
>    * mark the pages dirty _before_ performing IO.  And in interrupt context,
>    * check that the pages are still dirty.   If so, fine.  If not, redirty them
>    * in process context.
>    *
> - * We special-case compound pages here: normally this means reads into hugetlb
> - * pages.  The logic in here doesn't really work right for compound pages
> - * because the VM does not uniformly chase down the head page in all cases.
> - * But dirtiness of compound pages is pretty meaningless anyway: the VM doesn't
> - * handle them at all.  So we skip compound pages here at an early stage.
> - *
>    * Note that this code is very hard to test under normal circumstances because
>    * direct-io pins the pages with get_user_pages().  This makes
>    * is_page_cache_freeable return false, and the VM will not clean the pages.
> @@ -1482,12 +1485,12 @@ EXPORT_SYMBOL(bio_free_pages);
>    */
>   void bio_set_pages_dirty(struct bio *bio)
>   {
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> +	struct folio_iter fi;
>   
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		if (!PageCompound(bvec->bv_page))
> -			set_page_dirty_lock(bvec->bv_page);
> +	bio_for_each_folio_all(fi, bio) {
> +		folio_lock(fi.folio);
> +		folio_mark_dirty(fi.folio);
> +		folio_unlock(fi.folio);
>   	}
>   }
>   
> @@ -1530,12 +1533,11 @@ static void bio_dirty_fn(struct work_struct *work)
>   
>   void bio_check_pages_dirty(struct bio *bio)
>   {
> -	struct bio_vec *bvec;
> +	struct folio_iter fi;
>   	unsigned long flags;
> -	struct bvec_iter_all iter_all;
>   
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
> +	bio_for_each_folio_all(fi, bio) {
> +		if (!folio_test_dirty(fi.folio))
>   			goto defer;
>   	}
>   
You know what, I guess I've seen this bug.

During my large-page I/O work I stumbled across the weird issue that 
using the modified 'brd' directly resulted in xfs to report checksum 
errors, but when using the modified 'brd' as the backing store for an
nvme-target running over the loopback interface xfs was happy.

Haven't really investigated that, but it sounds awfully similar.

I'll see if I can give this patch a spin.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

