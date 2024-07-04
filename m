Return-Path: <linux-fsdevel+bounces-23137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBD927917
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B375B23EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A111B0100;
	Thu,  4 Jul 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWAQ8mEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524615491;
	Thu,  4 Jul 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104339; cv=none; b=d6azgT4c+cm7EL6MixoqoWhkP/kbLuuvb3U15WS+C50FYzeYfSrBs6fLuVsd1BLrPM9CV6XVQqx2pX3sgv5N9DEpCDLSG4hpnucPL585VIZHxXVH4IgBGG7m2wEiUyGafsV8oMsglFXnBRIsDQVUItUnBbagz+EdMFN8hPb6Oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104339; c=relaxed/simple;
	bh=IgMzbmEA/bk+LqRjGxJA13KtdyCS5f9kczciDYp3QvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMA7clTGtaVCgxzsTUtVJIziemkM6hhSGAhMrtUndo9xFArB75IdTp9dRXCTcDSZDeHFveP/ij1eEPFpO5I0s/hU01y8G8MWCobeB52fBP+ZVfcVEVI3qeJE5HmSbzQ1cpyZ7fNVwGFKYqFmJS6tOkZA2hwjoTdaEuB1Y/ckyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWAQ8mEB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720104338; x=1751640338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IgMzbmEA/bk+LqRjGxJA13KtdyCS5f9kczciDYp3QvQ=;
  b=bWAQ8mEB9ibACH1uChASaOHDin0m3AMMLuGbZuZ8m+F7QQuRi/Ut0Jhz
   wqieDvUbuvKmWbH6wzfxZHM/UP572RmX/Z3SdMBIY167LYe40Ep03sgIF
   4gCCUDxL5BK7/i0/bS0jc7EV9Tf4EhU6QgirtwHHQD3+X6iG5Py2GkqUo
   hZZVElcq3pf6Fh9pSXHgRPWy3TT06BSwWAmZWaSF2srM24vLHFkgdPdDN
   VitJEIoRku7YV7m2h8FLWalIY/HC3cSFPL1K4cjaEKsVRCXTqsTgs0IJw
   rpvxS02GKvP2oO70RaqNMi20Iiq+sEO/AhF8jjqDAJZNr3V8+ENg7Fg51
   g==;
X-CSE-ConnectionGUID: ziNUlGRgTFeb3ZE8uZUe4A==
X-CSE-MsgGUID: jF1LVh32RzOTJ8WbRVaDyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28059583"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28059583"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:45:37 -0700
X-CSE-ConnectionGUID: nzJLzc7zSxiCui9sixtncA==
X-CSE-MsgGUID: KCMyKMjLTq2/WFUKszPBpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46391413"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:45:35 -0700
Message-ID: <8fd90ebb-5d47-4630-a972-386a9caed976@intel.com>
Date: Thu, 4 Jul 2024 22:45:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, mjguzik@gmail.com, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-2-yu.ma@intel.com>
 <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
 <20240704101104.btkwwnhwf3mnfsvj@quack3>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <20240704101104.btkwwnhwf3mnfsvj@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/4/2024 6:11 PM, Jan Kara wrote:
> On Wed 03-07-24 16:34:49, Christian Brauner wrote:
>> On Wed, Jul 03, 2024 at 10:33:09AM GMT, Yu Ma wrote:
>>> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
>>> allocated fd is NULL. Remove this sanity check since it can be assured by
>>> exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
>>> likely/unlikely and expand_file() call avoidance to reduce the work under
>>> file_lock.
>>>
>>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>>> ---
>>>   fs/file.c | 38 ++++++++++++++++----------------------
>>>   1 file changed, 16 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/fs/file.c b/fs/file.c
>>> index a3b72aa64f11..5178b246e54b 100644
>>> --- a/fs/file.c
>>> +++ b/fs/file.c
>>> @@ -515,28 +515,29 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>>   	if (fd < files->next_fd)
>>>   		fd = files->next_fd;
>>>   
>>> -	if (fd < fdt->max_fds)
>>> +	if (likely(fd < fdt->max_fds))
>>>   		fd = find_next_fd(fdt, fd);
>>>   
>>> +	error = -EMFILE;
>>> +	if (unlikely(fd >= fdt->max_fds)) {
>>> +		error = expand_files(files, fd);
>>> +		if (error < 0)
>>> +			goto out;
>>> +		/*
>>> +		 * If we needed to expand the fs array we
>>> +		 * might have blocked - try again.
>>> +		 */
>>> +		if (error)
>>> +			goto repeat;
>>> +	}
>> So this ends up removing the expand_files() above the fd >= end check
>> which means that you can end up expanding the files_struct even though
>> the request fd is past the provided end. That seems odd. What's the
>> reason for that reordering?
> Yeah, not only that but also:
>
>>>   	/*
>>>   	 * N.B. For clone tasks sharing a files structure, this test
>>>   	 * will limit the total number of files that can be opened.
>>>   	 */
>>> -	error = -EMFILE;
>>> -	if (fd >= end)
>>> -		goto out;
>>> -
>>> -	error = expand_files(files, fd);
>>> -	if (error < 0)
>>> +	if (unlikely(fd >= end))
>>>   		goto out;
> We could then exit here with error set to 0 instead of -EMFILE. So this
> needs a bit of work. But otherwise the patch looks good to me.
>
> 								Honza

Do you mean that we return 0 here is fd >=end, I'm afraid that might 
broke the original design of this function. And all the callers of it 
are using ret < 0 for error handling, if ret=0, that should mean the fd 
allocated is 0 ...


