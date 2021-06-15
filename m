Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1481F3A770B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFOG23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFOG2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:28:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA4C061574;
        Mon, 14 Jun 2021 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xD+8OyCC8jit/aO3eSCpd00pyVmVHLw7NkSiMk3zXxA=; b=Xj3bpVv8EqGZQLC/9byslmfD3k
        OSI63tSYCY0QFyoi5we++yY1diRNQkR0oRQ18iCZt35QKMeN5zzMJPOl0HGVSeJ6XPKdxEntBLsyK
        Tu2OOBvROdhE+e336DCBnXFHWZXcso/j20WFgD5TDv1piUTtThP7VIHxMH6OXN31xCuq3G06kdRSo
        7AHLz6EK3N2x+ZmsT+5Yd+g8BwTt3cqtUOEK5bguul5MMi2IOf/w6IcgtONFUUlkT7MbkWPWnWKj2
        02SYHMvZZ4kExqJtLa8in5kVJkaf+smpzEsrcdryLdPlrmz2zuHPXcLG+sev9HrYgGaCCRwk2pWJB
        6T1iOSsQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2WN-006AEL-90; Tue, 15 Jun 2021 06:26:03 +0000
Date:   Tue, 15 Jun 2021 07:25:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 09/33] mm: Add folio_try_get_rcu()
Message-ID: <YMhH99XFlaoxKUae@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
 <20210614201435.1379188-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614201435.1379188-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:14:11PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the equivalent of page_cache_get_speculative().  Also add
> folio_ref_try_add_rcu (the equivalent of page_cache_add_speculative)
> and folio_get_unless_zero() (the equivalent of get_page_unless_zero()).
> 
> The new kernel-doc attempts to explain from the user's point of view
> when to use folio_try_get_rcu() and when to use folio_get_unless_zero(),
> because there seems to be some confusion currently between the users of
> page_cache_get_speculative() and get_page_unless_zero().
> 
> Reimplement page_cache_add_speculative() and page_cache_get_speculative()
> as wrappers around the folio equivalents, but leave get_page_unless_zero()
> alone for now.  This commit reduces text size by 3 bytes due to slightly
> different register allocation & instruction selections.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
