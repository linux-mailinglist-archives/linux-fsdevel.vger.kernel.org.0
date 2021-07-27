Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65403D6CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhG0Cmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 22:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234810AbhG0Cmi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:42:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4370B61057;
        Tue, 27 Jul 2021 03:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627356186;
        bh=D0/BkZwvoY2cXFJOBa5ybmS7OQw1oK528dMchIY/pfI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GHu3QoFDsl+8vzLRi8CnVyGXQMt4VNFo+W1olYrTc9A5weBex/61UroOsj7Hec+T/
         8OkUW+tVkheN8ehlD9VO3XtB2wORjsx50i5aDwADQYFx8GvDllPRgdn3GSxStI0ZkG
         NcAeJNF0cCfiQBlhzSDFqYfL5LmdxJN9T7QHSVMpsivKvweK6HmHkR9QDezWsBD+oR
         a4GI7lrCd6lOVIdgGeIsAKlmbicS86epw49WkbmX08Fh/46yctBfmRLCl+ha4YBEnm
         Tqrg7ut2vZuww9lrRJFiMyjU/bZ1AKcrqu9j36qVWIaXstppawe4KR9LRlu67NP9LQ
         5pS4XbQwzy62w==
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
To:     Eric Biggers <ebiggers@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain> <YP9oou9sx4oJF1sc@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <70f16fec-02f6-cb19-c407-856101cacc23@kernel.org>
Date:   Tue, 27 Jul 2021 11:23:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YP9oou9sx4oJF1sc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/27 10:00, Jaegeuk Kim wrote:
> On 07/25, Eric Biggers wrote:
>> On Sun, Jul 25, 2021 at 06:50:51PM +0800, Chao Yu wrote:
>>> On 2021/7/16 22:39, Eric Biggers wrote:
>>>> From: Eric Biggers <ebiggers@google.com>
>>>>
>>>> f2fs_write_begin() assumes that all blocks were preallocated by
>>>> default unless FI_NO_PREALLOC is explicitly set.  This invites data
>>>> corruption, as there are cases in which not all blocks are preallocated.
>>>> Commit 47501f87c61a ("f2fs: preallocate DIO blocks when forcing
>>>> buffered_io") fixed one case, but there are others remaining.
>>>
>>> Could you please explain which cases we missed to handle previously?
>>> then I can check those related logic before and after the rework.
>>
>> Any case where a buffered write happens while not all blocks were preallocated
>> but FI_NO_PREALLOC wasn't set.  For example when ENOSPC was hit in the middle of
>> the preallocations for a direct write that will fall back to a buffered write,
>> e.g. due to f2fs_force_buffered_io() or page cache invalidation failure.

Indeed, IIUC, the buggy code is as below, if any preallocation failed, we need to
set FI_NO_PREALLOC flag.

map_blocks:
	err = f2fs_map_blocks(inode, &map, 1, flag);
	if (map.m_len > 0 && err == -ENOSPC) {
		if (!direct_io)         <----
			set_inode_flag(inode, FI_NO_PREALLOC);
		err = 0;
	}

BTW, it will be better to include above issue details you explained into commit
message?

>>
>>>
>>>> -			/*
>>>> -			 * If force_buffere_io() is true, we have to allocate
>>>> -			 * blocks all the time, since f2fs_direct_IO will fall
>>>> -			 * back to buffered IO.
>>>> -			 */
>>>> -			if (!f2fs_force_buffered_io(inode, iocb, from) &&
>>>> -					f2fs_lfs_mode(F2FS_I_SB(inode)))
>>>> -				goto write;
>>>
>>> We should keep this OPU DIO logic, otherwise, in lfs mode, write dio
>>> will always allocate two block addresses for each 4k append IO.
>>>
>>> I jsut test based on codes of last f2fs dev-test branch.
>>
>> Yes, I had misread that due to the weird goto and misleading comment and
>> translated it into:
>>
>>          /* If it will be an in-place direct write, don't bother. */
>>          if (dio && !f2fs_lfs_mode(sbi))
>>                  return 0;
>>
>> It should be:
>>
>>          if (dio && f2fs_lfs_mode(sbi))
>>                  return 0;
> 
> Hmm, this addresses my 250 failure. And, I think the below commit can explain
> the case.
> 
> commit 47501f87c61ad2aa234add63e1ae231521dbc3f5
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Tue Nov 26 15:01:42 2019 -0800
> 
>      f2fs: preallocate DIO blocks when forcing buffered_io
> 
>      The previous preallocation and DIO decision like below.
> 
>                               allow_outplace_dio              !allow_outplace_dio
>      f2fs_force_buffered_io   (*) No_Prealloc / Buffered_IO   Prealloc / Buffered_IO
>      !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
> 
>      But, Javier reported Case (*) where zoned device bypassed preallocation but
>      fell back to buffered writes in f2fs_direct_IO(), resulting in stale data
>      being read.
> 
>      In order to fix the issue, actually we need to preallocate blocks whenever
>      we fall back to buffered IO like this. No change is made in the other cases.
> 
>                               allow_outplace_dio              !allow_outplace_dio
>      f2fs_force_buffered_io   (*) Prealloc / Buffered_IO      Prealloc / Buffered_IO
>      !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
> 
>      Reported-and-tested-by: Javier Gonzalez <javier@javigon.com>
>      Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>      Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>      Reviewed-by: Chao Yu <yuchao0@huawei.com>
>      Reviewed-by: Javier González <javier@javigon.com>
>      Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 

Thanks for the explain.

> 
>>
>> Do you have a proper explanation for why preallocations shouldn't be done in

See commit f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode"),
f2fs_map_blocks() logic was changed to force allocating a new block address no matter
previous block address was existed if it is called from write path of DIO. So, in such
condition, if we preallocate new block address in f2fs_file_write_iter(), we will
suffer the problem which my trace indicates.

>> this case?  Note that preallocations are still done for buffered writes, which
>> may be out-of-place as well; how are those different?
Got your concern.

For buffered IO, we use F2FS_GET_BLOCK_PRE_AIO, in this mode, we just preserve
filesystem block count and tag NEW_ADDR in dnode block, so, it's fine, double
new block address allocation won't happen during data page writeback.

For direct IO, we use F2FS_GET_BLOCK_PRE_DIO, in this mode, we will allocate
physical block address, after preallocation, if we fallback to buffered IO, we
may suffer double new block address allocation issue... IIUC.

Well, can we relocate preallocation into f2fs_direct_IO() after all cases which
may cause fallbacking DIO to buffered IO?

Thanks,

>>
>> - Eric
