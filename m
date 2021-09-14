Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01D940B200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhINOui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:50:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36305 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234274AbhINOtD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:49:03 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H85mc3stlz9sTZ;
        Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GO3bOpvNkxSJ; Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H85mc2pnkz9sTY;
        Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 475E88B773;
        Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6uDZRDL0dNLX; Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.207])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 86DA68B763;
        Tue, 14 Sep 2021 16:47:42 +0200 (CEST)
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
To:     Borislav Petkov <bp@alien8.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-graphics-maintainer@vmware.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <41b93dae-2f10-15a3-a079-c632381bec73@csgroup.eu>
Date:   Tue, 14 Sep 2021 16:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUCOTIPPsJJpLO/d@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 14/09/2021 à 13:58, Borislav Petkov a écrit :
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
>>   arch/powerpc/platforms/pseries/Kconfig       |  1 +
>>   arch/powerpc/platforms/pseries/Makefile      |  2 ++
>>   arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
>>   3 files changed, 29 insertions(+)
>>   create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
> 
> Michael,
> 
> can I get an ACK for the ppc bits to carry them through the tip tree
> pls?
> 
> Btw, on a related note, cross-compiling this throws the following error here:
> 
> $ make CROSS_COMPILE=/home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux- V=1 ARCH=powerpc
> 
> ...
> 
> /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -Wp,-MD,arch/powerpc/boot/.crt0.o.d -D__ASSEMBLY__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc -include ./include/linux/compiler_attributes.h -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -m32 -isystem /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/9.4.0/include -mbig-endian -nostdinc -c -o arch/powerpc/boot/crt0.o arch/powerpc/boot/crt0.S
> In file included from <command-line>:
> ././include/linux/compiler_attributes.h:62:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
>     62 | #if __has_attribute(__assume_aligned__)
>        |     ^~~~~~~~~~~~~~~
> ././include/linux/compiler_attributes.h:62:20: error: missing binary operator before token "("
>     62 | #if __has_attribute(__assume_aligned__)
>        |                    ^
> ././include/linux/compiler_attributes.h:88:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
>     88 | #if __has_attribute(__copy__)
>        |     ^~~~~~~~~~~~~~~
> ...
> 
> Known issue?
> 
> This __has_attribute() thing is supposed to be supported
> in gcc since 5.1 and I'm using the crosstool stuff from
> https://www.kernel.org/pub/tools/crosstool/ and gcc-9.4 above is pretty
> new so that should not happen actually.
> 
> But it does...
> 
> Hmmm.
> 


Yes, see 
https://lore.kernel.org/linuxppc-dev/20210914123919.58203eef@canb.auug.org.au/T/#t

