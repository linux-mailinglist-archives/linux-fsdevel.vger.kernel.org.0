Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A333D3CF83C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhGTKFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhGTKEh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 898946120C;
        Tue, 20 Jul 2021 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777916;
        bh=WQWoajTP6/cp5PISTAolW0ntDNq1tPHYptl5Y2TWjSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxGN88tsuN08tzzqyQo2na45Fa8BsYObr5J9ROPhX6NmUIR/HRayXKVe3xHUCUTbm
         uEUPBk1yhhFnuN74BlM+nkl1U/Ctv0aJAPJ5z1Cahs5Q5Ar7AuXUpFKSMlt43MtqP3
         vlG0S5KsdjCuCfG4oPJJmJk6ENeK8D8bjz36AINUZNUtXTwBuuDWjp2IOA2bQ/VItG
         cVhv2UhGpXTUP0m8Fg0DS8xY1lnz/zAzVFjGIphcAaNYVxptyu6zcBJ949aweGXucO
         4nErJUD6ixNhHo9wR6DkhtvH7uxPz3u5hy3a+++rpFAhochfS3PkMLvX/G77bna0Fp
         NDELd6HayXtIA==
Date:   Tue, 20 Jul 2021 13:45:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 020/138] mm/filemap: Add __folio_lock_async()
Message-ID: <YPapM+LWhC7QKxsj@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-21-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:06AM +0100, Matthew Wilcox (Oracle) wrote:
> There aren't any actual callers of lock_page_async(), so remove it.
> Convert filemap_update_page() to call __folio_lock_async().
> 
> __folio_lock_async() is 21 bytes smaller than __lock_page_async(),
> but the real savings come from using a folio in filemap_update_page(),
> shrinking it from 515 bytes to 404 bytes, saving 110 bytes.  The text
> shrinks by 132 bytes in total.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  fs/io_uring.c           |  2 +-
>  include/linux/pagemap.h | 17 -----------------
>  mm/filemap.c            | 31 ++++++++++++++++---------------
>  3 files changed, 17 insertions(+), 33 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

