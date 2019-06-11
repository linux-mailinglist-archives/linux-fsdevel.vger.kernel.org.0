Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3746C3C5A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404619AbfFKILH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 04:11:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18545 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404432AbfFKILH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:11:07 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47CABB653578D8FD9F97;
        Tue, 11 Jun 2019 16:04:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 16:04:49 +0800
Subject: Re: [PATCH v8 1/1] f2fs: ioctl for removing a range from F2FS
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <jaegeuk@kernel.org>
References: <20190605033325.47628-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fff6519a-17c7-35d3-19ff-37163cc0283a@huawei.com>
Date:   Tue, 11 Jun 2019 16:04:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190605033325.47628-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/5 11:33, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> This ioctl shrinks a given length (aligned to sections) from end of the
> main area. Any cursegs and valid blocks will be moved out before
> invalidating the range.
> 
> This feature can be used for adjusting partition sizes online.
> --
> Changlog v1 ==> v2:
> 
> Sahitya Tummala:
>  - Add this ioctl for f2fs_compat_ioctl() as well.
>  - Fix debugfs status to reflect the online resize changes.
>  - Fix potential race between online resize path and allocate new data
>    block path or gc path.
> 
> Others:
>  - Rename some identifiers.
>  - Add some error handling branches.
>  - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
> --
> Changelog v2 ==> v3:
> Implement this interface as ext4's, and change the parameter from shrunk
> bytes to new block count of F2FS.
> --
> Changelog v3 ==> v4:
>  - During resizing, force to empty sit_journal and forbid adding new
>    entries to it, in order to avoid invalid segno in journal after resize.
>  - Reduce sbi->user_block_count before resize starts.
>  - Commit the updated superblock first, and then update in-memory metadata
>    only when the former succeeds.
>  - Target block count must align to sections.
> --
> Changelog v4 ==> v5:
> Write checkpoint before and after committing the new superblock, w/o
> CP_FSCK_FLAG respectively, so that the FS can be fixed by fsck even if
> resize fails after the new superblock is committed.
> --
> Changelog v5 ==> v6:
>  - In free_segment_range(), reduce granularity of gc_mutex.
>  - Add protection on curseg migration.
> --
> Changelog v6 ==> v7:
>  - Add freeze_bdev() and thaw_bdev() for resize fs.
>  - Remove CUR_MAIN_SECS and use MAIN_SECS directly for allocation.
>  - Recover super_block and FS metadata when resize fails.
> --
> Changelog v7 ==> v8:
>  - No need to clear CP_FSCK_FLAG in update_ckpt_flags().
>  - Clean up the sb and fs metadata update functions for resize_fs.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Qiuyang, could you please add one f2fs individual testcase in fstest suit to do
simple test with this ioctl.

e.g.
- mkfs & mount
- fragment image
- resizefs ioctl
- check fs size via statfs
- umount & fsck
- maybe mount & check again

Thanks,
