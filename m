Return-Path: <linux-fsdevel+bounces-15207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C988AC86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DE4B2B3DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706F15622C;
	Mon, 25 Mar 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMB97Uh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2515ADA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368395; cv=none; b=izdvMsqJLvOUHt1g4RvWdEme+e4pWwEmyZ2/5VSXFgdPsGLFNCcjoQ+SLKIKPIVN/xeOfTBMT7gIIxkR8qZAzy0rXuDV5896VNYPXZBI2jhMuK9Uv66atphYAeJTFiGK5vc7RwALnqPuIOjYfFMaVi2cg+hvGS+iJeIZUcJCjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368395; c=relaxed/simple;
	bh=eNox4JDLxjRcdKAY6u8p7GLm+HSVRhmcVFuNTCswa5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQHQJyep5lcgGOuaHQR3q0oNRK+f7bzlSXOq8x2f2UTovzL86Cd+KJo2kjHZxYjI4cJY8P7/cRVWk9XO1YnXeAiOZ4fboi/j9vpDG5faloxaPrric9ZczRkGpcT5uPl9Xb2RFb9J8N/xFMwVLyKFpB7m+3gAjvgV8B1DTXUZYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMB97Uh2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711368392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lABgZk1lZQSYt/QBieB81J/7DIqjyOEer6Pj6qRVXso=;
	b=XMB97Uh2Kt5T0KGXzbGgcdnJZItgPJhXlxz7YzG3E8uBz62EACgCpK8eWqvjeJFDQaNFi7
	7tY3RjH9Sd5wPxwFyvUFMehFHPeTb8ZegB33d6mpkmNdJOcoO+qmMWF4cD5wP4u/OIJGBK
	awPMNHPCpMjlpFdsm6I6iDMO2cLrLaQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-RfzrsMnDO9uhwRLMnp_rOg-1; Mon, 25 Mar 2024 08:06:31 -0400
X-MC-Unique: RfzrsMnDO9uhwRLMnp_rOg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df9eab3d4so3420969a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 05:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711368390; x=1711973190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lABgZk1lZQSYt/QBieB81J/7DIqjyOEer6Pj6qRVXso=;
        b=OTAitfQ9e7I8+01m5Jd50g2Hgd261zfvpXncDd/PhXkR1FhIVLb3OyHsQoHLp+lTsd
         bgl92lDeSaP/FxIPK9vvQCUDhm1+sm+9IeAHzfxVwhRrZpK3C0PzNWfc7x0byKwhUaWV
         FQCcsIQW+U5wMwEdngtxrcHalNeoaxMv3DokIUoXOp/HCoM60ENAOPPN+BuQV1sFSSKU
         pSYvNMQunnIK2al52aGuZ5vvvNknnP8kWBiEUQSa6BopoetqsXcNmCnslwCRxFquo2h0
         YjrrnOErJvUCTlUunSLL3KuQfwdgknhVppOYBD6oNwofwsMLZmX3+JG+a3LvMe69PTNB
         DHiA==
X-Forwarded-Encrypted: i=1; AJvYcCUAgVrqlEy14WcTr4m2H0LGVMY0v/dgEAmBkErvw9HV3S9S5xF46E8dAg7OT1Q55hIp/gegkTYbbu7ZFLAO9G2VcHj0TB3suX5PPyI2ig==
X-Gm-Message-State: AOJu0Yx4W83lvTwX+0UvJKsWUytESfWDes9Z23I59XZKVRPEWVfdTjgH
	lSqPrGR8NGLk/Gcog7TZasgadj4o+/FKMamsp4fNlqlG6dFDPcmsKYiOy7duWAdsl63fORrmZVi
	L1NB2lsPrs6T3aDyr+9yVmNV138qa9W/z3uvXIGEQlhzXv2kI8S8VMl+mqMvGYNs=
X-Received: by 2002:a17:90a:9c11:b0:29d:32cf:aa6c with SMTP id h17-20020a17090a9c1100b0029d32cfaa6cmr4476363pjp.39.1711368390093;
        Mon, 25 Mar 2024 05:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyTnJUnpYX8fPYbpu6w+XJvMLSC+arGJrhhX/5JdOZw7aOSECjPeA/zF0c0nIEtpoOjsjD3g==
X-Received: by 2002:a17:90a:9c11:b0:29d:32cf:aa6c with SMTP id h17-20020a17090a9c1100b0029d32cfaa6cmr4476344pjp.39.1711368389729;
        Mon, 25 Mar 2024 05:06:29 -0700 (PDT)
Received: from [10.72.113.22] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pd4-20020a17090b1dc400b002a064133d87sm2451676pjb.12.2024.03.25.05.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:06:29 -0700 (PDT)
Message-ID: <d689e8bf-6628-499e-8a11-c74ce1b1fd8b@redhat.com>
Date: Mon, 25 Mar 2024 20:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
References: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
 <f453061e-6e01-4ad7-8fc6-a39108beacfc@redhat.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <f453061e-6e01-4ad7-8fc6-a39108beacfc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/25/24 18:14, David Hildenbrand wrote:
