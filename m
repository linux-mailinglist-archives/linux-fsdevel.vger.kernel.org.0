Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08A4C51EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 00:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiBYXHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 18:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiBYXHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:07:40 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16DF1223231;
        Fri, 25 Feb 2022 15:07:07 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 898E910E26DE;
        Sat, 26 Feb 2022 10:07:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nNjfz-00GQeR-V9; Sat, 26 Feb 2022 10:07:03 +1100
Date:   Sat, 26 Feb 2022 10:07:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220225230703.GP3061737@dread.disaster.area>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
 <20220222224546.GE3061737@dread.disaster.area>
 <20220224044328.GB8269@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224044328.GB8269@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6219611a
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=ncrAElXAJjHIR6zcruwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 08:43:28PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 23, 2022 at 09:45:46AM +1100, Dave Chinner wrote:
> > On Tue, Feb 22, 2022 at 01:24:50PM +1100, NeilBrown wrote:
> > > 
> > > Hi Al,
> > >  I wonder if you might find time to have a look at this patch.  It
> > >  allows concurrent updates to a single directory.  This can result in
> > >  substantial throughput improvements when the application uses multiple
> > >  threads to create lots of files in the one directory, and there is
> > >  noticeable per-create latency, as there can be with NFS to a remote
> > >  server.
> > > Thanks,
> > > NeilBrown
> > > 
> > > Some filesystems can support parallel modifications to a directory,
> > > either because the modification happen on a remote server which does its
> > > own locking (e.g.  NFS) or because they can internally lock just a part
> > > of a directory (e.g.  many local filesystems, with a bit of work - the
> > > lustre project has patches for ext4 to support concurrent updates).
> > > 
> > > To allow this, we introduce VFS support for parallel modification:
> > > unlink (including rmdir) and create.  Parallel rename is not (yet)
> > > supported.
> > 
> > Yay!
> > 
> > > If a filesystem supports parallel modification in a given directory, it
> > > sets S_PAR_UNLINK on the inode for that directory.  lookup_open() and
> > > the new lookup_hash_modify() (similar to __lookup_hash()) notice the
> > > flag and take a shared lock on the directory, and rely on a lock-bit in
> > > d_flags, much like parallel lookup relies on DCACHE_PAR_LOOKUP.
> > 
> > I suspect that you could enable this for XFS right now. XFS has internal
> > directory inode locking that should serialise all reads and writes
> > correctly regardless of what the VFS does. So while the VFS might
> > use concurrent updates (e.g. inode_lock_shared() instead of
> > inode_lock() on the dir inode), XFS has an internal metadata lock
> > that will then serialise the concurrent VFS directory modifications
> > correctly....
> 
> I don't think that will work because xfs_readdir doesn't hold the
> directory ILOCK while it runs, which means that readdir will see garbage
> if other threads now only hold inode_lock_shared while they update the
> directory.

It repeated picks up and drops the ILOCK as it maps buffers. IOWs,
the ILOCK serialises the lookup of the buffer at the next offset in
the readdir process and then reads the data out while the buffer is
locked. Hence we'll always serialise the buffer lookup and read
against concurrent modifications so we'll always get the next
directory buffer in ascending offset order. We then hold the buffer locked
while we read all the dirents out of it into the user buffer, so
that's also serialised against concurrent modifications.

Also, remember that readdir does not guarantee that it returns all
entries in the face of concurrent modifications that remove entries.
Because the offset of dirents never changes in the XFS data segment,
the only time we might skip an entry is when it has been removed
and it was the last entry in a data block so the entire data block
goes away between readdir buffer lookups. In that case, we just get
the next highest offset buffer returned, and we continue onwards.

If a hole is filled while we are walking, then we'll see the buffer
that was added into the hole. That new buffer is now at the next
highest offset, so readdir finding it is correct and valid
behaviour...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
