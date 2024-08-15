Return-Path: <linux-fsdevel+bounces-26013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F619527F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEA11F22B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3433997;
	Thu, 15 Aug 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGSvRkRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A528E0F;
	Thu, 15 Aug 2024 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690189; cv=none; b=aQi4u4+o/0jwh57SIjGvL/X1RvxXDTQYXvB59u/rxkQ2cAok92UriaaAwUgH4ZhfpWwuz+XgCYXnj9plCZM45eu+ZXXwGfMl2cyqafI4BZIAuCdOP84XVD6tfpggk4+GmZ+pYDd11zzBY4szBKFXCzBPwKRcatVSLod/CPnBeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690189; c=relaxed/simple;
	bh=L8b2IGlmI+/1Z8arUmqiuhUYfrXszN0dgzodXoNXRLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJG/sPe9bDIlSCXYefXFolC0u0krXJTAtz5m0oVuKzI6w058GhCFtSbQWvkrOLEVSnu8JJs/ILeNSDzhxgNYZadJxDJamWcZjMWlCqkoC8Po6GPFEqBJQK6MR3FfwkipkSsgiPkB4loJavJNABEK/FpdznKsryj+MviYas9tHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGSvRkRy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723690187; x=1755226187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L8b2IGlmI+/1Z8arUmqiuhUYfrXszN0dgzodXoNXRLo=;
  b=MGSvRkRyFGS29qNd7XI62740JhSAesjDC++ODzSipAaTEA9c6Rhd8uNT
   pChOMKK/Gydxdhp6k26WBe1Sb6d/nePZ49qxfNiKqNovIM0/QqVAvKMZo
   7ZOlIYPVQtu5nZof98uB9w0j+riOh0EdA2KQi2+zmVX0GWhILS33b7Amo
   S4jRRzBgGwRFqLtLzfVM4gxrtrAlthrEXRCkQR7pYosKpQBxZV5WuujmN
   S0JG8aduiWTIgNVgwGd32xYmKoGIjsYzCHzuGG84mlGHIDKxIR5rP1NgH
   7eU21lEnukAW14hNpWSi+UdpKQrjBAYb5S4LSrTfeAe38CfHo9mlnLgpD
   w==;
X-CSE-ConnectionGUID: LdQ2vBbBRge75/x2qQKNdw==
X-CSE-MsgGUID: kFIrGV3OQaKDzcDUJ5OKMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="44456216"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="44456216"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:49:47 -0700
X-CSE-ConnectionGUID: 7LQ4FysTTA6NOSvS6XAhgg==
X-CSE-MsgGUID: uJMWUOfBQHeyoH8KkuyoNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59979240"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:49:44 -0700
Message-ID: <d5c8edc6-68fc-44fd-90c6-5deb7c027566@intel.com>
Date: Thu, 15 Aug 2024 10:49:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-2-yu.ma@intel.com> <20240814213835.GU13701@ZenIV>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <20240814213835.GU13701@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/15/2024 5:38 AM, Al Viro wrote:
> On Wed, Jul 17, 2024 at 10:50:16AM -0400, Yu Ma wrote:
>> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
>> allocated fd is NULL. Remove this sanity check since it can be assured by
>> exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
>> likely/unlikely and expand_file() call avoidance to reduce the work under
>> file_lock.
>> +	if (unlikely(fd >= fdt->max_fds)) {
>> +		error = expand_files(files, fd);
>> +		if (error < 0)
>> +			goto out;
>>   
>> -	/*
>> -	 * If we needed to expand the fs array we
>> -	 * might have blocked - try again.
>> -	 */
>> -	if (error)
>> -		goto repeat;
>> +		/*
>> +		 * If we needed to expand the fs array we
>> +		 * might have blocked - try again.
>> +		 */
>> +		if (error)
>> +			goto repeat;
> With that change you can't get 0 from expand_files() here, so the
> last goto should be unconditional.  The only case when expand_files()
> returns 0 is when it has found the descriptor already being covered
> by fdt; since fdt->max_fds is stabilized by ->files_lock we are
> holding here, comparison in expand_files() will give the same
> result as it just had.
>
> IOW, that goto repeat should be unconditional.  The fun part here is
> that this was the only caller that distinguished between 0 and 1...

Yes, thanks Al, fully agree with you. The if (error) could be removed 
here as the above unlikely would make sure no 0 return here. Should I 
submit another version of patch set to update it, or you may help to 
update it directly during merge? I'm not very familiar with the rules, 
please let me know if I'd update and I'll take action soon. Thanks again 
for your careful check here.


