Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F41653E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 01:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBTAzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 19:55:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBTAzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ohb2InZKPvxlOicmdRvhyYCKfLB1DxvoDzY/kCt1K4s=; b=T8QSF4op0/rp9L38+C8q1g5ut5
        dIzRuTyJsLjo1s7MHYOVnttoiBMOu18ZMR9nCrAc/3v6n0bUKbM7+CxeQ2c45NxYZEXzyq7BrGQc9
        4+Er0bHhyLuyRtrLSPA23QZowPc6kmneaQFuNuR2+tJajx7V7lvqBhwrpnIpInQ/rzBNDj3Fq9LIi
        XY63dCV+ea5NFbAlKOynKaP+IVAxVPCQfJHn9IBh3GF7o7P1TzPawymIlp0B6SA8GbLA56LE2Rmce
        JFUBoks0X1tBf73MBYAPJ6xfkkVQTBZalie3+lRDInqxSukH+8HUeFlLPL+4ztK8qNo4YQfGURT7I
        hq0T/FoQ==;
Received: from [2603:3004:32:9a00::4074]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4a7c-00019t-5V; Thu, 20 Feb 2020 00:55:20 +0000
Subject: Re: [PATCH v13 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Dave Chinner <david@fromorbit.com>
References: <20200207031606.641231-1-damien.lemoal@wdc.com>
 <20200207031606.641231-3-damien.lemoal@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6f0eaf4-933f-8c15-6f0c-18400204791f@infradead.org>
Date:   Wed, 19 Feb 2020 16:55:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207031606.641231-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Damien,

Typo etc. corrections below:

On 2/6/20 7:16 PM, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document
> zonefs principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---
>  Documentation/filesystems/zonefs.txt | 404 +++++++++++++++++++++++++++
>  MAINTAINERS                          |   1 +
>  2 files changed, 405 insertions(+)
>  create mode 100644 Documentation/filesystems/zonefs.txt
> 
> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
> new file mode 100644
> index 000000000000..935bf22031ca
> --- /dev/null
> +++ b/Documentation/filesystems/zonefs.txt
> @@ -0,0 +1,404 @@
> +ZoneFS - Zone filesystem for Zoned block devices
> +
> +Introduction
> +============
> +
...
> +
> +Zoned block devices
> +-------------------
> +
...
> +
> +Zonefs Overview
> +===============
> +
...

> +
> +On-disk metadata
> +----------------
> +
...

> +
> +Zone type sub-directories
> +-------------------------
> +
...

> +
> +Zone files
> +----------
> +
...

> +
> +Conventional zone files
> +-----------------------
> +
...

> +
> +Sequential zone files
> +---------------------
> +
> +The size of sequential zone files grouped in the "seq" sub-directory represents
> +the file's zone write pointer position relative to the zone start sector.
> +
> +Sequential zone files can only be written sequentially, starting from the file
> +end, that is, write operations can only be append writes. Zonefs makes no
> +attempt at accepting random writes and will fail any write request that has a
> +start offset not corresponding to the end of the file, or to the end of the last
> +write issued and still in-flight (for asynchrnous I/O operations).
                                         asynchronous

> +
> +Since dirty page writeback by the page cache does not guarantee a sequential
> +write pattern, zonefs prevents buffered writes and writeable shared mappings
> +on sequential files. Only direct I/O writes are accepted for these files.
> +zonefs relies on the sequential delivery of write I/O requests to the device
> +implemented by the block layer elevator. An elevator implementing the sequential
> +write feature for zoned block device (ELEVATOR_F_ZBD_SEQ_WRITE elevator feature)
> +must be used. This type of elevator (e.g. mq-deadline) is the set by default

                                                          is set by default

> +for zoned block devices on device initialization.
> +
...

> +
> +Format options
> +--------------
> +
...

> +
> +IO error handling
> +-----------------
> +
...

> +
> +
> +* Unaligned write errors: These errors result from the host issuing write
> +  requests with a start sector that does not correspond to a zone write pointer
> +  position when the write request is executed by the device. Even though zonefs
> +  enforces sequential file write for sequential zones, unaligned write errors
> +  may still happen in the case of a partial failure of a very large direct I/O
> +  operation split into multiple BIOs/requests or asynchronous I/O operations.
> +  If one of the write request within the set of sequential write requests
> +  issued to the device fails, all write requests after queued after it will

                                           requests queued after it

> +  become unaligned and fail.
> +
...

> +
> +All I/O errors detected by zonefs are notified to the user with an error code
> +return for the system call that trigered or detected the error. The recovery

                                   triggered

> +actions taken by zonefs in response to I/O errors depend on the I/O type (read
> +vs write) and on the reason for the error (bad sector, unaligned writes or zone
> +condition change).
> +
...

> +
> +Zonefs minimal I/O error recovery may change a file size and a file access

                                                            and file access

> +permissions.
> +
> +* File size changes:
> +  Immediate or delayed write errors in a sequential zone file may cause the file
> +  inode size to be inconsistent with the amount of data successfully written in
> +  the file zone. For instance, the partial failure of a multi-BIO large write
> +  operation will cause the zone write pointer to advance partially, even though
> +  the entire write operation will be reported as failed to the user. In such
> +  case, the file inode size must be advanced to reflect the zone write pointer
> +  change and eventually allow the user to restart writing at the end of the
> +  file.
> +  A file size may also be reduced to reflect a delayed write error detected on
> +  fsync(): in this case, the amount of data effectively written in the zone may
> +  be less than originally indicated by the file inode size. After such I/O
> +  error, zonefs always fixes a file inode size to reflect the amount of data

                          fixes the file inode size

> +  persistently stored in the file zone.
> +
> +* Access permission changes:
...

> +
> +Further notes:
> +* The "errors=remount-ro" mount option is the default behavior of zonefs I/O
> +  error processing if no errors mount option is specified.
> +* With the "errors=remount-ro" mount option, the change of the file access
> +  permissions to read-only applies to all files. The file system is remounted
> +  read-only.
> +* Access permission and file size changes due to the device transitioning zones
> +  to the offline condition are permanent. Remounting or reformating the device

                                             usually:      reformatting

> +  with mkfs.zonefs (mkzonefs) will not change back offline zone files to a good
> +  state.
> +* File access permission changes to read-only due to the device transitioning
> +  zones to the read-only condition are permanent. Remounting or reformating

                                                                   reformatting

> +  the device will not re-enable file write access.
> +* File access permission changes implied by the remount-ro, zone-ro and
> +  zone-offline mount options are temporary for zones in a good condition.
> +  Unmounting and remounting the file system will restore the previous default
> +  (format time values) access rights to the files affected.
> +* The repair mount option triggers only the minimal set of I/O error recovery
> +  actions, that is, file size fixes for zones in a good condition. Zones
> +  indicated as being read-only or offline by the device still imply changes to
> +  the zone file access permissions as noted in the table above.
> +
> +Mount options
> +-------------
> +
> +zonefs define the "errors=<behavior>" mount option to allow the user to specify
> +zonefs behavior in response to I/O errors, inode size inconsistencies or zone
> +condition chages. The defined behaviors are as follow:

             changes.

> +* remount-ro (default)
> +* zone-ro
> +* zone-offline
> +* repair
> +
> +The I/O error actions defined for each behavior is detailed in the previous

                                                   are

> +section.
> +
> +Zonefs User Space Tools
> +=======================
> +
...
> +
> +Examples
> +--------
> +
...


HTH.
-- 
~Randy
