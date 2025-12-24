Return-Path: <linux-fsdevel+bounces-72034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD105CDBA5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 09:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A65D63019B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135023E355;
	Wed, 24 Dec 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fvlYlZPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C321FB1;
	Wed, 24 Dec 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564144; cv=none; b=oqgrE8ftBXwA8KeXcldKB9EiXiHIcN+R+W0RFJrZT3Ssqzxuv7Qx+zJgODm7FIDGbva2ZEvOR2b7jINPmq8hL6fHXDGwcZWDzhkLPS8FiLjgIVCzqUCTxoaKinhzc9680PpcJ2fcsEUmHGFsXTPljcybp6qxckQkdtlVCio6uK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564144; c=relaxed/simple;
	bh=SBy60DwRvJ0bD3Unmlcv8b9xSSB976Xj8wcUlep7TIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AF0/3PfIBk5nSVXT/2Y+jwdx9887KYwf+sc31E5cc3h+MfyJ/GfYXJyiXkkrLgzf7yw3Iu8yhcLT1Ugs6Do+kAWuY5ShbQcBZlJHhLBhykLMdNp67/s7FBj7t6xwCt+tKqR3bJflsrgM+OQPe+2i+tgvnKQR2ruZN8kv0cTpwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fvlYlZPB; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766564135; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HvNtWBYHjlKadnKRSAAlto1QAZJUw+2Q2TRFjKQurLY=;
	b=fvlYlZPBOb4tSBJqwU89Q6fQrKvrG2m2xpJFkOIEyOwYLaonMgtd/JlvSgn4CDhDj2hX6tgVsT8Ua4d49BscYOWENp3lmmJyA/W9lf6hfsl4NGUqv+glmrau3fROXN6to4yqIS5Fcr2+1B6rwknY22zlAo2u/NtSUISsvPeCq4I=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaNGZF_1766564134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 16:15:35 +0800
Message-ID: <7898bedf-0c02-432b-999a-01437265b51b@linux.alibaba.com>
Date: Wed, 24 Dec 2025 16:15:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/24 12:09, Hongbo Li wrote:
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
>   fs/erofs/data.c     | 32 +++++++++++++++++++++++++-------
>   fs/erofs/inode.c    |  4 ++++
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/ishare.c   | 31 +++++++++++++++++++++++++++++++
>   4 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..cbe7ac194b09 100644
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
> @@ -379,30 +381,44 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct inode *inode = folio_inode(folio);
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.cur_folio	= folio,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput = false;

	`bool need_iput` is enough, see below.

> +	struct erofs_iomap_iter_ctx iter_ctx = {> +		.realinode	= erofs_real_inode(inode, &need_iput),
> +	};
>   
> +	DBG_BUGON(!iter_ctx.realinode);

just remove this line, since erofs_real_inode() already has this check.


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
> +	bool need_iput = false;

	`bool need_iput` is enough, see below.

> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),
> +	};
>   
> +	DBG_BUGON(!iter_ctx.realinode);

just remove this line, since erofs_real_inode() already has this check.

>   	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>   					readahead_count(rac), true);
>   
>   	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> @@ -423,7 +439,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
> +		if (erofs_ishare_fill_inode(inode))
> +			inode->i_fop = &erofs_ishare_fops;
> +#endif
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a2b2434ee3c8..6930cce8f1fb 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -565,11 +565,13 @@ int __init erofs_init_ishare(void);
>   void erofs_exit_ishare(void);
>   bool erofs_ishare_fill_inode(struct inode *inode);
>   void erofs_ishare_free_inode(struct inode *inode);
> +struct inode *erofs_real_inode(struct inode *inode, bool *need_iput);
>   #else
>   static inline int erofs_init_ishare(void) { return 0; }
>   static inline void erofs_exit_ishare(void) {}
>   static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
>   static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +static inline struct inode *erofs_real_inode(struct inode *inode, bool *need_iput) { return inode; }

static inline struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
{
	*need_iput = false;
	return inode;
}

>   #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>   
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 09ea456f2eab..634b7ea63738 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -11,6 +11,12 @@
>   
>   static struct vfsmount *erofs_ishare_mnt;
>   
> +static inline bool erofs_is_ishare_inode(struct inode *inode)
> +{
> +	/* assumed FS_ONDEMAND is excluded with FS_PAGE_CACHE_SHARE feature */
> +	return inode->i_sb->s_type == &erofs_anon_fs_type;
> +}
> +
>   static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>   {
>   	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
> @@ -157,6 +163,31 @@ const struct file_operations erofs_ishare_fops = {
>   	.splice_read	= filemap_splice_read,
>   };
>   
> +struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +	struct inode *realinode;

	*need_iput = false;
here

Thanks,
Gao Xiang

> +
> +	if (!erofs_is_ishare_inode(inode))
> +		return inode;
> +
> +	vi_dedup = EROFS_I(inode);
> +	spin_lock(&vi_dedup->ishare_lock);
> +	/* fetch any one as real inode */
> +	DBG_BUGON(list_empty(&vi_dedup->ishare_list));
> +	list_for_each_entry(vi, &vi_dedup->ishare_list, ishare_list) {
> +		realinode = igrab(&vi->vfs_inode);
> +		if (realinode) {
> +			*need_iput = true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&vi_dedup->ishare_lock);
> +
> +	DBG_BUGON(!realinode);
> +	return realinode;
> +}
> +
>   int __init erofs_init_ishare(void)
>   {
>   	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);