> On 25.03.24 08:45, Xiubo Li wrote:
>> Hi guys,
>>
>> We are hitting the same crash frequently recently with the latest kernel
>> when testing kceph, and the call trace will be something likes:
>>
>> [ 1580.034891] usercopy: Kernel memory exposure attempt detected from
>> SLUB object 'kmalloc-192' (offset 82, size 499712)!^M
>> [ 1580.045866] ------------[ cut here ]------------^M
>> [ 1580.050551] kernel BUG at mm/usercopy.c:102!^M
>> ^M
>> Entering kdb (current=0xffff8881211f5500, pid 172901) on processor 4
>> Oops: (null)^M
>> due to oops @ 0xffffffff8138cabd^M
>> CPU: 4 PID: 172901 Comm: fsstress Tainted: G S 6.6.0-g623393c9d50c #1^M
>> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015^M
>> RIP: 0010:usercopy_abort+0x6d/0x80^M
>> Code: 4c 0f 44 d0 41 53 48 c7 c0 1c e9 13 82 48 c7 c6 71 62 13 82 48 0f
>> 45 f0 48 89 f9 48 c7 c7 f0 6b 1b 82 4c 89 d2 e8 63 2b df ff <0f> 0b 49
>> c7 c1 44 c8 14 82 4d 89 cb 4d 89 c8 eb a5 66 90 f3 0f 1e^M
>> RSP: 0018:ffffc90006dfba88 EFLAGS: 00010246^M
>> RAX: 000000000000006a RBX: 000000000007a000 RCX: 0000000000000000^M
>> RDX: 0000000000000000 RSI: ffff88885fd1d880 RDI: ffff88885fd1d880^M
>> RBP: 000000000007a000 R08: 0000000000000000 R09: c0000000ffffdfff^M
>> R10: 0000000000000001 R11: ffffc90006dfb930 R12: 0000000000000001^M
>> R13: ffff8882b7bbed12 R14: ffff88827a375830 R15: ffff8882b7b44d12^M
>> FS:  00007fb24c859500(0000) GS:ffff88885fd00000(0000)
>> knlGS:0000000000000000^M
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>> CR2: 000055c2bcf9eb00 CR3: 000000028956c005 CR4: 00000000001706e0^M
>> Call Trace:^M
>>    <TASK>^M
>>    ? kdb_main_loop+0x32c/0xa10^M
>>    ? kdb_stub+0x216/0x420^M
>> more>
>>
>> You can see more detail in ceph tracker
>> https://tracker.ceph.com/issues/64471.
>
> Where is the full backtrace? Above contains only the backtrace of kdb.
>
Hi David,

The bad news is that there is no more backtrace. All the failures we hit 
are similar with the following logs:


> That link also contains:
>
> Entering kdb (current=0xffff9115d14fb980, pid 61925) on processor 5 
> Oops: (null)^M
> due to oops @ 0xfffffffface3a1d2^M
> CPU: 5 PID: 61925 Comm: ld Kdump: loaded Not tainted 
> 5.14.0-421.el9.x86_64 #1^M
> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015^M
> RIP: 0010:usercopy_abort+0x74/0x76^M
> Code: 14 74 ad 51 48 0f 44 d6 49 c7 c3 cb 9f 73 ad 4c 89 d1 57 48 c7 
> c6 60 83 75 ad 48 c7 c7 00 83 75 ad 49 0f 44 f3 e8 1b 3b ff ff <0f> 0b 
> 0f b6 d3 4d 89 e0 48 89 e9 31 f6 48 c7 c7 7f 83 75 ad e8 73^M
> RSP: 0018:ffffbb97c16af8d0 EFLAGS: 00010246^M
> RAX: 0000000000000072 RBX: 0000000000000112 RCX: 0000000000000000^M
> RDX: 0000000000000000 RSI: ffff911d1fd60840 RDI: ffff911d1fd60840^M
> RBP: 0000000000004000 R08: 80000000ffff84b4 R09: 0000000000ffff0a^M
> R10: 0000000000000004 R11: 0000000000000076 R12: ffff9115c0be8b00^M
> R13: 0000000000000001 R14: ffff911665df9f68 R15: ffff9115d16be112^M
> FS:  00007ff20442eb80(0000) GS:ffff911d1fd40000(0000) 
> knlGS:0000000000000000^M
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> CR2: 00007ff20446142d CR3: 00000001215ec003 CR4: 00000000003706e0^M
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
> Call Trace:^M
>  <TASK>^M
>  ? show_trace_log_lvl+0x1c4/0x2df^M
> more>
>
>
> Don't we have more information about the calltrace somewhere? (or a 
> reproducer?)

There is no reproducer and each time the failure test cases are 
different. So it seems randomly.

Thanks

- Xiubo




