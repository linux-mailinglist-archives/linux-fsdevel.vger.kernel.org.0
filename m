Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC7131D23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 02:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgAGBYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 20:24:00 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51162 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbgAGBYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:24:00 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 24B547E9F69;
        Tue,  7 Jan 2020 12:23:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iodb7-000741-70; Tue, 07 Jan 2020 12:23:53 +1100
Date:   Tue, 7 Jan 2020 12:23:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sweet Tea Dorminy <sweettea@redhat.com>
Cc:     Tony Asleson <tasleson@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
Message-ID: <20200107012353.GO23195@dread.disaster.area>
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
 <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=W5MWU5QX0NKCcusCbkgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:19:07PM -0500, Sweet Tea Dorminy wrote:
> > > >> +
> > > >>    if (mp && mp->m_fsname) {
> > > >
> > > > mp->m_fsname is the name of the device we use everywhere for log
> > > > messages, it's set up at mount time so we don't have to do runtime
> > > > evaulation of the device name every time we need to emit the device
> > > > name in a log message.
> > > >
> > > > So, if you have some sooper speshial new device naming scheme, it
> > > > needs to be stored into the struct xfs_mount to replace mp->m_fsname.
> > >
> > > I don't think we want to replace mp->m_fsname with the vpd 0x83 device
> > > identifier.  This proposed change is adding a key/value structured data
> > > to the log message for non-ambiguous device identification over time,
> > > not to place the ID in the human readable portion of the message.  The
> > > existing name is useful too, especially when it involves a partition.
> >
> > Oh, if that's all you want to do, then why is this identifier needed
> > in every log message? It does not change over the life of the
> > filesystem, so it the persistent identifier only needs to be emitted
> > to the log once at filesystem mount time. i.e.  instead of:
> >
> > [    2.716841] XFS (dm-0): Mounting V5 Filesystem
> >
> > It just needs to be:
> >
> > [    2.716841] XFS (dm-0): Mounting V5 Filesystem on device <persistent dev id>
> >
> > If you need to do any sort of special "is this the right device"
> > checking, it needs to be done immediately at mount time so action
> > can be taken to shutdown the filesystem and unmount the device
> > immediately before further damage is done....
> >
> > i.e. once the filesystem is mounted, you've already got a unique and
> > persistent identifier in the log for the life of the filesystem (the
> > m_fsname string), so I'm struggling to understand exactly what
> > problem you are trying to solve by adding redundant information
> > to every log message.....
> 
> Log rotation loses that identifier though; there are plenty of setups
> where a mount-time message has been rotated out of all logs by the
> time something goes wrong after a month or two.

At what point months after you've mounted the filesystem do you care
about whether the correct device was mounted or not?

And, for the log rotation case, the filesystem log output already
has a unique, persistent identifier for the life of the mount - the
fsname ("dm-0" in the above example). We don't need to add a new
device identifier to the XFS log messages to solve that problem
because *we've already got a device identifier in the log messages*.

Again - the "is this the right device" information only makes sense
to be checked at mount time. If it was the right device at mount
time, then after months of uptime how would it suddenly become "the
wrong device"? And if it's the wrong device at mount time, then you
need to take action *immediately*, not after using the filesysetms
on the device for months...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
