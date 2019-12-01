Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8F10E385
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 22:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLAVFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 16:05:25 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57952 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbfLAVFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 16:05:25 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 759FA3A0A97;
        Mon,  2 Dec 2019 08:05:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibWP9-00056e-SX; Mon, 02 Dec 2019 08:05:19 +1100
Date:   Mon, 2 Dec 2019 08:05:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Message-ID: <20191201210519.GB2418@dread.disaster.area>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
 <20191127202136.GV6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127202136.GV6211@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=y7B9AfDEBtBswh77-68A:9 a=Sca554UL9fLBSYta:21
        a=MLJJ3OMF_MbDVCWc:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:21:36PM -0800, Darrick J. Wong wrote:
> On Wed, Nov 27, 2019 at 06:38:46PM +0000, Trond Myklebust wrote:
> > Hi all
> > 
> > A quick question about clone_range() and guarantees around metadata
> > stability.
> > 
> > Are users required to call fsync/fsync_range() after calling
> > clone_range() in order to guarantee that the cloned range metadata is
> > persisted?
> 
> Yes.
> 
> > I'm assuming that it is required in order to guarantee that
> > data is persisted.
> 
> Data and metadata.  XFS and ocfs2's reflink implementations will flush
> the page cache before starting the remap, but they both require fsync to
> force the log/journal to disk.

So we need to call xfs_fs_nfs_commit_metadata() to get that done
post vfs_clone_file_range() completion on the server side, yes?

> 
> (AFAICT the same reasoning applies to btrfs, but don't trust my word for
> it.)
> 
> > I'm asking because knfsd currently just does a call to
> > vfs_clone_file_range() when parsing a NFSv4.2 CLONE operation. It does
> > not call fsync()/fsync_range() on the destination file, and since the
> > NFSv4.2 protocol does not require you to perform any other operation in
> > order to persist data/metadata, I'm worried that we may be corrupting
> > the cloned file if the NFS server crashes at the wrong moment after the
> > client has been told the clone completed.

Yup, that's exactly what server side calls to commit_metadata() are
supposed to address.

I suspect to be correct, this might require commit_metadata() to be
called on both the source and destination inodes, as both of them
may have modified metadata as a result of the clone operation. For
XFS one of them will be a no-op, but for other filesystems that
don't implement ->commit_metadata, we'll need to call
sync_inode_metadata() on both inodes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
