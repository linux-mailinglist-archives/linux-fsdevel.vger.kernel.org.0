Return-Path: <linux-fsdevel+bounces-44183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18EAA646C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C6D3A58BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7321B9E0;
	Mon, 17 Mar 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L/Z+Ii17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4311322171B;
	Mon, 17 Mar 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202815; cv=none; b=mYZb/wkQLpWHo1MhY/68KcbrOjmArkBhmqVnZ0faSrtaQHkqnKYLYUUrZDfZmzEsoIcNcTLb94L5HJ9QdXM6FQN6Mir0F+ZjfQgK2PRYjLlkgTlFc7NXkv+6dWIYgwHDpEh6siiuRye4oZ+/ogF77cazIGgYWg10VXn8bzRbJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202815; c=relaxed/simple;
	bh=xbknrIV2AOwViV4/e6I0TKuNc7TJwYEBDQJhvAxvCTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkMH2qvGYajXYhz+WpTgaOMpAGATOCKa+ZscTmwEK8n6noR2ci9ojv9GaRvZ6wW93LcPrbMJYZycX5BEfvY2SjEPai0ZFNvfet4sOLBPR6r7HiYmVqWYGNI32BUGpyCWvCG+CfOYMyhvTIqK7ugQXYbvHCOxzJVOc59ZwlXA+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L/Z+Ii17; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=xbknrIV2AOwViV4/e6I0TKuNc7TJwYEBDQJhvAxvCTg=;
	b=L/Z+Ii17lRyvbtR87Tc/zdusuPBLJktBDu2e0J04vACIbKe4uy9v/gphlTzVPk
	tc8L0jG9a8OHM0BJp+909SIxq9pCzwe0adJ/eg2TviFm/RP2yrcqn/5bwhv/phjN
	ZBH+zVv/n7AQzdKTt6ibjO4H7GlmCWROfwfqwtWzSJzIo=
Received: from [192.168.22.248] (unknown [223.70.253.31])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXw0Cl59dnbdKbRQ--.9069S2;
	Mon, 17 Mar 2025 17:13:10 +0800 (CST)
Message-ID: <2ecdf349-779f-43d5-ae3d-55d973ea50e9@163.com>
Date: Mon, 17 Mar 2025 17:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/page: Refactoring to reduce code duplication.
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ran.xiaokai@zte.com.cn, dan.carpenter@linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250317080118.95696-1-liuyerd@163.com>
 <1c7018f1-fdc5-4fc6-adc7-fae592851710@redhat.com>
Content-Language: en-US
From: Liu Ye <liuyerd@163.com>
In-Reply-To: <1c7018f1-fdc5-4fc6-adc7-fae592851710@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXw0Cl59dnbdKbRQ--.9069S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryfZF13uw4DAw45Zw17trb_yoW8Kry5pF
	45J3W3Aan5twn8Cr1xJa98Z3sxC393KF4UtrW7K34fX3WDArnxCFyYyFnYvFy8GryUAr18
	uayq9FyavF42yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBE_tUUUUU=
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiKBUTTGfXzsDMtQACsn


在 2025/3/17 16:56, David Hildenbrand 写道:
> On 17.03.25 09:01, Liu Ye wrote:
>> From: Liu Ye <liuye@kylinos.cn>
>>
>> The function kpageflags_read and kpagecgroup_read is quite similar
>> to kpagecount_read. Consider refactoring common code into a helper
>> function to reduce code duplication.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>   fs/proc/page.c | 158 ++++++++++++++++---------------------------------
>>   1 file changed, 50 insertions(+), 108 deletions(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index a55f5acefa97..f413016ebe67 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -37,19 +37,17 @@ static inline unsigned long get_max_dump_pfn(void)
>>   #endif
>>   }
>>   -/* /proc/kpagecount - an array exposing page mapcounts
>> - *
>> - * Each entry is a u64 representing the corresponding
>> - * physical page mapcount.
>> - */
>> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
>> -                 size_t count, loff_t *ppos)
>> +static ssize_t kpage_read(struct file *file, char __user *buf,
>> +        size_t count, loff_t *ppos,
>> +        u64 (*get_page_info)(struct page *))
>
> Can we just indicate using an enum which operation to perform, so we can avoid having+passing these functions?
>
Like this? Good idea, I'll send a new patch later.

enum kpage_operation {
    KPAGE_FLAGS,
    KPAGE_COUNT,
    KPAGE_CGROUP,
};

static u64 get_page_info(struct page *page, enum kpage_operation op)
{
    switch (op) {
    case KPAGE_FLAGS:
        return stable_page_flags(page);
    case KPAGE_COUNT:
        return page_count(page);
    case KPAGE_CGROUP:
        return page_cgroup_ino(page);
    default:
        return 0;
    }
}

static ssize_t kpageflags_read(struct file *file, char __user *buf,
                               size_t count, loff_t *ppos)
{
    return kpage_read(file, buf, count, ppos, KPAGE_FLAGS);
}

static ssize_t kpagecount_read(struct file *file, char __user *buf,
                               size_t count, loff_t *ppos)
{
    return kpage_read(file, buf, count, ppos, KPAGE_COUNT);
}

static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
                                size_t count, loff_t *ppos)
{
    return kpage_read(file, buf, count, ppos, KPAGE_CGROUP);
}

static ssize_t kpage_read(struct file *file, char __user *buf,
                          size_t count, loff_t *ppos,
                          enum kpage_operation op)
{
        ...
        info = get_page_info(ppage, op);
        ...
}





