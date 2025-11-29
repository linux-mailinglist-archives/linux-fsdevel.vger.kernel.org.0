Return-Path: <linux-fsdevel+bounces-70233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60BC93D55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 13:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0D193475D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADC30E849;
	Sat, 29 Nov 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHCUAVFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2248309F1B
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764417992; cv=none; b=Lkpk6z5F9dJp3Qc9gKFVFNVisYmNs+XhDYt6Af4MwLWYfIBkm4aVpifzwAkp0Pd+OxSpiT4s3b2JytYenPOjWj7gPcCZVu2g79eqCq+f7S1NtOdQ+Va4ZDAdeg+DczrFKwm/yEXNvIHqSxyqiM0ClrXCV+urygk78h2bprQB8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764417992; c=relaxed/simple;
	bh=8N5fIIAs1wTrl4tZoQSpBPclrdySFFvO+N+LWQHrm2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niJzYo19MS3pXCNegAAcvlqRqbs4EpGB83nkdRgHo7TH9ae8lnhhmzQQSQiUQNWxYv2kiUghF5rdkJoqq79yOLyR9wRY+QNMknaX2dq2jAzcewgIhPuNeVgRc0aqccfyWxyogCHHZKPWGupAK/9f3wvfXrv2ralAD4vjidZsBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHCUAVFP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b2cff817aso172320f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 04:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764417989; x=1765022789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFdpFUjeuYya488Uw2LSyM1xV4mFxGyC/pjh5yJHqVE=;
        b=SHCUAVFPiex+/I9g02UUGlzhhrSZOCtm2FSjIijmDSgr+ZKVhOKsk99vdiKI4V4U/z
         U/j7xOkZYdrZH1fbKcCmWY3g1x/9yG046kxQrFsi3zcZ7vyurcfP9oXwG6hLoVPW8cBA
         e+SLiLOjiYVXHdu8Db2tmqfayg/OpjPBijmY2Xbcel3YBMyc3g315vlDyeFxfWrgAqhY
         Mok62LsJX26J/RVVhdc5VGub/ip6zM0pSqNUlUqkoO0n3tMm9eD1J5WtzgdGErjEJOoe
         /3Sj+mdv4RToYgnjb+DPRT7zmbIsQm9wAJvrCh37KoGHRww5aqGze6TNfE3xKenuz2r4
         g4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764417989; x=1765022789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFdpFUjeuYya488Uw2LSyM1xV4mFxGyC/pjh5yJHqVE=;
        b=p1mgZk4zujYAcXT/JfV8Aqfzpf+v9rfmtd7yh1FFSyi2tkQa9fCGt7SdDC072Wc80X
         OpY6bIgXicS4wFPXP6SaZZ7+Ck2Su20gWkgjQnyVoRprefwMS7ywYA/jQvUJdeZPf5Gi
         ggasGK7GSoPPfFAtU/VJQcUDtKSY3EbZXE1x4LI8ESLrPPuS2mR9u1pi2naK85O/wFUh
         RRrbO0EiWV7/IIx/cKvkOzQLUKtZjFqwHmD9FbJNc/6bjtW1MsnDtB+GznNYuqbrq2Vp
         SvvvAgV1acfy7poXnXvP1e18rKqXfJgUY4V4wwCeCODkRKfoDvlHylt39JR4qVtWe5Ci
         RE4w==
X-Forwarded-Encrypted: i=1; AJvYcCW793sh5gRHmcnGk/dAVRzUi4dHi1MPQgFgDEVSqcjlubcpx+iI6f/IB9LqTYlChkYi8xXdY9H4MN7o1Iz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyczvtODnBNZ+9Z9dctmV69CLgU01w3WrrSSHWeb6QH9FMuDqj/
	5ajKVXbs4/HyAg/66gipU7WrlS6/XLh6ZmyRe3/uZ0lvAJ2qmdVj2bNt
