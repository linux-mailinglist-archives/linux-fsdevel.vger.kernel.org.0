Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C02C2B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgKXPjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389795AbgKXPjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:39:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6FC0613D6;
        Tue, 24 Nov 2020 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SLTr7gkogpE89SCBqk7FGHjrc8WhupZCrsw5gAPvAgs=; b=u974TdaeuqLYVbQHjVb5RtODQa
        lp/+o73306/8RYVtwzBmiQq7A6Y2DF5ll+prf+lj5hXOuJSAU34957L/R5qaCEPMh1XkdkZ8FNRBl
        2Zq5Il5MaDJhFBDvvkKfp5VEJ4z7O7IB/cWQxZSFyrru+GlhqZMj6RWSyoyEyNOvOjhdO/lBXBDQD
        oEYiivABA6GsBr2Ln7cGRjMlbprmty9uQOzjyBZXvAijjEYT7NvmmZ8wCmtNLTprN5htEOQqQFRsL
        O+XliY7CiJW76kDlDMImr6kpP+z3thiAaxKMPIrJNVoQPQmlciMZE4Fa88+i+qN4rRYn69HOOgkAQ
        6X3UIkKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khaPQ-0007vF-TP; Tue, 24 Nov 2020 15:39:13 +0000
Date:   Tue, 24 Nov 2020 15:39:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@redhat.com,
        Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-ID: <20201124153912.GC4327@casper.infradead.org>
References: <cover.1606194703.git.cgoldswo@codeaurora.org>
 <1fe5d53722407a2651eeeada3a422c117041bf1d.1606194703.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe5d53722407a2651eeeada3a422c117041bf1d.1606194703.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:49:38PM -0800, Chris Goldsworthy wrote:
> +static void __evict_bh_lru(void *arg)
> +{
> +	struct bh_lru *b = &get_cpu_var(bh_lrus);
> +	struct buffer_head *bh = arg;
> +	int i;
> +
> +	for (i = 0; i < BH_LRU_SIZE; i++) {
> +		if (b->bhs[i] == bh) {
> +			brelse(b->bhs[i]);
> +			b->bhs[i] = NULL;
> +			goto out;

That's an odd way to spell 'break' ...

> +		}
> +	}
> +out:
> +	put_cpu_var(bh_lrus);
> +}

...

> @@ -3245,8 +3281,15 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
>  
>  	bh = head;
>  	do {
> -		if (buffer_busy(bh))
> -			goto failed;
> +		if (buffer_busy(bh)) {
> +			/*
> +			 * Check if the busy failure was due to an
> +			 * outstanding LRU reference
> +			 */
> +			evict_bh_lrus(bh);
> +			if (buffer_busy(bh))
> +				goto failed;

Do you see any performance problems with this?  I'm concerned that we
need to call all CPUs for each buffer on a page, so with a 4kB page
and 512-byte block, we'd call each CPU eight times (with a 64kB page
size and 4kB page, we'd call each CPU 16 times!).  We might be better
off just calling invalidate_bh_lrus() -- we'd flush the entire LRU,
but we'd only need to do it once, not once per buffer head.

We could have a more complex 'evict' that iterates each busy buffer on a
page so transforming:

for_each_buffer
	for_each_cpu
		for_each_lru_entry

to:

for_each_cpu
	for_each_buffer
		for_each_lru_entry

(and i suggest that way because it's more expensive to iterate the buffers
than it is to iterate the lru entries)
