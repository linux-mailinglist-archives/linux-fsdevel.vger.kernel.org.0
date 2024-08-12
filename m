Return-Path: <linux-fsdevel+bounces-25613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FEA94E4AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0AA1F21F08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4951C5A;
	Mon, 12 Aug 2024 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b="o1kC0CBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr009.pc5.atmailcloud.com (omr009.pc5.atmailcloud.com [103.150.252.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0A4690
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723428977; cv=none; b=J0pb10VPQ30FdN0S8eDVQ10hz9UXEwZuPeMTa3BI3O7SurOoB38D0FRp/GUCoU9xdFFyNvnQxqQNWIo9T46S1mEygqmYAhfe/Uzd+qp+03H+7tEzxn7rhfhquKRC4iX0Ue/a6rbIDqJRVFABilwNbkbTeo+ucsI38xYokWpmKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723428977; c=relaxed/simple;
	bh=pJN99/PGtsS8lPgvBKoMBI4Z0QgkoC7SkSske6zzXaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn4ACXgGgLypIUJge94d3svDTN/0ZJ/OCSzzSx1gG2XnurLvSbuVb63xMtb4E3A/mdumQdD7ltxxhEkQb2yu7X0J42k4DOzx5M+uqaBZdFfrDbYkQhmz5nbpu0fSDw22w86D2DJQq87D4BiykBexZAwocKxu2l8VjadngqEvkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au; spf=pass smtp.mailfrom=westnet.com.au; dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b=o1kC0CBF; arc=none smtp.client-ip=103.150.252.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westnet.com.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=westnet.com.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=2mrRSNbjyOXH0WGKyiiw/xHUYAwRvAtEjOypjx8tiJc=; b=o1kC0CBFwnReJB
	y46mHsZvng/a2a8ML/JqCAakjG+YV58cfdHPmfto2KyFEKsQWE4Ie7psmbkinObYxPa4ypPfjRljg
	TxPPSejmIOnhM4fX+4/GCgKXul49WmJ8+KTgn07rDa4jLF+FK/7ts21nqYEiexgv25nndjRVvZiXF
	IY9tn/iajgIogOkStCxcL3nrZnbGZ0jxBWll2djAGKVHJvt+wvdR5ez6/Xc/36MiZw8V2xO9VFMAu
	ZNmoM4nryKVDp4U3DzYrIMxugif7W+/800e0SYf8+vXPrX8yjqLmmKGcaMSmhXXHmtKY0mgyoVbUl
	yqbP93gYODR35D453jRA==;
Received: from CMR-KAKADU04.i-0c3ae8fd8bf390367
	 by OMR.i-0e903b7f5690dc9e4 with esmtps
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdK8u-0007QQ-Ld;
	Mon, 12 Aug 2024 01:46:40 +0000
Received: from [27.33.250.67] (helo=[192.168.0.22])
	 by CMR-KAKADU04.i-0c3ae8fd8bf390367 with esmtpsa
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdK8u-0006YX-0v;
	Mon, 12 Aug 2024 01:46:40 +0000
Message-ID: <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
Date: Mon, 12 Aug 2024 11:46:34 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
Content-Language: en-US
From: Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <20240530202110.2653630-13-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=fLk/34ae c=1 sm=1 tr=0 ts=66b96980 a=Pz+tuLbDt1M46b9uk18y4g==:117 a=Pz+tuLbDt1M46b9uk18y4g==:17 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=JfrnYn6hAAAA:8 a=-_dQqna_KL3JswWU-PQA:9 a=QEXdDO2ut3YA:10 a=2EAlj0jRiK55KS37XwDd:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Cm-Envelope: MS4xfKfJY//dcaAr/XbBIrUWkJTcjPiMmVUB2W8W6FdSSVU5Mz1ziUt2aZ+/I2zlsRMmdUk2uF/F2ymYsnDE8xW4nTRjOwH4WXVjubqoD2Dd0RgxSeBPO15D 1g9cyatvfYPAcj9PgL6OeMtEXzHpJMZnra8Pz1QTnMaOsuOmSPo/2Qn6n6uU1qRQGkll3cX23Yzl9A==
X-atmailcloud-route: unknown

Hi Mathew,

On 31/5/24 06:21, Matthew Wilcox (Oracle) wrote:
> Remove the conversion back to struct page and use the folio APIs instead
> of the page APIs.  It's probably more trouble than it's worth to support
> large folios in romfs, so there are still PAGE_SIZE assumptions in
> this function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This is breaking for me on my m68k/ColdFire 5475 target. That is a full
MMU CPU. The usual test build I do (m5475evb_defconfig) fails to boot,
not being able to load and start init or sh at startup from a ROMfs
resident in RAM within the uclinux MTD mapper:

...
Freeing unused kernel image (initmem) memory: 80K
This architecture does not have kernel memory protection.
Run /sbin/init as init process
Run /etc/init as init process
Run /bin/init as init process
Starting init: /bin/init exists but couldn't execute it (error -13)
Run /bin/sh as init process
Starting init: /bin/sh exists but couldn't execute it (error -13)
Kernel panic - not syncing: No working init found.  Try passing init= option to
kernel. See Linux Documentation/admin-guide/init.rst for guidance.
CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.11.0-rc3 #4
Stack from 00829f74:
         00829f74 003d8508 003d8508 00000000 0000000a 00000003 0032b864 003d8508
         00325126 00000001 00002700 00000003 00829fb0 00324e9e 00000000 00000000
         00000000 0032ba9a 003ce1bd 0032b9b8 000218a4 00000000 00000000 00000000
         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
         00000000 00002000 00000000
Call Trace: [<0032b864>] dump_stack+0xc/0x10
  [<00325126>] panic+0xca/0x236
  [<00324e9e>] try_to_run_init_process+0x0/0x36
  [<0032ba9a>] kernel_init+0xe2/0xe8
  [<0032b9b8>] kernel_init+0x0/0xe8
  [<000218a4>] ret_from_kernel_thread+0xc/0x14

Reverting this change gets it going again.

Any idea what might be going on?

Regards
Greg


> ---
>   fs/romfs/super.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index 2cbb92462074..68758b6fed94 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -101,19 +101,15 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
>    */
>   static int romfs_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct page *page = &folio->page;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>   	loff_t offset, size;
>   	unsigned long fillsize, pos;
>   	void *buf;
>   	int ret;
>   
> -	buf = kmap(page);
> -	if (!buf)
> -		return -ENOMEM;
> +	buf = kmap_local_folio(folio, 0);
>   
> -	/* 32 bit warning -- but not for us :) */
> -	offset = page_offset(page);
> +	offset = folio_pos(folio);
>   	size = i_size_read(inode);
>   	fillsize = 0;
>   	ret = 0;
> @@ -125,20 +121,14 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
>   
>   		ret = romfs_dev_read(inode->i_sb, pos, buf, fillsize);
>   		if (ret < 0) {
> -			SetPageError(page);
>   			fillsize = 0;
>   			ret = -EIO;
>   		}
>   	}
>   
> -	if (fillsize < PAGE_SIZE)
> -		memset(buf + fillsize, 0, PAGE_SIZE - fillsize);
> -	if (ret == 0)
> -		SetPageUptodate(page);
> -
> -	flush_dcache_page(page);
> -	kunmap(page);
> -	unlock_page(page);
> +	buf = folio_zero_tail(folio, fillsize, buf);
> +	kunmap_local(buf);
> +	folio_end_read(folio, ret == 0);
>   	return ret;
>   }
>   

