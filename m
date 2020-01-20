Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453F41429C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 12:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgATLpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 06:45:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgATLpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:45:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F8E6EBFB9287DB8B0BD;
        Mon, 20 Jan 2020 19:45:01 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 19:44:52 +0800
Subject: Re: [PATCH] jffs2: move jffs2_init_inode_info() just after allocating
 inode
To:     <viro@zeniv.linux.org.uk>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yihuaijie@huawei.com>,
        <zhongguohua1@huawei.com>, <chenjie6@huawei.com>
References: <20200106080411.41394-1-yi.zhang@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <1559fa23-525b-5dad-220e-2ab2821d33eb@huawei.com>
Date:   Mon, 20 Jan 2020 19:44:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200106080411.41394-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping.

On 2020/1/6 16:04, zhangyi (F) wrote:
> After commit 4fdcfab5b553 ("jffs2: fix use-after-free on symlink
> traversal"), it expose a freeing uninitialized memory problem due to
> this commit move the operaion of freeing f->target to
> jffs2_i_callback(), which may not be initialized in some error path of
> allocating jffs2 inode (eg: jffs2_iget()->iget_locked()->
> destroy_inode()->..->jffs2_i_callback()->kfree(f->target)).
> 
> Fix this by initialize the jffs2_inode_info just after allocating it.
> 
> Reported-by: Guohua Zhong <zhongguohua1@huawei.com>
> Reported-by: Huaijie Yi <yihuaijie@huawei.com>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/jffs2/fs.c    | 2 --
>  fs/jffs2/super.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
> index ab8cdd9e9325..50a9df7d43a5 100644
> --- a/fs/jffs2/fs.c
> +++ b/fs/jffs2/fs.c
> @@ -270,7 +270,6 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
>  	f = JFFS2_INODE_INFO(inode);
>  	c = JFFS2_SB_INFO(inode->i_sb);
>  
> -	jffs2_init_inode_info(f);
>  	mutex_lock(&f->sem);
>  
>  	ret = jffs2_do_read_inode(c, f, inode->i_ino, &latest_node);
> @@ -438,7 +437,6 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
>  		return ERR_PTR(-ENOMEM);
>  
>  	f = JFFS2_INODE_INFO(inode);
> -	jffs2_init_inode_info(f);
>  	mutex_lock(&f->sem);
>  
>  	memset(ri, 0, sizeof(*ri));
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 0e6406c4f362..90373898587f 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -42,6 +42,8 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
>  	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
>  	if (!f)
>  		return NULL;
> +
> +	jffs2_init_inode_info(f);
>  	return &f->vfs_inode;
>  }
>  
> 

