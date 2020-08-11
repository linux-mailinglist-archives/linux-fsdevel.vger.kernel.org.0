Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2B241F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgHKRzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 13:55:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgHKRzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597168540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3RR92GMCJJZ0VC4He3sC0Sni2KlxaOUk8hIIS0dPFI=;
        b=e61ZhJoGsiGE1WtV2hSBHy57w2+Zhhd94hdrGMgftU+xlu95OVvMRXJczHeqa6v5KiJSXS
        ih90VmBVpDIm2LnpTpn1QTGRVgv47JXmhyqmaimw2IfCzAUpLrK+ZOC872mgvlu+WBQOs5
        1b3q8ZxMEmte4fNhLmoWlYBJI30Qkzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-hyVnyBmVOnem-EKPGZyuwg-1; Tue, 11 Aug 2020 13:55:38 -0400
X-MC-Unique: hyVnyBmVOnem-EKPGZyuwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B84E8018A5;
        Tue, 11 Aug 2020 17:55:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-120.rdu2.redhat.com [10.10.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 399355FC01;
        Tue, 11 Aug 2020 17:55:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AB54C22036A; Tue, 11 Aug 2020 13:55:30 -0400 (EDT)
Date:   Tue, 11 Aug 2020 13:55:30 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH v2 15/20] fuse, dax: Take ->i_mmap_sem lock during dax
 page fault
Message-ID: <20200811175530.GB497326@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-16-vgoyal@redhat.com>
 <20200810222238.GD2079@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810222238.GD2079@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:22:38AM +1000, Dave Chinner wrote:
> On Fri, Aug 07, 2020 at 03:55:21PM -0400, Vivek Goyal wrote:
> > We need some kind of locking mechanism here. Normal file systems like
> > ext4 and xfs seems to take their own semaphore to protect agains
> > truncate while fault is going on.
> > 
> > We have additional requirement to protect against fuse dax memory range
> > reclaim. When a range has been selected for reclaim, we need to make sure
> > no other read/write/fault can try to access that memory range while
> > reclaim is in progress. Once reclaim is complete, lock will be released
> > and read/write/fault will trigger allocation of fresh dax range.
> > 
> > Taking inode_lock() is not an option in fault path as lockdep complains
> > about circular dependencies. So define a new fuse_inode->i_mmap_sem.
> 
> That's precisely why filesystems like ext4 and XFS define their own
> rwsem.
> 
> Note that this isn't a DAX requirement - the page fault
> serialisation is actually a requirement of hole punching...

Hi Dave,

I noticed that fuse code currently does not seem to have a rwsem which
can provide mutual exclusion between truncation/hole_punch path
and page fault path. I am wondering does that mean there are issues
with existing code or something else makes it unnecessary to provide
this mutual exlusion.

> 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/dir.c    |  2 ++
> >  fs/fuse/file.c   | 15 ++++++++++++---
> >  fs/fuse/fuse_i.h |  7 +++++++
> >  fs/fuse/inode.c  |  1 +
> >  4 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 26f028bc760b..f40766c0693b 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1609,8 +1609,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
> >  	 */
> >  	if ((is_truncate || !is_wb) &&
> >  	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
> > +		down_write(&fi->i_mmap_sem);
> >  		truncate_pagecache(inode, outarg.attr.size);
> >  		invalidate_inode_pages2(inode->i_mapping);
> > +		up_write(&fi->i_mmap_sem);
> >  	}
> >  
> >  	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index be7d90eb5b41..00ad27216cc3 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2878,11 +2878,18 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
> >  
> >  	if (write)
> >  		sb_start_pagefault(sb);
> > -
> > +	/*
> > +	 * We need to serialize against not only truncate but also against
> > +	 * fuse dax memory range reclaim. While a range is being reclaimed,
> > +	 * we do not want any read/write/mmap to make progress and try
> > +	 * to populate page cache or access memory we are trying to free.
> > +	 */
> > +	down_read(&get_fuse_inode(inode)->i_mmap_sem);
> >  	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
> >  
> >  	if (ret & VM_FAULT_NEEDDSYNC)
> >  		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
> > +	up_read(&get_fuse_inode(inode)->i_mmap_sem);
> >  
> >  	if (write)
> >  		sb_end_pagefault(sb);
> > @@ -3849,9 +3856,11 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> >  			file_update_time(file);
> >  	}
> >  
> > -	if (mode & FALLOC_FL_PUNCH_HOLE)
> > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > +		down_write(&fi->i_mmap_sem);
> >  		truncate_pagecache_range(inode, offset, offset + length - 1);
> > -
> > +		up_write(&fi->i_mmap_sem);
> > +	}
> >  	fuse_invalidate_attr(inode);
> 
> 
> I'm not sure this is sufficient. You have to lock page faults out
> for the entire time the hole punch is being performed, not just while
> the mapping is being invalidated.
> 
> That is, once you've taken the inode lock and written back the dirty
> data over the range being punched, you can then take a page fault
> and dirty the page again. Then after you punch the hole out,
> you have a dirty page with non-zero data in it, and that can get
> written out before the page cache is truncated.

Just for my better udnerstanding of the issue, I am wondering what
problem will it lead to. If one process is doing punch_hole and
other is writing in the range being punched, end result could be
anything. Either we will read zeroes from punched_hole pages or
we will read the data written by process writing to mmaped page, depending
on in what order it got executed. 

If that's the case, then holding fi->i_mmap_sem for the whole duration
might not matter. What am I missing?

Thanks
Vivek

> 
> IOWs, to do a hole punch safely, you have to both lock the inode
> and lock out page faults *before* you write back dirty data. Then
> you can invalidate the page cache so you know there is no cached
> data over the range about to be punched. Once the punch is done,
> then you can drop all locks....
> 
> The same goes for any other operation that manipulates extents
> directly (other fallocate ops, truncate, etc).
> 
> /me also wonders if there can be racing AIO+DIO in progress over the
> range that is being punched and whether fuse needs to call
> inode_dio_wait() before punching holes, running truncates, etc...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

