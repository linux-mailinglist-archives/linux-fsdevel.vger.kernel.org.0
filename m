Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E556A4FB11B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 02:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiDKAev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 20:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiDKAeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 20:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93358DED4
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649637156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMk2hrC13YV3a9T+ITG+ukTyu7UA8SMI5IqkNoDz3QE=;
        b=jEBN/vAmYq+q0gJ2pWeW5OYulZ84UCV4mej3Y0NQXtWvPSPnUSGKjjKwaGv90Swoyila29
        YR+T4OLDx/sEiNf8MuUKJuAWHMAuPk/TFPE1umi7VTZeXLM7Hdstv6+kotDcxMK5B69MuJ
        w2u41XQWYVoPzI4slIOUrUNOPXBLUdU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-38XEfLlKPBaJgcac3k7Uaw-1; Sun, 10 Apr 2022 20:32:33 -0400
X-MC-Unique: 38XEfLlKPBaJgcac3k7Uaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05DD1801585;
        Mon, 11 Apr 2022 00:32:33 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09C671415126;
        Mon, 11 Apr 2022 00:32:29 +0000 (UTC)
Date:   Mon, 11 Apr 2022 08:32:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>, philip.li@intel.com
Cc:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, hch@lst.de, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 RESEND 1/3] vmcore: Convert copy_oldmem_page() to take
 an iov_iter
Message-ID: <YlN3GkuYunspGxnd@MiWiFi-R3L-srv>
References: <20220408090636.560886-2-bhe@redhat.com>
 <202204082128.JKXXDGpa-lkp@intel.com>
 <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
 <YlDlBQYr9ldLWpFz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlDlBQYr9ldLWpFz@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/09/22 at 02:44am, Matthew Wilcox wrote:
> On Sat, Apr 09, 2022 at 09:02:29AM +0800, Baoquan He wrote:
> > I tried on x86_64 system, for the 1st step, I got this:
> > 
> > [ ~]# wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > /root/bin/make.cross: No such file or directory
> 
> ... I don't think we need to reproduce it to see the problem.
> 
> > > sparse warnings: (new ones prefixed by >>)
> > > >> arch/sh/kernel/crash_dump.c:23:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem * @@
> > >    arch/sh/kernel/crash_dump.c:23:36: sparse:     expected void const *addr
> > >    arch/sh/kernel/crash_dump.c:23:36: sparse:     got void [noderef] __iomem *
> > > 
> > > vim +23 arch/sh/kernel/crash_dump.c
> > > 
> > >     13	
> > >     14	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> > >     15				 size_t csize, unsigned long offset)
> > >     16	{
> > >     17		void  __iomem *vaddr;
> > >     18	
> > >     19		if (!csize)
> > >     20			return 0;
> > >     21	
> > >     22		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> > >   > 23		csize = copy_to_iter(vaddr + offset, csize, iter);
> 
> Unlike other architectures, sh4 does this by calling ioremap().
> That gives us an __iomem qualified pointer, which it then warns about
> passing to copy_to_iter().
> 
> There are a bunch of hacky things we could do to fix it, but for such an
> unmaintained arch as sh, I'm inclined to do nothing.  We're more likely
> to break something while fixing the warning.  Someone who knows the arch
> can figure out what to do properly.

Checked code, this can be fixed by casting away __iomem when feeding
__iomem pointer into function which doesn't expect it. While seems the
lkp failed me again.


Subject: [PATCH] sh: cast away __iomem to remove sparse warning

This warning happened when __iomem pointer is passed into fucntion which
does expect it. casting away the __iomem can fix it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/sh/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 19ce6a950aac..b45bb0b8a182 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -20,7 +20,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		return 0;
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_to_iter((void __force *)vaddr + offset, csize, iter);
 	iounmap(vaddr);
 
 	return csize;
-- 
2.34.1

Hi Philipp,

I executed 'mkdir -p /root/bin', then can continue the next steps.
However, the building failed with below message. I cloned linus's tree
into the testing system. Then add remote
https://github.com/intel-lab-lkp/linux. Forgive my stupidity on this. If
I can test above code, I can merge it into patch in a new version.
Otherwise, I will leave it alone as willy suggested.

[root@dell-pem710-02 linux]# wget https://download.01.org/0day-ci/archive/20220408/202204082128.JKXXDGpa-lkp@intel.com/config
--2022-04-10 19:54:15--  https://download.01.org/0day-ci/archive/20220408/202204082128.JKXXDGpa-lkp@intel.com/config
Resolving download.01.org (download.01.org)... 2600:1408:20:c90::4b21, 2600:1408:20:c9b::4b21, 23.208.55.108
Connecting to download.01.org (download.01.org)|2600:1408:20:c90::4b21|:443... failed: Network is unreachable.
Connecting to download.01.org (download.01.org)|2600:1408:20:c9b::4b21|:443... failed: Network is unreachable.
Connecting to download.01.org (download.01.org)|23.208.55.108|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 122058 (119K) [application/octet-stream]
Saving to: ‘config’

config                            100%[============================================================>] 119.20K   769KB/s    in 0.2s    

2022-04-10 19:54:16 (769 KB/s) - ‘config’ saved [122058/122058]

[root@dell-pem710-02 linux]# mv config .config
[root@dell-pem710-02 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/
Compiler will be installed in /root/0day
make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/root/0day/gcc-9.3.0-nolibc/sh4-linux/bin/sh4-linux- --jobs=32 C=1 CF=-fdiagnostic-prefix -D__CHECK_ENDIAN__ O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/
make[1]: Entering directory '/root/linux/build_dir'
  SYNC    include/config/auto.conf.cmd
***
*** The source tree is not clean, please run 'make ARCH=sh mrproper'
*** in /root/linux
***
make[2]: *** [../Makefile:574: outputmakefile] Error 1
  HOSTCC  scripts/basic/fixdep
make[2]: Target 'syncconfig' not remade because of errors.
make[1]: *** [/root/linux/Makefile:722: include/config/auto.conf.cmd] Error 2
make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
make[1]: Failed to remake makefile 'include/config/auto.conf'.
***
*** The source tree is not clean, please run 'make ARCH=sh mrproper'
*** in /root/linux
***
make[1]: *** [/root/linux/Makefile:574: outputmakefile] Error 1
  SYSHDR  arch/sh/include/generated/uapi/asm/unistd_32.h
  SYSTBL  arch/sh/include/generated/asm/syscall_table.h
Error: kernelrelease not valid - run 'make prepare' to update it
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/libfdt/fdt.o
  HOSTCC  scripts/dtc/libfdt/fdt_ro.o
  HOSTCC  scripts/dtc/libfdt/fdt_sw.o
  HOSTCC  scripts/dtc/libfdt/fdt_wip.o
  HOSTCC  scripts/dtc/libfdt/fdt_rw.o
  HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
  HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
  HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
  HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  HOSTCC  scripts/dtc/fdtoverlay.o
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/fdtoverlay
  HOSTLD  scripts/dtc/dtc
make[1]: Target 'arch/sh/kernel/' not remade because of errors.
make[1]: Leaving directory '/root/linux/build_dir'
make: *** [Makefile:219: __sub-make] Error 2
make: Target 'arch/sh/kernel/' not remade because of errors.
[root@dell-pem710-02 linux]# 



> 

