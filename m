Return-Path: <linux-fsdevel+bounces-48007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658CAA88DC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E536A7AA615
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862724728D;
	Sun,  4 May 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="W62cWlmr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTvz8cQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF21DBB2E
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746381963; cv=none; b=CDLGgrZu6GEhv2khg2y/TpGcuKLc7kxdH7QE5RHwlCU4C+3UtdBvVrEfDKkODtnJQpeMJ3CLyuPVquqd+KZ/ZOeYYInk7CwjCf9MRAEMpdLS3Fk96svhx1gU30apM8mRGz4rJThVeH56+SKTrOUxaG6sDpBu4P0r6obVBcO8aL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746381963; c=relaxed/simple;
	bh=cpHWLAg0roR48xMWNxL0QAeE/a1E3KMRA8LFAFDbOqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6uppe12r9Cnm+/zaBoGNvbJZYwXgYehZVoWPUw+6w+mggZjUcqkNh19l977t/kFmeTFoGE6Nte6Qh0Qi5xd4szcPo63rqMApUYuDkBxNQnx87UC0JcY25nOUhyWGuzqwrwMJvYnVtpZEkt3OUvARG5a+o7YhKre23T0jqGbm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=W62cWlmr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTvz8cQA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A09E1140085;
	Sun,  4 May 2025 14:05:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 14:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746381959;
	 x=1746468359; bh=rCdcYVurOobk6YfoB+YLC+h4Fy2hHOrEvvGklmbNg9Q=; b=
	W62cWlmr9fiZq7FbJk0oasBmaHyDa/i/INE7C9TsFKmVAHBWQkAZqwWLZ1WN25VZ
	Fy4wTtBGl5JzgCB4ZI7e95zx7EstcwmQqTy3yx9/UToIO3ee2MJH8jyS3VW4Vkv/
	JHv0lPvQNw1gHfBJDjArPNJfgcQHEg2hLbMo8WUgrFbwDTr+3i/jDcbg9GmWenxh
	WLmOqLFzMKlbyT4XKC/CkjVIjZy4D/RDZrSJEV5mbjg9ebwH9OoaWHFCrK/jPxqp
	cH6x23IvdwARYRJf1mV+QaizSBavD9CV3fPUX/UrYoKy9mlrowUo1K8sBPgHtWnU
	4RWDnlVqW3g5SPpt0NvYPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746381959; x=
	1746468359; bh=rCdcYVurOobk6YfoB+YLC+h4Fy2hHOrEvvGklmbNg9Q=; b=m
	Tvz8cQApr9xl+1doEzHcsN3Fttgck6yQbHQDglDi1w3wKUks8a1brvRgGrChxHpf
	c2PDzkrEg7ZK/ZifbwJEUzBXRGO+254P2ksrER+3qYY72R7ZAWzB0HUTLGDg7nBL
	rwB8bn6r37qh2Yd8eHK2k3j0Ri2nwvlzZdkthL56Gvqjvf8+PMhNAvLJTO6gcyKd
	3qScN/XYt/kGzHHXQtETJ5sPIkD06ZH+Ty9SSVFLnCkYDP44lp6vvAsaJvrbjpB3
	CxwqVS4gEyE728TkXjrQzya3cQY/SW8P5j0VgQII3S/c2eX+rsgV+Y6TaXLfj5fD
	lTSSgLo/aKI1M7Q4W9ocg==
X-ME-Sender: <xms:hawXaC7ZWixga899g107ohGpSDzjAEh0fmQ9bC1IqLVY5Svrk4tibw>
    <xme:hawXaL7oK-TKZ_J8KQXQAyq1x44AhTNI60FgiltCVhhgHSmSGJvy8dJ4MKjKZx-6D
    v3qIw06XdL9t-w5>
X-ME-Received: <xmr:hawXaBclVeRGvNmgpgqWQcRN7HspdVrAxpPgqIo_KkWST77paFxQ5Pso6A6XHOokRggstw2tNoAlLpCkiR-Wt_AdJNBs5PWOFIPbR_-p8uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:hqwXaPLgqh_6sf0KtTfd8RAoY4w3ZIUanxC7Mx8lOM-YEHUAPVn7lw>
    <xmx:hqwXaGL3NnnvjzrgBEqj4zvym6XQCXGhM08rkFUgFFFiFTl085Io3g>
    <xmx:hqwXaAz954n6BxbOWudyLbLzQ_vowKyL4a-Vt9UXycFFgISSb9EyKg>
    <xmx:hqwXaKIXzUZ6dFQCRKIxJ_mui2VRJ-y6epBnugZhvxlkeMKbYXWwsQ>
    <xmx:h6wXaINByjh2Y1CI2BhKyF2eAcU-apqY0MPdQujBehtuHBhchGq8H1Np>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 14:05:56 -0400 (EDT)
