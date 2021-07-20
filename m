Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F234D3D022C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhGTSrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 14:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhGTSrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626809249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q/d/LJIq20gccDCxNrTxAI8zEP6GHLRdmU5ruw0kxIg=;
        b=hxihkticV2rbw51z7LZ6oHuv1ymNQmqwAffILN2HoBQlF8uuiHWcTkDc6D5y1eLKyKz/Or
        4zAnIKrGrWjDvb73pGzLFA4xUYjtEj40LsgIPkD2hZyMZS71p9S1LDNj4/jw6eXOplXqYq
        Mkhi0GbR76YDoIFCtAU09Ch3TU+EvM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ENyoAwCvN8i5aRgIUOrEiQ-1; Tue, 20 Jul 2021 15:27:26 -0400
X-MC-Unique: ENyoAwCvN8i5aRgIUOrEiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 794D51835AC2;
        Tue, 20 Jul 2021 19:27:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-228.rdu2.redhat.com [10.10.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D04760583;
        Tue, 20 Jul 2021 19:27:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 24F59223E70; Tue, 20 Jul 2021 15:27:16 -0400 (EDT)
Date:   Tue, 20 Jul 2021 15:27:16 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPcjlN1ThL4UX8dn@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXWA+Uo5vFuHCH0@redhat.com>
 <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 02:51:34PM +0800, JeffleXu wrote:
> 
> 
> On 7/20/21 3:44 AM, Vivek Goyal wrote:
> > On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
> >> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> >> this file.
> >>
> >> When the per-file DAX flag changes for an *opened* file, the state of
> >> the file won't be updated until this file is closed and reopened later.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  fs/fuse/dax.c             | 21 +++++++++++++++++----
> >>  fs/fuse/file.c            |  4 ++--
> >>  fs/fuse/fuse_i.h          |  5 +++--
> >>  fs/fuse/inode.c           |  5 ++++-
> >>  include/uapi/linux/fuse.h |  5 +++++
> >>  5 files changed, 31 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> >> index a478e824c2d0..0e862119757a 100644
> >> --- a/fs/fuse/dax.c
> >> +++ b/fs/fuse/dax.c
> >> @@ -1341,7 +1341,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
> >>  	.invalidatepage	= noop_invalidatepage,
> >>  };
> >>  
> >> -static bool fuse_should_enable_dax(struct inode *inode)
> >> +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
> >>  {
> >>  	struct fuse_conn *fc = get_fuse_conn(inode);
> >>  	unsigned int mode;
> >> @@ -1354,18 +1354,31 @@ static bool fuse_should_enable_dax(struct inode *inode)
> >>  	if (mode == FUSE_DAX_MOUNT_NEVER)
> >>  		return false;
> >>  
> >> -	return true;
> >> +	if (mode == FUSE_DAX_MOUNT_ALWAYS)
> >> +		return true;
> >> +
> >> +	WARN_ON(mode != FUSE_DAX_MOUNT_INODE);
> >> +	return flags & FUSE_ATTR_DAX;
> >>  }
> >>  
> >> -void fuse_dax_inode_init(struct inode *inode)
> >> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
> >>  {
> >> -	if (!fuse_should_enable_dax(inode))
> >> +	if (!fuse_should_enable_dax(inode, flags))
> >>  		return;
> >>  
> >>  	inode->i_flags |= S_DAX;
> >>  	inode->i_data.a_ops = &fuse_dax_file_aops;
> >>  }
> >>  
> >> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
> >> +{
> >> +	struct fuse_conn *fc = get_fuse_conn(inode);
> >> +
> >> +	if (fc->dax && fc->dax->mode == FUSE_DAX_MOUNT_INODE &&
> >> +	    IS_DAX(inode) != newdax)
> >> +		d_mark_dontcache(inode);
> >> +}
> >> +
> > 
> > This capability to mark an inode dontcache should probably be in a
> > separate patch. These seem to logically two functionalities. One is
> > enabling DAX on an inode. And second is making sure how soon you
> > see the effect of that change and hence marking inode dontcache.
> 
> OK, sounds reasonable.
> 
> > 
> > Not sure how useful this is. In cache=none mode we should get rid of
> > inode ASAP. In cache=auto mode we will get rid of after 1 second (or
> > after a user specified timeout). So only place this seems to be
> > useful is cache=always.
> 
> Actually dontcache here is used to avoid dynamic switching between DAX
> and non-DAX state while file is opened. The complexity of dynamic
> switching is that, you have to clear the address_space, since page cache
> and DAX entry can not coexist in the address space. Besides,
> inode->a_ops also needs to be changed dynamically.
> 
> With dontcache, dynamic switching is no longer needed and the DAX state
> will be decided only when inode (in memory) is initialized. The downside
> is that the new DAX state won't be updated until the file is closed and
> reopened later.
> 
> 'cache=none' only invalidates dentry, while the inode (in memory) is
> still there (with address_space uncleared and a_ops unchanged).

Aha.., that's a good point.
> 
> The dynamic switching may be done, though it's not such straightforward.
> Currently, ext4/xfs are all implemented in this dontcache way, i.e., the
> new DAX state won't be seen until the file is closed and reopened later.

Got it. Agreed that dontcache seems reasonable if file's DAX state
has changed. Keep it in separate patch though with proper commit
logs.

Also, please copy virtiofs list (virtio-fs@redhat.com) when you post
patches next time.

Vivek

