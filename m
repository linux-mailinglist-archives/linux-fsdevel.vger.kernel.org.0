Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D373CF84D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhGTKG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237581AbhGTKF0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:05:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F9E61186;
        Tue, 20 Jul 2021 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777964;
        bh=/O0vv21Cgn0unUo+i8YkezR6Gk++1U7Fdq0xfVx3pkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h21+U6b9EbzyiLOtuCFLg8M02NiBEj15fSC7Tt2xkk4vtd3ty3Xi+Fc8bgMg9RXUm
         5nE82yW69y8nFnKbjCBpSdkI1hgdh62C37t3U6CbJirYsNL+O/8vTkvpjOOSB0kcK+
         EfO0/R8qZraMCF0ItGGgPbjIvhr3DlrOkdBWeMq48czuGG4fY93hOF7citD1av19ab
         05tP9cBOn+q3hKSrLBeKo1rk05lQml3eTtzL9pjehbMJ1PL7Ee1QDE3gjwwj0kSAJ8
         EQb+c9tM1JxeTdDyZrKsOolArdhqPxMErGQrjVT21JNlkycGZmRcy2nm2L3KbeUoHP
         j/y6hrrx78j2A==
Date:   Tue, 20 Jul 2021 13:45:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 023/138] mm/swap: Add folio_rotate_reclaimable()
Message-ID: <YPapZeNJ34pZfJXg@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-24-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:09AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert rotate_reclaimable_page() to folio_rotate_reclaimable().  This
> eliminates all five of the calls to compound_head() in this function,
> saving 75 bytes at the cost of adding 15 bytes to its one caller,
> end_page_writeback().  We also save 36 bytes from pagevec_move_tail_fn()
> due to using folios there.  Net 96 bytes savings.
> 
> Also move its declaration to mm/internal.h as it's only used by filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/swap.h |  1 -
>  mm/filemap.c         |  3 ++-
>  mm/internal.h        |  1 +
>  mm/page_io.c         |  4 ++--
>  mm/swap.c            | 30 ++++++++++++++++--------------
>  5 files changed, 21 insertions(+), 18 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

