Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA13CC3FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhGQPFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbhGQPFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:05:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D65C0613DD;
        Sat, 17 Jul 2021 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Xw1VcuTjgZ49t25zIRxicvryRU564jX2lY4pUY5o3A=; b=RyqOFqwmgDZXOtufkLpg6oCwEA
        juLFgW5sohegVkvt2PoNEwetF9INUp/TQwEtIfRYrlmd857WmaWVYc/IvC4oU+AGgmehR1Ggw3FPX
        nnU6+802ktykPsc9EROMcYW2QcUASskCnC+CDixXS6EPaGr6N+81kHUzTMRoPbAXNSk2FJtQY5vdA
        Qz1Ld4JR5SDFJFqKSyutbJYAhNP0sfjdT3Jyo6vM0jkv+WSGOjPg/xz3hk3X80TWCVjE+13HzSmFX
        35qCT05yvpyQP8eLxR9prjIxoAxDWrf7h0mgtqdWrBvhMZ+Ant9h/e4UHRg7gmD8ZgcIk4iOVmjSU
        e4dvHlRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4low-005LrJ-Da; Sat, 17 Jul 2021 15:01:49 +0000
Date:   Sat, 17 Jul 2021 16:01:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPLw0uc1jVKI8uKo@casper.infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 09:38:18PM +0800, Gao Xiang wrote:
> Sorry about some late. I've revised a version based on Christoph's
> version and Matthew's thought above. I've preliminary checked with
> EROFS, if it does make sense, please kindly help check on the gfs2
> side as well..

I don't understand how this bit works:

>  	struct page *page = ctx->cur_page;
> -	struct iomap_page *iop;
> +	struct iomap_page *iop = NULL;
>  	bool same_page = false, is_contig = false;
>  	loff_t orig_pos = pos;
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> +	if (iomap->type == IOMAP_INLINE && !pos)
> +		WARN_ON_ONCE(to_iomap_page(page) != NULL);
> +	else
> +		iop = iomap_page_create(inode, page);

Imagine you have a file with bytes 0-2047 in an extent which is !INLINE
and bytes 2048-2051 in the INLINE extent.  When you read the page, first
you create an iop for the !INLINE extent.  Then this function is called
again for the INLINE extent and you'll hit the WARN_ON_ONCE.  No?

