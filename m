Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839292D852D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 07:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438476AbgLLGRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 01:17:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2794 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436746AbgLLGRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 01:17:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd4603d0000>; Fri, 11 Dec 2020 22:16:29 -0800
Received: from [10.2.58.108] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 12 Dec
 2020 06:16:23 +0000
Subject: Re: [PATCH v14 10/10] secretmem: test: add basic selftest for
 memfd_secret(2)
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Christopher Lameter" <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Elena Reshetova" <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-riscv@lists.infradead.org>,
        <x86@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-11-rppt@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <248f928b-1383-48ea-8584-ec10146e60c9@nvidia.com>
Date:   Fri, 11 Dec 2020 22:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201203062949.5484-11-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607753789; bh=ofgMBZd16EADbvAo0gykil1HQ3WXinWEQXFsF7eWzJ0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=nHiMzIuFi9yGg9dtEXBRDsgSZmIDOiTwrsl4IkhMy6fFmjAA+d/AS9GK73/GrEl8c
         L2wFofk2X8mSJW/vLEAbgA9QPMoBNfjJd8BWsCI0rrp+bj6/xYZKQSgViVMLkLSYK1
         k66ZGlnQfrIIuas55l4diL4Iaoyoywisz15vCenxZUMAMyAtm2LyPLwxbz991YbWg8
         nRt0uF/HuZ34WhsfN3HMzjfJx7L8KMpuqwwkCn0Y66dd5OlXb+xyLmZkRBWZVKoHt4
         QQtiTloYRW+10TrH/r0jzw36mCIbK7syoQlFnk7px83Aq1dj4ALMG1TaKaeUNQMmQk
         OnZsyXYjTgO+g==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/2/20 10:29 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
...
> +#include "../kselftest.h"
> +
> +#define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
> +#define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
> +#define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
> +
> +#ifdef __NR_memfd_secret
> +
> +#include <linux/secretmem.h>

Hi Mike,

Say, when I tried this out from today's linux-next, I had to delete the
above line. In other words, the following was required in order to build:

diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
index 79578dfd13e6..c878c2b841fc 100644
--- a/tools/testing/selftests/vm/memfd_secret.c
+++ b/tools/testing/selftests/vm/memfd_secret.c
@@ -29,8 +29,6 @@

  #ifdef __NR_memfd_secret

-#include <linux/secretmem.h>
-
  #define PATTERN        0x55

  static const int prot = PROT_READ | PROT_WRITE;


...and that makes sense to me, because:

a) secretmem.h is not in the uapi, which this selftests/vm build system
    expects (it runs "make headers_install" for us, which is *not* going
    to pick up items in the kernel include dirs), and

b) There is nothing in secretmem.h that this test uses, anyway! Just these:

bool vma_is_secretmem(struct vm_area_struct *vma);
bool page_is_secretmem(struct page *page);
bool secretmem_active(void);


...or am I just Doing It Wrong? :)

thanks,
-- 
John Hubbard
NVIDIA
