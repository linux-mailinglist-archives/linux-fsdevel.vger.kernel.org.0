Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9754355374
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbhDFMRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 08:17:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243195AbhDFMRL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:17:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FE3BB15C;
        Tue,  6 Apr 2021 12:17:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CDD451F2B77; Tue,  6 Apr 2021 14:17:02 +0200 (CEST)
Date:   Tue, 6 Apr 2021 14:17:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Message-ID: <20210406121702.GB19407@quack2.suse.cz>
References: <20210120160611.26853-1-jack@suse.cz>
 <YGdxtbun4bT/Mko4@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGdxtbun4bT/Mko4@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 02-04-21 15:34:13, Theodore Ts'o wrote:
> On Wed, Jan 20, 2021 at 05:06:08PM +0100, Jan Kara wrote:
> > 
> > Amir has reported [1] a that ext4 has a potential issues when reads can race
> > with hole punching possibly exposing stale data from freed blocks or even
> > corrupting filesystem when stale mapping data gets used for writeout. The
> > problem is that during hole punching, new page cache pages can get instantiated
> > in a punched range after truncate_inode_pages() has run but before the
> > filesystem removes blocks from the file.  In principle any filesystem
> > implementing hole punching thus needs to implement a mechanism to block
> > instantiating page cache pages during hole punching to avoid this race. This is
> > further complicated by the fact that there are multiple places that can
> > instantiate pages in page cache.  We can have regular read(2) or page fault
> > doing this but fadvise(2) or madvise(2) can also result in reading in page
> > cache pages through force_page_cache_readahead().
> 
> What's the current status of this patch set?  I'm going through
> pending patches and it looks like folks don't like Jan's proposed
> solution.  What are next steps?

Note that I did post v2 here:

https://lore.kernel.org/linux-fsdevel/20210208163918.7871-1-jack@suse.cz/

It didn't get much comments though. I guess I'll rebase the series, include
the explanations I've added in my reply to Dave and resend.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
