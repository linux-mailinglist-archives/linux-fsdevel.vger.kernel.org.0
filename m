Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75455141AF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgASBnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 20:43:22 -0500
Received: from [198.137.202.133] ([198.137.202.133]:55144 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbgASBnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GacFmTwPDNSrAHS3oEX1cOtDzMsn4hpcGoZQBj+oge8=; b=pSvbAnIfeaU8NhiNePru6z203
        2b75/Sh4GoqRdexOHid3yVIFzRIf7ePbj9Iy43BhVmksspkhqiBi9Iw9qF0+/rFAieHnMzowwXkRQ
        YjfJGFRjBb9CKkseEkmnH3O2HE22DQUsjfWK7+bFq5xvuV8npFCHZtcSx2Xm476KM3ADF1VTPotPG
        kf2UK30o680R5XrbvuvlgeO0bz4b9gQmYSpCpaUsDapugo4HWQ1YKN5BBeU7iwvNB7xYXPWzJvHSC
        Siofg7N/OlykrLD9gGeABxvUChhn0pbbsFnQ2Sw0S4acilxY/W7VM9RW1eSYxh9rkwdY6YUaJEZnB
        gnX74Buzg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iszbR-0002Jg-E3; Sun, 19 Jan 2020 01:42:13 +0000
Date:   Sat, 18 Jan 2020 17:42:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200119014213.GA16943@bombadil.infradead.org>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200118230826.GA5583@bombadil.infradead.org>
 <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 09:34:32AM +0800, yukuai (C) wrote:
> 
> 
> On 2020/1/19 7:08, Matthew Wilcox wrote:
> > It's worth noting that my patch series from earlier this week to
> > redesign the readahead API will fix this problem.  Direct write will block
> > on the locked pages in the page cache.
> 
> Thank you for your response!
> 
> In this case, direct write finish while page do not exist in the page
> cache. This is the fundamental condition of the race, because readahead
> won't allocate page if page exist in page cache.
> 
> By the way, in the current logic, if page exist in page cache, direct
> write need to hold lock for page in invalidate_inode_pages2_range().

Did you read my patch series?  The current code allocates pages,
but does not put them in the page cache until after iomap is called.
My patch series changes that to put the pages in the page cache as soon
as they're allocated, and before iomap is called.
