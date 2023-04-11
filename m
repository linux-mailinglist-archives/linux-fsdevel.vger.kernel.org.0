Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E906DD0B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 06:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDKEOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 00:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKEOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:14:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD33B2691;
        Mon, 10 Apr 2023 21:14:47 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PwXSq23j9zSnTr;
        Tue, 11 Apr 2023 12:10:51 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 12:14:45 +0800
Message-ID: <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
Date:   Tue, 11 Apr 2023 12:14:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] fs: fix sysctls.c built
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/sys/fs/overflowuid and overflowgid  will be lost without
building this file, kindly ping, any comments, thanks.


On 2023/3/31 16:45, Kefeng Wang wrote:
> 'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
> or it won't be built as it is overwrited.
> 
> Fixes: ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   fs/Makefile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index 05f89b5c962f..8d4736fcc766 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -6,7 +6,6 @@
>   # Rewritten to use lists instead of if-statements.
>   #
>   
> -obj-$(CONFIG_SYSCTL)		+= sysctls.o
>   
>   obj-y :=	open.o read_write.o file_table.o super.o \
>   		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
> @@ -50,7 +49,7 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
>   obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
>   obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
>   obj-$(CONFIG_COREDUMP)		+= coredump.o
> -obj-$(CONFIG_SYSCTL)		+= drop_caches.o
> +obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
>   
>   obj-$(CONFIG_FHANDLE)		+= fhandle.o
>   obj-y				+= iomap/
