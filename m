Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE1352FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 21:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDBTej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 15:34:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49126 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236560AbhDBTeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:34:37 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132JYEa0017030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 15:34:14 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0628E15C3ACE; Fri,  2 Apr 2021 15:34:14 -0400 (EDT)
Date:   Fri, 2 Apr 2021 15:34:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Message-ID: <YGdxtbun4bT/Mko4@mit.edu>
References: <20210120160611.26853-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120160611.26853-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:06:08PM +0100, Jan Kara wrote:
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

What's the current status of this patch set?  I'm going through
pending patches and it looks like folks don't like Jan's proposed
solution.  What are next steps?

Thanks,

					- Ted
