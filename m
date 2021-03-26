Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B474C34A2D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 09:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCZIAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 04:00:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCZIAP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:00:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B349ADEF;
        Fri, 26 Mar 2021 08:00:13 +0000 (UTC)
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
 <20210315201824.GB2577561@casper.infradead.org>
 <20210315210452.GC2577561@casper.infradead.org>
 <CAFnufp3zKa+9K-hsV5vRkv-w8y-1nZioq_bFAnzaxs9RoP+sDA@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bf5478c7-e026-846c-3bb0-fd4c6c38372f@suse.de>
Date:   Fri, 26 Mar 2021 09:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAFnufp3zKa+9K-hsV5vRkv-w8y-1nZioq_bFAnzaxs9RoP+sDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/25/21 6:29 PM, Matteo Croce wrote:
> On Mon, Mar 15, 2021 at 10:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Mon, Mar 15, 2021 at 08:18:24PM +0000, Matthew Wilcox wrote:
>>> On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
>>>> From: Matteo Croce <mcroce@microsoft.com>
>>>>
>>>> Add a sequence number to the disk devices. This number is put in the
>>>> uevent so userspace can correlate events when a driver reuses a device,
>>>> like the loop one.
>>>
>>> Should this be documented as monotonically increasing?  I think this
>>> is actually a media identifier.  Consider (if you will) a floppy disc.
>>> Back when such things were common, it was possible with personal computers
>>> of the era to have multiple floppy discs "in play" and be prompted to
>>> insert them as needed.  So shouldn't it be possible to support something
>>> similar here -- you're really removing the media from the loop device.
>>> With a monotonically increasing number, you're always destroying the
>>> media when you remove it, but in principle, it should be possible to
>>> reinsert the same media and have the same media identifier number.
>>
>> So ... a lot of devices have UUIDs or similar.  eg:
>>
>> $ cat /sys/block/nvme0n1/uuid
>> e8238fa6-bf53-0001-001b-448b49cec94f
>>
>> https://linux.die.net/man/8/scsi_id (for scsi)
>>
> 
> Hi,
> 
> I don't have uuid anywhere:
> 
> matteo@saturno:~$ ll /dev/sd?
> brw-rw---- 1 root disk 8,  0 feb 16 13:24 /dev/sda
> brw-rw---- 1 root disk 8, 16 feb 16 13:24 /dev/sdb
> brw-rw---- 1 root disk 8, 32 feb 16 13:24 /dev/sdc
> brw-rw---- 1 root disk 8, 48 feb 16 13:24 /dev/sdd
> brw-rw---- 1 root disk 8, 64 mar  4 06:26 /dev/sde
> brw-rw---- 1 root disk 8, 80 feb 16 13:24 /dev/sdf
> matteo@saturno:~$ ll /sys/block/*/uuid
> ls: cannot access '/sys/block/*/uuid': No such file or directory
> 
> mcroce@t490s:~$ ll /dev/nvme0n1
> brw-rw----. 1 root disk 259, 0 25 mar 14.22 /dev/nvme0n1
> mcroce@t490s:~$ ll /sys/block/*/uuid
> ls: cannot access '/sys/block/*/uuid': No such file or directory
> 
> I find it only on a mdraid array:
> 
> $ cat /sys/devices/virtual/block/md127/md/uuid
> 26117338-4f54-f14e-b5d4-93feb7fe825d
> 
> I'm using a vanilla 5.11 kernel.
> 
The 'uuid' is optional for NVMe devices, and indeed not even present for 
other device types.
Use the 'wwid' attribute, which contains a unique identifier for all 
nvme devices:

# cat /sys/block/nvme*/wwid
nvme.8086-4356504436343735303034323430304e474e-564f303430304b45464a42-00000001
nvme.8086-4356504436343735303034363430304e474e-564f303430304b45464a42-00000001
uuid.3c6500ee-a775-4c89-b223-e9551f5a9f7a

and for SCSI the wwid is part of the SCSI device:
# cat /sys/block/sd*/device/wwid
naa.600508b1001ce2e648a35b6ec14a3996

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
