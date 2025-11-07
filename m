Return-Path: <linux-fsdevel+bounces-67463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B6C41089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD32561145
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09196334C1B;
	Fri,  7 Nov 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VXNDD4+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B83346AE;
	Fri,  7 Nov 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536239; cv=none; b=oyhLN/lQQC5515BZgIT+FyyisASibC1NxC4C3CUkkoioFQKkSATacLyHLtRfTHpb0gj0+MBQ6767WgEafdBjmrwcUEjYWZavegQcZMI7rUomsQIiK8LHjT0Daa0n+2D8iI9HL5eRlbqdl+g2W/syHkwbdIcnkQoJfJQl5qV2uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536239; c=relaxed/simple;
	bh=gLi7de/NPl4CutCbcHyElhUzdggKS3dZs6ObArdEYbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pBY/YOLQsObzD2Xz0+wxPWuM+cQMHIqeFbawDOb4SBBZLEKjpIwHOXPsVQ1SXLws+jOu7h5PvVhNeHPlv9WYwyXIusa/9DmBA4Gi6R/BKiisjlcl16ugDnXdfcZAUjXb7dDIoWxa4Z2VHvHBs1tUknTmVavqP/6D6KYyHt8Gwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VXNDD4+r; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762536237; x=1794072237;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=o6wcqFFajh7A/LsdWzRuMS1HeEL9V3ml4dPEALpSF3E=;
  b=VXNDD4+r6GivoVgSDwoaQ2BG1mDCQu9Kz/XtxJwu3+JAxNl/4tIbQXt1
   lK7I4q8XDmbi6yqthf6G7ycWBxErTbhHQnPOT2p3+tuzE0dCPS2V+pjmh
   7twctb5v+aqlGZCPRL3d+kuvK/d0fSeORtxnG0gqPkjHWVhoMdn2x+N+i
   Amw6Jv5CKq4k0VwdMgnOyaZvJj060oQMz5MkDVCnJxk6egIF6JhwJhMR2
   YFiekU1ToZeKwjFBTtolF/JNGy1AQCU/0cWVcJ92GpxdS75ur84D944dC
   x4UP/y1ldSO3/Kik/hmkeFBpR6DDUe/rs2tOJEVwtIGM2XWJJc4ekGhHv
   w==;
X-CSE-ConnectionGUID: hWjyRCz+SZyv1J236BTcDQ==
X-CSE-MsgGUID: J4rqY35IROKEYxpnVVSXaA==
X-IronPort-AV: E=Sophos;i="6.19,287,1754956800"; 
   d="scan'208";a="4849373"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:23:54 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:28723]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.74:2525] with esmtp (Farcaster)
 id 5bb66a71-c62c-4d84-9175-7e585abc3994; Fri, 7 Nov 2025 17:23:54 +0000 (UTC)
X-Farcaster-Flow-ID: 5bb66a71-c62c-4d84-9175-7e585abc3994
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 17:23:53 +0000
Received: from [192.168.9.244] (10.106.83.15) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 7 Nov 2025
 17:23:50 +0000
Message-ID: <add94932-290c-4037-b4e6-c3c760240819@amazon.com>
Date: Fri, 7 Nov 2025 17:23:49 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v7 00/12] Direct Map Removal Support for guest_memfd
To: Brendan Jackman <jackmanb@google.com>
CC: <pbonzini@redhat.com>, <corbet@lwn.net>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <joey.gouly@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <song@kernel.org>,
	<jolsa@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <jannh@google.com>,
	<pfalcato@suse.de>, <shuah@kernel.org>, <seanjc@google.com>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <xmarcalx@amazon.co.uk>,
	<kalyazin@amazon.co.uk>, <jackabt@amazon.co.uk>, <derekmn@amazon.co.uk>,
	<tabba@google.com>, <ackerleytng@google.com>, Patrick Roy
	<patrick.roy@campus.lmu.de>
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
 <DE2L1SAOC55E.E4JY62WJQ2A8@google.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <DE2L1SAOC55E.E4JY62WJQ2A8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUA001.ant.amazon.com (10.252.50.66) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 07/11/2025 15:54, Brendan Jackman wrote:
