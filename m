Return-Path: <linux-fsdevel+bounces-67717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD3C479BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36A23B9EA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DA26FA5B;
	Mon, 10 Nov 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0deuG2kE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D09248F47
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788983; cv=none; b=dObaWHcDJPx0YhLHyuOew+hrWCYgo2wGsQ6/2FUTW8HHrRZ+aQurLPBTmkE47q4AeYBL8smmarVSoeQ5wP0Yw38SJ0U+0huAEQUXGeFJKuC95khBHYmxS3a6s222GBb0gzD23uBp0XG9PQSP3o/vvVcFHzP6XpTLKlkckT8Ds/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788983; c=relaxed/simple;
	bh=6dsX1nap/ClvsXK7KrTRSd4Tz0PaTzKIHfmrOcuYTvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kei6x6Ye0CG4XMIlqZdycN1FT7kvh/ee7rk55LBEk15AMymc+fEKEPtJ2GkzMv1Ga8/pwHhDVF1fC+meaAF0zTv67CQRiUN54JfdBmCIepb13nAP9PwjaqghKVR2M+qvJ8+fgmu+j6WLbXgfVWS5UoCk5zHun854T/LB3lDL9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0deuG2kE; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b70a978cd51so425039766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762788978; x=1763393778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaWutXseEM49NYYHvmu1piLSnNhRd63IQT+QthHzxAo=;
        b=0deuG2kEWMF/6g9rM6XhekMoGiPnBy4VakFsAiejf9rhz3V8KsN5hO3bnoMNszQDxF
         hGugU0Xht6eooCGB4hqJxqwzQG0eU2bJRqxpEYT81pF3lTq74nFgYxZYDO9jG/V4wEhX
         xAGFZxaBJuVCCs7uibJ0/zJWnbH+DKM8RNOJcGkOQLcPla47UrQRtHFuKqmUnoMvms5T
         bf4+8vazv0d/JpAWQ9rBFcdBHnEoRsxCc7MwjJfdrARo6xrH75ImPXXy0dY3ZBFzFxP+
         YmnB02/VWJGgwzl3zBW0dADB2kP3k1zlmHZa1cMS93j8BfTZGxjsbjJVNlIws/E6zjab
         Ootw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788978; x=1763393778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaWutXseEM49NYYHvmu1piLSnNhRd63IQT+QthHzxAo=;
        b=komZJSiFjy3RB+ZalRGnuM30SCM6KkVs6QlmLIKTxHXAf0Omwym6QdILHvGJ00NwKm
         zWXmRxbTk3KaVeVac5g24EsZFLt7xH+qgsMAxWlT5GvNWLhFtoNqw1HlqpKpxZqQLgc2
         wP9Z9rZkyv/U9LkMUnjWhH61aOpmLW5TIAWtCpixieuX3nGgO8tjwjN5VBv5P/gkfCcH
         V8wLL4d+a+r9MdJpB9vdXx3VvKzQSIxOc2QIZcleFlvsOa0xSqFvoQeZGaTGcBbcOe5b
         tvdbOdKrYU4BZj/BgDBFfjyMEA1U9eTotmyN3EToWW7jPIqGJr0N7D3Y1dbv1vuGsvOh
         Ul8w==
X-Forwarded-Encrypted: i=1; AJvYcCU4EPrZ4nT1FzJi+FueAY3C4uw6qQe/pR584Nc8Z/BL6CF6T5u+T3Pu1GaV9YwYhdXP4ZKdTYlLbol76qCB@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGiC4qbzqMsWmegZzLFGUGgHYECMUK9bhhhaN2vMbSdIw0Zpw
	CLUL+Ua+3CuXri+tENsXxKQFZ8ZhZEVXjRaQTqcqbvnmSFXA4QzggZmISzUuUMF2ElvBTceViac
	zWZ1PeRbMIZD+TQ==
