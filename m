Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E515824CD7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 08:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgHUGAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 02:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHUGAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:00:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF7C061385;
        Thu, 20 Aug 2020 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWB+/2Nt9PlJumw2ZEaPgdNpFexNYVi38bcYSvOU2wU=; b=akR/dH1A9l7PREYPjibZXxeJbz
        TrcKAjIO6AOtnVfb5cHo3RKx2gWnUbdO5lLIITlStex6gUJgbL6sqMtxHdjMUiCLsIX2rgN61DQ7+
        UAdQL9cDNQb7Sd8opb/ZpCj0XKBVhvMmcETK7Hv4PmSrwOZLkZATxZDccz+CpFV6Uf2tDAhtV9gfE
        gbgOkAylwCl5+4KrLdRVjVjue6PHzzzV2fq0P6U42KJB+lM9rwCliZbw5ELAUb+yXWAOLBsrAh4xM
        HZHod7MHQzZVAErqRD8kzJRNJQNR8D8XJN/H0efFvmFI3AoOo+EWAvS6smimAc3281j/TV05ukiVg
        dKRsysew==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k906E-0008LC-1n; Fri, 21 Aug 2020 06:00:26 +0000
Date:   Fri, 21 Aug 2020 07:00:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200821060025.GA31091@infradead.org>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:15:33AM +0530, Ritesh Harjani wrote:
> Please correct me here, but as I see, bio has only these two limits
> which it checks for adding page to bio. It doesn't check for limits
> of /sys/block/<dev>/queue/* no? I guess then it could be checked
> by block layer below b4 submitting the bio?

The bio does not, but the blk-mq code will split the bios when mapping
it to requests, take a look at blk_mq_submit_bio and __blk_queue_split.

But while the default limits are quite low, they can be increased
siginificantly, which tends to help with performance and is often
also done by scripts shipped by the distributions.

> This issue was first observed while running a fio run on a system with
> huge memory. But then here is an easy way we figured out to trigger the
> issue almost everytime with loop device on my VM setup. I have provided
> all the details on this below.

Can you wire this up for xfstests?
