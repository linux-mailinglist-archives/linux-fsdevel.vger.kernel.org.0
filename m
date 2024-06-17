Return-Path: <linux-fsdevel+bounces-21840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB490B7D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34976284E88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50516D4EB;
	Mon, 17 Jun 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewGtm58f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8516CD3F;
	Mon, 17 Jun 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644941; cv=none; b=j/fJiSqPlUS3evWMYQc/4xxTYmKPgLgibf/q39ZBkgZ85HaJswyPkksaVAD5Htkx84bk1mOdocg9bVcZ1GjaGOVTRS0pP3Unx0iSzfo07jRjuPH5gHRBpAxl3OXa2KwFCucfxYuBhsD65nPKQS2+3xXqfoHrrXtvW8cjUo9NlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644941; c=relaxed/simple;
	bh=zptzhIEUP8jnYvt0dNb3Qykrja0JIEF/vS5PqxZQQHo=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=nR0ipdRlPuwbnerFnB7CeCVhXd1NCoVHPMkUGDFEIyuK8l1+tTeYF0z9RvtRjV6V8nJ+N2lpu/bqqwY2QQ1r57cd7dmbJeGyfHJsZUVCb+tv6PwZb8ahPt/8ER5oxhBSmk+3ryGxD1yiL9sy8ysFgELxqJ8U1HaZzlA5/+ZZ+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewGtm58f; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718644939; x=1750180939;
  h=message-id:date:mime-version:subject:references:from:to:
   cc:in-reply-to:content-transfer-encoding;
  bh=zptzhIEUP8jnYvt0dNb3Qykrja0JIEF/vS5PqxZQQHo=;
  b=ewGtm58fd8ggF2MiUWvjTUQnZot1Pqc+seohP2/4KTt19vyp1crwuyd2
   7X88ch3YcAO2pQoAU3+MjdB7S3nieMku8mPWUYoCI1n/s1ANKXtaZ1GD9
   jO8xs60RtU6r6hHCvFTGQHgXXbnwJrqZQ75jxRiSlzNvJAjsGU1rOr2Ue
   hl7B+F5sf/e+SoCXN2rjvCTEAjGJdP/8b6oHMocH7AsK9maXwmWezliOF
   ZP3X502iFoUyvvC753wFHguVOzyLwL2Rd51qoxL9IFMu2Nt4wKnr9sqMB
   7JHht1O/thhZihm1193rmoVGK4IfMbq84/SWmjQtoGjjPmizRkSw977eI
   g==;
X-CSE-ConnectionGUID: OqW5+oJEQieEl9SO8sZSpA==
X-CSE-MsgGUID: 3dwz1wpZTw+U/CJUl+IaCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15608879"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15608879"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:22:19 -0700
X-CSE-ConnectionGUID: fT/NIVfcRne7nSd02QR49Q==
X-CSE-MsgGUID: Aehq75JrQN2Ks/LW7Ia31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41192247"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.224.103]) ([10.124.224.103])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:22:16 -0700
Message-ID: <c96d2f39-fa90-41da-985c-116cf4cc967a@intel.com>
Date: Tue, 18 Jun 2024 01:22:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
 <e316cbe9-0e66-414f-8948-ba3b56187a98@intel.com>
 <suehfaqsibehz3vws6oourswenaz7bbbn75a7joi5cxi6komyk@3fxp7v3bg5qk>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tim.c.chen@linux.intel.com, tim.c.chen@intel.com, pan.deng@intel.com,
 tianyou.li@intel.com, yu.ma@intel.com
In-Reply-To: <suehfaqsibehz3vws6oourswenaz7bbbn75a7joi5cxi6komyk@3fxp7v3bg5qk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/17/2024 7:23 PM, Mateusz Guzik wrote:
> On Sun, Jun 16, 2024 at 11:47:40AM +0800, Ma, Yu wrote:
>> On 6/15/2024 12:41 PM, Mateusz Guzik wrote:
>>> So you are moving this to another locked area, but one which does not
>>> execute in the benchmark?
>> The consideration here as mentioned is to reduce the performance impact (if
>> to reserve the sanity check, and have the same functionality) by moving it
>> from critical path to non-critical, as put_unused_fd() is mostly used for
>> error handling when fd is allocated successfully but struct file failed to
>> obtained in the next step.
>>
> As mentioned by Christian in his mail this check can just be removed.

Yes, that's great, I'll update in v2

>
>>          error = -EMFILE;
>>          if (fd < fdt->max_fds) {
> I would likely() on it.

That's better :)

>
>>                  if (~fdt->open_fds[0]) {
>>                          fd = find_next_zero_bit(fdt->open_fds,
>> BITS_PER_LONG, fd);
>>                          goto fastreturn;
>>                  }
>>                  fd = find_next_fd(fdt, fd);
>>          }
>>
>>          if (unlikely(fd >= fdt->max_fds)) {
>>                  error = expand_files(files, fd);
>>                  if (error < 0)
>>                          goto out;
>>                  if (error)
>>                          goto repeat;
>>          }
>> fastreturn:
>>          if (unlikely(fd >= end))
>>                  goto out;
>>          if (start <= files->next_fd)
>>                  files->next_fd = fd + 1;
>>
>>         ....
>>
> This is not a review, but it does read fine.
>
> LTP (https://github.com/linux-test-project/ltp.git) has a bunch of fd
> tests, I would make sure they still pass before posting a v2.
Got it, thanks for the kind reminder.
>
> I would definitely try moving out the lock to its own cacheline --
> currently it resides with the bitmaps (and first 4 fds of the embedded
> array).
>
> I expect it to provide some win on top of the current patchset, but
> whether it will be sufficient to justify it I have no idea.
>
> Something of this sort:
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 2944d4aa413b..423cb599268a 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -50,11 +50,11 @@ struct files_struct {
>      * written part on a separate cache line in SMP
>      */
>          spinlock_t file_lock ____cacheline_aligned_in_smp;
> -       unsigned int next_fd;
> +       unsigned int next_fd ____cacheline_aligned_in_smp;
>          unsigned long close_on_exec_init[1];
>          unsigned long open_fds_init[1];
>          unsigned long full_fds_bits_init[1];
> -       struct file __rcu * fd_array[NR_OPEN_DEFAULT];
> +       struct file __rcu * fd_array[NR_OPEN_DEFAULT] ____cacheline_aligned_in_smp;
>   };
>
>   struct file_operations;
>
> (feel free to just take)

Thanks Guzik for the thoughtful suggestions, seems we've ever tried to 
separate file_lock and next_fd to different cachelines, but no obvious 
improvement observed, we'll double check and verify these 2 tips to see 
how it goes.

>
> All that said, I have to note blogbench has numerous bugs. For example
> it collects stats by merely bumping a global variable (not even with
> atomics), so some updates are straight up lost.
>
> To my understanding it was meant to test filesystems and I'm guessing
> threading (instead of separate processes) was only used to make it
> easier to share statistics. Given the current scales this
> unintentionally transitioned into bottlenecking on the file_lock
> instead.
>
> There were scalability changes made about 9 years ago and according to
> git log they were benchmarked by Eric Dumazet, while benchmark code was
> not shared. I suggest CC'ing the guy with your v2 and asking if he can
> bench.  Even if he is no longer in position to do it perhaps he can rope
> someone in (or even better share his benchmark).

Good advice, we also noticed the problem for blogbench, and current data 
in commits is collected based on revision to make sure the variables for 
score statistic/reporting are safe, will submit patch to blogbench for 
update. We'll copy Eric for more information on his benchmark and check 
details if it is available.


