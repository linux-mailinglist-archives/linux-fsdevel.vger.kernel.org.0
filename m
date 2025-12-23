Return-Path: <linux-fsdevel+bounces-71963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF5CD8720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1DE3030906
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A122C31A542;
	Tue, 23 Dec 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pwVKf8H6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37931987D;
	Tue, 23 Dec 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766477933; cv=none; b=cenHKnQUS2dv0xDgu/ejSmL/iY8S1LszDllOrTEsb2RfsaEYFNz0NaF9DzbGjytdJ29AZsrJEGuETSpzACys3B9m1C+gpSlqSLwrvmHN89p7fICedrrgD3u7YbkC9FJ0Ws6aIsNpezJb2oiWNk0ZK28zQC06jmKJVXc47OMnZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766477933; c=relaxed/simple;
	bh=iP/yeclhE3q7laZb8EK21IwSMRC1itdEfesHVgjXseY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPPEfOzY5cuQ4khK8FBqKuIeTgs4zHh6Tvst62IOPXKbip0S2F7FwiYOiUMOykNiMaS+AJaSWVRdKu74pjg7OcJaGIN8bm0up66B4YoScRyNm1NGmzV0JYy7oo/alELZZZfcINEALY2PLvEPMZXF8VmJ9SLyv3Sku3ahMsN1oXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pwVKf8H6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766477926; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nl5MwHnazquKRYPLmeRjaf6HhBiE4sUlehAEkIPwR+A=;
	b=pwVKf8H6Q79eYfu74DQHC6sOIszOf0R6ykTb5eBjkQVDyMijMhJiyXIKQx5iMBpVsqOdv9GDhWMPiBnz3DuEl3G1BTof8Q3gg4Cx92zfbt4XVmpzoYGytI0NP4BXlQnFGjhzbgBd9PluCOEN1ECGPBBwp0YDORjWh67f4b2RVd4=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX2CYI_1766477924 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:18:45 +0800
Message-ID: <a43ac775-aa82-44cc-ab01-9126eba98e75@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/zdata.c | 42 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 65da21504632..465918093984 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
>   };
>   
>   struct z_erofs_frontend {
> -	struct inode *const inode;
> +	struct inode *inode;
>   	struct erofs_map_blocks map;
>   	struct z_erofs_bvec_iter biter;
>   
> @@ -1883,10 +1883,18 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   
>   static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct inode *const inode = folio->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
> +	struct inode *const inode = folio->mapping->host, *realinode;
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));
>   	int err;
>   
> +	if (erofs_is_ishare_inode(inode))
> +		realinode = erofs_ishare_iget(inode);
> +	else
> +		realinode = inode;

I don't think it makes any sense to differ those two cases, just

	struct inode *inode = folio->mapping->host;
	struct inode *realinode = erofs_get_real_inode(inode);
	Z_EROFS_DEFINE_FRONTEND(f, realinode, folio_pos(folio));

...

> +
> +	if (!realinode)
> +		return -EIO;

That is an impossible case, just `DBG_BUGON(!realinode);`

> +	f.inode = realinode;
>   	trace_erofs_read_folio(folio, false);
>   	z_erofs_pcluster_readmore(&f, NULL, true);
>   	err = z_erofs_scan_folio(&f, folio, false);
> @@ -1896,23 +1904,34 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
> +	if (erofs_is_ishare_inode(inode))
> +		erofs_ishare_iput(realinode);

	erofs_put_real_inode(realinode);

>   	return err;
>   }
>   
>   static void z_erofs_readahead(struct readahead_control *rac)
>   {
> -	struct inode *const inode = rac->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> +	struct inode *const inode = rac->mapping->host, *realinode;
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));
>   	unsigned int nrpages = readahead_count(rac);
>   	struct folio *head = NULL, *folio;
>   	int err;
>   
> -	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
> +	if (erofs_is_ishare_inode(inode))
> +		realinode = erofs_ishare_iget(inode);
> +	else
> +		realinode = inode;
> +
> +	if (!realinode)
> +		return;
> +	f.inode = realinode;

Same here.

Thanks,
Gao Xiang

