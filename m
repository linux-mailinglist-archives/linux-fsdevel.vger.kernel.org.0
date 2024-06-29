Return-Path: <linux-fsdevel+bounces-22811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E28E91CDF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F377D282FCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAF12D758;
	Sat, 29 Jun 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9JzKeJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677B85624;
	Sat, 29 Jun 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675715; cv=none; b=ijMWWFTxea03QCEUCksMDYuqqf0p2szM34ueohZcfs2o/J2/0j8eCiVlrggl2s80veCXHPGQaL1tktQ76z4pXnxgVWZQ3EaynkSculd87ZrJBJeEDs3bkaEgU8uw8IYNkmE8owc+yI44Pl3HokhQ9skvPLQG5c2EApCKqjj9Pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675715; c=relaxed/simple;
	bh=/noymO8z7K1LMf0xkZ1uydxGcvHdG2zjp03nVsLShS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bgEcD4J0YCA94m0K8U0Gt7OhUFVHJPHFlZymFwO4PRhJQVyo8deTpM1XK5l6SJ58tkeEbw2sTr9BPa/AZd+D1KGGwzXgKr+Qe/KL83Jf/cYK4dFaDqj+dbMc8jdnGgv4sRSs5T2IYae5rGelsqwxsRYVteJNf/978qE3Y90uEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9JzKeJW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719675713; x=1751211713;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=/noymO8z7K1LMf0xkZ1uydxGcvHdG2zjp03nVsLShS0=;
  b=k9JzKeJWOzd7LzUs7sWawIt2lZJXTfRlmf3ryzbO1c6896POlqL16E/W
   SKTYpE+zLnihh3xts5TBVdPBZuUJXlE/NdhWwgV0oru/IwdR/wlWXUS1o
   4laZgBxKVTQBcY8hQf7BDe88iroQ6YzYj2yZbL9+i4BiGVf9+/SfsZ764
   nKVVNBUB8Kpfw0YwDVOsjAjmcFEo0qde+7deakrt5THU5ruB57Sv+Nlli
   JXXMPw6sWO3YZeyns0iqxI/kjaXyYGx3J/o8pTEzPxQweVX2i6kqRqO4b
   jXfwWKKCTPjuD1neAv2W8UbfgXrwRQhFcqc8DFtQgWLqagPH8vz8rF9Rc
   w==;
X-CSE-ConnectionGUID: inewjkyaTmSCXejyiePtcQ==
X-CSE-MsgGUID: OyUYDzNvR9+4z7vwJTBgMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16722557"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="16722557"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 08:41:53 -0700
X-CSE-ConnectionGUID: HGt9jzm1Tue4vX6M2mgZnQ==
X-CSE-MsgGUID: ZqAnO9QnSKCTHEEEWhcr1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45712734"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 08:41:49 -0700
Message-ID: <7482d788-3431-4d74-b16c-030160792a9e@intel.com>
Date: Sat, 29 Jun 2024 23:41:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>
References: <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
 <20240627-laufschuhe-hergibt-8158b7b6b206@brauner>
 <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
 <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
 <20240628091237.o5slz77tpwb5kdwj@quack3>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
In-Reply-To: <20240628091237.o5slz77tpwb5kdwj@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/28/2024 5:12 PM, Jan Kara wrote:
> On Thu 27-06-24 21:59:12, Mateusz Guzik wrote:
>> On Thu, Jun 27, 2024 at 8:27 PM Ma, Yu <yu.ma@intel.com> wrote:
>>> 2. For fast path implementation, the essential and simple point is to
>>> directly return an available bit if there is free bit in [0-63]. I'd
>>> emphasize that it does not only improve low number of open fds (even it
>>> is the majority case on system as Honza agreed), but also improve the
>>> cases that lots of fds open/close frequently with short task (as per the
>>> algorithm, lower bits will be prioritized to allocate after being
>>> recycled). Not only blogbench, a synthetic benchmark, but also the
>>> realistic scenario as claimed in f3f86e33dc3d("vfs: Fix pathological
>>> performance case for __alloc_fd()"), which literally introduced this
>>> 2-levels bitmap searching algorithm to vfs as we see now.
>> I don't understand how using next_fd instead is supposed to be inferior.
>>
>> Maybe I should clarify that by API contract the kernel must return the
>> lowest free fd it can find. To that end it maintains the next_fd field
>> as a hint to hopefully avoid some of the search work.
>>
>> In the stock kernel the first thing done in alloc_fd is setting it as
>> a starting point:
>>          fdt = files_fdtable(files);
>>          fd = start;
>>          if (fd < files->next_fd)
>>                  fd = files->next_fd;
>>
>> that is all the calls which come here with 0 start their search from
>> next_fd position.
> Yup.
>
>> Suppose you implemented the patch as suggested by me and next_fd fits
>> the range of 0-63. Then you get the benefit of lower level bitmap
>> check just like in the patch you submitted, but without having to
>> first branch on whether you happen to be in that range.
>>
>> Suppose next_fd is somewhere higher up, say 80. With your general
>> approach the optimization wont be done whatsoever or it will be
>> attempted at the 0-63 range when it is an invariant it finds no free
>> fds.
>>
>> With what I'm suggesting the general idea of taking a peek at the
>> lower level bitmap can be applied across the entire fd space. Some
>> manual mucking will be needed to make sure this never pulls more than
>> one cacheline, easiest way out I see would be to align next_fd to
>> BITS_PER_LONG for the bitmap search purposes.
> Well, all you need to do is to call:
>
> 	bit = find_next_zero_bit(fdt->open_fds[start / BITS_PER_LONG],
> 				 BITS_PER_LONG, start & (BITS_PER_LONG-1));
> 	if (bit < BITS_PER_LONG)
> 		return bit + (start & ~(BITS_PER_LONG - 1));
>
>
> in find_next_fd(). Not sure if this is what you meant by aligning next_fd
> to BITS_PER_LONG...
>
> 								Honza

So the idea here is to take a peek at the word contains next_fd, return 
directly if get free bit there. Not sure about the efficiency here if 
open/close fd frequently and next_fd is distributed very randomly. Just 
give a quick try for this part of code, seems kernel failed to boot 
up😳, kind of out of expectation ...


