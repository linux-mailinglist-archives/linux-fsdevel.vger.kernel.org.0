Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D7237BFCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhELOWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhELOWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 10:22:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49064C061574;
        Wed, 12 May 2021 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eOaFDmaOsRB5SZmY7GZQyJP9EcneAu4wq/VqoZMJKA0=; b=D/FBYaSYWv6OzEkl4olo0BI6C6
        6lwhaao1EEhwuC156MsK3O83RGoowreU8YQfQB3NMNjdeqNmm5y7zT1ognf2xw2tI+5pQvseSWoTe
        jKliduCU0fYTsRdguXHmSopDmUb4S9WFch0Bdz8N0ws+hdznCsYBY4CQulUwmCi/PszXrTlqmY9qd
        7k/qshhU7B+zlB5i0nHn6R28xKI1JV12MkWNr55RMoRVAK3D/eYP/s31H+VF4jzQ05gupekLTW5Ko
        cnXx9fDn8iqGiGckS69vPlSDt6KEM8tPqYc7fF4hwIOF84lMoLJ3N+/YU7f15TMU6uaPJ3XyWf6Ip
        /tBDqokQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgpjA-008M00-96; Wed, 12 May 2021 14:21:01 +0000
Date:   Wed, 12 May 2021 15:20:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH 03/11] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <YJvkPEAdVhM9JsbN@casper.infradead.org>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512134631.4053-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:46:11PM +0200, Jan Kara wrote:

> diff --git a/mm/truncate.c b/mm/truncate.c
> index 57a618c4a0d6..93bde2741e0e 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -415,7 +415,7 @@ EXPORT_SYMBOL(truncate_inode_pages_range);
>   * @mapping: mapping to truncate
>   * @lstart: offset from which to truncate
>   *
> - * Called under (and serialised by) inode->i_rwsem.
> + * Called under (and serialised by) inode->i_rwsem and inode->i_mapping_rwsem.

mapping->invalidate_lock, surely?  And could we ask lockdep to assert
this for us instead of just a comment?

>   *
>   * Note: When this function returns, there can be a page in the process of
>   * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
> -- 
> 2.26.2
> 
> 
