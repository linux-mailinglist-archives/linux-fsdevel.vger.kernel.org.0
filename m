Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43082C1EBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 08:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgKXHQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 02:16:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:39578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbgKXHQc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:16:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC181AD3F;
        Tue, 24 Nov 2020 07:16:30 +0000 (UTC)
Subject: Re: [PATCH v10 11/41] btrfs: implement log-structured superblock for
 ZONED mode
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <5aa30b45e2e29018e19e47181586f3f436759b69.1605007036.git.naohiro.aota@wdc.com>
 <69855ff1-4737-3d4c-f191-f31f8307fe88@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d2976430-83d3-7524-dede-fe46bda14f87@suse.de>
Date:   Tue, 24 Nov 2020 08:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <69855ff1-4737-3d4c-f191-f31f8307fe88@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/20 7:46 AM, Anand Jain wrote:
> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>> Superblock (and its copies) is the only data structure in btrfs which 
>> has a
>> fixed location on a device. Since we cannot overwrite in a sequential 
>> write
>> required zone, we cannot place superblock in the zone. One easy 
>> solution is
>> limiting superblock and copies to be placed only in conventional zones.
>> However, this method has two downsides: one is reduced number of 
>> superblock
>> copies. The location of the second copy of superblock is 256GB, which 
>> is in
>> a sequential write required zone on typical devices in the market today.
>> So, the number of superblock and copies is limited to be two.  Second
>> downside is that we cannot support devices which have no conventional 
>> zones
>> at all.
>>
> 
> 
>> To solve these two problems, we employ superblock log writing. It uses 
>> two
>> zones as a circular buffer to write updated superblocks. Once the first
>> zone is filled up, start writing into the second buffer. Then, when the
>> both zones are filled up and before start writing to the first zone 
>> again,
>> it reset the first zone.
>>
>> We can determine the position of the latest superblock by reading write
>> pointer information from a device. One corner case is when the both zones
>> are full. For this situation, we read out the last superblock of each
>> zone, and compare them to determine which zone is older.
>>
>> The following zones are reserved as the circular buffer on ZONED btrfs.
>>
>> - The primary superblock: zones 0 and 1
>> - The first copy: zones 16 and 17
>> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>>    to it
> 
> Superblock log approach needs a non-deterministic and inconsistent
> number of blocks to be read to find copy #0. And, to use 4K bytes
> we are reserving a lot more space. But I don't know any better way.
> I am just checking with you...
> 
> At the time of mkfs, is it possible to format the block device to
> add conventional zones as needed to support our sb LBAs?

No. The number of conventional zones (if any) are a drive characteristic 
and one cannot assume that the number can be modified.

>   OR
> For superblock zones why not reset the write pointer before the
> transaction commit?
> 
A write pointer reset is equivalent to clearing the contents of the 
zone, so we would lose the previous information there.

HTH.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
