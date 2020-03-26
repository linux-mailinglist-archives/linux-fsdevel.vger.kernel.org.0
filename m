Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017E5193F08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 13:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCZMop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 08:44:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCZMop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T/g5zYQ/IY8vQN8Q10rUYZvaI2MWyMueldruMEuSQnc=; b=HgT2+ZWqRx0rWdKg/5Wd7YXbmh
        0Ri3jbL/u/dBQ6dq4PM4FTLHHkeyW+51vJLIVd+SRXXRHbfZYjq+8RqV5dzYY/eHCPoKDhv4WUXPb
        nLVSF9qWWwA3Q64P0iUx29aclieenvaASSpdTLlpkIRUsANc/3aWG3ZqHYamEeV+UaXfin9f7ftnK
        hmqZvKM75uCSI+QZSaxYXBR2VkmVAe8LsjE9m7uZRC+JxRGOWm7QOcNdxfUFgLop73BPsmwxVRade
        s3332CvPz7WImOOsgQwpVq7MrbbKD3il8bVETfuNDMM/FgowP1ShM4BqOCPnTOxTJIDAHF3wCL9+H
        3MOuy/fw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHRsJ-0005tN-A5; Thu, 26 Mar 2020 12:44:43 +0000
Date:   Thu, 26 Mar 2020 05:44:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Use clear_bit_unlock_is_negative_byte for
 PageWriteback
Message-ID: <20200326124443.GG22483@bombadil.infradead.org>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-3-willy@infradead.org>
 <20200326124047.GA13756@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326124047.GA13756@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:40:47PM +0100, Jan Kara wrote:
> On Thu 26-03-20 05:24:29, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > By moving PG_writeback down into the low bits of the page flags, we can
> > use clear_bit_unlock_is_negative_byte() for writeback as well as the
> > lock bit.  wake_up_page() then has no more callers.  Given the other
> > code being executed between the clear and the test, this is not going
> > to be as dramatic a win as it was for PageLocked, but symmetry between
> > the two is nice and lets us remove some code.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The patch looks good to me. Just one nit:
> 
> > +	VM_BUG_ON_PAGE(!PageWriteback(page), page);
> > +	if (__clear_page_writeback(page))
> > +		wake_up_page_bit(page, PG_writeback);
> 
> Since __clear_page_writeback() isn't really prepared for PageWriteback()
> not being set, can we move the VM_BUG_ON_PAGE() there? Otherwise feel free
> to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!  I put it there to be parallel to the PageLocked equivalent:

void unlock_page(struct page *page)
{
        BUILD_BUG_ON(PG_waiters != 7);
        BUILD_BUG_ON(PG_locked > 7);
        page = compound_head(page);
        VM_BUG_ON_PAGE(!PageLocked(page), page);
        if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
                wake_up_page_bit(page, PG_locked);
}

but one could equally well argue it should be in __clear_page_writeback
instead.
