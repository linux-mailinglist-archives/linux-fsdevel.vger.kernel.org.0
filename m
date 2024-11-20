Return-Path: <linux-fsdevel+bounces-35297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACC9D37B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591CB1F22DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB419DF4F;
	Wed, 20 Nov 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fW6CeUwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E318EFC1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096585; cv=none; b=g4sToUEOzs4klgLh+3j/M43h0R6H1K4LWpzWHbhQQfnVmDDdjf4QMWwOPtaGHIhv1xy5rUQ0BeNNqlW41XdLgi62DWpHUfdYt1dB6VdlQQs/mCXnLaBzMGOd2D221/SWIh2WENwmjHuhs2dffmDO0V5eIz12trQcwGq8NuQMi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096585; c=relaxed/simple;
	bh=9dRJzAz8UuQq1G4RTL0SgfQ4llXaHjy6aqBMkg96PBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1w615v2T0GK0dU20+daUOF8Rw+PWmX4c87/SS2Vsr/yaauZ4yhQEEhQ30qCefDLzmgSlkiZRqDWupvxwa2x9wg1iXBT+TL68egYmGJIR7JznmYvuMRQcqtV95n6U5pNaNTqhyUaZrsKJVzjtBtfExUw7ujZveyLONBWmD9oMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fW6CeUwV; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732096572; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OdX8fHoMlswM6ZP/2AT7Q0ptZ6gYWHmieT+vd+jRDeg=;
	b=fW6CeUwVUg2aPfXD65eJpbsu8CRrO4i9iaMhbDvyBjPFadM+1yLnrXt/6Xr2yxbHk8dMVQw1jQlAXWwubdx2wmHeQ8hGbia0W/EUlPjkOpDJqmMefsKKkwr00u4ttV0xOC7VOeSo08rWvlP4Bs1rqzw/iVrjVLaCwOSMFSHRz+U=
Received: from 30.221.144.243(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJrw6GJ_1732096571 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 17:56:12 +0800
Message-ID: <cad4a8b3-8065-4187-875f-1810263b988c@linux.alibaba.com>
Date: Wed, 20 Nov 2024 17:56:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-6-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241115224459.427610-6-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/16/24 6:44 AM, Joanne Koong wrote:
> In the current FUSE writeback design (see commit 3be5a52b30aa
> ("fuse: support writable mmap")), a temp page is allocated for every
> dirty page to be written back, the contents of the dirty page are copied over
> to the temp page, and the temp page gets handed to the server to write back.
> 
> This is done so that writeback may be immediately cleared on the dirty page,
> and this in turn is done for two reasons:
> a) in order to mitigate the following deadlock scenario that may arise
> if reclaim waits on writeback on the dirty page to complete:
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
> b) in order to unblock internal (eg sync, page compaction) waits on
> writeback without needing the server to complete writing back to disk,
> which may take an indeterminate amount of time.
> 
> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
> the situations described above, FUSE writeback does not need to use
> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
> 
> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
> and removes the temporary pages + extra copying and the internal rb
> tree.
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
> ---
>  fs/fuse/file.c | 339 +++----------------------------------------------
>  1 file changed, 20 insertions(+), 319 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc9..56289ac58596 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -415,89 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
>  
>  struct fuse_writepage_args {
>  	struct fuse_io_args ia;
> -	struct rb_node writepages_entry;
>  	struct list_head queue_entry;
> -	struct fuse_writepage_args *next;
>  	struct inode *inode;
>  	struct fuse_sync_bucket *bucket;
>  };
>  
> -static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
> -					    pgoff_t idx_from, pgoff_t idx_to)
> -{
> -	struct rb_node *n;
> -
> -	n = fi->writepages.rb_node;
> -
> -	while (n) {
> -		struct fuse_writepage_args *wpa;
> -		pgoff_t curr_index;
> -
> -		wpa = rb_entry(n, struct fuse_writepage_args, writepages_entry);
> -		WARN_ON(get_fuse_inode(wpa->inode) != fi);
> -		curr_index = wpa->ia.write.in.offset >> PAGE_SHIFT;
> -		if (idx_from >= curr_index + wpa->ia.ap.num_folios)
> -			n = n->rb_right;
> -		else if (idx_to < curr_index)
> -			n = n->rb_left;
> -		else
> -			return wpa;
> -	}
> -	return NULL;
> -}
> -
> -/*
> - * Check if any page in a range is under writeback
> - */
> -static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
> -				   pgoff_t idx_to)
> -{
> -	struct fuse_inode *fi = get_fuse_inode(inode);
> -	bool found;
> -
> -	if (RB_EMPTY_ROOT(&fi->writepages))
> -		return false;
> -
> -	spin_lock(&fi->lock);
> -	found = fuse_find_writeback(fi, idx_from, idx_to);
> -	spin_unlock(&fi->lock);
> -
> -	return found;
> -}
> -
> -static inline bool fuse_page_is_writeback(struct inode *inode, pgoff_t index)
> -{
> -	return fuse_range_is_writeback(inode, index, index);
> -}
> -
> -/*
> - * Wait for page writeback to be completed.
> - *
> - * Since fuse doesn't rely on the VM writeback tracking, this has to
> - * use some other means.
> - */
> -static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
> -{
> -	struct fuse_inode *fi = get_fuse_inode(inode);
> -
> -	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
> -}
> -
> -static inline bool fuse_folio_is_writeback(struct inode *inode,
> -					   struct folio *folio)
> -{
> -	pgoff_t last = folio_next_index(folio) - 1;
> -	return fuse_range_is_writeback(inode, folio_index(folio), last);
> -}
> -
> -static void fuse_wait_on_folio_writeback(struct inode *inode,
> -					 struct folio *folio)
> -{
> -	struct fuse_inode *fi = get_fuse_inode(inode);
> -
> -	wait_event(fi->page_waitq, !fuse_folio_is_writeback(inode, folio));
> -}
> -
>  /*
>   * Wait for all pending writepages on the inode to finish.
>   *
> @@ -886,13 +808,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
>  	ssize_t res;
>  	u64 attr_ver;
>  
> -	/*
> -	 * With the temporary pages that are used to complete writeback, we can
> -	 * have writeback that extends beyond the lifetime of the folio.  So
> -	 * make sure we read a properly synced folio.
> -	 */
> -	fuse_wait_on_folio_writeback(inode, folio);
> -
>  	attr_ver = fuse_get_attr_version(fm->fc);
>  
>  	/* Don't overflow end offset */
> @@ -1003,17 +918,12 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
>  static void fuse_readahead(struct readahead_control *rac)
>  {
>  	struct inode *inode = rac->mapping->host;
> -	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	unsigned int max_pages, nr_pages;
> -	pgoff_t first = readahead_index(rac);
> -	pgoff_t last = first + readahead_count(rac) - 1;
>  
>  	if (fuse_is_bad(inode))
>  		return;
>  
> -	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
> -
>  	max_pages = min_t(unsigned int, fc->max_pages,
>  			fc->max_read / PAGE_SIZE);
>  
> @@ -1172,7 +1082,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>  	int err;
>  
>  	for (i = 0; i < ap->num_folios; i++)
> -		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> +		folio_wait_writeback(ap->folios[i]);
>  
>  	fuse_write_args_fill(ia, ff, pos, count);
>  	ia->write.in.flags = fuse_write_flags(iocb);
> @@ -1622,7 +1532,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  			return res;
>  		}
>  	}
> -	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> +	if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
>  		if (!write)
>  			inode_lock(inode);
>  		fuse_sync_writes(inode);
> @@ -1825,7 +1735,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
>  		fuse_sync_bucket_dec(wpa->bucket);
>  
>  	for (i = 0; i < ap->num_folios; i++)
> -		folio_put(ap->folios[i]);
> +		folio_end_writeback(ap->folios[i]);

