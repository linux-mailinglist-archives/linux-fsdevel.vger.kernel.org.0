Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF333CF839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhGTKFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbhGTKCu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:02:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5DCF6120C;
        Tue, 20 Jul 2021 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777809;
        bh=6cH5Jl0CX+wYlRijXnrox+m77wGnJ7blH2LxXxGvQ94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2SZempbeWlNxeWMltuyYTWoH59TZforrWOESpYyGT9SoZrSYJTDWSO0dvMRA9MH/
         HsRqbCheJVAF1no4QQungT2P5YzfkKS3+cbd1eoHyFpYnS+f1EzmrCB+KX9RaLufpT
         9cSuh87yjLbaNWTYSZxhIQ4jPoG5mDA4tFL0nhrdYY374Ea3HaL90wSguy5fXnKQBu
         05RuMXvuLyLSO3/tRyX7ys8OuFbJpfXaB+3kE10gK18lDyrQOWqDK3N5GjZUozZvAJ
         fC56rzKLuAfq0PgxSlBx+sLiQ+N+mFgQE5MBpbB/ULhWRNnXe4SinazkFgOEWNGj1E
         C6GFW5gx16C3w==
Date:   Tue, 20 Jul 2021 13:43:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 010/138] mm: Add folio flag manipulation functions
Message-ID: <YPaoybp9hDG+otnt@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-11-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:56AM +0100, Matthew Wilcox (Oracle) wrote:
> These new functions are the folio analogues of the various PageFlags
> functions.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio
> is not a tail page at every invocation.  This will also catch the
> PagePoisoned case as a poisoned page has every bit set, which would
> include PageTail.
> 
> This saves 1684 bytes of text with the distro-derived config that
> I'm testing due to removing a double call to compound_head() in
> PageSwapCache().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/page-flags.h | 219 ++++++++++++++++++++++++++-----------
>  1 file changed, 156 insertions(+), 63 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

