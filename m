Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2F3D0A5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhGUH3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 03:29:07 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:41476 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhGUH1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:27:21 -0400
DKIM-Signature: a=rsa-sha256;
        b=Oq7ucI7cOEz3YT5+tpsXb8SnX4l2s3WvTgtwwJGeWlz9ba4H7tJEwim4eXtQBgyI7Ybqi4CZd9wXphclQOuZhxoyFQB3gXaDn6RbmyvwRoEMf5vendbyL714FO04o1Ri2DmZ5grykpvoPs7UvsbqMxvwIxnRvR61uWHjBreUvNc=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=SF+ygtvBfcYPbmC1D6tZgdZGrjGqPciVxZWao+csWPc=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.25.44.145] (unknown [58.251.74.232])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 0410EAC00A7;
        Wed, 21 Jul 2021 16:07:54 +0800 (CST)
Subject: Re: [PATCH v3] fuse: use newer inode info when writeback cache is
 enabled
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
References: <20210629130311.238638-1-changfengnan@vivo.com>
From:   Fengnan Chang <changfengnan@vivo.com>
Message-ID: <1acffbf7-3826-6125-f5b8-476cef2b1bbc@vivo.com>
Date:   Wed, 21 Jul 2021 16:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210629130311.238638-1-changfengnan@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJPGkxWQkoZQk9NSxpIGE
        9DVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6Lhw5Qz9DSVFNH0ozGg89
        DgIKFB1VSlVKTUlNQ05PQ0xOT0xNVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSE9MTTcG
X-HM-Tid: 0a7ac81b5fdcb039kuuu0410eac00a7
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi miklos：

    Have you test this version? Is there any problem ?

Thanks.
	

On 2021/6/29 21:03, Fengnan Chang wrote:
> When writeback cache is enabled, the inode information in cached is
> considered new by default, and the inode information of lowerfs is
> stale.
> When a lower fs is mount in a different directory through different
> connection, for example PATHA and PATHB, since writeback cache is
> enabled by default, when the file is modified through PATHA, viewing the
> same file from the PATHB, PATHB will think that cached inode is newer
> than lowerfs, resulting in file size and time from under PATHA and PATHB
> is inconsistent.
> Add a judgment condition to check whether to use the info in the cache
> according to mtime.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/fuse/fuse_i.h | 6 ++++++
>   fs/fuse/inode.c  | 4 +++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 07829ce78695..98fc2ba91a03 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -909,6 +909,12 @@ static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
>   	for (i = index; i < index + nr_pages; i++)
>   		descs[i].length = PAGE_SIZE - descs[i].offset;
>   }
> +static inline bool attr_newer_than_local(struct fuse_attr *attr, struct inode *inode)
> +{
> +	return (attr->mtime > inode->i_mtime.tv_sec) ||
> +		((attr->mtime == inode->i_mtime.tv_sec) &&
> +		 (attr->mtimensec > inode->i_mtime.tv_nsec));
> +}
>   
>   /** Device operations */
>   extern const struct file_operations fuse_dev_operations;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b9beb39a4a18..32545f488274 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -241,8 +241,10 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>   	 * extend local i_size without keeping userspace server in sync. So,
>   	 * attr->size coming from server can be stale. We cannot trust it.
>   	 */
> -	if (!is_wb || !S_ISREG(inode->i_mode))
> +	if (!is_wb || !S_ISREG(inode->i_mode)
> +		|| (attr_newer_than_local(attr, inode) && !inode_is_open_for_write(inode))) {
>   		i_size_write(inode, attr->size);
> +	}
>   	spin_unlock(&fi->lock);
>   
>   	if (!is_wb && S_ISREG(inode->i_mode)) {
> 
