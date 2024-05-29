Return-Path: <linux-fsdevel+bounces-20430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0088D356E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DEA284F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF51802C5;
	Wed, 29 May 2024 11:23:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68198169397;
	Wed, 29 May 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981815; cv=none; b=nneWOyCgCObVhVhMwVJBbKUoeSzOnBv48MIlV/rhchKk5XfsNY+54lv6w7G4RUAs7TEsPwDMD11+IGlEjyLMmqddEnkLDNhA9f62AYQCfOYucLgscIzLZAngFR7Qd7NuIw+qyd/H7o7OzhxK3MRQg9whxR6myoNLUfSKfEC5lWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981815; c=relaxed/simple;
	bh=8OnN3vT9Wvc+BNCqWNYJsEhYBD9cumr4lSyp8UNRV+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP6UBI8ifOSCd1V1QTJhc6V49OnaFIiU0Ltzlj9CahRJr4w8Vw3SbQKGA9us4K780dE/z29VSFy85bGv5VuS71nM/HyyJZdOBkFsppCSaxBxBs7y/O5nIDCHTJg1D80i1O2Wv+kcRYRSRK1u1R1N86CW6STN6EatoE00FKvHb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vq6Sl2fzmz4f3pF8;
	Wed, 29 May 2024 19:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 308861A01B9;
	Wed, 29 May 2024 19:23:30 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBEsEFdmw2YAOA--.11667S3;
	Wed, 29 May 2024 19:23:28 +0800 (CST)
Message-ID: <6f1c7f87-70ff-67e8-3157-ca044d02b459@huaweicloud.com>
Date: Wed, 29 May 2024 19:23:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for
 ondemand requests
To: Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Gao Xiang <xiang@kernel.org>, libaokun@huaweicloud.com
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240529-lehrling-verordnen-e5040aa65017@brauner>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240529-lehrling-verordnen-e5040aa65017@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHGBEsEFdmw2YAOA--.11667S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWkCw4fAryrJr4UGw1rZwb_yoW5Ar48pF
	WFkFy3Gr1kWr48G3yvkF4ruFyrX393Ar97Kw17X34DZr90qFnIvrWIvr45XFyUAr9rWw4x
	XF1UCas8Ka47ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/29 19:07, Christian Brauner wrote:
> On Wed, 22 May 2024 19:42:56 +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Hi all!
>>
>> This is the third version of this patch series. The new version has no
>> functional changes compared to the previous one, so I've kept the previous
>> Acked-by and Reviewed-by, so please let me know if you have any objections.
>>
>> [...]
> So I've taken that as a fixes series which should probably make it upstream
> rather sooner than later. Correct?
Yes, I hope this patch set could be upstream soon.
Thank you very much for applying this fixes series!

Regards,
Baokun
> ---
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [01/12] cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
>          https://git.kernel.org/vfs/vfs/c/cc5ac966f261
> [02/12] cachefiles: remove requests from xarray during flushing requests
>          https://git.kernel.org/vfs/vfs/c/0fc75c5940fa
> [03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
>          https://git.kernel.org/vfs/vfs/c/de3e26f9e5b7
> [04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
>          https://git.kernel.org/vfs/vfs/c/da4a82741606
> [05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
>          https://git.kernel.org/vfs/vfs/c/3e6d704f02aa
> [06/12] cachefiles: add consistency check for copen/cread
>          https://git.kernel.org/vfs/vfs/c/a26dc49df37e
> [07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
>          https://git.kernel.org/vfs/vfs/c/0a790040838c
> [08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
>          https://git.kernel.org/vfs/vfs/c/4988e35e95fc
> [09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
>          https://git.kernel.org/vfs/vfs/c/4b4391e77a6b
> [10/12] cachefiles: Set object to close if ondemand_id < 0 in copen
>          https://git.kernel.org/vfs/vfs/c/4f8703fb3482
> [11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
>          https://git.kernel.org/vfs/vfs/c/85e833cd7243
> [12/12] cachefiles: make on-demand read killable
>          https://git.kernel.org/vfs/vfs/c/bc9dde615546


