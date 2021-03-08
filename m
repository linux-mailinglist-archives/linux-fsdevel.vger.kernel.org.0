Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3B3319C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 22:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhCHV4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 16:56:21 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:56725 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhCHVzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:55:48 -0500
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 29E148289A3;
        Tue,  9 Mar 2021 08:55:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lJNqh-000HG4-6L; Tue, 09 Mar 2021 08:55:35 +1100
Date:   Tue, 9 Mar 2021 08:55:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fscache: Redesigning the on-disk cache
Message-ID: <20210308215535.GA63242@dread.disaster.area>
References: <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com>
 <2653261.1614813611@warthog.procyon.org.uk>
 <517184.1615194835@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517184.1615194835@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=tj5_YPy7viIAn9pg2yAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:13:55AM +0000, David Howells wrote:
> Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > >  (0a) As (0) but using SEEK_DATA/SEEK_HOLE instead of bmap and opening the
> > >       file for every whole operation (which may combine reads and writes).
> > 
> > I read that NFSv4 supports hole punching, so when using ->bmap() or SEEK_DATA
> > to keep track of present data, it's hard to distinguish between an
> > invalid cached range and a valid "cached hole".
> 
> I wasn't exactly intending to permit caching over NFS.  That leads to fun
> making sure that the superblock you're caching isn't the one that has the
> cache in it.
> 
> However, we will need to handle hole-punching being done on a cached netfs,
> even if that's just to completely invalidate the cache for that file.
> 
> > With ->fiemap() you can at least make the distinction between a non existing
> > and an UNWRITTEN extent.
> 
> I can't use that for XFS, Ext4 or btrfs, I suspect.  Christoph and Dave's
> assertion is that the cache can't rely on the backing filesystem's metadata
> because these can arbitrarily insert or remove blocks of zeros to bridge or
> split extents.

Well, that's not the big problem. The issue that makes FIEMAP
unusable for determining if there is user data present in a file is
that on-disk extent maps aren't exactly coherent with in-memory user
data state.

That is, we can have a hole on disk with delalloc user data in
memory.  There's user data in the file, just not on disk. Same goes
for unwritten extents - there can be dirty data in memory over an
unwritten extent, and it won't get converted to written until the
data is written back and the filesystem runs a conversion
transaction.

So, yeah, if you use FIEMAP to determine where data lies in a file
that is being actively modified, you're going get corrupt data
sooner rather than later.  SEEK_HOLE/DATA are coherent with in
memory user data, so don't have this problem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
