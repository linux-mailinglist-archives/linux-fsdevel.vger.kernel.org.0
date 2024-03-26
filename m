Return-Path: <linux-fsdevel+bounces-15270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605688B6B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 02:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712501F3D815
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667FC1CD03;
	Tue, 26 Mar 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmfGbg/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED63320E
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415870; cv=none; b=G3NAOcGL0w3T5nWgG0SoIxTPtWR8OLrynWMwL2xuJl3nIfTvmdNzDl7l16s85kzTzFwgNjPZ3S30KBypUDLjMQNEUZ5y2mrarrUQyQMhUAHHfIEMgByTcZentWvOM44+cUvMIrzRXMtmXZCdtLFcNaENfdyszW8X1FOku+GYtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415870; c=relaxed/simple;
	bh=nS3g3IO6g4kpjFuYgFS0r2MaqCgjqqWaiyKbAGl8kfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUvbGxT4lvqMEhdTZ8Ym8sg6R2ak3wYg3Q/awZDBuXVHyufbO75/q9uHvAzhCOCd+zqsw1xUxlKibBWQaf6X4MuFdYPEpUudiJyGuO67B4CUFJJCaAte2bYoQ3PNkpVm6Pdz3WtVTINM/aeCJw/ma3tGm5F1aQzoJM5xwXl7xH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmfGbg/6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711415867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z83ENibvHU77eICe9oHQhl7ufx89U3OzknCbyRwqPnU=;
	b=OmfGbg/6HJPSw5xip77YTzxCtsuVn4gni0SyirUmDqiLk8Iu1nyZ2QwiBq0M0fkN2mnBRX
	rN5mXqEuU36Zcm29HqXif5YVo3O0oaz+0yalohfiqNJAvtCDq0CU6ra+ftTVTTFHqfGlxx
	90CjbpDTSzNCi830iiZskvvU1SGF50M=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-x7hvShVjM1K4FUi3wCmKig-1; Mon, 25 Mar 2024 21:17:46 -0400
X-MC-Unique: x7hvShVjM1K4FUi3wCmKig-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so3399754a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 18:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711415865; x=1712020665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z83ENibvHU77eICe9oHQhl7ufx89U3OzknCbyRwqPnU=;
        b=Yo1GfEcjf1+99PYOqiL51+NPZvU9Qqk5XIkE2MjYjv+di1zxPtJf+Zla/LDgECzqTh
         2mV92oROkWxsx3m1NxWB8dvtmjFHt9VmZQlJaacEC8vx1NCTBuy+GvY1yUh8YC5f6bJ3
         ajp6ta9sf6KRkFsjjVN4aODTP6TUOGKvt8h0zMhWui5WfQXofLCpOjLdY+DB94Yn0SmR
         S2Db2VoAe58dnFVhqk7ywkKU0Hk2wI4lUWnIpKBM2a7k/e4qF28qJbjKMemWpEvGaH+y
         Cfoe/lti5vU2IbN1jLDHVASDSKHvNHpBf+hOGREjs6C2Z6qF08fY3NK8Q6hn4GUyRpsr
         PRPg==
X-Forwarded-Encrypted: i=1; AJvYcCXF4ly7bZPkgWMB8Vu/ISLQog+mWHWLRS1DOlxzk5dN9XOjMS7ChywnZ2j8pPSayzi9rw+X/j3O+IuHyRZHhElHC8u6rVnPpJ3AsfQYyQ==
X-Gm-Message-State: AOJu0YzU9vktZxJLUcmq6LZaUls/KT34WRbnbupg6ouZ/GwQwEf5B9Eh
	jjNHgimh5NdKLDVhRijJlw5zJHJkDEDPG7cNbUnwQHc796/v6P1PWkkkRcdd+TClQauPYs4KdJG
	FzgxXgArMaszIz0z+7Cmmlce3qPSBVuMny+yk3PwVxGBKvM24lmsOxikZWXOyrjE=
X-Received: by 2002:a05:6a20:9148:b0:1a3:bd8a:f20 with SMTP id x8-20020a056a20914800b001a3bd8a0f20mr8973785pzc.49.1711415865207;
        Mon, 25 Mar 2024 18:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeN4RiN3pn5S3CZwVwGlQPlumf3LscM7nr6fujiPlOhaCHS0Q1N54KdaYd4GEIXklWX3bpOg==
