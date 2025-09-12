Return-Path: <linux-fsdevel+bounces-60996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92989B5429C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE57164861
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B314280317;
	Fri, 12 Sep 2025 06:16:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DC23D7EA;
	Fri, 12 Sep 2025 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657782; cv=none; b=NrVNMx2nD+bJ9c0yM3nneE/hdDcb+//Xj4L7IKQ2/VT6QeIKXSu5EdBdgT0KSEy3JsT6vaTUCdAQ9rsaGY7QpPOSRrhDu9/D5UAh3caL+0+rcyAteVMl/DUN7ay4gn3X2SPBSm/4Qtc3zKI2E9V3I2ZrgBkhI+H33Asen9TmPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657782; c=relaxed/simple;
	bh=CoHOnG0sU8oHdFLCPcDgLq5oy9StIEmgbV/rIBCw1bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmI3GqXtlGvoUuGA6Vk7U5bDX6fEWh/DnxayjASXJ3bR4pdPYgH/em5Up2bBcbNuMpZb99gG9NQm5Fpbr5GeTnN21QgNHYDVTAdMl4+j0heQ2YsQvI5EL1Olrc7FHzSqDWsm4KxjU7H0tISZHuLRR9ljVKL2EYywby5emP93+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cNPM63CJlzYQvFJ;
	Fri, 12 Sep 2025 14:16:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EFE8F1A0F1E;
	Fri, 12 Sep 2025 14:16:16 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY6rusNoytzrCA--.39146S3;
	Fri, 12 Sep 2025 14:16:13 +0800 (CST)
Message-ID: <c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
Date: Fri, 12 Sep 2025 14:16:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix the initialization of
 max_hw_wzeroes_unmap_sectors for stacking drivers
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 drbd-dev@lists.linbit.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
 pmenzel@molgen.mpg.de, hch@lst.de, martin.petersen@oracle.com,
 yi.zhang@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXIY6rusNoytzrCA--.39146S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw13KrW7Zw1fAF4UCr18Grg_yoWkWrc_uF
	4YgrZ2vw4kGF1ayF1UKF1fZry2yay8XFn5uryjgayFg34Sva1rCa1q9ry5J3Z8AF9FvFZ8
	AF1kt3yxZF9xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Jens!

Can you take this patch set through the linux-block tree?

Thanks,
Yi.

On 9/10/2025 7:11 PM, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Improve commit messages in patch 1 by adding a simple reproduction
>    case as Paul suggested and explaining the implementation differences
>    between RAID 0 and RAID 1/10/5, no code changes.
> 
> v1: https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/
> 
> This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
> queue_limits for all md raid and drbd drivers, preventing
> blk_validate_limits() failures on underlying devices that support the
> unmap write zeroes command.
> 
> Best regards,
> Yi.
> 
> Zhang Yi (2):
>   md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>   drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
> 
>  drivers/block/drbd/drbd_nl.c | 1 +
>  drivers/md/md-linear.c       | 1 +
>  drivers/md/raid0.c           | 1 +
>  drivers/md/raid1.c           | 1 +
>  drivers/md/raid10.c          | 1 +
>  drivers/md/raid5.c           | 1 +
>  6 files changed, 6 insertions(+)
> 


