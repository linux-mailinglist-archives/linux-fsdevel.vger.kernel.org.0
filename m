Return-Path: <linux-fsdevel+bounces-42872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D628FA4A752
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 02:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA3D189C525
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB784134B0;
	Sat,  1 Mar 2025 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKKQ5HcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8863A9
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740791749; cv=none; b=UKNnBp48viUreolc9UQA7SGRkHZdjBEHvSVC46Y75pr9b+Diy7z1DtUatJQNQsQg0Ei1396TYzbbX/tbk/8LlfZd8YkGqliGQEdI+Mu4fylIvoZESmzliA7n1vS5Q8uMmnACqndWNG+YhvhpMUPOPMNIkTho/rmcdu7LpNdl5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740791749; c=relaxed/simple;
	bh=gwP/lAwkf+yOnx27eEqF2ecPLEyoDU7PhipvMcy//xc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ILw4jUJQGs7v2/Gne/97g3+a62cg3oXd3LSNPtOIpJoQLYTD3MAE8KLWSMDrAca4wXnpyIINpCJqhUAWp60lfqSthpkXuEtvDn2N76HtFtSXYou6lhqjKgKLwRVzFymGB9L0HA0ZEZUgcngeyVjHy6ran1VDj3po/qywfdTEjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKKQ5HcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0F0C4CED6;
	Sat,  1 Mar 2025 01:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740791748;
	bh=gwP/lAwkf+yOnx27eEqF2ecPLEyoDU7PhipvMcy//xc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vKKQ5HcYczvq1COSyQF8Ci6vVbTOSCTdNyvZE8OSqHMP1rZFxIKslUuicU0uvpCZW
	 OL1qK9IYhpVt0GJbiODPHAzr23L4BvZGQtjjvlQTOTImubOwP4ddlJvIT/KhKcSvDt
	 6cKLF+wCWdu2ExPnj6+RDbib6sI2svJP8tjRvRGCuAVNRLnSCpnlA+++U10z/vLm2+
	 2Uv8VsG0kmJ/GW41upFzM2tnoJrlPD08SLRfDhHjK8D3VPZ1nzNWV8RAmcZM3nZO6z
	 4G9Vs7lnxP2e1fQiiqvdNJw0htDdWbjXqzahuZ70zoYQQsqG61VmMLVILzgVbyo0eW
	 EpgwvoccKx+6w==
Message-ID: <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>
Date: Sat, 1 Mar 2025 09:15:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/27] f2fs: Add f2fs_get_node_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-18-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250218055203.591403-18-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/18 13:51, Matthew Wilcox (Oracle) wrote:
> Change __get_node_page() to return a folio and convert back to a page in
> f2fs_get_node_page() and f2fs_get_node_page_ra().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/f2fs/f2fs.h |  1 +
>   fs/f2fs/node.c | 18 +++++++++++++-----
>   2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index bbaa61da83a8..8f23bb082c6f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3689,6 +3689,7 @@ struct page *f2fs_new_inode_page(struct inode *inode);
>   struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
>   void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
>   struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
> +struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
>   struct page *f2fs_get_node_page_ra(struct page *parent, int start);
>   int f2fs_move_node_page(struct page *node_page, int gc_type);
>   void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index da28e295c701..2d161ddda9c3 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1449,7 +1449,7 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
>   	f2fs_put_page(apage, err ? 1 : 0);
>   }
>   
> -static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
> +static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
>   					struct page *parent, int start)
>   {
>   	struct folio *folio;
> @@ -1462,7 +1462,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>   repeat:
>   	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), nid, false);
>   	if (IS_ERR(folio))
> -		return ERR_CAST(folio);
> +		return folio;
>   
>   	err = read_node_page(&folio->page, 0);
>   	if (err < 0) {
> @@ -1493,7 +1493,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>   	}
>   page_hit:
>   	if (likely(nid == nid_of_node(&folio->page)))
> -		return &folio->page;
> +		return folio;
>   
>   	f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
>   			  nid, nid_of_node(&folio->page), ino_of_node(&folio->page),
> @@ -1512,17 +1512,25 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>   	return ERR_PTR(err);
>   }
>   
> +struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
> +{
> +	return __get_node_folio(sbi, nid, NULL, 0);
> +}
> +
>   struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
>   {
> -	return __get_node_page(sbi, nid, NULL, 0);
> +	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
> +

	if (IS_ERR(folio))
		return ERR_CAST(folio));

> +	return &folio->page;
>   }
>   
>   struct page *f2fs_get_node_page_ra(struct page *parent, int start)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
>   	nid_t nid = get_nid(parent, start, false);
> +	struct folio *folio = __get_node_folio(sbi, nid, parent, start);
>   

	if (IS_ERR(folio))
		return ERR_CAST(folio));

> -	return __get_node_page(sbi, nid, parent, start);
> +	return &folio->page;
>   }
>   
>   static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)


