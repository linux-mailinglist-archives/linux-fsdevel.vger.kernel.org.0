Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19D245A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgHQA3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Aug 2020 20:29:46 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36065 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgHQA3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Aug 2020 20:29:45 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DCD1D3A71A2;
        Mon, 17 Aug 2020 10:29:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k7T1m-0008DJ-WD; Mon, 17 Aug 2020 10:29:31 +1000
Date:   Mon, 17 Aug 2020 10:29:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200817002930.GB28218@dread.disaster.area>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816230908.GI17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=GJ-ECc16plR639piJPwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:09:08AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 17, 2020 at 08:56:20AM +1000, Dave Chinner wrote:
> > Indeed, most filesystems will not be able to implement ADS as
> > xattrs. xattrs are implemented as atomicly journalled metadata on
> > most filesytems, they cannot be used like a seekable file by
> > userspace at all. If you want ADS to masquerade as an xattr, then
> > you have to graft the entire file IO path onto filesytsem xattrs,
> > and that just ain't gonna work without a -lot- of development in
> > every filesystem that wants to support ADS.
> > 
> > We've already got a perfectly good presentation layer for user data
> > files that are accessed by file descriptors (i.e. directories
> > containing files), so that should be the presentation layer you seek
> > to extend.
> > 
> > IOWs, trying to use abuse xattrs for ADS support is a non-starter.
> 
> One thing Dave didn't mention is that a directory can have xattrs,
> forks and files (and acls).  So your presentation layer needs to not
> confuse one thing for another.

I'd stop calling these "forks" already, too. The user wants
"alternate data streams", while a "resource fork" is an internal
filesystem implementation detail used to provide ADS
functionality...

e.g. an XFS inode has a "data fork" which contains the extent tree
that points at user data.  This is a seekable fork. Directories
are also implemented internally in the data fork as directories are
seekable.

OTOH, the XFS inode has an "attr fork" which contains a key-value
btree which only supports record based operations. i.e. and records
can only be atomically updated via transactions. This is not a
seekable data store. xattrs are stored in this data store. The
key-value store supports multiple namespaces (e.g. system vs user)
so things like ACLs and security information can be stored as xattrs
and not be visible as user xattrs.

On the gripping hand, the XFS inode also has a virtual "COW fork"
which is used to track data fork regions that are in the process of
underdoing a copy-on-write operation. This is a shadow extent tree
that tracks the new location of the data until writeback occurs and
then the new location is atomically swapped back into the data
fork. This fork does not get exposed to userspace, nor does it ever
end up on disk - users do not know this fork even exists.

IOWs, historically speaking, a "fork" is something that is used to
implement different storage types and address spaces within an
inode, it's not a feature that is exposed to users and userspace.

To implement ADS, we'd likely consider adding a new physical inode
"ADS fork" which, internally, maps to a separate directory
structure. This provides us with the ADS namespace for each inode
and a mechanism that instantiates a physical inode per ADS. IOWs,
each ADS can be referenced by the VFS natively and independently as
an inode (native "file as a directory" semantics). Hence existing
create/unlink APIs work for managing ADS, readdir() can list all
your ADS, you can keep per ADS xattrs, etc....

IOWs, with a filesystem inode fork implementation like this for ADS,
all we really need is for the VFS to pass a magic command to
->lookup() to tell us to use the ADS namespace attached to the inode
rather than use the primary inode type/state to perform the
operation.

Hence all the ADS support infrastructure is essentially dentry cache
infrastructure allowing a dentry to be both a file and directory,
and providing the pathname resolution that recognises an ADS
redirection. Name that however you want - we've got to do an on-disk
format change to support ADS, so we can tell the VFS we support ADS
or not. And we have no cares about existing names in the filesystem
conflicting with the ADS pathname identifier because it's a mkfs
time decision. Given that special flags are needed for the openat()
call to resolve an ADS (e.g. O_ALT), we know if we should parse the
ADS identifier as an ADS the moment it is seen...

> I don't understand why a fork would be permitted to have its own
> permissions.  That makes no sense.  Silly Solaris.

I can't think of a reason why, either, but the above implementation
for XFS would support it if the presentation layer allows it... :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
