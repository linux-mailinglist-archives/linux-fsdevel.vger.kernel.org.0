Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D53D0C01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhGUJGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237360AbhGUIvK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:51:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B12360E08;
        Wed, 21 Jul 2021 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626859833;
        bh=SKXjNvpvJ2ame/si0roFi8eBFQNTGfl9xkiytZdEM1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uvp2w68c1rRJ4JO3NEsHqmk9QGse8y1ty2dpAP5W2d9eQIRREKLmQfdPnn3C3Rw/E
         XA0dLOWRrut9uq6/oIVHQj2jR9imespACx4g4n+b67KCHbIkHAW0AZdafcK3EC8sgf
         8M1lCcxOnZEN284vWcnypdEeI5p4J23xFVoSG6B2QiSluIhqq1DyL+dv8NPL9tnq9t
         t4bz6ttrB65nTltbTaBHpVG2gUkq9Sz+K6eAH1pVUuvC8HyhcdX099j7oBEJQKJu4D
         x8EWLqwVVSfXRH+8ySaca7a3qoOatzhEk/UDPnbxCmSmWVDmrCQT7xAXzc9kmWrqey
         kMrugL/8LYoFg==
Date:   Wed, 21 Jul 2021 12:30:25 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 032/138] mm: Add folio_mapped()
Message-ID: <YPfpMVUBU2QWuDQz@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-33-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:18AM +0100, Matthew Wilcox (Oracle) wrote:
> This function is the equivalent of page_mapped().  It is slightly
> shorter as we do not need to handle the PageTail() case.  Reimplement
> page_mapped() as a wrapper around folio_mapped().  folio_mapped()
> is 13 bytes smaller than page_mapped(), but the page_mapped() wrapper
> is 30 bytes, for a net increase of 17 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/mm.h       |  1 +
>  include/linux/mm_types.h |  6 ++++++
>  mm/folio-compat.c        |  6 ++++++
>  mm/util.c                | 29 ++++++++++++++++-------------
>  4 files changed, 29 insertions(+), 13 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
