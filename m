Return-Path: <linux-fsdevel+bounces-19109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446E8C022E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 18:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C33281CE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADEBD524;
	Wed,  8 May 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQSbm6dW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338D4C6E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186639; cv=none; b=B5ekRiWPL+NyiTRlvC0e865TTDKxouKVouR0JtBfkRRbFY7x33D06uTvn9Z0vA30/ZFG2s9psp+Ph3fZnHZ96hFP4WzRBDywaNUCOJj5jGHmi3wEJBb0gHTVXPLzWD9Pzf8rVDZQYbqg0BNxPs7M65vZSlQELEh7ufnI+EcB/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186639; c=relaxed/simple;
	bh=v2O/JOXhGm7/O6sH0tL56gDuw0iqg3tR8svJJWlpQlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVEz/YCZ+TR0xixDStswrqthyKccj6nK7jcQKaQME8dnRHZ+r+njAMXFVYp7ZQ9Kec2uCYZNIH9E1QBIOA834Sh44j8usixQt6IS6dWvLFpEZErq/hC7w5lxKtVpkZnthaWC7WrW2HOqhbS6jKoBWRCbVDtgwmM34Lh8xLRpHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQSbm6dW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715186635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kfu+kNg5psV0QrTCz/mBUS9Pxutp2X9pNWB5lOfJe8k=;
	b=eQSbm6dWulaP85Yk5imWXlj7KLLpWy/MACeTusDH+I5aLpvqFrWAoUXi8VTPOSg5uueE+p
	Ec0jokjalY3vw9fq8+GmrxJ0dOb7j1SQ9HLaovEV4M1/iBxxNPFv7IYRxFcCNLAeVdeAUm
	/v5ChT2T/1iuWu2sA4n8PazuBlOk5o8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-0ayBmFgQM6SP2dAQ07ni8w-1; Wed, 08 May 2024 12:43:52 -0400
X-MC-Unique: 0ayBmFgQM6SP2dAQ07ni8w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418df23b51cso22945465e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 09:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186630; x=1715791430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfu+kNg5psV0QrTCz/mBUS9Pxutp2X9pNWB5lOfJe8k=;
        b=eK5h9swlbcYsbLz0ekx6XooEgm4ZzsoFEd3u+mTi/rwtqqv0IahScfWr9JUv0m0pCN
         xjeBW0E38w+Eldej+59Jjoy/kGhPi/HsLWUepjCtLHt63z/+HeQIGSdnu/ih+u5HqOrB
         +6/+SZ1rc9ysT3p3dHkGDdsgKKQYx3dxpBvJlGDjd2VbrlCAA+nC7bQ2u27zD82GuZCx
         KQm3ZxPcAydnboACgnDnWmsRCjuyyIY2LuEALdoljdzwup8nU4utPRDNf3c6Gw0k2faN
         hsBX8QKq5SH5H+u9wRtOZxKn/162u2kGN+BzGWzJMy7QUWkeHCjPfSMzNXXUttC0EZ7/
         KBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcj264rD05maN6JrcHH6ZrtGb3rrYN0KEnxrumE6NTq06Da7C/+SdkrN72AzUTesQHTBquq7eoM5UEqxxVsxEhVfiUN0andAuUX8TApg==
X-Gm-Message-State: AOJu0YwP/aPb7sY3PU9dyjgqlk1UyzwNGe6oxO21cOk77CQqwW3qfYir
	cVenGxhas4MI02tQu8ljPM0Din4N3RBQkg8swkr1DFWc/wCXAUzIGlYUY5NfCJusyO9bWtYvgZB
	k+zhYvAfa0RTR0tSoerOQ9Ik15DyqdKTT7plOlY57oUPZ6zorECtWpulULiqg5QI=
X-Received: by 2002:a05:600c:3507:b0:41a:f9db:88ac with SMTP id 5b1f17b1804b1-41f71cc4e9cmr25139285e9.14.1715186630458;
        Wed, 08 May 2024 09:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiXFhtgFYexLvlE9tUnQOpwikaBE/AJRGx0k+bYeHdn7M9LalM+i8Bs18/sw5TMREw1EkZEA==
X-Received: by 2002:a05:600c:3507:b0:41a:f9db:88ac with SMTP id 5b1f17b1804b1-41f71cc4e9cmr25139055e9.14.1715186629991;
        Wed, 08 May 2024 09:43:49 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882085dbsm29015445e9.41.2024.05.08.09.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:43:49 -0700 (PDT)
