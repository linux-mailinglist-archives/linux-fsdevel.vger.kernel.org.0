Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7295D457E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFNIw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 04:52:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfFNIw0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:52:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F13A3B02E;
        Fri, 14 Jun 2019 08:52:23 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and update timestamps
References: <20190610174007.4818-1-amir73il@gmail.com>
        <ed2e4b5d26890e96ba9dafcb3dba88427e36e619.camel@kernel.org>
        <87zhml7ada.fsf@suse.com>
        <38f6f71f6be0b5baaea75417aa4bcf072e625567.camel@kernel.org>
Date:   Fri, 14 Jun 2019 09:52:21 +0100
In-Reply-To: <38f6f71f6be0b5baaea75417aa4bcf072e625567.camel@kernel.org> (Jeff
        Layton's message of "Thu, 13 Jun 2019 13:48:42 -0400")
Message-ID: <87v9x87dmi.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2019-06-13 at 16:50 +0100, Luis Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > On Mon, 2019-06-10 at 20:40 +0300, Amir Goldstein wrote:
>> > > Because ceph doesn't hold destination inode lock throughout the copy,
>> > > strip setuid bits before and after copy.
>> > > 
>> > > The destination inode mtime is updated before and after the copy and the
>> > > source inode atime is updated after the copy, similar to the filesystem
>> > > ->read_iter() implementation.
>> > > 
>> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> > > ---
>> > > 
>> > > Hi Ilya,
>> > > 
>> > > Please consider applying this patch to ceph branch after merging
>> > > Darrick's copy-file-range-fixes branch from:
>> > >         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>> > > 
>> > > The series (including this patch) was tested on ceph by
>> > > Luis Henriques using new copy_range xfstests.
>> > > 
>> > > AFAIK, only fallback from ceph to generic_copy_file_range()
>> > > implementation was tested and not the actual ceph clustered
>> > > copy_file_range.
>> > > 
>> > > Thanks,
>> > > Amir.
>> > > 
>> > >  fs/ceph/file.c | 17 +++++++++++++++++
>> > >  1 file changed, 17 insertions(+)
>> > > 
>> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> > > index c5517ffeb11c..b04c97c7d393 100644
>> > > --- a/fs/ceph/file.c
>> > > +++ b/fs/ceph/file.c
>> > > @@ -1949,6 +1949,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>> > >  		goto out;
>> > >  	}
>> > >  
>> > > +	/* Should dst_inode lock be held throughout the copy operation? */
>> > > +	inode_lock(dst_inode);
>> > > +	ret = file_modified(dst_file);
>> > > +	inode_unlock(dst_inode);
>> > > +	if (ret < 0) {
>> > > +		dout("failed to modify dst file before copy (%zd)\n", ret);
>> > > +		goto out;
>> > > +	}
>> > > +
>> > 
>> > I don't see anything that guarantees that the mode of the destination
>> > file is up to date at this point. file_modified() just ends up checking
>> > the mode cached in the inode.
>> > 
>> > I wonder if we ought to fix get_rd_wr_caps() to also acquire a reference
>> > to AUTH_SHARED caps on the destination inode, and then call
>> > file_modified() after we get those caps. That would also mean that we
>> > wouldn't need to do this a second time after the copy.
>> > 
>> > The catch is that if we did need to issue a setattr, I'm not sure if
>> > we'd need to release those caps first.
>> > 
>> > Luis, Zheng, thoughts?
>> 
>> Hmm... I missed that.  IIRC the FILE_WR caps allow to modify some
>> metadata (such as timestamps, and file size).  I suppose it doesn't
>> allow to cache the mode, does it? 
>
> No, W caps don't guarantee that the mode won't change. You need As or Ax
> caps for that.
>
>>  If it does, fixing it would be a
>> matter of moving the code a bit further down.  If it doesn't the
>> ceph_copy_file_range function already has this problem, as it calls
>> file_update_time.  And I wonder if other code paths have this problem
>> too.
>> 
>
> I think you mean file_remove_privs, but yes...the write codepath has a
> similar problem. file_remove_privs is called before acquiring any caps,
> so the same thing could happen there too.
>
> It'd be good to fix both places, but taking As cap references in the
> write codepath could have performance impact in some cases. OTOH, they
> don't change that much, so maybe that's OK.
>
>> Obviously, the chunk below will have the same problem.
>> 
>
> Right. If however, we have this code take an As cap reference before
> doing the copy, then we can be sure that the mode can't change until we
> drop them. That way we wouldn't need the second call.

So, do you think the patch below would be enough?  It's totally
untested, but I wanted to know if that would be acceptable before
running some tests on it.

Cheers,
-- 
Luis

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c5517ffeb11c..f6b0683dd8dc 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1949,6 +1949,21 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		goto out;
 	}
 
+	ret = ceph_do_getattr(dst_inode, CEPH_CAP_AUTH_SHARED, false);
+	if (ret < 0) {
+		dout("failed to get auth caps on dst file (%zd)\n", ret);
+		goto out;
+	}
+
+	/* Should dst_inode lock be held throughout the copy operation? */
+	inode_lock(dst_inode);
+	ret = file_modified(dst_file);
+	inode_unlock(dst_inode);
+	if (ret < 0) {
+		dout("failed to modify dst file before copy (%zd)\n", ret);
+		goto out;
+	}
+
 	/*
 	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
 	 * clients may have dirty data in their caches.  And OSDs know nothing
