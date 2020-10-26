Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC7298A2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgJZJqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 05:46:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:10050 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768350AbgJZJqe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:46:34 -0400
IronPort-SDR: ffDmliBW1JZ6OFcUu+fdDn1U+lVHWOBwx33/y2SbcuHKYklG5Ju2qTgvv/dclR2Or20vz6TX3n
 4dWtidMSTucQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="154865801"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="154865801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 02:46:31 -0700
IronPort-SDR: crkotdR7NUitDLqL85FRvnA/FsKTI5Ig3M4ahO3tG+S0LQz4fueNd1HMSzNTFpd7HRQPRUSZZ6
 NF7Zb23YI+Lw==
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="535300062"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 02:46:30 -0700
Subject: Re: [kbuild-all] Re: [vfs:work.epoll 17/27] fs/eventpoll.c:1629:3:
 warning: Assignment of function parameter has no effect outside the function.
 Did you forget dereferencing
To:     Al Viro <viro@zeniv.linux.org.uk>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
References: <202010261043.dPTrCpUD-lkp@intel.com>
 <20201026023559.GC3576660@ZenIV.linux.org.uk>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <35d2f16c-7b53-0088-7e7c-aa04451b8fb8@intel.com>
Date:   Mon, 26 Oct 2020 17:45:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201026023559.GC3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/26/20 10:35 AM, Al Viro wrote:
> On Mon, Oct 26, 2020 at 10:09:47AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
>> head:   319c15174757aaedacc89a6e55c965416f130e64
>> commit: ff07952aeda8563d5080da3a0754db83ed0650f6 [17/27] ep_send_events_proc(): fold into the caller
>> compiler: h8300-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> "cppcheck warnings: (new ones prefixed by >>)"
>>>> fs/eventpoll.c:1629:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
>>       events++;
>>       ^
> Who the hell has come up with that warning?  What happens is,
> essentially,
>
> f(..., events, ....)
> 	loop in which we have
> 		g(events, something); // store the next sample
> 		events++;
>
> More specifically, it's
>>    1620			if (__put_user(revents, &events->events) ||
>>    1621			    __put_user(epi->event.data, &events->data)) {
>>    1622				list_add(&epi->rdllink, &txlist);
>>    1623				ep_pm_stay_awake(epi);
>>    1624				if (!res)
>>    1625					res = -EFAULT;
>>    1626				break;
>>    1627			}
>>    1628			res++;
>>> 1629			events++;
> If anything, that should be reported to the maintainers of the buggy code.
> Which is not the kernel in this case.
>
> Google search on that thing brings this:
>
> 	Cppcheck is an analysis tool for C/C++ code. It detects the types of
> bugs that the compilers normally fail to detect. The goal is no false positives.
>
> IOW, that should be reported to the authors of that thing, seeing that
> their stated goal is obviously missed in this case.  Badly.  Assignments of
> function parameters can be perfectly idiomatic and this case is such.

Hi Al,

Thanks for the explanation, we'll avoid sending out such reports 
automatically
and double check the warning.

Best Regards,
Rong Chen


