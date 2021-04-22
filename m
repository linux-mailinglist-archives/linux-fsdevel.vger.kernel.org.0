Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8773676B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 03:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhDVBSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 21:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhDVBSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:18:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B750C06174A;
        Wed, 21 Apr 2021 18:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+y6x2KmR9DmMzgd0umtxzcK+z2fQYDMGZRmfOOmeeOk=; b=Q2bBEcMjl6hxoF++IHEUTUHMg5
        S/EbsDe3Cmp4JGvsvBpRVn56BGW//MdYalQ7MSo3oTEuqUYY5zvHiz9vwLTTlD61OgbO5xak4KBSr
        rrbRjOb6SSNoTCwvzc3VmMJTMbE78D3RnmCwRrvwbR2XhnRQ4TPq6V6Vp6Gymlsu/Qb/DcqkUxlFA
        Ofvef2GT2PyTMhk8VRwCzEqtoxBYAQWdzyt/negf/nShmy6+E4do8X/tdaDJ5edQe6XjYvQh2fduh
        zAbym0tbkph7tdoxD5F6DR+Zk8UFH1Z5I9aHewiT522mk5ycWKIoSCIE/ME9dhefUG3dwdPmUpePE
        Jw1+iaYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZNxH-00HGun-AD; Thu, 22 Apr 2021 01:16:41 +0000
Date:   Thu, 22 Apr 2021 02:16:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
Message-ID: <20210422011631.GL3596236@casper.infradead.org>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
 <alpine.LSU.2.11.2104211737410.3299@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104211737410.3299@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:39:14PM -0700, Hugh Dickins wrote:
> No problem on 64-bit without huge pages, but xfstests generic/285
> and other SEEK_HOLE/SEEK_DATA tests have regressed on huge tmpfs,
> and on 32-bit architectures, with the new mapping_seek_hole_data().
> Several different bugs turned out to need fixing.
> 
> u64 casts added to stop unfortunate sign-extension when shifting
> (and let's use shifts throughout, rather than mixed with * and /).

That confuses me.  loff_t is a signed long long, but it can't be negative
(... right?)  So how does casting it to an u64 before dividing by
PAGE_SIZE help?

> Use round_up() when advancing pos, to stop assuming that pos was
> already THP-aligned when advancing it by THP-size.  (But I believe
> this use of round_up() assumes that any THP must be THP-aligned:
> true while tmpfs enforces that alignment, and is the only fs with
> FS_THP_SUPPORT; but might need to be generalized in the future?
> If I try to generalize it right now, I'm sure to get it wrong!)

No generalisation needed in future.  Folios must be naturally aligned
within a file.

> @@ -2681,7 +2681,8 @@ loff_t mapping_seek_hole_data(struct add
>  
>  	rcu_read_lock();
>  	while ((page = find_get_entry(&xas, max, XA_PRESENT))) {
> -		loff_t pos = xas.xa_index * PAGE_SIZE;
> +		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
> +		unsigned int seek_size;

I've been preferring size_t for 'number of bytes in a page' because
I'm sure somebody is going to want a page larger than 2GB in the next
ten years.

