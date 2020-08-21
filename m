Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54924CDC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgHUGMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 02:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:12:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CEC061385;
        Thu, 20 Aug 2020 23:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XjECR8+eDUPEGuoHB06jbTzMefby4d/dy/IIb2Ht2a4=; b=Tbpt5kSnanADTOo1RWnYXI1TxW
        RKUGe5xb2JaRZLaPWi1bweavQXKS2OJoYYiMPd31tHB7zYMsFT6/FpuQ/5Io7Usxfy7a0T6GSYHcS
        wDpyd0iRHMdWQIhe2f+HKhwzC1yRAiFGM5exUGPWGtEHIBLxNR9UPEErW3Kww7orsbfpYfiOkf3+E
        LOZnu2qb05CsM1L5DJPBxH9T2PWJlkPL3+Y/px/tiYv9ySuiIjn6bYLIRFY+xPoCmNuPb578diRc3
        UWIWHHV8aiwLtF8rVVo6IcNZdwRpL82fKWZMtTKVChgmo2lzelJyU17VvT+Xe10Lxez5srIWpSlan
        0QOioo0w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k90Hy-0000qm-Ii; Fri, 21 Aug 2020 06:12:34 +0000
Date:   Fri, 21 Aug 2020 07:12:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Gao Xiang <hsiangkao@redhat.com>, hch@infradead.org,
        darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200821061234.GE31091@infradead.org>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
 <20200819125608.GA24051@xiangao.remote.csb>
 <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:38:53AM +0800, yukuai (C) wrote:
> > > +iomap_set_range_dirty(struct page *page, unsigned int off,
> > > +		unsigned int len)
> > > +{
> > > +	if (PageError(page))
> > > +		return;
> > > +
> > > +	if (page_has_private(page))
> > > +		iomap_iop_set_range_dirty(page, off, len);
> > 
> > 
> > I vaguely remembered iomap doesn't always set up PagePrivate.
> > 
> 
> If so, maybe I should move iomap_set_page_dirty() to
> ioamp_set_range_dirty().

iomap sets PagePrivate if a iomap_page structure is allocated.  Right
now that means for all pages on a file system with a block size smaller
than the page size, although I hope we reduce that scope a little.
