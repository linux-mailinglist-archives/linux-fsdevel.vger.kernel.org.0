Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7134456
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFDK0G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 4 Jun 2019 06:26:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6957 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfFDK0G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:26:06 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id E6173E301BE5D144F403;
        Tue,  4 Jun 2019 18:26:02 +0800 (CST)
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.236]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0439.000; Tue, 4 Jun 2019 18:25:54 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     "Yuchao (T)" <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: RE: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS
Thread-Topic: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS
Thread-Index: AQHVEdFe1H4hbuAg10SRna9O0QiaOKaDWYUAgACig4CABauIgIAAnKAAgAEWT70=
Date:   Tue, 4 Jun 2019 10:25:54 +0000
Message-ID: <157FC541501A9C4C862B2F16FFE316DC1900FE39@dggeml512-mbx.china.huawei.com>
References: <20190524015555.12622-1-sunqiuyang@huawei.com>
 <20190530160626.GA28719@jaegeuk-macbookpro.roam.corp.google.com>
 <786721cc-90eb-cf2c-eed8-3be0ef9dff8c@huawei.com>
 <20190603162319.GA34729@jaegeuk-macbookpro.roam.corp.google.com>,<ba9aaee7-6bc4-b8d4-4670-54f11fc0cea0@huawei.com>
In-Reply-To: <ba9aaee7-6bc4-b8d4-4670-54f11fc0cea0@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.249.127]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have tried to add power failure after committing the new SB (resized) and before writing the new CP. This will cause FS inconsistency:

[FSCK] free segment_count matched with CP [Fail] 

which can be fixed by the fsck tool, resulting in a resized FS.

________________________________________
From: Yuchao (T)
Sent: Tuesday, June 04, 2019 9:43
To: Jaegeuk Kim
Cc: sunqiuyang; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS

On 2019/6/4 0:23, Jaegeuk Kim wrote:
> On 05/31, Chao Yu wrote:
>> On 2019/5/31 0:06, Jaegeuk Kim wrote:
>>> On 05/24, sunqiuyang wrote:
>>>> From: Qiuyang Sun <sunqiuyang@huawei.com>
>>>>
>>>> This ioctl shrinks a given length (aligned to sections) from end of the
>>>> main area. Any cursegs and valid blocks will be moved out before
>>>> invalidating the range.
>>>>
>>>> This feature can be used for adjusting partition sizes online.
>>>> --
>>>> Changlog v1 ==> v2:
>>>>
>>>> Sahitya Tummala:
>>>>  - Add this ioctl for f2fs_compat_ioctl() as well.
>>>>  - Fix debugfs status to reflect the online resize changes.
>>>>  - Fix potential race between online resize path and allocate new data
>>>>    block path or gc path.
>>>>
>>>> Others:
>>>>  - Rename some identifiers.
>>>>  - Add some error handling branches.
>>>>  - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
>>>> --
>>>> Changelog v2 ==> v3:
>>>> Implement this interface as ext4's, and change the parameter from shrunk
>>>> bytes to new block count of F2FS.
>>>> --
>>>> Changelog v3 ==> v4:
>>>>  - During resizing, force to empty sit_journal and forbid adding new
>>>>    entries to it, in order to avoid invalid segno in journal after resize.
>>>>  - Reduce sbi->user_block_count before resize starts.
>>>>  - Commit the updated superblock first, and then update in-memory metadata
>>>>    only when the former succeeds.
>>>>  - Target block count must align to sections.
>>>> --
>>>> Changelog v4 ==> v5:
>>>> Write checkpoint before and after committing the new superblock, w/o
>>>> CP_FSCK_FLAG respectively, so that the FS can be fixed by fsck even if
>>>> resize fails after the new superblock is committed.
>>>> --
>>>> Changelog v5 ==> v6:
>>>>  - In free_segment_range(), reduce granularity of gc_mutex.
>>>>  - Add protection on curseg migration.
>>>>
>>>> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>> ---
>>>>  fs/f2fs/checkpoint.c |   5 +-
>>>>  fs/f2fs/debug.c      |   7 +++
>>>>  fs/f2fs/f2fs.h       |   7 +++
>>>>  fs/f2fs/file.c       |  28 +++++++++++
>>>>  fs/f2fs/gc.c         | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>  fs/f2fs/segment.c    |  54 +++++++++++++++++----
>>>>  fs/f2fs/segment.h    |   1 +
>>>>  fs/f2fs/super.c      |   4 ++
>>>>  8 files changed, 228 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index ed70b68..4706d0a 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -1313,8 +1313,11 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>    else
>>>>            __clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
>>>>
>>>> -  if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>>>> +  if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
>>>> +          is_sbi_flag_set(sbi, SBI_IS_RESIZEFS))
>>>>            __set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>>>> +  else
>>>> +          __clear_ckpt_flags(ckpt, CP_FSCK_FLAG);
>>>
>>> We don't need to clear this flag.
>>
>> During resizefs, we may face inconsistent status of filesystem's on-disk data,
>> so I propose to use below flow, so once some thing breaks resizefs, fsck can
>> detect the corruption by the CP_FSCK_FLAG directly.
>>
>> - resizefs()
>>  - set SBI_IS_RESIZEFS
>>  - do_checkpoint()
>>   - if (is_resizing)
>>    - set CP_FSCK_FLAG
>>
>>  - clear SBI_IS_RESIZEFS
>>  - do_checkpoint()
>>   - if (!is_resizing && not_need_fsck)
>>    - clear CP_FSCK_FLAG
>>
>> It's safe to clear CP_FSCK_FLAG if there is no resizing and corruption, as once
>> the inconsistency was detected we will keep SBI_NEED_FSCK in memory anyway, then
>> checkpoint can set CP_FSCK_FLAG again.
>
> This tries to resize the image and I mostly worried whether fsck is able to fix

So, Qiuyang, could you try break resizefs at some key points with power-cut, to
check whether fsck can repair all corruption cases? and what is the result
(resized fs or origianl fs)?

> the corrupted metadata area. Moreover, I'm in doubt we really need to do this in
> parallel with FS operations.

What do you mean? We have wrapped main resizefs operaion with
{freeze,thaw}_bdev, so there should be no parallel FS operations.

Thanks,

