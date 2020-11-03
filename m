Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1462A489C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgKCOw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCOww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:52:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66679C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6U4ThevB7TVk8m9DqgD5pK3ESI9GndIOx4FdJBcwmOU=; b=qkX4qelchjIYClUSiVcbGmxP6K
        J9/IW+YbSLDUbwdY2RnWYcFQi8nx0fkVfdFQOBzi/+Mv/wLR5vuA4OcXLyXQU474y2sR/As4PwWuW
        HK61wKQao9PBaIiSuF2VGvyxOVC7NkneVUJEbZW2Suu0pKl/Rp115UlkevLpIuzFv++skF+9CjwXM
        1n6nNFYbfddDRQTf6Kq2rmhNRwLRM0KYh/v5M3kk5U1LY1JrxBpskj3uZhFqPcd5PSKRuyhuE5c1y
        knuKaUyawQHNPUISp6UfVy+Ak9l+at063vKDSjXHa4bhIC5V0c6ciLToy5m73WDrNzT/ta2Mawurj
        gUfKTfmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxg2-0003nP-Sb; Tue, 03 Nov 2020 14:52:50 +0000
Date:   Tue, 3 Nov 2020 14:52:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 01/17] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201103145250.GX27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-2-willy@infradead.org>
 <20201103072700.GA8389@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103072700.GA8389@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 08:27:00AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 02, 2020 at 06:42:56PM +0000, Matthew Wilcox (Oracle) wrote:
> > The recent split of generic_file_buffered_read() created some very
> > long function names which are hard to distinguish from each other.
> > Rename as follows:
> > 
> > generic_file_buffered_read_readpage -> filemap_read_page
> > generic_file_buffered_read_pagenotuptodate -> filemap_update_page
> > generic_file_buffered_read_no_cached_page -> filemap_create_page
> > generic_file_buffered_read_get_pages -> filemap_get_pages
> 
> Find with me, although I think filemap_find_get_pages would be a better
> name for filemap_get_pages.

To me, 'find' means 'starting from this position, search forward in the
array for the next page', but we don't want to do that, we just want to
get a batch of pages starting _at_ this index.  Arguably it'd be better
named filemap_get_or_create_batch().
