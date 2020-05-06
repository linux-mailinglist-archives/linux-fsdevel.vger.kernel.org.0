Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD811C7937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgEFSSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 14:18:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:46050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgEFSSJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 14:18:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20C2AAC8F;
        Wed,  6 May 2020 18:18:10 +0000 (UTC)
Subject: Re: [PATCH v10 6/9] scsi: sd_zbc: emulate ZONE_APPEND commands
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
References: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
 <20200506161145.9841-7-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f031f491-620a-6b72-f16a-3702239b01c6@suse.de>
Date:   Wed, 6 May 2020 20:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506161145.9841-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/20 6:11 PM, Johannes Thumshirn wrote:
> Emulate ZONE_APPEND for SCSI disks using a regular WRITE(16) command
> with a start LBA set to the target zone write pointer position.
> 
> In order to always know the write pointer position of a sequential write
> zone, the write pointer of all zones is tracked using an array of 32bits
> zone write pointer offset attached to the scsi disk structure. Each
> entry of the array indicate a zone write pointer position relative to
> the zone start sector. The write pointer offsets are maintained in sync
> with the device as follows:
> 1) the write pointer offset of a zone is reset to 0 when a
>     REQ_OP_ZONE_RESET command completes.
> 2) the write pointer offset of a zone is set to the zone size when a
>     REQ_OP_ZONE_FINISH command completes.
> 3) the write pointer offset of a zone is incremented by the number of
>     512B sectors written when a write, write same or a zone append
>     command completes.
> 4) the write pointer offset of all zones is reset to 0 when a
>     REQ_OP_ZONE_RESET_ALL command completes.
> 
> Since the block layer does not write lock zones for zone append
> commands, to ensure a sequential ordering of the regular write commands
> used for the emulation, the target zone of a zone append command is
> locked when the function sd_zbc_prepare_zone_append() is called from
> sd_setup_read_write_cmnd(). If the zone write lock cannot be obtained
> (e.g. a zone append is in-flight or a regular write has already locked
> the zone), the zone append command dispatching is delayed by returning
> BLK_STS_ZONE_RESOURCE.
> 
> To avoid the need for write locking all zones for REQ_OP_ZONE_RESET_ALL
> requests, use a spinlock to protect accesses and modifications of the
> zone write pointer offsets. This spinlock is initialized from sd_probe()
> using the new function sd_zbc_init().
> 
> Co-developed-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   drivers/scsi/sd.c     |  16 +-
>   drivers/scsi/sd.h     |  43 ++++-
>   drivers/scsi/sd_zbc.c | 363 +++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 392 insertions(+), 30 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
