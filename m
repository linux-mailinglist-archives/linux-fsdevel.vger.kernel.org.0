Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4473743CE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjF3Ni4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3Niy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:38:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811BC1FE8;
        Fri, 30 Jun 2023 06:38:52 -0700 (PDT)
X-QQ-mid: bizesmtp72t1688132308t5lpes6w
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 21:38:27 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: G+WLZ/1vSOE/QeI/ppaBpcBNTobcOzk/g+2a/fUhWadeWAN+Bf2pPc5KJQ0qu
        voSj4wbaCgh1sL5WZn80GZweZDDv0HyR/15Km1SmhfByZvoLY8ZUEIFopcm4HQoEA6UX4ZH
        t8q9lQ5IwoPbm+PPSMuTROK2wA7dH7g+p0MWNA9tXIAfcqqhXmQheuhxTN6yvNrJEXakTbJ
        L986E2QHyLUolLKqSvg3ID/S1QVbiu0NyS/unPrW1XC+2lWzzKtzBj7VB9+og4kdNRHJL9N
        0r1UDRFNLOuXKr0uS1P4VPKZje/L5VnJ5ZrmSZ6VKBU0pQaENlncL4aoXOdcf5Itm4Og3Yz
        O9oTPAv7rIx2XYBpdhXS58MK7GPO3KO7MVrWKretIXL59pJhBYmGlgpTdc9kJl3aYmvUyXB
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4867400409169338334
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     akpm@linux-foundation.org, brauner@kernel.org, falcon@tinylab.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk, w@lwt.eu
Subject: Re: [PATCH] mm: make MEMFD_CREATE into a selectable config option
Date:   Fri, 30 Jun 2023 21:38:26 +0800
Message-Id: <20230630133826.245610-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
References: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Thomas

I have manually applied your patch on v6.4, enabled MEMFD_CREATE (and disabled
TMPFS and HUGETLBFS) for 3 randomly selected virtual boards:

- arm/vexpress-a9
- aarch64/virt
- mipsel/malta

For all of the above boards, the current vfprintf test (uses
memfd_create) of tools/testing/selftests/nolibc/nolibc-test.c passes
without any failure:

    Running test 'vfprintf'
    0 emptymemfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'init'
     "" = ""                                                  [OK]
    1 simple "foo" = "foo"                                           [OK]
    2 string "foo" = "foo"                                           [OK]
    3 number "1234" = "1234"                                         [OK]
    4 negnumber "-1234" = "-1234"                                    [OK]
    5 unsigned "12345" = "12345"                                     [OK]
    6 char "c" = "c"                                                 [OK]
    7 hex "f" = "f"                                                  [OK]
    8 pointer "0x1" = "0x1"                                          [OK]
    Errors during this test: 0

If this test result is ok for you, here is my:

Tested-by: Zhangjin Wu <falcon@tinylab.org>

Best regards,
Zhangjin

> 
> The memfd_create() syscall, enabled by CONFIG_MEMFD_CREATE, is useful on
> its own even when not required by CONFIG_TMPFS or CONFIG_HUGETLBFS.
> 
> Split it into its own proper bool option that can be enabled by users.
> 
> Move that option into mm/ where the code itself also lies.
> Also add "select" statements to CONFIG_TMPFS and CONFIG_HUGETLBFS so
> they automatically enable CONFIG_MEMFD_CREATE as before.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  fs/Kconfig | 5 ++---
>  mm/Kconfig | 3 +++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 18d034ec7953..19975b104bc3 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -169,6 +169,7 @@ source "fs/sysfs/Kconfig"
>  config TMPFS
>  	bool "Tmpfs virtual memory file system support (former shm fs)"
>  	depends on SHMEM
> +	select MEMFD_CREATE
>  	help
>  	  Tmpfs is a file system which keeps all files in virtual memory.
>  
> @@ -240,6 +241,7 @@ config HUGETLBFS
>  	bool "HugeTLB file system support"
>  	depends on X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>  	depends on (SYSFS || SYSCTL)
> +	select MEMFD_CREATE
>  	help
>  	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
>  	  ramfs. For architectures that support it, say Y here and read
> @@ -264,9 +266,6 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>  	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
>  	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
>  
> -config MEMFD_CREATE
> -	def_bool TMPFS || HUGETLBFS
> -
>  config ARCH_HAS_GIGANTIC_PAGE
>  	bool
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09130434e30d..22acffd9009d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1144,6 +1144,9 @@ config KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
>  config IO_MAPPING
>  	bool
>  
> +config MEMFD_CREATE
> +	bool "Enable memfd_create() system call" if EXPERT
> +
>  config SECRETMEM
>  	default y
>  	bool "Enable memfd_secret() system call" if EXPERT
> 
> ---
> base-commit: e55e5df193d247a38a5e1ac65a5316a0adcc22fa
> change-id: 20230629-config-memfd-be6af03b7dca
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 
