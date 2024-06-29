Return-Path: <linux-fsdevel+bounces-22809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20F91CD91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64348B226A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4881AB6;
	Sat, 29 Jun 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZuffGoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C62574F;
	Sat, 29 Jun 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671012; cv=none; b=AlftRxUyRQ2LvAs8M5yloXo9cjnj0XNcJ9wQ4tkxCKHDrMFU9qNtB8f9zoogTopBFekyJl5zSdo3zfnroP8yn6HfpDKMqzoLXy9FDjIW1NZLTHoKmqNhYumcJKjotfQQxUybIZlq8ZvUoOwEYmDDGEjoNMmqco58ikA4cM63jQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671012; c=relaxed/simple;
	bh=RpJX4jnJ1foxztiWqLsT54cnw7nsRb+sOuX5F/IJV/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=PPtKP9Rd6yxOWDPQ3xUvCDd6inECOXQTeW9vLhS92i4aF9GpOZHsHYSa6fiCPyEOuObe08Kp12aygRkpv4IShjH5DUZGcfZfUBxKjOcFqIgg8T7Xi0xeksdkBNa99xRL9vqb9ac7oFZM0rMyNaeoDOkl3Ybq9Om9X3vAcS3Kdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZuffGoP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719671011; x=1751207011;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=RpJX4jnJ1foxztiWqLsT54cnw7nsRb+sOuX5F/IJV/o=;
  b=JZuffGoPj/Ln/6V2URHXffvWO+TR4YQcPHfOUoYh+cVz9bN2h3yz2CW6
   Wpg4CkbVkz8PNFm+Em1WdivqCNph9JJNdUPuuyBObH3zvobOGngdcYGu/
   rNIxIcnd3PjL/iLDQxEw3s1zCanmNeaK9BqRjxthTQAgKSe3uqIHJXzK7
   smYJmaxz/seoz6eHOy8R90FfmCsFQqrPlqfwsLuvNDFHTFvuhKgCkkskE
   Q5VMggLAAtEG5ckTjH3oxCl9j0wpp7ngdLtJcl7k9z58n3eirLQfeqXIg
   UR5oDY33hrxeJrsqPdkVmDncMOYni84Y9JV1MRdqskeZqc6r3xlkOG3x9
   Q==;
X-CSE-ConnectionGUID: dfQYYckDRQq0zlW+HHyOCQ==
X-CSE-MsgGUID: 1FJ28ZaMS4OE2iHoI9JEpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="34284176"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="34284176"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 07:23:30 -0700
X-CSE-ConnectionGUID: CP4kXIR3QRmPjN6sa6Ptww==
X-CSE-MsgGUID: zqw3upPuT1Ktkp7QIFBUXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="49498260"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 07:23:26 -0700
Message-ID: <20f6b9aa-65e0-4e05-9d41-85e4a22b51c2@intel.com>
Date: Sat, 29 Jun 2024 22:23:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: Mateusz Guzik <mjguzik@gmail.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
 <20240627-laufschuhe-hergibt-8158b7b6b206@brauner>
 <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
 <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 viro@zeniv.linux.org.uk, edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
In-Reply-To: <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/28/2024 3:59 AM, Mateusz Guzik wrote:
> On Thu, Jun 27, 2024 at 8:27 PM Ma, Yu <yu.ma@intel.com> wrote:
>> 2. For fast path implementation, the essential and simple point is to
>> directly return an available bit if there is free bit in [0-63]. I'd
>> emphasize that it does not only improve low number of open fds (even it
>> is the majority case on system as Honza agreed), but also improve the
>> cases that lots of fds open/close frequently with short task (as per the
>> algorithm, lower bits will be prioritized to allocate after being
>> recycled). Not only blogbench, a synthetic benchmark, but also the
>> realistic scenario as claimed in f3f86e33dc3d("vfs: Fix pathological
>> performance case for __alloc_fd()"), which literally introduced this
>> 2-levels bitmap searching algorithm to vfs as we see now.
> I don't understand how using next_fd instead is supposed to be inferior.
>
> Maybe I should clarify that by API contract the kernel must return the
> lowest free fd it can find. To that end it maintains the next_fd field
> as a hint to hopefully avoid some of the search work.
>
> In the stock kernel the first thing done in alloc_fd is setting it as
> a starting point:
>          fdt = files_fdtable(files);
>          fd = start;
>          if (fd < files->next_fd)
>                  fd = files->next_fd;
>
> that is all the calls which come here with 0 start their search from
> next_fd position.
>
> Suppose you implemented the patch as suggested by me and next_fd fits
> the range of 0-63. Then you get the benefit of lower level bitmap
> check just like in the patch you submitted, but without having to
> first branch on whether you happen to be in that range.
>
> Suppose next_fd is somewhere higher up, say 80. With your general
> approach the optimization wont be done whatsoever or it will be
> attempted at the 0-63 range when it is an invariant it finds no free
> fds.
>
> With what I'm suggesting the general idea of taking a peek at the
> lower level bitmap can be applied across the entire fd space. Some
> manual mucking will be needed to make sure this never pulls more than
> one cacheline, easiest way out I see would be to align next_fd to
> BITS_PER_LONG for the bitmap search purposes.

Some misunderstanding here, Guzik, I thought you felt not so worth for 
fast path in previous feedback, so the whole message sent just wanna say 
we still think the original idea is reasonable. Back to the point here, 
the way to implement it in find_next_fd() by searching the word with 
next_fd makes sense and OK to me. It's efficient, concise and should 
bring us the expected benefits. I'll re-measure the data for reference 
based on the code proposed by you and Honza.

> Outside of the scope of this patchset, but definitely worth
> considering, is an observation that this still pulls an entire
> cacheline worth of a bitmap (assuming it grew). If one could assume
> that the size is always a multiply of 64 bytes (which it is after
> first expansion) the 64 byte scan could be entirely inlined -- there
> is quite a bit of fd fields in this range we may as well scan in hopes
> of avoiding looking at the higher level bitmap, after all we already
> paid for fetching it. This would take the optimization to its logical
> conclusion.
>
> Perhaps it would be ok to special-case the lower bitmap to start with
> 64 bytes so that there would be no need to branch on it.

