Return-Path: <linux-fsdevel+bounces-19778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AB8C9C04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D8A282FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87A5339E;
	Mon, 20 May 2024 11:14:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409705337E;
	Mon, 20 May 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203667; cv=none; b=phclC8ZtJzRX0RQmpOO2jQ0Owji1O2Ee4WHECp7NUV7lRva0UBXFYRHha0VP257inJBerBmBLTxTCMs4y527llH4rvFaQJx7vjiXKYYQF7bdoQ/3eg2fLRO01cSMGnlSv1bX5ciUid6OjwJxLHM5KsMRzdtTipUmTj4LJVSE9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203667; c=relaxed/simple;
	bh=w6EWHG/7umfYX85hJzKNaeqWOnb01B251xQqu8FXNag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=citahhZn34nyjGqbrXXI9xAoEVs0G4/CHJFwF+3LrM48ir4q3pz1A76rXpMlXakUia9WRjy384dO8+QbkJqMG7PoWrSRMyIchy2QYXCNmk6joVZkSgb5w3awXlcM4ti++oXbc2JeHrqhHxzEfFrsB9SfFCrZcsfAiVDjMiNUplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjZhL0Jmlz4f3mJD;
	Mon, 20 May 2024 19:14:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6CF731A016E;
	Mon, 20 May 2024 19:14:20 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6IMEtmiAG7NA--.5841S3;
	Mon, 20 May 2024 19:14:20 +0800 (CST)
Message-ID: <5b1b2719-2123-9218-97b4-ccda8b5cb3b4@huaweicloud.com>
Date: Mon, 20 May 2024 19:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 libaokun@huaweicloud.com
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
 <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
 <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
 <a3ca2292-0218-45f6-8afe-4319a10b69e2@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <a3ca2292-0218-45f6-8afe-4319a10b69e2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6IMEtmiAG7NA--.5841S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7Wr1ktw4rCryUZrW5Wrg_yoW8XFyDpF
	WxWa4rKF1vqFW0vr9Fvr9xXryjyay7J3WUXrs7Kw1UJr98Zr15Cr4xJr4jgas8A39ava1I
	yF12q3srZa4UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/20 17:24, Jingbo Xu wrote:
>
> On 5/20/24 5:07 PM, Baokun Li wrote:
>> On 2024/5/20 16:43, Jingbo Xu wrote:
>>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
SNIP
>>>>
>>>> To avoid this, allocate a new anonymous fd only if no anonymous fd has
>>>> been allocated (ondemand_id == 0) or if the previously allocated
>>>> anonymous
>>>> fd has been closed (ondemand_id == -1). Moreover, returns an error if
>>>> ondemand_id is valid, letting the daemon know that the current userland
>>>> restore logic is abnormal and needs to be checked.
>>>>
>>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
>>>> up cookie")
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> The LOCs of this fix is quite under control.  But still it seems that
>>> the worst consequence is that the (potential) malicious daemon gets
>>> hung.  No more effect to the system or other processes.  Or does a
>>> non-malicious daemon have any chance having the same issue?
>> If we enable hung_task_panic, it may cause panic to crash the server.
> Then this issue has nothing to do with this patch?  As long as a
> malicious daemon doesn't close the anonymous fd after umounting, then I
> guess a following attempt of mounting cookie with the same name will
> also wait and hung there?
>
Yes, a daemon that only reads requests but doesn't process them will
cause hung，but the daemon will obey the basic constraints when we
test it.

-- 
With Best Regards,
Baokun Li


