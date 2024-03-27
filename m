Return-Path: <linux-fsdevel+bounces-15449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5A88E97C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0811F248F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA812FB32;
	Wed, 27 Mar 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1/5Rk2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984E12F595
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553993; cv=none; b=p356bUdrb6ajF2hBJdClsMB5KsgUkyufwUrYsHKph4PGfNvdYDwGVVohEIsOOFO7QUSC1j8+x2XQsIkV2dqmX82VakmgbmW0dkx7tkg9NfAoc4vdYS/Ya264S3VOHCZcr0Go1QTyhH6xDQ8srYPCFiSZ8PE6fIRjoLTQTVACm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553993; c=relaxed/simple;
	bh=6qortPhecC5ypfseMZlrrYHN5HO4Cx2t/CZ2MeJ9vs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuoLHS5/gl/L54G0ImQ4H+Ctzfxfb92iw0HVus2MzWbkKZoc1r8aLW3GIuq5gPmFaR17fWLN4/ediBqLYMCiTMDgMjbK7pSImx0xsilrmA7VLZzbRkx8ld3iqsiWSCq7SWMnf3SgQONzC1sBKfCLL3colHUS1k2U22gPDMymnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1/5Rk2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ur8OskSppa9H+HBircWeiCnislf2Tqfr+PXSwh/fvIk=;
	b=R1/5Rk2fge9dnk5c8klM4WyOJdtt1tW3aFe9EYZ6mv5F0xA0JhLHWGeNbG7/tYaG70lyWN
	z5Wln2/15zRfSioE8T9Ky1dBOSOXF82VwRbBmLXXfKhO+Lni5wc/tC3zcYjrzEpighn005
	S+ksV9DW+X9lTovYave6qIYVqDRoXq4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-bq-g0FeoPyyK8kuRF86-nw-1; Wed, 27 Mar 2024 11:39:48 -0400
X-MC-Unique: bq-g0FeoPyyK8kuRF86-nw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33eca6f6e4bso4273595f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 08:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553987; x=1712158787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ur8OskSppa9H+HBircWeiCnislf2Tqfr+PXSwh/fvIk=;
        b=WrqKw1UmDKQz3QX+BVN9XqZrKFm9Q0LntU4zcjZhWgIVEL3JWF7vUzjAXXERPBcadT
         4dmMCAEKsdeKJg2kcYiI+r5ZIoFq+HKAw8abBqoBtvkJ20xycjMmewRGKmR1akSfE6Q/
         kVUpfG6jrU4tA+KkP7llNl1D1E19PISK9oqAbbygM97nuEc0aWKsKaeVVMbgmFcTEYpd
         9truMD80+8P0XacBTzkpOjimjY4SMORxEXkbLj3nea96aGMqdRuh0iWJC80ZPkZXODAf
         7yOu1VeXzY6DgUrUPsUxCUi5495XFQDkSP4/IlW0eN7JQmzcNt5pcK1utOe+NxJAPMnN
         0RQw==
X-Forwarded-Encrypted: i=1; AJvYcCUOnJim4T4zmXBcGU3sFV17glx4yVlZ2qd59l+5d0rpgqLTOFcEMEffB4p1YDpK2jo1VA/wdSsxVyWVFcNzx4LYxUox5ZxKxmWEUNAs1g==
X-Gm-Message-State: AOJu0Yx0Ad9/Dc2EKSOFcqIi7WxNSihfOd/92CqHSfiqIW/1LbhXOhZw
	zXSf8RaFO23jA5OzHmq/y08yFZ4eWWjPfq67RX3fklASksDhBr8VwwVVJf+L4cmCkUbSedanlSq
	1m7le22e1B+5c4OB9BDzX+V04aC6XjdclksyeMMsCdUN7mCE7OC2jFvPJRgBYXQoP6qD2PO8=
X-Received: by 2002:a05:600c:1d9a:b0:414:9141:1462 with SMTP id p26-20020a05600c1d9a00b0041491411462mr291184wms.28.1711553987257;
        Wed, 27 Mar 2024 08:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw3dASPUZ4fnCTPx+HHUYsdjHbHmbIEVVFlmMiRvszlN9ujMWRcobGz3Cz/cDHzhvHXPlb1w==
