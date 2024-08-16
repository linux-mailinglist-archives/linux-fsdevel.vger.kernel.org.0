Return-Path: <linux-fsdevel+bounces-26118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E2954AA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6881F21E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FC1B4C5C;
	Fri, 16 Aug 2024 12:59:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68913DBB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813192; cv=none; b=Xh4tnHns0lUW+xyj8JllfimUBzwSSi3Qw0YjuF8Ji2ubKh9nP0E8SFBDBIk6cvTymIyZfK6q/qibKnMBz3GLezKWDrNY+2MqgarIgFeifqoSwYAMHgdWCbkxp3nX2BLuPjjtPF3l0fidlr21nZ3UwrZqrcG2oouKieNw2PAefSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813192; c=relaxed/simple;
	bh=f4FTrC2KtERrke/KUiNKWy1pOEhg9oX5QzJWkol30u0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DZBbFvipIgdvReoDUQblGGAso0o+/EX+JkYm+u5XS2/Lfe43WrnzA0lWq+eysNj35yEAhjZ3Or3kQ27WkMw5dz1cZScblHhu6ycxPqtaX92jWSFh2B6eT+wtmnoD6Rgc1+70Bx6IdfQc9/wF9SqO/3oydXFshPqNUJ0l/ojgGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wlhm84KPJz20lvL;
	Fri, 16 Aug 2024 20:55:04 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D6A7E14010C;
	Fri, 16 Aug 2024 20:59:40 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 20:59:40 +0800
Subject: Re: [PATCH 1/2] jffs2: Convert jffs2_do_readpage_nolock to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Woodhouse
	<dwmw2@infradead.org>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
References: <20240814195915.249871-1-willy@infradead.org>
 <20240814195915.249871-2-willy@infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f5eda589-c706-ea18-17e5-ab4a7ecdae9e@huawei.com>
Date: Fri, 16 Aug 2024 20:59:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240814195915.249871-2-willy@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/15 3:59, Matthew Wilcox (Oracle) Ð´µÀ:
> Both callers now have a folio, so pass it in.  No effort is made
> here to support large folios.  Removes several hidden calls to
> compound_head(), two references to page->index and a use of kmap.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/jffs2/file.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index ada572c466f8..13c18ccc13b0 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -77,29 +77,27 @@ const struct address_space_operations jffs2_file_address_operations =
>   	.write_end =	jffs2_write_end,
>   };
>   
> -static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
> +static int jffs2_do_readpage_nolock(struct inode *inode, struct folio *folio)
>   {
>   	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
>   	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
> -	unsigned char *pg_buf;
> +	unsigned char *kaddr;
>   	int ret;
>   
>   	jffs2_dbg(2, "%s(): ino #%lu, page at offset 0x%lx\n",
> -		  __func__, inode->i_ino, pg->index << PAGE_SHIFT);
> +		  __func__, inode->i_ino, folio->index << PAGE_SHIFT);
>   
> -	BUG_ON(!PageLocked(pg));
> +	BUG_ON(!folio_test_locked(folio));
>   
> -	pg_buf = kmap(pg);
> -	/* FIXME: Can kmap fail? */
> -
> -	ret = jffs2_read_inode_range(c, f, pg_buf, pg->index << PAGE_SHIFT,
> +	kaddr = kmap_local_folio(folio, 0);
> +	ret = jffs2_read_inode_range(c, f, kaddr, folio->index << PAGE_SHIFT,
>   				     PAGE_SIZE);
> +	kunmap_local(kaddr);
>   
>   	if (!ret)
> -		SetPageUptodate(pg);
> +		folio_mark_uptodate(folio);
>   
> -	flush_dcache_page(pg);
> -	kunmap(pg);
> +	flush_dcache_folio(folio);
>   
>   	jffs2_dbg(2, "readpage finished\n");
>   	return ret;
> @@ -107,7 +105,7 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
>   
>   int __jffs2_read_folio(struct file *file, struct folio *folio)
>   {
> -	int ret = jffs2_do_readpage_nolock(folio->mapping->host, &folio->page);
> +	int ret = jffs2_do_readpage_nolock(folio->mapping->host, folio);
>   	folio_unlock(folio);
>   	return ret;
>   }
> @@ -221,7 +219,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
>   	 */
>   	if (!folio_test_uptodate(folio)) {
>   		mutex_lock(&f->sem);
> -		ret = jffs2_do_readpage_nolock(inode, &folio->page);
> +		ret = jffs2_do_readpage_nolock(inode, folio);
>   		mutex_unlock(&f->sem);
>   		if (ret) {
>   			folio_unlock(folio);
> 


