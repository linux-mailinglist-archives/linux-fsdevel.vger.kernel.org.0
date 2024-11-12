Return-Path: <linux-fsdevel+bounces-34415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEA9C51EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BDF2847A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3C20D4F5;
	Tue, 12 Nov 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NbEgztFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304120B814
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403530; cv=none; b=jFx67NzILuaNKKZV7tdOYESUG1olyAnSPop8x2nqZxXPBEXM1Qf+K2Zw7XAxbhvtuethhQpV1cGWzjP+z+6FPQg66NXf4iT/ioTS/lIWwxsI+NVs2iiJ0UHZdYBkYtGWkQvd8qwm5O25n6MNHqBxtuShKx+7zBr4Q7zpazyKRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403530; c=relaxed/simple;
	bh=5nwHO7XkhwRtkGoYD8g3yH2ypRLPeL4h/sOKQikDUd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLe3Uup1T0jL6zGxYASFdE8pJEo74lhhBg3Jiz2N1hVYm8C/nKnnf/Y1vuRG4g42D+u6EsgJcM+zRI4TukNI1xfPQGACKffga1egrvfLf1+1Jf2iocNu6nxFvdMBR66S6fcJQ+6tCoRk695iGntOdLkHmRs47CHLTesl/lEFEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NbEgztFn; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731403525; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rBBmXbke/LnZGdd5wS2IEgWfHY2wAeJCKq8GTtqQaN8=;
	b=NbEgztFn7XGtdQJhK42aWwIyS2Dfk0BUnfQBDxHI9gF5tOp9Og1cKImeGnGYeoSN1i7I3yQNApg8qHamf2HwbxnMWx9BVTFFqrGXMedHo/MLpN0hrA7fm2hqMJ2EvtteGP9h8wZL6r19PFwu8pJNxWOz4ddmBiQuKDiQq5QaxBc=
Received: from 30.221.148.118(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJGlMAQ_1731403523 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 17:25:24 +0800
Message-ID: <e85bd643-894e-4eb2-994b-62f0d642b4f1@linux.alibaba.com>
Date: Tue, 12 Nov 2024 17:25:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241107235614.3637221-7-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

On 11/8/24 7:56 AM, Joanne Koong wrote:
> Currently, we allocate and copy data to a temporary folio when
> handling writeback in order to mitigate the following deadlock scenario
> that may arise if reclaim waits on writeback to complete:
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
> 
> To work around this, we allocate a temporary folio and copy over the
> original folio to the temporary folio so that writeback can be
> immediately cleared on the original folio. This additionally requires us
> to maintain an internal rb tree to keep track of writeback state on the
> temporary folios.
> 
> A recent change prevents reclaim logic from waiting on writeback for
> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> will prevent FUSE folios from running into the reclaim deadlock described
> above) and removes the temporary folio + extra copying and the internal
> rb tree.
> 
> fio benchmarks --
> (using averages observed from 10 runs, throwing away outliers)
> 
> Setup:
> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
> 
> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
> 
>         bs =  1k          4k            1M
> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> % diff        -3%          23%         45%
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

I think there are some places checking or waiting for writeback could be
reconsidered if they are still needed or not after we dropping the temp
page design.

As they are inherited from the original implementation, at least they
are harmless.  I think they could be remained in this patch, and could
be cleaned up later if really needed.


> @@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
>  	 * have writeback that extends beyond the lifetime of the folio.  So
>  	 * make sure we read a properly synced folio.
>  	 */
> -	fuse_wait_on_folio_writeback(inode, folio);
> +	folio_wait_writeback(folio);

I doubt if wait-on-writeback is needed here, as now page cache won't be
freed until the writeback IO completes.

The routine attempts to free page cache, e.g. invalidate_inode_pages2()
(generally called by distributed filesystems when the file content has
been modified from remote) or truncate_inode_pages() (called from
truncate(2) or inode eviction) will wait for writeback completion (if
any) before freeing page.

Thus I don't think there's any possibility that .read_folio() or
.readahead() will be called when the writeback has not completed.


> @@ -1172,7 +1093,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>  	int err;
>  
>  	for (i = 0; i < ap->num_folios; i++)
> -		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> +		folio_wait_writeback(ap->folios[i]);

Ditto.



>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
> -					  struct folio *tmp_folio, uint32_t folio_index)
> +					  uint32_t folio_index)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  
> -	folio_copy(tmp_folio, folio);
> -
> -	ap->folios[folio_index] = tmp_folio;
> +	folio_get(folio);

I still think this folio_get() here is harmless but redundant.

Ditto page cache won't be freed before writeback completes.

Besides, other .writepages() implementaions e.g. iomap_writepages() also
doen't get the refcount when constructing the writeback IO.


> @@ -2481,7 +2200,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
>  	if (IS_ERR(folio))
>  		goto error;
>  
> -	fuse_wait_on_page_writeback(mapping->host, folio->index);
> +	folio_wait_writeback(folio);

I also doubt if wait_on_writeback() is needed here, as now there won't
be duplicate writeback IOs for the same page.


> @@ -2545,13 +2264,11 @@ static int fuse_launder_folio(struct folio *folio)
>  {
>  	int err = 0;
>  	if (folio_clear_dirty_for_io(folio)) {
> -		struct inode *inode = folio->mapping->host;
> -
>  		/* Serialize with pending writeback for the same page */
> -		fuse_wait_on_page_writeback(inode, folio->index);
> +		folio_wait_writeback(folio);

I think folio_wait_writeback() is unneeded after dropping the temp page
copying.  This is introduced in commit
3993382bb3198cc5e263c3519418e716bd57b056 ("fuse: launder page should
wait for page writeback") since .launder_page() could be called when the
previous writeback of the same page has not completed yet.  Since now we
won't clear PG_writeback until the writeback completes, .launder_page()
won't be called on the same page when the corresponding writeback IO is
still inflight.


-- 
Thanks,
Jingbo

