Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF83995F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhFBW26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBW26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B647C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e2ldX4bfM5mKfs85ACVtcDrIKE1liu0rw7NOjjRx7JI=; b=n55GYFH4iUTRiVjGnFSsjozLSu
        eUh7m9Vo5CXQ/CpjboZJyd+MlP+PLf32oOoain3d29wyV2nXDLZ/tK9wXxLEbPFPKA7owFYShKm+V
        aECRPoQAHaRz8HTpjY/T+R3GxrSNmAXTPR/HYJ0TkCj09IzviT8WqleeCGGk9s6ENBwl7HRSTs+x/
        p72LnLbUwEwsCc/9qarhFz+CL+Hk/CdyqFTpUf95ghtdRsMUeC8v4ATjTP/+9Q45LLTHR9rPoUZ1S
        9dbDx2DzBSSwS6gu9LrShZwK0HUuSDQEngIzOqyE3K9RkxQhENXAB23PjeWXAJ9H6bADBH4MyC7dd
        Iz8+5tRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1loZK2-00Bary-S4; Wed, 02 Jun 2021 22:26:52 +0000
Date:   Wed, 2 Jun 2021 23:26:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: question about mapping_set_error when writeback fails?
Message-ID: <YLgFpqi63K/NMO2D@casper.infradead.org>
References: <20210602202756.GA26333@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602202756.GA26333@locust>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:27:56PM -0700, Darrick J. Wong wrote:
> In iomap_finish_page_writeback,
> 
> static void
> iomap_finish_page_writeback(struct inode *inode, struct page *page,
> 		int error, unsigned int len)
> {
> 	struct iomap_page *iop = to_iomap_page(page);
> 
> 	if (error) {
> 		SetPageError(page);
> 		mapping_set_error(inode->i_mapping, -EIO);
> 
> Why don't we pass error to mapping_set_error here?  If the writeback
> completion failed due to insufficient space (e.g. extent mapping btree
> expansion hit ENOSPC while trying to perform an unwritten extent
> conversion) then we set AS_EIO which causes fsync to return EIO instead
> of ENOSPC like you'd expect.

Hah, I noticed the same thing a few weeks ago and didn't get round to
asking about it yet.  I'm pretty sure we should pass the real error to
mapping_set_error().

I also wonder if we shouldn't support more of the errors from
blk_errors, like -ETIMEDOUT or -EILSEQ, but that's a different
conversation.
