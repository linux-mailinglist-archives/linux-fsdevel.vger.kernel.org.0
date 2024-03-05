Return-Path: <linux-fsdevel+bounces-13580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243D87163D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 08:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EF01F23C93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF907E56C;
	Tue,  5 Mar 2024 07:07:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320E45005;
	Tue,  5 Mar 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622457; cv=none; b=gCQTGAtSIWQmbTeQz59z/gHRVqjeSdkkR8qrs8yh8LoWaBClwV32tFe5AFfGDZKxKp/uh0SCHFxkuCKLEOXB9A9MSR4sy4fFWxwPHv4PBcLh06bVJM717+/KqfF36FcwDU30Q3oCFRFcJA+kM6jcaXggt+36fn0hBZRlyJr0L9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622457; c=relaxed/simple;
	bh=DXNf5QUK3RsSzXyDuaAMlqnL7FiXPA4FMKLeC4mq8Kk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ebkjlHe5fnD61SgKhg3M8ilzTcE4LIOYm80R+RCtZoasSdaUbPmVOpAorropgQHcZlQfKFrasmg/IFZGLuMuqgdGUlXW7Cv2htHZfIy/f8Yzk7f4pE1gBEqbPeBrbt42irz2+QYAz64yeAynwhjU3wSuJU644Uq9Td52embsj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tpmm70PXPz1Q9sl;
	Tue,  5 Mar 2024 15:05:11 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 808D61402CE;
	Tue,  5 Mar 2024 15:07:31 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 5 Mar 2024 15:07:30 +0800
Subject: Re: [PATCH 2/2] mm/readahead: limit sync readahead while too many
 active refault
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-3-liushixin2@huawei.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <09e871aa-bbe6-47a8-4aea-e2a1674366a1@huawei.com>
Date: Tue, 5 Mar 2024 15:07:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201100835.1626685-3-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200004.china.huawei.com (7.185.36.141)

Hi, Jan, All,

Please take a look at this patch again. Although this may not be a graceful way.

I can't think any other way to fix the problem except using workingset.


Thanks,

On 2024/2/1 18:08, Liu Shixin wrote:
> When the pagefault is not for write and the refault distance is close,
> the page will be activated directly. If there are too many such pages in
> a file, that means the pages may be reclaimed immediately.
> In such situation, there is no positive effect to read-ahead since it will
> only waste IO. So collect the number of such pages and when the number is
> too large, stop bothering with read-ahead for a while until it decreased
> automatically.
>
> Define 'too large' as 10000 experientially, which can solves the problem
> and does not affect by the occasional active refault.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  include/linux/fs.h      |  2 ++
>  include/linux/pagemap.h |  1 +
>  mm/filemap.c            | 16 ++++++++++++++++
>  mm/readahead.c          |  4 ++++
>  4 files changed, 23 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a704951..f2a1825442f5a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -960,6 +960,7 @@ struct fown_struct {
>   *      the first of these pages is accessed.
>   * @ra_pages: Maximum size of a readahead request, copied from the bdi.
>   * @mmap_miss: How many mmap accesses missed in the page cache.
> + * @active_refault: Number of active page refault.
>   * @prev_pos: The last byte in the most recent read request.
>   *
>   * When this structure is passed to ->readahead(), the "most recent"
> @@ -971,6 +972,7 @@ struct file_ra_state {
>  	unsigned int async_size;
>  	unsigned int ra_pages;
>  	unsigned int mmap_miss;
> +	unsigned int active_refault;
>  	loff_t prev_pos;
>  };
>  
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d2..da9eaf985dec4 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1256,6 +1256,7 @@ struct readahead_control {
>  	pgoff_t _index;
>  	unsigned int _nr_pages;
>  	unsigned int _batch_count;
> +	unsigned int _active_refault;
>  	bool _workingset;
>  	unsigned long _pflags;
>  };
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 750e779c23db7..4de80592ab270 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3037,6 +3037,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  
>  #ifdef CONFIG_MMU
>  #define MMAP_LOTSAMISS  (100)
> +#define ACTIVE_REFAULT_LIMIT	(10000)
>  /*
>   * lock_folio_maybe_drop_mmap - lock the page, possibly dropping the mmap_lock
>   * @vmf - the vm_fault for this fault.
> @@ -3142,6 +3143,18 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	if (mmap_miss > MMAP_LOTSAMISS)
>  		return fpin;
>  
> +	ractl._active_refault = READ_ONCE(ra->active_refault);
> +	if (ractl._active_refault)
> +		WRITE_ONCE(ra->active_refault, --ractl._active_refault);
> +
> +	/*
> +	 * If there are a lot of refault of active pages in this file,
> +	 * that means the memory reclaim is ongoing. Stop bothering with
> +	 * read-ahead since it will only waste IO.
> +	 */
> +	if (ractl._active_refault >= ACTIVE_REFAULT_LIMIT)
> +		return fpin;
> +
>  	/*
>  	 * mmap read-around
>  	 */
> @@ -3151,6 +3164,9 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	ra->async_size = ra->ra_pages / 4;
>  	ractl._index = ra->start;
>  	page_cache_ra_order(&ractl, ra, 0);
> +
> +	WRITE_ONCE(ra->active_refault, ractl._active_refault);
> +
>  	return fpin;
>  }
>  
> diff --git a/mm/readahead.c b/mm/readahead.c
> index cc4abb67eb223..d79bb70a232c4 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -263,6 +263,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			folio_set_readahead(folio);
>  		ractl->_workingset |= folio_test_workingset(folio);
>  		ractl->_nr_pages++;
> +		if (unlikely(folio_test_workingset(folio)))
> +			ractl->_active_refault++;
> +		else if (unlikely(ractl->_active_refault))
> +			ractl->_active_refault--;
>  	}
>  
>  	/*


