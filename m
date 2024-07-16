Return-Path: <linux-fsdevel+bounces-23753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5579326B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 14:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322401F23AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D219AA5F;
	Tue, 16 Jul 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3PDmArl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997317C233;
	Tue, 16 Jul 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133432; cv=none; b=oEgz0oOFJcRkXQtsMW4v275QSaQRlVlxvTof8nD2PRY3TmKiX2GsCx6BqFOFZ08JC/GrOVuRLZAo6lH9zPDWmHhR+8xR7F71hpIiNTOpsQkoWfbGscBzLzPvkBE3ckkFC+Hz2KGBi2L/1qid2lcoUT3EXsq/698B4FF+rsaIs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133432; c=relaxed/simple;
	bh=a3qAbusKgntIluHRD33W5ItQ8YsM9fy8EGzR2BhtmUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZsm6Pu+ehEzbqzYBVh/T1kuyVEwZXAIoKm+oLfIEhDDidHht/Lw28yRWaUeSH4LS7zY6C/22uXFF74e4JSRs8NYj/nxW/3dkQCiy5Yx2RBqLzUli/GVXAEVjejdBtTVmrUqrIwM0ymp6ojxZO+A9YE4h9noDi9eLZCLDZN3aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3PDmArl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721133431; x=1752669431;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a3qAbusKgntIluHRD33W5ItQ8YsM9fy8EGzR2BhtmUs=;
  b=F3PDmArlKpamiRBBxKsO4JqUCDHxwmLhXXgnYqxI7f5hx78KVFxOsCDg
   rrO0cIabFdqn+oeD3fdly++4H40dEjQgYlhlyrIUomKYAbH2TlSHJHwxn
   dm3zYfe4Oc5MPkaik1CuMvDKiwAB368gHz1cTD9MeO49WQVQwCHQkxhRi
   VVmrciu7Ed5xTehvy3K6RVRzYbGGA8OAh1S6uu8hNu8hLdmSSCCQH0KG6
   fc32Auow5CaVDijGQ8VMb9uF8pj2Bj6g15a/qwYrPTX7EZIai5pKVbtKz
   4HH7I3exCCdVQoJVr3MFex++2lZX2eRzsPlm9zUoEMz95AMgnAp/m+8zv
   w==;
X-CSE-ConnectionGUID: qfJpnIbYQx+NvqAS7Iwkng==
X-CSE-MsgGUID: dCefI/n4TdK5jQwdodt+UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18682244"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18682244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 05:37:10 -0700
X-CSE-ConnectionGUID: ycBl0GIkTbiJtOLvCIgjPA==
X-CSE-MsgGUID: P86ezPSVRwORv/wlLjufhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54896455"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 05:37:07 -0700
Message-ID: <398cd906-c31a-465b-9400-d8d81a3cf049@intel.com>
Date: Tue, 16 Jul 2024 20:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] fs/file.c: add fast path in find_next_fd()
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240713023917.3967269-1-yu.ma@intel.com>
 <20240713023917.3967269-4-yu.ma@intel.com>
 <20240716111908.tocqtq435d6bc3q3@quack3>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <20240716111908.tocqtq435d6bc3q3@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/16/2024 7:19 PM, Jan Kara wrote:
> On Fri 12-07-24 22:39:17, Yu Ma wrote:
>> Skip 2-levels searching via find_next_zero_bit() when there is free slot in the
>> word contains next_fd, as:
>> (1) next_fd indicates the lower bound for the first free fd.
>> (2) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
>> searching.
>> (3) After fdt is expanded (the bitmap size doubled for each time of expansion),
>> it would never be shrunk. The search size increases but there are few open fds
>> available here.
>>
>> This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agreed by
>> Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
>> versions. And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
>> 8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
> Looks good. Just some code style nits below.

Copy that, thanks Honza, I'll revise and send out updated version soon.


>
>> diff --git a/fs/file.c b/fs/file.c
>> index 1be2a5bcc7c4..a3ce6ba30c8c 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -488,9 +488,20 @@ struct files_struct init_files = {
>>   
>>   static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>>   {
>> +	unsigned int bitbit = start / BITS_PER_LONG;
>> +	unsigned int bit;
>> +
>> +	/*
>> +	 * Try to avoid looking at the second level bitmap
>> +	 */
>> +	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
>> +				 start & (BITS_PER_LONG -1));
> 							^^ Either
> (BITS_PER_LONG-1) or (BITS_PER_LONG - 1) please. Your combination looks
> particularly weird :)
>
>> +	if (bit < BITS_PER_LONG) {
>> +		return bit + bitbit * BITS_PER_LONG;
>> +	}
> No need for braces around the above block.
>
>>   	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>>   	unsigned int maxbit = maxfd / BITS_PER_LONG;
> We keep declarations at the beginning of the block. Usually it keeps the
> code more readable and the compiler should be clever enough to perform the
> loads & arithmetics only when needed.
>
> After fixing these style nits feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza

Yes, I'll polish this part of code accordingly, thanks for all the 
comments here :)


