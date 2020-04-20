Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680C71AFF7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 03:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDTBP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 21:15:56 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36043 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgDTBP4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:15:56 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 21:15:55 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D1AF020424C;
        Mon, 20 Apr 2020 03:06:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o6RaDLZrkeY2; Mon, 20 Apr 2020 03:06:08 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 54118204157;
        Mon, 20 Apr 2020 03:06:07 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned block
 devices
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <afefece2-3016-8b58-fda4-1fbd7fcac75c@acm.org>
 <BY5PR04MB6900CA6DD8B3354981DB688BE7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <be9f128e-788d-bf0d-2965-feb7305b1a3a@interlog.com>
Date:   Sun, 19 Apr 2020 21:06:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB6900CA6DD8B3354981DB688BE7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-19 8:21 p.m., Damien Le Moal wrote:
> On 2020/04/19 0:56, Bart Van Assche wrote:
>> On 2020-04-17 05:15, Johannes Thumshirn wrote:
>>> In order to reduce memory consumption, the only cached item is the offset
>>> of the write pointer from the start of the zone, everything else can be
>>> calculated. On an example drive with 52156 zones, the additional memory
>>> consumption of the cache is thus 52156 * 4 = 208624 Bytes or 51 4k Byte
>>> pages. The performance impact is neglectable for a spinning drive.
>>
>> What will happen if e.g. syzkaller mixes write() system calls with SG_IO
>> writes? Can that cause a mismatch between the cached write pointer and
>> the write pointer maintained by the drive? If so, should SG_IO perhaps
>> be disallowed if the write pointer is cached?
> 
> Bart,
> 
> Yes, SG_IO write will change the WP on the device side, causing the driver WP
> cache to go out of sync with the device. We actually use that for testing and
> generating write errors.
> 
> But that is not a problem limited to this new write pointer caching scheme. Any
> zoned drive user can hit this problem (dm-zoned or f2fs currently). More
> generally speaking, SG_IO writes can corrupt data/metadata on any regular disk
> without (for instance) the file system noticing until the corrupted
> data/metadata is accessed. SG_IO to a disk is not disabled if the disk has a
> mounted file system. Also, since the series adds unconditional write pointer
> caching with CONFIG_BLK_DEV_ZONED enabled, that would disable SG_IO permanently
> in this case, and negatively impact a lot of userspace tools relying on it (FW
> update, power management, SMART, etc).

Putting my smartmontools maintainer hat on, I don't like the sound of that.
We have spent time in the past discussing black and white lists, but they
can't cope with vendor specific commands. Then there are commands that both
sd and smartmontools might have good cause to use; MODE SELECT comes to
mind. Changing the setting of the URSWRZ_M bit in the Zoned Block Device
Control page, for example, could upset the apple cart.

Doug Gilbert


