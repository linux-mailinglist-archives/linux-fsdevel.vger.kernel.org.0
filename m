Return-Path: <linux-fsdevel+bounces-15515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E4488FC16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211E41C2ED1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E6657C1;
	Thu, 28 Mar 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLmklekO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DE65BA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619455; cv=none; b=qZm0pwBXBFvkRANiFpOp21UbLfQmuGIRDDruE60UxqmNT/TPTO4yScSLN+SwTWsBg8a4O6Ck5n1/i2PfR6+aHt3h+oLCCXo4U/boq2DDlOo+3IaFhIQArzUciTlmx6kRV37VBNaH6RXHQrRha3K1goiHv9qcJ/e4A338/hwtz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619455; c=relaxed/simple;
	bh=IC+w1/aG7/S0e85a60pC7lSi5fxH02gmkfHkY/6WOcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLiwf2G6Mtn56b4jo5pmMrmU7RKoS92X/A7IJ3atKNQ/+rQDfHTnU0aaHsz7BpSi60L8MSfsd4dvyTCpbge5ovhS/Mev3Rvgo7D3IVPcK7KkPe5FeifE/JJpbZFGoSxjW2PAFOdRyqxC9qZJ+5pXSNdJUxyHfHbjJuQhgyRvn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLmklekO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711619450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nxtLpj+iBP9Xt1HHnMn0rZUp2jdjxbDETMue+PmYl4I=;
	b=aLmklekOFnozbxt++LYlBOC+UOL7k/BHqyPgkCanxiihydrYWahcfjS1lYNfyWFzDgrY9J
	TMubl7BefYT4XXnXmsRNTnF1sUYeBpzaquM7kiZ1a/ZH2YNx0V+lvpnbJVLSWGfveJrC6X
	3H8O+sxz9AyxLFEPlirtQ5IXHHapYjk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-fIRfT3zrPquD0d4CPgLYKw-1; Thu, 28 Mar 2024 05:50:49 -0400
X-MC-Unique: fIRfT3zrPquD0d4CPgLYKw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-341cdbcbd62so203154f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 02:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619448; x=1712224248;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxtLpj+iBP9Xt1HHnMn0rZUp2jdjxbDETMue+PmYl4I=;
        b=riVxcqmVW6YeIelcwQ3caVVCyQfKOd2bKV8LvBUUU/QqHo5//tIJ0LD1qMXFkVfuQc
         WAIXheFyqCryq+dvIR7VHItndy7hCyDYNo9shCFilFR+qi0/jMlLV/rovDZdPlj9OePW
         IYw1+/bszoIE2PwTjtIG5fqOyCrk7FqZ31qf7Lm8Jc+KXXiTy9b5H02fUYL633yhoDRN
         JSBbQN/7kF5+QCChnjui+YkKktEAUOwv9yLtutxzMZD7yN1KGT+NxBKuDzkz0ME7GPQP
         /Hwr6jVkNgLRI9crlW4Dff7AMFbP/wyTmjXcqcWf0kDtnmp/lWS+1T3SkzvyLLLTio6/
         goaw==
X-Forwarded-Encrypted: i=1; AJvYcCXcyp7sf5Uzn9VPpQZmuwqWubWy3ndYCe44Uz9HS+edruDuKF+HrQbPpQ4s9w9kjH+BsRDULU/o7qH0g79/3eCiMSV3XXNrz0lxqgMI5A==
X-Gm-Message-State: AOJu0YwMMUff4VbeB/52gC7WhIkpgBTXaqrWPo4WTIi6jFdJiNaVKylL
	dho+gQu4kIAhsgYaGfVZHAV7F1KNPFrS/dm/4GFg5svWKykGdwoGD3rtJiHdDuHdENJOp4JWtiO
	DZ+Fa02mbv8+bWvlDZMIeTtXklXNXCl16ixNWKwcaocC+Ow8ZpHhOlL/N7OIi10w=
X-Received: by 2002:a5d:6b87:0:b0:33e:7402:f4d3 with SMTP id n7-20020a5d6b87000000b0033e7402f4d3mr1830869wrx.33.1711619447553;
        Thu, 28 Mar 2024 02:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyrKrZ3N50ui+bWTg50EQbEelvWiqsIQ+BxNpbWjJq6gih2eNzSfvyD9RigouCStOuyiIO3g==