Message-ID: <417e4dc4-ea48-4d68-a441-f782f98a08fe@redhat.com>
Date: Wed, 8 May 2024 18:43:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Fix userfaultfd_api to return EINVAL as expected
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, raquini@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20240507195510.283744-1-audra@redhat.com>
 <939a16f2-7b66-45a6-a043-4821bd3c71dc@redhat.com> <Zjt3Apr8ILFA4oK_@fedora>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zjt3Apr8ILFA4oK_@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 14:58, Audra Mitchell wrote:
> On Wed, May 08, 2024 at 09:39:10AM +0200, David Hildenbrand wrote:
>> On 07.05.24 21:55, Audra Mitchell wrote:
>>> Currently if we request a feature that is not set in the Kernel
>>> config we fail silently and return the available features. However, the
>>> documentation indicates we should return an EINVAL.
>>
>> I assume you are referencing
>>
>> "EINVAL The API version requested in the api field is not supported by this
>> kernel, or  the  features  field passed to the kernel includes feature bits
>> that are not supported by the current kernel version."
>>
>> and
>>
>> "To  enable  userfaultfd features the application should set a bit
>> corresponding to each feature it wants to enable in the features field. If
>> the kernel supports all the requested features it will enable them.
>> Otherwise it will zero out the returned uffdio_api structure and return
>> EINVAL.
>> "
>>
>> in which case I agree.
> 
> Yep! I'm referencing the man page.

Might be worth just quoting the man page :)

>>> We need to fix this issue since we can end up with a Kernel warning
>>> should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
>>> a kernel with the config not set with this feature.
>>
>> Can you mention which exact one? Is it a WARN* or a pr_warn() ?
> 
> Here is the kernel warning I get:
> 

Thanks, it makes sense to add the first couple of lines of below to the 
patch description.