X-Received: by 2002:a05:6a20:9148:b0:1a3:bd8a:f20 with SMTP id x8-20020a056a20914800b001a3bd8a0f20mr8973774pzc.49.1711415864849;
        Mon, 25 Mar 2024 18:17:44 -0700 (PDT)
Received: from [10.72.112.68] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902700a00b001ddb505d50asm5414251plk.244.2024.03.25.18.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 18:17:44 -0700 (PDT)
Message-ID: <cd2f027c-b20e-4ea1-87f5-c0fa41180595@redhat.com>
Date: Tue, 26 Mar 2024 09:17:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
Content-Language: en-US
To: Ilya Dryomov <idryomov@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ceph Development <ceph-devel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
 <f453061e-6e01-4ad7-8fc6-a39108beacfc@redhat.com>
 <d689e8bf-6628-499e-8a11-c74ce1b1fd8b@redhat.com>
 <6f5b9d18-2d04-495c-970c-eb5eada5f676@redhat.com>
 <CAOi1vP-yf=VNLpcRPnd7qwxkgsxUpnZYKUx96pJr+WMQeLwyvA@mail.gmail.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP-yf=VNLpcRPnd7qwxkgsxUpnZYKUx96pJr+WMQeLwyvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/26/24 03:37, Ilya Dryomov wrote:
