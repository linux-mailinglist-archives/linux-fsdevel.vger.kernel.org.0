Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6D4E2AC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349242AbiCUObD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349417AbiCUOaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:30:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A402B24B;
        Mon, 21 Mar 2022 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q2baNzMLIXfSGSiUmbqX3eLXrnYx71EZPdk4mLBGa7c=; b=G51pkFK/0LvtxH3jQVMGNb9cjr
        X3DGF1Rlnqj8lTf5AaDGuw8eN3ttTz1lumhhA6ojURBAIiR9RlI4JWC5dzqIh43hY2X9i2CxX2sn4
        7sNnz+n7LWGPiP0TIhhoPg58eBXsgYVauXw3fjjuIncQxXdishY+6W1Ez3f87f1OrlEY/Z6Z08dQF
        g9ZMaK4Bo0fFlZZ1ovtiS1WEJdl/xwFwjfEN7KEWS2opZVsMxRpEnor6XzBw57mpkQZGB0px+sEOx
        MDp5mGP1ch3ZqNzKMEM7TgggQum7c1BgZ4okLyGpGZh0xECpYegoJoJp0W6p7V+Kxe/euOVIExhrV
        hC4v3n0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWIz2-00AeF9-B8; Mon, 21 Mar 2022 14:26:08 +0000
Date:   Mon, 21 Mar 2022 14:26:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjiLACenpRV4XTcs@casper.infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:08:47PM +0800, JeffleXu wrote:
> reqs_lock is also used to protect the check of cache->flags. Please
> refer to patch 4 [1] of this patchset.

Yes, that's exactly what I meant by "bad idea".

> ```
> +	/*
> +	 * Enqueue the pending request.
> +	 *
> +	 * Stop enqueuing the request when daemon is dying. So we need to
> +	 * 1) check cache state, and 2) enqueue request if cache is alive.
> +	 *
> +	 * The above two ops need to be atomic as a whole. @reqs_lock is used
> +	 * here to ensure that. Otherwise, request may be enqueued after xarray
> +	 * has been flushed, in which case the orphan request will never be
> +	 * completed and thus netfs will hang there forever.
> +	 */
> +	read_lock(&cache->reqs_lock);
> +
> +	/* recheck dead state under lock */
> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		read_unlock(&cache->reqs_lock);
> +		ret = -EIO;
> +		goto out;
> +	}

So this is an error path.  We're almost always going to take the xa_lock
immediately after taking the read_lock.  In other words, you've done two
atomic operations instead of one.

> +	xa_lock(xa);
> +	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
> +	if (!ret)
> +		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
> +	xa_unlock(xa);
> +
> +	read_unlock(&cache->reqs_lock);
> ```
> 
> It's mainly used to protect against the xarray flush.
> 
> Besides, IMHO read-write lock shall be more performance friendly, since
> most cases are the read side.

That's almost never true.  rwlocks are usually a bad idea because you
still have to bounce the cacheline, so you replace lock contention
(which you can see) with cacheline contention (which is harder to
measure).  And then you have questions about reader/writer fairness
(should new readers queue behind a writer if there's one waiting, or
should a steady stream of readers be able to hold a writer off
indefinitely?)
