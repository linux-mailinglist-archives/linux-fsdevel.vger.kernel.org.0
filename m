Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECFD7CA8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfGaRdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:33:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42276 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfGaRdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:33:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so32244865pff.9;
        Wed, 31 Jul 2019 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1mUzN69TbVh9yZT+F3MQDO+6tQ5Mp+B1rUEtD2T6Huc=;
        b=YOxge0Yl9i70G+adD8fcIAQFr/+MKP/AFeajQGmNOUU3PSBiJFy13XEVeByt0H23Fm
         eQzDcQe68Apu1iZpVUkzBjb1K8sNEmZZT1vTc0iVLJa71adt7IaZsg7HXfFrupSDvu2t
         /AbaO7TzbQzEOfsYUnbE8+0dT8MWRwsp1fjykU0avS6hF4Jk57q5gwhJWRcTwnruRx8D
         PzGi9hcvi/tT1aDkbKf0dLDit1UyoCPYI0SUX4i4V74v4YxmWPog8KRGZn0aniBLbdUA
         HNRGCy5jpKlcLfKvyalbj8kL5hQfmFY6LXC6ZzkipEieZEKSDhpcT5WZw6P56IE6NcoA
         AxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1mUzN69TbVh9yZT+F3MQDO+6tQ5Mp+B1rUEtD2T6Huc=;
        b=ZRW4HZzsbuSJSyog9F0pt3s0UBhhSrxs2RTBxWDqpJG0XCP2MouhGo4kZt6iVfwRBf
         vI6LZz+KfowtOFS1p0hx0t/fiBFLtUsbON8nDstHXSthtdc0MD0YGjHPOqDAZFBZzbOx
         KffbHOSCLAtDeb+DI6suyaA/HEXjIcForwO98eAKNOaXos+1X+j/onxQyL5goEjLMfb8
         MLCGW2+5JCRVNxSt+pb1ZgVkYg7ycmY9sM+M04pjIJDp3SnJ8zmhO9q3WU4CykyumU1T
         DpmJ8KrH63qbuVLs2eW7A4PH1/gWGbTSBCUdFVxhcfHv3ddD6zbyfC5IjMcjRiunM7h5
         LiZA==
X-Gm-Message-State: APjAAAUWlYrRPBPnzmrnpE2Ffuy6RUDOKpiDXKXpBwa2/a4xSZaECPvS
        V9dU5iOPpW4oVW+1ZCIrkcA=
X-Google-Smtp-Source: APXvYqwzc3V4hpBjzjfpPb1vXFYPZ0Qeb7PGWHW8bph0fdJAOdbQdQV14uAoPp6X+iZ/zBHaMBAOoQ==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr48612603pfc.62.1564594404588;
        Wed, 31 Jul 2019 10:33:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e10sm71043899pfi.173.2019.07.31.10.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 10:33:23 -0700 (PDT)
Date:   Wed, 31 Jul 2019 10:33:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 14/14] riscv: Make mmap allocation top-down by default
Message-ID: <20190731173322.GA30870@roeck-us.net>
References: <20190730055113.23635-1-alex@ghiti.fr>
 <20190730055113.23635-15-alex@ghiti.fr>
 <88a9bbf8-872f-97cc-fc1a-83eb7694478f@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a9bbf8-872f-97cc-fc1a-83eb7694478f@ghiti.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:05:23AM -0400, Alex Ghiti wrote:
> On 7/30/19 1:51 AM, Alexandre Ghiti wrote:
> >In order to avoid wasting user address space by using bottom-up mmap
> >allocation scheme, prefer top-down scheme when possible.
> >
> >Before:
> >root@qemuriscv64:~# cat /proc/self/maps
> >00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> >00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> >00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> >00018000-00039000 rw-p 00000000 00:00 0          [heap]
> >1555556000-155556d000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> >155556d000-155556e000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> >155556e000-155556f000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> >155556f000-1555570000 rw-p 00000000 00:00 0
> >1555570000-1555572000 r-xp 00000000 00:00 0      [vdso]
> >1555574000-1555576000 rw-p 00000000 00:00 0
> >1555576000-1555674000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> >1555674000-1555678000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> >1555678000-155567a000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> >155567a000-15556a0000 rw-p 00000000 00:00 0
> >3fffb90000-3fffbb1000 rw-p 00000000 00:00 0      [stack]
> >
> >After:
> >root@qemuriscv64:~# cat /proc/self/maps
> >00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> >00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> >00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> >2de81000-2dea2000 rw-p 00000000 00:00 0          [heap]
> >3ff7eb6000-3ff7ed8000 rw-p 00000000 00:00 0
> >3ff7ed8000-3ff7fd6000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> >3ff7fd6000-3ff7fda000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> >3ff7fda000-3ff7fdc000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> >3ff7fdc000-3ff7fe2000 rw-p 00000000 00:00 0
> >3ff7fe4000-3ff7fe6000 r-xp 00000000 00:00 0      [vdso]
> >3ff7fe6000-3ff7ffd000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> >3ff7ffd000-3ff7ffe000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> >3ff7ffe000-3ff7fff000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> >3ff7fff000-3ff8000000 rw-p 00000000 00:00 0
> >3fff888000-3fff8a9000 rw-p 00000000 00:00 0      [stack]
> >
> >Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >Reviewed-by: Christoph Hellwig <hch@lst.de>
> >Reviewed-by: Kees Cook <keescook@chromium.org>
> >Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >---
> >  arch/riscv/Kconfig | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> >diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >index 8ef64fe2c2b3..8d0d8af1a744 100644
> >--- a/arch/riscv/Kconfig
> >+++ b/arch/riscv/Kconfig
> >@@ -54,6 +54,19 @@ config RISCV
> >  	select EDAC_SUPPORT
> >  	select ARCH_HAS_GIGANTIC_PAGE
> >  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> >+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> >+	select HAVE_ARCH_MMAP_RND_BITS
> >+
> >+config ARCH_MMAP_RND_BITS_MIN
> >+	default 18 if 64BIT
> >+	default 8
> >+
> >+# max bits determined by the following formula:
> >+#  VA_BITS - PAGE_SHIFT - 3
> >+config ARCH_MMAP_RND_BITS_MAX
> >+	default 33 if RISCV_VM_SV48
> >+	default 24 if RISCV_VM_SV39
> >+	default 17 if RISCV_VM_SV32
> >  config MMU
> >  	def_bool y
> 
> 
> Hi Andrew,
> 
> I have just seen you took this series into mmotm but without Paul's patch
> ("riscv: kbuild: add virtual memory system selection") on which this commit
> relies, I'm not sure it could
> compile without it as there is no default for ARCH_MMAP_RND_BITS_MAX.
> 
Yes, this patch results in a bad configuration file.

CONFIG_ARCH_MMAP_RND_BITS_MIN=18
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=0

CONFIG_ARCH_MMAP_RND_BITS=0 is outside the valid range, causing make to ask
for a valid number. Since none exists, one is stuck with something like:

Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 1
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 2
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 3
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 4
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 5
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 6
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 7
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 8
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 19
Number of bits to use for ASLR of mmap base address (ARCH_MMAP_RND_BITS) [0] (NEW) 18

when trying to compile riscv images. Plus, of course, all automatic builders
bail out as result. 

Guenter
