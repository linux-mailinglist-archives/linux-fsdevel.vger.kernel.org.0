Return-Path: <linux-fsdevel+bounces-11939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24485944E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 04:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D281F21B8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625520EE;
	Sun, 18 Feb 2024 03:13:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934815C8;
	Sun, 18 Feb 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226019; cv=none; b=PpthfPcllDQwLBd6b+3PAj/KwXad2V7wGleUuxHd+O+PT0xG5gMbkkhdzUnyEEt0JyxDaDj5JQ0HewBaDaWxsJOyiOGZBYfZnKQzgHPV1nqlrcbn06dbV89zFLwpPy+O1FOPA9qBhDD5hQM5rT7NRGKYn8+2ad1ERvKskaoeU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226019; c=relaxed/simple;
	bh=9PA84v9pzYDldV05l4PGP/Ofdp6nm/gY83fp9dEkKAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TB0WhufJrzpd3rPA4TiGXIX2d+T4cBgRQfd/fRz3yzkLVQAFPE5bCuSdoX1+JcZv2HiqbvRwugkioJg/6uWKeZ9U/nqiEk+uETlmLXUyfpl0zMQ+WzQs9L8BCpq7SlVikzwXFTYV27v1AIDBw2WSdb2UDzJqUTvJtPGgEu6IUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TcrKp3JBsz1Q8PS;
	Sun, 18 Feb 2024 11:11:26 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id AAE7718001B;
	Sun, 18 Feb 2024 11:13:32 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 11:13:31 +0800
Message-ID: <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
Date: Sun, 18 Feb 2024 11:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Christian
 Brauner <christian@brauner.io>, David Laight <David.Laight@ACULAB.COM>,
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20230925120309.1731676-1-dhowells@redhat.com>
 <20230925120309.1731676-8-dhowells@redhat.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20230925120309.1731676-8-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)

Hi David, Jens:

Recently, I tested the x86 coredump function of the user process in the
mainline (6.8-rc1) and found an deadloop issue related to this patch.

Let's discuss it.

1. Test step:
----------------------------
   a. Start a user process.
   b. Use EINJ to inject a hardware memory error into a page of
      the this user process.
   c. Send SIGBUS to this user process.
   d. After receiving the signal, a coredump file is configured to be
      written to tmpfs.

2. Root cause:
----------------------------
The deadloop occurs in generic_perform_write(), the call path:

elf_core_dump()
   -> dump_user_range()
     -> dump_emit_page()
       -> iov_iter_bvec()  //iter type set to BVEC
         -> iov_iter_set_copy_mc(&iter);  //support copy mc
           -> __kernel_write_iter()
             -> shmem_file_write_iter()
               -> generic_perform_write()

ssize_t generic_perform_write(...)
{
	[...]
	do {
		[...]
	again:
		//[4]
		if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
                              bytes)) {
			status = -EFAULT;
			break;
		}
		//[5]
		if (fatal_signal_pending(current)) {
			status = -EINTR;
			break;
		}
		
	        [...]
		
		//[1]
		copied = copy_page_from_iter_atomic(page, offset, bytes,
                          i);
		[...]
		
		//[2]
		status = a_ops->write_end(...);
		if (unlikely(status != copied)) {
			iov_iter_revert(i, copied - max(status, 0L));
			if (unlikely(status < 0))
				break;
		}
		cond_resched();
		
		if (unlikely(status == 0)) {
			/*
			* A short copy made ->write_end() reject the
			* thing entirely.  Might be memory poisoning
			* halfway through, might be a race with munmap,
			* might be severe memory pressure.
			*/
			if (copied)
				bytes = copied;
			//----[3]
			goto again;
		}
		[...]
	} while (iov_iter_count(i));
	[...]
}

[1]Before this patch:
   copy_page_from_iter_atomic()
     -> iterate_and_advance()
        -> __iterate_and_advance(..., ((void)(K),0))
          ->iterate_bvec macro
            -> left = ((void)(K),0)

With CONFIG_ARCH_HAS_COPY_MC, the K() is copy_mc_to_kernel() which
return "bytes not copied".

When a memory error occurs during K(), the value of "left" must be 0.
Therefore, the value of "copied" returned by
copy_page_from_iter_atomic() is not 0, and the loop of
generic_perform_write() can be ended normally.


