Return-Path: <linux-fsdevel+bounces-68634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69771C62433
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160BF3ACD66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A280313551;
	Mon, 17 Nov 2025 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kcy0hMvJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBC1531C8;
	Mon, 17 Nov 2025 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351064; cv=none; b=IvEB9FgDvDNE0Hy/a7T6wkzRyZRWmHQwkkXQjXxoSQ7/FHdKdGcRevW2CcD53lxoA0N+uBjrrIfC4RwDlFKEhM8UFy3738uBFRbe1cYeZRaLoFQiOosKJiOrY9DYIJGgpJWLMZl8HwoVZszUYx1eRMK6Yoquf10OB5Bk9PAEkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351064; c=relaxed/simple;
	bh=UOsF7FF7cfDmiMynqnFiTDhHiuFf0AB7wDDlE4Q57RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnfWri5cEKnPdiMAFQbjOIfw6J52J02iabOyrulP0PA5wgjq213p1VTjMOQ1xCEL0hGKBPUKZwJn2yqKerbNIZX97AMQ9VNb7TrgWkuSeLUV0jeoybOQgKOoNqIqfos4L1zHnyQt4vkebdYh0tKydqpTtHmBXyvY8Cx2OrApRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kcy0hMvJ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763351058; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xM/7SlXR05QhJ9/aqpWKEmKID+CL6RpEJ9yf+AkBzU8=;
	b=Kcy0hMvJf6qLPwl35JJSXafm0mcN9MWnV/AUlrt3gPBEnFu0M0oM9SGJtICZKJ1+bJms5yT/ZwSi5PD4V/4tJAql0DdJkuDoOWH7BWdVKSQLEhI/49P/zWoS+mJhErtk1iWgDqw1HmOAKhKkcz+wREXdq9livGjZ5xFSE0ypHMw=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsU-ZOC_1763351056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:44:17 +0800
Message-ID: <40b291a4-ea32-4450-ab67-0c9c96a3d601@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:44:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/14 17:55, Hongbo Li wrote:
> This patch adds inode page cache sharing functionality for unencoded
> files.
> 
> I conducted experiments in the container environment. Below is the
> memory usage for reading all files in two different minor versions
> of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c     | 38 +++++++++++++++---
>   fs/erofs/inode.c    |  5 +++
>   fs/erofs/internal.h |  4 ++
>   fs/erofs/ishare.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++-
>   fs/erofs/ishare.h   | 18 +++++++++
>   fs/erofs/super.c    | 11 +++--
>   6 files changed, 163 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index bd3d85c61341..c459104e4734 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "internal.h"
> +#include "ishare.h"

Can we just get rid of another "ishare.h", these can be moved into
internal.h:

#ifdef CONFIG_EROFS_FS_INODE_SHARE

int erofs_ishare_init(struct super_block *sb);
void erofs_ishare_exit(struct super_block *sb);
bool erofs_ishare_fill_inode(struct inode *inode);
void erofs_ishare_free_inode(struct inode *inode);

#else

static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
static inline void erofs_ishare_exit(struct super_block *sb) {}
static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
static inline void erofs_ishare_free_inode(struct inode *inode) {}

#endif // CONFIG_EROFS_FS_INODE_SHARE

>   #include <linux/sched/mm.h>
>   #include <trace/events/erofs.h>
>   
> @@ -269,23 +270,27 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   struct erofs_iomap_iter_ctx {
>   	struct page *page;
>   	void *base;
> +	struct inode *realinode;
>   };
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>   {
> -	int ret;
>   	struct erofs_iomap_iter_ctx *ctx;
> -	struct super_block *sb = inode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	struct iomap_iter *iter;
> +	struct inode *realinode;
> +	struct super_block *sb;

	struct inode *realinode = ctx ? ctx->realinode : inode;
	struct super_block *sb = realinode->i_sb;

> +	int ret;
>   
>   	iter = container_of(iomap, struct iomap_iter, iomap);
>   	ctx = iter->private;
> +	realinode = ctx ? ctx->realinode : inode;
> +	sb = realinode->i_sb;
>   	map.m_la = offset;
>   	map.m_llen = length;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(realinode, &map);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -300,7 +305,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		return 0;
>   	}
>   
> -	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
> +	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
>   		mdev = (struct erofs_map_dev) {
>   			.m_deviceid = map.m_deviceid,
>   			.m_pa = map.m_pa,
> @@ -326,7 +331,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   
>   			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> -						 erofs_inode_in_metabox(inode));
> +						 erofs_inode_in_metabox(realinode));
>   			if (IS_ERR(ptr))
>   				return PTR_ERR(ptr);
>   			iomap->inline_data = ptr;

...

>   
> @@ -234,3 +248,83 @@ const struct file_operations erofs_ishare_fops = {
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };
> +
> +void erofs_read_begin(struct erofs_read_ctx *rdctx)

I think if backing_head, backing_link (although I don't like
the naming) is valid, erofs_read_begin() and erofs_read_end()
is unneeded here.

Since we maintain the backing validity using .open() and
.release() hooks.

the odd erofs_read_{begin,end} can be avoided then...

Thanks,
Gao Xiang

