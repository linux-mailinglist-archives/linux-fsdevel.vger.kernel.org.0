Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB4743EF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjF3Pdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjF3PdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF834699;
        Fri, 30 Jun 2023 08:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983AD61775;
        Fri, 30 Jun 2023 15:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD8C433C8;
        Fri, 30 Jun 2023 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688139157;
        bh=CJqO16i0LZzxYDlZkn2JK2TRPz9mJweGfqT2Kgdc7kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+27wpG23JR8DB7YlPAAim2PABjkM7pwFdma+9qdP2T7fXROIWKCFiJXEawyWpA7h
         YhkWq9ZFoAe1QkUeJYqv9Hx4RQTocrxwgUHCZ2fT6ZHXoefoJwS/cX/pOWkPeU/xP4
         WVay19YGmxv8kBfp8Pr4yw0G/z55caJvA9D7uSLoUbQviXHH3AiHEdkMoJihp1jZWg
         IKIM3bNY68sQdZ332v56So6R8gx3+hkoYFT04zleu/BsLbzrdyrcB06x6gRRgK6AA1
         uXirPIb/erocXMGGT8Ww4Fxl/wUPx8HsAQlkpA6SoMmj4RdZpjqK0MZiyo/xRpgG+l
         K6XwNn2SSpfcA==
Date:   Fri, 30 Jun 2023 08:32:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Willy Tarreau <w@lwt.eu>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH] mm: make MEMFD_CREATE into a selectable config option
Message-ID: <20230630153236.GD11423@frogsfrogsfrogs>
References: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:08:53AM +0200, Thomas Weiﬂschuh wrote:
> The memfd_create() syscall, enabled by CONFIG_MEMFD_CREATE, is useful on
> its own even when not required by CONFIG_TMPFS or CONFIG_HUGETLBFS.

If you don't have tmpfs or hugetlbfs enabled, then what fs ends up
backing the file returned by memfd_create()?  ramfs?

(Not an objection, I'm just curious...)

--D

> Split it into its own proper bool option that can be enabled by users.
> 
> Move that option into mm/ where the code itself also lies.
> Also add "select" statements to CONFIG_TMPFS and CONFIG_HUGETLBFS so
> they automatically enable CONFIG_MEMFD_CREATE as before.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
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
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
