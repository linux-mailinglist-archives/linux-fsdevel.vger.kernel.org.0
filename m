Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EB59EDC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiHWUtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiHWUso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:48:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D3C0A;
        Tue, 23 Aug 2022 13:43:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 802F81F890;
        Tue, 23 Aug 2022 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661287419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvUii2Ere0iwPAZzLrUqcRoqaN33vJT3Za8FZvP1Oes=;
        b=nF/SYpX0baEzY/ugyPQ5L8m/l9RISUp24MncZFUB2HeyoHjj5+C1rsnQ0bpvcKftU+/8Ka
        vefiOQhXMOPer3UAUx1pWkowFjTm6itVCAjFzk+9YArJFRLGrzG6QaqSo/yXVhzE7FK6K6
        g4pLpbGi7xKbCuH5cUAQeLN71T2YMuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661287419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvUii2Ere0iwPAZzLrUqcRoqaN33vJT3Za8FZvP1Oes=;
        b=ZXjO/kDKQb8ICoMCdvjHznlofq/jGeDCXHPmbWtoIwgThYUGWCdKVZ6yF0G1TO2ScdvvY2
        g9jX6JO4KbtX/aDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B50313A89;
        Tue, 23 Aug 2022 20:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4VZ6Dfs7BWNYCgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 20:43:39 +0000
Date:   Tue, 23 Aug 2022 22:38:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] btrfs: Convert process_page_range() to use
 filemap_get_folios_contig()
Message-ID: <20220823203825.GT13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220816175246.42401-1-vishal.moola@gmail.com>
 <20220816175246.42401-5-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816175246.42401-5-vishal.moola@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:52:43AM -0700, Vishal Moola (Oracle) wrote:
> Converted function to use folios throughout. This is in preparation for
> the removal of find_get_pages_contig(). Now also supports large folios.
> 
> Since we may receive more than nr_pages pages, nr_pages may underflow.
> Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
> with this check instead.
> 
> Also minor comment renaming for consistency in subpage.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: David Sterba <dsterba@suse.com>

> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/pagemap.h>
> +#include <linux/pagevec.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/sizes.h>
> @@ -20,39 +21,39 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
>  				       unsigned long flags)
>  {
>  	int ret;
> -	struct page *pages[16];
> +	struct folio_batch fbatch;
>  	unsigned long index = start >> PAGE_SHIFT;
>  	unsigned long end_index = end >> PAGE_SHIFT;
> -	unsigned long nr_pages = end_index - index + 1;
>  	int i;
>  	int count = 0;
>  	int loops = 0;
>  
> -	while (nr_pages > 0) {
> -		ret = find_get_pages_contig(inode->i_mapping, index,
> -				     min_t(unsigned long, nr_pages,
> -				     ARRAY_SIZE(pages)), pages);
> +	folio_batch_init(&fbatch);
> +
> +	while (index <= end_index) {
> +		ret = filemap_get_folios_contig(inode->i_mapping, &index,
> +				end_index, &fbatch);
>  		for (i = 0; i < ret; i++) {
> +			struct folio *folio = fbatch.folios[i];

Add a newline please

>  			if (flags & PROCESS_TEST_LOCKED &&
> -			    !PageLocked(pages[i]))
> +			    !folio_test_locked(folio))
>  				count++;
> -			if (flags & PROCESS_UNLOCK && PageLocked(pages[i]))
> -				unlock_page(pages[i]);
> -			put_page(pages[i]);
> +			if (flags & PROCESS_UNLOCK && folio_test_locked(folio))
> +				folio_unlock(folio);
>  			if (flags & PROCESS_RELEASE)
> -				put_page(pages[i]);
> +				folio_put(folio);
>  		}
> -		nr_pages -= ret;
> -		index += ret;
> +		folio_batch_release(&fbatch);
>  		cond_resched();
>  		loops++;
>  		if (loops > 100000) {
>  			printk(KERN_ERR
> -		"stuck in a loop, start %llu, end %llu, nr_pages %lu, ret %d\n",
> -				start, end, nr_pages, ret);
> +		"stuck in a loop, start %llu, end %llu, ret %d\n",
> +				start, end, ret);
>  			break;
>  		}
>  	}
> +
>  	return count;
>  }
>  
> -- 
> 2.36.1
