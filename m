Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC268B1CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 22:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBEVKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 16:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEVKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:10:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF8E12052;
        Sun,  5 Feb 2023 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=otjeEFo/SDJToXrP0LWWRoXxWKYoByEB8N3Ut6KbeGU=; b=hg1CiB1bNbDtMRqV/PYwPFWrzf
        L36wNFSyuAFrSIWrSOst1aZZsGviFsa70ohYRuU7LlMlvPMY8SiQeloqQmv/9rnuP+9HD98XjZ+Lv
        7akP1v+IpS/FYxJQZ2fdC5e8zMTbrhXXl7J4JBNPSDJ9HQYAEn2e/6so29jfGi9TemSvaSMu+SYGe
        d/awv55Pfb+LOGOg+soKrCQVauDYA+qalJt5E5sRZe6EIJEE5Kgmq5UmfSo+eUzyBvbkHyGP/mwuN
        h4pnkPyfgA7cDB512ZkeP8Oh20wPcfq9Vn9deNUfnYe80oiyTL2WoPEYt9A58aDkyrNwqgvgPvj/g
        FP4BSXFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOmHZ-00GE5v-BO; Sun, 05 Feb 2023 21:10:41 +0000
Date:   Sun, 5 Feb 2023 21:10:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <Y+AbUZoj7hLobLXK@casper.infradead.org>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1675522718-88-4-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675522718-88-4-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:58:38PM +0000, Shiyang Ruan wrote:
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		down_write(&mp->m_super->s_umount);
> +		error = sync_filesystem(mp->m_super);
> +		/* invalidate_inode_pages2() invalidates dax mapping */
> +		super_drop_pagecache(mp->m_super, invalidate_inode_pages2);

OK, there's a better way to handle all of this.

First, an essentially untyped interface with a void * argument is
bad.  Second, we can do all this with invalidate_inode_pages2_range()
and invalidate_mapping_pages() without introducing a new function.

Here's the proposal:

void super_drop_pagecache(struct super_block *sb,
		int (*invalidate)(struct address_space *, pgoff_t start, pgoff_t end))

In fs/drop-caches.c:

static void drop_pagecache_sb(struct super_block *sb, void *unused)
{
	super_drop_pagecache(sb, invalidate_mapping_pages);
}

In XFS:

		super_drop_pagecache(mp->m_super,
				invalidate_inode_pages2_range);

Much smaller change ...
