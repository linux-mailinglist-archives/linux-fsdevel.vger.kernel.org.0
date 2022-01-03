Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFC483453
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiACPgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 10:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiACPgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:36:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE97C061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7sd73yLtLEQWYazRoKEbo6fL+jWQwJgfDIPjDDhuGTM=; b=WT0cXG6x/4ab5sMR6zMig45pQB
        rHsLtMoRCUBF7Mk8x1jX6jnEW8fmjFtSBqgjZXIzqr7baE83o4TNFkKW8MhbOZ0pMZj1OQR0URAC+
        DcnEzxyJlqrJlV8XpOQSXGY17+vNFjUo80W91gcdwaOtsBN9/Jeu3xcfbUaOMFf7QjjQ0YT9xE43z
        DuFQGu26CfUmO5tpwBK1dOQLaZXRXSK2tqnR07krueYxCarWR31QvgnJzZ020aIXUAwX7ZO+Yax77
        7lObWIcaTni4IBJo58RvnKlPqMWFk1SeCsg1ZGGPZoydPz/1CqemRMdRL7HDtp1BRdbiqWxfZXXHF
        SaVR+18w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4PO4-00CwFm-Ln; Mon, 03 Jan 2022 15:36:40 +0000
Date:   Mon, 3 Jan 2022 15:36:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 3/3] shmem: Fix "Unused swap" messages
Message-ID: <YdMYCFIHA/wtcDVV@casper.infradead.org>
References: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 05:35:50PM -0800, Hugh Dickins wrote:
> shmem_swapin_page()'s swap_free() has occasionally been generating
> "_swap_info_get: Unused swap offset entry" messages.  Usually that's
> no worse than noise; but perhaps it indicates a worse case, when we
> might there be freeing swap already reused by others.
> 
> The multi-index xas_find_conflict() loop in shmem_add_to_page_cache()
> did not allow for entry found NULL when expected to be non-NULL, so did
> not catch that race when the swap has already been freed.
> 
> The loop would not actually catch a realistic conflict which the single
> check does not catch, so revert it back to the single check.

I think what led to the loop was concern for the xa_state if trying
to find a swap entry that's smaller than the size of the folio.
So yes, the loop was expected to execute twice, but I didn't consider
the case where we were looking for something non-NULL and actually found
NULL.

So should we actually call xas_find_conflict() twice (if we're looking
for something non-NULL), and check that we get @expected, followed by
NULL?