> On Mon, Mar 25, 2024 at 6:39 PM David Hildenbrand <david@redhat.com> wrote:
>> On 25.03.24 13:06, Xiubo Li wrote:
>>> On 3/25/24 18:14, David Hildenbrand wrote:
>>>> On 25.03.24 08:45, Xiubo Li wrote:
>>>>> Hi guys,
>>>>>
>>>>> We are hitting the same crash frequently recently with the latest kernel
>>>>> when testing kceph, and the call trace will be something likes:
>>>>>
>>>>> [ 1580.034891] usercopy: Kernel memory exposure attempt detected from
>>>>> SLUB object 'kmalloc-192' (offset 82, size 499712)!^M
>>>>> [ 1580.045866] ------------[ cut here ]------------^M
>>>>> [ 1580.050551] kernel BUG at mm/usercopy.c:102!^M
>>>>> ^M
>>>>> Entering kdb (current=0xffff8881211f5500, pid 172901) on processor 4
>>>>> Oops: (null)^M
>>>>> due to oops @ 0xffffffff8138cabd^M
>>>>> CPU: 4 PID: 172901 Comm: fsstress Tainted: G S 6.6.0-g623393c9d50c #1^M
>>>>> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015^M
>>>>> RIP: 0010:usercopy_abort+0x6d/0x80^M
>>>>> Code: 4c 0f 44 d0 41 53 48 c7 c0 1c e9 13 82 48 c7 c6 71 62 13 82 48 0f
>>>>> 45 f0 48 89 f9 48 c7 c7 f0 6b 1b 82 4c 89 d2 e8 63 2b df ff <0f> 0b 49
>>>>> c7 c1 44 c8 14 82 4d 89 cb 4d 89 c8 eb a5 66 90 f3 0f 1e^M
>>>>> RSP: 0018:ffffc90006dfba88 EFLAGS: 00010246^M
>>>>> RAX: 000000000000006a RBX: 000000000007a000 RCX: 0000000000000000^M
>>>>> RDX: 0000000000000000 RSI: ffff88885fd1d880 RDI: ffff88885fd1d880^M
>>>>> RBP: 000000000007a000 R08: 0000000000000000 R09: c0000000ffffdfff^M
>>>>> R10: 0000000000000001 R11: ffffc90006dfb930 R12: 0000000000000001^M
>>>>> R13: ffff8882b7bbed12 R14: ffff88827a375830 R15: ffff8882b7b44d12^M
>>>>> FS:  00007fb24c859500(0000) GS:ffff88885fd00000(0000)
>>>>> knlGS:0000000000000000^M
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>>>>> CR2: 000055c2bcf9eb00 CR3: 000000028956c005 CR4: 00000000001706e0^M
>>>>> Call Trace:^M
>>>>>      <TASK>^M
>>>>>      ? kdb_main_loop+0x32c/0xa10^M
>>>>>      ? kdb_stub+0x216/0x420^M
>>>>> more>
>>>>>
>>>>> You can see more detail in ceph tracker
>>>>> https://tracker.ceph.com/issues/64471.
>>>> Where is the full backtrace? Above contains only the backtrace of kdb.
>>>>
>>> Hi David,
>>>
>>> The bad news is that there is no more backtrace. All the failures we hit
>>> are similar with the following logs:
>>>
>> That's unfortunate :/
>>
>> "exposure" in the message means we are in copy_to_user().
>>
>> SLUB object 'kmalloc-192' means that we come from __check_heap_object()
>> ... we have 192 bytes, but the length we want to access is 499712 ...
>> 488 KiB.
>>
>> So we ended  up somehow in
>>
>> __copy_to_user()->check_object_size()->__check_object_size()->
>> check_heap_object()->__check_heap_object()->usercopy_abort()
>>
>>
>> ... but the big question is which code tried to copy way too much memory
>> out of a slab folio to user space.
>>
>>>> That link also contains:
>>>>
>>>> Entering kdb (current=0xffff9115d14fb980, pid 61925) on processor 5
>>>> Oops: (null)^M
>>>> due to oops @ 0xfffffffface3a1d2^M
>>>> CPU: 5 PID: 61925 Comm: ld Kdump: loaded Not tainted
>>>> 5.14.0-421.el9.x86_64 #1^M
>>>> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015^M
>>>> RIP: 0010:usercopy_abort+0x74/0x76^M
>>>> Code: 14 74 ad 51 48 0f 44 d6 49 c7 c3 cb 9f 73 ad 4c 89 d1 57 48 c7
>>>> c6 60 83 75 ad 48 c7 c7 00 83 75 ad 49 0f 44 f3 e8 1b 3b ff ff <0f> 0b
>>>> 0f b6 d3 4d 89 e0 48 89 e9 31 f6 48 c7 c7 7f 83 75 ad e8 73^M
>>>> RSP: 0018:ffffbb97c16af8d0 EFLAGS: 00010246^M
>>>> RAX: 0000000000000072 RBX: 0000000000000112 RCX: 0000000000000000^M
>>>> RDX: 0000000000000000 RSI: ffff911d1fd60840 RDI: ffff911d1fd60840^M
>>>> RBP: 0000000000004000 R08: 80000000ffff84b4 R09: 0000000000ffff0a^M
>>>> R10: 0000000000000004 R11: 0000000000000076 R12: ffff9115c0be8b00^M
>>>> R13: 0000000000000001 R14: ffff911665df9f68 R15: ffff9115d16be112^M
>>>> FS:  00007ff20442eb80(0000) GS:ffff911d1fd40000(0000)
>>>> knlGS:0000000000000000^M
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>>>> CR2: 00007ff20446142d CR3: 00000001215ec003 CR4: 00000000003706e0^M
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
>>>> Call Trace:^M
>>>>    <TASK>^M
>>>>    ? show_trace_log_lvl+0x1c4/0x2df^M
>>
>> ... are we stuck in show_trace_log_lvl(), probably deadlocked not being
>> able to print the actuall callstack? If so, that's nasty.
> Hi David,
>
> I don't think so.  This appears to be a cut-and-paste from what is
> essentially a non-interactive serial console.  Stack trace entries
> prefixed with ? aren't exact and kdb prompt
>
>      more>
>
> is there in all cases which is what hides the rest of the stack.
>
> There are four ways to get the entire stack trace here:
>
> a) try to attach to the serial console and interact with kdb -- this
>     is very much hit or miss due to general IPMI/BMC unreliability and
>     the fact that it would be already attached to for logging
> b) disable kdb by passing "kdb: false" in the job definition -- this
>     should result in /sys/module/kgdboc/parameters/kgdboc cleared after
>     booting into the kernel under test (or just hack teuthology to not
>     pass "kdb: true" which it does by default if "-k <kernel>" is given
>     when scheduling)
> c) if b) fails, rebuild the kernel with kdb disabled in Kconfig
> d) configure kdump and grab a vmcore -- these is no teuthology support
>     for this, so it would be challenging but would provide the most data
>     to chew on
>
> Xiubo, I'd recommend going with b), but take your pick ;)

Thanks Ilya

Let's try the b) first and to see could we find something new.

Thanks

- Xiubo


> Thanks,
>
>                  Ilya
>