X-Received: by 2002:a5d:6b87:0:b0:33e:7402:f4d3 with SMTP id n7-20020a5d6b87000000b0033e7402f4d3mr1830833wrx.33.1711619447065;
        Thu, 28 Mar 2024 02:50:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:3600:8033:4189:6bd4:ea29? (p200300cbc7143600803341896bd4ea29.dip0.t-ipconnect.de. [2003:cb:c714:3600:8033:4189:6bd4:ea29])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5603000000b0033e03d37685sm1281329wrv.55.2024.03.28.02.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:50:46 -0700 (PDT)
Message-ID: <0e1dccfe-c181-444b-b124-05bec5cfd055@redhat.com>
Date: Thu, 28 Mar 2024 10:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Vineet Gupta <vgupta@kernel.org>, peterx <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Matt Turner <mattst88@gmail.com>,
 Alexey Brodkin <abrodkin@synopsys.com>
References: <20240327130538.680256-1-david@redhat.com> <ZgQ5hNltQ2DHQXps@x1n>
 <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
 <dc1433ea-4e59-4ab7-83fb-23b393020980@app.fastmail.com>
 <3360dba8-0fac-4126-b72b-abc036957d6a@kernel.org>
 <10da3ced-9a79-4ebb-a77d-1aa49cc61952@app.fastmail.com>
 <ZgUZCBNloC-grPWJ@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZgUZCBNloC-grPWJ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.03.24 08:15, Mike Rapoport wrote:
> On Thu, Mar 28, 2024 at 07:09:13AM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 28, 2024, at 06:51, Vineet Gupta wrote:
>>> On 3/27/24 09:22, Arnd Bergmann wrote:
>>>> On Wed, Mar 27, 2024, at 16:39, David Hildenbrand wrote:
>>>>> On 27.03.24 16:21, Peter Xu wrote:
>>>>>> On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
>>>>>>
>>>>>> I'm not sure what config you tried there; as I am doing some build tests
>>>>>> recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
>>>>>> avoid a lot of issues, I think it's due to libc missing.  But maybe not the
>>>>>> case there.
>>>>> CCin Arnd; I use some of his compiler chains, others from Fedora directly. For
>>>>> example for alpha and arc, the Fedora gcc is "13.2.1".
>>>>> But there is other stuff like (arc):
>>>>>
>>>>> ./arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
>>>>> ./arch/arc/include/asm/mmu-arcv2.h:82:9: error: implicit declaration of
>>>>> function 'write_aux_reg' [-Werro
>>>>> r=implicit-function-declaration]
>>>>>      82 |         write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
>>>>>         |         ^~~~~~~~~~~~~
>>>> Seems to be missing an #include of soc/arc/aux.h, but I can't
>>>> tell when this first broke without bisecting.
>>>
>>> Weird I don't see this one but I only have gcc 12 handy ATM.
>>>
>>>      gcc version 12.2.1 20230306 (ARC HS GNU/Linux glibc toolchain -
>>> build 1360)
>>>
>>> I even tried W=1 (which according to scripts/Makefile.extrawarn) should
>>> include -Werror=implicit-function-declaration but don't see this still.
>>>
>>> Tomorrow I'll try building a gcc 13.2.1 for ARC.
>>
>> David reported them with the toolchains I built at
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>> I'm fairly sure the problem is specific to the .config
>> and tree, not the toolchain though.
> 
> This happens with defconfig and both gcc 12.2.0 and gcc 13.2.0 from your
> crosstools. I also see these on the current Linus' tree:
> 
> arc/kernel/ptrace.c:342:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
> arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'arc_kprobe_handler' [-Wmissing-prototypes]
> 
> This fixed the warning about write_aux_reg for me, probably Vineet would
> want this include somewhere else...
> 
> diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
> index ed9036d4ede3..0fca342d7b79 100644
> --- a/arch/arc/include/asm/mmu-arcv2.h
> +++ b/arch/arc/include/asm/mmu-arcv2.h
> @@ -69,6 +69,8 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +#include <asm/arcregs.h>
> +
>   struct mm_struct;
>   extern int pae40_exist_but_not_enab(void);


Here are all err+warn I see with my configs on Linus' tree from today (not mm-unstable).
Most of them are warnings due to missing prototypes or missing "clone3".

Parisc64 seems to be a bit more broken. Maybe nobody cares about parisc64 anymore? Or
it's a toolchain issue, don't know.

xtensa is also broken, but "invalid register" smells like a toolchain issue to me.


