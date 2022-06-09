Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81915440AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 02:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiFIAxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 20:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFIAxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:53:18 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF09A4B875;
        Wed,  8 Jun 2022 17:53:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1A22E10E70BC;
        Thu,  9 Jun 2022 10:53:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nz6QD-004Mhp-7R; Thu, 09 Jun 2022 10:53:13 +1000
Date:   Thu, 9 Jun 2022 10:53:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     djwong@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2] iomap: skip pages past eof in iomap_do_writepage()
Message-ID: <20220609005313.GX227878@dread.disaster.area>
References: <20220608004228.3658429-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608004228.3658429-1-clm@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62a1447c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=aaJEA_Hj0o49BXF2jZMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:42:29PM -0700, Chris Mason wrote:
> iomap_do_writepage() sends pages past i_size through
> folio_redirty_for_writepage(), which normally isn't a problem because
> truncate and friends clean them very quickly.
> 
> When the system has cgroups configured, we can end up in situations
> where one cgroup has almost no dirty pages at all, and other cgroups
> consume the entire background dirty limit.  This is especially common in
> our XFS workloads in production because they have cgroups using O_DIRECT
> for almost all of the IO mixed in with cgroups that do more traditional
> buffered IO work.
> 
> We've hit storms where the redirty path hits millions of times in a few
> seconds, on all a single file that's only ~40 pages long.  This leads to
> long tail latencies for file writes because the pdflush workers are
> hogging the CPU from some kworkers bound to the same CPU.
> 
> Reproducing this on 5.18 was tricky because 869ae85dae ("xfs: flush new
> eof page on truncate...") ends up writing/waiting most of these dirty pages
> before truncate gets a chance to wait on them.

That commit went into 5.10, so this would mean it's not easily
reproducable on kernels released since then?

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8ce8720093b9..64d1476c457d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1482,10 +1482,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		pgoff_t end_index = isize >> PAGE_SHIFT;
>  
>  		/*
> -		 * Skip the page if it's fully outside i_size, e.g. due to a
> -		 * truncate operation that's in progress. We must redirty the
> -		 * page so that reclaim stops reclaiming it. Otherwise
> -		 * iomap_vm_releasepage() is called on it and gets confused.
> +		 * Skip the page if it's fully outside i_size, e.g.
> +		 * due to a truncate operation that's in progress.  We've
> +		 * cleaned this page and truncate will finish things off for
> +		 * us.
>  		 *
>  		 * Note that the end_index is unsigned long.  If the given
>  		 * offset is greater than 16TB on a 32-bit system then if we
> @@ -1500,7 +1500,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 */
>  		if (folio->index > end_index ||
>  		    (folio->index == end_index && poff == 0))
> -			goto redirty;
> +			goto unlock;
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

Regardless, the change looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