> [  200.803094] unrecognized swap entry 0x7c00000000000001
> [  200.808270] ------------[ cut here ]------------
> [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
> [  200.820738] Modules linked in: qrtr bridge stp llc rfkill sunrpc amd_atl intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm ipmi_ssif acpi_ipmi i2c_piix4 ipmi_si wmi_bmof dcdbas dell_smbios dell_wmi_descriptor ptdma ipmi_devintf rapl ipmi_msghandler acpi_power_meter pcspkr k10temp xfs libcrc32c sd_mod t10_pi mgag200 sg drm_kms_helper crct10dif_pclmul i2c_algo_bit ahci crc32_pclmul drm_shmem_helper libahci crc32c_intel drm i40e libata ghash_clmulni_intel tg3 ccp megaraid_sas sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod fuse
> [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
> [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
> [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> [  200.889595] Code: 83 fa 02 0f 86 44 01 00 00 83 f9 17 0f 84 e1 00 00 00 83 f9 1f 0f 84 d0 00 00 00 48 89 c6 48 c7 c7 00 e4 dd bb e8 73 a2 de ff <0f> 0b e9 44 fd ff ff 45 0f b6 44 24 20 41 f6 c0 f4 75 27 4c 89 ee
> [  200.908348] RSP: 0018:ffffa18d2e6c37c8 EFLAGS: 00010246
> [  200.913584] RAX: 000000000000002a RBX: 00007f26d3600000 RCX: 0000000000000000
> [  200.920730] RDX: 0000000000000000 RSI: ffff93503f9a0bc0 RDI: ffff93503f9a0bc0
> [  200.927867] RBP: 00007f26d35cc000 R08: 0000000000000000 R09: ffffa18d2e6c3688
> [  200.935009] R10: ffffa18d2e6c3680 R11: ffffffffbc9de448 R12: ffffa18d2e6c39e8
> [  200.942149] R13: ffff92d1ebc15b50 R14: ffff93114e0cde60 R15: ffffa18d2e6c3928
> [  200.949291] FS:  0000000000000000(0000) GS:ffff93503f980000(0000) knlGS:0000000000000000
> [  200.957384] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  200.963140] CR2: 00007f26b1600658 CR3: 00000040905ba000 CR4: 0000000000350ef0
> [  200.970283] Call Trace:
> [  200.972745]  <TASK>
> [  200.974862]  ? __warn+0x7f/0x130
> [  200.978108]  ? zap_pte_range+0x43d/0x660
> [  200.982044]  ? report_bug+0x18a/0x1a0
> [  200.985720]  ? handle_bug+0x3c/0x70
> [  200.989219]  ? exc_invalid_op+0x14/0x70
> [  200.993068]  ? asm_exc_invalid_op+0x16/0x20
> [  200.997265]  ? zap_pte_range+0x43d/0x660
> [  201.001199]  ? zap_pte_range+0x43d/0x660
> [  201.005134]  zap_pmd_range.isra.0+0xf9/0x230
> [  201.009416]  unmap_page_range+0x2d4/0x4a0
> [  201.013436]  unmap_vmas+0xa8/0x180
> [  201.016854]  exit_mmap+0xea/0x3b0
> [  201.020191]  __mmput+0x43/0x120
> [  201.023342]  exit_mm+0xb1/0x110
> [  201.026496]  do_exit+0x270/0x4f0
> [  201.029739]  do_group_exit+0x2c/0x80
> [  201.033326]  get_signal+0x886/0x8b0
> [  201.036828]  ? srso_return_thunk+0x5/0x5f
> [  201.040848]  arch_do_signal_or_restart+0x25/0x100
> [  201.045563]  ? srso_return_thunk+0x5/0x5f
> [  201.049583]  ? vma_set_page_prot+0x5e/0xc0
> [  201.053692]  ? srso_return_thunk+0x5/0x5f
> [  201.057713]  ? syscall_exit_work+0xff/0x130
> [  201.061908]  syscall_exit_to_user_mode+0x1b3/0x200
> [  201.066712]  do_syscall_64+0x87/0x160
> [  201.070387]  ? srso_return_thunk+0x5/0x5f
> [  201.074405]  ? do_mmap+0x416/0x5f0
> [  201.077821]  ? srso_return_thunk+0x5/0x5f
> [  201.081840]  ? rseq_get_rseq_cs+0x1d/0x240
> [  201.085950]  ? srso_return_thunk+0x5/0x5f
> [  201.089970]  ? rseq_ip_fixup+0x6d/0x1d0
> [  201.093823]  ? vm_mmap_pgoff+0x117/0x1a0
> [  201.097755]  ? srso_return_thunk+0x5/0x5f
> [  201.101776]  ? srso_return_thunk+0x5/0x5f
> [  201.105795]  ? syscall_exit_to_user_mode+0x78/0x200
> [  201.110685]  ? srso_return_thunk+0x5/0x5f
> [  201.114706]  ? do_syscall_64+0x87/0x160
> [  201.118557]  ? srso_return_thunk+0x5/0x5f
> [  201.122575]  ? __count_memcg_events+0x49/0xb0
> [  201.126944]  ? srso_return_thunk+0x5/0x5f
> [  201.130967]  ? srso_return_thunk+0x5/0x5f
> [  201.134986]  ? syscall_exit_work+0xff/0x130
> [  201.139184]  ? srso_return_thunk+0x5/0x5f
> [  201.143205]  ? syscall_exit_to_user_mode+0x78/0x200
> [  201.148093]  ? srso_return_thunk+0x5/0x5f
> [  201.152114]  ? do_syscall_64+0x87/0x160
> [  201.155960]  ? srso_return_thunk+0x5/0x5f
> [  201.159984]  ? sched_clock_cpu+0xb/0x190
> [  201.163916]  ? srso_return_thunk+0x5/0x5f
> [  201.167939]  ? irqtime_account_irq+0x40/0xc0
> [  201.172220]  ? srso_return_thunk+0x5/0x5f
> [  201.176243]  ? srso_return_thunk+0x5/0x5f
> [  201.180263]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  201.185326] RIP: 0033:0x7f26dfd0735b
> [  201.188939] Code: Unable to access opcode bytes at 0x7f26dfd07331.
> [  201.195128] RSP: 002b:00007fffce176868 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
> [  201.202700] RAX: fffffffffffffffc RBX: 00007f26dfe60000 RCX: 00007f26dfd0735b
> [  201.209841] RDX: 0000000000000003 RSI: 0000000001000000 RDI: 00007f26af401000
> [  201.216983] RBP: 00007f26b0400640 R08: 00000000ffffffff R09: 0000000000000000
> [  201.224127] R10: ffffffffffffffc0 R11: 0000000000000206 R12: 0000000000000000
> [  201.231267] R13: 000000000040d320 R14: 0000000000000000 R15: 0000000000000000
> [  201.238413]  </TASK>
> [  201.240610] ---[ end trace 0000000000000000 ]---
> [  201.245250] unrecognized swap entry 0x7c00000000000001
> 
> 
> 
>>
>> Likely we want "Fixes:" here.
> 
> This could be seen as a continuation of the problem
> 2ff559f31a5d Revert "userfaultfd: don't fail on unrecognized features"
> was trying to solve. However, this patch only checks to make sure we didnt
> ask for a feature outside the possible range of features. We are still missing
> a check to confirm the requested features are also configured on. So I guess
> the "Fixes" tag would be for this patch?
> 914eedcb9ba0 userfaultfd: don't fail on unrecognized features
> 
> Happy to get your input here!

I agree with Peters summary :)

-- 
Cheers,

David / dhildenb


