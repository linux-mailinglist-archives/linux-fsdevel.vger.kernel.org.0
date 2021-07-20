Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8123CF81D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhGTKBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237524AbhGTKAy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:00:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A58161165;
        Tue, 20 Jul 2021 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777688;
        bh=yEsKWSjIDeG5CYGsxYSfoyolXUgGMddSmWQesyZ8Rmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjTzdqh+lFCzldzGa4JyDiq3MKIfE4yqdhh1SblhWV2Al1xZT8cr6K+caVmTgBMWE
         knSC7+kc1UPon9e25FX4yL9H6uNmm4hiBbhyEGlBoVE8VUl9hOZxjPpE+QK6HDMO5M
         bJq+JDUzajyHyV0T4gho2RsuEm6VfQztUZmeX5ihQHk0HzXqbNkJhZ9HYKAdhKN63u
         FJM3kAX4whqBLcZKjwh29crwhenYPzrmZliew5hJjcaRF0j9uXkE9L/7l+MYSQd2m0
         uJBxi4o59Ay5j5rNJi2wGBjMi4bh5CxFKJmpB/6pSTowZ92O5wa7jJgf+avOH+z2A2
         ldPpJ77IUcrqg==
Date:   Tue, 20 Jul 2021 13:41:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 007/138] mm: Add folio_put()
Message-ID: <YPaoUPOMsTSByJF/@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-8-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:53AM +0100, Matthew Wilcox (Oracle) wrote:
> If we know we have a folio, we can call folio_put() instead of put_page()
> and save the overhead of calling compound_head().  Also skips the
> devmap checks.
> 
> This commit looks like it should be a no-op, but actually saves 684 bytes
> of text with the distro-derived config that I'm testing.  Some functions
> grow a little while others shrink.  I presume the compiler is making
> different inlining decisions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/mm.h | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

