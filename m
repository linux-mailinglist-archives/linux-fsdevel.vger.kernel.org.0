Return-Path: <linux-fsdevel+bounces-32156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85029A15DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAADE1C210E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBC1D434F;
	Wed, 16 Oct 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ES5D5lL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC931D279F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729118334; cv=none; b=Eh5Q9Aj2Yd2sHt1YtoHRTCjmjsqrZZVxX4sVOh0CQH5myRbWWaNcSlDb/xtnhFaCu6atJAk3ibaRMUnCTBbY6AqtjC88GIA2ahfwck9lhlAm6hjPQl3B0WDUb4jzuTbYpUayx7ycjRMxCKV9xpetduViTYvF8LjpVjOGgXDsMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729118334; c=relaxed/simple;
	bh=NbnNRvmjZJubvyTcaKg6ILzesZLmfD5iMvU3AWzbVyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HphlcHh7Gxo8jy/uPS72JUFGFQ2V97hm3xcyBcRabY8IlsTv/tL78FPV74cEG7NAVN+1HL1tR6fJ7fd2iH2ze7MNDudA/DQc3cF5fbR/hZ4LWZKhjYbt9u616J/UgOVIfe+tUydskV1hGlAeO2+tfv3BrjQIbMtfR6nPAbZNgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ES5D5lL4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83aac75fcceso14341439f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729118332; x=1729723132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQRRRq47/Hw9MX6ZtToVorakNDyg07L0TFDDDji46Mo=;
        b=ES5D5lL4AwPZ8yvkNaLWYQDxf67wOqUkmVxkEl/UQS/wn2b0Oar3tPuxpyHDhqe28T
         VBQEkCMcDQf2F70/D4SeyBApNmTtCXlXqy4PCRJy1+F9T+qNHSIRxEqNW/sTm1hRqFy/
         CX1DhyqQMTWkLgH/4Yer3Re6NvbS1kAabZC2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729118332; x=1729723132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQRRRq47/Hw9MX6ZtToVorakNDyg07L0TFDDDji46Mo=;
        b=QagdxkuG9TpJINeCdbIVv+ODz5OuBPMmNox9zBLd11iFMHnDwMGXxXcIwr3VjaG4G7
         Kt9eMr9+Eto/rH0+jSWopCPK84jjDHqcWzRHzr9ie0dOZXbExKLNAH7oTqZtiV0/Bxh6
         V5co9o82Bdx4+EnDaJAPKs8HH7/Y1A+eiR6zlSd7i7ujptoENKDL3tDFl1FiZPO6v1G/
         wXT/wCMsQxkztLryzBg2p4qnGzhVTIDOBy6x2BqHkjPs+6R/v5SkJFnuI7mo5NhprOgn
         m8EXKHUGVQS4EzdnHHjUroG4UKLoozkL5kMEu15eIgF/pwJxIdIWApU7BY5ArbEQ8zLN
         z37A==
X-Forwarded-Encrypted: i=1; AJvYcCXbVKDEHiJYgx7IzskLkii3Eprxml6FlGjBiHaoeqaKqqoG4Q+9/4+00tb5Ptzy9GT2bvKroJn6tKuaQ8Qf@vger.kernel.org
X-Gm-Message-State: AOJu0YyIizv7mg5kOfO8h9n4aRvQ4BGNDlMwJi5lwaYtrjjIwNBruzY0
	SUNPGQdkEbSAzAI7fyUBQHubYgQxU0nPT1Qk1qjkXBqmwPhvyRvn6g2jSSDYAcU=
X-Google-Smtp-Source: AGHT+IFivQcgqrz4+LdP/xfhfGNmIqN1nL/+KVDlxQRCS03LTC4/8hYkEZhoL+4u2csjPmdOw2hZKA==
X-Received: by 2002:a05:6e02:3cc2:b0:3a3:a307:6851 with SMTP id e9e14a558f8ab-3a3bce0858dmr137968295ab.22.1729118331696;
        Wed, 16 Oct 2024 15:38:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9632cbsm1058985173.20.2024.10.16.15.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 15:38:51 -0700 (PDT)
Message-ID: <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
Date: Wed, 16 Oct 2024 16:38:50 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/24 16:06, Lorenzo Stoakes wrote:
> On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
>>> Add tests to assert that PIDFD_SELF_* correctly refers to the current
>>> thread and process.
>>>
>>> This is only practically meaningful to pidfd_send_signal() and
>>> pidfd_getfd(), but also explicitly test that we disallow this feature for
>>> setns() where it would make no sense.
>>>
>>> We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
>>> theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
>>>
>>> We defer testing of mm-specific functionality which uses pidfd, namely
>>> process_madvise() and process_mrelease() to mm testing (though note the
>>> latter can not be sensibly tested as it would require the testing process
>>> to be dying).
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    tools/testing/selftests/pidfd/pidfd.h         |   8 +
>>>    .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
>>>    .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
>>>    tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
>>>    4 files changed, 224 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
>>> index 88d6830ee004..1640b711889b 100644
>>> --- a/tools/testing/selftests/pidfd/pidfd.h
>>> +++ b/tools/testing/selftests/pidfd/pidfd.h
>>> @@ -50,6 +50,14 @@
>>>    #define PIDFD_NONBLOCK O_NONBLOCK
>>>    #endif
>>> +/* System header file may not have this available. */
>>> +#ifndef PIDFD_SELF_THREAD
>>> +#define PIDFD_SELF_THREAD -100
>>> +#endif
>>> +#ifndef PIDFD_SELF_THREAD_GROUP
>>> +#define PIDFD_SELF_THREAD_GROUP -200
>>> +#endif
>>> +
>>
>> As mentioned in my response to v1 patch:
>>
>> kselftest has dependency on "make headers" and tests include
>> headers from linux/ directory
> 
> Right but that assumes you install the kernel headers on the build system,
> which is quite a painful thing to have to do when you are quickly iterating
> on a qemu setup.