X-Gm-Gg: ASbGncs+eeXC6OI6FsJfavtGnnushDqZUHTU6L2zCkz1z06iGG+GMQ+9M0WVe7ZX/pU
	0DcZ28dGW4GRSBV4Yr6ffCPj4bR50Bi57LMp9meXy2kI2iZGoOXAm0PTJ/vY3ie1xZnspPPl0W7
	XlNtwFwpJDwMMguy7O0iLHtCoHch1gqhPdn0LhyHPIBqVMgDk8oX6OBvN+NC71ADQqIh/hEuHiw
	872Ky7ugebOoV43wyJze4B2icqbCcVBaQ3+XMkIf4PWhgJp9si715kKmkyl8SJf9fKeNs4wjWcl
	dL3b9h8vSVjCS1WhQOvyqarMQx9i8xxlwnYPdBCQmDthRJccnn1xKCqyieBnUf2Ola69DIGUqZb
	qjsj/77jMx2WOgj1sEEwYIKxEWSEDwiAa6urKKbzZSLpTBP/za4GamSFosev12ej9CUzTm+8MIg
	lALYj+Zd0vfARQwBhrlYyqypi6hB/yUg==
X-Google-Smtp-Source: AGHT+IHQIe2ySkcpdD4lAHKBfpJWHfviZ9ZZRA6p1icKkcqqn5YDA3edfC96lI3JFD1h+khfTxYFGQ==
X-Received: by 2002:a05:600c:4443:b0:45f:2c33:2731 with SMTP id 5b1f17b1804b1-477c0169f1emr182523085e9.2.1764417989080;
        Sat, 29 Nov 2025 04:06:29 -0800 (PST)