Maybe all known/expected, just posting it if anybody cares. I can share my full build script
on request.



[INFO] Compiling alpha
[INFO] 0 errors
[INFO] 102 warnings
[PASS]

$ cat alpha_log  | grep warn
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/alpha/lib/checksum.c:45:9: warning: no previous prototype for 'csum_tcpudp_magic' [-Wmissing-prototypes]
arch/alpha/lib/checksum.c:54:8: warning: no previous prototype for 'csum_tcpudp_nofold' [-Wmissing-prototypes]
arch/alpha/lib/checksum.c:145:9: warning: no previous prototype for 'ip_fast_csum' [-Wmissing-prototypes]
arch/alpha/lib/checksum.c:163:8: warning: no previous prototype for 'csum_partial' [-Wmissing-prototypes]
arch/alpha/lib/checksum.c:180:9: warning: no previous prototype for 'ip_compute_csum' [-Wmissing-prototypes]
arch/alpha/kernel/traps.c:211:1: warning: no previous prototype for 'do_entArith' [-Wmissing-prototypes]
arch/alpha/kernel/traps.c:233:1: warning: no previous prototype for 'do_entIF' [-Wmissing-prototypes]
arch/alpha/kernel/traps.c:400:1: warning: no previous prototype for 'do_entDbg' [-Wmissing-prototypes]
arch/alpha/kernel/traps.c:436:1: warning: no previous prototype for 'do_entUna' [-Wmissing-prototypes]
arch/alpha/kernel/traps.c:721:1: warning: no previous prototype for 'do_entUnaUser' [-Wmissing-prototypes]
arch/alpha/mm/init.c:261:1: warning: no previous prototype for 'srm_paging_stop' [-Wmissing-prototypes]
arch/alpha/lib/fpreg.c:20:1: warning: no previous prototype for 'alpha_read_fp_reg' [-Wmissing-prototypes]
[....]

[INFO] Compiling arc
[INFO] 0 errors
[INFO] 2 warnings
[PASS]

$ cat arc_log  | grep warn
arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'arc_kprobe_handler' [-Wmissing-prototypes]


[INFO] Compiling hexagon
[INFO] 0 errors
[INFO] 1 warnings
[PASS]

  $ cat hexagon_log  | grep warn
<stdin>:1519:2: warning: syscall clone3 not implemented [-W#warnings]
  1519 | #warning syscall clone3 not implemented
1 warning generated.


[INFO] Compiling mips64
[INFO] 0 errors
[INFO] 15 warnings
[PASS]

  $ cat mips64_log  | grep warn
arch/mips/sibyte/bcm1480/setup.c:104:13: warning: no previous prototype for 'bcm1480_setup' [-Wmissing-prototypes]
arch/mips/sibyte/bcm1480/irq.c:200:13: warning: no previous prototype for 'init_bcm1480_irqs' [-Wmissing-prototypes]
arch/mips/sibyte/bcm1480/time.c:10:13: warning: no previous prototype for 'plat_time_init' [-Wmissing-prototypes]
arch/mips/sibyte/bcm1480/smp.c:49:6: warning: no previous prototype for 'bcm1480_smp_init' [-Wmissing-prototypes]
arch/mips/sibyte/bcm1480/smp.c:158:6: warning: no previous prototype for 'bcm1480_mailbox_interrupt' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/setup.c:59:5: warning: no previous prototype for 'swarm_be_handler' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/rtc_xicor1241.c:108:5: warning: no previous prototype for 'xicor_set_time' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/rtc_xicor1241.c:167:10: warning: no previous prototype for 'xicor_get_time' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/rtc_xicor1241.c:203:5: warning: no previous prototype for 'xicor_probe' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/rtc_m41t81.c:139:5: warning: no previous prototype for 'm41t81_set_time' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/rtc_m41t81.c:186:10: warning: no previous prototype for 'm41t81_get_time' [-Wmissing-prototypes]
arch/mips/sibyte/swarm/rtc_m41t81.c:219:5: warning: no previous prototype for 'm41t81_probe' [-Wmissing-prototypes]
arch/mips/mm/cerr-sb1.c:165:17: warning: no previous prototype for 'sb1_cache_error' [-Wmissing-prototypes]
arch/mips/kernel/cevt-bcm1480.c:96:6: warning: no previous prototype for 'sb1480_clockevent_init' [-Wmissing-prototypes]
arch/mips/kernel/csrc-bcm1480.c:37:13: warning: no previous prototype for 'sb1480_clocksource_init' [-Wmissing-prototypes]


[INFO] Compiling mips32-xpa
[INFO] 0 errors
[INFO] 1 warnings
[PASS]

$ cat mips32-xpa_log | grep warn
drivers/uio/uio.c:795:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]


