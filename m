Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E043FD88B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 08:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfJPGke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 02:40:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPGke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NRdXWd+mf1CKKFMNao+no9nPxbfmJv9cte/QDA2R1kk=; b=ctaDRp3zUFE0fdWuYVklwnD8C
        oZxpkJChewAYKKFbAYqFtQpNVk3j0tG4PHKPR1EEpXjxR2/FDlFSz97ahsse6HqHzrVcJQ5C5cU9H
        Y/ZaGenBahXnI5nUz5qVN1aeLpg7QB7AZU4Elk+L8p4Lg7hnPNTjer0ayLUvf3YfBT/Kq0GaF85G+
        ltPtfm1nT2nMpZenZnlPDvq3JR+WKTxCPvCWWpeBW/fgtMTCQ5WvuQt1u5+1PDTw1YxcQFrL9OnnN
        kBPnaEPtRJNSj4u/zcs7jecp89JXZFNhZEiKft+6OqhHd2eEk1W+MhnZ4XjZQWVW4RuyeHVPh9Jc1
        dATOVDcYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKcz3-0006gt-Hl; Wed, 16 Oct 2019 06:40:33 +0000
Date:   Tue, 15 Oct 2019 23:40:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191016064033.GA18326@infradead.org>
References: <20191016051101.12620-1-david@fromorbit.com>
 <20191016052713.GX13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016052713.GX13108@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:27:13PM -0700, Darrick J. Wong wrote:
> > +	/*
> > +	 * Writes that span EOF might trigger an IO size update on completion,
> > +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> > +	 * there is no other metadata changes being made or are pending here.
> > +	 */
> > +	if (offset + count > i_size_read(inode))
> > +		iomap->flags |= IOMAP_F_DIRTY;
> 
> This ought to be in xfs_direct_write_iomap_begin(), right?
> 
> (Hoping to see another rev of Christoph's iomap cleanup series... ;))

I need to finish off all the nitpicks on the first iomap series..

Also we'll want this patch in first as it is 5.4 / -stable material,
so I'll need to rebase on top of that as well.
