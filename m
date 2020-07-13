Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDB21CCD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 03:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGMBlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 21:41:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7839 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbgGMBlA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:41:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADFC6E5CEAD6CEEBB804;
        Mon, 13 Jul 2020 09:40:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.187) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Jul 2020
 09:40:48 +0800
Subject: Re: [PATCH v3 0/5] ext4: fix inconsistency since async write metadata
 buffer error
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.com>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <4b8a3738-cf3a-a1fb-06d6-c14436cf2cf4@huawei.com>
Date:   Mon, 13 Jul 2020 09:40:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200620025427.1756360-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.187]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ted and Jan, what do you think about this solution ?

Thanks,
Yi.

On 2020/6/20 10:54, zhangyi (F) wrote:
> Changes since v2:
>  - Christoph against the solution of adding callback in the block layer
>    that could let ext4 handle write error. So for simplicity, switch to
>    check the bdev mapping->wb_err when ext4 getting journal write access
>    as Jan suggested now. Maybe we could implement the callback through
>    introduce a special inode (e.g. a meta inode) for ext4 in the future.
>  - Patch 1: Add mapping->wb_err check and invoke ext4_error_err() in
>    ext4_journal_get_write_access() if wb_err is different from the
>    original one saved at mount time.
>  - Patch 2-3: Remove partial fix <7963e5ac90125> and <9c83a923c67d>.
>  - Patch 4: Fix another inconsistency problem since we may bypass the
>    journal's checkpoint procedure if we free metadata buffers which
>    were failed to async write out.
>  - Patch 5: Just a cleanup patch.
>    
> The above 5 patches are based on linux-5.8-rc1 and have been tested by
> xfstests, no newly increased failures.
> 
> Thanks,
> Yi.
> 
> -----------------------
> 
> Original background
> ===================
> 
> This patch set point to fix the inconsistency problem which has been
> discussed and partial fixed in [1].
> 
> Now, the problem is on the unstable storage which has a flaky transport
> (e.g. iSCSI transport may disconnect few seconds and reconnect due to
> the bad network environment), if we failed to async write metadata in
> background, the end write routine in block layer will clear the buffer's
> uptodate flag, but the data in such buffer is actually uptodate. Finally
> we may read "old && inconsistent" metadata from the disk when we get the
> buffer later because not only the uptodate flag was cleared but also we
> do not check the write io error flag, or even worse the buffer has been
> freed due to memory presure.
> 
> Fortunately, if the jbd2 do checkpoint after async IO error happens,
> the checkpoint routine will check the write_io_error flag and abort the
> the journal if detect IO error. And in the journal recover case, the
> recover code will invoke sync_blockdev() after recover complete, it will
> also detect IO error and refuse to mount the filesystem.
> 
> Current ext4 have already deal with this problem in __ext4_get_inode_loc()
> and commit 7963e5ac90125 ("ext4: treat buffers with write errors as
> containing valid data"), but it's not enough.
> 
> [1] https://lore.kernel.org/linux-ext4/20190823030207.GC8130@mit.edu/
> 
> 
> zhangyi (F) (5):
>   ext4: abort the filesystem if failed to async write metadata buffer
>   ext4: remove ext4_buffer_uptodate()
>   ext4: remove write io error check before read inode block
>   jbd2: abort journal if free a async write error metadata buffer
>   jbd2: remove unused parameter in jbd2_journal_try_to_free_buffers()
> 
>  fs/ext4/ext4.h        | 16 +++-------------
>  fs/ext4/ext4_jbd2.c   | 25 +++++++++++++++++++++++++
>  fs/ext4/inode.c       | 15 +++------------
>  fs/ext4/super.c       | 23 ++++++++++++++++++++---
>  fs/jbd2/transaction.c | 20 ++++++++++++++------
>  include/linux/jbd2.h  |  2 +-
>  6 files changed, 66 insertions(+), 35 deletions(-)
> 

