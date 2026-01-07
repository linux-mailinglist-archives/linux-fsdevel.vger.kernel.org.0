Return-Path: <linux-fsdevel+bounces-72579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34BCFC284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 07:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CEE23016FA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2826ED5C;
	Wed,  7 Jan 2026 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GURsP/M3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D713AD26;
	Wed,  7 Jan 2026 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766367; cv=none; b=dBcN3dgPxxwmmTH5FMZJol7OM+wLYFvUeyDCOXIb41uTIg/ShnItswhI1v/2DtKEfXBHBbnBQMwcEcQ7FBQfV72GD7V2xmhyM4SGPpQN9hZzKcWs9O8XfOyepQUHP7k0TmEwUmc7G/gTzmVzAL31BQ3wI13UVBrUmg3mGpURTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766367; c=relaxed/simple;
	bh=yEctpp3vx6nQAafBTxiT03NkALmCnMCBFkxYy/O35yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzhuE3xwQ9l7aNbkmNU4q+gSt6h1k821dQboi7X5C8L/Oi/CitsbFdM4zMVd+rqfE8jK4zIu9ad4qfHpyf9h205b8W70JqWxkXQhR3C19XEUk+Dkk6ZfB4ewCK/Kt9t6kcwSdeQwvDLljMBq4BvMuE6hpWlMr6FijkrSSrd/wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GURsP/M3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767766355; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mwmjvvbd3+Vmc8YWs9Hwuvv41Bmm+2Ldip6b99XrSHY=;
	b=GURsP/M3aTxJryNohnVsSR3wLwVdiqaEL8BpWX6JhC+L1UaTl1rTHkRxQicQvkOF7X8Z/iPiYeN/QTHqi9ubt09SmVVFTk/9xUwDfTZYVF5TnNelCjOvArm2JRLFRCN5XLjkOfMHZ5o+mj+eKLu0AiqRu2WAeFBkICtQ9dv9Iso=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXjKuu_1767766354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 14:12:34 +0800
Message-ID: <d31cd92b-56ba-4798-bc88-5bf4999a2437@linux.alibaba.com>
Date: Wed, 7 Jan 2026 14:12:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251231090118.541061-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/31 17:01, Hongbo Li wrote:
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
>   fs/erofs/data.c     | 30 +++++++++++++++++++++++-------
>   fs/erofs/inode.c    |  4 ++++
>   fs/erofs/internal.h |  6 ++++++
>   fs/erofs/ishare.c   | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..5fc8e3ce0d9e 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   struct erofs_iomap_iter_ctx {
>   	struct page *page;
>   	void *base;
> +	struct inode *realinode;
>   };
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> @@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   {
>   	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
>   	struct erofs_iomap_iter_ctx *ctx = iter->private;
> -	struct super_block *sb = inode->i_sb;
> +	struct inode *realinode = ctx ? ctx->realinode : inode;
> +	struct super_block *sb = realinode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	int ret;
>   
>   	map.m_la = offset;
>   	map.m_llen = length;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(realinode, &map);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		return 0;
>   	}
>   
> -	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
> +	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
>   		mdev = (struct erofs_map_dev) {
>   			.m_deviceid = map.m_deviceid,
>   			.m_pa = map.m_pa,
> @@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			void *ptr;
>   
>   			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> -						 erofs_inode_in_metabox(inode));
> +						 erofs_inode_in_metabox(realinode));
>   			if (IS_ERR(ptr))
>   				return PTR_ERR(ptr);
>   			iomap->inline_data = ptr;
> @@ -379,30 +381,42 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct inode *inode = folio_inode(folio);
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.cur_folio	= folio,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),
> +	};
>   
>   	trace_erofs_read_folio(folio, true);
>   
>   	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   	return 0;
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +	struct inode *inode = rac->mapping->host;
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.rac		= rac,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),
> +	};
>   
>   	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>   					readahead_count(rac), true);
>   
>   	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> @@ -423,7 +437,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>   #endif
>   	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
> -		struct erofs_iomap_iter_ctx iter_ctx = {};
> +		struct erofs_iomap_iter_ctx iter_ctx = {
> +			.realinode = inode,
> +		};
>   
>   		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>   				    NULL, 0, &iter_ctx, 0);
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index bce98c845a18..8116738fe432 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -215,6 +215,10 @@ static int erofs_fill_inode(struct inode *inode)
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
>   		inode->i_fop = &erofs_file_fops;
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE

Is that unnecessary?

It seems erofs_ishare_fill_inode() will return false if
CONFIG_EROFS_FS_PAGE_CACHE_SHARE is undefined.

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

