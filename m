Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A583D4D2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGYKKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 06:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhGYKKY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 06:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B169260E09;
        Sun, 25 Jul 2021 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627210254;
        bh=yQbrkcDM1yJmK+PftQjYegtYQ1gnnfPgYmC1lw0cjwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pN7HlkVX4xMxq6PYGr86ouHgYPN4BM2tSJa5oUD15kkgc1b+9w8Y2sEy6SEHKzr81
         +uZkRPeeqTE8Z+QH7n9Ty/zswhUrPB46PhIpL0nA+bczwBPF+m62Z9bj+oAscjeUGd
         KY7YQfzXlPBozAkQh6fhM/IP7HhTUJDEpADa3XbKr1hxLdG5cOmimsafF7eQYe+YqY
         VHxvo3u5L0SOsrJjdG0ozEX3uQtxqFG5bAUtHHzgBvCPmXZw7vd2RDUQDfbJYcXtHu
         TzhkWQv8pNLZvbj+xmyFcvqAqMt+eicbMHJPPeFqL+CqOxodBVe7E5MWtRXiJP7HML
         0+9q4Z73B0gWg==
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
To:     Eric Biggers <ebiggers@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
Date:   Sun, 25 Jul 2021 18:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716143919.44373-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/16 22:39, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs_write_begin() assumes that all blocks were preallocated by
> default unless FI_NO_PREALLOC is explicitly set.  This invites data
> corruption, as there are cases in which not all blocks are preallocated.
> Commit 47501f87c61a ("f2fs: preallocate DIO blocks when forcing
> buffered_io") fixed one case, but there are others remaining.

Could you please explain which cases we missed to handle previously?
then I can check those related logic before and after the rework.

> -			/*
> -			 * If force_buffere_io() is true, we have to allocate
> -			 * blocks all the time, since f2fs_direct_IO will fall
> -			 * back to buffered IO.
> -			 */
> -			if (!f2fs_force_buffered_io(inode, iocb, from) &&
> -					f2fs_lfs_mode(F2FS_I_SB(inode)))

We should keep this OPU DIO logic, otherwise, in lfs mode, write dio
will always allocate two block addresses for each 4k append IO.

I jsut test based on codes of last f2fs dev-test branch.

rm /mnt/f2fs/dio
dd if=/dev/zero  of=/mnt/f2fs/dio bs=4k count=4 oflag=direct

           <...>-763176  [001] ...1 177258.793370: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 0, start blkaddr = 0xe1a2e, len = 0x1, flags = 48,seg_type = 1, may_create = 1, err = 0
            <...>-763176  [001] ...1 177258.793462: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 0, start blkaddr = 0xe1a2f, len = 0x1, flags = 16,seg_type = 1, may_create = 1, err = 0
               dd-763176  [001] ...1 177258.793575: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 1, start blkaddr = 0xe1a30, len = 0x1, flags = 48,seg_type = 1, may_create = 1, err = 0
               dd-763176  [001] ...1 177258.793599: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 1, start blkaddr = 0xe1a31, len = 0x1, flags = 16,seg_type = 1, may_create = 1, err = 0
               dd-763176  [001] ...1 177258.793735: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 2, start blkaddr = 0xe1a32, len = 0x1, flags = 48,seg_type = 1, may_create = 1, err = 0
               dd-763176  [001] ...1 177258.793769: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 2, start blkaddr = 0xe1a33, len = 0x1, flags = 16,seg_type = 1, may_create = 1, err = 0
               dd-763176  [001] ...1 177258.793859: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 3, start blkaddr = 0xe1a34, len = 0x1, flags = 48,seg_type = 1, may_create = 1, err = 0
               dd-763176  [001] ...1 177258.793885: f2fs_map_blocks: dev = (259,1), ino = 6, file offset = 3, start blkaddr = 0xe1a35, len = 0x1, flags = 16,seg_type = 1, may_create = 1, err = 0

Thanks,
