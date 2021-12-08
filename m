Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9416D46D8BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbhLHQqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 11:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhLHQqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:46:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B89CC061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Dec 2021 08:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=unVsL4/B8c5q3qCPRGdOxHvlVKh2YxxO1irX6dLbbto=; b=Qg1Xw6qoSKh1r1mwxFjdllNQUz
        RHBv0sALyvj8m3+m6R4YPZ3FBy0APnL8q7y4YOAXtU2bvhx+foObC3VCGQ2HU0lwkdHr6sm/IXwpP
        yYUuIFpuP5IqQbDTnjBHxswbJGb9VxaXo5TF2LzWDyalB+wdVfCZEuESfvKtxsrsTlamxRo8t1yOj
        VJJCWTr8j+lLNxTlvMbesG5s8Wac9iw0gsWAaTl/rv4QPmVk9RO2Y+JwWbQ+UbmuiFJL7SQsYoLN/
        EqZeKn71UBv2mIGZWbD3UHcQL3wIQhihlLksAl5AX1LN3807J48rry/ohiKODn5wPR0BYAsRWeOat
        Vff+yXyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv021-008akh-9e; Wed, 08 Dec 2021 16:43:01 +0000
Date:   Wed, 8 Dec 2021 16:43:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 46/48] truncate,shmem: Handle truncates that split large
 folios
Message-ID: <YbDglV215QdqpXZ+@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-47-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-47-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:54AM +0000, Matthew Wilcox (Oracle) wrote:
> @@ -917,13 +904,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
> -	unsigned int partial_start = lstart & (PAGE_SIZE - 1);
> -	unsigned int partial_end = (lend + 1) & (PAGE_SIZE - 1);
>  	struct folio_batch fbatch;
>  	pgoff_t indices[PAGEVEC_SIZE];
> +	struct folio *folio;

This turns a couple of other definitions of struct folio in this
function into shadowed definitions.  We don't have -Wshadow turned
on, so I didn't notice until doing more patch review this morning.
I'm going to fold in this patch:

+++ b/mm/shmem.c
@@ -919,7 +919,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
        while (index < end && find_lock_entries(mapping, index, end - 1,
                        &fbatch, indices)) {
                for (i = 0; i < folio_batch_count(&fbatch); i++) {
-                       struct folio *folio = fbatch.folios[i];
+                       folio = fbatch.folios[i];

                        index = indices[i];

@@ -985,7 +985,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
                        continue;
                }
                for (i = 0; i < folio_batch_count(&fbatch); i++) {
-                       struct folio *folio = fbatch.folios[i];
+                       folio = fbatch.folios[i];

                        index = indices[i];
                        if (xa_is_value(folio)) {

