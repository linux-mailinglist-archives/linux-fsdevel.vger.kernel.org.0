Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6092567C5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 09:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjAZIYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 03:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZIYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:24:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C176C46162;
        Thu, 26 Jan 2023 00:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FA161755;
        Thu, 26 Jan 2023 08:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27F5C433D2;
        Thu, 26 Jan 2023 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674721443;
        bh=+MDfSw8ecbR1iO4aRZGe7ix3d1cZaEFTWeP/rWDj4g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxPdHcQ6wYGhz9Hsm6z7f5vj42FNvlg0OtLGUTEyfNHCdyciRjS4dOG3jvHiMFeSx
         cvUt2BNS2E44e3b1+NlCOji+qgYTsk1F6col1shQvrPdcYVhWPY0xlDwDYyJH24NiT
         8uwff/PvVc5sIKG3DVggN6qO7giEAPJxCclyNQbzhP/lRJlCA0iAVVGBaAdK5EqmYL
         Wk4xBzez1fTxPNEGvxGCqLk3Epv1Xxs0bMw3DVF5BzYZDbpDYCG3/R2vSTnSl2azuq
         X6hvhEXDfC13YO7gBZCVXj7MnWc3Xze5ZzsaWWIwMdCN3vGqJkQKqp7pa9qfx2XYLd
         JfOeXOPVgKsKg==
Date:   Thu, 26 Jan 2023 09:23:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 RESEND 3/8] vfs: plumb i_version handling into struct
 kstat
Message-ID: <20230126082355.ejgunkoqr4kocz3b@wittgenstein>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-4-jlayton@kernel.org>
 <20230125155059.u22lmktpylymmruo@wittgenstein>
 <275450f6a909a640a416860b13a35769d253ab1b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <275450f6a909a640a416860b13a35769d253ab1b.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 01:30:07PM -0500, Jeff Layton wrote:
