Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EE114A85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 02:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfLFBbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 20:31:16 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:49623 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfLFBbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:31:16 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 57CEB7E9F1E;
        Fri,  6 Dec 2019 12:31:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1id2Sd-0007VB-0H; Fri, 06 Dec 2019 12:31:11 +1100
Date:   Fri, 6 Dec 2019 12:31:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Message-ID: <20191206013110.GR2695@dread.disaster.area>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
 <20191127202136.GV6211@magnolia>
 <20191201210519.GB2418@dread.disaster.area>
 <52f1afb6e0a2026840da6f4b98a5e01a247447e5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f1afb6e0a2026840da6f4b98a5e01a247447e5.camel@hammerspace.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=VsxxF31QQODBYBkOMZoA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 07:36:29AM +0000, Trond Myklebust wrote:
> On Mon, 2019-12-02 at 08:05 +1100, Dave Chinner wrote:
> > On Wed, Nov 27, 2019 at 12:21:36PM -0800, Darrick J. Wong wrote:
> > > On Wed, Nov 27, 2019 at 06:38:46PM +0000, Trond Myklebust wrote:
> > > > Hi all
> > > > 
> > > > A quick question about clone_range() and guarantees around
> > > > metadata
> > > > stability.
> > > > 
> > > > Are users required to call fsync/fsync_range() after calling
> > > > clone_range() in order to guarantee that the cloned range
> > > > metadata is
> > > > persisted?
> > > 
> > > Yes.
> > > 
> > > > I'm assuming that it is required in order to guarantee that
> > > > data is persisted.
> > > 
> > > Data and metadata.  XFS and ocfs2's reflink implementations will
> > > flush
> > > the page cache before starting the remap, but they both require
> > > fsync to
> > > force the log/journal to disk.
> > 
> > So we need to call xfs_fs_nfs_commit_metadata() to get that done
> > post vfs_clone_file_range() completion on the server side, yes?
> > 
> 
> I chose to implement this using a full call to vfs_fsync_range(), since
> we really do want to ensure data stability as well. Consider, for
> instance, the case where client A is running an application, and client
> B runs vfs_clone_file_range() in order to create a point in time
> snapshot of the file for disaster recovery purposes...

Data stability should already be handled by vfs_clone_file_range()
followed by ->commit_metadata. Clone requires local filesystem side
data stability to guarantee the atomicity of the clone operation.
Hence we lock out concurrent modifications to both the source and
desination files, sync any dirty data over the source and
destination ranges of the clone, and only then do we do the
metadata modification. See generic_remap_file_range_prep().

So, AFAICT, a post-vfs_clone_file_range() call to ->commit_metadata
is all that is necessary to force the metadata to stable storage and
the corresponding disk cache flush will guarantee that both data and
metadata are on stable storage....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
