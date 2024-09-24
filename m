Return-Path: <linux-fsdevel+bounces-29971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55298443E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 13:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6120B1F22994
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6751A4F1B;
	Tue, 24 Sep 2024 11:10:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE91A4E95;
	Tue, 24 Sep 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176205; cv=none; b=jg4ExqxQflxFfVl8ihhJGpqiZD8WSrFW2YcRfmSbg+nMqwxg/kLX7QWhf2hJXMhv/0hIWwQDw151s6oiTDmAzaeaGqFX3Y8JHh5N5JAE47PRg96+AYuYl4zDwfZjpt/aD7zTu/mM+v4pnV1p3IN4Cvn3/U6137ontiHosLZGNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176205; c=relaxed/simple;
	bh=cpI6pGHmRebpNzkmkIEeAjGeKKQx/iNqWGbZ1h3E+KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+vrZ7kJdzFCpObqt+FVwj/3xnK8jlJx7WK24AjctImtCk7S6ttW16jvxoP6osWS8V3uMr94NhRuG39Ppgczmn7KHnH7cdgD+I45lCiLpMmIESLpiJ/8olT0s3yBUzFBVzOplNxD/1EoPqnz7i+tBKcagubKCVh+ONbE4tA+3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XCcZV3vPPz4f3lCv;
	Tue, 24 Sep 2024 19:09:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6C5AC1A0359;
	Tue, 24 Sep 2024 19:09:55 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8QBnvJm3RbeCA--.62308S3;
	Tue, 24 Sep 2024 19:09:55 +0800 (CST)
Message-ID: <d92d106b-3a85-4ca1-85da-7078ba63f95b@huaweicloud.com>
Date: Tue, 24 Sep 2024 19:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] ext4: drop ext4_update_disksize_before_punch()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-4-yi.zhang@huaweicloud.com>
 <20240920161351.ax3oidpt6w6bf3o4@quack3>
 <5de46c69-74f4-4955-a825-8c8970c0aa09@huaweicloud.com>
 <20240924101119.xzejk3a2rjmgqed7@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240924101119.xzejk3a2rjmgqed7@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHR8QBnvJm3RbeCA--.62308S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKFyfJr43JFykGF4ftF45GFg_yoW8Jry3pF
	WfKay8tF48K3y8Cr1Iq3WIvr18tw4Iyr48XryxXr17XrZY9Fy3Kr4IqryUKF95uw1vkr45
	X3Wjga97Z3yjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/24 18:11, Jan Kara wrote:
> On Tue 24-09-24 15:43:22, Zhang Yi wrote:
>> On 2024/9/21 0:13, Jan Kara wrote:
>>> On Wed 04-09-24 14:29:18, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Since we always write back dirty data before zeroing range and punching
>>>> hole, the delalloc extended file's disksize of should be updated
>>>> properly when writing back pages, hence we don't need to update file's
>>>> disksize before discarding page cache in ext4_zero_range() and
>>>> ext4_punch_hole(), just drop ext4_update_disksize_before_punch().
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> So when we don't write out before hole punching & company this needs to stay
>>> in some shape or form. 
>>>
>>
>> Thanks for taking time to review this series!
>>
>> I don't fully understand this comment, please let me confirm. Do you
>> suggested that we still don't write out all the data before punching /
>> zeroing / collapseing(i.e. drop patch 01), so we need to keep
>> ext4_update_disksize_before_punch()(i.e. also drop this patch), is
>> that right?
> 
> Yes, this is what I meant. Sorry for not being clear.
> 
> 								Honza
> 

OK, this looks fine to me. Let me revise this series.

Thanks,
Yi.