After this patch:
   copy_page_from_iter_atomic()
     -> iterate_and_advance2()
       -> iterate_bvec()
         -> remain = step()

With CONFIG_ARCH_HAS_COPY_MC, the step() is copy_mc_to_kernel() which
return "bytes not copied".

When a memory error occurs during step(), the value of "left" equal to
the value of "part" (no one byte is copied successfully). In this case,
iterate_bvec() returns 0, and copy_page_from_iter_atomic() also returns
0. The callback shmem_write_end()[2] also returns 0. Finally,
generic_perform_write() goes to "goto again"[3], and the loop restarts.
4][5] cannot enter and exit the loop, then deadloop occurs.

Thanks.
Tong


在 2023/9/25 20:03, David Howells 写道:
> Convert the iov_iter iteration macros to inline functions to make the code
> easier to follow.
> 
> The functions are marked __always_inline as we don't want to end up with
> indirect calls in the code.  This, however, leaves dealing with ->copy_mc
> in an awkard situation since the step function (memcpy_from_iter_mc())
> needs to test the flag in the iterator, but isn't passed the iterator.
> This will be dealt with in a follow-up patch.
> 
> The variable names in the per-type iterator functions have been harmonised
> as much as possible and made clearer as to the variable purpose.
> 
> The iterator functions are also moved to a header file so that other
> operations that need to scan over an iterator can be added.  For instance,
> the rbd driver could use this to scan a buffer to see if it is all zeros
> and libceph could use this to generate a crc.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Christian Brauner <christian@brauner.io>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: David Laight <David.Laight@ACULAB.COM>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/3710261.1691764329@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/855.1692047347@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/20230816120741.534415-1-dhowells@redhat.com/ # v3
> ---
> 
> Notes:
>      Changes
>      =======
>      ver #5)
>       - Merge in patch to move iteration framework to a header file.
>       - Move "iter->count - progress" into individual iteration subfunctions.
> 
>   include/linux/iov_iter.h | 274 ++++++++++++++++++++++++++
>   lib/iov_iter.c           | 416 ++++++++++++++++-----------------------
>   2 files changed, 449 insertions(+), 241 deletions(-)
>   create mode 100644 include/linux/iov_iter.h
> 
> diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
> new file mode 100644
> index 000000000000..270454a6703d
> --- /dev/null
> +++ b/include/linux/iov_iter.h
> @@ -0,0 +1,274 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* I/O iterator iteration building functions.
> + *
> + * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#ifndef _LINUX_IOV_ITER_H
> +#define _LINUX_IOV_ITER_H
> +
> +#include <linux/uio.h>
> +#include <linux/bvec.h>
> +
> +typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
> +			     void *priv, void *priv2);
> +typedef size_t (*iov_ustep_f)(void __user *iter_base, size_t progress, size_t len,
> +			      void *priv, void *priv2);
> +
> +/*
> + * Handle ITER_UBUF.
> + */
> +static __always_inline
> +size_t iterate_ubuf(struct iov_iter *iter, size_t len, void *priv, void *priv2,
> +		    iov_ustep_f step)
> +{
> +	void __user *base = iter->ubuf;
> +	size_t progress = 0, remain;
> +
> +	remain = step(base + iter->iov_offset, 0, len, priv, priv2);
> +	progress = len - remain;
> +	iter->iov_offset += progress;
> +	iter->count -= progress;
> +	return progress;
> +}
> +
> +/*
> + * Handle ITER_IOVEC.
> + */
> +static __always_inline
> +size_t iterate_iovec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
> +		     iov_ustep_f step)
> +{
> +	const struct iovec *p = iter->__iov;
> +	size_t progress = 0, skip = iter->iov_offset;
> +
> +	do {
> +		size_t remain, consumed;
> +		size_t part = min(len, p->iov_len - skip);
> +
> +		if (likely(part)) {
> +			remain = step(p->iov_base + skip, progress, part, priv, priv2);
> +			consumed = part - remain;
> +			progress += consumed;
> +			skip += consumed;
> +			len -= consumed;
> +			if (skip < p->iov_len)
> +				break;
> +		}
> +		p++;
> +		skip = 0;
> +	} while (len);
> +
> +	iter->nr_segs -= p - iter->__iov;
> +	iter->__iov = p;
> +	iter->iov_offset = skip;
> +	iter->count -= progress;
> +	return progress;
> +}
> +
> +/*
> + * Handle ITER_KVEC.
> + */
> +static __always_inline
> +size_t iterate_kvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
> +		    iov_step_f step)
> +{
> +	const struct kvec *p = iter->kvec;
> +	size_t progress = 0, skip = iter->iov_offset;
> +
> +	do {
> +		size_t remain, consumed;
> +		size_t part = min(len, p->iov_len - skip);
> +
> +		if (likely(part)) {
> +			remain = step(p->iov_base + skip, progress, part, priv, priv2);
> +			consumed = part - remain;
> +			progress += consumed;
> +			skip += consumed;
> +			len -= consumed;
> +			if (skip < p->iov_len)
> +				break;
> +		}
> +		p++;
> +		skip = 0;
> +	} while (len);
> +
> +	iter->nr_segs -= p - iter->kvec;
> +	iter->kvec = p;
> +	iter->iov_offset = skip;
> +	iter->count -= progress;
> +	return progress;
> +}
> +
> +/*
> + * Handle ITER_BVEC.
> + */
> +static __always_inline
> +size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
> +		    iov_step_f step)
> +{
> +	const struct bio_vec *p = iter->bvec;
> +	size_t progress = 0, skip = iter->iov_offset;
> +
> +	do {
> +		size_t remain, consumed;
> +		size_t offset = p->bv_offset + skip, part;
> +		void *kaddr = kmap_local_page(p->bv_page + offset / PAGE_SIZE);
> +
> +		part = min3(len,
> +			   (size_t)(p->bv_len - skip),
> +			   (size_t)(PAGE_SIZE - offset % PAGE_SIZE));
> +		remain = step(kaddr + offset % PAGE_SIZE, progress, part, priv, priv2);
> +		kunmap_local(kaddr);
> +		consumed = part - remain;
> +		len -= consumed;
> +		progress += consumed;
> +		skip += consumed;
> +		if (skip >= p->bv_len) {
> +			skip = 0;
> +			p++;
> +		}
> +		if (remain)
> +			break;
> +	} while (len);
> +
> +	iter->nr_segs -= p - iter->bvec;
> +	iter->bvec = p;
> +	iter->iov_offset = skip;
> +	iter->count -= progress;
> +	return progress;
> +}
> +
> +/*
> + * Handle ITER_XARRAY.
> + */
> +static __always_inline
> +size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, void *priv2,
> +		      iov_step_f step)
> +{
> +	struct folio *folio;
> +	size_t progress = 0;
> +	loff_t start = iter->xarray_start + iter->iov_offset;
> +	pgoff_t index = start / PAGE_SIZE;
> +	XA_STATE(xas, iter->xarray, index);
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, folio, ULONG_MAX) {
> +		size_t remain, consumed, offset, part, flen;
> +
> +		if (xas_retry(&xas, folio))
> +			continue;
> +		if (WARN_ON(xa_is_value(folio)))
> +			break;
> +		if (WARN_ON(folio_test_hugetlb(folio)))
> +			break;
> +
> +		offset = offset_in_folio(folio, start + progress);
> +		flen = min(folio_size(folio) - offset, len);
> +
> +		while (flen) {
> +			void *base = kmap_local_folio(folio, offset);
> +
> +			part = min_t(size_t, flen,
> +				     PAGE_SIZE - offset_in_page(offset));
> +			remain = step(base, progress, part, priv, priv2);
> +			kunmap_local(base);
> +
> +			consumed = part - remain;
> +			progress += consumed;
> +			len -= consumed;
> +
> +			if (remain || len == 0)
> +				goto out;
> +			flen -= consumed;
> +			offset += consumed;
> +		}
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +	iter->iov_offset += progress;
> +	iter->count -= progress;
> +	return progress;
> +}
> +
> +/*
> + * Handle ITER_DISCARD.
> + */
> +static __always_inline
> +size_t iterate_discard(struct iov_iter *iter, size_t len, void *priv, void *priv2,
> +		      iov_step_f step)
> +{
> +	size_t progress = len;
> +
> +	iter->count -= progress;
> +	return progress;
> +}
> +
> +/**
> + * iterate_and_advance2 - Iterate over an iterator
> + * @iter: The iterator to iterate over.
> + * @len: The amount to iterate over.
> + * @priv: Data for the step functions.
> + * @priv2: More data for the step functions.
> + * @ustep: Function for UBUF/IOVEC iterators; given __user addresses.
> + * @step: Function for other iterators; given kernel addresses.
> + *
> + * Iterate over the next part of an iterator, up to the specified length.  The
> + * buffer is presented in segments, which for kernel iteration are broken up by
> + * physical pages and mapped, with the mapped address being presented.
> + *
> + * Two step functions, @step and @ustep, must be provided, one for handling
> + * mapped kernel addresses and the other is given user addresses which have the
> + * potential to fault since no pinning is performed.
> + *
> + * The step functions are passed the address and length of the segment, @priv,
> + * @priv2 and the amount of data so far iterated over (which can, for example,
> + * be added to @priv to point to the right part of a second buffer).  The step
> + * functions should return the amount of the segment they didn't process (ie. 0
> + * indicates complete processsing).
> + *
> + * This function returns the amount of data processed (ie. 0 means nothing was
> + * processed and the value of @len means processes to completion).
> + */
> +static __always_inline
> +size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
> +			    void *priv2, iov_ustep_f ustep, iov_step_f step)
> +{
> +	if (unlikely(iter->count < len))
> +		len = iter->count;
> +	if (unlikely(!len))
> +		return 0;
> +
> +	if (likely(iter_is_ubuf(iter)))
> +		return iterate_ubuf(iter, len, priv, priv2, ustep);
> +	if (likely(iter_is_iovec(iter)))
> +		return iterate_iovec(iter, len, priv, priv2, ustep);
> +	if (iov_iter_is_bvec(iter))
> +		return iterate_bvec(iter, len, priv, priv2, step);
> +	if (iov_iter_is_kvec(iter))
> +		return iterate_kvec(iter, len, priv, priv2, step);
> +	if (iov_iter_is_xarray(iter))
> +		return iterate_xarray(iter, len, priv, priv2, step);
> +	return iterate_discard(iter, len, priv, priv2, step);
> +}
> +
> +/**
> + * iterate_and_advance - Iterate over an iterator
> + * @iter: The iterator to iterate over.
> + * @len: The amount to iterate over.
> + * @priv: Data for the step functions.
> + * @ustep: Function for UBUF/IOVEC iterators; given __user addresses.
> + * @step: Function for other iterators; given kernel addresses.
> + *
> + * As iterate_and_advance2(), but priv2 is always NULL.
> + */
> +static __always_inline
> +size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
> +			   iov_ustep_f ustep, iov_step_f step)
> +{
> +	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
> +}
> +
> +#endif /* _LINUX_IOV_ITER_H */
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 227c9f536b94..65374ee91ecd 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -13,189 +13,69 @@
>   #include <net/checksum.h>
>   #include <linux/scatterlist.h>
>   #include <linux/instrumented.h>
> +#include <linux/iov_iter.h>
>   
> -/* covers ubuf and kbuf alike */
> -#define iterate_buf(i, n, base, len, off, __p, STEP) {		\
> -	size_t __maybe_unused off = 0;				\
> -	len = n;						\
> -	base = __p + i->iov_offset;				\
> -	len -= (STEP);						\
> -	i->iov_offset += len;					\
> -	n = len;						\
> -}
> -
> -/* covers iovec and kvec alike */
> -#define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
> -	size_t off = 0;						\
> -	size_t skip = i->iov_offset;				\
> -	do {							\
> -		len = min(n, __p->iov_len - skip);		\
> -		if (likely(len)) {				\
> -			base = __p->iov_base + skip;		\
> -			len -= (STEP);				\
> -			off += len;				\
> -			skip += len;				\
> -			n -= len;				\
> -			if (skip < __p->iov_len)		\
> -				break;				\
> -		}						\
> -		__p++;						\
> -		skip = 0;					\
> -	} while (n);						\
> -	i->iov_offset = skip;					\
> -	n = off;						\
> -}
> -
> -#define iterate_bvec(i, n, base, len, off, p, STEP) {		\
> -	size_t off = 0;						\
> -	unsigned skip = i->iov_offset;				\
> -	while (n) {						\
> -		unsigned offset = p->bv_offset + skip;		\
> -		unsigned left;					\
> -		void *kaddr = kmap_local_page(p->bv_page +	\
> -					offset / PAGE_SIZE);	\
> -		base = kaddr + offset % PAGE_SIZE;		\
> -		len = min(min(n, (size_t)(p->bv_len - skip)),	\
> -		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
> -		left = (STEP);					\
> -		kunmap_local(kaddr);				\
> -		len -= left;					\
> -		off += len;					\
> -		skip += len;					\
> -		if (skip == p->bv_len) {			\
> -			skip = 0;				\
> -			p++;					\
> -		}						\
> -		n -= len;					\
> -		if (left)					\
> -			break;					\
> -	}							\
> -	i->iov_offset = skip;					\
> -	n = off;						\
> -}
> -
> -#define iterate_xarray(i, n, base, len, __off, STEP) {		\
> -	__label__ __out;					\
> -	size_t __off = 0;					\
> -	struct folio *folio;					\
> -	loff_t start = i->xarray_start + i->iov_offset;		\
> -	pgoff_t index = start / PAGE_SIZE;			\
> -	XA_STATE(xas, i->xarray, index);			\
> -								\
> -	len = PAGE_SIZE - offset_in_page(start);		\
> -	rcu_read_lock();					\
> -	xas_for_each(&xas, folio, ULONG_MAX) {			\
> -		unsigned left;					\
> -		size_t offset;					\
> -		if (xas_retry(&xas, folio))			\
> -			continue;				\
> -		if (WARN_ON(xa_is_value(folio)))		\
> -			break;					\
> -		if (WARN_ON(folio_test_hugetlb(folio)))		\
> -			break;					\
> -		offset = offset_in_folio(folio, start + __off);	\
> -		while (offset < folio_size(folio)) {		\
> -			base = kmap_local_folio(folio, offset);	\
> -			len = min(n, len);			\
> -			left = (STEP);				\
> -			kunmap_local(base);			\
> -			len -= left;				\
> -			__off += len;				\
> -			n -= len;				\
> -			if (left || n == 0)			\
> -				goto __out;			\
> -			offset += len;				\
> -			len = PAGE_SIZE;			\
> -		}						\
> -	}							\
> -__out:								\
> -	rcu_read_unlock();					\
> -	i->iov_offset += __off;					\
> -	n = __off;						\
> -}
> -
> -#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
> -	if (unlikely(i->count < n))				\
> -		n = i->count;					\
> -	if (likely(n)) {					\
> -		if (likely(iter_is_ubuf(i))) {			\
> -			void __user *base;			\
> -			size_t len;				\
> -			iterate_buf(i, n, base, len, off,	\
> -						i->ubuf, (I)) 	\
> -		} else if (likely(iter_is_iovec(i))) {		\
> -			const struct iovec *iov = iter_iov(i);	\
> -			void __user *base;			\
> -			size_t len;				\
> -			iterate_iovec(i, n, base, len, off,	\
> -						iov, (I))	\
> -			i->nr_segs -= iov - iter_iov(i);	\
> -			i->__iov = iov;				\
> -		} else if (iov_iter_is_bvec(i)) {		\
> -			const struct bio_vec *bvec = i->bvec;	\
> -			void *base;				\
> -			size_t len;				\
> -			iterate_bvec(i, n, base, len, off,	\
> -						bvec, (K))	\
> -			i->nr_segs -= bvec - i->bvec;		\
> -			i->bvec = bvec;				\
> -		} else if (iov_iter_is_kvec(i)) {		\
> -			const struct kvec *kvec = i->kvec;	\
> -			void *base;				\
> -			size_t len;				\
> -			iterate_iovec(i, n, base, len, off,	\
> -						kvec, (K))	\
> -			i->nr_segs -= kvec - i->kvec;		\
> -			i->kvec = kvec;				\
> -		} else if (iov_iter_is_xarray(i)) {		\
> -			void *base;				\
> -			size_t len;				\
> -			iterate_xarray(i, n, base, len, off,	\
> -							(K))	\
> -		}						\
> -		i->count -= n;					\
> -	}							\
> -}
> -#define iterate_and_advance(i, n, base, len, off, I, K) \
> -	__iterate_and_advance(i, n, base, len, off, I, ((void)(K),0))
> -
> -static int copyout(void __user *to, const void *from, size_t n)
> +static __always_inline
> +size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> +			 size_t len, void *from, void *priv2)
>   {
>   	if (should_fail_usercopy())
> -		return n;
> -	if (access_ok(to, n)) {
> -		instrument_copy_to_user(to, from, n);
> -		n = raw_copy_to_user(to, from, n);
> +		return len;
> +	if (access_ok(iter_to, len)) {
> +		from += progress;
> +		instrument_copy_to_user(iter_to, from, len);
> +		len = raw_copy_to_user(iter_to, from, len);
>   	}
> -	return n;
> +	return len;
>   }
>   
> -static int copyout_nofault(void __user *to, const void *from, size_t n)
> +static __always_inline
> +size_t copy_to_user_iter_nofault(void __user *iter_to, size_t progress,
> +				 size_t len, void *from, void *priv2)
>   {
> -	long res;
> +	ssize_t res;
>   
>   	if (should_fail_usercopy())
> -		return n;
> -
> -	res = copy_to_user_nofault(to, from, n);
> +		return len;
>   
> -	return res < 0 ? n : res;
> +	from += progress;
> +	res = copy_to_user_nofault(iter_to, from, len);
> +	return res < 0 ? len : res;
>   }
>   
> -static int copyin(void *to, const void __user *from, size_t n)
> +static __always_inline
> +size_t copy_from_user_iter(void __user *iter_from, size_t progress,
> +			   size_t len, void *to, void *priv2)
>   {
> -	size_t res = n;
> +	size_t res = len;
>   
>   	if (should_fail_usercopy())
> -		return n;
> -	if (access_ok(from, n)) {
> -		instrument_copy_from_user_before(to, from, n);
> -		res = raw_copy_from_user(to, from, n);
> -		instrument_copy_from_user_after(to, from, n, res);
> +		return len;
> +	if (access_ok(iter_from, len)) {
> +		to += progress;
> +		instrument_copy_from_user_before(to, iter_from, len);
> +		res = raw_copy_from_user(to, iter_from, len);
> +		instrument_copy_from_user_after(to, iter_from, len, res);
>   	}
>   	return res;
>   }
>   
> +static __always_inline
> +size_t memcpy_to_iter(void *iter_to, size_t progress,
> +		      size_t len, void *from, void *priv2)
> +{
> +	memcpy(iter_to, from + progress, len);
> +	return 0;
> +}
> +
> +static __always_inline
> +size_t memcpy_from_iter(void *iter_from, size_t progress,
> +			size_t len, void *to, void *priv2)
> +{
> +	memcpy(to + progress, iter_from, len);
> +	return 0;
> +}
> +
>   /*
>    * fault_in_iov_iter_readable - fault in iov iterator for reading
>    * @i: iterator
> @@ -312,23 +192,29 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>   		return 0;
>   	if (user_backed_iter(i))
>   		might_fault();
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyout(base, addr + off, len),
> -		memcpy(base, addr + off, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance(i, bytes, (void *)addr,
> +				   copy_to_user_iter, memcpy_to_iter);
>   }
>   EXPORT_SYMBOL(_copy_to_iter);
>   
>   #ifdef CONFIG_ARCH_HAS_COPY_MC
> -static int copyout_mc(void __user *to, const void *from, size_t n)
> -{
> -	if (access_ok(to, n)) {
> -		instrument_copy_to_user(to, from, n);
> -		n = copy_mc_to_user((__force void *) to, from, n);
> +static __always_inline
> +size_t copy_to_user_iter_mc(void __user *iter_to, size_t progress,
> +			    size_t len, void *from, void *priv2)
> +{
> +	if (access_ok(iter_to, len)) {
> +		from += progress;
> +		instrument_copy_to_user(iter_to, from, len);
> +		len = copy_mc_to_user(iter_to, from, len);
>   	}
> -	return n;
> +	return len;
> +}
> +
> +static __always_inline
> +size_t memcpy_to_iter_mc(void *iter_to, size_t progress,
> +			 size_t len, void *from, void *priv2)
> +{
> +	return copy_mc_to_kernel(iter_to, from + progress, len);
>   }
>   
>   /**
> @@ -361,22 +247,20 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>   		return 0;
>   	if (user_backed_iter(i))
>   		might_fault();
> -	__iterate_and_advance(i, bytes, base, len, off,
> -		copyout_mc(base, addr + off, len),
> -		copy_mc_to_kernel(base, addr + off, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance(i, bytes, (void *)addr,
> +				   copy_to_user_iter_mc, memcpy_to_iter_mc);
>   }
>   EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
>   #endif /* CONFIG_ARCH_HAS_COPY_MC */
>   
> -static void *memcpy_from_iter(struct iov_iter *i, void *to, const void *from,
> -				 size_t size)
> +static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
> +				  size_t len, void *to, void *priv2)
>   {
> -	if (iov_iter_is_copy_mc(i))
> -		return (void *)copy_mc_to_kernel(to, from, size);
> -	return memcpy(to, from, size);
> +	struct iov_iter *iter = priv2;
> +
> +	if (iov_iter_is_copy_mc(iter))
> +		return copy_mc_to_kernel(to + progress, iter_from, len);
> +	return memcpy_from_iter(iter_from, progress, len, to, priv2);
>   }
>   
>   size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
> @@ -386,30 +270,46 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
>   
>   	if (user_backed_iter(i))
>   		might_fault();
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyin(addr + off, base, len),
> -		memcpy_from_iter(i, addr + off, base, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance2(i, bytes, addr, i,
> +				    copy_from_user_iter,
> +				    memcpy_from_iter_mc);
>   }
>   EXPORT_SYMBOL(_copy_from_iter);
>   
> +static __always_inline
> +size_t copy_from_user_iter_nocache(void __user *iter_from, size_t progress,
> +				   size_t len, void *to, void *priv2)
> +{
> +	return __copy_from_user_inatomic_nocache(to + progress, iter_from, len);
> +}
> +
>   size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
>   {
>   	if (WARN_ON_ONCE(!i->data_source))
>   		return 0;
>   
> -	iterate_and_advance(i, bytes, base, len, off,
> -		__copy_from_user_inatomic_nocache(addr + off, base, len),
> -		memcpy(addr + off, base, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance(i, bytes, addr,
> +				   copy_from_user_iter_nocache,
> +				   memcpy_from_iter);
>   }
>   EXPORT_SYMBOL(_copy_from_iter_nocache);
>   
>   #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
> +static __always_inline
> +size_t copy_from_user_iter_flushcache(void __user *iter_from, size_t progress,
> +				      size_t len, void *to, void *priv2)
> +{
> +	return __copy_from_user_flushcache(to + progress, iter_from, len);
> +}
> +
> +static __always_inline
> +size_t memcpy_from_iter_flushcache(void *iter_from, size_t progress,
> +				   size_t len, void *to, void *priv2)
> +{
> +	memcpy_flushcache(to + progress, iter_from, len);
> +	return 0;
> +}
> +
>   /**
>    * _copy_from_iter_flushcache - write destination through cpu cache
>    * @addr: destination kernel address
> @@ -431,12 +331,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
>   	if (WARN_ON_ONCE(!i->data_source))
>   		return 0;
>   
> -	iterate_and_advance(i, bytes, base, len, off,
> -		__copy_from_user_flushcache(addr + off, base, len),
> -		memcpy_flushcache(addr + off, base, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance(i, bytes, addr,
> +				   copy_from_user_iter_flushcache,
> +				   memcpy_from_iter_flushcache);
>   }
>   EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
>   #endif
> @@ -508,10 +405,9 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t byte
>   		void *kaddr = kmap_local_page(page);
>   		size_t n = min(bytes, (size_t)PAGE_SIZE - offset);
>   
> -		iterate_and_advance(i, n, base, len, off,
> -			copyout_nofault(base, kaddr + offset + off, len),
> -			memcpy(base, kaddr + offset + off, len)
> -		)
> +		n = iterate_and_advance(i, bytes, kaddr,
> +					copy_to_user_iter_nofault,
> +					memcpy_to_iter);
>   		kunmap_local(kaddr);
>   		res += n;
>   		bytes -= n;
> @@ -554,14 +450,25 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
>   }
>   EXPORT_SYMBOL(copy_page_from_iter);
>   
> -size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
> +static __always_inline
> +size_t zero_to_user_iter(void __user *iter_to, size_t progress,
> +			 size_t len, void *priv, void *priv2)
>   {
> -	iterate_and_advance(i, bytes, base, len, count,
> -		clear_user(base, len),
> -		memset(base, 0, len)
> -	)
> +	return clear_user(iter_to, len);
> +}
>   
> -	return bytes;
> +static __always_inline
> +size_t zero_to_iter(void *iter_to, size_t progress,
> +		    size_t len, void *priv, void *priv2)
> +{
> +	memset(iter_to, 0, len);
> +	return 0;
> +}
> +
> +size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
> +{
> +	return iterate_and_advance(i, bytes, NULL,
> +				   zero_to_user_iter, zero_to_iter);
>   }
>   EXPORT_SYMBOL(iov_iter_zero);
>   
> @@ -586,10 +493,9 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>   		}
>   
>   		p = kmap_atomic(page) + offset;
> -		iterate_and_advance(i, n, base, len, off,
> -			copyin(p + off, base, len),
> -			memcpy_from_iter(i, p + off, base, len)
> -		)
> +		n = iterate_and_advance2(i, n, p, i,
> +					 copy_from_user_iter,
> +					 memcpy_from_iter_mc);
>   		kunmap_atomic(p);
>   		copied += n;
>   		offset += n;
> @@ -1180,32 +1086,64 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>   }
>   EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
>   
> +static __always_inline
> +size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
> +				size_t len, void *to, void *priv2)
> +{
> +	__wsum next, *csum = priv2;
> +
> +	next = csum_and_copy_from_user(iter_from, to + progress, len);
> +	*csum = csum_block_add(*csum, next, progress);
> +	return next ? 0 : len;
> +}
> +
> +static __always_inline
> +size_t memcpy_from_iter_csum(void *iter_from, size_t progress,
> +			     size_t len, void *to, void *priv2)
> +{
> +	__wsum *csum = priv2;
> +
> +	*csum = csum_and_memcpy(to + progress, iter_from, len, *csum, progress);
> +	return 0;
> +}
> +
>   size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
>   			       struct iov_iter *i)
>   {
> -	__wsum sum, next;
> -	sum = *csum;
>   	if (WARN_ON_ONCE(!i->data_source))
>   		return 0;
> -
> -	iterate_and_advance(i, bytes, base, len, off, ({
> -		next = csum_and_copy_from_user(base, addr + off, len);
> -		sum = csum_block_add(sum, next, off);
> -		next ? 0 : len;
> -	}), ({
> -		sum = csum_and_memcpy(addr + off, base, len, sum, off);
> -	})
> -	)
> -	*csum = sum;
> -	return bytes;
> +	return iterate_and_advance2(i, bytes, addr, csum,
> +				    copy_from_user_iter_csum,
> +				    memcpy_from_iter_csum);
>   }
>   EXPORT_SYMBOL(csum_and_copy_from_iter);
>   
> +static __always_inline
> +size_t copy_to_user_iter_csum(void __user *iter_to, size_t progress,
> +			      size_t len, void *from, void *priv2)
> +{
> +	__wsum next, *csum = priv2;
> +
> +	next = csum_and_copy_to_user(from + progress, iter_to, len);
> +	*csum = csum_block_add(*csum, next, progress);
> +	return next ? 0 : len;
> +}
> +
> +static __always_inline
> +size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
> +			   size_t len, void *from, void *priv2)
> +{
> +	__wsum *csum = priv2;
> +
> +	*csum = csum_and_memcpy(iter_to, from + progress, len, *csum, progress);
> +	return 0;
> +}
> +
>   size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
>   			     struct iov_iter *i)
>   {
>   	struct csum_state *csstate = _csstate;
> -	__wsum sum, next;
> +	__wsum sum;
>   
>   	if (WARN_ON_ONCE(i->data_source))
>   		return 0;
> @@ -1219,14 +1157,10 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
>   	}
>   
>   	sum = csum_shift(csstate->csum, csstate->off);
> -	iterate_and_advance(i, bytes, base, len, off, ({
> -		next = csum_and_copy_to_user(addr + off, base, len);
> -		sum = csum_block_add(sum, next, off);
> -		next ? 0 : len;
> -	}), ({
> -		sum = csum_and_memcpy(base, addr + off, len, sum, off);
> -	})
> -	)
> +	
> +	bytes = iterate_and_advance2(i, bytes, (void *)addr, &sum,
> +				     copy_to_user_iter_csum,
> +				     memcpy_to_iter_csum);
>   	csstate->csum = csum_shift(sum, csstate->off);
>   	csstate->off += bytes;
>   	return bytes;
> 
> 

