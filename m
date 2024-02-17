Return-Path: <linux-fsdevel+bounces-11910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C2858E55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 10:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E7D1F21F22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 09:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A81D553;
	Sat, 17 Feb 2024 09:31:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCD1D525;
	Sat, 17 Feb 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708162296; cv=none; b=l5OvcSVxZRzWB3AvpKJmGROeI6LUufVIyYLBdibAEjUPwASx3Gb8uXW8Ii/b7eA+cd6tAO+IJfG9Mo/vfCobkpPgyjcr3FpaStL3qjVvVsbzScgGVHezCZdUtsiC46eqgUyOYmGcWBN3k3gedgLgAyVViAQJduj0D35dNEYCH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708162296; c=relaxed/simple;
	bh=OLvOvd+ZV+lea0d9gFrxv+fwwSEy+ijPUHHEfKWAEdA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dMVT9xodJMmAJO+50D2MEHib6H1dsh8Ye7lxrKu2HEUoV8lQrXQGJrIww1cYabXrWCQpJTT00YMcfye8JkKR5m9RSIigf9Yor50HJQp2qb1Udl6QYVm+7qW16jxHSLyXam5UHhCmU2xr8L8zbp1DrP9ayyb/852iBwUNjjL8FJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TcNpd6cgyz4f3knq;
	Sat, 17 Feb 2024 17:31:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B96C41A0390;
	Sat, 17 Feb 2024 17:31:26 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7nfNBlPbkfEQ--.27281S3;
	Sat, 17 Feb 2024 17:31:20 +0800 (CST)
Subject: Re: [RFC PATCH v3 00/26] ext4: use iomap for regular file's buffered
 IO path and enable large foilo
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 hch@infradead.org, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240212061842.GB6180@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <cfb9d61b-be8c-e1fc-1c0d-e25607d99e4a@huaweicloud.com>
Date: Sat, 17 Feb 2024 17:31:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240212061842.GB6180@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn9g7nfNBlPbkfEQ--.27281S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDXw4rCF1xAryDXrWkWFg_yoW5trW8pF
	Z09Fy3Krs5Kry8Wa92vw4Utr4j9w4rGr47JFy3Wry7ZF4DCF1SgFn7KF1Yva98Ar4fG340
	vF4UA34xuan0yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/2/12 14:18, Darrick J. Wong wrote:
> On Sat, Jan 27, 2024 at 09:57:59AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Hello,
>>
>> This is the third version of RFC patch series that convert ext4 regular
>> file's buffered IO path to iomap and enable large folio. It's rebased on
>> 6.7 and Christoph's "map multiple blocks per ->map_blocks in iomap
>> writeback" series [1]. I've fixed all issues found in the last about 3
>> weeks of stress tests and fault injection tests in v2. I hope I've
>> covered most of the corner cases, and any comments are welcome. :)
>>
>> Changes since v2:
>>  - Update patch 1-6 to v3 [2].
>>  - iomap_zero and iomap_unshare don't need to update i_size and call
>>    iomap_write_failed(), introduce a new helper iomap_write_end_simple()
>>    to avoid doing that.
>>  - Factor out ext4_[ext|ind]_map_blocks() parts from ext4_map_blocks(),
>>    introduce a new helper ext4_iomap_map_one_extent() to allocate
>>    delalloc blocks in writeback, which is always under i_data_sem in
>>    write mode. This is done to prevent the writing back delalloc
>>    extents become stale if it raced by truncate.
>>  - Add a lock detection in mapping_clear_large_folios().
>> Changes since v1:
>>  - Introduce seq count for iomap buffered write and writeback to protect
>>    races from extents changes, e.g. truncate, mwrite.
>>  - Always allocate unwritten extents for new blocks, drop dioread_lock
>>    mode, and make no distinctions between dioread_lock and
>>    dioread_nolock.
>>  - Don't add ditry data range to jinode, drop data=ordered mode, and
>>    make no distinctions between data=ordered and data=writeback mode.
>>  - Postpone updating i_disksize to endio.
>>  - Allow splitting extents and use reserved space in endio.
>>  - Instead of reimplement a new delayed mapping helper
>>    ext4_iomap_da_map_blocks() for buffer write, try to reuse
>>    ext4_da_map_blocks().
>>  - Add support for disabling large folio on active inodes.
>>  - Support online defragmentation, make file fall back to buffer_head
>>    and disable large folio in ext4_move_extents().
>>  - Move ext4_nonda_switch() in advance to prevent deadlock in mwrite.
>>  - Add dirty_len and pos trace info to trace_iomap_writepage_map().
>>  - Update patch 1-6 to v2.
>>
>> This series only support ext4 with the default features and mount
>> options, doesn't support inline_data, bigalloc, dax, fs_verity, fs_crypt
>> and data=journal mode, ext4 would fall back to buffer_head path
> 
> Do you plan to add bigalloc or !extents support as a part 2 patchset?

Hello,

Sorry for the late reply since I was on the vacation of Chinese New Year.
I've been working on bigalloc support recently and it's going relatively
well, but have no plans to support !extents yet, I would start looking
into it after I finish rebasing my another patch set "ext4: more
accurate metadata reservaion for delalloc mount option" mentioned in my
TODO list.

> 
> An ext2 port to iomap has been (vaguely) in the works for a while,
> though iirc willy never got the performance to match because iomap
> didn't have a mechanism for the caller to tell it "run the IO now even
> though you don't have a complete page, because the indirect block is the
> next block after the 11th block".
> 

Thanks for pointing this out and the explanation given by Matthew. IIUC,
this problem also affects ext4 in !extents mode, but not affects bigalloc,
right?

Thanks,
Yi.