> On Wed Sep 24, 2025 at 3:10 PM UTC, Patrick Roy wrote:
>> From: Patrick Roy <roypat@amazon.co.uk>
>>
>> [ based on kvm/next ]
>>
>> Unmapping virtual machine guest memory from the host kernel's direct map is a
>> successful mitigation against Spectre-style transient execution issues: If the
>> kernel page tables do not contain entries pointing to guest memory, then any
>> attempted speculative read through the direct map will necessarily be blocked
>> by the MMU before any observable microarchitectural side-effects happen. This
>> means that Spectre-gadgets and similar cannot be used to target virtual machine
>> memory. Roughly 60% of speculative execution issues fall into this category [1,
>> Table 1].
>>
>> This patch series extends guest_memfd with the ability to remove its memory
>> from the host kernel's direct map, to be able to attain the above protection
>> for KVM guests running inside guest_memfd.
>>
>> Additionally, a Firecracker branch with support for these VMs can be found on
>> GitHub [2].
>>
>> For more details, please refer to the v5 cover letter [v5]. No
>> substantial changes in design have taken place since.
>>
>> === Changes Since v6 ===
>>
>> - Drop patch for passing struct address_space to ->free_folio(), due to
>>    possible races with freeing of the address_space. (Hugh)
>> - Stop using PG_uptodate / gmem preparedness tracking to keep track of
>>    direct map state.  Instead, use the lowest bit of folio->private. (Mike, David)
>> - Do direct map removal when establishing mapping of gmem folio instead
>>    of at allocation time, due to impossibility of handling direct map
>>    removal errors in kvm_gmem_populate(). (Patrick)
>> - Do TLB flushes after direct map removal, and provide a module
>>    parameter to opt out from them, and a new patch to export
>>    flush_tlb_kernel_range() to KVM. (Will)
>>
>> [1]: https://download.vusec.net/papers/quarantine_raid23.pdf
>> [2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
> 
> I just got around to trying this out, I checked out this patchset using
> its base-commit and grabbed the Firecracker branch. Things seem OK until
> I set the secrets_free flag in the Firecracker config which IIUC makes
> it set GUEST_MEMFD_FLAG_NO_DIRECT_MAP.
> 
> If I set it, I find the guest doesn't show anything on the console.
> Running it in a VM and attaching GDB suggests that it's entering the
> guest repeatedly, it doesn't seem like the vCPU thread is stuck or
> anything. I'm a bit clueless about how to debug that (so far, whenever
> I've broken KVM, things always exploded very dramatically).
> 
> Anyway, if I then kill the firecracker process, the host sometimes
> crashes, I think this is the most suggestive splat I've seen:
> 
> [   99.673420][    T2] BUG: unable to handle page fault for address: ffff888012804000
> [   99.676216][    T2] #PF: supervisor write access in kernel mode
> [   99.678381][    T2] #PF: error_code(0x0002) - not-present page
> [   99.680499][    T2] PGD 2e01067 P4D 2e01067 PUD 2e02067 PMD 12801063 PTE 800fffffed7fb020
> [   99.683374][    T2] Oops: Oops: 0002 [#1] SMP
> [   99.685004][    T2] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.17.0-rc7-00366-g473c46a3cb2a #106 NONE
> [   99.688514][    T2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.1 11/11/2019
> [   99.691547][    T2] RIP: 0010:clear_page_erms+0x7/0x10
> [   99.693440][    T2] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 66 0f 1f 44 00 00 48 83 f9 40 73 2a 83 f9 08 73 0f 85 c9
> [   99.700188][    T2] RSP: 0018:ffff88800318fc10 EFLAGS: 00010246
> [   99.702321][    T2] RAX: 0000000000000000 RBX: 0000000000400dc0 RCX: 0000000000001000
> [   99.705100][    T2] RDX: ffffea00004a0100 RSI: ffffea00004a0200 RDI: ffff888012804000
> [   99.707861][    T2] RBP: 0000000000000801 R08: 0000000000000000 R09: 0000000000000000
> [   99.710648][    T2] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [   99.713412][    T2] R13: 0000000000000801 R14: ffffea00004a0100 R15: ffffffff81f4df80
> [   99.716191][    T2] FS:  0000000000000000(0000) GS:ffff8880bbf28000(0000) knlGS:0000000000000000
> [   99.719316][    T2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   99.721648][    T2] CR2: ffff888012804000 CR3: 0000000007583001 CR4: 0000000000372eb0
> [   99.724421][    T2] Call Trace:
> [   99.725608][    T2]  <TASK>
> [   99.726646][    T2]  get_page_from_freelist+0x6fe/0x14b0
> [   99.728583][    T2]  ? fs_reclaim_acquire+0x43/0xe0
> [   99.730325][    T2]  ? find_held_lock+0x2b/0x80
> [   99.731965][    T2]  __alloc_frozen_pages_noprof+0x147/0x2d0
> [   99.734003][    T2]  __alloc_pages_noprof+0x5/0x50
> [   99.735766][    T2]  copy_process+0x1b1/0x1b30
> [   99.737398][    T2]  ? lock_is_held_type+0x89/0x100
> [   99.739157][    T2]  ? kthreadd+0x25/0x190
> [   99.740664][    T2]  kernel_clone+0x59/0x390
> [   99.742213][    T2]  ? kthreadd+0x25/0x190
> [   99.743728][    T2]  kernel_thread+0x55/0x70
> [   99.745310][    T2]  ? kthread_complete_and_exit+0x20/0x20
> [   99.747265][    T2]  kthreadd+0x117/0x190
> [   99.748748][    T2]  ? kthread_is_per_cpu+0x30/0x30
> [   99.750509][    T2]  ret_from_fork+0x16b/0x1e0
> [   99.752193][    T2]  ? kthread_is_per_cpu+0x30/0x30
> [   99.753992][    T2]  ret_from_fork_asm+0x11/0x20
> [   99.755717][    T2]  </TASK>
> [   99.756861][    T2] CR2: ffff888012804000
> [   99.758353][    T2] ---[ end trace 0000000000000000 ]---
> [   99.760319][    T2] RIP: 0010:clear_page_erms+0x7/0x10
> [   99.762209][    T2] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 66 0f 1f 44 00 00 48 83 f9 40 73 2a 83 f9 08 73 0f 85 c9
> [   99.769129][    T2] RSP: 0018:ffff88800318fc10 EFLAGS: 00010246
> [   99.771297][    T2] RAX: 0000000000000000 RBX: 0000000000400dc0 RCX: 0000000000001000
> [   99.774126][    T2] RDX: ffffea00004a0100 RSI: ffffea00004a0200 RDI: ffff888012804000
> [   99.777013][    T2] RBP: 0000000000000801 R08: 0000000000000000 R09: 0000000000000000
> [   99.779827][    T2] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [   99.782641][    T2] R13: 0000000000000801 R14: ffffea00004a0100 R15: ffffffff81f4df80
> [   99.785487][    T2] FS:  0000000000000000(0000) GS:ffff8880bbf28000(0000) knlGS:0000000000000000
> [   99.788671][    T2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   99.791012][    T2] CR2: ffff888012804000 CR3: 0000000007583001 CR4: 0000000000372eb0
> [   99.793863][    T2] Kernel panic - not syncing: Fatal exception
> [   99.796760][    T2] Kernel Offset: disabled
> [   99.798296][    T2] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> This makes me suspect the kvm_gmem_folio_restore_direct_map() path isn't
> working or isn't getting called.
> 
> If anyone wants help trying to reproduce this let me know.

Hi Brendan,

Thanks for trying to run it!

Just as a sanity check, the way it is known for us to work is we apply 
all patches from [1].  For booted VMs (as opposed to restored from 
snapshot), apart from the v6 of the direct map removal series, the only 
additional patch is a fix for kvmclock on x86 [2].  Please let me know 
if you see the same issue with that patch applied too.

Nikita

[1] 
https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding/resources/hiding_ci/linux_patches
[2] 
https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding/resources/hiding_ci/linux_patches/11-kvm-clock


