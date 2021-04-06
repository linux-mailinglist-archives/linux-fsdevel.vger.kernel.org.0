Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5A35574F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhDFPIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDFPIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:08:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D60EC06174A;
        Tue,  6 Apr 2021 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lDs7/lCOjqt9xEn6CNej+2SxO3jRNqh20hRXcKO0GYg=; b=I8nVYP3I1MUGAF7JEjSydH9W0+
        yekQ0x5fiIsBdIbM2C2elScPeQdYie5pfHnFpuWuC3sI75XmS5jSTkKQgQcBgwnEVX30QIUg8sJno
        +FLXbuLADU6UdEk+h4d+YIf6pr41znZIg6lJVRl6OxjMZoRVwZfIId/7qOCdc1Op1XJgnTJxj1hu+
        P0S8raOEI5fYhh6jp9q5cqh1GgXbxT5P9ozAUvv7RoI8s4V5nLezKmeCEMtSq9k0V3dophXH3W4kl
        Z32V4NoUFjCJE86Lk/lZRRRAq/TSzwCWWfEBzA7r2UhXkcIzBEpvP71HEzBt+CpDaL3rWmQuMBPnb
        BFq+Hl4w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTnH4-00Cz7X-Fq; Tue, 06 Apr 2021 15:06:09 +0000
Date:   Tue, 6 Apr 2021 16:05:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406150550.GA3094215@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
 <20210406143150.GA3082513@infradead.org>
 <20210406144022.GR2531743@casper.infradead.org>
 <20210406144712.GA3087660@infradead.org>
 <20210406145511.GS2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406145511.GS2531743@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:55:11PM +0100, Matthew Wilcox wrote:
> Assuming we're getting rid of them all though, we have to include:
> 
> $ git grep 'page->mapping' fs |wc -l
> 358
> $ git grep 'page->index' fs |wc -l
> 355

Are they all going to stay?  Or are we going to clean up some of that
mess.  A lot of ->index should be page_offet, and on the mapping side
the page_mapping and page_file_mapping mess is also waiting to be
sorted..
