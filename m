Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39178133906
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 03:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAHCKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 21:10:08 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44317 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgAHCKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:10:08 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1154C3A0F36;
        Wed,  8 Jan 2020 13:10:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ip0nL-0007TV-0W; Wed, 08 Jan 2020 13:10:03 +1100
Date:   Wed, 8 Jan 2020 13:10:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     Sweet Tea Dorminy <sweettea@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
Message-ID: <20200108021002.GR23195@dread.disaster.area>
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
 <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
 <20200107012353.GO23195@dread.disaster.area>
 <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=akbcZbo06iP5b_x4eJUA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 11:01:47AM -0600, Tony Asleson wrote:
> On 1/6/20 7:23 PM, Dave Chinner wrote:
> > On Mon, Jan 06, 2020 at 07:19:07PM -0500, Sweet Tea Dorminy wrote:
> >>>>>> +
> >>>>>>    if (mp && mp->m_fsname) {
> >>>>>
> >>>>> mp->m_fsname is the name of the device we use everywhere for log
> >>>>> messages, it's set up at mount time so we don't have to do runtime
> >>>>> evaulation of the device name every time we need to emit the device
> >>>>> name in a log message.
> >>>>>
> >>>>> So, if you have some sooper speshial new device naming scheme, it
> >>>>> needs to be stored into the struct xfs_mount to replace mp->m_fsname.
> >>>>
> >>>> I don't think we want to replace mp->m_fsname with the vpd 0x83 device
> >>>> identifier.  This proposed change is adding a key/value structured data
> >>>> to the log message for non-ambiguous device identification over time,
> >>>> not to place the ID in the human readable portion of the message.  The
> >>>> existing name is useful too, especially when it involves a partition.
> >>>
> >>> Oh, if that's all you want to do, then why is this identifier needed
> >>> in every log message? 
> 
> The value is we can filter all the messages by the id as they are all
> individually identifiable.

Then what you want is the *filesystem label* or *filesystem UUID*
in the *filesystem log output* to uniquely identify the *filesystem
log output* regardless of the block device identifier the kernel
assigned it's underlying disk.

By trying to use the block device as the source of a persistent
filesytem identifier, you are creating more new problems about
uniqueness than you are solving.  E.g.

- there can be more than one filesystem per block device, so the
  identifier needs to be, at minimum, a {dev_id, partition} tuple.
  The existing bdev name (e.g. sda2) that filesystems emit contain
  this information. The underlying vpd device indentifier does not.

- the filesystem on a device can change (e.g. mkfs), so an unchanged
  vpd identifier does not mean we mounted the same filesystem

- raid devices are made up of multiple physical devices, so using
  device information for persistent identification is problematic,
  especially when devices fail and are replaced with different
  hardware.

- clone a filesystem to a new device to replace a failing disk,
  block device identifier changes but the filesystem doesn't.

Basically, if you need a *persistent filesystem identifier* for
your log messages, then you cannot rely on the underlying device to
provide that. Filesystems already have unique identifiers in them
that can be used for this purpose, and we have mechanisms to allow
users to configure them as well.

IOWs, you're trying to tackle this "filesystem identifier" at the
wrong layer - use the persistent filesystem identifiers to
persitently identify the filesystem across mounts, not some random
block device identifier.

> The structured data id that the patch series adds is not outputted by
> default by journalctl.  Please look at cover letter in patch series for
> example filter use.  You can see all the data in the journal entries by
> using journalctl -o json-pretty.

Yes, I understand that. But my comments about adding redundant
information to the log text output were directed at your suggestiong to
use dev_printk() instead of printk to achieve what you want. That
changes the log text output by prepending device specific strings to
the filesystem output.

> One can argue that we are adding a lot of data to each log message
> as the VPD data isn't trivial.  This could be mitigated by hashing
> the VPD and storing the hash as the ID, but that makes it less
> user friendly.  However, maybe it should be considered.

See above, I don't think the VPD information actually solves the
problem you are seeking to solve.

> >>> It does not change over the life of the filesystem, so it the
> >>> persistent identifier only needs to >>> be
> emitted to the log once at filesystem mount time. i.e.  >>>
> instead of:
> >>>
> >>> [    2.716841] XFS (dm-0): Mounting V5 Filesystem
> >>>
> >>> It just needs to be:
> >>>
> >>> [    2.716841] XFS (dm-0): Mounting V5 Filesystem on device
> >>> <persistent dev id>
> >>>
> >>> If you need to do any sort of special "is this the right
> >>> device" checking, it needs to be done immediately at mount
> >>> time so action can be taken to shutdown the filesystem and
> >>> unmount the device immediately before further damage is
> >>> done....
> >>>
> >>> i.e. once the filesystem is mounted, you've already got a
> >>> unique and persistent identifier in the log for the life of
> >>> the filesystem (the m_fsname string), so I'm struggling to
> >>> understand exactly what problem you are trying to solve by
> >>> adding redundant information to every log message.....
> 
> m_fsname is only valid for the life of the mount, not the life of
> the FS.  Each and every time we reboot, remove/reattach a device
> the attachment point may change and thus the m_fsname changes too.

Well, yes, that's because m_fsname is currently aimed at identifying
the block device that the filesytem is currently mounted on. That's
the block device we *actually care about* when trying to diagnose
problems reported in the log.  From that perspective, I don't want
the log output to change - it contains exactly what we need to
diagnose problems when things go wrong.

But for structured logging, using block device identifiers for the
filesystem identifier is just wrong. If you need new information,
append the UUID from the filesystem to the log message and use that
instead. i.e your original printk_emit() function should pass
mp->m_sb.sb_uuid as the post-message binary filesystem identifier,
not the block device VPD information.

If you need to convert the filesystem uuid to a block device, then
you can just go look up /dev/disk/by-uuid/ and follow the link the
filesystem uuid points to....

> > And, for the log rotation case, the filesystem log output
> > already has a unique, persistent identifier for the life of the
> > mount - the fsname ("dm-0" in the above example). We don't need
> > to add a new device identifier to the XFS log messages to solve
> > that problem because *we've already got a device identifier in
> > the log messages*.
> 
> It's very useful to have an ID that persists and identifies across
> mounts.  The existing id logging scheme tells you where something
> is attached, not what is attached.

Yup, that's what the filesystem labels and UUIDs provide. We've been
using them for this purpose for a long, long time.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
