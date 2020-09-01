Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2B25867B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgIADsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 23:48:42 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49203 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIADsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:48:42 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8FA5B3A7746;
        Tue,  1 Sep 2020 13:48:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kCxHg-0004Wo-4a; Tue, 01 Sep 2020 13:48:36 +1000
Date:   Tue, 1 Sep 2020 13:48:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200901034836.GG12096@dread.disaster.area>
References: <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
 <E7419E0D-6FF8-4E7E-B04A-835B0FE695B2@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E7419E0D-6FF8-4E7E-B04A-835B0FE695B2@dilger.ca>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=eBHbTIyNLBQfYuXCXi8A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:02:56PM -0600, Andreas Dilger wrote:
> On Aug 31, 2020, at 7:23 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Mon, Aug 31, 2020 at 01:51:20PM +0200, Miklos Szeredi wrote:
> >> On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> wrote:
> >> 
> >>> As I said to Dave, you and I have a strong difference of opinion here.
> >>> I think that what you are proposing is madness.  You're making it too
> >>> flexible which comes with too much opportunity for abuse.
> >> 
> >> Such as?
> > 
> > One proposal I saw earlier in this thread was to do something like
> > $ runalt /path/to/file ls
> > which would open_alt() /path/to/file, fchdir to it and run ls inside it.
> > That's just crazy.
> > 
> >>> I just want
> >>> to see alternate data streams for the same filename in order to support
> >>> existing use cases.  You seem to be able to want to create an entire
> >>> new world inside a file, and that's just too confusing.
> >> 
> >> To whom?  I'm sure users of ancient systems with a flat directory
> >> found directory trees very confusing.  Yet it turned out that the
> >> hierarchical system beat the heck out of the flat one.
> > 
> > Which doesn't mean that multiple semi-hidden hierarchies are going to
> > be better than one visible hierarchy.
> 
> I can see the use of ADS for "additional information" about a single file
> (e.g. verity Merkle tree with checksums of the file data) that are too big
> to put into an xattr and/or need random updates.  However, I don't see the
> benefits of attaching a whole arbitrary set of files to a single filename.
> 
> If people want a whole hierarchy of directories contained within a single
> file, why not use a container (e.g. ext4 filesystem image) to hold all of
> that?  That allows an arbitrary group of files/directories/permissions to
> be applied to a tree of files, but the container can be copied or removed
> atomically as needed?
> 
> Using a filesystem image as the container is (IMHO) preferable to using a
> tarball or similar, because it can be randomly updated after creation, and
> already has all of the semantics needed.

Yup, that's pretty much the premise behind the XFS subvolume stuff I
was exploring a while back. The file user data fork contains a
filesystem image, and the filesystem can mount them where-ever it
wants and manipulates the internal state as if it's just another
filesytem. It's essentially the equivalent of virtual LBA address
space mapping layer above the block layer.

And if your user data fork is capable of reflink and COW, then you
have atomically snapshottable virtually mapped filesystem containers
a.k.a. subvolumes.....

> The main thing that is needed is some mechanism that users can access that
> decides whether access to the image is as a file, or if processed should
> automount the image and descend into the contained namespace.

XFS used to have a IF_UUID inode type that was intended on Irix to
be a filesystem referral indicator. Kinda like a symlink, but it
just contained a UUID rather than a path. Traversing a IF_UUID inode
in the path would result in calling out to userspace to find the
filesystem with that UUID and automounting it in place, then it
would restart the path resolution and walk directly into the
filesystem that got mounted...

CHeers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
