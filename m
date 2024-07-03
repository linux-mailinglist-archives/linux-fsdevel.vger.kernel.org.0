Return-Path: <linux-fsdevel+bounces-23044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760F9263C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC9B2A6DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890917DA15;
	Wed,  3 Jul 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKMeDFqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16505173328;
	Wed,  3 Jul 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018006; cv=none; b=lBg17YisEW0yycDp7qzZkYOM6+cG3xKIMyXARzzm7PFK17n6JXYod3q7Z12PYr+Hpib10L69RJvNNbz+4yD9efhrf5WeTkqk2nG6Ysj1y86tAwFMuoIo/x2ecLXZK1v0DUQBaZMvztOvSMsLblBXA3Uj/1L5L9UAoCm77lLH3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018006; c=relaxed/simple;
	bh=CH5oOKlw9c3vTvHIEHykaqkv2UUYIeenW68f8BPCnms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8LCM/Im65ks+Ux/RuRxnTsdRgVvA5eAGzYBcSTVR7Jvsamodu2MMNJ5IO8i/SWdXM0ehVSZO1BYqG8xzsFG8jb+aJlm+BND7Q/Xnn3RxS+yTkaXgCEbTPxTgCpSgx/QV2pEuQ0lx00G6BoBSSXxBPKYW4jHp6rS6pQRLJwT7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKMeDFqh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720018004; x=1751554004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CH5oOKlw9c3vTvHIEHykaqkv2UUYIeenW68f8BPCnms=;
  b=kKMeDFqhZa+5BqjsTm44iqY7uRYJaSMRWh6mKZiX9jogBYnj6bZZjHiA
   oHqBto9rQ58RairDWruA2lVjIkNN64Q/LqqkbvMJOH8oWnZCiJPAP7xse
   b+54+tCzoRE/Y914PUSd4ZzlnB+axvIjcyiA2frDbtGS8oWaFfNLyfTUU
   kbnKWP8XO7H2MDaWWiAe1JBPjCeLXYYEeWDOkDQfRWV3Dr+bQY8dyU+dZ
   DbQ9yilf/6CX63FSXRKULJY4U3RIMN48KSBZGZGAz8+lyWzsqmy9MIh3V
   GT34cIIYl4P2+TMqUjc3nwiqq8SC5Z7DWNJ/PBlPrd+0ZGC7Szb2KIjcF
   g==;
X-CSE-ConnectionGUID: F3fmfeTWQnKj/bgwVEK/5Q==
X-CSE-MsgGUID: PDvDYinATRmGYufzhwwmkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21062825"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="21062825"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:46:44 -0700
X-CSE-ConnectionGUID: s+pa840NR8+fyklk+rc93w==
X-CSE-MsgGUID: xDtuv+aTTbulHa1hrxNDzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="47034391"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.232.196]) ([10.124.232.196])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:46:41 -0700
Message-ID: <5ece40f0-0d28-4d7f-b028-91825cb05ed7@intel.com>
Date: Wed, 3 Jul 2024 22:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, mjguzik@gmail.com,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-2-yu.ma@intel.com>
 <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/3/2024 10:34 PM, Christian Brauner wrote:
> On Wed, Jul 03, 2024 at 10:33:09AM GMT, Yu Ma wrote:
>> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
>> allocated fd is NULL. Remove this sanity check since it can be assured by
>> exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
>> likely/unlikely and expand_file() call avoidance to reduce the work under
>> file_lock.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>> ---
>>   fs/file.c | 38 ++++++++++++++++----------------------
>>   1 file changed, 16 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index a3b72aa64f11..5178b246e54b 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -515,28 +515,29 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>   	if (fd < files->next_fd)
>>   		fd = files->next_fd;
>>   
>> -	if (fd < fdt->max_fds)
>> +	if (likely(fd < fdt->max_fds))
>>   		fd = find_next_fd(fdt, fd);
>>   
>> +	error = -EMFILE;
>> +	if (unlikely(fd >= fdt->max_fds)) {
>> +		error = expand_files(files, fd);
>> +		if (error < 0)
>> +			goto out;
>> +		/*
>> +		 * If we needed to expand the fs array we
>> +		 * might have blocked - try again.
>> +		 */
>> +		if (error)
>> +			goto repeat;
>> +	}
> So this ends up removing the expand_files() above the fd >= end check
> which means that you can end up expanding the files_struct even though
> the request fd is past the provided end. That seems odd. What's the
> reason for that reordering?

Yes, you are right, thanks Christian. This incorrect reordering here is 
due to historical versions with fast path inside. I'll update the order 
back.

>> +
>>   	/*
>>   	 * N.B. For clone tasks sharing a files structure, this test
>>   	 * will limit the total number of files that can be opened.
>>   	 */
>> -	error = -EMFILE;
>> -	if (fd >= end)
>> -		goto out;
>> -
>> -	error = expand_files(files, fd);
>> -	if (error < 0)
>> +	if (unlikely(fd >= end))
>>   		goto out;
>>   
>> -	/*
>> -	 * If we needed to expand the fs array we
>> -	 * might have blocked - try again.
>> -	 */
>> -	if (error)
>> -		goto repeat;
>> -
>>   	if (start <= files->next_fd)
>>   		files->next_fd = fd + 1;
>>   
>> @@ -546,13 +547,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>   	else
>>   		__clear_close_on_exec(fd, fdt);
>>   	error = fd;
>> -#if 1
>> -	/* Sanity check */
>> -	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
>> -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
>> -		rcu_assign_pointer(fdt->fd[fd], NULL);
>> -	}
>> -#endif
>>   
>>   out:
>>   	spin_unlock(&files->file_lock);
>> @@ -618,7 +612,7 @@ void fd_install(unsigned int fd, struct file *file)
>>   		rcu_read_unlock_sched();
>>   		spin_lock(&files->file_lock);
>>   		fdt = files_fdtable(files);
>> -		BUG_ON(fdt->fd[fd] != NULL);
>> +		WARN_ON(fdt->fd[fd] != NULL);
>>   		rcu_assign_pointer(fdt->fd[fd], file);
>>   		spin_unlock(&files->file_lock);
>>   		return;
>> -- 
>> 2.43.0
>>