X-Google-Smtp-Source: AGHT+IHTU5FXzUFeb1nI9cPK796M7PgT3DwXYMV5kcA8PjpI6OADg2Z/FZfwu9WOGlr1GmkIIQ0Qzc++hauFnA==
X-Received: from ejcsq16.prod.google.com ([2002:a17:907:3890:b0:b72:b433:246f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:72c5:b0:b70:be84:5183 with SMTP id a640c23a62f3a-b72e0591830mr875999666b.60.1762788978060;
 Mon, 10 Nov 2025 07:36:18 -0800 (PST)
Date: Mon, 10 Nov 2025 15:36:17 +0000
In-Reply-To: <a940044f-3ae4-451f-b9ba-946ec6df5082@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
 <DE2L1SAOC55E.E4JY62WJQ2A8@google.com> <add94932-290c-4037-b4e6-c3c760240819@amazon.com>
 <DE2NTMZXQ1MT.2TH9VAKM6WP6I@google.com> <a940044f-3ae4-451f-b9ba-946ec6df5082@amazon.com>
X-Mailer: aerc 0.21.0
Message-ID: <DE54JGHVJ4QH.KW6CD73R58AU@google.com>
Subject: Re: [PATCH v7 00/12] Direct Map Removal Support for guest_memfd
From: Brendan Jackman <jackmanb@google.com>
To: <kalyazin@amazon.com>, Brendan Jackman <jackmanb@google.com>
Cc: <pbonzini@redhat.com>, <corbet@lwn.net>, <maz@kernel.org>, 
	<oliver.upton@linux.dev>, <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, 
	<yuzenghui@huawei.com>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>, 
	<luto@kernel.org>, <peterz@infradead.org>, <willy@infradead.org>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <lorenzo.stoakes@oracle.com>, 
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <song@kernel.org>, <jolsa@kernel.org>, 
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>, 
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jgg@ziepe.ca>, <jhubbard@nvidia.com>, 
	<peterx@redhat.com>, <jannh@google.com>, <pfalcato@suse.de>, 
	<shuah@kernel.org>, <seanjc@google.com>, <kvm@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>, 
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>, 
	<linux-kselftest@vger.kernel.org>, <xmarcalx@amazon.co.uk>, 
	<kalyazin@amazon.co.uk>, <jackabt@amazon.co.uk>, <derekmn@amazon.co.uk>, 
	<tabba@google.com>, <ackerleytng@google.com>, 
	Patrick Roy <patrick.roy@campus.lmu.de>
Content-Type: text/plain; charset="UTF-8"

On Fri Nov 7, 2025 at 6:11 PM UTC, Nikita Kalyazin wrote:
>
>
> On 07/11/2025 18:04, Brendan Jackman wrote:
>> On Fri Nov 7, 2025 at 5:23 PM UTC, Nikita Kalyazin wrote:
>>>
>>>
>>> On 07/11/2025 15:54, Brendan Jackman wrote:
>>>> On Wed Sep 24, 2025 at 3:10 PM UTC, Patrick Roy wrote:
>>>>> From: Patrick Roy <roypat@amazon.co.uk>
>>>>>
>>>>> [ based on kvm/next ]
>>>>>
>>>>> Unmapping virtual machine guest memory from the host kernel's direct map is a
>>>>> successful mitigation against Spectre-style transient execution issues: If the
>>>>> kernel page tables do not contain entries pointing to guest memory, then any
>>>>> attempted speculative read through the direct map will necessarily be blocked
>>>>> by the MMU before any observable microarchitectural side-effects happen. This
>>>>> means that Spectre-gadgets and similar cannot be used to target virtual machine
>>>>> memory. Roughly 60% of speculative execution issues fall into this category [1,
>>>>> Table 1].
>>>>>
>>>>> This patch series extends guest_memfd with the ability to remove its memory
>>>>> from the host kernel's direct map, to be able to attain the above protection
>>>>> for KVM guests running inside guest_memfd.
>>>>>
>>>>> Additionally, a Firecracker branch with support for these VMs can be found on
>>>>> GitHub [2].
>>>>>
>>>>> For more details, please refer to the v5 cover letter [v5]. No
>>>>> substantial changes in design have taken place since.
>>>>>
>>>>> === Changes Since v6 ===
>>>>>
>>>>> - Drop patch for passing struct address_space to ->free_folio(), due to
>>>>>     possible races with freeing of the address_space. (Hugh)
>>>>> - Stop using PG_uptodate / gmem preparedness tracking to keep track of
>>>>>     direct map state.  Instead, use the lowest bit of folio->private. (Mike, David)
>>>>> - Do direct map removal when establishing mapping of gmem folio instead
>>>>>     of at allocation time, due to impossibility of handling direct map
>>>>>     removal errors in kvm_gmem_populate(). (Patrick)
>>>>> - Do TLB flushes after direct map removal, and provide a module
>>>>>     parameter to opt out from them, and a new patch to export
>>>>>     flush_tlb_kernel_range() to KVM. (Will)
>>>>>
>>>>> [1]: https://download.vusec.net/papers/quarantine_raid23.pdf
>>>>> [2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
>>>>
>>>> I just got around to trying this out, I checked out this patchset using
>>>> its base-commit and grabbed the Firecracker branch. Things seem OK until
>>>> I set the secrets_free flag in the Firecracker config which IIUC makes
>>>> it set GUEST_MEMFD_FLAG_NO_DIRECT_MAP.
>>>>
>>>> If I set it, I find the guest doesn't show anything on the console.
>>>> Running it in a VM and attaching GDB suggests that it's entering the
>>>> guest repeatedly, it doesn't seem like the vCPU thread is stuck or
>>>> anything. I'm a bit clueless about how to debug that (so far, whenever
>>>> I've broken KVM, things always exploded very dramatically).
>>>>
>>>> Anyway, if I then kill the firecracker process, the host sometimes
>>>> crashes, I think this is the most suggestive splat I've seen:
>>>>
>>>> [   99.673420][    T2] BUG: unable to handle page fault for address: ffff888012804000
>>>> [   99.676216][    T2] #PF: supervisor write access in kernel mode
>>>> [   99.678381][    T2] #PF: error_code(0x0002) - not-present page
>>>> [   99.680499][    T2] PGD 2e01067 P4D 2e01067 PUD 2e02067 PMD 12801063 PTE 800fffffed7fb020
>>>> [   99.683374][    T2] Oops: Oops: 0002 [#1] SMP
>>>> [   99.685004][    T2] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.17.0-rc7-00366-g473c46a3cb2a #106 NONE
>>>> [   99.688514][    T2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.1 11/11/2019
>>>> [   99.691547][    T2] RIP: 0010:clear_page_erms+0x7/0x10
>>>> [   99.693440][    T2] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 66 0f 1f 44 00 00 48 83 f9 40 73 2a 83 f9 08 73 0f 85 c9
>>>> [   99.700188][    T2] RSP: 0018:ffff88800318fc10 EFLAGS: 00010246
>>>> [   99.702321][    T2] RAX: 0000000000000000 RBX: 0000000000400dc0 RCX: 0000000000001000
>>>> [   99.705100][    T2] RDX: ffffea00004a0100 RSI: ffffea00004a0200 RDI: ffff888012804000
>>>> [   99.707861][    T2] RBP: 0000000000000801 R08: 0000000000000000 R09: 0000000000000000
>>>> [   99.710648][    T2] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
>>>> [   99.713412][    T2] R13: 0000000000000801 R14: ffffea00004a0100 R15: ffffffff81f4df80
>>>> [   99.716191][    T2] FS:  0000000000000000(0000) GS:ffff8880bbf28000(0000) knlGS:0000000000000000
>>>> [   99.719316][    T2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   99.721648][    T2] CR2: ffff888012804000 CR3: 0000000007583001 CR4: 0000000000372eb0
>>>> [   99.724421][    T2] Call Trace:
>>>> [   99.725608][    T2]  <TASK>
>>>> [   99.726646][    T2]  get_page_from_freelist+0x6fe/0x14b0
>>>> [   99.728583][    T2]  ? fs_reclaim_acquire+0x43/0xe0
>>>> [   99.730325][    T2]  ? find_held_lock+0x2b/0x80
>>>> [   99.731965][    T2]  __alloc_frozen_pages_noprof+0x147/0x2d0
>>>> [   99.734003][    T2]  __alloc_pages_noprof+0x5/0x50
>>>> [   99.735766][    T2]  copy_process+0x1b1/0x1b30
>>>> [   99.737398][    T2]  ? lock_is_held_type+0x89/0x100
>>>> [   99.739157][    T2]  ? kthreadd+0x25/0x190
>>>> [   99.740664][    T2]  kernel_clone+0x59/0x390
>>>> [   99.742213][    T2]  ? kthreadd+0x25/0x190
>>>> [   99.743728][    T2]  kernel_thread+0x55/0x70
>>>> [   99.745310][    T2]  ? kthread_complete_and_exit+0x20/0x20
>>>> [   99.747265][    T2]  kthreadd+0x117/0x190
>>>> [   99.748748][    T2]  ? kthread_is_per_cpu+0x30/0x30
>>>> [   99.750509][    T2]  ret_from_fork+0x16b/0x1e0
>>>> [   99.752193][    T2]  ? kthread_is_per_cpu+0x30/0x30
>>>> [   99.753992][    T2]  ret_from_fork_asm+0x11/0x20
>>>> [   99.755717][    T2]  </TASK>
>>>> [   99.756861][    T2] CR2: ffff888012804000
>>>> [   99.758353][    T2] ---[ end trace 0000000000000000 ]---
>>>> [   99.760319][    T2] RIP: 0010:clear_page_erms+0x7/0x10
>>>> [   99.762209][    T2] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 66 0f 1f 44 00 00 48 83 f9 40 73 2a 83 f9 08 73 0f 85 c9
>>>> [   99.769129][    T2] RSP: 0018:ffff88800318fc10 EFLAGS: 00010246
>>>> [   99.771297][    T2] RAX: 0000000000000000 RBX: 0000000000400dc0 RCX: 0000000000001000
>>>> [   99.774126][    T2] RDX: ffffea00004a0100 RSI: ffffea00004a0200 RDI: ffff888012804000
>>>> [   99.777013][    T2] RBP: 0000000000000801 R08: 0000000000000000 R09: 0000000000000000
>>>> [   99.779827][    T2] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
>>>> [   99.782641][    T2] R13: 0000000000000801 R14: ffffea00004a0100 R15: ffffffff81f4df80
>>>> [   99.785487][    T2] FS:  0000000000000000(0000) GS:ffff8880bbf28000(0000) knlGS:0000000000000000
>>>> [   99.788671][    T2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   99.791012][    T2] CR2: ffff888012804000 CR3: 0000000007583001 CR4: 0000000000372eb0
>>>> [   99.793863][    T2] Kernel panic - not syncing: Fatal exception
>>>> [   99.796760][    T2] Kernel Offset: disabled
>>>> [   99.798296][    T2] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>>
>>>> This makes me suspect the kvm_gmem_folio_restore_direct_map() path isn't
>>>> working or isn't getting called.
>>>>
>>>> If anyone wants help trying to reproduce this let me know.
>>>
>>> Hi Brendan,
>>>
>>> Thanks for trying to run it!
>>>
>>> Just as a sanity check, the way it is known for us to work is we apply
>>> all patches from [1].  For booted VMs (as opposed to restored from
>>> snapshot), apart from the v6 of the direct map removal series, the only
>>> additional patch is a fix for kvmclock on x86 [2].  Please let me know
>>> if you see the same issue with that patch applied too.
>>>
>>> Nikita
>>>
>>> [1]
>>> https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding/resources/hiding_ci/linux_patches
>>> [2]
>>> https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding/resources/hiding_ci/linux_patches/11-kvm-clock
>> 
>> Ah, thanks! Seems I should have checked my inbox before sending my other
>> mail. With the kvmclock fix applied to my host kernel, I start setting
>> the other crash immediately when the VM boots. If I comment out the
>> actual unmapping of memory, it boots (before, it wouldn't boot even with
>> that commented out).
>> 
>> For the other linux_patches, I couldn't apply them on top of this
>> series, do you have a branch I can use as a reference?
>
> Instead of having an explicit branch, we apply all the patches on top of 
> [1].  There is a script that performs fetch/build/install end-to-end: [2].
>
> [1] 
> https://github.com/firecracker-microvm/firecracker/blob/feature/secret-hiding/resources/hiding_ci/kernel_commit_hash
> [2] 
> https://github.com/firecracker-microvm/firecracker/blob/feature/secret-hiding/resources/hiding_ci/build_and_install_kernel.sh

Thanks, I was able to construct a branch and confirm the crashes go
away. I guess this should block merging the feature though, right? Do
you know which particular of the patches are the likely relevant ones
here?

