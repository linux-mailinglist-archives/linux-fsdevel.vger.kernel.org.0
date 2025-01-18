Return-Path: <linux-fsdevel+bounces-39573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C969A15B36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 04:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA0A188AE04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 03:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B6502BE;
	Sat, 18 Jan 2025 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVW0nzAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F701422D4;
	Sat, 18 Jan 2025 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737170740; cv=none; b=lPaZ5Fnay6BCZUxls0NCZcglW/j59qe49z0BPxmHSLBcZX/tIN/jBHRnAGrTw36b/cnzK0Fk0eklj47R5GB3uES6aAwKmkx4rXP+4sjx3PKJLWG+2oqoX143SuDjREKN0YWFSGTu7b18cvigsQvUhC4HTx3nRC9gF3+FSj2LI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737170740; c=relaxed/simple;
	bh=VVhSfy6WkrFs5h1HjoH+FRANBLbuM/rl9g/xY3TdlAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxZCC5qda9zoWvYQZQxmXVa+I9RKiBPwbwSWc37gCn7/quZMtpZP5he8wjfkXery9hE92XS7FKl120a5qGD5g1X6x/hxhoaFl1LUIEkeSg1CSKxEVCr26AqErBIArNpzkQfzXtvnsh6m7TTbfBXsRLv+6Prao3Jd+w7YlfJ+Bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVW0nzAF; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737170728; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FA6xT1Fn7iSkDO00AAPe6p1EmFdXA/BcGiOnCvLrOnM=;
	b=oVW0nzAFZJ9QNkYlADj6pz3g+04ACBCa8zSa67mDMSp/thdakt8bJemrZOYpXpeqvz2rqfLk7FR1RXvoxDAdgBM8W7/l5Xo0HY9SvImZFUhNMVJhi7nhe3A+SrhMlYGv21sGLbLFMox8qgeyltd46fTOaMeClF1C9vpl3Wl9sOA=
Received: from 30.221.144.93(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WNqQkOj_1737170727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 18 Jan 2025 11:25:28 +0800
Message-ID: <e938e161-81c2-4def-87f2-22e80489874f@linux.alibaba.com>
Date: Sat, 18 Jan 2025 11:25:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] mm/filemap: add filemap_fdatawrite_range_kick()
 helper
To: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-11-axboe@kernel.dk>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241220154831.1086649-11-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/24 11:47 PM, Jens Axboe wrote:
> Works like filemap_fdatawrite_range(), except it's a non-integrity data
> writeback and hence only starts writeback on the specified range. Will
> help facilitate generically starting uncached writeback from
> generic_write_sync(), as header dependencies preclude doing this inline
> from fs.h.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6a838b5479a6..653b5efa3d3f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2878,6 +2878,8 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
>  extern int __must_check file_check_and_advance_wb_err(struct file *file);
>  extern int __must_check file_write_and_wait_range(struct file *file,
>  						loff_t start, loff_t end);
> +int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
> +		loff_t end);
>  
>  static inline int file_write_and_wait(struct file *file)
>  {
> diff --git a/mm/filemap.c b/mm/filemap.c
> index aa0b3af6533d..9842258ba343 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -449,6 +449,24 @@ int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  }
>  EXPORT_SYMBOL(filemap_fdatawrite_range);
>  
> +/**
> + * filemap_fdatawrite_range_kick - start writeback on a range
> + * @mapping:	target address_space
> + * @start:	index to start writeback on
> + * @end:	last (non-inclusive) index for writeback
> + *
> + * This is a non-integrity writeback helper, to start writing back folios
> + * for the indicated range.
> + *
> + * Return: %0 on success, negative error code otherwise.
> + */
> +int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
> +				  loff_t end)
> +{
> +	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
> +}

__filemap_fdatawrite_range() actually accepts @end argument as "last
(**inclusive**) index".

-- 
Thanks,
Jingbo

