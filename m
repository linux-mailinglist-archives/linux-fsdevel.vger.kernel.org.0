Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFADA11FFFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLPIio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 03:38:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:37642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbfLPIio (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:38:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB298AE34;
        Mon, 16 Dec 2019 08:38:41 +0000 (UTC)
Subject: Re: [PATCH 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <20191212183816.102402-3-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8fe28905-aae5-bfb4-d6ac-f09d7244059e@suse.de>
Date:   Mon, 16 Dec 2019 09:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212183816.102402-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 7:38 PM, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document zonefs
> principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   Documentation/filesystems/zonefs.txt | 150 +++++++++++++++++++++++++++
>   MAINTAINERS                          |   1 +
>   2 files changed, 151 insertions(+)
>   create mode 100644 Documentation/filesystems/zonefs.txt
> 
> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
> new file mode 100644
> index 000000000000..e5d798f4087d
> --- /dev/null
> +++ b/Documentation/filesystems/zonefs.txt
> @@ -0,0 +1,150 @@
> +ZoneFS - Zone filesystem for Zoned block devices
> +
> +Overview
> +========
> +
> +zonefs is a very simple file system exposing each zone of a zoned block device
> +as a file. Unlike a regular file system with zoned block device support (e.g.
> +f2fs), zonefs does not hide the sequential write constraint of zoned block
> +devices to the user. Files representing sequential write zones of the device
> +must be written sequentially starting from the end of the file (append only
> +writes).
> +
> +As such, zonefs is in essence closer to a raw block device access interface
> +than to a full featured POSIX file system. The goal of zonefs is to simplify
> +the implementation of zoned block devices support in applications by replacing
> +raw block device file accesses with a richer file API, avoiding relying on
> +direct block device file ioctls which may be more obscure to developers. One
> +example of this approach is the implementation of LSM (log-structured merge)
> +tree structures (such as used in RocksDB and LevelDB) on zoned block devices by
> +allowing SSTables to be stored in a zone file similarly to a regular file system
> +rather than as a range of sectors of the entire disk. The introduction of the
> +higher level construct "one file is one zone" can help reducing the amount of
> +changes needed in the application as well as introducing support for different
> +application programming languages.
> +
> +zonefs on-disk metadata is reduced to a super block which persistently stores a
> +magic number and optional features flags and values. On mount, zonefs uses
> +blkdev_report_zones() to obtain the device zone configuration and populates
> +the mount point with a static file tree solely based on this information.
> +E.g. file sizes come from the device zone type and write pointer offset managed
> +by the device itself.
> +
> +The zone files created on mount have the following characteristics.
> +1) Files representing zones of the same type are grouped together
> +   under the same sub-directory:
> +  * For conventional zones, the sub-directory "cnv" is used.
> +  * For sequential write zones, the sub-directory "seq" is used.
> +  These two directories are the only directories that exist in zonefs. Users
> +  cannot create other directories and cannot rename nor delete the "cnv" and
> +  "seq" sub-directories.
> +2) The name of zone files is the number of the file within the zone type
> +   sub-directory, in order of increasing zone start sector.
> +3) The size of conventional zone files is fixed to the device zone size.
> +   Conventional zone files cannot be truncated.
> +4) The size of sequential zone files represent the file's zone write pointer
> +   position relative to the zone start sector. Truncating these files is
> +   allowed only down to 0, in wich case, the zone is reset to rewind the file
> +   zone write pointer position to the start of the zone, or up to the zone size,
> +   in which case the file's zone is transitioned to the FULL state (finish zone
> +   operation).
> +5) All read and write operations to files are not allowed beyond the file zone
> +   size. Any access exceeding the zone size is failed with the -EFBIG error.
> +6) Creating, deleting, renaming or modifying any attribute of files and
> +   sub-directories is not allowed.
> +
> +Several optional features of zonefs can be enabled at format time.
> +* Conventional zone aggregation: ranges of contiguous conventional zones can be
> +  agregated into a single larger file instead of the default one file per zone.
> +* File ownership: The owner UID and GID of zone files is by default 0 (root)
> +  but can be changed to any valid UID/GID.
> +* File access permissions: the default 640 access permissions can be changed.
> +

Please mention the 'direct writes only to sequential zones' restriction.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
