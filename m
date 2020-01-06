Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E908B131AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgAFWCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 17:02:39 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57310 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbgAFWCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:02:39 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DAEBE7E84E1;
        Tue,  7 Jan 2020 09:02:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ioaSH-00061A-5f; Tue, 07 Jan 2020 09:02:33 +1100
Date:   Tue, 7 Jan 2020 09:02:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
Message-ID: <20200106220233.GK23195@dread.disaster.area>
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=J_bn1_9MaN90Pk6s4eYA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 05, 2020 at 08:45:00PM -0600, Tony Asleson wrote:
> On 1/3/20 8:56 PM, Dave Chinner wrote:
> > On Mon, Dec 23, 2019 at 04:55:58PM -0600, Tony Asleson wrote:
> >> Add persistent durable name to xfs messages so we can
> >> correlate them with other messages for the same block
> >> device.
> >>
> >> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> >> ---
> >>  fs/xfs/xfs_message.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
> >> index 9804efe525a9..8447cdd985b4 100644
> >> --- a/fs/xfs/xfs_message.c
> >> +++ b/fs/xfs/xfs_message.c
> >> @@ -20,6 +20,23 @@ __xfs_printk(
> >>  	const struct xfs_mount	*mp,
> >>  	struct va_format	*vaf)
> >>  {
> >> +	char dict[128];
> >> +	int dict_len = 0;
> >> +
> >> +	if (mp && mp->m_super && mp->m_super->s_bdev &&
> >> +		mp->m_super->s_bdev->bd_disk) {
> >> +		dict_len = dev_durable_name(
> >> +			disk_to_dev(mp->m_super->s_bdev->bd_disk)->parent,
> >> +			dict,
> >> +			sizeof(dict));
> >> +		if (dict_len) {
> >> +			printk_emit(
> >> +				0, level[1] - '0', dict, dict_len,
> >> +				"XFS (%s): %pV\n",  mp->m_fsname, vaf);
> >> +			return;
> >> +		}
> >> +	}
> > 
> > NACK on the ground this is a gross hack.
> 
> James suggested I utilize dev_printk, which does make things simpler.
> Would something like this be acceptable?
> 
> diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
> index 9804efe525a9..0738c74a8d3a 100644
> --- a/fs/xfs/xfs_message.c
> +++ b/fs/xfs/xfs_message.c
> @@ -20,11 +20,18 @@ __xfs_printk(
>         const struct xfs_mount  *mp,
>         struct va_format        *vaf)
>  {
> +       struct device *dev = NULL;
> +
> +       if (mp && mp->m_super && mp->m_super->s_bdev &&
> +               mp->m_super->s_bdev->bd_disk) {
> +               dev = disk_to_dev(mp->m_super->s_bdev->bd_disk)->parent;
> +       }
> +
>         if (mp && mp->m_fsname) {
> -               printk("%sXFS (%s): %pV\n", level, mp->m_fsname, vaf);
> +               dev_printk(level, dev, "XFS (%s): %pV\n", mp->m_fsname,
> vaf);
>                 return;
>         }
> -       printk("%sXFS: %pV\n", level, vaf);
> +       dev_printk(level, dev, "XFS: %pV\n", vaf);

No, because that's just doing the same thing involving dynamic
extraction of static, unchanging information. Only now we get the
output looking like:

[ts] "<driver string> <dev name>: XFS (<dev name>): <message>"

Or we get:

[ts] "(NULL device *): XFS: <message>"

Both of which don't provide any extra useful information to the
person/script parsing the log message.

Oh, and calling dev_printk() with a null dev pointer is likely to
panic the machine in dev_driver_string().

>  }
> 
> >> +
> >>  	if (mp && mp->m_fsname) {
> > 
> > mp->m_fsname is the name of the device we use everywhere for log
> > messages, it's set up at mount time so we don't have to do runtime
> > evaulation of the device name every time we need to emit the device
> > name in a log message.
> > 
> > So, if you have some sooper speshial new device naming scheme, it
> > needs to be stored into the struct xfs_mount to replace mp->m_fsname.
> 
> I don't think we want to replace mp->m_fsname with the vpd 0x83 device
> identifier.  This proposed change is adding a key/value structured data
> to the log message for non-ambiguous device identification over time,
> not to place the ID in the human readable portion of the message.  The
> existing name is useful too, especially when it involves a partition.

Oh, if that's all you want to do, then why is this identifier needed
in every log message? It does not change over the life of the
filesystem, so it the persistent identifier only needs to be emitted
to the log once at filesystem mount time. i.e.  instead of:

[    2.716841] XFS (dm-0): Mounting V5 Filesystem

It just needs to be:

[    2.716841] XFS (dm-0): Mounting V5 Filesystem on device <persistent dev id>

If you need to do any sort of special "is this the right device"
checking, it needs to be done immediately at mount time so action
can be taken to shutdown the filesystem and unmount the device
immediately before further damage is done....

i.e. once the filesystem is mounted, you've already got a unique and
persistent identifier in the log for the life of the filesystem (the
m_fsname string), so I'm struggling to understand exactly what
problem you are trying to solve by adding redundant information
to every log message.....

> > And if you have some sooper spehsial new printk API that uses this
> > new device name, everything XFS emits needs to use it
> > unconditionally as we do with mp->m_fsname now.
> > 
> > IOWs, this isn't conditional code - it either works for the entire
> > life of the mount for every message we have to emit with a single
> > setup call, or the API is broken and needs to be rethought.
> 
> I've been wondering why the struct scsi device uses rcu data for the vpd
> as I would not think that it would be changing for a specific device.
> Perhaps James can shed some light on this?

The implementation of the in-memory driver vpd data page has no
relationship to the lifetime of the persistent information that
the VPD stores/reports.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
