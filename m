Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC3403670
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351074AbhIHI5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 04:57:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15392 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbhIHI5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:57:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H4G9Z5dvHzR0cJ;
        Wed,  8 Sep 2021 16:52:34 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 16:56:25 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 8 Sep 2021 16:56:25 +0800
Subject: Re: [PATCH] ramfs: fix mount source show for ramfs
To:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>
CC:     <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yukuai3@huawei.com>
References: <20210811122811.2288041-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <720f6c7a-6745-98ad-5c71-7747857a7f01@huawei.com>
Date:   Wed, 8 Sep 2021 16:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210811122811.2288041-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, this patch seems still leave in linux-next, should we pull it to
mainline?

在 2021/8/11 20:28, yangerkun 写道:
> ramfs_parse_param does not parse key "source", and will convert
> -ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
> vfs_parse_fs_param, which lead always "none" mount source for ramfs. Fix
> it by parse "source" in ramfs_parse_param.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/ramfs/inode.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 65e7e56005b8..0d7f5f655fd8 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -202,6 +202,10 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	struct ramfs_fs_info *fsi = fc->s_fs_info;
>   	int opt;
>   
> +	opt = vfs_parse_fs_param_source(fc, param);
> +	if (opt != -ENOPARAM)
> +		return opt;
> +
>   	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
>   	if (opt < 0) {
>   		/*
> 
