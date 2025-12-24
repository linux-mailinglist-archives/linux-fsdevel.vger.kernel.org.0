Return-Path: <linux-fsdevel+bounces-72035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E20CDBA6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 09:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34FAA302177F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930082D23A8;
	Wed, 24 Dec 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lMIsOteE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34041FB1;
	Wed, 24 Dec 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564333; cv=none; b=tbRXCVeZUis1rXME8WNWbtTi61+EkyB83VWHDjC1GtNB8Ouv1Ewgc66bqpg9nzx4yovyq1SBLJtMXwIci6EzBpJyVGeMbcVe5tuWgVMQ9rSNmESB1bAt8YsFbTNDEOqQgG2bJEUT6dBS7cYS9jnThPBO+6Ep4Q36O57Bh/To2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564333; c=relaxed/simple;
	bh=J7y61VH7++0dYWxjHUnzEBiRQoUGNY34sbLcxf25x3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pscaXFIkDiqSf56OPAgThlrJSvCCrqtQ9Zq4XE97bzFQnJ9+O90+CCmPvJz+YbvqckPcU8kdeA1VRmfSkoCeChNcwxGZXSyLubiW0ocTX7hLrISJe8CiKrU10IHHj+ygzqdaB+DBtX49FkALDHmfkhVBjL7vFc1bLT9ctuT8Y2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lMIsOteE; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766564327; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vmfl4kJe7qnG1RuxB0cXFeB4KzCnrLvhP6qlpFEYlNI=;
	b=lMIsOteEvrJKRerR9opse+oF36BQ9ZfOU37eDHT12lzGFyfsJ9HWDgvUEcjgtQ/0t9KKl6ckB/HBhRQmmVWYTNSnlNVKrOzyECP74I19vlYBaOWDu7B4Im+msl0JtH+6wKVYVJvXJwKF7sQKXwjzr1uRHwQnEibykFZpIR+PG9I=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaaH5I_1766564326 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 16:18:46 +0800
Message-ID: <0185cd6f-791b-41b4-a741-8004a8d43fdf@linux.alibaba.com>
Date: Wed, 24 Dec 2025 16:18:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/zdata.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 65da21504632..759f3fe225c9 100644
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
> @@ -1884,9 +1884,13 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   {
>   	struct inode *const inode = folio->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
> +	bool need_iput = false;
> +	struct inode *realinode = erofs_real_inode(inode, &need_iput);
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));

Why not just
	Z_EROFS_DEFINE_FRONTEND(f, realinode, folio_pos(folio));
?

>   	int err;
>   
> +	DBG_BUGON(!realinode);

Remove this line

> +	f.inode = realinode;
>   	trace_erofs_read_folio(folio, false);
>   	z_erofs_pcluster_readmore(&f, NULL, true);
>   	err = z_erofs_scan_folio(&f, folio, false);
> @@ -1896,23 +1900,30 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
>   	struct inode *const inode = rac->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> +	bool need_iput;
> +	struct inode *realinode = erofs_real_inode(inode, &need_iput);
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));

Why not just
	Z_EROFS_DEFINE_FRONTEND(f, realinode, folio_pos(folio));
?

>   	unsigned int nrpages = readahead_count(rac);
>   	struct folio *head = NULL, *folio;
>   	int err;
>   
> -	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
> +	DBG_BUGON(!realinode);

Remove this line.

Thanks,
Gao Xiang

> +	f.inode = realinode;
> +	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
>   	z_erofs_pcluster_readmore(&f, rac, true);
>   	while ((folio = readahead_folio(rac))) {
>   		folio->private = head;
> @@ -1926,8 +1937,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   
>   		err = z_erofs_scan_folio(&f, folio, true);
>   		if (err && err != -EINTR)
> -			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
> -				  folio->index, EROFS_I(inode)->nid);
> +			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
> +				  folio->index, EROFS_I(realinode)->nid);
>   	}
>   	z_erofs_pcluster_readmore(&f, rac, false);
>   	z_erofs_pcluster_end(&f);
> @@ -1935,6 +1946,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   	(void)z_erofs_runqueue(&f, nrpages);
>   	erofs_put_metabuf(&f.map.buf);
>   	erofs_release_pages(&f.pagepool);
> +
> +	if (need_iput)
> +		iput(realinode);
>   }
>   
>   const struct address_space_operations z_erofs_aops = {


