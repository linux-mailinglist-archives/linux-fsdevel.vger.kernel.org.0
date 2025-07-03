Return-Path: <linux-fsdevel+bounces-53760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02843AF686F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 05:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAD01C46669
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421C22157E;
	Thu,  3 Jul 2025 03:02:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE017D7;
	Thu,  3 Jul 2025 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511773; cv=none; b=CPfapsgiiZjUl0waIhilzClHRgr1WQzperkjMGQCU8+rc+slA3knSjO2LVJX2ob5znaicXKfyzTk9JRIbBfWGI7WU2ZAH603u1u494ulN29YbD0roE0hueCvsO3Z958Zs+8b/lx1osgWAJfBNFbdBMJW+LyJXL29olvx2kAmp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511773; c=relaxed/simple;
	bh=k8m3AqAlVUtVHY4lTl+sebWiccKErEjIqTjotdNZIlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ip4KN6vergj7jXmUDJDMi/x7gYl2qJfLTXhqJKKT8GW19xbAwlabDXVK9tniLHBWEWc1PZFOgKZ2hGGvdhg7aPdfpaleddgNSQngKWa/RwM4eWJ5W0myb1QQka/jFYb5cv7RkNSSCX4j0gY+HJnMoZl6aM5aAOjgQ+NJ2Du7ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXhQd4h1LzKHMg4;
	Thu,  3 Jul 2025 11:02:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 13A891A06E2;
	Thu,  3 Jul 2025 11:02:48 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP3 (Coremail) with SMTP id _Ch0CgB32SbW8mVoyJbvAQ--.245S3;
	Thu, 03 Jul 2025 11:02:47 +0800 (CST)
Message-ID: <66b2f540-228f-40e9-9ac5-529e3101e973@huaweicloud.com>
Date: Thu, 3 Jul 2025 11:02:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: Fix the incorrect return value in
 __cachefiles_write()
To: Zizhi Wo <wozizhi@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com
References: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB32SbW8mVoyJbvAQ--.245S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW8Gr1xKryrGF1UuF13XFb_yoW8KF1DpF
	Waya4UKryxur48Crn7AFs5WFyrA3ykJFnFg345Ww1kZrnxXrsY9F4jqr1YqF18ArZrJr4x
	tw4j9a47Jw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/7/3 10:44, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> In __cachefiles_write(), if the return value of the write operation > 0, it
> is set to 0. This makes it impossible to distinguish scenarios where a
> partial write has occurred, and will affect the outer calling functions:
> 
>   1) cachefiles_write_complete() will call "term_func" such as
> netfs_write_subrequest_terminated(). When "ret" in __cachefiles_write()
> is used as the "transferred_or_error" of this function, it can not
> distinguish the amount of data written, makes the WARN meaningless.
> 

Sorry, I was negligent. The first error actually doesn't exist because
ret=0 was set after cachefiles_write_complete(), but the second error
still exists.

Thanks,
Zizhi Wo

>   2) cachefiles_ondemand_fd_write_iter() can only assume all writes were
> successful by default when "ret" is 0, and unconditionally return the full
> length specified by user space.
> 
> Fix it by modifying "ret" to reflect the actual number of bytes written.
> Furthermore, returning a value greater than 0 from __cachefiles_write()
> does not affect other call paths, such as cachefiles_issue_write() and
> fscache_write().
> 
> Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   fs/cachefiles/io.c       | 2 --
>   fs/cachefiles/ondemand.c | 4 +---
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index c08e4a66ac07..3e0576d9db1d 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -347,8 +347,6 @@ int __cachefiles_write(struct cachefiles_object *object,
>   	default:
>   		ki->was_async = false;
>   		cachefiles_write_complete(&ki->iocb, ret);
> -		if (ret > 0)
> -			ret = 0;
>   		break;
>   	}
>   
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index d9bc67176128..a7ed86fa98bb 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -83,10 +83,8 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
>   
>   	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
>   	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
> -	if (!ret) {
> -		ret = len;
> +	if (ret > 0)
>   		kiocb->ki_pos += ret;
> -	}
>   
>   out:
>   	fput(file);


