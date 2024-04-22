Return-Path: <linux-fsdevel+bounces-17400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEBA8ACFD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFEF1F21C33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CDB152504;
	Mon, 22 Apr 2024 14:46:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2FB2AD2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797207; cv=none; b=J+V0bxV0o9oh5PchLLan86hqlKaP4wr5UHkKexC9NxiYxS44V7gnjj675n0ObVvPqu4b2hEZtww4Hk4jBD2DJ8vHuEod/ljq+8F5/Wciqu8y80WT4aErMgTBumZtjf6nvQTe8Y/xu/rlGfWCJfc8ifUUsWWrTG3yS4QNzIhDI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797207; c=relaxed/simple;
	bh=OpbzQ3lgN8afD25hYKBKIpfG5ziU0mhP+oVLlGJ2qdo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LDGL47JJYuw0d0flYIIs1toNFdHw0PFhoqMEwTMrlzM8MzRhvElqUKK5UtdBdGntj0HoqIwK/Bn+EhtaQeAyN37tbSstxB5SeLc1UIEVl/dasN+zDyfO71wLfBHyPri51OGFsbhoL7+q62Ybal6yDuJv/WxhQz6hZ5HGVZjG2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNSfS3SlkzXlQn;
	Mon, 22 Apr 2024 22:43:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B024180072;
	Mon, 22 Apr 2024 22:46:39 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 22:46:38 +0800
Subject: Re: [PATCH 14/30] jffs2: Remove calls to set/clear the folio error
 flag
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger
	<richard@nod.at>, <linux-mtd@lists.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-15-willy@infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <75dbe998-231a-4dd3-70de-d98bf8ee3349@huawei.com>
Date: Mon, 22 Apr 2024 22:46:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240420025029.2166544-15-willy@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/4/20 10:50, Matthew Wilcox (Oracle) Ð´µÀ:
> Nobody checks the error flag on jffs2 folios, so stop setting and
> clearing it.  We can also remove the call to clear the uptodate
> flag; it will already be clear.
> 
> Convert one of these into a call to mapping_set_error() which will
> actually be checked by other parts of the kernel.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/jffs2/file.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)

xfstests passed. Looks like the change is harmless.

Tested-by: Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index 62ea76da7fdf..e12cb145147e 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -95,13 +95,8 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
>   	ret = jffs2_read_inode_range(c, f, pg_buf, pg->index << PAGE_SHIFT,
>   				     PAGE_SIZE);
>   
> -	if (ret) {
> -		ClearPageUptodate(pg);
> -		SetPageError(pg);
> -	} else {
> +	if (!ret)
>   		SetPageUptodate(pg);
> -		ClearPageError(pg);
> -	}
>   
>   	flush_dcache_page(pg);
>   	kunmap(pg);
> @@ -304,10 +299,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
>   
>   	kunmap(pg);
>   
> -	if (ret) {
> -		/* There was an error writing. */
> -		SetPageError(pg);
> -	}
> +	if (ret)
> +		mapping_set_error(mapping, ret);
>   
>   	/* Adjust writtenlen for the padding we did, so we don't confuse our caller */
>   	writtenlen -= min(writtenlen, (start - aligned_start));
> @@ -330,7 +323,6 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
>   		   it gets reread */
>   		jffs2_dbg(1, "%s(): Not all bytes written. Marking page !uptodate\n",
>   			__func__);
> -		SetPageError(pg);
>   		ClearPageUptodate(pg);
>   	}
>   
> 


