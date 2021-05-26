Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B494639146B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhEZKIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 06:08:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233803AbhEZKIf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 06:08:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622023623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZxNqCRr5czRb56ktpxOWnOSu0fMulpRezdytlVC9QQ=;
        b=MUD4K8oZyRkdjWXxo9HyOuILAC4V4vxmrSA2puCD1iiJPv8jaP+OiF8l+HEBDcKpaVp3/h
        7onqU4PqBHfM45G/uKaLxUlJv3zQzDi8HpsqqlwG/16TY4CmFD/oNOcXgIeoljs82BjeKG
        BWqBVJ7bKd8IeS58qNbom5KI0ThJpMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622023623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZxNqCRr5czRb56ktpxOWnOSu0fMulpRezdytlVC9QQ=;
        b=hZUsEKYXJUCCkMAN57O+Y8WvBmPX15w3AXW2eO+doBR566bf0sVhZ7r7OxXtui0gC6+R4Q
        /hxlBSr/JveL4MCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D67DB237;
        Wed, 26 May 2021 10:07:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0EB141F2CAC; Wed, 26 May 2021 12:07:02 +0200 (CEST)
Date:   Wed, 26 May 2021 12:07:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
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
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/13] mm: Add functions to lock invalidate_lock for two
 mappings
Message-ID: <20210526100702.GB30369@quack2.suse.cz>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-4-jack@suse.cz>
 <20210525204805.GM202121@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525204805.GM202121@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-05-21 13:48:05, Darrick J. Wong wrote:
> On Tue, May 25, 2021 at 03:50:41PM +0200, Jan Kara wrote:
> > Some operations such as reflinking blocks among files will need to lock
> > invalidate_lock for two mappings. Add helper functions to do that.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  include/linux/fs.h |  6 ++++++
> >  mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 897238d9f1e0..e6f7447505f5 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -822,6 +822,12 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
> >  void lock_two_nondirectories(struct inode *, struct inode*);
> >  void unlock_two_nondirectories(struct inode *, struct inode*);
> >  
> > +void filemap_invalidate_down_write_two(struct address_space *mapping1,
> > +				       struct address_space *mapping2);
> > +void filemap_invalidate_up_write_two(struct address_space *mapping1,
> 
> TBH I find myself wishing that the invalidate_lock used the same
> lock/unlock style wrappers that we use for i_rwsem.
> 
> filemap_invalidate_lock(inode1->mapping);
> filemap_invalidate_lock_two(inode1->i_mapping, inode2->i_mapping);

OK, and filemap_invalidate_lock_shared() for down_read()? I guess that
works for me.

								Honza

 
> To be fair, I've never been able to keep straight that down means lock
> and up means unlock.  Ah well, at least you didn't use "p" and "v".
> 
> Mechanically, the changes look ok to me.
> Acked-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > +				     struct address_space *mapping2);
> > +
> > +
> >  /*
> >   * NOTE: in a 32bit arch with a preemptable kernel and
> >   * an UP compile the i_size_read/write must be atomic
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 4d9ec4c6cc34..d3801a9739aa 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1009,6 +1009,44 @@ struct page *__page_cache_alloc(gfp_t gfp)
> >  EXPORT_SYMBOL(__page_cache_alloc);
> >  #endif
> >  
> > +/*
> > + * filemap_invalidate_down_write_two - lock invalidate_lock for two mappings
> > + *
> > + * Lock exclusively invalidate_lock of any passed mapping that is not NULL.
> > + *
> > + * @mapping1: the first mapping to lock
> > + * @mapping2: the second mapping to lock
> > + */
> > +void filemap_invalidate_down_write_two(struct address_space *mapping1,
> > +				       struct address_space *mapping2)
> > +{
> > +	if (mapping1 > mapping2)
> > +		swap(mapping1, mapping2);
> > +	if (mapping1)
> > +		down_write(&mapping1->invalidate_lock);
> > +	if (mapping2 && mapping1 != mapping2)
> > +		down_write_nested(&mapping2->invalidate_lock, 1);
> > +}
> > +EXPORT_SYMBOL(filemap_invalidate_down_write_two);
> > +
> > +/*
> > + * filemap_invalidate_up_write_two - unlock invalidate_lock for two mappings
> > + *
> > + * Unlock exclusive invalidate_lock of any passed mapping that is not NULL.
> > + *
> > + * @mapping1: the first mapping to unlock
> > + * @mapping2: the second mapping to unlock
> > + */
> > +void filemap_invalidate_up_write_two(struct address_space *mapping1,
> > +				     struct address_space *mapping2)
> > +{
> > +	if (mapping1)
> > +		up_write(&mapping1->invalidate_lock);
> > +	if (mapping2 && mapping1 != mapping2)
> > +		up_write(&mapping2->invalidate_lock);
> > +}
> > +EXPORT_SYMBOL(filemap_invalidate_up_write_two);
> > +
> >  /*
> >   * In order to wait for pages to become available there must be
> >   * waitqueues associated with pages. By using a hash table of
> > -- 
> > 2.26.2
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
