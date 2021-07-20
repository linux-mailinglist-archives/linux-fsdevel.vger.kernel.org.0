Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350483CF84B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhGTKGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236961AbhGTKFi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:05:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 036CD61208;
        Tue, 20 Jul 2021 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777977;
        bh=cVJquzikbqpsZkuMxzOmiVGse7Bj0cQ+8eBMhfsg9Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zxx34MNI9MH/cZBKH2d7s8lip8rXG0DY4DX9uI1xHpso2LXpOdc5FOIAVs4/WwIeV
         rBEJsURmnA6C+xa0CBvQa82WkBaaMJLywO6LRa5K04S4IGCHhpTRs0Z4rv3AH15Jsg
         21i5BWrNlncuydrkvOcw/nnEM1hmjLB8MWmC/R+3BOHRs3IN/K6rx/SQJ6adu1XTm6
         mvRmBKMv/rmiF9stFbyrkJCSkzowk1xuiqSurCu+W6cdJhyncZtQ1tJhHIm7wUX4NU
         k2+SCzSCW68+nNAr72WXRHQHz6jnYtpqWYRHHW+azlkx0nIIXRXaaipq8TfWL5+hFX
         Vh1etDFQMKNqg==
Date:   Tue, 20 Jul 2021 13:46:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 027/138] mm/filemap: Add folio_wait_bit()
Message-ID: <YPapcZEuV7dhVzL8@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-28-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:13AM +0100, Matthew Wilcox (Oracle) wrote:
> Rename wait_on_page_bit() to folio_wait_bit().  We must always wait on
> the folio, otherwise we won't be woken up due to the tail page hashing
> to a different bucket from the head page.
> 
> This commit shrinks the kernel by 770 bytes, mostly due to moving
> the page waitqueue lookup into folio_wait_bit_common().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h | 10 +++---
>  mm/filemap.c            | 77 +++++++++++++++++++----------------------
>  mm/page-writeback.c     |  4 +--
>  3 files changed, 43 insertions(+), 48 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
