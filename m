Return-Path: <linux-fsdevel+bounces-23038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5192636C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47589B2221B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D217BB0C;
	Wed,  3 Jul 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiDMOi8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2717B4FC;
	Wed,  3 Jul 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016921; cv=none; b=sgrhQzpJSppr+1i83GrBOaXSNnIA61+jMrx+swDxVNtVfjzRuP70PPHXEKTeMfFtvm+sXUIVHFvTNoSasGVA7ABYAZZjuWXG32tNbBleQ/WSGHLNyeUVFTkvt4eRijmW79lpBleJdVR5c+dqn5wbDuKywfeAWbBLaGIwZTnVOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016921; c=relaxed/simple;
	bh=EvTHQMeUgp8e+eYfiigUvbbVOoVnUroziugO7WZl6tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bax5Yryt3sk030CBF/PjEU11wkEV1f+2xJ+RqroXGtCLMi98MijjTgxWRo5QZwNc0Wz2W9Piniq5IeTOO5xrspbxqNZcL17dGjQ2FYj8Uv1ob+BKIP/12QfH6QzaW6EG+9hhZ0h6MK4S9JW+nJsfFZswbe0KQ5qxGJBSXii6ukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiDMOi8U; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720016920; x=1751552920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EvTHQMeUgp8e+eYfiigUvbbVOoVnUroziugO7WZl6tk=;
  b=QiDMOi8UpMKuaZmE46c5kgbSzumdAufpttYjuz4VORQCLzS1iaRHnk53
   8TLblTFUkkYfczseOqertK8HdS316XbRWnaqw12yYhBuyWMBGYHbxxKtF
   B50BhoEaA6G+lGEOsBML2IBzQkWT+LLPb63tXsVDrbMypfGav+776S5bw
   HvQs234l0zLpQjwW41xRTr91YSJ1ErabDwBGTxh5tjcG69jPXdIbMIZeV
   /7XkWCpWgPbTiAEmtXoHtUpZR5GPgV+7o2hB4S+jVjxj7h6apu3RxUhjG
   H0NlRgwwLYDiw8DUK+lVX3lzPKnem2FM256q1g8KK5R0oqdCLftbpDmUQ
   g==;
X-CSE-ConnectionGUID: KJklrA09RD6H+3Bru+XhXA==
X-CSE-MsgGUID: 6m0v0Qd3R+mORGJsvhpPxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21059795"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="21059795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:28:40 -0700
X-CSE-ConnectionGUID: wPkJZuWzRHSjuZ83PLQ/tg==
X-CSE-MsgGUID: OVelZf1ERY+u9YRpHI6x7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="47025727"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.232.196]) ([10.124.232.196])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:28:37 -0700
Message-ID: <9c57d47b-8e77-49f6-ab31-8899d6b845b8@intel.com>
Date: Wed, 3 Jul 2024 22:28:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
 <CAGudoHEcb3g16O1daqGdViHoPEnEC7iJ-Z2B+ZC9JA9LucimDA@mail.gmail.com>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <CAGudoHEcb3g16O1daqGdViHoPEnEC7iJ-Z2B+ZC9JA9LucimDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/3/2024 10:17 PM, Mateusz Guzik wrote:
> On Wed, Jul 3, 2024 at 4:07 PM Yu Ma <yu.ma@intel.com> wrote:
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
>> As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
>> update the fast path from alloc_fd() to find_next_fd(). With which, on top of
>> patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
>> Intel ICX 160 cores configuration with v6.10-rc6.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>> ---
>>   fs/file.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index a15317db3119..f25eca311f51 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -488,6 +488,11 @@ struct files_struct init_files = {
>>
>>   static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>>   {
>> +       unsigned int bit;
>> +       bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
>> +       if (bit < BITS_PER_LONG)
>> +               return bit;
>> +
> The rest of the patchset looks good on cursory read.
>
> As for this one, the suggestion was to make it work across the entire range.
>
> Today I wont have time to write and test what we proposed, but will
> probably find some time tomorrow. Perhaps Jan will do the needful(tm)
> in the meantime.
>
> That said, please stay tuned for a patch. :)

Sure, understood, Guzik, thanks for the quick feedback and consideration 
of chances to make it better and more versatile. I'll also give a try to 
double check previous proposal on entire fds range.

>>          unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>>          unsigned int maxbit = maxfd / BITS_PER_LONG;
>>          unsigned int bitbit = start / BITS_PER_LONG;
>> --
>> 2.43.0
>>
>

