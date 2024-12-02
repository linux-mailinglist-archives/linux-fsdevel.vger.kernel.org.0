Return-Path: <linux-fsdevel+bounces-36268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E39E0705
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDDD280FAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960F20898F;
	Mon,  2 Dec 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2gyjDro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BC205ADE
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153081; cv=none; b=LLGIgHuseB1MPrhMLz4IRvb5ygZ/5yEdE3bqu6Yw9lqC9hTLy8U7h1WC94NSGlWL5tHYLtUntFVKDxAK9XicrfLoqxBeaqEqmS6Zg1Diz5pW/eqWXcXjB71CbkH8VirQmZn49a5AkmgaFU5fe1K+eGwvr5choH4bL7/mINqtHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153081; c=relaxed/simple;
	bh=jDZl4c1CNu20a/jHdJY5CVu5FJ2QZx1EkxKvXh+UF0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8a5t0AkUiv0wTdXqsVXChAHthI+T0nsaWy2dWDS2/OiN0Ktd+G+SzpsLwATM5IeiXHNwLYeDwO3uwIly+UeT7IEiB4R2aqn5Yj2553XT6ONSYTg5zl73tTHYVcP/NauSM81jfMxgBvIQ5PW8EuX9oF8cHte6VVf7uCWAOMbOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2gyjDro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733153077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=el4afnZhUFq+YSDIcO8cXs32ghoR5UkLrqEsMgwmxZo=;
	b=N2gyjDrosXahwBA+h7tfQA5YAJfhnNp8wEFh8YUMxs/Ha7VJM7HO5nLABahr/LoAanV9ds
	eRxNUnzEH/rP2TdSpO1T/uzHhHK/h/wvAIk7WB2TtFo8qourcnsjvPNGiNN0SRTjBfL3mT
	56LWAK1wrU+DF7nNzz/o4A/dp5vnFsA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-j0E22L_AOPi5ND2OkYiCSg-1; Mon,
 02 Dec 2024 10:24:32 -0500
X-MC-Unique: j0E22L_AOPi5ND2OkYiCSg-1
X-Mimecast-MFC-AGG-ID: j0E22L_AOPi5ND2OkYiCSg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD5D11945CB7;
	Mon,  2 Dec 2024 15:24:30 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.140])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 809611955D45;
	Mon,  2 Dec 2024 15:24:28 +0000 (UTC)
