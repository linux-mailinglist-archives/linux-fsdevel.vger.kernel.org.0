Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE8E2FF476
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbhAUT35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbhAUT3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:29:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C12FC06174A;
        Thu, 21 Jan 2021 11:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i1zxz8vASWRHLxesy1rO5fxiDd7lfVOB0Kd0jdtsmCA=; b=TiWmVlnRNRpl3k1fc6a7iL5LGC
        prg+qFh/jLfikAviMB9uncuW06NSsekhPIdfm3CW93gMh5i2aj1KmCFqxMo+xpdOph3lJ8k9r7jk7
        +YmzLil60j3IwF55dXjAlx5PDHqzHpS/Ce89Dzj6UjniN855XSKoPlcVHo064TQGffU4xXkmJVmmf
        TPDL/iH2/emDkxLnniPB0adm3KwqgxHGIV5Gl6Jg6GRMhJcwTO+vWR9dQAAWIG9CWqHifD8DqIjwZ
        qzYamwherXXeCx6cUfoJXR/ALQ4HjNj1RNcm7y1DfPckn4CMijalvip3LZ+05rNR0/67jpvSz/cmO
        3QinD+ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2fcZ-00HQxN-4v; Thu, 21 Jan 2021 19:27:59 +0000
Date:   Thu, 21 Jan 2021 19:27:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Message-ID: <20210121192755.GC4127393@casper.infradead.org>
References: <20210120160611.26853-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120160611.26853-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:06:08PM +0100, Jan Kara wrote:
> Hello,
> 
> Amir has reported [1] a that ext4 has a potential issues when reads can race
> with hole punching possibly exposing stale data from freed blocks or even
> corrupting filesystem when stale mapping data gets used for writeout. The
> problem is that during hole punching, new page cache pages can get instantiated
> in a punched range after truncate_inode_pages() has run but before the
> filesystem removes blocks from the file.  In principle any filesystem
> implementing hole punching thus needs to implement a mechanism to block
> instantiating page cache pages during hole punching to avoid this race. This is
> further complicated by the fact that there are multiple places that can
> instantiate pages in page cache.  We can have regular read(2) or page fault
> doing this but fadvise(2) or madvise(2) can also result in reading in page
> cache pages through force_page_cache_readahead().

Doesn't this indicate that we're doing truncates in the wrong order?
ie first we should deallocate the blocks, then we should free the page
cache that was caching the contents of those blocks.  We'd need to
make sure those pages in the page cache don't get written back to disc
(either by taking pages in the page cache off the lru list or having
the filesystem handle writeback of pages to a freed extent as a no-op).
