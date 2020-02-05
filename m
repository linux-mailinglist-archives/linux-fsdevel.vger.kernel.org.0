Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78A3153AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 23:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBEW3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 17:29:54 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38729 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgBEW3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:29:54 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 67A8E3A406C;
        Thu,  6 Feb 2020 09:29:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1izTB5-0006D4-AP; Thu, 06 Feb 2020 09:29:47 +1100
Date:   Thu, 6 Feb 2020 09:29:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v11 2/2] zonefs: Add documentation
Message-ID: <20200205222947.GN20628@dread.disaster.area>
References: <20200205120837.67798-1-damien.lemoal@wdc.com>
 <20200205120837.67798-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205120837.67798-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JF9118EUAAAA:8 a=7-415B0cAAAA:8 a=nyWtIYOtnHeH4J-rdD4A:9
        a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:08:37PM +0900, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document
> zonefs principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
.....

Just looking at the error handling text...

> +Several optional features of zonefs can be enabled at format time.
> +* Conventional zone aggregation: ranges of contiguous conventional zones can be
> +  aggregated into a single larger file instead of the default one file per zone.
> +* File ownership: The owner UID and GID of zone files is by default 0 (root)
> +  but can be changed to any valid UID/GID.
> +* File access permissions: the default 640 access permissions can be changed.
> +
> +zonefs mount options
> +--------------------

This section is really all about error handling, not so much mount
options in general...

> +
> +zonefs defines several mount options allowing the user to control the file
> +system behavior when write I/O errors occur and when inconsistencies between a
> +file size and its zone write pointer position are discovered. The handling of
> +read I/O errors is not changed by these options as long as no inode size
> +corruption is detected.
> +
> +These options are as follows.
> +* errors=remount-ro (default)
> +  All write IO errors and errors due to a zone of the device going "bad"
> +  (condition changed to offline or read-only), the file system is remounted
> +  read-only after fixing the size and access permissions of the inode that
> +  suffered the IO error.

What does "fixing the size and access permissions of the inode"
mean?

> +* errors=zone-ro
> +  Any write IO error to a file zone result in the zone being considered as in a
> +  read-only condition, preventing any further modification to the file. This
> +  option does not affect the handling of errors due to offline zones. For these
> +  zones, all accesses (read and write) are disabled.

If the zone is marked RO, then shouldn't reads still work?. Oh, hold
on, you're now talking about errors that take the zone oflfine at
the device level?

Perhaps a table describing what IO can be done to a zone vs the
device once an error occurs would be a clearer way of describing the
behaviour.


It seems to me that a table might be a better way of decribing all
the different conditions

				Post error access permissions
				   zone		    device
mountopt	zone state	read	write	read	write
--------	----------	----	-----	----	-----
remount-ro	good		yes	no	yes	no
		RO		yes	no	yes	no
		Offline		no	no	yes	no

zone-ro		good		yes	no	yes	yes
		RO		yes	no	yes	yes
		Offline		no	no	yes	yes

zone-offline	good		no	no	yes	yes
		RO		no	no	yes	yes
		Offline		no	no	yes	yes

repair		good		yes	yes	yes	yes
		RO		yes	no	yes	yes
		Offline		no	no	yes	yes

And then you can document that an offline zone will always appear to
have a size of 0, be immutable, etc, while a read-only zone will
have a size that reflects the amount of valid data in the zone that
can be read.

IOWs, you don't need to mix the definitions of zone state appearence
and behaviour with descriptions of what actions the different mount
options take when a write error occurs.

> +* errors=zone-offline
> +  Any write IO error to a file zone result in the zone being considered as in
> +  an offline condition. This implies that the file size is changed to 0 and all
> +  read/write accesses to the file disabled, preventing all accesses by the user.
> +* errors=repair
> +  Any inconsistency between an inode size and its zone amount of written data
> +  due to IO errors or external corruption are fixed without any change to file
> +  access rights. This option does not affect the processing of zones that were
> +  signaled as read-only or offline by the device. For read-only zones, the file
> +  read accesses are disabled and for offline zones, all access permissions are
> +  removed.
> +
> +For sequential zone files, inconsistencies between an inode size and the amount
> +of data writen in its zone, that is, the position of the file zone write
> +pointer, can result from different events:
> +* When the device write cache is enabled, a differed write error can occur

"a different write error"?

> +  resulting in the amount of data written in the zone being less than the inode
> +  size.

Though I suspect that what you really mean to say is that errors can
occur in ranges of previously completed writes can occur when the
cache is flushed, hence less data being physically written than the
OS has previously be told was written by the hardware. i.e. visible
inode size goes backwards.

> +* Partial failures of large write I/O operations (e.g. one BIO of a multi-bio
> +  large direct write fails) can result in the amount of data written in the
> +  zone being larger than the inode size.
> +* External action on the disk such as write, zone reset or zone finish
> +  operations will change a file zone write pointer position resulting in a
> +  reported amount of written data being different from the file inode size.

*nod*

> +Finally, defective drives may change the condition of any zone to offline (zone
> +dead) or read-only. Such changes, when discovered with the IO errors they can
> +cause, are handled automatically regardless of the options specified at mount
> +time. For offline zones, the action taken is similar to the action defined by
> +the errors=zone-offline mount option. For read-only zones, the action used is
> +as defined by the errors=zone-ro mount option.

Hmmmm. I think that's over-complicating things and takes control of
error handling away from the user. That is, regardless of the reason
for the error, if we get a write error and the user specified
errors=remount-ro, the entire device should go read-only because
that's what the user has told the filesystem to do on write error.

This seems pretty user-unfriendly - giving them a way to control
error handling behaviour and then ignoring it for specific errors
despite the fact they mean exactly the same thing to the user: the
write failed because a zone has gone bad since the last time that
zone was accessed by the application....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
