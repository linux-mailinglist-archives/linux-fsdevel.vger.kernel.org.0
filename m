Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6781740BCA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 02:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhIOAaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhIOAaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:30:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53563C061574;
        Tue, 14 Sep 2021 17:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631665743;
        bh=HgCpSqOauKiPM+dBPwX1rVKc5DllbEYyPqTeHP+eUfA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nobrDH5nGZu7v+B+3sYvcmgWwQ6HXMJcFwBQJdDWX9HZxhJmSYRfeLJ5bqM1L8nAT
         Zv7FEyFybAcOR9q2SSYXqyD/igi9xudle6V5yasFwsCuG7S0oozCaRNikxkvD596/w
         6l43PVixwL61h3NyNDnNd5sNzqDNGCDn9FEcD1fB6an9gsKEzr5R3Isof7M+Dp+CFm
         Flkym9C4vSI8DMWcOL/ydbmO/xhA1U449O7gqRfyeoJq9Tl/sPJDKQcCHDPv+s1Rp6
         4loBfWLosZBa6f9xlvgT7ZD+EwPUzeNUvScHtwtaoHQpWTi57p46qNn2qlhGqy8rED
         FWCERXkM6X8Sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H8LgJ0MSWz9sVq;
        Wed, 15 Sep 2021 10:28:59 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
In-Reply-To: <YUCOTIPPsJJpLO/d@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
Date:   Wed, 15 Sep 2021 10:28:59 +1000
Message-ID: <87lf3yk7g4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Wed, Sep 08, 2021 at 05:58:35PM -0500, Tom Lendacky wrote:
>> Introduce a powerpc version of the cc_platform_has() function. This will
>> be used to replace the powerpc mem_encrypt_active() implementation, so
>> the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
>> attribute.
>> 
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/powerpc/platforms/pseries/Kconfig       |  1 +
>>  arch/powerpc/platforms/pseries/Makefile      |  2 ++
>>  arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
>>  3 files changed, 29 insertions(+)
>>  create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
>
> Michael,
>
> can I get an ACK for the ppc bits to carry them through the tip tree
> pls?

Yeah.

I don't love it, a new C file and an out-of-line call to then call back
to a static inline that for most configuration will return false ... but
whatever :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


> Btw, on a related note, cross-compiling this throws the following error here:
>
> $ make CROSS_COMPILE=/home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux- V=1 ARCH=powerpc
>
> ...
>
> /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -Wp,-MD,arch/powerpc/boot/.crt0.o.d -D__ASSEMBLY__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc -include ./include/linux/compiler_attributes.h -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -m32 -isystem /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/9.4.0/include -mbig-endian -nostdinc -c -o arch/powerpc/boot/crt0.o arch/powerpc/boot/crt0.S
> In file included from <command-line>:
> ././include/linux/compiler_attributes.h:62:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
>    62 | #if __has_attribute(__assume_aligned__)
>       |     ^~~~~~~~~~~~~~~
> ././include/linux/compiler_attributes.h:62:20: error: missing binary operator before token "("
>    62 | #if __has_attribute(__assume_aligned__)
>       |                    ^
> ././include/linux/compiler_attributes.h:88:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
>    88 | #if __has_attribute(__copy__)
>       |     ^~~~~~~~~~~~~~~
> ...
>
> Known issue?

Yeah, fixed in mainline today, thanks for trying to cross compile :)

cheers
