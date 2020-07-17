Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10A223521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGQHFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:05:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgGQHFa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:05:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6554D58FBC5CDADFDF01;
        Fri, 17 Jul 2020 15:05:27 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 17 Jul
 2020 15:05:23 +0800
Subject: Re: [PATCH v3 1/1] f2fs: support zone capacity less than zone size
To:     Aravind Ramesh <aravind.ramesh@wdc.com>, <jaegeuk@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <hch@lst.de>
CC:     <Damien.LeMoal@wdc.com>, <niklas.cassel@wdc.com>,
        <matias.bjorling@wdc.com>
References: <20200716125656.3662-1-aravind.ramesh@wdc.com>
 <20200716125656.3662-2-aravind.ramesh@wdc.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <50e9491f-6d05-1f37-4ea8-05c2ddff97e1@huawei.com>
Date:   Fri, 17 Jul 2020 15:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200716125656.3662-2-aravind.ramesh@wdc.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/7/16 20:56, Aravind Ramesh wrote:
> NVMe Zoned Namespace devices can have zone-capacity less than zone-size.
> Zone-capacity indicates the maximum number of sectors that are usable in
> a zone beginning from the first sector of the zone. This makes the sectors
> sectors after the zone-capacity till zone-size to be unusable.
> This patch set tracks zone-size and zone-capacity in zoned devices and
> calculate the usable blocks per segment and usable segments per section.
> 
> If zone-capacity is less than zone-size mark only those segments which
> start before zone-capacity as free segments. All segments at and beyond
> zone-capacity are treated as permanently used segments. In cases where
> zone-capacity does not align with segment size the last segment will start
> before zone-capacity and end beyond the zone-capacity of the zone. For
> such spanning segments only sectors within the zone-capacity are used.
> 
> During writes and GC manage the usable segments in a section and usable
> blocks per segment. Segments which are beyond zone-capacity are never
> allocated, and do not need to be garbage collected, only the segments
> which are before zone-capacity needs to garbage collected.
> For spanning segments based on the number of usable blocks in that
> segment, write to blocks only up to zone-capacity.
> 
> Zone-capacity is device specific and cannot be configured by the user.
> Since NVMe ZNS device zones are sequentially write only, a block device
> with conventional zones or any normal block device is needed along with
> the ZNS device for the metadata operations of F2fs.
> 
> A typical nvme-cli output of a zoned device shows zone start and capacity
> and write pointer as below:
> 
> SLBA: 0x0     WP: 0x0     Cap: 0x18800 State: EMPTY Type: SEQWRITE_REQ
> SLBA: 0x20000 WP: 0x20000 Cap: 0x18800 State: EMPTY Type: SEQWRITE_REQ
> SLBA: 0x40000 WP: 0x40000 Cap: 0x18800 State: EMPTY Type: SEQWRITE_REQ
> 
> Here zone size is 64MB, capacity is 49MB, WP is at zone start as the zones
> are in EMPTY state. For each zone, only zone start + 49MB is usable area,
> any lba/sector after 49MB cannot be read or written to, the drive will fail
> any attempts to read/write. So, the second zone starts at 64MB and is
> usable till 113MB (64 + 49) and the range between 113 and 128MB is
> again unusable. The next zone starts at 128MB, and so on.
> 
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
