Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94035568D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbhDFOYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhDFOYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:24:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73025C06174A;
        Tue,  6 Apr 2021 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h8Ohb5Nl+BWd1e8JB1eKnm6zirqglOxK/PIdWxnDxGc=; b=RnPjPifYJLwE8ugTNLmyZ8ufmm
        WkEAfmFeG9q6iEoiCYK01PLavR5/z1Ea4z/iZjVNq3RoXmBLDHxU2mR1d6x4lQb3YAJa9jlqe2u+r
        eWPQNkHGCaIOwyTOx0kdTw/1R64fQMrQPB0S1WenBmo34SNWpd+eqmqq1Nc5AjilJSqMKoNrGa5T4
        +8s5HQC9vZbW0JmxPcovuIisYw+eH1XijlQmlnqGLI0hsA6TNlmYE3BHSXf7pj+134GYbN1SvgY2W
        MlHFBTxAFVE1Fxrv6faOk/PuDsSlfZleybcANMFgDb/y/bSLGsUoBOgI0yCZoZitYnZPhZRPgWqoZ
        6895580w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmbs-00Cvj3-2f; Tue, 06 Apr 2021 14:23:22 +0000
Date:   Tue, 6 Apr 2021 15:23:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 26/27] mm/filemap: Convert wake_up_page_bit to
 wake_up_folio_bit
Message-ID: <20210406142316.GY3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-27-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:27PM +0100, Matthew Wilcox (Oracle) wrote:
>  void unlock_page_private_2(struct page *page)
>  {
> -	page = compound_head(page);
> -	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
> -	clear_bit_unlock(PG_private_2, &page->flags);
> -	wake_up_page_bit(page, PG_private_2);
> +	struct folio *folio = page_folio(page);
> +	VM_BUG_ON_FOLIO(!FolioPrivate2(folio), folio);

A whitespace between the declaration and the code would be nice.

Otherwise looks good;

Reviewed-by: Christoph Hellwig <hch@lst.de>
