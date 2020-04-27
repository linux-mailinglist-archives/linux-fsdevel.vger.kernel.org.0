Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37E31BA39C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgD0MbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 08:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:43490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0MbD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:31:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2A168AD93;
        Mon, 27 Apr 2020 12:31:01 +0000 (UTC)
Subject: Re: [PATCH v8 04/11] block: Introduce REQ_OP_ZONE_APPEND
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-5-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6aaf3d41-c097-b5da-9539-c34b1a02a644@suse.de>
Date:   Mon, 27 Apr 2020 14:30:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 1:31 PM, Johannes Thumshirn wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Define REQ_OP_ZONE_APPEND to append-write sectors to a zone of a zoned
> block device. This is a no-merge write operation.
> 
> A zone append write BIO must:
> * Target a zoned block device
> * Have a sector position indicating the start sector of the target zone
> * The target zone must be a sequential write zone
> * The BIO must not cross a zone boundary
> * The BIO size must not be split to ensure that a single range of LBAs
>    is written with a single command.
> 
> Implement these checks in generic_make_request_checks() using the
> helper function blk_check_zone_append(). To avoid write append BIO
> splitting, introduce the new max_zone_append_sectors queue limit
> attribute and ensure that a BIO size is always lower than this limit.
> Export this new limit through sysfs and check these limits in bio_full().
> 
> Also when a LLDD can't dispatch a request to a specific zone, it
> will return BLK_STS_ZONE_RESOURCE indicating this request needs to
> be delayed, e.g.  because the zone it will be dispatched to is still
> write-locked. If this happens set the request aside in a local list
> to continue trying dispatching requests such as READ requests or a
> WRITE/ZONE_APPEND requests targetting other zones. This way we can
> still keep a high queue depth without starving other requests even if
> one request can't be served due to zone write-locking.
> 
> Finally, make sure that the bio sector position indicates the actual
> write position as indicated by the device on completion.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [ jth: added zone-append specific add_page and merge_page helpers ]
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c               | 62 ++++++++++++++++++++++++++++++++++++---
>   block/blk-core.c          | 52 ++++++++++++++++++++++++++++++++
>   block/blk-mq.c            | 27 +++++++++++++++++
>   block/blk-settings.c      | 23 +++++++++++++++
>   block/blk-sysfs.c         | 13 ++++++++
>   drivers/scsi/scsi_lib.c   |  1 +
>   include/linux/blk_types.h | 14 +++++++++
>   include/linux/blkdev.h    | 11 +++++++
>   8 files changed, 199 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
