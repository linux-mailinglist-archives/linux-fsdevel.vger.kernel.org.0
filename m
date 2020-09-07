Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC325F3A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIGHNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIGHNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A4C061573;
        Mon,  7 Sep 2020 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t/uLsl5AXin2cAViLg4Mxi6tBTprZgEYc53F0H7n0lo=; b=sq7WdxpxnmMJ8WWESWXfPZpLsN
        Tff3aZz7wGmc+yxuGIUKAuDFJMRtdrK2lzhPQYUrK7JR4PMlY9vv3ZYL3q4fA+WALY9KdGFNRvJQX
        e7hNeZwLHyMzrHqkIOKD4ZP8rrRjFTnfq60NziD4ekdtp/gCdFPnYchURqD5g2UVibjXB9/oaDLq5
        ElDFa6fffnZ1Qm3ErZispjREou77C+6jznLHmUJ1xrZV6ahhV73Ct3zuH4SlsVI86YYsx/XYNkLn8
        BUDDKVnynTd1B6kQCG+HdVWyvbrhHBgXFSZ+peUShI+YET9c+XnQrnE/rtUsi8jIHziwRfBNNjvH/
        cLuN7X3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFBKv-0007NJ-0x; Mon, 07 Sep 2020 07:13:09 +0000
Date:   Mon, 7 Sep 2020 08:13:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        linux-kernel@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH] ext4: Implement swap_activate aops using iomap
Message-ID: <20200907071308.GC27898@infradead.org>
References: <20200904091653.1014334-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904091653.1014334-1-riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 02:46:53PM +0530, Ritesh Harjani wrote:
> After moving ext4's bmap to iomap interface, swapon functionality
> on files created using fallocate (which creates unwritten extents) are
> failing. This is since iomap_bmap interface returns 0 for unwritten
> extents and thus generic_swapfile_activate considers this as holes
> and hence bail out with below kernel msg :-
> 
> [340.915835] swapon: swapfile has holes
> 
> To fix this we need to implement ->swap_activate aops in ext4
> which will use ext4_iomap_report_ops. Since we only need to return
> the list of extents so ext4_iomap_report_ops should be enough.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
