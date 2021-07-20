Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1453CF83A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhGTKFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237050AbhGTKEt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C011561221;
        Tue, 20 Jul 2021 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777928;
        bh=AoiepgxEITyIJRI5qaMn5CqtGrZnv94SEd8njH1wOHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLDKq/7Qy1ARgF8QTIrfXYPTCI2BJ98d3nHYQ/TmYVBNHNO+Ao7hzO15JQspO/B38
         hJc4mtlw5HkBLeesli974ynw5Lp8jxuYtPiLMHmU+hpnbk9mO8R2u978fwAyFmKVn4
         8V56bCtzQBQ5rD3Xp/Eg7FqBc/FsKLuIImD0Ggk9V4n+qZ60ziinlm4/EFqJfNdoM1
         EPEGKo3z/15A0zAIZddR5DbnBoldjVUIAwBiUXCbEQkhMCrt1/d6r73pZgpn2nx1zQ
         k633OgX8RccMVDxQDxdHM5/dXTaEjpKoUmTL2SkYcmpfP6G1dJDxWIR7kI5buXy/Dv
         ZXsfiC6Sk9Lkw==
Date:   Tue, 20 Jul 2021 13:45:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 022/138] mm/filemap: Add __folio_lock_or_retry()
Message-ID: <YPapQUUSQZ4PZVHw@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-23-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:08AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert __lock_page_or_retry() to __folio_lock_or_retry().  This actually
> saves 4 bytes in the only caller of lock_page_or_retry() (due to better
> register allocation) and saves the 14 byte cost of calling page_folio()
> in __folio_lock_or_retry() for a total saving of 18 bytes.  Also use
> a bool for the return type.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  include/linux/pagemap.h | 11 +++++++----
>  mm/filemap.c            | 20 +++++++++-----------
>  mm/memory.c             |  8 ++++----
>  3 files changed, 20 insertions(+), 19 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