> On Wed, 2023-01-25 at 16:50 +0100, Christian Brauner wrote:
> > On Tue, Jan 24, 2023 at 02:30:20PM -0500, Jeff Layton wrote:
> > > The NFS server has a lot of special handling for different types of
> > > change attribute access, depending on the underlying filesystem. In
> > > most cases, it's doing a getattr anyway and then fetching that value
> > > after the fact.
> > > 
> > > Rather that do that, add a new STATX_CHANGE_COOKIE flag that is a
> > > kernel-only symbol (for now). If requested and getattr can implement it,
> > > it can fill out this field. For IS_I_VERSION inodes, add a generic
> > > implementation in vfs_getattr_nosec. Take care to mask
> > > STATX_CHANGE_COOKIE off in requests from userland and in the result
> > > mask.
> > > 
> > > Since not all filesystems can give the same guarantees of monotonicity,
> > > claim a STATX_ATTR_CHANGE_MONOTONIC flag that filesystems can set to
> > > indicate that they offer an i_version value that can never go backward.
> > > 
> > > Eventually if we decide to make the i_version available to userland, we
> > > can just designate a field for it in struct statx, and move the
> > > STATX_CHANGE_COOKIE definition to the uapi header.
> > > 
> > > Reviewed-by: NeilBrown <neilb@suse.de>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/stat.c            | 17 +++++++++++++++--
> > >  include/linux/stat.h |  9 +++++++++
> > >  2 files changed, 24 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index d6cc74ca8486..f43afe0081fe 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/syscalls.h>
> > >  #include <linux/pagemap.h>
> > >  #include <linux/compat.h>
> > > +#include <linux/iversion.h>
> > >  
> > >  #include <linux/uaccess.h>
> > >  #include <asm/unistd.h>
> > > @@ -122,6 +123,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> > >  	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
> > >  				  STATX_ATTR_DAX);
> > >  
> > > +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > > +		stat->result_mask |= STATX_CHANGE_COOKIE;
> > > +		stat->change_cookie = inode_query_iversion(inode);
> > > +	}
> > > +
> > >  	mnt_userns = mnt_user_ns(path->mnt);
> > >  	if (inode->i_op->getattr)
> > >  		return inode->i_op->getattr(mnt_userns, path, stat,
> > > @@ -602,9 +608,11 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
> > >  
> > >  	memset(&tmp, 0, sizeof(tmp));
> > >  
> > > -	tmp.stx_mask = stat->result_mask;
> > > +	/* STATX_CHANGE_COOKIE is kernel-only for now */
> > > +	tmp.stx_mask = stat->result_mask & ~STATX_CHANGE_COOKIE;
> > >  	tmp.stx_blksize = stat->blksize;
> > > -	tmp.stx_attributes = stat->attributes;
> > > +	/* STATX_ATTR_CHANGE_MONOTONIC is kernel-only for now */
> > > +	tmp.stx_attributes = stat->attributes & ~STATX_ATTR_CHANGE_MONOTONIC;
> > >  	tmp.stx_nlink = stat->nlink;
> > >  	tmp.stx_uid = from_kuid_munged(current_user_ns(), stat->uid);
> > >  	tmp.stx_gid = from_kgid_munged(current_user_ns(), stat->gid);
> > > @@ -643,6 +651,11 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
> > >  	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
> > >  		return -EINVAL;
> > >  
> > > +	/* STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
> > > +	 * from userland.
> > > +	 */
> > > +	mask &= ~STATX_CHANGE_COOKIE;
> > > +
> > >  	error = vfs_statx(dfd, filename, flags, &stat, mask);
> > >  	if (error)
> > >  		return error;
> > > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > > index ff277ced50e9..52150570d37a 100644
> > > --- a/include/linux/stat.h
> > > +++ b/include/linux/stat.h
> > 
> > Sorry being late to the party once again...
> > 
> > > @@ -52,6 +52,15 @@ struct kstat {
> > >  	u64		mnt_id;
> > >  	u32		dio_mem_align;
> > >  	u32		dio_offset_align;
> > > +	u64		change_cookie;
> > >  };
> > >  
> > > +/* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> > > +
> > > +/* mask values */
> > > +#define STATX_CHANGE_COOKIE		0x40000000U	/* Want/got stx_change_attr */
> > > +
> > > +/* file attribute values */
> > > +#define STATX_ATTR_CHANGE_MONOTONIC	0x8000000000000000ULL /* version monotonically increases */
> > 
> > maybe it would be better to copy what we do for SB_* vs SB_I_* flags and
> > at least rename them to:
> > 
> > STATX_I_CHANGE_COOKIE
> > STATX_I_ATTR_CHANGE_MONOTONIC
> > i_change_cookie
> 
> An "i_"/"I_" prefix says "inode" to me. Maybe I've been at this too
> long. ;)
> 
> > 
> > to visually distinguish internal and external flags.
> > 
> > And also if possible it might be useful to move STATX_I_* flags to the
> > higher 32 bits and then one can use upper_32_bits to retrieve kernel
> > internal flags and lower_32_bits for userspace flags in tiny wrappers.
> > 
> > (I did something similar for clone3() a few years ago but there to
> > distinguish between flags available both in clone() and clone3() and
> > such that are only available in clone3().)
> > 
> > But just a thought. I mostly worry about accidently leaking this to
> > userspace so ideally we'd even have separate fields in struct kstat for
> > internal and external attributes but that might bump kstat size, though
> > I don't think struct kstat is actually ever really allocated all that
> > much.
> 
> I'm not sure that the internal/external distinction matters much for
> filesystem providers or consumers of it. The place that it matters is at
> the userland interface level, where statx or something similar is
> called.
> 
> At some point we may want to make STATX_CHANGE_COOKIE queryable via
> statx, at which point we'll have to have a big flag day where we do
> s/STATX_I_CHANGE_COOKIE/STATX_CHANGE_COOKIE/.
> 
> I don't think it's worth it here.

I'm not fond of internal and external STATX_* flags having the exact
same name but fine. :)
