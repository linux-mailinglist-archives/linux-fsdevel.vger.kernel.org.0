Return-Path: <linux-fsdevel+bounces-22468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5B917692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 05:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CD1F22F95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 03:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526142AB3;
	Wed, 26 Jun 2024 03:03:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56811CB8;
	Wed, 26 Jun 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371002; cv=none; b=RAks4FttbROe+oClZkR8w2J7/1Jm0k6l5ezbv20HxQekQHAUCCVTNdTGk2YsYyLpF776T5QzZYlTkK2GVIrYY76BMzzas2rMjlYkXUuF1O2bgq6zsFDdXZ5cedLu2htgJhrs4XK5JLMeOxUrV7H31P0PlORfXOZJJkCJdei37NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371002; c=relaxed/simple;
	bh=czBM482pH9l++pF3ssBG1WFBJnTvb536DFZk7EolOfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8u9UnZqXdG9tiKWPz6MY8ig5jXvhaHk+BWtd0kmD0iS02Z73sTnk0tr6FsYC/I1dWG/uPdF9HQjVJZyNaYcXYQ2DYaYpHreZ8XLIfyxhWjhBW9UNDzmUGbql7Df2CSldNYs4Q/uq3nIjZVx1KPnEtFlxfUz2Jof4VH2q5nfTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W862Z6wDwz4f3kvL;
	Wed, 26 Jun 2024 11:03:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1C0F41A0572;
	Wed, 26 Jun 2024 11:03:15 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAXQn7uhHtmOLVmAQ--.51004S3;
	Wed, 26 Jun 2024 11:03:14 +0800 (CST)
Message-ID: <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>
Date: Wed, 26 Jun 2024 11:03:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] cachefiles: some bugfixes for withdraw and
 xattr
To: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240522115911.2403021-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXQn7uhHtmOLVmAQ--.51004S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13WrW3AryDKrWxAF18Krg_yoW8WrW5pF
	WakF43ArykW397Grn3Jr45JF1fA3yfJF4vgw17Wr1UAwn5Xr1YvF4Iyr15ZFyUCrn7tws3
	t3WjgFy7Ww1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBV1jkHn9PQADsW

A gentle ping.

On 2024/5/22 19:59, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> Hi all!
>
> There are some fixes for some cachefiles generic processes. We found these
> issues when testing the on-demand mode, but the non-on-demand mode is also
> involved. The following is a brief overview of the patches, see the patches
> for more details.
>
> Patch 1-2: Add fscache_try_get_volume() helper function to avoid
> fscache_volume use-after-free on cache withdrawal.
>
> Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
> concurrency causing cachefiles_volume use-after-free.
>
> Patch 4-5: Propagate error codes returned by vfs_getxattr() to avoid
> endless loops.
>
> Comments and questions are, as always, welcome.
>
> Thanks,
> Baokun
>
> Baokun Li (5):
>    netfs, fscache: export fscache_put_volume() and add
>      fscache_try_get_volume()
>    cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
>    cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
>    cachefiles: correct the return value of
>      cachefiles_check_volume_xattr()
>    cachefiles: correct the return value of cachefiles_check_auxdata()
>
>   fs/cachefiles/cache.c          | 45 +++++++++++++++++++++++++++++++++-
>   fs/cachefiles/volume.c         |  1 -
>   fs/cachefiles/xattr.c          |  5 +++-
>   fs/netfs/fscache_volume.c      | 14 +++++++++++
>   fs/netfs/internal.h            |  2 --
>   include/linux/fscache-cache.h  |  6 +++++
>   include/trace/events/fscache.h |  4 +++
>   7 files changed, 72 insertions(+), 5 deletions(-)
>

-- 
With Best Regards,
Baokun Li