X-Received: by 2002:a05:600c:1d9a:b0:414:9141:1462 with SMTP id p26-20020a05600c1d9a00b0041491411462mr291147wms.28.1711553986691;
        Wed, 27 Mar 2024 08:39:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d5910000000b003418364032asm15207424wrd.112.2024.03.27.08.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:39:46 -0700 (PDT)
Message-ID: <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
Date: Wed, 27 Mar 2024 16:39:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240327130538.680256-1-david@redhat.com> <ZgQ5hNltQ2DHQXps@x1n>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZgQ5hNltQ2DHQXps@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.24 16:21, Peter Xu wrote:
> On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
>> Some cleanups around function names, comments and the config option of
>> "GUP-fast" -- GUP without "lock" safety belts on.
>>
>> With this cleanup it's easy to judge which functions are GUP-fast specific.
>> We now consistently call it "GUP-fast", avoiding mixing it with "fast GUP",
>> "lockless", or simply "gup" (which I always considered confusing in the
>> ode).
>>
>> So the magic now happens in functions that contain "gup_fast", whereby
>> gup_fast() is the entry point into that magic. Comments consistently
>> reference either "GUP-fast" or "gup_fast()".
>>
>> Based on mm-unstable from today. I won't CC arch maintainers, but only
>> arch mailing lists, to reduce noise.
>>
>> Tested on x86_64, cross compiled on a bunch of archs, whereby some of them
>> don't properly even compile on mm-unstable anymore in my usual setup
>> (alpha, arc, parisc64, sh) ... maybe the cross compilers are outdated,
>> but there are no new ones around. Hm.
> 
> I'm not sure what config you tried there; as I am doing some build tests
> recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
> avoid a lot of issues, I think it's due to libc missing.  But maybe not the
> case there.

CCin Arnd; I use some of his compiler chains, others from Fedora directly. For
example for alpha and arc, the Fedora gcc is "13.2.1".


I compile quite some targets, usually with defconfig. From my compile script:

# COMPILER NAME ARCH CROSS_COMPILE CONFIG(if different from defconfig)

compile_gcc "alpha" "alpha" "alpha-linux-gnu-"
compile_gcc "arc" "arc" "arc-linux-gnu-"
compile_gcc "arm" "arm" "arm-linux-gnu-" "axm55xx_defconfig"
compile_gcc "arm-nommu" "arm" "arm-linux-gnu-" "imxrt_defconfig"
compile_gcc "arm64" "arm64" "aarch64-linux-gnu-"
compile_gcc "csky" "csky" "../cross/gcc-13.2.0-nolibc/csky-linux/bin/csky-linux-"
compile_gcc "loongarch" "loongarch" "../cross/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-"
compile_gcc "m68k-nommu" "m68k" "m68k-linux-gnu-" "amcore_defconfig"
compile_gcc "m68k-sun3" "m68k" "m68k-linux-gnu-" "sun3_defconfig"
compile_gcc "m68k-coldfire" "m68k" "m68k-linux-gnu-" "m5475evb_defconfig"
compile_gcc "m68k-virt" "m68k" "m68k-linux-gnu-" "virt_defconfig"
compile_gcc "microblaze" "microblaze" "microblaze-linux-gnu-"
compile_gcc "mips64" "mips" "mips64-linux-gnu-" "bigsur_defconfig"
compile_gcc "mips32-xpa" "mips" "mips64-linux-gnu-" "maltaup_xpa_defconfig"
compile_gcc "mips32-alchemy" "mips" "mips64-linux-gnu-" "gpr_defconfig"
compile_gcc "mips32" "mips" "mips64-linux-gnu-"
compile_gcc "nios2" "nios2" "nios2-linux-gnu-" "3c120_defconfig"
compile_gcc "openrisc" "openrisc" "../cross/gcc-13.2.0-nolibc/or1k-linux/bin/or1k-linux-" "virt_defconfig"
compile_gcc "parisc32" "parisc" "hppa-linux-gnu-" "generic-32bit_defconfig"
compile_gcc "parisc64" "parisc" "hppa64-linux-gnu-" "generic-64bit_defconfig"
compile_gcc "riscv32" "riscv" "riscv64-linux-gnu-" "32-bit.config"
compile_gcc "riscv64" "riscv" "riscv64-linux-gnu-" "64-bit.config"
compile_gcc "riscv64-nommu" "riscv" "riscv64-linux-gnu-" "nommu_virt_defconfig"
compile_gcc "s390x" "s390" "s390x-linux-gnu-"
compile_gcc "sh" "sh" "../cross/gcc-13.2.0-nolibc/sh4-linux/bin/sh4-linux-"
compile_gcc "sparc32" "sparc" "../cross/gcc-13.2.0-nolibc/sparc-linux/bin/sparc-linux-" "sparc32_defconfig"
compile_gcc "sparc64" "sparc" "../cross/gcc-13.2.0-nolibc/sparc64-linux/bin/sparc64-linux-" "sparc64_defconfig"
compile_gcc "uml64" "um" "" "x86_64_defconfig"
compile_gcc "x86" "x86" "" "i386_defconfig"
compile_gcc "x86-pae" "x86" "" "i386_defconfig"
compile_gcc "x86_64" "x86" ""
compile_gcc "xtensa" "xtensa" "../cross/gcc-13.2.0-nolibc/xtensa-linux/bin/xtensa-linux-" "virt_defconfig"
compile_gcc "powernv" "powerpc" "../cross/gcc-13.2.0-nolibc/powerpc64-linux/bin/powerpc64-linux-" "powernv_defconfig"
compile_gcc "pseries" "powerpc" "../cross/gcc-13.2.0-nolibc/powerpc64-linux/bin/powerpc64-linux-" "pseries_defconfig"



