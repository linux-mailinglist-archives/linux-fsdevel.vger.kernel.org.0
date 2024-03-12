Return-Path: <linux-fsdevel+bounces-14206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1D4879465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598381C220D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7C5812D;
	Tue, 12 Mar 2024 12:45:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189556450;
	Tue, 12 Mar 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247499; cv=none; b=cpV1dlDN2UkGuVUx2yUMTKHI8k2g8bwHHskSUjCQBEymkovLNLsgqraAI/23B0QQvvjpKr7MascU4/5oGiYXcncYsiVH9+/ZsMJYYcb/1YfQLjaKdyM/VjoLSPTI0n2MnozXilF7lX9E70qyMHA0xKHW61Wlq81JQWFGLiyA+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247499; c=relaxed/simple;
	bh=fo2PUinZrKOftVrEk38HPvk2sVAXUsDtMB8dDlZidUI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KdKGVEJ6iCpJg67Dp7OIYNY6MTf2RwfuXlOf9UXzVicOEPI4P+mIqN/pU9G1JJBrGmzUBmRaMdv3FJfFryZZlwxXHhZImbxh05tUyKppYqGcdxxdTOfRzrPF1kR/pxI3J7ksTf+z5W5BU5SQ6s6N0g9UVfg6MVhOjUxuwVYTTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TvCyj3NKYz4f3lgS;
	Tue, 12 Mar 2024 20:44:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 28E231A0232;
	Tue, 12 Mar 2024 20:44:53 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFDTvBlbtDmGg--.34133S3;
	Tue, 12 Mar 2024 20:44:52 +0800 (CST)
Subject: Re: [PATCH 2/4] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, david@fromorbit.com,
 tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
 <20240311153737.GT1927156@frogsfrogsfrogs> <ZfBI1l2l3TWw0tMV@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ad9c96de-26f3-6ef5-a2ab-37504d371fb1@huaweicloud.com>
Date: Tue, 12 Mar 2024 20:44:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZfBI1l2l3TWw0tMV@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFDTvBlbtDmGg--.34133S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4fJw1rWF18Jr4kCrW5trb_yoWfGrX_ua
	48AF1rGryDJFZxGanrAr13JrZ2vF10gF4UXryftw42q347tFZ8ZF4UArWFqr1qgasIv34a
	kryrCrnaga4avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UQzVbUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/3/12 20:21, Christoph Hellwig wrote:
> On Mon, Mar 11, 2024 at 08:37:37AM -0700, Darrick J. Wong wrote:
>>> +convert_delay:
>>> +	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
>>> +	xfs_iunlock(ip, lockmode);
>>> +	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
>>> +	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
>>> +				       flags, &imap, &seq);
>>
>> I expected this to be a direct call to xfs_bmapi_convert_delalloc.
>> What was the reason not for using that?
> 
> Same here.  The fact that we even convert delalloc reservations in
> xfs_iomap_write_direct is something that doesn't make much sense
> given that we're punching out delalloc reservations before starting
> direct I/O.
> 

OK, sure, I will use xfs_bmapi_convert_delalloc() in my next iteration.

Thanks，
Yi.


