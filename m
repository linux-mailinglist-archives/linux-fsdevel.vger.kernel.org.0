Return-Path: <linux-fsdevel+bounces-69842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB65C87310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 22:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A534E0F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168E2F5A01;
	Tue, 25 Nov 2025 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpBqazwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB62E88B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105291; cv=none; b=b8ztMQnJgzsgIwbRf8d1dVJVGw/AFcOFCK78ENyOIJNz+i64MWJaWkhbEB+HZLt9RNm7Jc13yKeHIGcQNCg9mGKURQMkw9Z4lMeKcO7gKaZeTKy5WEzhr7PapZCqfJpYh7FSVBOoM1DwsdyPgJztt03kxq/VEjKPkMvs6IpmIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105291; c=relaxed/simple;
	bh=DZnQUN/nAlgSu2Kpkn5dSzFzvgyig6owWn26hUjzbyM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=INihxRpA4moKgC0zXv147WQMGURHrSZyF1gli4cJqN25PsI7lOfSIgJnYX6sefL/bejQyasx7pI136DKIzorw1NcG4nywA3FBm4fameLpAKJ0giDQdZGtK7ANtyJ/kmHkT4F/ddQPnBI5fqI9ygzd9UJBON0RX+q3Io2H3V57zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpBqazwo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47798089d30so2938805e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764105288; x=1764710088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPpJMDi1g7UI5t4ESn7eW8N6MMnk1/trXPeHvR9k1Xg=;
        b=lpBqazwoAgO5/C/c2iVkTD9drKodLeCjNULBi9jxcikGd12SV6rCqNnyRjisa+t60K
         4RqU1WS6NylqTm4+7ueFwndM6EUCy7Rnl/S4jlz8t0paYX8aWGrOBVDwcbN+2boyYpgz
         FendGI/RTM7mHXM0vUazVZQWXQbY897XXkikPWRZ0sjVjSOgaMbOWtbCbTf9wom9xFsV
         b5wCmy3xjaXqEeizuLwQV/4vj1SDrdxxQo/r683dXhmf6XHVfr8TklijT+labXUoby01
         s5B+Jl4hadFL9/fJs/zbBNlenEafsokPcTIjL4aV5tPCtP5XYSW+uUrjrstkUEtbyNoH
         MUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764105288; x=1764710088;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPpJMDi1g7UI5t4ESn7eW8N6MMnk1/trXPeHvR9k1Xg=;
        b=QiWO4m2ruv49kJIgTLyF4yzMr/W/hLA1JPRXVoi9W+olL3aefQ/Kg00G0mVQR7WzCZ
         NCqis0FUOK8SI2YGYQre2YjUNoq2N42ykXGiEzHGdpCh6qtpvZqkyP5Hs2lv4Q5OXkEu
         uKlLVxwUsn/Kd2T3Ods85BPUetqk6KCPCFBXRG95tRRw2alCxmbdQJJbxtPWfNH0Oawk
         4Xy3KvSpElpMVRiLhNozBH0V9xPTuGZ7mOxJbpTLGyC5H+UVR8cqqwlsiP/jbFOwzzdD
         jM/Qnn39nCUtWqPvQdg7+DLtVoWxDGGK4/WSHQXpwtqQihiegBgxAadyypYQrGvreGH8
         mBMg==
X-Forwarded-Encrypted: i=1; AJvYcCXK5bUI6Q5NHYqkNF7W9CU+nLBxI3I7rQLlPkVZlB3QcgOuUQb11D2vKBQouoFiYbpYgVDTdv0Q3jC57Dw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kfCqey6WpXzXCGqK0YK7XjA9y1V3DZcASaoS6tlbTVPAPRBq
	bnA9f7pT4306mtaxkTmFeAhrPruZzNJ3S82QygxAe9F2Eb11lCRQJ5UO
X-Gm-Gg: ASbGncvAzHK3JpGCxB50V2zjFjWkmgSEAQYyDcMYsyvt59wV7xHgD7U7aErFfiiCIWG
	zuTeF1N1Ih5939W3ifv7zEYK+fVMd/4mSPM9pw+T8p6ZhN2Dybay7NzDpMHPj9jqZnF2BHRMzaO
	PWKK+UVyVAST+x6CU6Y0tp4cLOuupKC8O69mNQ5wzlhl0eWIVsvZ7sh5O79DMV5mUeQNF3M8Co0
	uu35G41mXgBZbl9o/yNxylfbz5u+t8haWb8R1x9e7SAta9uxy1iLixghBv37nSDgUbdj56mkqeQ
	pgovpQEDCktKwK0gorY98Iq9bpw26Pgw42SyDrjMaXZHOEfPz+G5cE0fAKJods+j1F+g1YnB3jR
	5N0v7wAq3dLbRP/EwARmtl5R/yAvGzSeOYeSvRorVQg6vkI6IrMgAM4c/fuDcFbmLNdqvZzBAr5
	A28mfNINUl73SVSTS2fkj739yFDkpxlQ==
