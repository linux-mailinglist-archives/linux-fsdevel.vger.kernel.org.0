Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D024529E15A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgJ2CAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 22:00:36 -0400
Received: from casper.infradead.org ([90.155.50.34]:44160 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgJ1Vvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KAN5MsCxB0/0ihaYJ8QP10+Ylgbrg2B5iiFQkUw7qQc=; b=d2TjJYBnkIzUkafsxl4+hketI/
        tk8fgkKTlSFl71xShwE1I1HSk++rr1qMmkfKX1VaPoTu4QRhF4xLsQT9qINE6zjJLph+S1NzZwSXR
        xSFVPhcKfH1hYd2C+wE6onDrp2LrUMLZM9VpCV1BmEM7XxXghgqfEUbvruuAt1zy8ftXH+QVznJ6J
        CPum9fbLKHPWrwteZf9NaI41x2iA0YDWFjJIQM/BP85mCFOA1gE3gBNI4XAU3CGucdbWzzUfJYMKf
        K8wUoIdBFKBAJpVL69vhBuitKhP3/gsZEDG9KzSDVMzd5pKp9+0yah09Bd6PyAMQl+n1GZp+Ea2sN
        ThS6LgEg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmXC-0004OX-Qz; Wed, 28 Oct 2020 14:34:42 +0000
Date:   Wed, 28 Oct 2020 14:34:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, kernel test robot <lkp@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K
 pages
Message-ID: <20201028143442.GA20115@casper.infradead.org>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
 <160389426655.300137.17487677797144804730.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160389426655.300137.17487677797144804730.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:11:06PM +0000, David Howells wrote:
> +static inline unsigned int afs_page_dirty_resolution(void)

I've been using size_t for offsets within a struct page.  I don't know
that we'll ever support pages larger than 2GB (they're completely
impractical with today's bus speeds), but I'd rather not be the one
who has to track down all the uses of 'int' in the kernel in fifteen
years time.

> +{
> +	if (PAGE_SIZE - 1 <= __AFS_PAGE_PRIV_MASK)
> +		return 1;
> +	else
> +		return PAGE_SIZE / (__AFS_PAGE_PRIV_MASK + 1);

Could this be DIV_ROUND_UP(PAGE_SIZE, __AFS_PAGE_PRIV_MASK + 1); avoiding
a conditional?  I appreciate it's calculated at compile time today, but
it'll be dynamic with THP.

>  static inline unsigned int afs_page_dirty_to(unsigned long priv)
>  {
> -	return ((priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK) + 1;
> +	unsigned int x = (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
> +
> +	/* The upper bound is exclusive */

I think you mean 'inclusive'.

> +	return (x + 1) * afs_page_dirty_resolution();
>  }
>  
>  static inline unsigned long afs_page_dirty(unsigned int from, unsigned int to)
>  {
> +	unsigned int res = afs_page_dirty_resolution();
> +	from /= res; /* Round down */
> +	to = (to + res - 1) / res; /* Round up */
>  	return ((unsigned long)(to - 1) << __AFS_PAGE_PRIV_SHIFT) | from;

Wouldn't it produce the same result to just round down?  ie:

	to = (to - 1) / res;
	return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;

