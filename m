Return-Path: <linux-fsdevel+bounces-18030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A438B4E12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 23:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE705B20C96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD99BA27;
	Sun, 28 Apr 2024 21:59:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-13.prod.sxb1.secureserver.net (sxb1plsmtpa01-13.prod.sxb1.secureserver.net [188.121.53.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC98F4E
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341554; cv=none; b=pQs3eyp+xfgei3GYgX7BhDhNjHX6cU5mIEGN3LTTli6bCClw6KaQ8Ofa+GmWX+Wipz+/k9eFTuOYwocvAiOgqLLw5Rk+pECUZouOue3vsUcXvJ/dXyr9sAuKThr8bRfSgWVi0Y/G2bIOkmpu4pnnqh3k5ND0cM9OWh1SVp1/TyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341554; c=relaxed/simple;
	bh=3yI8YZpe4PDtSE1G4xDe/BaKByXpx/bBXsaZyJ4nJtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hAzuEao1xPAmZCPbXiSnN3GRpat/0soigtxz3rgHHE3vHL4nHRHOSMZgXzsyFqqjvRQkhXpSXWgCU5Yi50ajxMjfQEm3qj6YE1l8+KnUa+poF/JWNCvgp/RQR3+X6ySCAFvnRd+ArI/qwfwwiVO3FYIae1cCq/sYCO45zbcDjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 1CFesySMyeOLy1CFgsTbOO; Sun, 28 Apr 2024 14:40:05 -0700
X-CMAE-Analysis: v=2.4 cv=B4Ny0/tM c=1 sm=1 tr=0 ts=662ec236
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=FXvPX3liAAAA:8 a=JfrnYn6hAAAA:8 a=zF9BiN6CPQy_781Rqo8A:9
 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <87af91eb-e5cb-473f-9724-35d7dab41736@squashfs.org.uk>
Date: Sun, 28 Apr 2024 22:40:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/30] squashfs: Convert squashfs_symlink_read_folio to
 use folio APIs
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-23-willy@infradead.org>
Content-Language: en-GB
Cc: Andrew Morton <akpm@linux-foundation.org>
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20240420025029.2166544-23-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfINapGQ+fQcK89WIrrlJL81PMGVkcH/krmsG2KNHVDWYThJ8HxZ5mmnJeffZlB5j9tzj3x4kIDIMlHMaNAbNYOPTmWKogSL+zWRRIr3ryHBvYthP92Ef
 EXk//aLTZk+UpVjxyqQbkBAYUCMQaDvAqfuu6KrpQg6xe6lH27W2r7kfLmrwbCBY/h+XtsdH+TV/RRnsvIGG1G9JG4BeR2g8xxI8QTNcoXAJhthle3hxJXjF
 ansVup477VAjbFhy470ZFk4LkhvnyWhr+5/OBHbSf0E=

On 20/04/2024 03:50, Matthew Wilcox (Oracle) wrote:
> Remove use of page APIs, return the errno instead of 0, switch from
> kmap_atomic to kmap_local and use folio_end_read() to unify the two
> exit paths.
> 
> Cc: Phillip Lougher <phillip@squashfs.org.uk>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Tested-by: Phillip Lougher <phillip@squashfs.org.uk>
Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

You've mentioned a couple of times you prefer the patches in
the series to go through the fs maintainers.  Andrew Morton is
currently handling submission of Squashfs patches for me, and
I'm happy with either Andrew or you merging it.

CC'ing Andrew.

Regards

Phillip

> ---
>   fs/squashfs/symlink.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
> index 2bf977a52c2c..6ef735bd841a 100644
> --- a/fs/squashfs/symlink.c
> +++ b/fs/squashfs/symlink.c
> @@ -32,20 +32,19 @@
>   
>   static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct page *page = &folio->page;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>   	struct super_block *sb = inode->i_sb;
>   	struct squashfs_sb_info *msblk = sb->s_fs_info;
> -	int index = page->index << PAGE_SHIFT;
> +	int index = folio_pos(folio);
>   	u64 block = squashfs_i(inode)->start;
>   	int offset = squashfs_i(inode)->offset;
>   	int length = min_t(int, i_size_read(inode) - index, PAGE_SIZE);
> -	int bytes, copied;
> +	int bytes, copied, error;
>   	void *pageaddr;
>   	struct squashfs_cache_entry *entry;
>   
>   	TRACE("Entered squashfs_symlink_readpage, page index %ld, start block "
> -			"%llx, offset %x\n", page->index, block, offset);
> +			"%llx, offset %x\n", folio->index, block, offset);
>   
>   	/*
>   	 * Skip index bytes into symlink metadata.
> @@ -57,14 +56,15 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
>   			ERROR("Unable to read symlink [%llx:%x]\n",
>   				squashfs_i(inode)->start,
>   				squashfs_i(inode)->offset);
> -			goto error_out;
> +			error = bytes;
> +			goto out;
>   		}
>   	}
>   
>   	/*
>   	 * Read length bytes from symlink metadata.  Squashfs_read_metadata
>   	 * is not used here because it can sleep and we want to use
> -	 * kmap_atomic to map the page.  Instead call the underlying
> +	 * kmap_local to map the folio.  Instead call the underlying
>   	 * squashfs_cache_get routine.  As length bytes may overlap metadata
>   	 * blocks, we may need to call squashfs_cache_get multiple times.
>   	 */
> @@ -75,29 +75,26 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
>   				squashfs_i(inode)->start,
>   				squashfs_i(inode)->offset);
>   			squashfs_cache_put(entry);
> -			goto error_out;
> +			error = entry->error;
> +			goto out;
>   		}
>   
> -		pageaddr = kmap_atomic(page);
> +		pageaddr = kmap_local_folio(folio, 0);
>   		copied = squashfs_copy_data(pageaddr + bytes, entry, offset,
>   								length - bytes);
>   		if (copied == length - bytes)
>   			memset(pageaddr + length, 0, PAGE_SIZE - length);
>   		else
>   			block = entry->next_index;
> -		kunmap_atomic(pageaddr);
> +		kunmap_local(pageaddr);
>   		squashfs_cache_put(entry);
>   	}
>   
> -	flush_dcache_page(page);
> -	SetPageUptodate(page);
> -	unlock_page(page);
> -	return 0;
> -
> -error_out:
> -	SetPageError(page);
> -	unlock_page(page);
> -	return 0;
> +	flush_dcache_folio(folio);
> +	error = 0;
> +out:
> +	folio_end_read(folio, error == 0);
> +	return error;
>   }
>   
>   


