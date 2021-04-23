Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD05C3699B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbhDWScF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWScE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:32:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3610EC061574;
        Fri, 23 Apr 2021 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=19MC/ECN3OWEttJSfNKYhsEBI3DWNTT+3puFZa754BA=; b=q2fnOVoW6AVeExxSOF8pr+ERGP
        yfxbQCEhL3SoJ9S4pecr6zRB0GmmsCxrZukyAdiAMif6SHNvdOE1E7U120Ij1sP+Z3+wdrWsoURWi
        PmYCkHgT1eriQFe7P0ERXjHBCO+9JlTYV8aQVmtgIJjR8lvgL3cyavi3FEjHoHFTxc21WAQ4f2Zz+
        sV1Z4B6IbOjs6KU46Pmsh7fntCFyTamR96j2R8oTTo7FP6sAhPbe7AQKxieTOEdSvtIYQdjJzcTxN
        +xIAsRybN9Pq4T5YBkQNFpvPqSZSTBjscy226S2phOUwKGDjVYieWIwk09t7BsYB4/T18YLR5tOTh
        NjjW6VQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1la0Zc-002EBZ-Af; Fri, 23 Apr 2021 18:30:48 +0000
Date:   Fri, 23 Apr 2021 19:30:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 02/12] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210423183040.GD235567@casper.infradead.org>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423173018.23133-2-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 07:29:31PM +0200, Jan Kara wrote:
> Currently, serializing operations such as page fault, read, or readahead
> against hole punching is rather difficult. The basic race scheme is
> like:
> 
> fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
>   truncate_inode_pages_range()
> 						  <create pages in page
> 						   cache here>
>   <update fs block mapping and free blocks>
> 
> Now the problem is in this way read / page fault / readahead can
> instantiate pages in page cache with potentially stale data (if blocks
> get quickly reused). Avoiding this race is not simple - page locks do
> not work because we want to make sure there are *no* pages in given
> range.

One of the things I've had in mind for a while is moving the DAX locked
entry concept into the page cache proper.  It would avoid creating the
new semaphore, at the cost of taking the i_pages lock twice (once to
insert the entries that cover the range, and once to delete the entries).

It'd have pretty much the same effect, though -- read/fault/... would
block until the entry was deleted from the page cache.
