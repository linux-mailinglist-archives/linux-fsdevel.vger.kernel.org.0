Return-Path: <linux-fsdevel+bounces-55940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5DB10927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 13:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACFC584C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0C02749D8;
	Thu, 24 Jul 2025 11:27:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DF2727E2;
	Thu, 24 Jul 2025 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356425; cv=none; b=Lq2VJ2vylQu2tJ4pDfCE/PloqfWchWKUKMFFhyTptztjvKTf4p+XeUTuTAqL+ExdvcLAcBBoaFZ9etOMPdCZWTtKKZ/Giuoyii4/mNwqYELKJogXTYEXoA9HJkk2Z7UkhZq/U+m4xkRg+K+KxJ95VBqAu06Xi83MSDxWpCzUyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356425; c=relaxed/simple;
	bh=P9VfqiWvA20V9ELBXliXvbis8H7A5q9eHZ2f+y+EoFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qXzuc8GxYsoNo8ogfJ+X9ahGOKSSmWnPpbhnjvLXwA+GUz8l2KSCypH43aYfKffnLhfEhZM82Lj/k5ikV3gbjY7SdiRy8B4GLCn2+mhS+ESoTntYEMvzvaTXMpeV6O9G0a8azHlWe04SZUk1yl6IDjoSTqYPCTmsSTV9X5FzY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bnpWQ2ZGDzSjZB;
	Thu, 24 Jul 2025 19:22:26 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id E1D741402CF;
	Thu, 24 Jul 2025 19:26:58 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 19:26:58 +0800
Message-ID: <dcb71be5-18af-4ca0-b5c1-ef4850e1e670@huawei.com>
Date: Thu, 24 Jul 2025 19:26:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add additional checks for block devices during mount
To: <viro@zeniv.linux.org.uk>, <jack@suse.com>, <brauner@kernel.org>,
	<axboe@kernel.dk>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250719024403.3452285-1-wozizhi@huawei.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20250719024403.3452285-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/7/19 10:44, Zizhi Wo 写道:
> A filesystem abnormal mount issue was found during current testing:
> 
> disk_container=$(...kata-runtime...io.kubernets.docker.type=container...)
> docker_id=$(...kata-runtime...io.katacontainers.disk_share=
>              "{"src":"/dev/sdb","dest":"/dev/test"}"...)
> ${docker} stop "$disk_container"
> ${docker} exec "$docker_id" mount /dev/test /tmp -->success!!
> 
> When the "disk_container" is stopped, the created sda/sdb/sdc disks are
> already deleted, but inside the "docker_id", /dev/test can still be mounted
> successfully. The reason is that runc calls unshare, which triggers
> clone_mnt(), increasing the "sb->s_active" reference count. As long as the
> "docker_id" does not exit, the superblock still has a reference count.
> 
> So when mounting, the old superblock is reused in sget_fc(), and the mount
> succeeds, even if the actual device no longer exists. The whole process can
> be simplified as follows:
> 
> mkfs.ext4 -F /dev/sdb
> mount /dev/sdb /mnt
> mknod /dev/test b 8 16    # [sdb 8:16]
> echo 1 > /sys/block/sdb/device/delete
> mount /dev/test /mnt1    # -> mount success
> 
> Therefore, it is necessary to add an extra check. Solve this problem by
> checking disk_live() in super_s_dev_test().
> 
> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
> Link: https://lore.kernel.org/all/20250717091150.2156842-1-wozizhi@huawei.com/
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   fs/super.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 80418ca8e215..8030fb519eb5 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1376,8 +1376,16 @@ static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
>   
>   static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
>   {
> -	return !(s->s_iflags & SB_I_RETIRED) &&
> -		s->s_dev == *(dev_t *)fc->sget_key;
> +	if (s->s_iflags & SB_I_RETIRED)
> +		return false;
> +
> +	if (s->s_dev != *(dev_t *)fc->sget_key)
> +		return false;
> +
> +	if (s->s_bdev && !disk_live(s->s_bdev->bd_disk))
> +		return false;
> +
> +	return true;
>   }
>   
>   /**

Thanks for all the feedback. I will take some time to prepare a v2
version of the fix.

Thanks,
Zizhi Wo