[INFO] Compiling mips32-alchemy
[INFO] 0 errors
[INFO] 1 warnings
[PASS]

$ cat mips32-alchemy_log  | grep warn
drivers/net/ethernet/amd/au1000_eth.c:574:6: warning: no previous prototype for 'au1000_ReleaseDB' [-Wmissing-prototypes]


[INFO] Compiling nios2
[INFO] 0 errors
[INFO] 35 warnings
[PASS]

$ cat nios2_log | grep warn
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/nios2/lib/memcpy.c:160:7: warning: no previous prototype for 'memcpy' [-Wmissing-prototypes]
arch/nios2/lib/memcpy.c:194:7: warning: no previous prototype for 'memcpyb' [-Wmissing-prototypes]
arch/nios2/mm/dma-mapping.c:21:6: warning: no previous prototype for 'arch_sync_dma_for_device' [-Wmissing-prototypes]
arch/nios2/mm/dma-mapping.c:45:6: warning: no previous prototype for 'arch_sync_dma_for_cpu' [-Wmissing-prototypes]
arch/nios2/mm/dma-mapping.c:63:6: warning: no previous prototype for 'arch_dma_prep_coherent' [-Wmissing-prototypes]
arch/nios2/mm/dma-mapping.c:70:7: warning: no previous prototype for 'arch_dma_set_uncached' [-Wmissing-prototypes]
arch/nios2/kernel/irq.c:19:17: warning: no previous prototype for 'do_IRQ' [-Wmissing-prototypes]
arch/nios2/kernel/process.c:34:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
arch/nios2/kernel/process.c:43:6: warning: no previous prototype for 'machine_restart' [-Wmissing-prototypes]
arch/nios2/kernel/process.c:54:6: warning: no previous prototype for 'machine_halt' [-Wmissing-prototypes]
arch/nios2/kernel/process.c:66:6: warning: no previous prototype for 'machine_power_off' [-Wmissing-prototypes]
arch/nios2/kernel/process.c:152:6: warning: no previous prototype for 'dump' [-Wmissing-prototypes]
arch/nios2/kernel/process.c:253:16: warning: no previous prototype for 'nios2_clone' [-Wmissing-prototypes]
[...]


[INFO] Compiling parisc64
[INFO] 79 errors
[INFO] 54 warnings
[FAIL]

$ cat parisc64_log  | grep error
ipc/sem.c:1284:18: error: 'struct semid64_ds' has no member named 'sem_otime_high'; did you mean 'sem_otime'?
ipc/sem.c:1285:18: error: 'struct semid64_ds' has no member named 'sem_ctime_high'; did you mean 'sem_ctime'?
././include/linux/compiler_types.h:449:45: error: call to '__compiletime_assert_276' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct semid64_ds) != 80
ipc/msg.c:567:12: error: 'struct msqid64_ds' has no member named 'msg_stime_high'; did you mean 'msg_stime'?
ipc/msg.c:568:12: error: 'struct msqid64_ds' has no member named 'msg_rtime_high'; did you mean 'msg_rtime'?
ipc/msg.c:569:12: error: 'struct msqid64_ds' has no member named 'msg_ctime_high'; did you mean 'msg_ctime'?
ipc/shm.c:1137:15: error: 'struct shmid64_ds' has no member named 'shm_atime_high'; did you mean 'shm_atime'?
ipc/shm.c:1138:15: error: 'struct shmid64_ds' has no member named 'shm_dtime_high'; did you mean 'shm_dtime'?
ipc/shm.c:1139:15: error: 'struct shmid64_ds' has no member named 'shm_ctime_high'; did you mean 'shm_ctime'?
././include/linux/compiler_types.h:449:45: error: call to '__compiletime_assert_390' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __rcuref) & 63
././include/linux/compiler_types.h:449:45: error: call to '__compiletime_assert_374' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __rcuref) & 63
././include/linux/compiler_types.h:449:45: error: call to '__compiletime_assert_382' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __rcuref) & 63
[...]