Some of them look like mm-unstable issue, For example, arm64 fails with

   CC      arch/arm64/mm/extable.o
In file included from ./include/linux/hugetlb.h:828,
                  from security/commoncap.c:19:
./arch/arm64/include/asm/hugetlb.h:25:34: error: redefinition of 'arch_clear_hugetlb_flags'
    25 | #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/hugetlb.h:840:20: note: in expansion of macro 'arch_clear_hugetlb_flags'
   840 | static inline void arch_clear_hugetlb_flags(struct folio *folio) { }
       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/hugetlb.h:21:20: note: previous definition of 'arch_clear_hugetlb_flags' with t
ype 'void(struct folio *)'
    21 | static inline void arch_clear_hugetlb_flags(struct folio *folio)
       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/hugetlb.h:828,
                  from mm/filemap.c:37:
./arch/arm64/include/asm/hugetlb.h:25:34: error: redefinition of 'arch_clear_hugetlb_flags'
    25 | #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/hugetlb.h:840:20: note: in expansion of macro 'arch_clear_hugetlb_flags'
   840 | static inline void arch_clear_hugetlb_flags(struct folio *folio) { }
       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/hugetlb.h:21:20: note: previous definition of 'arch_clear_hugetlb_flags' with type 'void(struct folio *)'
    21 | static inline void arch_clear_hugetlb_flags(struct folio *folio)


But there is other stuff like (arc):

./arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
./arch/arc/include/asm/mmu-arcv2.h:82:9: error: implicit declaration of function 'write_aux_reg' [-Werro
r=implicit-function-declaration]
    82 |         write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
       |         ^~~~~~~~~~~~~

or (alpha)

WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
ERROR: modpost: "memcpy" [fs/reiserfs/reiserfs.ko] undefined!
ERROR: modpost: "memcpy" [fs/nfs/nfs.ko] undefined!
ERROR: modpost: "memcpy" [fs/nfs/nfsv3.ko] undefined!
ERROR: modpost: "memcpy" [fs/nfsd/nfsd.ko] undefined!
ERROR: modpost: "memcpy" [fs/lockd/lockd.ko] undefined!
ERROR: modpost: "memcpy" [crypto/crypto.ko] undefined!
ERROR: modpost: "memcpy" [crypto/crypto_algapi.ko] undefined!
ERROR: modpost: "memcpy" [crypto/aead.ko] undefined!
ERROR: modpost: "memcpy" [crypto/crypto_skcipher.ko] undefined!
ERROR: modpost: "memcpy" [crypto/seqiv.ko] undefined!


> 
> The series makes sense to me, the naming is confusing.  Btw, thanks for
> posting this as RFC. This definitely has a conflict with the other gup
> series that I had; I'll post v4 of that shortly.

Yes, I will rebase on top of that!

-- 
Cheers,

David / dhildenb


