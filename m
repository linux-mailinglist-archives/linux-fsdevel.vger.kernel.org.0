Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF98E37D04D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhELRcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 13:32:12 -0400
Received: from sandeen.net ([63.231.237.45]:45698 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243253AbhELQpd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 12:45:33 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 566E6323C00;
        Wed, 12 May 2021 11:44:03 -0500 (CDT)
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Reichl <preichl@redhat.com>,
        chritophe.vu-brugier@seagate.com
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
 <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
 <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
 <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
 <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
 <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
 <CANFS6bZs3bDQdKH-PYnQqo=3iDUaVy5dH8VQ+JE8WdeVi4o0NQ@mail.gmail.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: problem with exfat on 4k logical sector devices
Message-ID: <35b5967f-dc19-f77f-f7d1-bf1d6e2b73e8@sandeen.net>
Date:   Wed, 12 May 2021 11:44:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CANFS6bZs3bDQdKH-PYnQqo=3iDUaVy5dH8VQ+JE8WdeVi4o0NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/21 9:09 AM, Hyunchul Lee wrote:
> Hello,
> 
> 2021년 5월 12일 (수) 오전 8:57, Eric Sandeen <sandeen@sandeen.net>님이 작성:
>>
>> On 5/11/21 6:53 PM, Namjae Jeon wrote:
>>
>>>> One other thing that I ran across is that fsck seems to validate an image against the sector size of
>>>> the device hosting the image rather than the sector size found in the boot sector, which seems like
>>>> another issue that will come up:
>>>>
>>>> # fsck/fsck.exfat /dev/sdb
>>>> exfatprogs version : 1.1.1
>>>> /dev/sdb: clean. directories 1, files 0
>>>>
>>>> # dd if=/dev/sdb of=test.img
>>>> 524288+0 records in
>>>> 524288+0 records out
>>>> 268435456 bytes (268 MB) copied, 1.27619 s, 210 MB/s
>>>>
>>>> # fsck.exfat test.img
>>>> exfatprogs version : 1.1.1
>>>> checksum of boot region is not correct. 0, but expected 0x3ee721 boot region is corrupted. try to
>>>> restore the region from backup. Fix (y/N)? n
>>>>
>>>> Right now the utilities seem to assume that the device they're pointed at is always a block device,
>>>> and image files are problematic.
>>> Okay, Will fix it.
>>
>> Right now I have a hack like this.
>>
>> 1) don't validate the in-image sector size against the host device size
>> (maybe should only skip this check if it's not a bdev? Or is it OK to have
>> a 4k sector size fs on a 512 device? Probably?)
>>
>> 2) populate the "bd" sector size information from the values read from the image.
>>
>> It feels a bit messy, but it works so far. I guess the messiness stems from
>> assuming that we always have a "bd" block device.
>>
> 
> I think we need to keep the "bd" sector size to avoid confusion between
> the device's sector size and the exfat's sector size.

Sure, it's just that for a filesystem in an image file, there is no meaning to
the "device sector size" because there is no device.

...

> Is it better to add a sector size parameter to read_boot_region
> function? This function
> is also called to read the backup boot region to restore the corrupted
> main boot region.
> During this restoration, we need to read the backup boot region with
> various sector sizes,
> Because we don't have a certain exfat sector size.
> 
>>         ret = boot_region_checksum(bd, bs_offset);
>>         if (ret < 0)
>>                 goto err;
>>
>>
> 
> I sent the pull request to fix these problems. Could you check this request?
> https://github.com/exfatprogs/exfatprogs/pull/167

I didn't review that in depth, but it looks like for fsck and dump, it gets the
sector size from the boot sector rather than from the host device or filesystem,
which makes sense, at least.

(As an aside, I'd suggest that your new "c2o" function could have a more
descriptive, self-documenting name.)

But there are other problems where bd->sector_* is used and assumed to relate
to the filesystem, for example:

# fsck/fsck.exfat /root/test.img 
exfatprogs version : 1.1.1
/root/test.img: clean. directories 1, files 0
# tune/tune.exfat -I 0x1234  /root/test.img 
exfatprogs version : 1.1.1
New volume serial : 0x1234
# fsck/fsck.exfat /root/test.img 
exfatprogs version : 1.1.1
checksum of boot region is not correct. 0x3eedc5, but expected 0xe59577e3
boot region is corrupted. try to restore the region from backup. Fix (y/N)? n

I think because exfat_write_checksum_sector() relies on bd->sector_size.

You probably need to audit every use of bd->sector_size and
bd->sector_size_bits outside of mkfs, because anything assuming that it
is related to the filesystem itself, as opposed to the filesytem/device
hosting it, could be problematic.  Is there any time outside of mkfs that
you actually care about the device sector size? If not, I might suggest
trying to isolate that usage to mkfs.

I also wonder about:

        bd->num_sectors = blk_dev_size / DEFAULT_SECTOR_SIZE;
        bd->num_clusters = blk_dev_size / ui->cluster_size;

is it really correct that this should always be in terms of 512-byte sectors?

-Eric
