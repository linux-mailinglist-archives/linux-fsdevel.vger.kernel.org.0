Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C368AF98
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 12:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBELvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 06:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBELvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:51:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187720D0F;
        Sun,  5 Feb 2023 03:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3gbpxE81nqEN5LIygYkPi/oBuXUyCIhUuArjW1ldGIE=; b=daogPHFeFlcPdXUq2O0cCo4ZxN
        E9/Zc/FBn9Z7QxFWGf7S9lPsy9gBq+d6/l64ENYUQ0nKTmvI7e9dFG3FAWLynNMGVSy0WbS7vp0ht
        VjuHHf76ZCu0YMoQrG77gnAHheousfZ2xPQyEhtP7eyIL/+z9erC23t26NFow5NGFgRRM7XFt6F+u
        T+H384g8N3YLzesb2IGoD7teOt1dA6dP/Bh+X4WHtI8UUqgygOOrcnD5HqV0iakSGoVcIDe0H04jR
        mKHRuKzAs3o1MVS9WSEWAt8kAA0F/mgItMJDhv494hn+BgZTcma0RPYKSFPq6y5XShYY44BSOPWHZ
        7JUZnW2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOdYf-00FswH-FE; Sun, 05 Feb 2023 11:51:45 +0000
Date:   Sun, 5 Feb 2023 11:51:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 2/3] fs: move drop_pagecache_sb() for others to use
Message-ID: <Y9+YUWUdMPKnJpyq@casper.infradead.org>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1675522718-88-3-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675522718-88-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:58:37PM +0000, Shiyang Ruan wrote:
> @@ -678,6 +679,48 @@ void drop_super_exclusive(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(drop_super_exclusive);
>  
> +/*

You've gone to the trouble of writing kernel-doc, just add the extra '*'
and make it actually part of the documentation!

> + *	super_drop_pagecache - drop all page caches of a filesystem
> + *	@sb: superblock to invalidate
> + *	@arg: invalidate method, such as invalidate_inode_pages(),
> + *	        invalidate_inode_pages2()
> + *
> + *	Scans the inodes of a filesystem, drop all page caches.
> + */

> +++ b/include/linux/fs.h
> @@ -3308,6 +3308,7 @@ extern struct super_block *get_super(struct block_device *);
>  extern struct super_block *get_active_super(struct block_device *bdev);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
> +void super_drop_pagecache(struct super_block *sb, void *unused);

But the arg isn't unused.  Call it 'invalidator' here.

> +/**
> + * invalidate_inode_pages - Invalidate all clean, unlocked cache of one inode
> + * @mapping: the address_space which holds the cache to invalidate
> + *
> + * This function removes all pages that are clean, unmapped and unlocked,
> + * as well as shadow entries. It will not block on IO activity.
> + */
> +int invalidate_inode_pages(struct address_space *mapping)
> +{
> +	invalidate_mapping_pages(mapping, 0, -1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(invalidate_inode_pages);

I might make this a static function in super.c but maybe you need it
in the next patch.
