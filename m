Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE24721CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhLMHe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 02:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLMHe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:34:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7ACC06173F;
        Sun, 12 Dec 2021 23:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5Pb345+1U5ovcXdOFAfP24g/IrGCHyslWbHwzGxwMU=; b=NvX6vO2uvf4aIxjW5C/z1RBKH2
        nv9ey6ctZFG3qHSw+pdEypY5xkQTo34LHAVvoLExwYifypTiJtF2hGgNr2BywkCgakvCUtwEhNG+o
        cwCSX85e4f1VUoqqTm3n3qVS6ENVLT0wGA8ieho3GC+VEcpkyuDVQ5As5xgWymTWi8FHNKd9kaKQJ
        k7kYXkU3qaWFYG9NT08zyStyQk5+kAFiuxm3MBu0nowp14iWROwrz5BI2dWCIWt02KKUffu2DNSH8
        STzr8LyZDMa8vTe4WgsUpqfmatfEoJdoBfl6d95ly7232fAOI2JUrcHGwMuUPFMAK2U0LTT+rGx3d
        BEAoblbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwfrK-0086qN-4F; Mon, 13 Dec 2021 07:34:54 +0000
Date:   Sun, 12 Dec 2021 23:34:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <Ybb3nmf0hPXhlnOu@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
 <YbJ3O1qf+9p/HWka@casper.infradead.org>
 <YbN+KqqCG0032NMG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbN+KqqCG0032NMG@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 04:19:54PM +0000, Matthew Wilcox wrote:
> After attempting the merge with Christoph's ill-timed refactoring,

I did give you a headsup before..

> I decided that eliding the use of 'bytes' here was the wrong approach,
> because it very much needs to be put back in for the merge.

Is there any good reason to not just delay the iomp_zero_iter folio
conversion for now?
