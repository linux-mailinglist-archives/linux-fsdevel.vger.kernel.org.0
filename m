Return-Path: <linux-fsdevel+bounces-52659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578AAE59BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B563B31E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2021A435;
	Tue, 24 Jun 2025 02:20:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EB690487BF;
	Tue, 24 Jun 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731642; cv=none; b=iZPyFm+Hz0OHsk88kelR2hZiC5i4EHGh75eDTvVtL7XxHd9kcKoLwmmKfgEK93O51SU/Iv3UIGZlgog30aln4oTnQun9rR3/lnrl6KlwSoKgK2VElB6QE66hw6nLNdMVGAaK4vuxuFvEdYhpVRXYorn9fWHwCoKIzoYGGeRk4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731642; c=relaxed/simple;
	bh=zF9394emyJh88B0Ne709HIxYxnkIAYp0BQf2JAnhX2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=eJf4bI7y/kd9y56CWDaEXVpfxR5IxZRycM9beqbjbGD6ItbQLS1dq8HRJT2k/eJMSW0KRX6ep0U+SJSWRlcz5HX/BlRs1pLJUzyB+lDGbx6YYKn0wAt20K3OARmBvlNdEjy8SH1f5RqCT0koW8DFRJRN7pUgLu7cqQK+1lCdf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id DD45060108125;
	Tue, 24 Jun 2025 10:20:35 +0800 (CST)
Message-ID: <ac035aaa-f7b4-42a6-8f5c-e0a93faf5c6b@nfschina.com>
Date: Tue, 24 Jun 2025 10:20:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <33a9a2a5-a725-4ab0-865c-1d26e941e054@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/6/23 23:06, Dan Carpenter wrote:
> On Mon, Jun 23, 2025 at 06:47:05PM +0800, Su Hui wrote:
>> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
>> type from 'size_t' to 'unsigned int' for the consistency of data->size.
>> Return -ENOMEM directly rather than goto the label to simplify the code.
>> Using scoped_guard() to simplify the lock/unlock code.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/proc/vmcore.c | 33 ++++++++++++++-------------------
>>   1 file changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index 10d01eb09c43..9ac2863c68d8 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   {
>>   	struct vmcoredd_node *dump;
>>   	void *buf = NULL;
>> -	size_t data_size;
>> +	unsigned int data_size;
>>   	int ret;
> This was in reverse Christmas tree order before.  Move the data_size
> declaration up a line.
>
> 	long long_variable_name;
> 	medium variable_name;
> 	short name;
Got it,  and this 'usgined int' will be removed because of 'size_t' can
avoid overflow in some case.
>>   
>>   	if (vmcoredd_disabled) {
>> @@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   		return -EINVAL;
>>   
>>   	dump = vzalloc(sizeof(*dump));
>> -	if (!dump) {
>> -		ret = -ENOMEM;
>> -		goto out_err;
>> -	}
>> +	if (!dump)
>> +		return -ENOMEM;
>>   
>>   	/* Keep size of the buffer page aligned so that it can be mmaped */
>>   	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
>> @@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   	dump->size = data_size;
>>   
>>   	/* Add the dump to driver sysfs list and update the elfcore hdr */
>> -	mutex_lock(&vmcore_mutex);
>> -	if (vmcore_opened)
>> -		pr_warn_once("Unexpected adding of device dump\n");
>> -	if (vmcore_open) {
>> -		ret = -EBUSY;
>> -		goto unlock;
>> -	}
>> -
>> -	list_add_tail(&dump->list, &vmcoredd_list);
>> -	vmcoredd_update_size(data_size);
>> -	mutex_unlock(&vmcore_mutex);
>> -	return 0;
>> +	scoped_guard(mutex, &vmcore_mutex) {
>> +		if (vmcore_opened)
>> +			pr_warn_once("Unexpected adding of device dump\n");
>> +		if (vmcore_open) {
>> +			ret = -EBUSY;
>> +			goto out_err;
>> +		}
>>   
>> -unlock:
>> -	mutex_unlock(&vmcore_mutex);
>> +		list_add_tail(&dump->list, &vmcoredd_list);
>> +		vmcoredd_update_size(data_size);
>> +		return 0;
> Please, move this "return 0;" out of the scoped_guard().  Otherwise
> it's not obvious that we return zero on the success path.
Yes, it's better. Will update in v2 patch.
Thanks again!

Regards,
Su Hui

