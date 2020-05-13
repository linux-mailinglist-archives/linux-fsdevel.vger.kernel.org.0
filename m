Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CD1D0514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 04:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEMCiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 22:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMCiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 22:38:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC33C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 19:38:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id a4so7112547pgc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 19:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WyehoVS5xyMsLCe9+kv0B9xp6ecEQYyhEXRq6FyyLdc=;
        b=C81jvOP5IIpQSOmMCWgKmuxFjl4tmtvtegGVhvIv2onkYKGOq/ngfs15R0Jup3yyBt
         BLb8nqLC/i0JhgUehRlszwt35PWjr82kiTS5uPwjiFPswK7F8WgRyxbBO9HB/AgmcaiK
         nlas4o8GF8bnhZ+5Mn3gsgaFcoNjdJ2iUWeoyGR5unsHH1uBrttK/snvSm3RjVeFGomT
         CNo8Pgsyjk5pol/9nRwPvzTXp7x+zOAw3wlryxhBG5/v2F3JAdYayCfJVrCLi45lAYYY
         gMFfT9LbX2U9jBvAtyA6H6tnHykC6pO8D98NmDhRP/NRnU9PWb6dVEZL2gXdHOeWvmmN
         XzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WyehoVS5xyMsLCe9+kv0B9xp6ecEQYyhEXRq6FyyLdc=;
        b=oUCdVRr+C5Xl6PJPb9vcrQFpLiL0G+Grn/9ZoOu8ZSIoML/MHwPheeC/CPC+I4mJD+
         bGRv7UVlZ8u/LDeL+jdekXrtXLSRFKlsm9U09JG2HApn4QYQB6NLOQ/A45znzJExa7kh
         t3Ae4vFAZk/ZZ1D7juIlZ7Vy3jeJiZlrIwzopGyH7OMXHa/a5hIlkoxI5Cw0X6VAU7fD
         4eFBFVQaUr1Qh/0ZnJmWBpvnSgYO7/R/LDWPuUO6ZmXSc3TwkAGHwfZvt8rfCNGFzw+8
         gnwufUozsaBRugwSCzbXWFTNhyUl+xSBXm1DFGtE93c2II4kx4c12EX3tWSsDXm8nDLt
         M+wg==
X-Gm-Message-State: AOAM530tiiMfeg4V1WRyoRQD5I/FDgZvdITduaV9VaTOL1QMJMDY0A4y
        xPxFgjecR5bAeW/FfinwY8O2/Al9K2s=
X-Google-Smtp-Source: ABdhPJzaaa08OSndxUzWVb1oUbS2rPRvAvnZOpuEVl6MGugQ7SyvMZIgJja84vb/FDIjuTHT2UoE3w==
X-Received: by 2002:a62:6146:: with SMTP id v67mr5541865pfb.134.1589337480765;
        Tue, 12 May 2020 19:38:00 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id b9sm12967542pfp.12.2020.05.12.19.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:38:00 -0700 (PDT)
Subject: Re: [PATCH v11 00/10] Introduce Zone Append for writing to zoned
 block devices
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <abd4b3d4-6261-c3a6-9b4c-9bf009a9820d@kernel.dk>
Date:   Tue, 12 May 2020 20:37:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/20 2:55 AM, Johannes Thumshirn wrote:
> The upcoming NVMe ZNS Specification will define a new type of write
> command for zoned block devices, zone append.
> 
> When when writing to a zoned block device using zone append, the start
> sector of the write is pointing at the start LBA of the zone to write to.
> Upon completion the block device will respond with the position the data
> has been placed in the zone. This from a high level perspective can be
> seen like a file system's block allocator, where the user writes to a
> file and the file-system takes care of the data placement on the device.
> 
> In order to fully exploit the new zone append command in file-systems and
> other interfaces above the block layer, we choose to emulate zone append
> in SCSI and null_blk. This way we can have a single write path for both
> file-systems and other interfaces above the block-layer, like io_uring on
> zoned block devices, without having to care too much about the underlying
> characteristics of the device itself.
> 
> The emulation works by providing a cache of each zone's write pointer, so
> zone append issued to the disk can be translated to a write with a
> starting LBA of the write pointer. This LBA is used as input zone number
> for the write pointer lookup in the zone write pointer offset cache and
> the cached offset is then added to the LBA to get the actual position to
> write the data. In SCSI we then turn the REQ_OP_ZONE_APPEND request into a
> WRITE(16) command. Upon successful completion of the WRITE(16), the cache
> will be updated to the new write pointer location and the written sector
> will be noted in the request. On error the cache entry will be marked as
> invalid and on the next write an update of the write pointer will be
> scheduled, before issuing the actual write.
> 
> In order to reduce memory consumption, the only cached item is the offset
> of the write pointer from the start of the zone, everything else can be
> calculated. On an example drive with 52156 zones, the additional memory
> consumption of the cache is thus 52156 * 4 = 208624 Bytes or 51 4k Byte
> pages. The performance impact is neglectable for a spinning drive.
> 
> For null_blk the emulation is way simpler, as null_blk's zoned block
> device emulation support already caches the write pointer position, so we
> only need to report the position back to the upper layers. Additional
> caching is not needed here.
> 
> Furthermore we have converted zonefs to run use ZONE_APPEND for synchronous
> direct I/Os. Asynchronous I/O still uses the normal path via iomap.
> 
> Performance testing with zonefs sync writes on a 14 TB SMR drive and nullblk
> shows good results. On the SMR drive we're not regressing (the performance
> improvement is within noise), on nullblk we could drastically improve specific
> workloads:
> 
> * nullblk:
> 
> Single Thread Multiple Zones
> 				kIOPS	MiB/s	MB/s	% delta
> mq-deadline REQ_OP_WRITE	10.1	631	662
> mq-deadline REQ_OP_ZONE_APPEND	13.2	828	868	+31.12
> none REQ_OP_ZONE_APPEND		15.6	978	1026	+54.98
> 
> 
> Multiple Threads Multiple Zones
> 				kIOPS	MiB/s	MB/s	% delta
> mq-deadline REQ_OP_WRITE	10.2	640	671
> mq-deadline REQ_OP_ZONE_APPEND	10.4	650	681	+1.49
> none REQ_OP_ZONE_APPEND		16.9	1058	1109	+65.28
> 
> * 14 TB SMR drive
> 
> Single Thread Multiple Zones
> 				IOPS	MiB/s	MB/s	% delta
> mq-deadline REQ_OP_WRITE	797	49.9	52.3
> mq-deadline REQ_OP_ZONE_APPEND	806	50.4	52.9	+1.15
> 
> Multiple Threads Multiple Zones
> 				kIOPS	MiB/s	MB/s	% delta
> mq-deadline REQ_OP_WRITE	745	46.6	48.9
> mq-deadline REQ_OP_ZONE_APPEND	768	48	50.3	+2.86
> 
> The %-delta is against the baseline of REQ_OP_WRITE using mq-deadline as I/O
> scheduler.
> 
> The series is based on Jens' for-5.8/block branch with HEAD:
> ae979182ebb3 ("bdi: fix up for "remove the name field in struct backing_dev_info"")

Applied for 5.8, thanks.

-- 
Jens Axboe

