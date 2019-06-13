Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF0449E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfFMRsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 13:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFMRsq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:48:46 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4875420679;
        Thu, 13 Jun 2019 17:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560448125;
        bh=7J9Nux+2C7/bgk/c109GwybQXNMP+OZJrJQ0WKB2MDM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wKmxMYeeuohRNBfiKXFRf1epHECIGe5dPVdzTEFHQDjCtiR74X9OavoanZKTgyiUt
         EMitOqcLudxyeomD3SNbtVkmWJ5D7uZj6hI/tonNLptuxsdQ4Q7UWUEW295pwFJZcM
         MHA3sLBS+KqyPcfvaRvjWl4thZAHgj2Mxh7gi06s=
Message-ID: <38f6f71f6be0b5baaea75417aa4bcf072e625567.camel@kernel.org>
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and
 update timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Date:   Thu, 13 Jun 2019 13:48:42 -0400
In-Reply-To: <87zhml7ada.fsf@suse.com>
References: <20190610174007.4818-1-amir73il@gmail.com>
         <ed2e4b5d26890e96ba9dafcb3dba88427e36e619.camel@kernel.org>
         <87zhml7ada.fsf@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-06-13 at 16:50 +0100, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > On Mon, 2019-06-10 at 20:40 +0300, Amir Goldstein wrote:
> > > Because ceph doesn't hold destination inode lock throughout the copy,
> > > strip setuid bits before and after copy.
> > > 
> > > The destination inode mtime is updated before and after the copy and the
> > > source inode atime is updated after the copy, similar to the filesystem
> > > ->read_iter() implementation.
> > > 
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > > 
> > > Hi Ilya,
> > > 
> > > Please consider applying this patch to ceph branch after merging
> > > Darrick's copy-file-range-fixes branch from:
> > >         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > > 
> > > The series (including this patch) was tested on ceph by
> > > Luis Henriques using new copy_range xfstests.
> > > 
> > > AFAIK, only fallback from ceph to generic_copy_file_range()
> > > implementation was tested and not the actual ceph clustered
> > > copy_file_range.
> > > 
> > > Thanks,
> > > Amir.
> > > 
> > >  fs/ceph/file.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > index c5517ffeb11c..b04c97c7d393 100644
> > > --- a/fs/ceph/file.c
> > > +++ b/fs/ceph/file.c
> > > @@ -1949,6 +1949,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >  		goto out;
> > >  	}
> > >  
> > > +	/* Should dst_inode lock be held throughout the copy operation? */
> > > +	inode_lock(dst_inode);
> > > +	ret = file_modified(dst_file);
> > > +	inode_unlock(dst_inode);
> > > +	if (ret < 0) {
> > > +		dout("failed to modify dst file before copy (%zd)\n", ret);
> > > +		goto out;
> > > +	}
> > > +
> > 
> > I don't see anything that guarantees that the mode of the destination
> > file is up to date at this point. file_modified() just ends up checking
> > the mode cached in the inode.
> > 
> > I wonder if we ought to fix get_rd_wr_caps() to also acquire a reference
> > to AUTH_SHARED caps on the destination inode, and then call
> > file_modified() after we get those caps. That would also mean that we
> > wouldn't need to do this a second time after the copy.
> > 
> > The catch is that if we did need to issue a setattr, I'm not sure if
> > we'd need to release those caps first.
> > 
> > Luis, Zheng, thoughts?
> 
> Hmm... I missed that.  IIRC the FILE_WR caps allow to modify some
> metadata (such as timestamps, and file size).  I suppose it doesn't
> allow to cache the mode, does it? 

No, W caps don't guarantee that the mode won't change. You need As or Ax
caps for that.

>  If it does, fixing it would be a
> matter of moving the code a bit further down.  If it doesn't the
> ceph_copy_file_range function already has this problem, as it calls
> file_update_time.  And I wonder if other code paths have this problem
> too.
> 

I think you mean file_remove_privs, but yes...the write codepath has a
similar problem. file_remove_privs is called before acquiring any caps,
so the same thing could happen there too.

It'd be good to fix both places, but taking As cap references in the
write codepath could have performance impact in some cases. OTOH, they
don't change that much, so maybe that's OK.

> Obviously, the chunk below will have the same problem.
> 

Right. If however, we have this code take an As cap reference before
doing the copy, then we can be sure that the mode can't change until we
drop them. That way we wouldn't need the second call.

-- 
Jeff Layton <jlayton@kernel.org>

