Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5797F141A63
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 00:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgARXJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 18:09:07 -0500
Received: from [198.137.202.133] ([198.137.202.133]:40440 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbgARXJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 18:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m5EpDMuociEO+dhOx0dLjYTpW5oUxRxlXa1xRujJ5N4=; b=rPdI1c6SL+Uxr55wj8QlFXdD0
        5VxOSFTTxYx1dTuBaLrJ1VWZFVk6MhTP4sR/r8SB+2V3sMYJmEaeQOMDEUYSnrUNlvBA2WNtz09wM
        BGIXPhlfnD+zNDCTAZW7L9g4kQaXIjAK4y1sS5vv2ejWVzsfSniTki8dEt3W7bYdaEvynRAa7gIeq
        i3X7q2KZFEKQWIrcP1U5LoYXLjdLk+e2xj62Cix+HwO7a+GxrzQKPuoFrWePUtXcmKirGFWDjkYgM
        NqofqK1uzM4tU57IwJDNuk0G4DTLhatMoyGpiveFj6I7QHiZCigsmk+TIiNSGECqhciwnycSNMPXv
        j8F5XtwMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isxCc-0002oc-MH; Sat, 18 Jan 2020 23:08:26 +0000
Date:   Sat, 18 Jan 2020 15:08:26 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200118230826.GA5583@bombadil.infradead.org>
References: <20200116063601.39201-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116063601.39201-1-yukuai3@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 02:36:01PM +0800, yu kuai wrote:
> I noticed that generic/418 test may fail with small probability. And with
> futher investiation, it can be reproduced with:
> 
> ./src/dio-invalidate-cache -wp -b 4096 -n 8 -i 1 -f filename
> ./src/dio-invalidate-cache -wt -b 4096-n 8 -i 1 -f filename
> 
> The failure is because direct write wrote none-zero but buffer read got
> zero.
> 
> In the process of buffer read, if the page do not exist, readahead will
> be triggered.  __do_page_cache_readahead() will allocate page first. Next,
> if the file block is unwritten(or hole), iomap_begin() will set iomap->type
> to IOMAP_UNWRITTEN(or IOMAP_HOLE). Then, iomap_readpages_actor() will add
> page to page cache. Finally, iomap_readpage_actor() will zero the page.
> 
> However, there is no lock or serialization between initializing iomap and
> adding page to page cache against direct write. If direct write happen to
> fininsh between them, the type of iomap should be IOMAP_MAPPED instead of
> IOMAP_UNWRITTEN or IOMAP_HOLE. And the page will end up zeroed out in page
> cache, while on-disk page hold the data of direct write.

It's worth noting that my patch series from earlier this week to
redesign the readahead API will fix this problem.  Direct write will block
on the locked pages in the page cache.
