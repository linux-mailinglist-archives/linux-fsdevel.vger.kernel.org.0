Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA37A1E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjIOMPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjIOMPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:15:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93192113;
        Fri, 15 Sep 2023 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9cnxnW7ESMZ0JG3goy/SixkPNAd8GwuVMtcmWWhCh8M=; b=hh6qr8cfEsfSY8d709qeQzGUkh
        UqWbKETiUA6IhftO6ApR9FkEpzteHmM+8ekxGG4ssTV4swSkqsb1TXp7TEXFZmosyzLUBBOxCxCrV
        lUG8Crmn4dfj7jxugqd8oCM8Q/6igBT/i9H9+7IY7mFu9sfs0InzwaJ8D82+W1GJtsjHT1LAMul5E
        lGrj/xb0Tk2yDdB26P2rvy6GpP88l0V3thIIOSknLo2fVBpglW/ONxUboUlhJ4vZEzqDRpK53DDT/
        f4aWb4/Nm9XHkK57VOp7Rr4oRjRAmnJWS0/bZp2jyLt65GoP4gBWCbe9R83/9KVSRXryzj9mZRKd3
        wJ9rqGzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh7iq-009cFS-1s; Fri, 15 Sep 2023 12:14:56 +0000
Date:   Fri, 15 Sep 2023 13:14:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/6] shmem: account for large order folios
Message-ID: <ZQRKv6NcfYCr0aWo@casper.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095128eucas1p2885c3add58d82413d9c1d17832d3d281@eucas1p2.samsung.com>
 <20230915095042.1320180-4-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095042.1320180-4-da.gomez@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:51:26AM +0000, Daniel Gomez wrote:
> @@ -1810,13 +1815,14 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>  		return;
>  
>  	folio_wait_writeback(folio);
> +	num_swap_pages = folio_nr_pages(folio);
>  	delete_from_swap_cache(folio);
>  	/*
>  	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>  	 * in shmem_evict_inode().
>  	 */
> -	shmem_recalc_inode(inode, -1, -1);
> +	shmem_recalc_inode(inode, num_swap_pages, num_swap_pages);

Shouldn't that be -num_swap_pages?

>  	swap_free(swap);
>  }
>  
> @@ -1903,7 +1909,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	if (error)
>  		goto failed;
>  
> -	shmem_recalc_inode(inode, 0, -1);
> +	shmem_recalc_inode(inode, 0, folio_nr_pages(folio));
>  
>  	if (sgp == SGP_WRITE)
>  		folio_mark_accessed(folio);

Also here.
