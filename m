Return-Path: <linux-fsdevel+bounces-22469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8A917696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 05:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584431C21119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F7175BE;
	Wed, 26 Jun 2024 03:04:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE31758D;
	Wed, 26 Jun 2024 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371081; cv=none; b=MPa72UWLPYU3wv053N5jCEghfyiQaErsMwG614jvWQ1cPq59P0Sf8XNVOxRE85pLWhu5DlstwMifbJhAp4qZ/gcLkPUmZsPuxAuCPMrg6yIeB0jPwKe8UzmbkSX/NmF517IJ/3A1ehPSekFVeA7RDNI1NHSaUjeyLzigs+qB9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371081; c=relaxed/simple;
	bh=uOsXLYT9YtQy7XEYasw7NhSEItptuk93aPBkVEsCnss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJAw3Pmf12oiHaP9og7WPpj7xSYYeHDOHhiPIqZ3bllBO1TKF9PNixsjHsRzjn9uDdTpZ57iyZtVuSAnDA1+h84Ra3JoleyuUTJmJMKN5NgmyoODjJT+wg9urrYC1Zn3qeZWwHM77bCBs6IIWn2xumGZ2mvC1Ce6VMtUz/yVes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W864B5jgxz4f3jMJ;
	Wed, 26 Jun 2024 11:04:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DC2AD1A0189;
	Wed, 26 Jun 2024 11:04:33 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAnUn4+hXtmg8pmAQ--.51587S3;
	Wed, 26 Jun 2024 11:04:31 +0800 (CST)
Message-ID: <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
Date: Wed, 26 Jun 2024 11:04:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240515125136.3714580-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnUn4+hXtmg8pmAQ--.51587S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4UCF43uFWfurW8JrW8JFb_yoW5Wr1UpF
	Wak3W3GrykWryIkan3Z3WxtFyFy3yfX3W3Gr4xX345A3s8XF1FyrWIgr1jqFyDCrZ7Gr4a
	vr4q9Fna9ryjv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAGBV1jkH8nxAABsx

A gentle ping.

On 2024/5/15 20:51, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> Hi all!
>
> This is the second version of this patch series. Thank you, Jia Zhu and
> Gao Xiang, for the feedback in the previous version.
>
> We've been testing ondemand mode for cachefiles since January, and we're
> almost done. We hit a lot of issues during the testing period, and this
> patch set fixes some of the issues related to reopen worker/send req/poll.
> The patches have passed internal testing without regression.
>
> Patch 1-3: A read request waiting for reopen could be closed maliciously
> before the reopen worker is executing or waiting to be scheduled. So
> ondemand_object_worker() may be called after the info and object and even
> the cache have been freed and trigger use-after-free. So use
> cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
> reopen worker or wait for it to finish. Since it makes no sense to wait
> for the daemon to complete the reopen request, to avoid this pointless
> operation blocking cancel_work_sync(), Patch 1 avoids request generation
> by the DROPPING state when the request has not been sent, and Patch 2
> flushes the requests of the current object before cancel_work_sync().
>
> Patch 4: Cyclic allocation of msg_id to avoid msg_id reuse misleading
> the daemon to cause hung.
>
> Patch 5: Hold xas_lock during polling to avoid dereferencing reqs causing
> use-after-free. This issue was triggered frequently in our tests, and we
> found that anolis 5.10 had fixed it, so to avoid failing the test, this
> patch was pushed upstream as well.
>
> Comments and questions are, as always, welcome.
> Please let me know what you think.
>
> Thanks,
> Baokun
>
> Changes since v1:
>    * Collect RVB from Jia Zhu and Gao Xiang.(Thanks for your review!)
>    * Pathch 1,2：Add more commit messages.
>    * Pathch 3：Add Fixes tag as suggested by Jia Zhu.
>    * Pathch 4：No longer changing "do...while" to "retry" to focus changes
>      and optimise commit messages.
>    * Pathch 5: Drop the internal RVB tag.
>
> [V1]: https://lore.kernel.org/all/20240424033409.2735257-1-libaokun@huaweicloud.com
>
> Baokun Li (3):
>    cachefiles: stop sending new request when dropping object
>    cachefiles: flush all requests for the object that is being dropped
>    cachefiles: cyclic allocation of msg_id to avoid reuse
>
> Hou Tao (1):
>    cachefiles: flush ondemand_object_worker during clean object
>
> Jingbo Xu (1):
>    cachefiles: add missing lock protection when polling
>
>   fs/cachefiles/daemon.c   |  4 ++--
>   fs/cachefiles/internal.h |  3 +++
>   fs/cachefiles/ondemand.c | 52 +++++++++++++++++++++++++++++++++++-----
>   3 files changed, 51 insertions(+), 8 deletions(-)
>

-- 
With Best Regards,
Baokun Li


