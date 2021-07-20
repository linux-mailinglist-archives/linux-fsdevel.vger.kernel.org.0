Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979633CF834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhGTKEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237540AbhGTKCC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:02:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4BA361165;
        Tue, 20 Jul 2021 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777759;
        bh=YQE7P7lLZR07h6/dfoxegMJc7T4H7tBElA2h22TtAZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVJSPLXfpMKKlvvUdM4PhX0CswRtMmdEoVcUrZ+AsHkuNuEYeIZ1A6kXx4f5AWyr6
         5eG+3xt2Bm7qrjY0HZZVQ2naR/XkUnKuRAsPCkNleW5G91V/nh9zts2TTEzBoEawFB
         MwJIbzahzr7AQKpqlibg487dKNgpKmsG0IyarQ0OBGf4u57VTvIxv1aLbnUWQXhpJL
         R2+OllOStYHimMW5a+NjypHW/tjnYHUK8uIl4aTROzzfTpoA88Vwwrirb5WvkimfRF
         Qwszl19dveDmIm0GtJ2FTydzr2gnoGy75GpubZIPOhIz8wSne0xFqDOmA/02KjVGXs
         2nDaV35hcOfUw==
Date:   Tue, 20 Jul 2021 13:42:32 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 017/138] mm/filemap: Add folio_unlock()
Message-ID: <YPaomB3DcajZIH+D@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-18-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:03AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert unlock_page() to call folio_unlock().  By using a folio we
> avoid a call to compound_head().  This shortens the function from 39
> bytes to 25 and removes 4 instructions on x86-64.  Because we still
> have unlock_page(), it's a net increase of 16 bytes of text for the
> kernel as a whole, but any path that uses folio_unlock() will execute
> 4 fewer instructions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h |  3 ++-
>  mm/filemap.c            | 29 ++++++++++++-----------------
>  mm/folio-compat.c       |  6 ++++++
>  3 files changed, 20 insertions(+), 18 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

