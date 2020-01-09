Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17BB1363B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgAIXWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:22:51 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58458 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgAIXWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:22:50 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 868EE820917;
        Fri, 10 Jan 2020 10:22:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iph8W-0006Qu-Dy; Fri, 10 Jan 2020 10:22:44 +1100
Date:   Fri, 10 Jan 2020 10:22:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Tony Asleson <tasleson@redhat.com>,
        Sweet Tea Dorminy <sweettea@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
Message-ID: <20200109232244.GT23195@dread.disaster.area>
References: <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
 <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
 <20200107012353.GO23195@dread.disaster.area>
 <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com>
 <20200108021002.GR23195@dread.disaster.area>
 <9e449c65-193c-d69c-1454-b1059221e5dc@redhat.com>
 <20200109014117.GB3809@agk-dp.fab.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109014117.GB3809@agk-dp.fab.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=hoDmsdNMAAAA:20 a=GFaoHKnqAAAA:8 a=7-415B0cAAAA:8
        a=VQnnGOFCwwFJJO5165wA:9 a=CjuIK1q_8ugA:10 a=Vh1PrrggmBitVpCIy7ZX:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:41:17AM +0000, Alasdair G Kergon wrote:
> On Wed, Jan 08, 2020 at 10:53:13AM -0600, Tony Asleson wrote:
> > We are not removing any existing information, we are adding.
> 
> A difficulty with this approach is:  Where do you stop when your storage
> configuration is complicated and changing?  Do you add the complete
> relevant part of the storage stack configuration to every storage
> message in the kernel so that it is easy to search later?
> 
> Or do you catch the messages in userspace and add some of this
> information there before sending them on to your favourite log message
> database?  (ref. peripety, various rsyslog extensions)
> 
> > I think all the file systems should include their FS UUID in the FS log
> > messages too, but that is not part of the problem we are trying to solve.
> 
> Each layer (subsystem) should already be tagging its messages in an
> easy-to-parse way so that all those relating to the same object (e.g.
> filesystem instance, disk) at its level of the stack can easily be
> matched together later.  Where this doesn't already happen, we should
> certainly be fixing that as it's a pre-requisite for any sensible
> post-processing: As long as the right information got recorded, it can
> all be joined together on demand later by some userspace software.

*nod*

That was the essence of my suggestion that the filesystem mount log
notification emits it's persistent identifier. If you need it to be
logged, that's where the verbose identifier output should be....

> > The user has to systematically and methodically go through the logs
> > trying to deduce what the identifier was referring to at the time of the
> > error.  This isn't trivial and virtually impossible at times depending
> > on circumstances.
> 
> So how about logging what these identifiers reference at different times
> in a way that is easy to query later?
> 
> Come to think of it, we already get uevents when the references change,
> and udev rules even already now create neat "by-*" links for us.  Maybe
> we just need to log better what udev is actually already doing?

Right, this is essentially what I've been trying to point out - I
even used the by-uuid links as an example of how the filesystem is
persistently identified by existing system boot infrastructure. :)

> Then we could reproduce what the storage configuration looked like at
> any particular time in the past to provide the missing context for
> the identifiers in the log messages.
> 
>                     ---------------------
>  
> Which seems like an appropriate time to introduce storage-logger.
> 
>     https://github.com/lvmteam/storage-logger
> 
>     Fedora rawhide packages:
>       https://copr.fedorainfracloud.org/coprs/agk/storage-logger/ 
> 
> The goal of this particular project is to maintain a record of the
> storage configuration as it changes over time.  It should provide a
> quick way to check the state of a system at a specified time in the
> past.
> 
> The initial logging implementation is triggered by storage uevents and
> consists of two components:
> 
> 1. A new udev rule file, 99-zzz-storage-logger.rules, which runs after
> all the other rules have run and invokes:
> 
> 2. A script, udev_storage_logger.sh, that captures relevant
> information about devices that changed and stores it in the system
> journal.
> 
> The effect is to log the data from relevant uevents plus some
> supplementary information (including device-mapper tables, for example).
> It does not yet handle filesystem-related events.

There are very few filesystem uevents issued that you could log,
anyway. Certainly nothing standardised across filesystems....

> Two methods to query the data are offered:
> 
> 1. journalctl
> Data is tagged with the identifier UDEVLOG and retrievable as
> key-value pairs.
>   journalctl -t UDEVLOG --output verbose
>   journalctl -t UDEVLOG --output json
>     --since 'YYYY-MM-DD HH:MM:SS' 
>     --until 'YYYY-MM-DD HH:MM:SS'
>   journalctl -t UDEVLOG --output verbose
>     --output-fields=PERSISTENT_STORAGE_ID,MAJOR,MINOR
>      PERSISTENT_STORAGE_ID=dm-name-vg1-lvol0
> 
> 2. lsblkj  [appended j for journal]
> This lsblk wrapper reprocesses the logged uevents to reconstruct a
> dummy system environment that "looks like" the system did at a
> specified earlier time and then runs lsblk against it.

Yeah, and if you add the equivalent of 'lsblk -f' then you also get
the fs UUID to identify the filesystem on the block device at a
given time....

> Yes, I'm looking for feedback to help to decide whether or not it's
> worth developing this any further.

This seems like a more flexible approach to me - it allows for
text-based system loggers a hook to capture this device
information, too, and hence implement their own post-processing
scripts to provide the same lifetime information.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
