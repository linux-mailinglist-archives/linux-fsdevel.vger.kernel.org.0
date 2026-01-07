Return-Path: <linux-fsdevel+bounces-72580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60ACFC29D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 07:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5DF301D585
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031A227BB5;
	Wed,  7 Jan 2026 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ftxfr6Ww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAA3C2F;
	Wed,  7 Jan 2026 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766538; cv=none; b=SEHvSmIpVRBStJF6Flnw5mlFCDyfnGa1PgcIpSmobWyrsWVx37uGiuYy8+WRgFePX8qIhRlipzlCukCW3skL+FWE7p4F5Lr0+Cz4WjmXpfUf37mokQx88rvisItxF0M2T6QzQRFAOHcE3BFkeLWVS5q8ooZ3+s+Ykp3HmoaO0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766538; c=relaxed/simple;
	bh=qhl3GFHbp81NEdmDMYz8b+s1USJTwNSOnZsqHRTL2oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEB10gonjzUzrV/PIMWzOzHGK2UII+FVQ2HALypo4wc99EZhrUb0wRZFa2wQxSIT3yP2exicgpkaPymCV5+MspCBBWZqJ3ZcfGyvyGwxbbiiDXTv3OoUuMsUkXl4ZDXsICI75esy6z14W7lI4lYXtY6eo3K8CjI7bGuT7tZplQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ftxfr6Ww; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767766531; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kX0ibGMw8jtyCB1R4U6zfSTnINLFtE0rYeIUZULlvYE=;
	b=ftxfr6WwgBOpi/VgZacYd21paAaw5zPlNAvcKE2Yihef4d1xJRdtiZPlIcpwQvHDnUZkvlF9aaWaMoiSHPN3e/G1fwetmis1yNndbGsikxYWaugtZuBWGwi+zqvQuDbzWcrSeZZdVXu/5FaUyjzu6D7QFnizGoARcp4ExLSWzqo=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXjML4_1767766529 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 14:15:30 +0800
Message-ID: <ee332277-b19f-4c7c-9114-6fc19878ed43@linux.alibaba.com>
Date: Wed, 7 Jan 2026 14:15:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251231090118.541061-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/31 17:01, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/zdata.c | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 65da21504632..2697c703a4c4 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -493,7 +493,8 @@ enum z_erofs_pclustermode {
>   };
>   
>   struct z_erofs_frontend {
> -	struct inode *const inode;
> +	struct inode *inode;
> +	struct inode *sharedinode;

Let's combine these two lines into one for two related inodes?

	struct inode *inode, *sharedinode;

>   	struct erofs_map_blocks map;
>   	struct z_erofs_bvec_iter biter;
>   
> @@ -508,8 +509,8 @@ struct z_erofs_frontend {
>   	unsigned int icur;
>   };
>   
> -#define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
> -	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
> +#define Z_EROFS_DEFINE_FRONTEND(fe, i, si, ho) struct z_erofs_frontend fe = { \
> +	.inode = i, .sharedinode = si, .head = Z_EROFS_PCLUSTER_TAIL, \
>   	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
>   
>   static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
> @@ -1866,7 +1867,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   		pgoff_t index = cur >> PAGE_SHIFT;
>   		struct folio *folio;
>   
> -		folio = erofs_grab_folio_nowait(inode->i_mapping, index);
> +		folio = erofs_grab_folio_nowait(f->sharedinode->i_mapping, index);
>   		if (!IS_ERR_OR_NULL(folio)) {
>   			if (folio_test_uptodate(folio))
>   				folio_unlock(folio);
> @@ -1883,8 +1884,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   
>   static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct inode *const inode = folio->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
> +	struct inode *const sharedinode = folio->mapping->host;

Let's drop useless const annotation:

	struct inode *sharedinode = folio->mapping->host;

> +	bool need_iput;
> +	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
> +	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, folio_pos(folio));
>   	int err;
>   
>   	trace_erofs_read_folio(folio, false);
> @@ -1896,23 +1899,28 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   	/* if some pclusters are ready, need submit them anyway */
>   	err = z_erofs_runqueue(&f, 0) ?: err;
>   	if (err && err != -EINTR)
> -		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
> -			  err, folio->index, EROFS_I(inode)->nid);
> +		erofs_err(realinode->i_sb, "read error %d @ %lu of nid %llu",
> +			  err, folio->index, EROFS_I(realinode)->nid);
>   
>   	erofs_put_metabuf(&f.map.buf);
>   	erofs_release_pages(&f.pagepool);
> +
> +	if (need_iput)
> +		iput(realinode);
>   	return err;
>   }
>   
>   static void z_erofs_readahead(struct readahead_control *rac)
>   {
> -	struct inode *const inode = rac->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> +	struct inode *const sharedinode = rac->mapping->host;

Same here.
	struct inode *sharedinode = rac->mapping->host;

Thanks,
Gao Xiang

