Return-Path: <linux-fsdevel+bounces-21773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95128909B6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 05:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0B82822D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 03:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9B49657;
	Sun, 16 Jun 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQo6Fyvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C73A20;
	Sun, 16 Jun 2024 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718509667; cv=none; b=oqqPfrv60+8ko2JM8x3Fv+XbQYqGb0m1JEraVtrXSDFF74QAqXopg3Pl5lhnbIeqwTNWF708H17KlPTObAYO3CXys8EAXc6M65SxQrU/RaSlURHoxAiQrm7YsiX8zz4AvHM5KAGn4DXrJeNJ6bdmQR7uPI+KRddyRDCYCvBqheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718509667; c=relaxed/simple;
	bh=xtp4Gs5IDSmT3zH0M+U3sMn0gDatcq8ADESTWYEKAmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=rqVGofDAN4C1h7KRxqIxLHwGebzhItlv3MKyx9YEds8UVthqQMH2P+QrhWWUh1oV0lwp+Qh2HBV42xQJHC7aI51sr5e0CmHd0spHOTPJDGgMZJNy/oLQZn82rsVqsFmH/jcpRkBkaqUSH/09fMwSHjGn0AXPP1SJU7DtpxrhhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQo6Fyvq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718509666; x=1750045666;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=xtp4Gs5IDSmT3zH0M+U3sMn0gDatcq8ADESTWYEKAmY=;
  b=OQo6FyvqWIWQW4IOkaLsz+Zdn8kk6eE5DVpnQg5X1zIv1QAMxmvcfxUj
   /+f+koxR5mgaTeecl0kBv3qLHp5x6sdyN58zljfu79Cu3/OXF6yLqj8u+
   fl/J7FBDmiXxrqJlYaWDC6/DHjOtLdZenhZv4WN591xwWTg1qc8D/nyYS
   7EsK+iX1jEbGSzK2TXTz8dhMIL4ZIq5ISaksKTTkjEd+owauwDQb+CalY
   01WMgKUORsAyCEi4h86R3/mVsDhdgYGOV3m22FzuOBj3QVsYmfln7Q/1b
   5F/oI4yxEyIPkXCMouaruHfe5dRsMINZz5faC1ooO9XDmnjSmJY3yyiVI
   w==;
X-CSE-ConnectionGUID: UjDAxiHHT5+nJhcoIvS3NQ==
X-CSE-MsgGUID: e41aFWGrQ6WtdORwZpRcUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="19193104"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="19193104"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 20:47:45 -0700
X-CSE-ConnectionGUID: y0d1gb/7RjWBRdKavdjBAQ==
X-CSE-MsgGUID: dJHAnFYNQ0+QcxqCCs9VeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="45992625"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.232.251]) ([10.124.232.251])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 20:47:42 -0700
Message-ID: <e316cbe9-0e66-414f-8948-ba3b56187a98@intel.com>
Date: Sun, 16 Jun 2024 11:47:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
To: Mateusz Guzik <mjguzik@gmail.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tim.c.chen@linux.intel.com, tim.c.chen@intel.com, pan.deng@intel.com,
 tianyou.li@intel.com, yu.ma@intel.com
In-Reply-To: <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/15/2024 12:41 PM, Mateusz Guzik wrote:
> On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
>> alloc_fd() has a sanity check inside to make sure the FILE object mapping to the
> Total nitpick: FILE is the libc thing, I would refer to it as 'struct
> file'. See below for the actual point.

Good point, not nitpick at all ;) , will update the word in commit message.

>> Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
>> 32%, write improved by 15% on Intel ICX 160 cores configuration with v6.8-rc6.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>> ---
>>   fs/file.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index a0e94a178c0b..59d62909e2e3 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
> I was going to ask when was the last time anyone seen this fire and
> suggest getting rid of it if enough time(tm) passed. Turns out it does
> show up sometimes, latest result I found is 2017 vintage:
> https://groups.google.com/g/syzkaller-bugs/c/jfQ7upCDf9s/m/RQjhDrZ7AQAJ
>
> So you are moving this to another locked area, but one which does not
> execute in the benchmark?

The consideration here as mentioned is to reduce the performance impact 
(if to reserve the sanity check, and have the same functionality) by 
moving it from critical path to non-critical, as put_unused_fd() is 
mostly used for error handling when fd is allocated successfully but 
struct file failed to obtained in the next step.

>
> Patch 2/3 states 28% read and 14% write increase, this commit message
> claims it goes up to 32% and 15% respectively -- pretty big. I presume
> this has to do with bouncing a line containing the fd.
>
> I would argue moving this check elsewhere is about as good as removing
> it altogether, but that's for the vfs overlords to decide
>
> All that aside, looking at disasm of alloc_fd it is pretty clear there
> is time to save, for example:
>
> 	if (unlikely(nr >= fdt->max_fds)) {
> 		if (fd >= end) {
> 			error = -EMFILE;
> 			goto out;
> 		}
> 		error = expand_files(fd, fd);
> 		if (error < 0)
> 			goto out;
> 		if (error)
> 			goto repeat;
> 	}
>
> This elides 2 branches and a func call in the common case. Completely
> untested, maybe has some brainfarts, feel free to take without credit
> and further massage the routine.
>
> Moreover my disasm shows that even looking for a bit results in
> a func call(!) to _find_next_zero_bit -- someone(tm) should probably
> massage it into another inline.
>
> After the above massaging is done and if it turns out the check has to
> stay, you can plausibly damage-control it with prefetch -- issue it
> immediately after finding the fd number, before any other work.
>
> All that said, by the above I'm confident there is still *some*
> performance left on the table despite the lock.

Thank you Guzik for such quick check and good suggestions :) Yes, there 
are extra branches and func call can be reduced for better performance, 
considering the fix for fast path, how about flow as below draft 
(besides the massage to find_next_fd()):

         error = -EMFILE;
         if (fd < fdt->max_fds) {
                 if (~fdt->open_fds[0]) {
                         fd = find_next_zero_bit(fdt->open_fds, 
BITS_PER_LONG, fd);
                         goto fastreturn;
                 }
                 fd = find_next_fd(fdt, fd);
         }

         if (unlikely(fd >= fdt->max_fds)) {
                 error = expand_files(files, fd);
                 if (error < 0)
                         goto out;
                 if (error)
                         goto repeat;
         }
fastreturn:
         if (unlikely(fd >= end))
                 goto out;
         if (start <= files->next_fd)
                 files->next_fd = fd + 1;

        ....

>>   out:
>>   	spin_unlock(&files->file_lock);
>> @@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
>>   }
>>   EXPORT_SYMBOL(get_unused_fd_flags);
>>   
>> -static void __put_unused_fd(struct files_struct *files, unsigned int fd)
>> +static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
>>   {
>>   	struct fdtable *fdt = files_fdtable(files);
>>   	__clear_open_fd(fd, fdt);
>> @@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struct *files, unsigned int fd)
>>   void put_unused_fd(unsigned int fd)
>>   {
>>   	struct files_struct *files = current->files;
>> +	struct fdtable *fdt = files_fdtable(files);
>>   	spin_lock(&files->file_lock);
>> +	if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
>> +		printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n", fd);
>> +		rcu_assign_pointer(fdt->fd[fd], NULL);
>> +	}
>>   	__put_unused_fd(files, fd);
>>   	spin_unlock(&files->file_lock);
>>   }

