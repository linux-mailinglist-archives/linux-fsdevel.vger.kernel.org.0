Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185B8CC38C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfJDT2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 15:28:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDT2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7FrKM8lwwq9BP68RfAzbEbu9ZbuQwm+28FVR9aIuo9k=; b=mLsT1CQPB6s297SOjc6whQlHh
        7OQtfOT/7cA/t+dU8xiYVhYyHjt1oahqDByGmLf+dVbEXOy8b432BO4dERJl/TZOptiJc8C/IqfAv
        CQ7oSGBik8lmRWnpZFqBHcpl/CypQTAlqsoPWcyjWzq/usEfouGHNgUHr2x3wQcWpxxapFEnpj63d
        ZMKIUQ6ziTf5UPc9N1CYQuWI55zudMMEo7tkr9wTfCat1r9pkGDz50sUyJDg20HwMCHQ7q2OJMGEa
        qXZ4wq1o4eVTqxBzMVw3s7MBpnGs2IgUAUdyj+uCExBlOQhqB7bKH8riky78QzO8yAIpCDi5QWoT/
        ElZOX2C5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGTFM-0003sN-Cm; Fri, 04 Oct 2019 19:28:12 +0000
Date:   Fri, 4 Oct 2019 12:28:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] fs: Introduce i_blocks_per_page
Message-ID: <20191004192812.GK32665@bombadil.infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-3-willy@infradead.org>
 <20190925083650.GE804@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925083650.GE804@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 06:36:50PM +1000, Dave Chinner wrote:
> I'm actually working on abstrcting this code from both block size
> and page size via the helpers below. We ahve need to support block
> size > page size, and so that requires touching a bunch of all the
> same code as this patchset. I'm currently trying to combine your
> last patch set with my patchset so I can easily test allocating 64k
> page cache pages on a 64k block size filesystem on a 4k page size
> machine with XFS....

This all makes sense ...

> > -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> > +	if (iop || i_blocks_per_page(inode, page) <= 1)
> >  		return iop;
> 
> That also means checks like these become:
> 
> 	if (iop || iomap_chunks_per_page(inode, page) <= 1)
> 
> as a single file can now have multiple pages per block, a page per
> block and multiple blocks per page as the page size changes...
> 
> I'd like to only have to make one pass over this code to abstract
> out page and block sizes, so I'm guessing we'll need to do some
> co-ordination here....

Yup.  I'm happy if you want to send your patches out; I'll keep going
with the patches I have for the moment, and we'll figure out how to
merge the two series in a way that makes sense.