X-Google-Smtp-Source: AGHT+IGlls89KY5veV5wfwRYZMITh6LRhl72MxX5srA+TSmWi5C6PuVSnMEYol6zHgzpM6bGpo/1nA==
X-Received: by 2002:a05:600c:5254:b0:477:7bd8:8f2d with SMTP id 5b1f17b1804b1-477c32794f8mr86979105e9.8.1764105287519;
        Tue, 25 Nov 2025 13:14:47 -0800 (PST)
Received: from [192.168.1.105] ([165.50.65.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040ac7e8sm28794415e9.1.2025.11.25.13.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 13:14:47 -0800 (PST)
Message-ID: <b2fcff21-2b5a-486a-976f-4a5ff4337d72@gmail.com>
Date: Tue, 25 Nov 2025 23:14:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "jack@suse.cz"
 <jack@suse.cz>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
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
Content-Language: en-US
In-Reply-To: <218c654fc2cad8f6acac1530d431094abb1bffbe.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/25 12:01 AM, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-22 at 00:36 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 11/21/25 11:28 PM, Viacheslav Dubeyko wrote:
>>> On Sat, 2025-11-22 at 00:16 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> On 11/21/25 11:04 PM, Viacheslav Dubeyko wrote:
>>>>> On Fri, 2025-11-21 at 23:48 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>> On 11/21/25 10:15 PM, Viacheslav Dubeyko wrote:
>>>>>>> On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>>> On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
>>>>>>>>> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>>>>>
> 
> <skipped>
> 
>>>>>>>
>>>>>> IIUC, hfs_mdb_put() isn't called in the case of hfs_kill_super() in
>>>>>> christian's patch because fill_super() (for the each specific
>>>>>> filesystem) is responsible for cleaning up the superblock in case of
>>>>>> failure and you can reference christian's patch[1] which he explained
>>>>>> the reasoning for here[2].And in the error path the we are trying to
>>>>>> fix, fill_super() isn't even called yet. So such pointers shouldn't be
>>>>>> pointing to anything allocated yet hence only freeing the pointer to the
>>>>>> sb_info here is sufficient I think.
>>>
>>> I was confused that your code with hfs_mdb_put() is still in this email. So,
>>> yes, hfs_fill_super()/hfsplus_fill_super() try to free the memory in the case of
>>> failure. It means that if something wasn't been freed, then it will be issue in
>>> these methods. Then, I don't see what should else need to be added here. Some
>>> file systems do sb->s_fs_info = NULL. But absence of this statement is not
>>> critical, from my point of view.
>>>
>> Thanks for the input. I will be sending the same mentionned patch after
>> doing testing for it and also after finishing my testing for the hfs
>> patch too.
>>>
> 
> I am guessing... Should we consider to introduce some xfstest, self-test, or
> unit-test to detect this issue in all Linux's file systems family?
> 
Yes, It isn't that hard either IIUC you just need to fail the 
bdev_file_open_by_dev() function somehow to trigger this error path..
> Thanks,
> Slava.

So I wanted to update you on my testing for the hfs patch and the 
hfsplus patch. For the testing I used both my desktop pc and my laptop 
pc running the same configuraitons and the same linux distribution to 
have more accurate testing. There are three variants that I used for 
testing : A stable kernel, 6.18-rc7 kernel with no patch, 6.18-rc7 
kernel with hfs or hfsplus patch.

Firstly, I couldn't run the hfs tests due to mkfs.hfs being unavailable 
in my search for it. they all point to mkfs.hfsplus and you pointed out 
that mkfs.hfsplus can create hfs filesystems with the -h flag but in my 
case it doesn't. I pointed out last time that I found a tool to create 
HFS filesystems which it does (it's called hformat) but the xfstests 
require the availability of mkfs.hfs and fsck.hfs for them to run. More 
help on this is needed for me to run hfs tests. I also tested ext4 as 
you have suggested as a base to compare to. Here is my summary of testing:

For Stable kernel 6.17.8:

On desktop:
ext4 tests ran successfully.
hfsplus tests crash the pc around generic 631 test.

On Laptop:
ext4 and hfsplus tests ran successfully.

For 6.18-rc7 kernel:

On desktop:
ext4 tests ran successfully same results as the stable kernel.
hfsplus crashes on testing startup.For launching any test.

On Laptop:
ext4 tests ran successfully same results as the stable kernel.
hfsplus crashes on testing startup.For launcing any test.


For the patched 6.18-rc7 kernel.

Same results for both desktop and laptop pcs as in the 6.18-rc7 kernel.


Should be noted that I have tried many different setups regarding the 
devices and their creation for the 6.18-rc7 kernel and none of them 
worked.Still I can't deduce what is causing the issue.If they work for 
you, my only assumption is that some dependency of xfstests is not met 
on my part even though I made sure that I do cover them all especially 
with repeatedly failed testing...

What could be the issue here on my end if you have any idea?

Also should I send you the hfsplus patch in one of my earlier replies[1] 
for you to test too and maybe add it to hfsplus?

Best Regards,
Mehdi Ben Hadj Khelifa

[1]:https://lore.kernel.org/all/3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com/







