Return-Path: <linux-fsdevel+bounces-39193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270CA11371
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19315169E0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA0520E01D;
	Tue, 14 Jan 2025 21:53:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-14.prod.sxb1.secureserver.net (sxb1plsmtpa01-14.prod.sxb1.secureserver.net [92.204.81.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAC1CDFC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891590; cv=none; b=Pg6sN5WYgeuCd2iKJ7UVfdzCJGEXcCZIvxvtPQQ8RXU8V7Ny5/i/aHow5NVRpuqVSaIlYos2lHHzYZvbe6BDGk0CiJncdxqG3xCCXLEDOtzd+fcfnFfTU2eYq9mixaObauSgoaTurTjEEsTQks6tqWVwXU11PdYdgwcAdb87OHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891590; c=relaxed/simple;
	bh=a3g8ThR7LSWlYeAmR+PkNpaiX7x0bk8vyWHKR2aSSaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs6xE06bXT8jC8LMKTD1qDmi4t1WBQ/5T0Sic/kVughEoVpNktmrW2xjbnmfdKmF3iHxMvTYf3eCsa24yq7NRDIgFchqmQcoWJx21KrswIuNs4YzrucFLwHj8eA+yHL8XNL7PMtWLgH7xakt1PF9pTrZtgxVeqkXoKH+p4snEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id Xo98tHZHlnPPbXo98tjc8M; Tue, 14 Jan 2025 14:08:22 -0700
X-CMAE-Analysis: v=2.4 cv=C/sTyRP+ c=1 sm=1 tr=0 ts=6786d246
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=PXAFGWOKMHoxhg3sn_wA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <0153c973-1100-4863-868d-ba80f736fa41@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:07:56 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] squashfs: Use a folio throughout
 squashfs_read_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241216162701.57549-1-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241216162701.57549-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHB0Hx4a17bVBC7pc6GziKY4aIItP+B8Qd9tkzn53dSYNe9B9ILHoaFRDnXBGbOfcizb9SMf+wtgI8puRujRvSVcVhTicGyUFNCfasjhzOCYuaJdSeGR
 Nx0Tcxw3SWf/TJxYCSEgzPMyFgs/2BVKkda3BLq5UKE4shXakSEbjSczIn7hOAkC3xlyBUJshWQK03EbPP/W8UdPCXYY+ugGzjSSDm4IIl/XDNIhsRaKHwJ1
 ZesoQEISNG+3GVBYTL8l7+2oaHYEA5snp4RY3VPpnU62sHXt27XGHxxToGbZKyY9QdveUNum/9gXtW51Vm71hw==



On 12/16/24 16:26, Matthew Wilcox (Oracle) wrote:
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

