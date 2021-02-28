Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAA3274E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 23:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhB1Wjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 17:39:35 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47679 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230167AbhB1Wje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 17:39:34 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7E4FD1041250;
        Mon,  1 Mar 2021 09:38:47 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lGUi6-008ztl-Kp; Mon, 01 Mar 2021 09:38:46 +1100
Date:   Mon, 1 Mar 2021 09:38:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
Message-ID: <20210228223846.GA4662@dread.disaster.area>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia>
 <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area>
 <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area>
 <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area>
 <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=TP_jekbwqI1TK37FQS4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 03:40:24PM -0800, Dan Williams wrote:
> On Sat, Feb 27, 2021 at 2:36 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Feb 26, 2021 at 02:41:34PM -0800, Dan Williams wrote:
> > > On Fri, Feb 26, 2021 at 1:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Fri, Feb 26, 2021 at 12:59:53PM -0800, Dan Williams wrote:
> > it points to, check if it points to the PMEM that is being removed,
> > grab the page it points to, map that to the relevant struct page,
> > run collect_procs() on that page, then kill the user processes that
> > map that page.
> >
> > So why can't we walk the ptescheck the physical pages that they
> > map to and if they map to a pmem page we go poison that
> > page and that kills any user process that maps it.
> >
> > i.e. I can't see how unexpected pmem device unplug is any different
> > to an MCE delivering a hwpoison event to a DAX mapped page.
> 
> I guess the tradeoff is walking a long list of inodes vs walking a
> large array of pages.

Not really. You're assuming all a filesystem has to do is invalidate
everything if a device goes away, and that's not true. Finding if an
inode has a mapping that spans a specific device in a multi-device
filesystem can be a lot more complex than that. Just walking inodes
is easy - determining whihc inodes need invalidation is the hard
part.

That's where ->corrupt_range() comes in - the filesystem is already
set up to do reverse mapping from physical range to inode(s)
offsets...

> There's likely always more pages than inodes, but perhaps it's more
> efficient to walk the 'struct page' array than sb->s_inodes?

I really don't see you seem to be telling us that invalidation is an
either/or choice. There's more ways to convert physical block
address -> inode file offset and mapping index than brute force
inode cache walks....

.....

> > IOWs, what needs to happen at this point is very filesystem
> > specific. Assuming that "device unplug == filesystem dead" is not
> > correct, nor is specifying a generic action that assumes the
> > filesystem is dead because a device it is using went away.
> 
> Ok, I think I set this discussion in the wrong direction implying any
> mapping of this action to a "filesystem dead" event. It's just a "zap
> all ptes" event and upper layers recover from there.

Yes, that's exactly what ->corrupt_range() is intended for. It
allows the filesystem to lock out access to the bad range
and then recover the data. Or metadata, if that's where the bad
range lands. If that recovery fails, it can then report a data
loss/filesystem shutdown event to userspace and kill user procs that
span the bad range...

FWIW, is this notification going to occur before or after the device
has been physically unplugged? i.e. what do we do about the
time-of-unplug-to-time-of-invalidation window where userspace can
still attempt to access the missing pmem though the
not-yet-invalidated ptes? It may not be likely that people just yank
pmem nvdimms out of machines, but with NVMe persistent memory
spaces, there's every chance that someone pulls the wrong device...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
