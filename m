Return-Path: <linux-fsdevel+bounces-37614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A839F453D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB73169218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B11D1724;
	Tue, 17 Dec 2024 07:38:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD250276;
	Tue, 17 Dec 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421128; cv=none; b=IU42zuW+HNQVbWOz0yCMK5cm6pjjwg8mbRuHCCdZMhWHPOT+5Fhid4MdbvFXHTyHOqtCdvx6KaIoRXTkJObmlZshpS3/8Wjire7N+gXzJyY27R+l6gqGtjlA2lWkKyGu+oIuKPwX0ANzH3XgsLlb5z+E2lVWZWEBAd5ifKq2wHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421128; c=relaxed/simple;
	bh=dZXfiaEqrBcd9nj6W/pzU+FSLgaznwKBVxJr5HWva7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsY8Ypw0p57QH1YmPa1FSB/6urPHizoSSd2r9I1vBgA8/7+M7nPUgXtdRb52p4LVhvcm0AN80ezsrUZM3WVLiWj98r8b1qzx6wSL0DUbkk0KBLLnxq3Y1GXUeq5TKyU8zxsmq669To216GbYMa5kaey+bXD036RkMhhvOapE1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC7w33BDSz4f3jqb;
	Tue, 17 Dec 2024 15:38:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D734B1A0568;
	Tue, 17 Dec 2024 15:38:41 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoKAKmFnLsxcEw--.50920S3;
	Tue, 17 Dec 2024 15:38:41 +0800 (CST)
Message-ID: <b222e406-5f17-47f5-8671-c913452615af@huaweicloud.com>
Date: Tue, 17 Dec 2024 15:38:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
 <Z2BD_JLfuZ9VVwhQ@casper.infradead.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z2BD_JLfuZ9VVwhQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3XoKAKmFnLsxcEw--.50920S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWkCr45AryfCF4UKFWrAFb_yoWDCrX_JF
	1jvFZ7WrW7Aay0kr4qvw4Utr4DK3WSvw1UJrykXry7Jr4qyw1DAF4DAr1xGryrJw47JrW3
	Cr17Xr1DGry2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/16 23:15, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 09:39:06AM +0800, Zhang Yi wrote:
>>  $mkfs.ext4 -b 1024 /dev/vdb
>>  $mount /dev/vdb /mnt
>>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
>>
>>  $od -Ax -t x1z /mnt/foo
>>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>>  *
>>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>>  *
>>  001000
>>
>>  $umount /mnt && mount /dev/vdb /mnt
>>  $od -Ax -t x1z /mnt/foo
>>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>>  *
>>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  *
>>  001000
> 
> Can you add this to fstests please so we can be sure other filesystems
> don't have the same problem?

Sure, I captured this issue by generic/567 while refactoring punch
hole operation on ext4. The generic/567 only performs a partial punch
hole test but does not include a partial zero range test, so we
did not capture this issue. I will expand this test and add this case.

Thanks,
Yi.


