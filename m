Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2C24D62D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHUNhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgHUNhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:37:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6018C061573;
        Fri, 21 Aug 2020 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7cWjPG1+m96/p7EsFzUoRpFmcNyib+nqYEpG+MEwLFU=; b=PK+vJHHT2V5rhklvCQxBLFugX7
        eCJLJC7Rugf2E+inW443z0mHRCIOy9Hqyg01Re+85vCzEx1Jra2z+jSoeIvuRlEVFdvxbyseRqFKd
        ogu3LTLXkADnkouRz/PIc9cba+MZJ5naztugOpoIJK7/bbndASBH852gsE/zqrIW6/stYAtUSAVfB
        WsHLQMlOEuEs/RaXCYiYF3xtXTNAAKap+GD7Dhv7Zjxy3CxiQkYO9eg0l3/h8aeBmAELAM5umbuaT
        C4bvndo/kKTUJpEGM6BOG4QrgaFWy5BqvSX4k94trGPqxSmUvEdmZ7iWloAMeqDarbNCmK2OB4lCR
        NtHQO+1g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k97E1-000653-Lm; Fri, 21 Aug 2020 13:36:57 +0000
Date:   Fri, 21 Aug 2020 14:36:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>, darrick.wong@oracle.com,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200821133657.GU17456@casper.infradead.org>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
 <20200819125608.GA24051@xiangao.remote.csb>
 <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
 <20200821061234.GE31091@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821061234.GE31091@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:12:34AM +0100, Christoph Hellwig wrote:
> iomap sets PagePrivate if a iomap_page structure is allocated.  Right
> now that means for all pages on a file system with a block size smaller
> than the page size, although I hope we reduce that scope a little.

I was thinking about that.  Is there a problem where we initially allocate
the page with a contiguous extent larger than the page, then later need
to write the page to a pair of extents?

If we're doing an unshare operation, then we know our src and dest iomaps
and can allocate the iop then.  But if we readahead, we don't necessarily
know our eventual dest.  So the conditions for skipping allocating an
iop are tricky to be sure we'll never need it.
