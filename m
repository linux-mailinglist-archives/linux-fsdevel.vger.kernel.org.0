Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94B76E941D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjDTMUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjDTMUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:20:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D74C37;
        Thu, 20 Apr 2023 05:19:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C4F121993;
        Thu, 20 Apr 2023 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681993198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNJO5JoHwcnmeI96izM3wTCc2c/oK0ZQQpslc8KNUY4=;
        b=X2AUvC96elh9w3oozO6fynVGk3y9mb1fGJq3wLjSZq8RqmdVn2UQazZ+PDR9dLW+rnlMC4
        gluAcr61PYQW3hkGA1zC/lxD1umDzx9Z8/MG3ilKzrI5Qf4lAUdF4nTxWnCRsY5uEQ8Vo8
        wvKkpN83RQh27+QXcr2qWKHAZYFIJ6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681993198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNJO5JoHwcnmeI96izM3wTCc2c/oK0ZQQpslc8KNUY4=;
        b=5AZo+lE3S+ru1WgSGPGPNioKJfH0ySi0avfXvp1uce1zYQm/eI5p30nTuen3R5QtUvVXuo
        7UltgL2p509r8MDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 097931333C;
        Thu, 20 Apr 2023 12:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uVsAAu4tQWTncwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 20 Apr 2023 12:19:58 +0000
Message-ID: <a826abe1-332f-22db-982c-ecec67a40585@suse.de>
Date:   Thu, 20 Apr 2023 14:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, SSDR Gost Dev <gost.dev@samsung.com>
References: <CGME20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601@eucas1p1.samsung.com>
 <20230414134908.103932-1-hare@suse.de>
 <2466fa23-a817-1dee-b89f-fcbeaca94a9e@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <2466fa23-a817-1dee-b89f-fcbeaca94a9e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/23 14:05, Pankaj Raghav wrote:
> To keep this thread alive and get some direction on the next steps, I made some changes
> with which I am able to do **buffered reads** with fio on brd with logical block size > 4k.
> 
> Along with your patches (this patch and the brd patches), I added the following diff:
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 242e213ee064..2e0c066d72d3 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -161,7 +161,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>          struct folio *folio = args->folio;
>          struct inode *inode = folio->mapping->host;
>          const unsigned blkbits = inode->i_blkbits;
> -       const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
> +       const unsigned blocks_per_page = folio_size(folio) >> blkbits;
>          const unsigned blocksize = 1 << blkbits;
>          struct buffer_head *map_bh = &args->map_bh;
>          sector_t block_in_file;
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..2e42b5127f4c 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -210,7 +210,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>          unsigned long index = readahead_index(ractl);
>          gfp_t gfp_mask = readahead_gfp_mask(mapping);
>          unsigned long i;
> -
> +       int order = 0;
>          /*
>           * Partway through the readahead operation, we will have added
>           * locked pages to the page cache, but will not yet have submitted
> @@ -223,6 +223,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>           */
>          unsigned int nofs = memalloc_nofs_save();
> 
> +       if (mapping->host->i_blkbits > PAGE_SHIFT)
> +               order = mapping->host->i_blkbits - PAGE_SHIFT;
> +
>          filemap_invalidate_lock_shared(mapping);
>          /*
>           * Preallocate as many pages as we will need.
> @@ -245,7 +248,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>                          continue;
>                  }
> 
> -               folio = filemap_alloc_folio(gfp_mask, 0);
> +               folio = filemap_alloc_folio(gfp_mask, order);
>                  if (!folio)
>                          break;
>                  if (filemap_add_folio(mapping, folio, index + i,
> @@ -259,7 +262,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>                  if (i == nr_to_read - lookahead_size)
>                          folio_set_readahead(folio);
>                  ractl->_workingset |= folio_test_workingset(folio);
> -               ractl->_nr_pages++;
> +               ractl->_nr_pages += folio_nr_pages(folio);
>          }
> 
> 
> And with that (drum roll):
> 
> root@debian:~# cat /sys/block/ram0/queue/logical_block_size
> 8192
> root@debian:~# fio -bs=8k -iodepth=8 -rw=read -ioengine=io_uring -size=200M -name=io_uring_1
> -filename=/dev/ram0
> io_uring_1: (g=0): rw=read, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T) 8192B-8192B, ioengine=io_uring,
> iodepth=8
> fio-3.33
> Starting 1 process
> 
> io_uring_1: (groupid=0, jobs=1): err= 0: pid=450: Thu Apr 20 11:34:10 2023
>    read: IOPS=94.8k, BW=741MiB/s (777MB/s)(40.0MiB/54msec)
> 
> <snip>
> 
> Run status group 0 (all jobs):
>     READ: bw=741MiB/s (777MB/s), 741MiB/s-741MiB/s (777MB/s-777MB/s), io=40.0MiB (41.9MB), run=54-54msec
> 
> Disk stats (read/write):
>    ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
> 
> 
> **Questions on the future work**:
> 
> As willy pointed out, we have to do this `order = mapping->host->i_blkbits - PAGE_SHIFT` in
> many places. Should we pursue something that willy suggested: encapsulating order in the
> mapping->flags as a next step?[1]
> 
> 
> [1] https://lore.kernel.org/lkml/ZDty+PQfHkrGBojn@casper.infradead.org/

Well ... really, not sure.
Yes, continue updating buffer_heads would be a logical thing as it could 
be done incrementally.

But really, the end-goal should be to move away from buffer_heads for fs 
and mm usage. So I wonder if we shouldn't rather look in that direction..

Cheers,

Hannes

