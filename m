Return-Path: <linux-fsdevel+bounces-32328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62199A39EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D2D28772A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430A1F4727;
	Fri, 18 Oct 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xMzT77sa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FC1E22F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243484; cv=none; b=NzatBAGEz5jwVQFqFQQ/Uv+2R6MAyQJ65uZpP1z4Qky+p0mD4E5pyfALcOW5cDv5zAxv6AByWvQBPQBHRclg/KkRMw+gGsLwaNQtBhcVaO3bMaGmrLmDf8LFKwSJIOQO0pcY3GQhFut4Ny5/7+vfdVnNGxjGhY1l/L0OdOJiuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243484; c=relaxed/simple;
	bh=X6RKFcDE14UJfuCaXzzis33UhlccbLrYoCBtnHdcD4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1RLxe1GBbq+21C9ymCz40qwazRFGZQi+6+lzpPGXn3yqNZ+2UQLKRqjOg7U8WMM1zNAnurrnMyb52Znd+fHo0/5YiEJ5gUL4LKLECVC7jY/udRt+Edkx91wbe9b2pNzdZakRUdnky18wABX9vPE4EfslG6TXMaNPjpNwE5IpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xMzT77sa; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729243480; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5XuejgPzIVqDuPyLye/qQgpabzNMLIvSL8VC78yW/wY=;
	b=xMzT77saMNnCYfLLhpoDGcGOueY6eVhximzlFqzsnRiUZJee62TJjaHzpleBkAY+bN0oQcmvytFZqUdW0oFoOSpytbE3TeCPj2t5GQsuTfa/VZ7eGeg+OKbEmy8/AkPB8kJ57Ku1w5wzWtnEwCLnBx8TmGbsd2cQ0zFG/20s8so=
Received: from 30.221.145.79(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WHNlHCJ_1729243478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 17:24:39 +0800
Message-ID: <0ba71b33-71ca-4dc0-a01b-7744933ae6d4@linux.alibaba.com>
Date: Fri, 18 Oct 2024 17:24:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241014182228.1941246-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/15/24 2:22 AM, Joanne Koong wrote:
>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
> -					  struct folio *tmp_folio, uint32_t page_index)
> +					  uint32_t page_index)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  
> -	folio_copy(tmp_folio, folio);
> -
> -	ap->pages[page_index] = &tmp_folio->page;
> +	folio_get(folio);

Why folio_get() is needed?


>  
> @@ -2203,68 +2047,11 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
>  	struct fuse_writepage_args *wpa = data->wpa;
>  	struct inode *inode = data->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
> -	int num_pages = wpa->ia.ap.num_pages;
> -	int i;
>  
>  	spin_lock(&fi->lock);
>  	list_add_tail(&wpa->queue_entry, &fi->queued_writes);

Could we also drop fi->queued_writes list and writectr counter after we
dropping the temp folio?  I'm not sure.  When I grep all callsites of
fuse_set_nowrite(), it seems that apart from the direct IO
path(fuse_direct_io -> fuse_sync_writes), the truncation related code
also relies on this writectr mechanism.



-- 
Thanks,
Jingbo

