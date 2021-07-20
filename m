Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6E3CF84F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbhGTKGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237447AbhGTKGD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:06:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C43E461209;
        Tue, 20 Jul 2021 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626778001;
        bh=NuneWne0eQvjMARQjeOYZk+gZrvufDCaE2mhrY1ue3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbdgA6+HDrWQrdQzD/rHtgkdVnOxD5g5BKgW6IZMPket9lGlWK5TX18bTlEDVON0d
         JeyofqlLAiaYOjDdhzioXo8Ssp1I+4Iq/a6bPXv+tqECKtIrvjp9PA+wS7YLC5lQcV
         mhgEn/FzuQiPg3BC/YSN/7GK/P/bt4boUl1Fd8P5Exyj+Ei8uJm6a9fQGZ42AddIgs
         kCmNrfas3YHo6XS5BznMXYo3XUITmTc8G8T5SG+Is2ZL15tpA/uDcv+XCdy3hR02h7
         /7/LcOLY4OkKvOLdt6uzKu1LEb9Yxv0NaV4YK/IC1IVrAmi6kdJv9ok/Ce0R0XfEZP
         EwQZE+FNkG7PQ==
Date:   Tue, 20 Jul 2021 13:46:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 025/138] mm/writeback: Add folio_wait_writeback()
Message-ID: <YPapireXNIZmin9E@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-26-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:11AM +0100, Matthew Wilcox (Oracle) wrote:
> wait_on_page_writeback_killable() only has one caller, so convert it to
> call folio_wait_writeback_killable().  For the wait_on_page_writeback()
> callers, add a compatibility wrapper around folio_wait_writeback().
> 
> Turning PageWriteback() into folio_test_writeback() eliminates a call
> to compound_head() which saves 8 bytes and 15 bytes in the two
> functions.  Unfortunately, that is more than offset by adding the
> wait_on_page_writeback compatibility wrapper for a net increase in text
> of 7 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/afs/write.c          |  9 ++++----
>  include/linux/pagemap.h |  3 ++-
>  mm/folio-compat.c       |  6 ++++++
>  mm/page-writeback.c     | 48 ++++++++++++++++++++++++++++-------------
>  4 files changed, 46 insertions(+), 20 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
