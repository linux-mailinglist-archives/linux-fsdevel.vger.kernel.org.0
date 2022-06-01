Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C553A4B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbiFAMSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 08:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbiFAMSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:18:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4215D5CC;
        Wed,  1 Jun 2022 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g8FVAL5R+OVZFW0X+arv2MOpnNnrIY+mq+TEzocA8+M=; b=U2jvK8cW8xz8WfMjngKCBR+3lZ
        oFNSSU1gDzN+LCScEhZoebQzCHr2FkjUL4r57ksv/B4/J2sS6W2LIvbjx3rNjTp0nY3frSUNPnRBT
        PlPgTvI+82d//SuZGQ2s7zSZvQfivYRWjc12Oz+o0xjseTFwlLweWIViSRtwW2Ws9UEy3M4rHV0o8
        v9E5DILAfyTO4Y74mbn+u3J5COAj6ALLzQH4b4qQiRj59S+dJU/CmlW9OzUJBzXcSxLL+3QtRN9Of
        WW3wGmSHhU1PwreBPRE/29xL/ktrIQpQOATQwKn/GMQFArXTwmDp+aNbh7m6omgHSzXeGIzGMl3uH
        C/B7rFnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwNJJ-00G16s-1r; Wed, 01 Jun 2022 12:18:49 +0000
Date:   Wed, 1 Jun 2022 05:18:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     djwong@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        dchinner@redhat.com
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <YpdZKbrtXJJ9mWL7@infradead.org>
References: <20220601011116.495988-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601011116.495988-1-clm@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This does look sane to me.  How much testing did this get?  Especially
for the block size < page sie case?  Also adding Dave as he has spent
a lot of time on this code.

On Tue, May 31, 2022 at 06:11:17PM -0700, Chris Mason wrote:
> iomap_do_writepage() sends pages past i_size through
> folio_redirty_for_writepage(), which normally isn't a problem because
> truncate and friends clean them very quickly.
> 
> When the system a variety of cgroups,

^^^ This sentence does not parse ^^^

> we can end up in situations where
> one cgroup has almost no dirty pages at all.  This is especially common
> in our XFS workloads in production because they tend to use O_DIRECT for
> everything.
> 
> We've hit storms where the redirty path hits millions of times in a few
> seconds, on all a single file that's only ~40 pages long.  This ends up
> leading to long tail latencies for file writes because the page reclaim
> workers are hogging the CPU from some kworkers bound to the same CPU.
> 
> That's the theory anyway.  We know the storms exist, but the tail
> latencies are so sporadic that it's hard to have any certainty about the
> cause without patching a large number of boxes.
> 
> There are a few different problems here.  First is just that I don't
> understand how invalidating the page instead of redirtying might upset
> the rest of the iomap/xfs world.  Btrfs invalidates in this case, which
> seems like the right thing to me, but we all have slightly different
> sharp corners in the truncate path so I thought I'd ask for comments.
> 
> Second is the VM should take wbc->pages_skipped into account, or use
> some other way to avoid looping over and over.  I think we actually want
> both but I wanted to understand the page invalidation path first.
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> Reported-by: Domas Mituzas <domas@fb.com>
> ---
>  fs/iomap/buffered-io.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8ce8720093b9..4a687a2a9ed9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1482,10 +1482,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		pgoff_t end_index = isize >> PAGE_SHIFT;
>  
>  		/*
> -		 * Skip the page if it's fully outside i_size, e.g. due to a
> -		 * truncate operation that's in progress. We must redirty the
> -		 * page so that reclaim stops reclaiming it. Otherwise
> -		 * iomap_vm_releasepage() is called on it and gets confused.
> +		 * invalidate the page if it's fully outside i_size, e.g.
> +		 * due to a truncate operation that's in progress.
>  		 *
>  		 * Note that the end_index is unsigned long.  If the given
>  		 * offset is greater than 16TB on a 32-bit system then if we
> @@ -1499,8 +1497,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * offset is just equal to the EOF.
>  		 */
>  		if (folio->index > end_index ||
> -		    (folio->index == end_index && poff == 0))
> -			goto redirty;
> +		    (folio->index == end_index && poff == 0)) {
> +			folio_invalidate(folio, 0, folio_size(folio));
> +			goto unlock;
> +		}
>  
>  		/*
>  		 * The page straddles i_size.  It must be zeroed out on each
> @@ -1518,6 +1518,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  
>  redirty:
>  	folio_redirty_for_writepage(wbc, folio);
> +unlock:
>  	folio_unlock(folio);
>  	return 0;
>  }
> -- 
> 2.30.2
> 
---end quoted text---
