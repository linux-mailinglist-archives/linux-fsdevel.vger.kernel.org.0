Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8458333F748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhCQRmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhCQRlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF0C06174A;
        Wed, 17 Mar 2021 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FpOCNlGLmjPJhj1fuEhys0yX7aI4LJ/EMSq9Vu3moFY=; b=YU2gItud2sL1cw1Aifsrz1cFpx
        M7bWLZmF+tboQztj/Zh+aIVLRPi1m2GCah9bRmtWuVRVrWqlP0sUPputrC/aLG/Gr4r6uF29IOEK5
        CAL1s3NCbKweYs8w6YMs5l9s/BR8ZbbL8XEMfFf0rsyMP/DKC7UvspJmyjjdxhuiSaihKzSRHHQzC
        B8WZSReKQV/hT5olM/1BrQ4k2ARZObnJrh2ngxkNpHEtNWSGOBLglVx4z+hKynhenZASHrPk7wgA6
        PmX96g67cBy3B8kVncSsdTMOr8TMBApSZ2CLcMayaW1ytF10mPGkjU83wdEG7bF0qIoJ/JMoDwgfC
        mM6IePaA==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaAh-001vdy-FG; Wed, 17 Mar 2021 17:41:29 +0000
Date:   Wed, 17 Mar 2021 18:39:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 20/25] mm/filemap: Convert wait_on_page_bit to
 wait_on_folio_bit
Message-ID: <YFI+xNeN+NrgszI7@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (FolioWriteback(folio) &&
> +	    wait_on_folio_bit_killable(folio, PG_writeback) < 0)
>  		return VM_FAULT_RETRY;

This really screams for a proper wait_on_page_writeback_killable helper
rather than hardcoding the PG_* bit in a random file system.  It also
seems to have missed the conversion to a while loop in
wait_on_page_writeback.

Also this patch seems to be different in style to other by not for now
always using page wrappers in the file systems.  Not that I really care
either way, but it seems inconsistent with the rest.

>  /*
> - * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
> + * This is exported only for wait_on_folio_locked/wait_on_folio_writeback, etc.,
>   * and should not be used directly.
>   */
> -extern void wait_on_page_bit(struct page *page, int bit_nr);
> -extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
> +extern void wait_on_folio_bit(struct folio *folio, int bit_nr);
> +extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);

Well, the above code obviously ignored this comment :(  Maybe an
__ prefix is a bit more of hint? 