Message-ID: <34f30f17-f9ce-4675-98c8-b50022d3b9f3@fastmail.fm>
Date: Sun, 4 May 2025 20:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] fuse: support copying large folios
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Currently, all folios associated with fuse are one page size. As part of
> the work to enable large folios, this commit adds support for copying
> to/from folios larger than one page size.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> ---
>  fs/fuse/dev.c        | 84 +++++++++++++++++++-------------------------
>  fs/fuse/fuse_dev_i.h |  2 +-
>  2 files changed, 37 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 155bb6aeaef5..7b0e3a394480 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -955,10 +955,10 @@ static int fuse_check_folio(struct folio *folio)
>   * folio that was originally in @pagep will lose a reference and the new
>   * folio returned in @pagep will carry a reference.
>   */
> -static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
> +static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop)
>  {
>  	int err;
> -	struct folio *oldfolio = page_folio(*pagep);
> +	struct folio *oldfolio = *foliop;
>  	struct folio *newfolio;
>  	struct pipe_buffer *buf = cs->pipebufs;
>  
> @@ -979,7 +979,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	cs->pipebufs++;
>  	cs->nr_segs--;
>  
> -	if (cs->len != PAGE_SIZE)
> +	if (cs->len != folio_size(oldfolio))
>  		goto out_fallback;
>  
>  	if (!pipe_buf_try_steal(cs->pipe, buf))
> @@ -1025,7 +1025,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	if (test_bit(FR_ABORTED, &cs->req->flags))
>  		err = -ENOENT;
>  	else
> -		*pagep = &newfolio->page;
> +		*foliop = newfolio;
>  	spin_unlock(&cs->req->waitq.lock);
>  
>  	if (err) {
> @@ -1058,8 +1058,8 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	goto out_put_old;
>  }
>  
> -static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
> -			 unsigned offset, unsigned count)
> +static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
> +			  unsigned offset, unsigned count)
>  {
>  	struct pipe_buffer *buf;
>  	int err;
> @@ -1067,17 +1067,17 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
>  	if (cs->nr_segs >= cs->pipe->max_usage)
>  		return -EIO;
>  
> -	get_page(page);
> +	folio_get(folio);
>  	err = unlock_request(cs->req);
>  	if (err) {
> -		put_page(page);
> +		folio_put(folio);
>  		return err;
>  	}
>  
>  	fuse_copy_finish(cs);
>  
>  	buf = cs->pipebufs;
> -	buf->page = page;
> +	buf->page = &folio->page;
>  	buf->offset = offset;
>  	buf->len = count;
>  
> @@ -1089,20 +1089,21 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
>  }
>  
>  /*
> - * Copy a page in the request to/from the userspace buffer.  Must be
> + * Copy a folio in the request to/from the userspace buffer.  Must be
>   * done atomically
>   */
> -static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
> -			  unsigned offset, unsigned count, int zeroing)
> +static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
> +			   unsigned offset, unsigned count, int zeroing)
>  {
>  	int err;
> -	struct page *page = *pagep;
> +	struct folio *folio = *foliop;
> +	size_t size = folio_size(folio);
>  
> -	if (page && zeroing && count < PAGE_SIZE)
> -		clear_highpage(page);
> +	if (folio && zeroing && count < size)
> +		folio_zero_range(folio, 0, size);
>  
>  	while (count) {
> -		if (cs->write && cs->pipebufs && page) {
> +		if (cs->write && cs->pipebufs && folio) {
>  			/*
>  			 * Can't control lifetime of pipe buffers, so always
>  			 * copy user pages.
> @@ -1112,12 +1113,12 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
>  				if (err)
>  					return err;
>  			} else {
> -				return fuse_ref_page(cs, page, offset, count);
> +				return fuse_ref_folio(cs, folio, offset, count);
>  			}
>  		} else if (!cs->len) {
> -			if (cs->move_pages && page &&
> -			    offset == 0 && count == PAGE_SIZE) {
> -				err = fuse_try_move_page(cs, pagep);
> +			if (cs->move_folios && folio &&
> +			    offset == 0 && count == folio_size(folio)) {
> +				err = fuse_try_move_folio(cs, foliop);
>  				if (err <= 0)
>  					return err;
>  			} else {
> @@ -1126,22 +1127,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
>  					return err;
>  			}
>  		}
> -		if (page) {
> -			void *mapaddr = kmap_local_page(page);
> -			void *buf = mapaddr + offset;
> +		if (folio) {
> +			void *mapaddr = kmap_local_folio(folio, offset);
> +			void *buf = mapaddr;
>  			offset += fuse_copy_do(cs, &buf, &count);
>  			kunmap_local(mapaddr);
>  		} else
>  			offset += fuse_copy_do(cs, NULL, &count);
>  	}
> -	if (page && !cs->write)
> -		flush_dcache_page(page);
> +	if (folio && !cs->write)
> +		flush_dcache_folio(folio);
>  	return 0;
>  }
>  
> -/* Copy pages in the request to/from userspace buffer */
> -static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
> -			   int zeroing)
> +/* Copy folios in the request to/from userspace buffer */
> +static int fuse_copy_folios(struct fuse_copy_state *cs, unsigned nbytes,
> +			    int zeroing)
>  {
>  	unsigned i;
>  	struct fuse_req *req = cs->req;
> @@ -1151,23 +1152,12 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
>  		int err;
>  		unsigned int offset = ap->descs[i].offset;
>  		unsigned int count = min(nbytes, ap->descs[i].length);
> -		struct page *orig, *pagep;
> -
> -		orig = pagep = &ap->folios[i]->page;
>  
> -		err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
> +		err = fuse_copy_folio(cs, &ap->folios[i], offset, count, zeroing);
>  		if (err)
>  			return err;
>  
>  		nbytes -= count;
> -
> -		/*
> -		 *  fuse_copy_page may have moved a page from a pipe instead of
> -		 *  copying into our given page, so update the folios if it was
> -		 *  replaced.
> -		 */
> -		if (pagep != orig)
> -			ap->folios[i] = page_folio(pagep);
>  	}
>  	return 0;
>  }
> @@ -1197,7 +1187,7 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>  	for (i = 0; !err && i < numargs; i++)  {
>  		struct fuse_arg *arg = &args[i];
>  		if (i == numargs - 1 && argpages)
> -			err = fuse_copy_pages(cs, arg->size, zeroing);
> +			err = fuse_copy_folios(cs, arg->size, zeroing);
>  		else
>  			err = fuse_copy_one(cs, arg->value, arg->size);
>  	}
> @@ -1786,7 +1776,6 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	num = outarg.size;
>  	while (num) {
>  		struct folio *folio;
> -		struct page *page;
>  		unsigned int this_num;
>  
>  		folio = filemap_grab_folio(mapping, index);
> @@ -1794,9 +1783,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		if (IS_ERR(folio))
>  			goto out_iput;
>  
> -		page = &folio->page;
>  		this_num = min_t(unsigned, num, folio_size(folio) - offset);
> -		err = fuse_copy_page(cs, &page, offset, this_num, 0);
> +		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
>  		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
>  		    (this_num == folio_size(folio) || file_size == end)) {
>  			folio_zero_segment(folio, this_num, folio_size(folio));
> @@ -2037,8 +2025,8 @@ static int fuse_notify_inc_epoch(struct fuse_conn *fc)
>  static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
>  		       unsigned int size, struct fuse_copy_state *cs)
>  {
> -	/* Don't try to move pages (yet) */
> -	cs->move_pages = false;
> +	/* Don't try to move folios (yet) */
> +	cs->move_folios = false;
>  
>  	switch (code) {
>  	case FUSE_NOTIFY_POLL:
> @@ -2189,7 +2177,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  	spin_unlock(&fpq->lock);
>  	cs->req = req;
>  	if (!req->args->page_replace)
> -		cs->move_pages = false;
> +		cs->move_folios = false;
>  
>  	if (oh.error)
>  		err = nbytes != sizeof(oh) ? -EINVAL : 0;
> @@ -2307,7 +2295,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>  	cs.pipe = pipe;
>  
>  	if (flags & SPLICE_F_MOVE)
> -		cs.move_pages = true;
> +		cs.move_folios = true;
>  
>  	ret = fuse_dev_do_write(fud, &cs, len);
>  
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index db136e045925..5a9bd771a319 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -30,7 +30,7 @@ struct fuse_copy_state {
>  	unsigned int len;
>  	unsigned int offset;
>  	bool write:1;
> -	bool move_pages:1;
> +	bool move_folios:1;
>  	bool is_uring:1;
>  	struct {
>  		unsigned int copied_sz; /* copied size into the user buffer */


