Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97177951A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHKQt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjHKQtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:49:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C82D78;
        Fri, 11 Aug 2023 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oUhqXwPiOWFNveyUDU+xr0z5RJ8d81Aju54m/CW4sYA=; b=TNuHSPOWgjVZsykDgsIiVM1BeH
        bL6bJ5C0ys31kNb4mswLrnD7zu36A2jG46vo23W/Qw28W3/rPGkR8CRsTKMJIs3sIeMUL4vOaHIYe
        2zRPFj2FXp2wHynclnABrKhsRl6HBYw9N8YRweReefT3mL6RBRx7qxpty0SSoRUvqCvSBUEWLhCcl
        wcwle+riWfXEHCndx7a8j8vqgyJSTHO8+zfzotrh4/zWZndKo68MJsR8PR1bVOYFKPsSFu80aYW8U
        qhSZzaH3YRwVir8tEG7IvRKeM4qKErs7oYSal37Sp+QEySCzx96Myp6M1jUAcVczoLS2NuW7SlfIp
        BiDQMbcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUVKI-002FqJ-CR; Fri, 11 Aug 2023 16:49:26 +0000
Date:   Fri, 11 Aug 2023 17:49:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org, jack@suse.cz,
        yi.zhang@huawei.com, hare@suse.de, p.raghav@samsung.com,
        ritesh.list@gmail.com, mpatocka@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, teawater@antgroup.com,
        teawater@gmail.com
Subject: Re: [PATCH] ext4_sb_breadahead_unmovable: Change to be no-blocking
Message-ID: <ZNZmlhQ1zW4vdTFK@casper.infradead.org>
References: <20230811071519.1094-1-teawaterz@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811071519.1094-1-teawaterz@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:15:19AM +0000, Hui Zhu wrote:
> From: Hui Zhu <teawater@antgroup.com>
> 
> This version fix the gfp flags in the callers instead of working this
> new "bool" flag through the buffer head layers according to the comments
> from Matthew Wilcox.

FYI, this paragraph should have been below the --- so it gets excluded
from the commit log.

> Meanwhile, it was observed that the task holding the ext4 journal lock
> was blocked for an extended period of time on "shrink_page_list" due to
> "ext4_sb_breadahead_unmovable".
> 0 [] __schedule at xxxxxxxxxxxxxxx
> 1 [] _cond_resched at xxxxxxxxxxxxxxx
> 2 [] shrink_page_list at xxxxxxxxxxxxxxx
> 3 [] shrink_inactive_list at xxxxxxxxxxxxxxx
> 4 [] shrink_lruvec at xxxxxxxxxxxxxxx
> 5 [] shrink_node_memcgs at xxxxxxxxxxxxxxx
> 6 [] shrink_node at xxxxxxxxxxxxxxx
> 7 [] shrink_zones at xxxxxxxxxxxxxxx
> 8 [] do_try_to_free_pages at xxxxxxxxxxxxxxx
> 9 [] try_to_free_mem_cgroup_pages at xxxxxxxxxxxxxxx
> 10 [] try_charge at xxxxxxxxxxxxxxx
> 11 [] mem_cgroup_charge at xxxxxxxxxxxxxxx
> 12 [] __add_to_page_cache_locked at xxxxxxxxxxxxxxx
> 13 [] add_to_page_cache_lru at xxxxxxxxxxxxxxx
> 14 [] pagecache_get_page at xxxxxxxxxxxxxxx
> 15 [] grow_dev_page at xxxxxxxxxxxxxxx

After applying your patch, we'd still get into trouble with
folio_alloc_buffers() also specifying __GFP_NOWAIT.  So I decided
to pass the GFP flags into folio_alloc_buffers() -- see the patch
series I just sent out.

> @@ -1050,18 +1051,27 @@ grow_dev_page(struct block_device *bdev, sector_t block,
>  	int ret = 0;
>  	gfp_t gfp_mask;
>  
> -	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
> +	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS);
> +	if (gfp == ~__GFP_DIRECT_RECLAIM)
> +		gfp_mask &= ~__GFP_DIRECT_RECLAIM;

This isn't how we normally use gfp_mask.  OTOH, how buffer.c uses GFP
masks is also a bit weird.  The bdev_getblk() I just added is more
normal.

Please try the patchset I cc'd you on (with the __GFP_ACCOUNT added);
I'm currently running it through xfstests and it's holding up fine.
I suppose I should play around with memcgs to try to make it happen a
bit more often.