[INFO] Compiling sh
[INFO] 0 errors
[INFO] 39 warnings
[PASS]

  $ cat sh_log | grep warn
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/sh/mm/cache-shx3.c:18:13: warning: no previous prototype for 'shx3_cache_init' [-Wmissing-prototypes]
arch/sh/mm/flush-sh4.c:106:13: warning: no previous prototype for 'sh4__flush_region_init' [-Wmissing-prototypes]
arch/sh/mm/cache-sh4.c:384:13: warning: no previous prototype for 'sh4_cache_init' [-Wmissing-prototypes]
arch/sh/kernel/return_address.c:49:7: warning: no previous prototype for 'return_address' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:10:6: warning: no previous prototype for 'pgd_ctor' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:32:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:37:6: warning: no previous prototype for 'pgd_free' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:43:6: warning: no previous prototype for 'pud_populate' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:48:8: warning: no previous prototype for 'pmd_alloc_one' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:53:6: warning: no previous prototype for 'pmd_free' [-Wmissing-prototypes]
arch/sh/mm/tlbex_32.c:22:1: warning: no previous prototype for 'handle_tlbmiss' [-Wmissing-prototypes]
arch/sh/kernel/sys_sh.c:58:16: warning: no previous prototype for 'sys_cacheflush' [-Wmissing-prototypes]
[...]


[INFO] Compiling sparc32
[INFO] 0 errors
[INFO] 1 warnings
[PASS]

$ cat sparc32_log | grep warn
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]


[INFO] Compiling sparc64
[INFO] 0 errors
[INFO] 26 warnings
[PASS]

$ cat sparc64_log | grep warn
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for 'init_vdso_image' [-Wmissing-prototypes]
arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype for '__vdso_clock_gettime_stick' [-Wmissing-prototypes]
arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype for '__vdso_gettimeofday_stick' [-Wmissing-prototypes]
arch/sparc/kernel/traps_64.c:253:6: warning: no previous prototype for 'is_no_fault_exception' [-Wmissing-prototypes]
arch/sparc/kernel/traps_64.c:2035:6: warning: no previous prototype for 'do_mcd_err' [-Wmissing-prototypes]
[...]


[INFO] Compiling uml64
[INFO] 0 errors
[INFO] 51 warnings
[PASS]

  $ cat uml64_log | grep warn
arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
./arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
arch/x86/um/bugs_64.c:9:6: warning: no previous prototype for 'arch_check_bugs' [-Wmissing-prototypes]
arch/x86/um/bugs_64.c:13:6: warning: no previous prototype for 'arch_examine_signal' [-Wmissing-prototypes]
arch/x86/um/fault.c:18:5: warning: no previous prototype for 'arch_fixup' [-Wmissing-prototypes]
arch/x86/um/ptrace_64.c:111:5: warning: no previous prototype for 'poke_user' [-Wmissing-prototypes]
arch/x86/um/ptrace_64.c:171:5: warning: no previous prototype for 'peek_user' [-Wmissing-prototypes]
arch/um/os-Linux/main.c:187:7: warning: no previous prototype for '__wrap_malloc' [-Wmissing-prototypes]
arch/um/os-Linux/main.c:208:7: warning: no previous prototype for '__wrap_calloc' [-Wmissing-prototypes]
arch/um/os-Linux/main.c:222:6: warning: no previous prototype for '__wrap_free' [-Wmissing-prototypes]
arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for 'kasan_map_memory' [-Wmissing-prototypes]
arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for 'check_tmpexec' [-Wmissing-prototypes]
arch/um/os-Linux/signal.c:75:6: warning: no previous prototype for 'sig_handler' [-Wmissing-prototypes]
arch/um/os-Linux/signal.c:111:6: warning: no previous prototype for 'timer_alarm_handler' [-Wmissing-prototypes]
[...]


[INFO] Compiling xtensa
[INFO] 1 errors
[INFO] 1 warnings
[FAIL]

  $ cat xtensa_log | grep Error
./arch/xtensa/include/asm/initialize_mmu.h:57: Error: invalid register 'atomctl' for 'wsr' instruction
make[4]: *** [scripts/Makefile.build:362: arch/xtensa/kernel/head.o] Error 1
make[3]: *** [scripts/Makefile.build:485: arch/xtensa/kernel] Error 2
make[2]: *** [scripts/Makefile.build:485: arch/xtensa] Error 2
make[1]: *** [/home/dhildenb/git/linux-cross/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


-- 
Cheers,

David / dhildenb


