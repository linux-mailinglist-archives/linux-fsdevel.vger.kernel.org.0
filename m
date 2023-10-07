Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366D57BC3D7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjJGBjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGBjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:39:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7702B6;
        Fri,  6 Oct 2023 18:39:29 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S2SZf54PBzrTNN;
        Sat,  7 Oct 2023 09:36:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 09:39:26 +0800
Subject: Re: [PATCH 25/29] ubifs: move ubifs_xattr_handlers to .rodata
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-26-wedsonaf@gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3b1f3981-639b-83ea-a691-b919f9838644@huawei.com>
Date:   Sat, 7 Oct 2023 09:39:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230930050033.41174-26-wedsonaf@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> ubifs_xattr_handlers at runtime.
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   fs/ubifs/ubifs.h | 2 +-
>   fs/ubifs/xattr.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 4c36044140e7..8a9a66255e7e 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -2043,7 +2043,7 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
>   			size_t size);
>   
>   #ifdef CONFIG_UBIFS_FS_XATTR
> -extern const struct xattr_handler *ubifs_xattr_handlers[];
> +extern const struct xattr_handler * const ubifs_xattr_handlers[];
>   ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size);
>   void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum);
>   int ubifs_purge_xattrs(struct inode *host);
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 349228dd1191..5e17e9591e6e 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -735,7 +735,7 @@ static const struct xattr_handler ubifs_security_xattr_handler = {
>   };
>   #endif
>   
> -const struct xattr_handler *ubifs_xattr_handlers[] = {
> +const struct xattr_handler * const ubifs_xattr_handlers[] = {
>   	&ubifs_user_xattr_handler,
>   	&ubifs_trusted_xattr_handler,
>   #ifdef CONFIG_UBIFS_FS_SECURITY
> 

