Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EAB7BC3DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjJGBjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjJGBjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:39:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC197D6;
        Fri,  6 Oct 2023 18:39:42 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2SYG4cvDzNp2M;
        Sat,  7 Oct 2023 09:35:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 09:39:40 +0800
Subject: Re: [PATCH 15/29] jffs2: move jffs2_xattr_handlers to .rodata
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-16-wedsonaf@gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9c4d2055-de05-42d9-dace-a9ff9d28f819@huawei.com>
Date:   Sat, 7 Oct 2023 09:39:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230930050033.41174-16-wedsonaf@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2023/9/30 13:00, Wedson Almeida Filho Ð´µÀ:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> jffs2_xattr_handlers at runtime.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   fs/jffs2/xattr.c | 2 +-
>   fs/jffs2/xattr.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> index 3b6bdc9a49e1..00224f3a8d6e 100644
> --- a/fs/jffs2/xattr.c
> +++ b/fs/jffs2/xattr.c
> @@ -920,7 +920,7 @@ struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
>    * do_jffs2_setxattr(inode, xprefix, xname, buffer, size, flags)
>    *   is an implementation of setxattr handler on jffs2.
>    * -------------------------------------------------- */
> -const struct xattr_handler *jffs2_xattr_handlers[] = {
> +const struct xattr_handler * const jffs2_xattr_handlers[] = {
>   	&jffs2_user_xattr_handler,
>   #ifdef CONFIG_JFFS2_FS_SECURITY
>   	&jffs2_security_xattr_handler,
> diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
> index 1b5030a3349d..7e7de093ec0a 100644
> --- a/fs/jffs2/xattr.h
> +++ b/fs/jffs2/xattr.h
> @@ -94,7 +94,7 @@ extern int do_jffs2_getxattr(struct inode *inode, int xprefix, const char *xname
>   extern int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
>   			     const char *buffer, size_t size, int flags);
>   
> -extern const struct xattr_handler *jffs2_xattr_handlers[];
> +extern const struct xattr_handler * const jffs2_xattr_handlers[];
>   extern const struct xattr_handler jffs2_user_xattr_handler;
>   extern const struct xattr_handler jffs2_trusted_xattr_handler;
>   
> 

