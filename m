Return-Path: <linux-fsdevel+bounces-21774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E94909B7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 06:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B6C1F2143C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF3416C694;
	Sun, 16 Jun 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwXyhJra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD12632;
	Sun, 16 Jun 2024 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718510476; cv=none; b=ZlE/jv2nW4w0UN26cHLVDrJjynpSerbG3/yPgNWMRCagAiK9XtA62b0biygwq/9PNPG07QJ9pVagL9bOWkcUSpWv/d/n/4HAIst3WBWZK4/vQQ9gQrX03zkkBdMcwlMeCEx3jk0GhQ/8f8N0mslVQrJ/ndaDVcDAZlYvLHKcmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718510476; c=relaxed/simple;
	bh=LOBeSDMLvjOcAiROl79GUg1b1Ol44rfsv4ROT9gOiwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlcLLCoZObs8dg2mH8DV/RHKYiOdzzazHWuAMAjh5j2EcMK+JQDqEfous06KCfh9o3yg833BZDl2MXAuQNTPHKvlDzfV6OYX4CcPiXHZ21nX6FwzMp7y4YAZ0NZWIKTM+O61mjSRjZBjGz2hqKMn0A2cxD1/+ZmNjtI5CJIO6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwXyhJra; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718510475; x=1750046475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LOBeSDMLvjOcAiROl79GUg1b1Ol44rfsv4ROT9gOiwM=;
  b=QwXyhJra17edh9OMySGRiZ7BTqZK8Nere+NQsUKOT8LxDgUd4fzB2oPC
   mqrvl7uIMrGI/roBHTSKkoedHdpUhYAL1qS2nj6HYTacutn3vYdnMr2vC
   DI68X5fq1Uqy6sKBaDPGjReq/BMS1FSRNMrYAONWsGro1XXiXdwv+XLUV
   DPi90QaFNe1GHINqtEd6nIw0hEmzYYPzEdBUBD7KKQPOcd03baYAXuT7A
   KsPBrEhuvG5zASk3TNjzhYmYdbtIzWmbP9vAk0ycDOJdkkKOEwoFNSV4n
   0fVfHYbWfvHLFN6YQl/9XJvGW9DRS2GBDc8PA9fmlBczqgqE49T/YyR60
   w==;
X-CSE-ConnectionGUID: w+lQzJn7RJCGz6sy68s8BQ==
X-CSE-MsgGUID: lWc7TzTATCmV5nyWzRuy7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15521681"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15521681"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 21:01:14 -0700
X-CSE-ConnectionGUID: jg446RxPQhqExQiBLcU+1g==
X-CSE-MsgGUID: SUtQbsIdSLG7yt5XT8M2Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="41557169"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.232.251]) ([10.124.232.251])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 21:01:13 -0700
Message-ID: <3fa7c6c4-d9e4-4233-93a7-12e5d34ee4d0@intel.com>
Date: Sun, 16 Jun 2024 12:01:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tim.c.chen@linux.intel.com, tim.c.chen@intel.com, pan.deng@intel.com,
 tianyou.li@intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-2-yu.ma@intel.com>
 <egcrzi4bkw7lm2q4wml2y7pptpxos4nf5v3il3jmhptcurhxjj@fxtica52olsj>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <egcrzi4bkw7lm2q4wml2y7pptpxos4nf5v3il3jmhptcurhxjj@fxtica52olsj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/15/2024 2:31 PM, Mateusz Guzik wrote:
> On Fri, Jun 14, 2024 at 12:34:14PM -0400, Yu Ma wrote:
>> There is available fd in the lower 64 bits of open_fds bitmap for most cases
>> when we look for an available fd slot. Skip 2-levels searching via
>> find_next_zero_bit() for this common fast path.
>>
>> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
>> free slot is available there, as:
>> (1) The fd allocation algorithm would always allocate fd from small to large.
>> Lower bits in open_fds bitmap would be used much more frequently than higher
>> bits.
>> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
>> it would never be shrunk. The search size increases but there are few open fds
>> available here.
>> (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
>> searching.
>>
>> With the fast path added in alloc_fd() through one-time bitmap searching,
>> pts/blogbench-1.1.0 read is improved by 20% and write by 10% on Intel ICX 160
>> cores configuration with v6.8-rc6.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>> ---
>>   fs/file.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 3b683b9101d8..e8d2f9ef7fd1 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -510,8 +510,13 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>   	if (fd < files->next_fd)
>>   		fd = files->next_fd;
>>   
>> -	if (fd < fdt->max_fds)
>> +	if (fd < fdt->max_fds) {
>> +		if (~fdt->open_fds[0]) {
>> +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
>> +			goto success;
>> +		}
>>   		fd = find_next_fd(fdt, fd);
>> +	}
>>   
>>   	/*
>>   	 * N.B. For clone tasks sharing a files structure, this test
>> @@ -531,7 +536,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>   	 */
>>   	if (error)
>>   		goto repeat;
>> -
>> +success:
>>   	if (start <= files->next_fd)
>>   		files->next_fd = fd + 1;
>>   
> As indicated in my other e-mail it may be a process can reach a certain
> fd number and then lower its rlimit(NOFILE). In that case the max_fds
> field can happen to be higher and the above patch will fail to check for
> the (fd < end) case.

Thanks for the good catch, replied in that mail thread for details.

>
>> -- 
>> 2.43.0
>>

