Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7974D37FCCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhEMRut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 13:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhEMRus (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 13:50:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F23DAF83;
        Thu, 13 May 2021 17:49:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0670B1E0D30; Thu, 13 May 2021 19:49:36 +0200 (CEST)
Date:   Thu, 13 May 2021 19:49:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
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
Message-ID: <20210513174935.GI2734@quack2.suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
 <YJvkPEAdVhM9JsbN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJvkPEAdVhM9JsbN@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-05-21 15:20:44, Matthew Wilcox wrote:
> On Wed, May 12, 2021 at 03:46:11PM +0200, Jan Kara wrote:
> 
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 57a618c4a0d6..93bde2741e0e 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -415,7 +415,7 @@ EXPORT_SYMBOL(truncate_inode_pages_range);
> >   * @mapping: mapping to truncate
> >   * @lstart: offset from which to truncate
> >   *
> > - * Called under (and serialised by) inode->i_rwsem.
> > + * Called under (and serialised by) inode->i_rwsem and inode->i_mapping_rwsem.
> 
> mapping->invalidate_lock, surely?

Right, thanks for noticing. 

> And could we ask lockdep to assert this for us instead of just a comment?

That's the plan but currently it would trip for filesystems unaware of
invalidate_lock. Once all filesystems are converted I plan to transform the
comments into actual asserts. In this series I aim at fixing the data
corruption issues, I plan the cleanups for later...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
