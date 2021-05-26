Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32EE391BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhEZP1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 11:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235600AbhEZP05 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 11:26:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A6FB61378;
        Wed, 26 May 2021 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622042725;
        bh=/uzTTNLjF88gVIvVPehwcj9E7+SDKIBIEbe1++RMcCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQ7xuH3OSvQiH8WTyODIiNgCaa8VPSIlyo23vb9HtCWw7llMRo4A/QjKfRC588iEs
         cvBicODScd+zWU0/qy9HoNnaXPqGqeM7FPRW1d7eD3je2K9aXlvIXMfyoweXztaME1
         I14haJq08cG54aoOyPVUR07m+a8Dp3PTJnGilKvamk99idXs9eZcznD7NKdNQgHXzw
         MCmHriw/JX66+IvWWdkHQ8tSWchzi7nZ3ymLuHxR3qrqa5nDnh77qs3pFVtTGrDfYH
         PdRj3qcJPIWztj+xrh/HZE/cXxl9nVGPOJbQzuoNKF2vnF6COWpAHtFpeZnx4It663
         X4utnX24c9Niw==
Date:   Wed, 26 May 2021 08:25:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/13] mm: Add functions to lock invalidate_lock for two
 mappings
Message-ID: <20210526152525.GY202121@locust>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-4-jack@suse.cz>
 <20210525204805.GM202121@locust>
 <20210526100702.GB30369@quack2.suse.cz>
 <DM6PR04MB7081EBE7CE3404AB53F62795E7249@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210526134518.GF30369@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526134518.GF30369@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 03:45:18PM +0200, Jan Kara wrote:
> On Wed 26-05-21 12:11:43, Damien Le Moal wrote:
> > On 2021/05/26 19:07, Jan Kara wrote:
> > > On Tue 25-05-21 13:48:05, Darrick J. Wong wrote:
> > >> On Tue, May 25, 2021 at 03:50:41PM +0200, Jan Kara wrote:
> > >>> Some operations such as reflinking blocks among files will need to lock
> > >>> invalidate_lock for two mappings. Add helper functions to do that.
> > >>>
> > >>> Signed-off-by: Jan Kara <jack@suse.cz>
> > >>> ---
> > >>>  include/linux/fs.h |  6 ++++++
> > >>>  mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
> > >>>  2 files changed, 44 insertions(+)
> > >>>
> > >>> diff --git a/include/linux/fs.h b/include/linux/fs.h
> > >>> index 897238d9f1e0..e6f7447505f5 100644
> > >>> --- a/include/linux/fs.h
> > >>> +++ b/include/linux/fs.h
> > >>> @@ -822,6 +822,12 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
> > >>>  void lock_two_nondirectories(struct inode *, struct inode*);
> > >>>  void unlock_two_nondirectories(struct inode *, struct inode*);
> > >>>  
> > >>> +void filemap_invalidate_down_write_two(struct address_space *mapping1,
> > >>> +				       struct address_space *mapping2);
> > >>> +void filemap_invalidate_up_write_two(struct address_space *mapping1,
> > >>
> > >> TBH I find myself wishing that the invalidate_lock used the same
> > >> lock/unlock style wrappers that we use for i_rwsem.
> > >>
> > >> filemap_invalidate_lock(inode1->mapping);
> > >> filemap_invalidate_lock_two(inode1->i_mapping, inode2->i_mapping);
> > > 
> > > OK, and filemap_invalidate_lock_shared() for down_read()? I guess that
> > > works for me.
> > 
> > What about filemap_invalidate_lock_read() and filemap_invalidate_lock_write() ?
> > That reminds the down_read()/down_write() without the slightly confusing down/up.
> 
> Well, if we go for lock wrappers as Darrick suggested, I'd mirror naming
> used for inode_lock(). That is IMO the least confusing option... And that
> naming has _lock and _lock_shared suffixes.

I'd like filemap_invalidate_lock and filemap_invalidate_lock_shared.

--D

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
