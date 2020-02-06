Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C73154F6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 00:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgBFXmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 18:42:03 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:34574 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgBFXmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:42:03 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 59C658214F9;
        Fri,  7 Feb 2020 10:41:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1izqmU-0006dw-Gc; Fri, 07 Feb 2020 10:41:58 +1100
Date:   Fri, 7 Feb 2020 10:41:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v12 2/2] zonefs: Add documentation
Message-ID: <20200206234158.GB21953@dread.disaster.area>
References: <20200206052631.111586-1-damien.lemoal@wdc.com>
 <20200206052631.111586-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206052631.111586-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=pdmCJgB9B0VxgstGLv4A:9
        a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 02:26:31PM +0900, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document
> zonefs principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/filesystems/zonefs.txt | 404 +++++++++++++++++++++++++++
>  MAINTAINERS                          |   1 +
>  2 files changed, 405 insertions(+)
>  create mode 100644 Documentation/filesystems/zonefs.txt

Looks largely OK to me. A few small nits below in the new error handling text,
but otherwise

Reviewed-by: Dave Chinner <dchinner@redhat.com>

> +IO error handling
> +-----------------
> +
> +Zoned block devices may fail I/O requests for reasons similar to regular block
> +devices, e.g. due to bad sectors. However, in addition to such known I/O
> +failure pattern, the standards governing zoned block devices behavior define
> +additional conditions that result in I/O errors.
> +
> +* A zone may transition to the read-only condition (BLK_ZONE_COND_READONLY):
> +  While the data already written in the zone is still readable, the zone can
> +  no longer be written. No user action on the zone (zone management command or
> +  read/write access) can change the zone condition back to a normal read/write
> +  state. While the reasons for the device to transition a zone to read-only
> +  state are not defined by the standards, a typical cause for such transition
> +  would be a defective write head on an HDD (all zones under this head are
> +  changed to read-only).
> +
> +* A zone may transition to the offline condition (BLK_ZONE_COND_OFFLINE):
> +  An offline zone cannot be read nor written. No user action can transition an
> +  offline zone back to an operational good state. Similarly to zone read-only
> +  transitions, the reasons for a drive to transition a zone to the offline
> +  condition are undefined. A typical cause would be a defective read-write head
> +  on an HDD causing all zones on the platter under the broken head to be
> +  inaccessible.
> +
> +* Unaligned write errors: These errors result from the host issuing write
> +  requests with a start sector that does not correspond to a zone write pointer
> +  position when the write request is executed by the device. Even though zonefs
> +  enforces sequential file write for sequential zones, unaligned write errors
> +  may still happen in the case of a partial failure of a very large direct I/O
> +  operation split into multiple BIOs/requests or asynchronous I/O operations.
> +  If one of the write request within the set of sequential write requests
> +  issued to the device fails, all write requests after queued after it will
> +  become unaligned and fail.
> +
> +* Delayed write errors: similarly to regular block devices, if the device side
> +  write cache is enabled, write errors may occur in ranges of previously
> +  completed writes when the device write cache is flushed, e.g. on fsync().
> +  Similarly to the previous immediate unaligned write error case, delayed write
> +  errors can propagate through a stream of cached sequential data for a zone
> +  causing all data to be dropped after the sector that caused the error.
> +
> +All I/O errors detected by zonefs are always notified to the user with an error

s/always//

> +code return for the system call that trigered or detected the error. The
> +recovery actions taken by zonefs in response to I/O errors depend on the I/O
> +type (read vs write) and on the reason for the error (bad sector, unaligned
> +writes or zone condition change).
> +
> +* For read I/O errors, zonefs does not execute any particular recovery action,
> +  but only if the file zone is still in a good condition and there is no
> +  inconsistency between the file inode size and its zone write pointer position.
> +  If a problem is detected, I/O error recovery is executed (see below table).
> +
> +* For write I/O errors, zonefs I/O error recovery is always executed.
> +
> +* A zone condition change to read-only or offline also always triggers zonefs
> +  I/O error recovery.
> +
> +Zonefs minimal I/O error recovery may change a file size and a file access
> +permissions.
> +
> +* File size changes:
> +  Immediate or delayed write errors in a sequential zone file may cause the file
> +  inode size to be inconsistent with the amount of data successfully written in
> +  the file zone. For instance, the partial failure of a multi-BIO large write
> +  operation will cause the zone write pointer to advance partially, eventhough

"even though"

> +  the entire write operation will be reported as failed to the user. In such
> +  case, the file inode size must be advanced to reflect the zone write pointer
> +  change and eventually allow the user to restart writing at the end of the
> +  file.
> +  A file size may also be reduced to reflect a delayed write error detected on
> +  fsync(): in this case, the amount of data effectively written in the zone may
> +  be less than originally indicated by the file inode size. After such I/O
> +  error zonefs always fixes a file inode size to reflect the amount of data

"error, zonefs" ?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
