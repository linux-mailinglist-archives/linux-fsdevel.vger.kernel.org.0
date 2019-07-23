Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C870DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 02:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGWADj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 20:03:39 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55849 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727643AbfGWADj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:03:39 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4C6C843B788;
        Tue, 23 Jul 2019 10:03:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hpiGA-0001mL-5I; Tue, 23 Jul 2019 10:02:26 +1000
Date:   Tue, 23 Jul 2019 10:02:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: annotate refault stalls from IO submission
Message-ID: <20190723000226.GV7777@dread.disaster.area>
References: <20190722201337.19180-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722201337.19180-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=ufHFDILaAAAA:8 a=7-415B0cAAAA:8 a=o-jcnmsilH93K4pHmdQA:9
        a=EdKfoW5OtvoDdtON:21 a=SJvZlBx9A85TV0R8:21 a=CjuIK1q_8ugA:10
        a=ZmIg1sZ3JBWsdXgziEIF:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:13:37PM -0400, Johannes Weiner wrote:
> psi tracks the time tasks wait for refaulting pages to become
> uptodate, but it does not track the time spent submitting the IO. The
> submission part can be significant if backing storage is contended or
> when cgroup throttling (io.latency) is in effect - a lot of time is
> spent in submit_bio(). In that case, we underreport memory pressure.
> 
> Annotate the submit_bio() paths (or the indirection through readpage)
> for refaults and swapin to get proper psi coverage of delays there.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/btrfs/extent_io.c | 14 ++++++++++++--
>  fs/ext4/readpage.c   |  9 +++++++++
>  fs/f2fs/data.c       |  8 ++++++++
>  fs/mpage.c           |  9 +++++++++
>  mm/filemap.c         | 20 ++++++++++++++++++++
>  mm/page_io.c         | 11 ++++++++---
>  mm/readahead.c       | 24 +++++++++++++++++++++++-
>  7 files changed, 89 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1eb671c16ff1..2d2b3239965a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -13,6 +13,7 @@
>  #include <linux/pagevec.h>
>  #include <linux/prefetch.h>
>  #include <linux/cleancache.h>
> +#include <linux/psi.h>
>  #include "extent_io.h"
>  #include "extent_map.h"
>  #include "ctree.h"
> @@ -4267,6 +4268,9 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
>  	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
>  	int nr = 0;
>  	u64 prev_em_start = (u64)-1;
> +	int ret = 0;
> +	bool refault = false;
> +	unsigned long pflags;
>  
>  	while (!list_empty(pages)) {
>  		u64 contig_end = 0;
> @@ -4281,6 +4285,10 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
>  				put_page(page);
>  				break;
>  			}
> +			if (PageWorkingset(page) && !refault) {
> +				psi_memstall_enter(&pflags);
> +				refault = true;
> +			}
>  
>  			pagepool[nr++] = page;
>  			contig_end = page_offset(page) + PAGE_SIZE - 1;
> @@ -4301,8 +4309,10 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
>  		free_extent_map(em_cached);
>  
>  	if (bio)
> -		return submit_one_bio(bio, 0, bio_flags);
> -	return 0;
> +		ret = submit_one_bio(bio, 0, bio_flags);
> +	if (refault)
> +		psi_memstall_leave(&pflags);
> +	return ret;

This all seems extremely fragile to me. Sprinkling magic,
undocumented pixie dust through the IO paths to account for
something nobody can actually determine is working correctly is a
bad idea.  People are going to break this without knowing it, nobody
is going to notice because there are no regression tests for it,
and this will all end up in frustration for users because it
constantly gets broken and doesn't work reliably.

e.g. If this is needed around all calls to ->readpage(), then please
write a readpage wrapper function and convert all the callers to use
that wrapper.

Even better: If this memstall and "refault" check is needed to
account for bio submission blocking, then page cache iteration is
the wrong place to be doing this check. It should be done entirely
in the bio code when adding pages to the bio because we'll only ever
be doing page cache read IO on page cache misses. i.e. this isn't
dependent on adding a new page to the LRU or not - if we add a new
page then we are going to be doing IO and so this does not require
magic pixie dust at the page cache iteration level

e.g. bio_add_page_memstall() can do the working set check and then
set a flag on the bio to say it contains a memstall page. Then on
submission of the bio the memstall condition can be cleared.

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com
