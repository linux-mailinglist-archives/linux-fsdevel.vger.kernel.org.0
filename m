Return-Path: <linux-fsdevel+bounces-35747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFFF9D79D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674F42821A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F8B666;
	Mon, 25 Nov 2024 01:47:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905180B;
	Mon, 25 Nov 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732499265; cv=none; b=j0HXkQwDpJX+JE/yBerVwkW5co0V1gLurcIOrmtLqh5z0l3OM9RnPivBoXg0niyQPNYD0uurK8/XJOloGAOLP8OutM1/YDwSDWEE74+wHeKhzu/rf6DUO17Xuyg+Ilsn27OzWVXedO/jwRqi3vEyLj2x3AqhhGLWhrczVD78We4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732499265; c=relaxed/simple;
	bh=F2GUL/+T8zED1xEtnrSOwlk6AQj2HTjq3G7hOoUPcyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hClW1h7PO5rxuQlggLLkzgZ+Lx9GjHW5iSOjUuDM/fqlrhg0YtqxeHxvX+kCUIw21JiESXRw0sKzvzy9j1ZMW/hqfwysYewEFLSu5OIOIuxB2VE8SVBo+rKoUziKlLypkK7duXo5m1WG6tzsHkK4PpFfvzEsocAc8Ge9hsK9atA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XxT7J4wbYzqScw;
	Mon, 25 Nov 2024 09:45:48 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 22F4318009B;
	Mon, 25 Nov 2024 09:47:39 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 09:47:38 +0800
Date: Mon, 25 Nov 2024 09:45:46 +0800
From: Long Li <leo.lilong@huawei.com>
To: Brian Foster <bfoster@redhat.com>
CC: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v3 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0PWyuEohzKlmxvw@localhost.localdomain>
References: <20241121063430.3304895-1-leo.lilong@huawei.com>
 <Z0CTCYWwu8Ko0rPV@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z0CTCYWwu8Ko0rPV@bfoster>
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Fri, Nov 22, 2024 at 09:19:53AM -0500, Brian Foster wrote:
> On Thu, Nov 21, 2024 at 02:34:29PM +0800, Long Li wrote:
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
> > This patch changes the meaning of io_size to represent the size of
> > valid data in ioend, while the extent size of ioend can be obtained
> > by rounding up based on block size. It ensures more precise disk
> > size updates and avoids the zero padding issue.  Another benefit is
> > that it makes the xfs_ioend_is_append() check more accurate, which
> > can reduce unnecessary end bio callbacks of xfs_end_bio() in certain
> > scenarios, such as repeated writes at the file tail without extending
> > the file size.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > ---
> > v2->v3:
> >   1. Modify commit message and add the description of A+B+C > A+BS
> >   2. Rename iomap_ioend_extent_size() to iomap_ioend_size_aligned()
> >   3. Move iomap_ioend_size_aligned to buffered-io.c and avoid exposed
> >      to new users.
> >   4. Add comment for rounding up io_size to explain when/why use it
> > 
> 
> Thanks for the tweaks..
> 
> >  fs/iomap/buffered-io.c | 43 ++++++++++++++++++++++++++++++++++++------
> >  include/linux/iomap.h  |  2 +-
> >  2 files changed, 38 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d42f01e0fc1c..3f59dfb4d58d 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1593,12 +1593,35 @@ iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_finish_ioends);
> >  
> > +/*
> > + * Calculates the extent size of an ioend by rounding up to block size. When
> > + * the last block in the ioend's extent contains the file EOF and the EOF is
> > + * not block-aligned, the io_size will not be block-aligned.
> > + *
> > + * This function is specifically used for ioend grow/merge management:
> > + * 1. In concurrent writes, when one write's io_size is truncated due to
> > + *    non-block-aligned file size while another write extends the file size,
> > + *    if these two writes are physically and logically contiguous at block
> > + *    boundaries, rounding up io_size to block boundaries helps grow the
> > + *    first write's ioend and share this ioend between both writes.
> > + * 2. During IO completion, we try to merge physically and logically
> > + *    contiguous ioends before completion to minimize the number of
> > + *    transactions. Rounding up io_size to block boundaries helps merge
> > + *    ioends whose io_size is not block-aligned.
> > + */
> 
> I might suggest to simplify this and maybe split off a comment to where
> the ioend size is trimmed as well. For example:
> 
> "Calculate the physical size of an ioend by rounding up to block
> granularity. io_size might be unaligned if the last block crossed an
> unaligned i_size boundary at creation time."

Ok, I want to move the explain of iomap_ioend_size_aligned() to commit
message. 
> 
> > +static inline size_t iomap_ioend_size_aligned(struct iomap_ioend *ioend)
> > +{
> > +	return round_up(ioend->io_size, i_blocksize(ioend->io_inode));
> > +}
> > +
> >  /*
> >   * We can merge two adjacent ioends if they have the same set of work to do.
> >   */
> >  static bool
> >  iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
> >  {
> > +	size_t size = iomap_ioend_size_aligned(ioend);
> > +
> >  	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
> >  		return false;
> >  	if (next->io_flags & IOMAP_F_BOUNDARY)
> ...
> > @@ -1784,12 +1810,17 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> >  		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
> >  	}
> >  
> > -	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
> > +	ioend = wpc->ioend;
> > +	if (!bio_add_folio(&ioend->io_bio, folio, len, poff))
> >  		goto new_ioend;
> >  
> >  	if (ifs)
> >  		atomic_add(len, &ifs->write_bytes_pending);
> > -	wpc->ioend->io_size += len;
> > +
> 
> And here..
> 
> "If the ioend spans i_size, trim io_size to the former to provide the fs
> with more accurate size information. This is useful for completion time
> on-disk size updates."
> 

it's fine to me.

> > +	ioend->io_size = iomap_ioend_size_aligned(ioend) + len;
> > +	if (ioend->io_offset + ioend->io_size > isize)
> > +		ioend->io_size = isize - ioend->io_offset;
> > +
> >  	wbc_account_cgroup_owner(wbc, folio, len);
> >  	return 0;
> >  }
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 5675af6b740c..956a0f7c2a8d 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -335,7 +335,7 @@ struct iomap_ioend {
> >  	u16			io_type;
> >  	u16			io_flags;	/* IOMAP_F_* */
> >  	struct inode		*io_inode;	/* file being written to */
> > -	size_t			io_size;	/* size of the extent */
> > +	size_t			io_size;	/* size of valid data */
> 
> "valid data" is kind of unclear to me. Maybe just "size of data within
> eof..?"

It's fine to me.
> 
> But those are just suggestions. Feel free to take, leave or reword any
> of it, and this LGTM regardless:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>
 
Thanks for your review, I'll update it as suggested in next version.

Long Li

