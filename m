Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740DD546C8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbiFJSfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349792AbiFJSeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:34:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888193A197;
        Fri, 10 Jun 2022 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ds5WQBITtKB6EEQtW4hoMd9Sg3HLa34Vavd3wlK3BM=; b=J+6nFrtPQRWqS0sBmw87Kkv/bJ
        8Sz2jKPCtpG6GIG2+Q5erX23oNN8K5YTXCOJplN+4Gw3drhbTgmHoggZD70XobYEyXeYZXDdZtLO2
        ptTD6vKuCHL1onHZ4Th6xYQFS8TTlm9Bj7KdOR3IgxxwJ4uSy5H8MixcxKagAGH/CIVO/9zzKGQB+
        NkSvxpsU03UsXoy9Ss5kzlqXJyCD2Z8PsUT8tnfsH+OWPjsCpj1S6IURai8dA5G297qktZUxwQhNe
        VrIpR+r50cJtBUcG3vXt1CdXJdl2Jf98gSOFCTlLIfeSFqljmMOM9OkEFElID0duHr42Y0ioKS4Ng
        IsBHaA6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzjSi-00EeyM-DD; Fri, 10 Jun 2022 18:34:24 +0000
Date:   Fri, 10 Jun 2022 19:34:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Yu Kuai <yukuai3@huawei.com>, akpm@linux-foundation.org,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Message-ID: <YqOOsHecZUWlHEn/@casper.infradead.org>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
 <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:47:02PM -0400, Kent Overstreet wrote:
> I think this is the fix we want - I think Yu basically had the right idea
> and had the off by one fix, this should be clearer though:
> 
> Yu, can you confirm the fix?
> 
> -- >8 --
> Subject: [PATCH] filemap: Fix off by one error when marking folios accessed
> 
> In filemap_read() we mark pages accessed as we read them - but we don't
> want to do so redundantly, if the previous read already did so.
> 
> But there was an off by one error: we want to check if the current page
> was the same as the last page we read from, but the last page we read
> from was (ra->prev_pos - 1) >> PAGE_SHIFT.
> 
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9daeaab360..8d5c8043cb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2704,7 +2704,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct
> iov_iter *iter,
>                  * mark it as accessed the first time.
>                  */
>                 if (iocb->ki_pos >> PAGE_SHIFT !=
> -                   ra->prev_pos >> PAGE_SHIFT)
> +                   (ra->prev_pos - 1) >> PAGE_SHIFT)
>                         folio_mark_accessed(fbatch.folios[0]);
> 
>                 for (i = 0; i < folio_batch_count(&fbatch); i++) {
> 

This is going to mark the folio as accessed multiple times if it's
a multi-page folio.  How about this one?


diff --git a/mm/filemap.c b/mm/filemap.c
index 5f227b5420d7..a30587f2e598 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2599,6 +2599,13 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	return err;
 }
 
+static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
+{
+	unsigned int shift = folio_shift(folio);
+
+	return (pos1 >> shift == pos2 >> shift);
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2670,11 +2677,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		writably_mapped = mapping_writably_mapped(mapping);
 
 		/*
-		 * When a sequential read accesses a page several times, only
+		 * When a read accesses the same folio several times, only
 		 * mark it as accessed the first time.
 		 */
-		if (iocb->ki_pos >> PAGE_SHIFT !=
-		    ra->prev_pos >> PAGE_SHIFT)
+		if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
+							fbatch.folios[0]))
 			folio_mark_accessed(fbatch.folios[0]);
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
