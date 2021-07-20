Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D213CF835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhGTKE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237373AbhGTKC0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAD8761209;
        Tue, 20 Jul 2021 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777784;
        bh=TElIdA7TU13XWaYftU7W5tzTBGWxkzWuDXvv2eTmwow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgyUhlApKRNgfbycKofJc/KXwvMSWX3ifHhWeQUxKatrrWIR+CX25gE6Po5ke6Gmg
         YlqJ9dxsKPZv/fntA57t9CP3wrTxfyGan4TCcTUGoP/4/XUCoo62orPoLYunp37dbG
         H34Py5c9JmWl/lhncJMe5fNRZfzemUEu2mCON88K0lYvV18HKaatvbiEn3TPkd2RY6
         vptTJZJL5+YdUkIZYnov6kjAUIJpQI6kwr9A+PU9tA3zTnxNyusg6Exsvl9PSHoffX
         aP0RaOZZiKqXnWG5KngWbYQkzXQz2FTEFPnZOdhedi+cMhf/Lh6ZiqUjZwHDxsIIYU
         L5LmmXmaXHHAQ==
Date:   Tue, 20 Jul 2021 13:42:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 012/138] mm: Handle per-folio private data
Message-ID: <YPaosfFeqoPpx19G@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-13-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:58AM +0100, Matthew Wilcox (Oracle) wrote:
> Add folio_get_private() which mirrors page_private() -- ie folio private
> data is the same as page private data.  The only difference is that these
> return a void * instead of an unsigned long, which matches the majority
> of users.
> 
> Turn attach_page_private() into folio_attach_private() and reimplement
> attach_page_private() as a wrapper.  No filesystem which uses page private
> data currently supports compound pages, so we're free to define the rules.
> attach_page_private() may only be called on a head page; if you want
> to add private data to a tail page, you can call set_page_private()
> directly (and shouldn't increment the page refcount!  That should be
> done when adding private data to the head page / folio).
> 
> This saves 813 bytes of text with the distro-derived config that I'm
> testing due to removing the calls to compound_head() in get_page()
> & put_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/mm_types.h | 11 +++++++++
>  include/linux/pagemap.h  | 48 ++++++++++++++++++++++++----------------
>  2 files changed, 40 insertions(+), 19 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

