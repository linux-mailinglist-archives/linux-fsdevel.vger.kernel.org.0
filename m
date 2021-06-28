Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F623B591F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhF1Gb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1Gb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:31:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D9C061574;
        Sun, 27 Jun 2021 23:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8cTi4WGWVG2C120IO8WXCGutLnZwDIpaPEZ82wXkV+I=; b=tfarKpP8v6HFfCRc4oPK53+lEp
        kAsNYstY133Xrj6wY+iRY2blwaUJNgk1aeZGikyqy9k6tg/JrwaaW5S0E5eGwJX6pqWu+wTJo/KR+
        xt9heM8cLmFbCUxe6AVpkt4yY1ZJza+qpBvX6EJlyVilaUH5SgB15TFcdl9fPxYB4/O6b3sXoDvNJ
        AZdka/FRVm3jSrj+MI0YAggREVpK12ImlYWtmpTR6LMgOwmXDNOCHPfa0pnk2qXq2xL3cBZp4yFWh
        FR65y632uMUcBxZBy3u9vQkn9uuThGDR51z1zkw/8A1PGnfYp5EodsXI4dmx2NAQzg25/DrXVeUPg
        O6Bpbvbw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkjR-002ep3-Cr; Mon, 28 Jun 2021 06:27:13 +0000
Date:   Mon, 28 Jun 2021 07:26:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/46] mm/migrate: Add folio_migrate_copy()
Message-ID: <YNlrsfsk/dziia2q@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-21-willy@infradead.org>
 <YNLyNJupwcDdj0ZG@infradead.org>
 <YNTIr/UGVrTOZD3f@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTIr/UGVrTOZD3f@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 07:02:23PM +0100, Matthew Wilcox wrote:
> > What is the advantage of copying backwards here to start with?
> 
> Easier to write the loop this way?  I suppose we could do it as ...
> 
> 	unsigned int i, nr = folio_nr_pages(folio);
> 
> 	for (i = 0; i < nr; i++) {
> 		/* folio_page() handles discontinuities in memmap */
> 		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
> 		cond_resched();
> 	}

I'd prefer that if there is no obvious downside.