Received: from [192.168.1.105] ([165.50.52.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052cfae0sm108457775e9.8.2025.11.29.04.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 04:06:28 -0800 (PST)
Message-ID: <bbb45390-58f0-4069-8b32-78d0242afdee@gmail.com>
Date: Sat, 29 Nov 2025 14:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: David Hunter <david.hunter.linux@gmail.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "jack@suse.cz" <jack@suse.cz>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "khalid@kernel.org" <khalid@kernel.org>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
 <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
 <148f1324cd2ae50059e1dcdc811cccdee667b9ae.camel@ibm.com>
 <6ddd2fd3-5f62-4181-a505-38a5d37fa793@gmail.com>
 <960f74ac4a4b67ebb0c1c4311302798c1a9afc53.camel@ibm.com>
 <28fbe625-eb1b-4c7f-925c-aec4685a6cbf@gmail.com>
 <218c654fc2cad8f6acac1530d431094abb1bffbe.camel@ibm.com>
 <b2fcff21-2b5a-486a-976f-4a5ff4337d72@gmail.com>
 <a3b93b9e-f0ea-428d-9a10-07f345e139a7@gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <a3b93b9e-f0ea-428d-9a10-07f345e139a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/25 6:45 PM, David Hunter wrote:
> On 11/25/25 17:14, Mehdi Ben Hadj Khelifa wrote:
>> On 11/22/25 12:01 AM, Viacheslav Dubeyko wrote:
>>> On Sat, 2025-11-22 at 00:36 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> On 11/21/25 11:28 PM, Viacheslav Dubeyko wrote:
>>>>> On Sat, 2025-11-22 at 00:16 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>> On 11/21/25 11:04 PM, Viacheslav Dubeyko wrote:
>>>>>>> On Fri, 2025-11-21 at 23:48 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>>> On 11/21/25 10:15 PM, Viacheslav Dubeyko wrote:
>>>>>>>>> On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>>>>> On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
>>>>>>>>>>> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>>>>>>>
>>>
>>> <skipped>
>>>
>>>>>>>>>
>>>>>>>> IIUC, hfs_mdb_put() isn't called in the case of hfs_kill_super() in
>>>>>>>> christian's patch because fill_super() (for the each specific
>>>>>>>> filesystem) is responsible for cleaning up the superblock in case of
>>>>>>>> failure and you can reference christian's patch[1] which he
>>>>>>>> explained
>>>>>>>> the reasoning for here[2].And in the error path the we are trying to
>>>>>>>> fix, fill_super() isn't even called yet. So such pointers
>>>>>>>> shouldn't be
>>>>>>>> pointing to anything allocated yet hence only freeing the pointer
>>>>>>>> to the
>>>>>>>> sb_info here is sufficient I think.
>>>>>
>>>>> I was confused that your code with hfs_mdb_put() is still in this
>>>>> email. So,
>>>>> yes, hfs_fill_super()/hfsplus_fill_super() try to free the memory in
>>>>> the case of
>>>>> failure. It means that if something wasn't been freed, then it will
>>>>> be issue in
>>>>> these methods. Then, I don't see what should else need to be added
>>>>> here. Some
>>>>> file systems do sb->s_fs_info = NULL. But absence of this statement
>>>>> is not
>>>>> critical, from my point of view.
>>>>>
>>>> Thanks for the input. I will be sending the same mentionned patch after
>>>> doing testing for it and also after finishing my testing for the hfs
>>>> patch too.
>>>>>
>>>
>>> I am guessing... Should we consider to introduce some xfstest, self-
>>> test, or
>>> unit-test to detect this issue in all Linux's file systems family?
>>>
>> Yes, It isn't that hard either IIUC you just need to fail the
>> bdev_file_open_by_dev() function somehow to trigger this error path..
>>> Thanks,
>>> Slava.
>>
>> So I wanted to update you on my testing for the hfs patch and the
>> hfsplus patch. For the testing I used both my desktop pc and my laptop
>> pc running the same configuraitons and the same linux distribution to
>> have more accurate testing. There are three variants that I used for
>> testing : A stable kernel, 6.18-rc7 kernel with no patch, 6.18-rc7
>> kernel with hfs or hfsplus patch.
>>
>> Firstly, I couldn't run the hfs tests due to mkfs.hfs being unavailable
>> in my search for it. they all point to mkfs.hfsplus and you pointed out
>> that mkfs.hfsplus can create hfs filesystems with the -h flag but in my
>> case it doesn't. I pointed out last time that I found a tool to create
>> HFS filesystems which it does (it's called hformat) but the xfstests
>> require the availability of mkfs.hfs and fsck.hfs for them to run. More
>> help on this is needed for me to run hfs tests. I also tested ext4 as
>> you have suggested as a base to compare to. Here is my summary of testing:
>>
>> For Stable kernel 6.17.8:
>>
>> On desktop:
>> ext4 tests ran successfully.
>> hfsplus tests crash the pc around generic 631 test.
>>
>> On Laptop:
>> ext4 and hfsplus tests ran successfully.
>>
>> For 6.18-rc7 kernel:
>>
>> On desktop:
>> ext4 tests ran successfully same results as the stable kernel.
>> hfsplus crashes on testing startup.For launching any test.
>>
>> On Laptop:
>> ext4 tests ran successfully same results as the stable kernel.
>> hfsplus crashes on testing startup.For launcing any test.
>>
>>
>> For the patched 6.18-rc7 kernel.
>>
>> Same results for both desktop and laptop pcs as in the 6.18-rc7 kernel.
>>
>>
>> Should be noted that I have tried many different setups regarding the
>> devices and their creation for the 6.18-rc7 kernel and none of them
>> worked.Still I can't deduce what is causing the issue.If they work for
>> you, my only assumption is that some dependency of xfstests is not met
>> on my part even though I made sure that I do cover them all especially
>> with repeatedly failed testing...
>>
>> What could be the issue here on my end if you have any idea?
>>
>> Also should I send you the hfsplus patch in one of my earlier replies[1]
>> for you to test too and maybe add it to hfsplus?
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa
>>
>> [1]:https://lore.kernel.org/all/3ad2e91e-2c7f-488b-
>> a119-51d62a6e95b8@gmail.com/
>>
>>
>>
>>
>>
>>
> 
> Hey everyone,
> 
> I am helping Shuah with the Linux Kernel Mentorship Program. I wanted to
> report that many mentees have also had problems with xfstests recently.
> 
> I am tracking what happens here, so I can help future developers, but I
> just wanted to let everyone know that others are also having issues with
> xfstests.
> 
> Also, Mehdi, by any chance have you used any of the configuration
> targets like "localmodconfig". I am wondering if something in your
> configuration file is missing.
> 
No I have not,Thanks for the suggestion.I have been messing with a lot 
of syzbot configurations but IIRC I always have made sure to make 
mrproper and copy my in use .config file before building for my pc.I 
still want to reproduce the same crash as I did before on my part now to 
see what caused the problem anyway but my assumption for the time being 
is that localmodconfig would fix it.

I will keep you updated on the matter too David.Thanks

> Thanks,
> David Hunter
Best Regards,
Mehdi Ben Hadj khelifa

