Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A0202DAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbgFUXg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 19:36:29 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:34105 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgFUXg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:36:28 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id A2EF410634C;
        Mon, 22 Jun 2020 09:36:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jn9Vb-000165-77; Mon, 22 Jun 2020 09:36:19 +1000
Date:   Mon, 22 Jun 2020 09:36:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Files dated before 1970
Message-ID: <20200621233619.GB2040@dread.disaster.area>
References: <20200620021611.GD8681@bombadil.infradead.org>
 <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=1IRuNBlthIabty98T_MA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:59:48AM +0200, Arnd Bergmann wrote:
> On Sat, Jun 20, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >
> > Hi Deepa,
> >
> > Your commit 95582b008388 ("vfs: change inode times to use struct
> > timespec64") changed the behaviour of some filesystems with regards to
> > files from before 1970.  Specifically, this line from JFS, unchanged
> > since before 2.6.12:
> >
> > fs/jfs/jfs_imap.c:3065: ip->i_atime.tv_sec = le32_to_cpu(dip->di_atime.tv_sec);
> >
> > le32_to_cpu() returns a u32.  Before your patch, the u32 was assigned
> > to an s32, so a file with a date stamp of 1968 would show up that way.
> > After your patch, the u32 is zero-extended to an s64, so a file from
> > 1968 now appears to be from 2104.
> >
> > Obviously there aren't a lot of files around from before 1970, so it's
> > not surprising that nobody's noticed yet.  But I don't think this was
> > an intended change.
> 
> In the case of JFS, I think the change of behavior on 32-bit kernels was
> intended because it makes them do the same thing as 64-bit kernels.
> I'm sure Deepa or I documented this somewhere but unfortunately it's
> not clear from the commit description that actually made the transition :(.
> 
> > The fix is simple; cast the result to (int) like XFS and ext2 do.
> > But someone needs to go through all the filesystems with care.  And it'd
> > be great if someone wrote an xfstest for handling files from 1968.
> 
> I'm sure the xfstests check was added back when XFS and ext3 decided to
> stick with the behavior of 32-bit kernels in order to avoid an
> inadvertent change when 64-bit kernels originally became popular.


$ ./lsqa.pl tests/generic/258

FS QA Test No. 258

Test timestamps prior to epoch
On 64-bit, ext2/3/4 was sign-extending when read from disk
See also commit 4d7bf11d649c72621ca31b8ea12b9c94af380e63

$

Commit 4d7bf11d649c ("ext2/3/4: fix file date underflow on ext2 3
filesystems on 64 bit systems") was indeed as you describe, but it
was only ext2/3/4 that had this problem. XFS has always had
consistent behaviour of timestamps across 32 and 64 bit systems
because that's what it inherited from Irix. :)

FWIW, this test was written in 2011, long before the y2038k work
started.  Hence if the filesystem does not pass generic/258, it's a
fair bet that JFS was broken on 64 bit kernels right from the
start....

Hmmm - generic/258 runs on filesystems where:

_require_negative_timestamps

does not abort the test.

Which, according to common/rc:

# exfat timestamps start at 1980 and cannot be prior to epoch
_require_negative_timestamps() {
        case "$FSTYP" in
        ceph|exfat)
                _notrun "$FSTYP does not support negative timestamps"
                ;;
        esac
}

Is every supported filesystem except exfat and ceph. Hence the list
of supported filesystems include:

	NFS, Glusterfs, CIFS, 9p, virtiofs, overlay, pvfs2, tmpfs
	ubifs, btrfs, ext2/3/4, XFS, JFS, reiserfs, reiser4, Btrfs,
	ocfs2, udf, gfs2, f2fs

So, really, if this is a long standing bug in the 64bit JFS
implementation in that it doesn't support negative timestamps, it
tells us that either nobody has been running fstests on 64-bit JFS
for almost 10 years or they are ignoring long standing failures.
Either way, it indicates that JFS really isn't being maintained by
anyone.

> For JFS and the others that already used an unsigned interpretation
> on 64 bit kernels, the current code seems to be the least broken
> of the three alternatives we had:

For anything that is actively maintained, it should be fixed to
pass generic/258 or have an exception added to
_require_negative_timestamps().

For filesystems that are not actively maintained, should we use this
as a sign we should seriously consider removing those filesystems
from the upstream tree?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