Date: Mon, 2 Dec 2024 10:26:14 -0500
From: Brian Foster <bfoster@redhat.com>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z03RlpfdJgsJ_glO@bfoster>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0sVkSXzxUDReow7@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Nov 30, 2024 at 09:39:29PM +0800, Long Li wrote:
> On Wed, Nov 27, 2024 at 02:35:02PM +0800, Long Li wrote:
> > During concurrent append writes to XFS filesystem, zero padding data
> > may appear in the file after power failure. This happens due to imprecise
> > disk size updates when handling write completion.
> > 
> > Consider this scenario with concurrent append writes same file:
> > 
> >   Thread 1:                  Thread 2:
> >   ------------               -----------
> >   write [A, A+B]
> >   update inode size to A+B
> >   submit I/O [A, A+BS]
> >                              write [A+B, A+B+C]
> >                              update inode size to A+B+C
> >   <I/O completes, updates disk size to min(A+B+C, A+BS)>
> >   <power failure>
> > 
> > After reboot:
> >   1) with A+B+C < A+BS, the file has zero padding in range [A+B, A+B+C]
> > 
> >   |<         Block Size (BS)      >|
> >   |DDDDDDDDDDDDDDDD0000000000000000|
> >   ^               ^        ^
> >   A              A+B     A+B+C
> >                          (EOF)
> > 
> >   2) with A+B+C > A+BS, the file has zero padding in range [A+B, A+BS]
> > 
> >   |<         Block Size (BS)      >|<           Block Size (BS)    >|
> >   |DDDDDDDDDDDDDDDD0000000000000000|00000000000000000000000000000000|
> >   ^               ^                ^               ^
> >   A              A+B              A+BS           A+B+C
> >                                   (EOF)
> > 
> >   D = Valid Data
> >   0 = Zero Padding
> > 
> > The issue stems from disk size being set to min(io_offset + io_size,
> > inode->i_size) at I/O completion. Since io_offset+io_size is block
> > size granularity, it may exceed the actual valid file data size. In
> > the case of concurrent append writes, inode->i_size may be larger
> > than the actual range of valid file data written to disk, leading to
> > inaccurate disk size updates.
> > 
> > This patch modifies the meaning of io_size to represent the size of
> > valid data within EOF in an ioend. If the ioend spans beyond i_size,
> > io_size will be trimmed to provide the file with more accurate size
> > information. This is particularly useful for on-disk size updates
> > at completion time.
> > 
> > After this change, ioends that span i_size will not grow or merge with
> > other ioends in concurrent scenarios. However, these cases that need
> > growth/merging rarely occur and it seems no noticeable performance impact.
> > Although rounding up io_size could enable ioend growth/merging in these
> > scenarios, we decided to keep the code simple after discussion [1].
> > 
> > Another benefit is that it makes the xfs_ioend_is_append() check more
> > accurate, which can reduce unnecessary end bio callbacks of xfs_end_bio()
> > in certain scenarios, such as repeated writes at the file tail without
> > extending the file size.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Link[1]: https://patchwork.kernel.org/project/xfs/patch/20241113091907.56937-1-leo.lilong@huawei.com
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > ---
> > v4->v5: remove iomap_ioend_size_aligned() and don't round up io_size for
> > 	ioend growth/merging to keep the code simple. 
> >  fs/iomap/buffered-io.c | 10 ++++++++++
> >  include/linux/iomap.h  |  2 +-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d42f01e0fc1c..dc360c8e5641 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1774,6 +1774,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> >  {
> >  	struct iomap_folio_state *ifs = folio->private;
> >  	size_t poff = offset_in_folio(folio, pos);
> > +	loff_t isize = i_size_read(inode);
> >  	int error;
> >  
> >  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
> > @@ -1789,7 +1790,16 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> >  
> >  	if (ifs)
> >  		atomic_add(len, &ifs->write_bytes_pending);
> > +
> > +	/*
> > +	 * If the ioend spans i_size, trim io_size to the former to provide
> > +	 * the fs with more accurate size information. This is useful for
> > +	 * completion time on-disk size updates.
> > +	 */
> >  	wpc->ioend->io_size += len;
> > +	if (wpc->ioend->io_offset + wpc->ioend->io_size > isize)
> > +		wpc->ioend->io_size = isize - wpc->ioend->io_offset;
> > +
>  
> When performing fsstress test with this patch set, there is a very low probability of
> encountering an issue where isize is less than ioend->io_offset in iomap_add_to_ioend.
> After investigation, this was found to be caused by concurrent with truncate operations.
> Consider a scenario with 4K block size and a file size of 12K.
> 
> //write back [8K, 12K]           //truncate file to 4K
> ----------------------          ----------------------
> iomap_writepage_map             xfs_setattr_size
>   iomap_writepage_handle_eof
>                                   truncate_setsize
> 				    i_size_write(inode, newsize)  //update inode size to 4K
>   iomap_writepage_map_blocks
>     iomap_add_to_ioend
>            < iszie < ioend->io_offset>
> 	   <iszie = 4K,  ioend->io_offset=8K>
> 
> It appears that in extreme cases, folios beyond EOF might be written back,
> resulting in situations where isize is less than pos. In such cases,
> maybe we should not trim the io_size further.
> 

Hmm.. it might be wise to characterize this further to determine whether
there are potentially larger problems to address before committing to
anything. For example, assuming truncate acquires ilock and does
xfs_itruncate_extents() and whatnot before this ioend submits/completes,
does anything in that submission or completion path detect and handle
this scenario gracefully? What if the ioend happens to be unwritten
post-eof preallocation and completion wants to convert blocks that might
no longer exist in the file..?

I don't see anything obvious on a quick look other than unwritten
conversion doesn't look like it would bump up i_size, which sounds sane,
but I could have easily missed something. If nobody else can point at
something, a way to instrument this might be to do something like:

1. add post-eof preallocation to a file
2. buffered write beyond eof
3. inject a delay in the writeback path somewhere after the writeback
eof checks
4. when writeback sits on that delay, truncate the file and try to
remove those extents before the ioend submits

Maybe something similar could be done to isolate the append ioend
completion scenario as well. Hm?

Brian

> Long Li
> 
> 