I noticed that if we folio_end_writeback() in fuse_writepage_finish()
(rather than fuse_writepage_free()), there's ~50% buffer write
bandwridth performance gain (5500MB -> 8500MB)[*]

The fuse server is generally implemented in multi-thread style, and
multi (fuse server) worker threads could fetch and process FUSE_WRITE
requests of one fuse inode.  Then there's serious lock contention for
the xarray lock (of the address space) when these multi worker threads
call fuse_writepage_end->folio_end_writeback when they are sending
replies of FUSE_WRITE requests.

The lock contention is greatly alleviated when folio_end_writeback() is
serialized with fi->lock.  IOWs in the current implementation
(folio_end_writeback() in fuse_writepage_free()), each worker thread
needs to compete for the xarray lock for 256 times (one fuse request can
contain at most 256 pages if FUSE_MAX_MAX_PAGES is 256) when completing
a FUSE_WRITE request.

After moving folio_end_writeback() to fuse_writepage_finish(), each
worker thread needs to compete for fi->lock only once.  IOWs the locking
granularity is larger now.



> @@ -2367,54 +2111,23 @@ static int fuse_writepages_fill(struct folio *folio,
>  		data->wpa = NULL;
>  	}
>  
> -	err = -ENOMEM;
> -	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> -	if (!tmp_folio)
> -		goto out_unlock;
> -
> -	/*
> -	 * The page must not be redirtied until the writeout is completed
> -	 * (i.e. userspace has sent a reply to the write request).  Otherwise
> -	 * there could be more than one temporary page instance for each real
> -	 * page.
> -	 *
> -	 * This is ensured by holding the page lock in page_mkwrite() while
> -	 * checking fuse_page_is_writeback().  We already hold the page lock
> -	 * since clear_page_dirty_for_io() and keep it held until we add the
> -	 * request to the fi->writepages list and increment ap->num_folios.
> -	 * After this fuse_page_is_writeback() will indicate that the page is
> -	 * under writeback, so we can release the page lock.
> -	 */
>  	if (data->wpa == NULL) {
>  		err = -ENOMEM;
>  		wpa = fuse_writepage_args_setup(folio, data->ff);
> -		if (!wpa) {
> -			folio_put(tmp_folio);
> +		if (!wpa)
>  			goto out_unlock;
> -		}
>  		fuse_file_get(wpa->ia.ff);
>  		data->max_folios = 1;
>  		ap = &wpa->ia.ap;
>  	}
>  	folio_start_writeback(folio);

There's also a lock contention for the xarray lock when calling
folio_start_writeback().

I also noticed a strange thing that, if we lock fi->lock and unlock
immediately, the write bandwidth improves by 5% (8500MB -> 9000MB).  The
palce where to insert the "locking fi->lock and unlocking" actually
doesn't matter.  "perf lock contention" shows the lock contention for
the xarray lock is greatly alleviated, though I can't understand how it
is done quite well...

As the performance gain is not significant (~5%), I think we can leave
this stange phenomenon aside for now.



[*] test case:
./passthrough_hp  --bypass-rw 2  /tmp /mnt
(testbench mode in
https://github.com/libfuse/libfuse/pull/807/commits/e83789cc6e83ca42ccc9899c4f7f8c69f31cbff9
bypass the buffer copy along with the persistence procedure)

fio -fallocate=0 -numjobs=32 -iodepth=1 -ioengine=sync -sync=0
--direct=0 -rw=write -bs=1M -size=100G --time_based --runtime=300
-directory=/mnt/ --group_reporting --name=Fio
-- 
Thanks,
Jingbo

