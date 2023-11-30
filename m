Return-Path: <linux-fsdevel+bounces-4337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585107FEACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CF91C20B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB738DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A8D7F;
	Thu, 30 Nov 2023 00:22:35 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sgpw50yt8zMnVW;
	Thu, 30 Nov 2023 16:17:41 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 16:22:32 +0800
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
To: Christoph Hellwig <hch@infradead.org>, Ritesh Harjani
	<ritesh.list@gmail.com>
CC: Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
References: <87msv5r0uq.fsf@doe.com> <8734wnj53k.fsf@doe.com>
 <ZWgPzfd8P+F/qQlh@infradead.org>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <a2af4039-65e0-6bb5-337e-fc160ae94aee@huawei.com>
Date: Thu, 30 Nov 2023 16:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZWgPzfd8P+F/qQlh@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected

On 2023/11/30 12:30, Christoph Hellwig wrote:
> On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
>> So I took a look at this. Here is what I think -
>> So this is useful of-course when we have a large folio. Because
>> otherwise it's just one block at a time for each folio. This is not a
>> problem once FS buffered-io handling code moves to iomap (because we
>> can then enable large folio support to it).
> 
> Yes.
> 
>> However, this would still require us to pass a folio to ->map_blocks
>> call to determine the size of the folio (which I am not saying can't be
>> done but just stating my observations here).
> 
> XFS currently maps based on the underlyig reservation (delalloc extent)
> and not the actual map size.   This works because on-disk extents are
> allocated as unwritten extents, and only the actual written part is
> the converted.  But if you only want to allocate blocks for the part

IIUC, I noticed a side effect of this map method, Let's think about a
special case, if we sync a partial range of a delalloc extent, and then
the system crashes before the remaining data write back. We could get a
file which has allocated blocks(unwritten) beyond EOF. I can reproduce
it on xfs.

 # write 10 blocks, but only sync 3 blocks, i_size becomes 12K after IO complete
 xfs_io -f -c "pwrite 0 40k" -c "sync_range 0 12k" /mnt/foo
 # postpone the remaining data writeback
 echo 20000 > /proc/sys/vm/dirty_writeback_centisecs
 echo 20000 > /proc/sys/vm/dirty_expire_centisecs
 # wait 35s to make sure xfs's cil log writeback
 sleep 35
 # triger system crash
 echo c > /proc/sysrq-trigger

After system reboot, the 'foo' file's size is 12K but have 10
allocated blocks.

 xfs_db> inode 131
 core.size = 12288
 core.nblocks = 10
 ...
 0:[0,24,3,0]
 1:[3,27,7,1]

I'm not expert on xfs, but I don't think this is the right result,
is it?

Thanks,
Yi.

> actually written you actually need to pass in the dirty range and not
> just use the whole folio.  This would be the incremental patch to do
> that:
> 
> http://git.infradead.org/users/hch/xfs.git/commitdiff/0007893015796ef2ba16bb8b98c4c9fb6e9e6752
> 
> But unless your block allocator is very cheap doing what XFS does is
> probably going to work much better.
> 
>> ...ok so here is the PoC for seq counter check for ext2. Next let me
>> try to see if we can lift this up from the FS side to iomap - 
> 
> This looks good to me from a very superficial view.  Dave is the expert
> on this, though.
> 
> 
> .
> 

