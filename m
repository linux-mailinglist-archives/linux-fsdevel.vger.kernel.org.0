Return-Path: <linux-fsdevel+bounces-22414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A636916D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2711C2149A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CD16F859;
	Tue, 25 Jun 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpxxbCIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5D1CABB;
	Tue, 25 Jun 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330097; cv=none; b=o+2AQDGqRVlOjGU6HyLlEIfVSJTAfDMkEeUnejGc55xeulbAk3z8auJCj88iiaC+a9mEFxVDi7vMc3LqzDy2trZRP8JrPHgO3TxOVMkbazMx8bnGVQRJPUbhx8FNfJjZnNBF87D7+2njSpYwrEJuW6nbjWMOkktVM1PvvhW2LiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330097; c=relaxed/simple;
	bh=LiL5hKWe2xoajjxT1kgvhN8TLhkyWDzL+X2Uj2AAUzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkqxmmzcGQDyUXWMlcBojuQpWkuExufBh0w+G31m8qcgwZl5zwvwIF+daCnPrv/n7G5oVsOqioZiu9RMYgAW76GepCs1uUJN2nzlZ3lOVoU8yg/vwhcbQXq5a3yMd280ypJOhe0YADRa1RYf1fDTY6Umg35e39ca2/6y4AX2zsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpxxbCIz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719330096; x=1750866096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LiL5hKWe2xoajjxT1kgvhN8TLhkyWDzL+X2Uj2AAUzM=;
  b=UpxxbCIzjY7bXFSwYsa63TY707JDFPVrEsz5JvjRz8Szn8SVygq2Gxgn
   B/OkTRTZ0isXa6i/nRpCe+VE3O2QhWeDlMfuV5X1umHe8vWzLXOlDik0i
   tpHPALKdUJYGeDmQviJ3tG6mc22UrZj3EgURGT6IgsKts8Ven07op8MR6
   AVr0LxAiA8IF30GviHsB6XF7fQfBT8l+jQw3bT1j0ztpUf4apTz1Vz7rl
   kXyLQxs6NwXp6hdq53OSPUOZfKAaJZDAlTGJ6tV2zqoIyLM15rSQPstBD
   72teLeOF8iCjcTT4ToBNbVSGz/LuoWBoCdBUq/vSdX6D/BDdpN8yi0z7A
   A==;
X-CSE-ConnectionGUID: +iyBdgLNRFm8ENFMtcZfnw==
X-CSE-MsgGUID: fGTeIAeST9CoZ743/z4qFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20240961"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20240961"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:41:36 -0700
X-CSE-ConnectionGUID: 8pwsUsu1TMCAik3rgwzd6Q==
X-CSE-MsgGUID: AvaPvVgVRNe7ygwyRm7Hcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43507791"
Received: from wenjun3x-mobl1.ccr.corp.intel.com (HELO [10.124.232.196]) ([10.124.232.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:41:32 -0700
Message-ID: <f2f127fc-5098-4e86-b2b9-ade8b438a1e6@intel.com>
Date: Tue, 25 Jun 2024 23:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] fs/file.c: conditionally clear full_fds
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-3-yu.ma@intel.com>
 <20240625115442.kkrqy6yvy6qpct4y@quack3>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <20240625115442.kkrqy6yvy6qpct4y@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/25/2024 7:54 PM, Jan Kara wrote:
> On Sat 22-06-24 11:49:03, Yu Ma wrote:
>> 64 bits in open_fds are mapped to a common bit in full_fds_bits. It is very
>> likely that a bit in full_fds_bits has been cleared before in
>> __clear_open_fds()'s operation. Check the clear bit in full_fds_bits before
>> clearing to avoid unnecessary write and cache bouncing. See commit fc90888d07b8
>> ("vfs: conditionally clear close-on-exec flag") for a similar optimization.
>> Together with patch 1, they improves pts/blogbench-1.1.0 read for 27%, and write
>> for 14% on Intel ICX 160 cores configuration with v6.10-rc4.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
> Nice. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza

Copy that, thanks Honza :)


>> ---
>>   fs/file.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 50e900a47107..b4d25f6d4c19 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -268,7 +268,9 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
>>   static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
>>   {
>>   	__clear_bit(fd, fdt->open_fds);
>> -	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
>> +	fd /= BITS_PER_LONG;
>> +	if (test_bit(fd, fdt->full_fds_bits))
>> +	    __clear_bit(fd, fdt->full_fds_bits);
>>   }
>>   
>>   static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
>> -- 
>> 2.43.0
>>

