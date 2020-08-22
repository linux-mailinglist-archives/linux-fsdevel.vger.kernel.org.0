Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055F424E8EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgHVQn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgHVQn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:43:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0DC061573;
        Sat, 22 Aug 2020 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oFuDeXF5XTQkzKHIHDTB3fkJIr4yRoHkr/iTMIInKAo=; b=Fkp1ehUBmRd07mlHbBu82Z0UJF
        XYNwHVDBi0sORpPOufYmQn/L6gACvzmYKqaXg7imKFdFCkp296kzKMjlbnAvabviqPcwXiA3DPKAP
        tgPTrS4i8X2tMz8dLVtjbSoGWwHDT/nIVPCxeh7YQDD9DGGVCymd4V3PojOCrqCry5IjsUCDR3A8b
        HuoRFgbPcUwiWn/zgsDeFYeRo4llJmlNr6cvmuKPYJlBYrHAf3SJO6N2pSfAK8rdiLUkk6yaa4Nds
        ID1To+9HoUjIPqkUhls33C4Ijv/CAGsRYPh/r0Ila9WaLWMQDY1YHFHTaTaDu/r7yhrV6DkCOtLPc
        xpbKsL8g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9WcA-0000jU-U1; Sat, 22 Aug 2020 16:43:34 +0000
Date:   Sat, 22 Aug 2020 17:43:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>, darrick.wong@oracle.com,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200822164334.GA2625@infradead.org>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
 <20200819125608.GA24051@xiangao.remote.csb>
 <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
 <20200821061234.GE31091@infradead.org>
 <20200821133657.GU17456@casper.infradead.org>
 <20200822060345.GD17129@infradead.org>
 <20200822142414.GY17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822142414.GY17456@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 22, 2020 at 03:24:14PM +0100, Matthew Wilcox wrote:
> The case I was worrying about:
> 
> fill a filesystem so that free space is very fragmented
> readahead into a hole
> hole is large, don't allocate an iop
> writeback the page
> don't have an iop, can't track the write count
> 
> I'd be fine with choosing to allocate an iop later (and indeed I do that
> as part of the THP work).  But does this scenario make you think of any
> other corner cases?

Can't think of a corner case.  And as said last time this comes up I
think trying to allocate the iop as late and lazy as possible is
probably a good thing.  I just went for the dumb way because it was
simpler and already a huge improvement over buffer heads.