Yes that is exactly what we do. kselftest build depends on headers
install. The way it works for qemu is either using vitme-ng or
building tests and installing them in your vm.. This is what CIs do.

> 
> This is a use case I use all the time so not at all theoretical.

This is what CIs do. Yes - it works for them to build and install
headers. You don't have to install them on the build system. You
run "make headers" in your repo. You could use O= option for
relocatable build.

> 
> Unfortunately this seems broken on my system anyway :( - see below.
> 
>>
>> These local make it difficult to maintain these tests in the
>> longer term. Somebody has to go clean these up later.
> 
> I don't agree, tests have to be maintained alongside the core code, and if
> these values change (seems unlikely) then the tests will fail and can
> easily be updated.
> 
> This was the approach already taken in this file with other linux
> header-defined values, so we'll also be breaking the precendence.

Some of these defines were added a while back. Often these defines
need cleaning up. I would rather not see new ones added unless it is
absolutely necessary.

> 
>>
>> The import will be fine and you can control that with -I flag in
>> the makefile. Remove these and try to get including linux/pidfd.h
>> working.
> 
> I just tried this and it's not fine :) it immediately broke the build as
> pidfd.h imports linux/fcntl.h which conflicts horribly with system headers
> on my machine.
> 
> For instance f_owner_ex gets redefined among others and fails the build e..g:
> 
> /usr/include/asm-generic/fcntl.h:155:8: error: redefinition of ‘struct f_owner_ex’
>    155 | struct f_owner_ex {
>        |        ^~~~~~~~~~
> In file included from /usr/include/bits/fcntl.h:61,
>                   from /usr/include/fcntl.h:35,
>                   from pidfd_test.c:6:
> /usr/include/bits/fcntl-linux.h:274:8: note: originally defined here
>    274 | struct f_owner_ex
>        |        ^~~~~~~~~~
> 
> It seems only one other test tries to do this as far as I can tell (I only
> did a quick grep), so it's not at all standard it seems.
> 
> This issue occurred even when I used make headers_install to create
> sanitised user headers and added them to the include path.
> 
> A quick google suggests linux/fcntl.h (imported by this pidfd.h uapi
> header) and system fcntl.h is a known thing. Slightly bizarre...
> 
> I tried removing the <fcntl.h> include and that resulted in <sys/mount.h>
> conflicting:
> 
> In file included from /usr/include/fcntl.h:35,
>                   from /usr/include/sys/mount.h:24,
>                   from pidfd.h:17,
>                   from pidfd_test.c:22:
> /usr/include/bits/fcntl.h:35:8: error: redefinition of ‘struct flock’
>     35 | struct flock
>        |        ^~~~~
> In file included from /tmp/hdr/include/asm/fcntl.h:1,
>                   from /tmp/hdr/include/linux/fcntl.h:5,
>                   from /tmp/hdr/include/linux/pidfd.h:7,
>                   from pidfd.h:6:
> /usr/include/asm-generic/fcntl.h:195:8: note: originally defined here
>    195 | struct flock {
>        |        ^~~~~
> 
> So I don't think I can actually work around this, at least on my system,
> and I can't really sensibly submit a patch that I can't run on my own
> machine :)
> 
> I may be missing something here.
> 
>>
>> Please revise this patch to include the header file and remove
>> these local defines.
> 
> I'm a little stuck because of the above, but I _could_ do the following in
> the test pidfd.h header.:
> 
> #define _LINUX_FCNTL_H
> #include "../../../../include/uapi/linux/pidfd.h"
> #undef _LINUX_FCNTL_H
> 

Does this test really need fcntl.h is another question.
This is another problem with too many includes. The test
built just fine on my system on 6.12-rc3 with

+/* #include <fcntl.h> */

> Which prevents the problematic linux/fcntl.h header from being included and
> includes the right header.
> 
> But I'm not sure this is hugely better than what we already have
> maintinability-wise? Either way if something changes to break it it'll
> break the test build.
> 

If these defines are in a header file - tests include them. Part
of test development is figuring out these problems.

> Let me know if this is what you want me to do. Otherwise I'm not sure how
> to proceed - this header just seems broken at least on my system (arch
> linux at 6.11.1).
> 
> An aside:
> 
> The existing code already taken the approach I take (this is partly why I
> did it), I think it'd be out of the scope of my series to change that, for
> instance in pidfd.h:
> 
> #ifndef PIDFD_NONBLOCK
> #define PIDFD_NONBLOCK O_NONBLOCK
> #endif
> 
> Alongside a number of other defines. So those will have to stay at least
> for now for being out of scope, but obviously if people would prefer to
> move the whole thing that can be followed up later.
> 
>>

I would like us to explore before giving up and saying these will
stay.

thanks,
-- Shuah


