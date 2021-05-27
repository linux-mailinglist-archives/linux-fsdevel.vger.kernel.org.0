Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453E6392999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhE0Ic4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhE0Icz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:32:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534B4C061574;
        Thu, 27 May 2021 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i7BWqfskeK9kW3dSo9ld0sv/Je9/N41pQm9p0c/HcNQ=; b=Yozlr+C0MAefXsNXcCwqD2C1+3
        n/ks5zxvGw25ayN20tLSWFEC5h+F41iNKBwAcN7h+LhIKbAL9xhZ3phR1TYoWsmrDMSpGlnVH9/Sr
        g2aXJsbycGI41VWSTZzRcgMn4MomUUdWyCggj10GaE0zJIX0km20jHpVNzxXheIEVpx/6bDUd2lID
        VfkZK05V/iL3D4wfMRSSUCrtgRa+tM0rmoISTJiTcfA4Gbdszhi1uoJEyBqkTprcjlSu7W2gQd76/
        v8x7OeoHB6bVCFHfTebDTX8l6Cd3W34xcqF9VpTo5u+1V2cpaS4GysN75FOkfa7OAi+KTNVqjt3Wr
        mZh54MYA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmBQ5-005Ksd-DJ; Thu, 27 May 2021 08:31:10 +0000
Date:   Thu, 27 May 2021 09:31:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 33/33] mm: Add folio_mapped
Message-ID: <YK9YzS1T3xp3QI8/@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-34-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:35PM +0100, Matthew Wilcox (Oracle) wrote:
> This function is the equivalent of page_mapped().  It is slightly
> shorter as we do not need to handle the PageTail() case.  Reimplement
> page_mapped() as a wrapper around folio_mapped().

No byte savings numbers as for the other patches?

The patch itself looks good, although I'd go for a slightly easier
readable structure:

bool folio_mapped(struct folio *folio)
{
	if (folio_single(folio))
		return atomic_read(&folio->_mapcount) >= 0;

	if (atomic_read(compound_mapcount_ptr(&folio->page)) >= 0)
		return true;

	if (!folio_hugetlb(folio)) {
		unsigned long i;

		for (i = 0; i < folio_nr_pages(folio); i++)
			if (atomic_read(&folio_page(folio, i)->_mapcount) >= 0)
 				return true;
 	}
 	return false;
 }

 Shouldn't we also have a folio version of compound_mapcount_ptr?
