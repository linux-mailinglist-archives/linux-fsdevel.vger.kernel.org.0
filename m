Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA3776549
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 18:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHIQou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 12:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHIQot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:44:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A041BFE;
        Wed,  9 Aug 2023 09:44:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84B7A2187E;
        Wed,  9 Aug 2023 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691599487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDhLE3ZT6vGy7jFyOFpA8ZS/b+W0KeOHURtugtULW3g=;
        b=dfLcv7/AijRLKHjL1t1noAK9Qk5iKSFINL4VURbX3V9BPdMkLGdsFnao+maJUgXRq8FzHA
        ampedrAG6ab+ku3msmXGKGC50qGzvzpq1uFfrkN4bpx5ePJf7RBuXFD1UZW1zZJf/ZoseJ
        NK9IGgKfeS2AVFS48lEAsqJgWhNBWag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691599487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDhLE3ZT6vGy7jFyOFpA8ZS/b+W0KeOHURtugtULW3g=;
        b=IC1FePROY468GiaL9M2rWyaAYV2g2X93uqoziugzeEp2uSvcA4TmqRA0ZiA/wR/ocuihXL
        TD4pMgaSKCACQrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F4F8133B5;
        Wed,  9 Aug 2023 16:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pbEbG3/C02S1awAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Aug 2023 16:44:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F112CA0769; Wed,  9 Aug 2023 18:44:46 +0200 (CEST)
Date:   Wed, 9 Aug 2023 18:44:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
Subject: Re: [PATCH] mm/filemap.c:fix update prev_pos after one read request
 done
Message-ID: <20230809164446.uwxryhrfbjka2lio@quack3>
References: <20230628110220.120134-1-haibo.li@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628110220.120134-1-haibo.li@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 19:02:20, Haibo Li wrote:
> ra->prev_pos tracks the last visited byte in the previous read request.
> It is used to check whether it is sequential read in
> ondemand_readahead and thus affects the readahead window.
> 
> From commit 06c0444290ce ("mm/filemap.c: generic_file_buffered_read()
> now uses find_get_pages_contig"),update logic of prev_pos is changed.
> It updates prev_pos after each returns from filemap_get_pages.
> But the read request from user may be not fully completed
> at this point.
> The updated prev_pos impacts the subsequent readahead window.
> 
> The real problem is performance drop of fsck_msdos between linux-5.4
> and linux-5.15(also linux-6.4).
> Comparing to linux-5.4,It spends about 110% time and read 140% pages.
> The read pattern of fsck_msdos is not fully sequential.
> 
> Simplified read pattern of fsck_msdos likes below:
> 1.read at page offset 0xa,size 0x1000
> 2.read at other page offset like 0x20,size 0x1000
> 3.read at page offset 0xa,size 0x4000
> 4.read at page offset 0xe,size 0x1000
> 
> Here is the read status on linux-6.4:
> 1.after read at page offset 0xa,size 0x1000
>     ->page ofs 0xa go into pagecache
> 2.after read at page offset 0x20,size 0x1000
>     ->page ofs 0x20 go into pagecache
> 3.read at page offset 0xa,size 0x4000
>     ->filemap_get_pages read ofs 0xa from pagecache and returns
>     ->prev_pos is updated to 0xb and goto next loop
>     ->filemap_get_pages tends to read ofs 0xb,size 0x3000
>     ->initial_readahead case in ondemand_readahead since prev_pos is
>       the same as request ofs.
>     ->read 8 pages while async size is 5 pages
>       (PageReadahead flag at page 0xe)
> 4.read at page offset 0xe,size 0x1000
>     ->hit page 0xe with PageReadahead flag set,double the ra_size.
>       read 16 pages while async size is 16 pages
> Now it reads 24 pages while actually uses 5 pages
> 
> on linux-5.4:
> 1.the same as 6.4
> 2.the same as 6.4
> 3.read at page offset 0xa,size 0x4000
>     ->read ofs 0xa from pagecache
>     ->read ofs 0xb,size 0x3000 using page_cache_sync_readahead
>       read 3 pages
>     ->prev_pos is updated to 0xd before generic_file_buffered_read
>       returns
> 4.read at page offset 0xe,size 0x1000
>     ->initial_readahead case in ondemand_readahead since
>       request ofs-prev_pos==1
>     ->read 4 pages while async size is 3 pages
> 
> Now it reads 7 pages while actually uses 5 pages.
> 
> In above demo,the initial_readahead case is triggered by offset
> of user request on linux-5.4.
> While it may be triggered by update logic of prev_pos on linux-6.4.
> 
> To fix the performance drop,update prev_pos after finishing one read
> request.
> 
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>

Sorry for the delayed reply. This seems to have fallen through the cracks.
So if I understand your analysis right, you are complaining that random
read larger than 1 page gets misdetected as sequential read and so "larger
than necessary" readahead happens. I tend to agree with your opinion and your
solution looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Willy, any opinion? Andrew, can you pickup the patch if Willy doesn't
object?

								Honza

> ---
>  mm/filemap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 83dda76d1fc3..16b2054eee71 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2670,6 +2670,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  	int i, error = 0;
>  	bool writably_mapped;
>  	loff_t isize, end_offset;
> +	loff_t last_pos = ra->prev_pos;
>  
>  	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
>  		return 0;
> @@ -2721,8 +2722,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  		 * When a read accesses the same folio several times, only
>  		 * mark it as accessed the first time.
>  		 */
> -		if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
> -							fbatch.folios[0]))
> +		if (!pos_same_folio(iocb->ki_pos, last_pos - 1,
> +				    fbatch.folios[0]))
>  			folio_mark_accessed(fbatch.folios[0]);
>  
>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> @@ -2749,7 +2750,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  
>  			already_read += copied;
>  			iocb->ki_pos += copied;
> -			ra->prev_pos = iocb->ki_pos;
> +			last_pos = iocb->ki_pos;
>  
>  			if (copied < bytes) {
>  				error = -EFAULT;
> @@ -2763,7 +2764,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
>  
>  	file_accessed(filp);
> -
> +	ra->prev_pos = last_pos;
>  	return already_read ? already_read : error;
>  }
>  EXPORT_SYMBOL_GPL(filemap_read);
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
