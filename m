Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91B490C37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiAQQLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiAQQLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:11:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F1C061574;
        Mon, 17 Jan 2022 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fB/5UIJYK/N6mY41Lc7aoPYq98s1VP7KunDWS2lUCAs=; b=HmIb80JJAC7ZddUBJ1hJaFr52I
        EMGYIKArwetQ6GXfbsQq4iRVshjxPMN8mbV7Qg/hc0tBPSAe8O1YCbCyoFUaqfNmT8ZbRZFB0AV5Q
        8q8TfhXjqILYLu8YC0b0BvatQ1aMJb39zGa1oWZltF0gtVgtnTf3ior8bN+lqFWqw3arwT1Fgx6BN
        gM1ZeOy0LNFItTVRLAEyVi2Cbu8ETZqkUYcao7lnF4Q5hk98dR4HpC3lE4lGazYUdd0sql0qWP5oi
        6GBceqNur6eMvTR3V1JQnPqZnjnKUmqY+gjI8B3NiCCl9dZJYO3L5IlHAl085LJOqzgm5N6sMZHUF
        rw/N/iDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9Ubk-008Mko-Ug; Mon, 17 Jan 2022 16:11:49 +0000
Date:   Mon, 17 Jan 2022 16:11:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/12] filemap: Use folio_put_refs() in
 filemap_free_folio()
Message-ID: <YeWVRFgUjlQ4/gOu@casper.infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-3-willy@infradead.org>
 <20220117155641.u5ysambg72nq2p6y@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117155641.u5ysambg72nq2p6y@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 06:56:41PM +0300, Kirill A. Shutemov wrote:
> On Sun, Jan 16, 2022 at 12:18:12PM +0000, Matthew Wilcox (Oracle) wrote:
> > +	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> > +		refs = folio_nr_pages(folio);
> 
> Isn't folio_test_large() check redundant? folio_nr_pages() would return 1
> for non-large folio, wouldn't it?

I'm trying to avoid the function call for !hugetlb pages.
