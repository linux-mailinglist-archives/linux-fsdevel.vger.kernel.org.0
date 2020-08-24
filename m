Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B22250059
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHXPEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHXPE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:04:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D0C0617A9;
        Mon, 24 Aug 2020 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8CP6fVQFmATmTA1mY6X4BjyYws+1260yHBdv8vP3vaA=; b=abBFOKCuZv5f3di1oL2KpM+NYX
        3jL/ZHpavzavy6HHSEvGScySN4B2OLgWxbltw14zWrUpj7tQFvq2IlvmFiLgtzkhTcycrFXioZVCj
        jVUGq4nLATCW0S1bNtYkidrzspSdwR8K60jIsr0RPBF2cxijXTBLeOJ1WeOMZSp/vBHi+UpQV85/0
        5fSNqFHc+ZTkoHT8XmdxHNDlmHH8fdzjWJF/uE49Z8OYVBbH348GA0dQ8c7yT06WZcSIL7cdyySc8
        SAu7lKtuxV8m9AJo5nGSa8Hw5lYXnAqpy8p0CTJuO4czS5S6jQgEEHkR8bD5CEjMjb9QrJeMOK2Wd
        iZalW7Yg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAE1B-0003Nv-An; Mon, 24 Aug 2020 15:04:17 +0000
Date:   Mon, 24 Aug 2020 16:04:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200824150417.GA12258@infradead.org>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824142823.GA295033@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> Do I understand the current code (__bio_try_merge_page() ->
> page_is_mergeable()) correctly in that we're checking for physical page
> contiguity and not necessarily requiring a new bio_vec per physical
> page?


Yes.

> With regard to Dave's earlier point around seeing excessively sized bio
> chains.. If I set up a large memory box with high dirty mem ratios and
> do contiguous buffered overwrites over a 32GB range followed by fsync, I
> can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> for the entire write. If I play games with how the buffered overwrite is
> submitted (i.e., in reverse) however, then I can occasionally reproduce
> a ~32GB chain of ~32k bios, which I think is what leads to problems in
> I/O completion on some systems. Granted, I don't reproduce soft lockup
> issues on my system with that behavior, so perhaps there's more to that
> particular issue.
> 
> Regardless, it seems reasonable to me to at least have a conservative
> limit on the length of an ioend bio chain. Would anybody object to
> iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> if we chain something like more than 1k bios at once?

So what exactly is the problem of processing a long chain in the
workqueue vs multiple small chains?  Maybe we need a cond_resched()
here and there, but I don't see how we'd substantially change behavior.
