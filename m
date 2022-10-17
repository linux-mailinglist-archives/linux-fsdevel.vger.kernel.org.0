Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E5601418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJQQ4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQQ4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:56:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065925F232;
        Mon, 17 Oct 2022 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=83HfgXyt1fnZGMmK4nQ7n8nfSmpn8od1B8gLuX+LwHY=; b=qBC6TDZlB3i8imxlXD/g7zRcJf
        jf4EA0n7DQ1N/e0YAOQexbZVxhjV6+a5hS4WlZS/ATV4qfUVTKBwZAondrx63RNrK7wkMoZb52WVy
        sImZzqiob3gMY07YftS5VFT+npmDONCyOhi/f3drznjbYpXgHYfcaismrphe3S1V4Bg9dEQ/rK8O6
        jst1T6wMheKn6r5EzJksGGFiT9Kpe05Um8fq1fN0F03kx5q2Nhu52jxYRn0s4v3iN+iQ5R0bXt8Z9
        QyKEJXbTRQvxjlUOnXaP04GOU7H84G4lBmCUiMwH5sm58iNM3CCH7Yx7XmzQbXa3puTug2WuKCRG6
        2Ruryt2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okTPw-009zMo-8r; Mon, 17 Oct 2022 16:56:44 +0000
Date:   Mon, 17 Oct 2022 17:56:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] filemap: find_lock_entries() now updates start
 offset
Message-ID: <Y02JTOtYEbAyo+zu@casper.infradead.org>
References: <20221017161800.2003-1-vishal.moola@gmail.com>
 <20221017161800.2003-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017161800.2003-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:17:59AM -0700, Vishal Moola (Oracle) wrote:
> +++ b/mm/shmem.c
> @@ -932,21 +932,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  
>  	folio_batch_init(&fbatch);
>  	index = start;
> -	while (index < end && find_lock_entries(mapping, index, end - 1,
> +	while (index < end && find_lock_entries(mapping, &index, end - 1,

Sorry for not spotting this in earlier revisions, but this is wrong.
Before, find_lock_entries() would go up to (end - 1) and then the
index++ at the end of the loop would increment index to "end", causing
the loop to terminate.  Now we don't increment index any more, so the
condition is wrong.

I suggest just removing the 'index < end" half of the condition.

> @@ -361,9 +361,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  
>  	folio_batch_init(&fbatch);
>  	index = start;
> -	while (index < end && find_lock_entries(mapping, index, end - 1,
> +	while (index < end && find_lock_entries(mapping, &index, end - 1,
>  			&fbatch, indices)) {

Similarly here.

> @@ -510,20 +509,17 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
>  	int i;
>  
>  	folio_batch_init(&fbatch);
> -	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
> +	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {

While this one had the check removed already, so is fine ;-)

