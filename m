Return-Path: <linux-fsdevel+bounces-39224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F1A1177F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 03:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7297A1C72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F922DF9B;
	Wed, 15 Jan 2025 02:54:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [188.121.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221A22E3E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909667; cv=none; b=XLL9GgKzCdGlPILAeNQ4ILZmT2EA+dM8ctoR/1KIf2M43xcsTuu4Q01SMzYV+nrdKU8S5XGv2IIPKhsukVKatqfXOS9kJwVzJ4QbvIdeMZiK5yfX3zR0LJ/5tNBoC4+LpA7Fe11f0a5h1lQIUPCFakmJEGXUJfCpaS9neCSwWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909667; c=relaxed/simple;
	bh=dpwWf+m75OkqfJTiSdciwyHJNdVXyBieuBUHOhecWYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTOpLP2tszUZmCa8HYFzdr6coulhi3uf7O3dVfEhbQFq+89/cUCNjiciLDT01ymCLdlEz8XEe/EKxVdnrW7YNU0QDg/OOoZ84PWwhnOqVtvQ/OP2RYQ3dKwuvLbM/hmkZuLVn+FeluoJ8VTCT2ppbF51H8iEw5jfwrt2roYgFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoCEtPK8Px4XtXoCFtujmE; Tue, 14 Jan 2025 14:11:35 -0700
X-CMAE-Analysis: v=2.4 cv=Fa3NxI+6 c=1 sm=1 tr=0 ts=6786d307
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=PXAFGWOKMHoxhg3sn_wA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <8c391f15-b30c-4d2d-856e-0eb74f68e433@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:11:09 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] squashfs: Use a folio throughout
 squashfs_read_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241220224634.723899-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfENWepOiRwFkYR6Vlt7hCMenpMy5wn5og774Ssac3cKZjajAc7lAai1e/GWEjMfzSKouO/N+rOv48c2CpVQKcl4K+A8pUume9vE0T5uHIRbRmfLUalYg
 VXWu5Wg/2GXce9N9HlkOI9tnJMDoQqk62gGQNLNHHIgZWs9E47oj1kI7bwU1pqgNmmx8LNzWgIGXsxGL2JvRZ30p0y3sumLAnow3Hz3JfAfiQnsjxmpaIbTH
 Dz+o1Wyd9TwiZXhGWX1dZHHccnBLR+5Hq7WyX2vV1hw=



On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
> Use modern folio APIs where they exist and convert back to struct
> page for the internal functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/file.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 21aaa96856c1..bc6598c3a48f 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -445,21 +445,19 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
>   
>   static int squashfs_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct page *page = &folio->page;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> -	int index = page->index >> (msblk->block_log - PAGE_SHIFT);
> +	int index = folio->index >> (msblk->block_log - PAGE_SHIFT);
>   	int file_end = i_size_read(inode) >> msblk->block_log;
>   	int expected = index == file_end ?
>   			(i_size_read(inode) & (msblk->block_size - 1)) :
>   			 msblk->block_size;
>   	int res = 0;
> -	void *pageaddr;
>   
>   	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
> -				page->index, squashfs_i(inode)->start);
> +				folio->index, squashfs_i(inode)->start);
>   
> -	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
> +	if (folio->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
>   					PAGE_SHIFT))
>   		goto out;
>   
> @@ -472,23 +470,18 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   			goto out;
>   
>   		if (res == 0)
> -			res = squashfs_readpage_sparse(page, expected);
> +			res = squashfs_readpage_sparse(&folio->page, expected);
>   		else
> -			res = squashfs_readpage_block(page, block, res, expected);
> +			res = squashfs_readpage_block(&folio->page, block, res, expected);
>   	} else
> -		res = squashfs_readpage_fragment(page, expected);
> +		res = squashfs_readpage_fragment(&folio->page, expected);
>   
>   	if (!res)
>   		return 0;
>   
>   out:
> -	pageaddr = kmap_atomic(page);
> -	memset(pageaddr, 0, PAGE_SIZE);
> -	kunmap_atomic(pageaddr);
> -	flush_dcache_page(page);
> -	if (res == 0)
> -		SetPageUptodate(page);
> -	unlock_page(page);
> +	folio_zero_segment(folio, 0, folio_size(folio));
> +	folio_end_read(folio, res == 0);
>   
>   	return res;
>   }

