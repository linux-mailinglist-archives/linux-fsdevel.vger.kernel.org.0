Return-Path: <linux-fsdevel+bounces-57998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67DB27EC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4BAAC3F0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B910275B19;
	Fri, 15 Aug 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MLfDP79h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A5319855
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255715; cv=none; b=ukDRNPLBKLh+hMNmt6oOQfwIWrYFy4QP2t7B4goKX52Uml29bss3F5VkTeZ4hirGxyGBWWGRfQR8lgYjPhg0k9W5teobs3l9+6fu7PRD2QdetnHVmLYP2ED1Ycg7frarCu2WwD/MlDw/xeDupMI6rTTm7w0lzScMx4O++Ki03HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255715; c=relaxed/simple;
	bh=WYpFKbfeaT8HNEBSy4zAigMvXb0z6zq4KvCwXFzDsDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hi2zlZZMAcj0WbUwZtulhoRd6LpuxUXqAq3sL6ryuZEOiG7wvM/jFCbS6hzunzjYQa16NopgE820ZJ+PwvG5zLDzWAEjtUfnXFm9I/shOnFZ1Sh/iEnKZGka0DQIbyyMuCftQ6m01q8ZfALxfcKuMWZMqKpvbKRulqg2hk8NexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MLfDP79h; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755255710; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6NKoxmUD6OnVO63NZ5ScVxYujCChgDolKtXO6Jal5vw=;
	b=MLfDP79hCTtbKK2MDuCWgy4huj4u9bBVqK9U6Tj6CQbCZrAS9Ez+Ru/82mzljmCN8mKgWcjVG1doivFMcNQ5nlkVAti6OcvelDeP9wh0vkhP9JmgDBfvb55r89ApCnjb2Zm489iGJF0fiC3yTIySYcCv2+85VgSovOXYTAreMhA=
Received: from 30.221.147.6(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wlot7ch_1755255687 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 19:01:49 +0800
Message-ID: <6bd47f03-8638-4460-9349-deebd1184b45@linux.alibaba.com>
Date: Fri, 15 Aug 2025 19:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
 willy@infradead.org, kernel-team@meta.com
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20250811204008.3269665-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 4:40 AM, Joanne Koong wrote:
> Large folios are only enabled if the writeback cache isn't on.
> (Strictlimiting needs to be turned off if the writeback cache is used in
> conjunction with large folios, else this tanks performance.)
> 
> Benchmarks showed noticeable improvements for writes (both sequential
> and random). There were no performance differences seen for random reads
> or direct IO. For sequential reads, there was no performance difference
> seen for the first read (which populates the page cache) but subsequent
> sequential reads showed a huge speedup.
> 
> Benchmarks were run using fio on the passthrough_hp fuse server:
> ~/libfuse/build/example/passthrough_hp ~/libfuse ~/fuse_mnt --nopassthrough --nocache
> 
> run fio in ~/fuse_mnt:
> fio --name=test --ioengine=sync --rw=write --bs=1M --size=5G --numjobs=2 --ramp_time=30 --group_reporting=1
> 
> Results (tested on bs=256K, 1M, 5M) showed roughly a 15-20% increase in
> write throughput and for sequential reads after the page cache has
> already been populated, there was a ~800% speedup seen.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index adc4aa6810f5..2e7aae294c9e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1167,9 +1167,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		pgoff_t index = pos >> PAGE_SHIFT;
>  		unsigned int bytes;
>  		unsigned int folio_offset;
> +		fgf_t fgp = FGP_WRITEBEGIN | fgf_set_order(num);
>  
>   again:
> -		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +		folio = __filemap_get_folio(mapping, index, fgp,
>  					    mapping_gfp_mask(mapping));
>  		if (IS_ERR(folio)) {
>  			err = PTR_ERR(folio);
> @@ -3155,11 +3156,24 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	unsigned int max_pages, max_order;
>  
>  	inode->i_fop = &fuse_file_operations;
>  	inode->i_data.a_ops = &fuse_file_aops;
> -	if (fc->writeback_cache)
> +	if (fc->writeback_cache) {
>  		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> +	} else {
> +		/*
> +		 * Large folios are only enabled if the writeback cache isn't on.
> +		 * If the writeback cache is on, large folios should only be
> +		 * enabled in conjunction with strictlimiting turned off, else
> +		 * performance tanks.
> +		 */
> +		max_pages = min(min(fc->max_write, fc->max_read) >> PAGE_SHIFT,
> +				fc->max_pages);
> +		max_order = ilog2(max_pages);
> +		mapping_set_folio_order_range(inode->i_mapping, 0, max_order);
> +	}

JFYI fc->max_read shall also be honored when calculating max_order,
otherwise the following warning in fuse_readahead() may be triggered.

			/*
                         * Large folios belonging to fuse will never
                         * have more pages than max_pages.
                         */
                         WARN_ON(!pages);


-- 
Thanks,
Jingbo


