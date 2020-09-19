Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CF270B31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 08:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgISGnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 02:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISGnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:43:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80360C0613CE;
        Fri, 18 Sep 2020 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9LrZ9sUo6w/03uY6kgjnqJLLj1Zrpd31yqvhq3IMdAc=; b=qn0uaXwgGqPr2aTt+Ane4uwzoA
        ZdSDuH+XDa5qH9pbauTzlI8SJiEutnbkyKtBo4fgaeQPYqIC04szwYcj8pLzm5WzhjLMtLXy05ABo
        2W/wG5b94r238l/mwxNNZFkrUfiJzgSg+Q4TWXxNw28orhkswJu1xqb/X6hUtd86fZgVZ3shE2bpE
        369u4r6bVU40RkTZrkDGBjq2u1Uo9X/9068JgSWfVLQkJjHZ6F4F3ulMDfyouTWFSuQCeYzmsGQnV
        oWB3cnfm/cF/gLibM/Imsg2LO/fXGiffDqotO+8gkRSdRGOWa4/eF8iSAtlOw/7/S+6hOt8neuynz
        hYWRluiw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJWaS-0004Rm-37; Sat, 19 Sep 2020 06:43:08 +0000
Date:   Sat, 19 Sep 2020 07:43:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 16/13] iomap: Make readpage synchronous
Message-ID: <20200919064308.GA16257@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
 <20200917225647.26481-3-willy@infradead.org>
 <20200919063908.GH13501@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919063908.GH13501@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 19, 2020 at 07:39:08AM +0100, Christoph Hellwig wrote:
> I think just adding the completion and status to struct
> iomap_readpage_ctx would be a lot easier to follow, at the cost
> of bloating the structure a bit for the readahead case.  If we
> are realy concerned about that, the completion could be directly
> on the iomap_readpage stack and we'd pass a pointer.

Anbother option would be to chain the bios and use submit_bio_wait.
That would take care of the completion and the status propagation
withour extra fields and extra code in iomap.
