Return-Path: <linux-fsdevel+bounces-65798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EBDC11958
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252DB4E4929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE82FFDDD;
	Mon, 27 Oct 2025 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+2Hs3Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407132EB84E;
	Mon, 27 Oct 2025 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602211; cv=none; b=l7IQnSITtNsGoP5BCL3Z1r7TNQGtXJDBGTwNrkWQSFFjKfFG14a51TZG1DeUZjfVyQ/nWUdNwlwvV2OyLC5F8lvHal0jB7vwdNJfE82A8stgczansh7Cc/KBfxnBXDt7ik/yhcjU51ydGLosL7GNb19flA2zQTe2CfxHT5Kjnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602211; c=relaxed/simple;
	bh=405cnyAwlgl8G6n9UhDVXviAWRHuhcD6pnbJ2+1/ELo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcz2y6BMdXxOjp8YRI8xvtmPvvnlwhyAwMQT06DovH+BtUc/UgvF8MC/yKvgEr8bHELxBlhHeKuxyEvUb0lWprdIuVh7RuxtRjauQ0qgP58gjCIjPqImx3YLKjGxfFPc76B3/j540WuNMZlF5UYqjnFHEWRA0/Lolo/+moaerBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+2Hs3Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A474AC4CEF1;
	Mon, 27 Oct 2025 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761602210;
	bh=405cnyAwlgl8G6n9UhDVXviAWRHuhcD6pnbJ2+1/ELo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+2Hs3IypUls8lSAjdGvQhr+l4x/IwslEpeWGbGpmjryf+rXJCB6leDz+nuXscEEQ
	 5EEax/w4kjmRAOb2LjwX+qXZU6awcTnUqql7NwUGg4jvfaNhgYB2TtZZ9u3UXr5gdD
	 w0Wj/GOCzQgdU82zKvFqXF7wWh5eDVyMb1qs8VMG9CcULK/1ncirpqX4OhDZW0GYF7
	 TKGKwdBizDiRp6vdTCmTSWAQ+Ybv9keILSkKPfWzkVT5IYBTIyzMAhzePDO39Bigwg
	 m67e7v93N0X+6QJAUBhBdBtvzuDcLp425i/OlMmWqH5iP+uU5J9Vwqb4zAkH7IHmWe
	 FhhsQeDoIuQig==
Date: Mon, 27 Oct 2025 14:56:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251027215650.GO4015566@frogsfrogsfrogs>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-2-hch@lst.de>
 <20251027161027.GS3356773@frogsfrogsfrogs>
 <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>

On Tue, Oct 28, 2025 at 08:11:21AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/10/28 02:40, Darrick J. Wong 写道:
> > On Thu, Oct 23, 2025 at 03:55:42PM +0200, Christoph Hellwig wrote:
> > > From: Qu Wenruo <wqu@suse.com>
> > > 
> > > Btrfs requires all of its bios to be fs block aligned, normally it's
> > > totally fine but with the incoming block size larger than page size
> > > (bs > ps) support, the requirement is no longer met for direct IOs.
> > > 
> > > Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> > > requiring alignment to be bdev_logical_block_size().
> > > 
> > > In the real world that value is either 512 or 4K, on 4K page sized
> > > systems it means bio_iov_iter_get_pages() can break the bio at any page
> > > boundary, breaking btrfs' requirement for bs > ps cases.
> > > 
> > > To address this problem, introduce a new public iomap dio flag,
> > > IOMAP_DIO_FSBLOCK_ALIGNED.
> > > 
> > > When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
> > > inherit that new flag, and iomap_dio_bio_iter() will take fs block size
> > > into the calculation of the alignment, and pass the alignment to
> > > bio_iov_iter_get_pages(), respecting the fs block size requirement.
> > > 
> > > The initial user of this flag will be btrfs, which needs to calculate the
> > > checksum for direct read and thus requires the biovec to be fs block
> > > aligned for the incoming bs > ps support.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >   fs/iomap/direct-io.c  | 13 ++++++++++++-
> > >   include/linux/iomap.h |  8 ++++++++
> > >   2 files changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 5d5d63efbd57..ce9cbd2bace0 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -336,10 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> > >   	int nr_pages, ret = 0;
> > >   	u64 copied = 0;
> > >   	size_t orig_count;
> > > +	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
> > >   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
> > >   		return -EINVAL;
> > > +	/*
> > > +	 * Align to the larger one of bdev and fs block size, to meet the
> > > +	 * alignment requirement of both layers.
> > > +	 */
> > > +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> > > +		alignment = max(alignment, fs_block_size);
> > > +
> > >   	if (dio->flags & IOMAP_DIO_WRITE) {
> > >   		bio_opf |= REQ_OP_WRITE;
> > > @@ -434,7 +442,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> > >   		bio->bi_end_io = iomap_dio_bio_end_io;
> > >   		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
> > > -				bdev_logical_block_size(iomap->bdev) - 1);
> > > +					     alignment - 1);
> > >   		if (unlikely(ret)) {
> > >   			/*
> > >   			 * We have to stop part way through an IO. We must fall
> > > @@ -639,6 +647,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   	if (iocb->ki_flags & IOCB_NOWAIT)
> > >   		iomi.flags |= IOMAP_NOWAIT;
> > > +	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> > > +		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
> > > +
> > >   	if (iov_iter_rw(iter) == READ) {
> > >   		/* reads can always complete inline */
> > >   		dio->flags |= IOMAP_DIO_INLINE_COMP;
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 73dceabc21c8..4da13fe24ce8 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -518,6 +518,14 @@ struct iomap_dio_ops {
> > >    */
> > >   #define IOMAP_DIO_PARTIAL		(1 << 2)
> > > +/*
> > > + * Ensure each bio is aligned to fs block size.
> > > + *
> > > + * For filesystems which need to calculate/verify the checksum of each fs
> > > + * block. Otherwise they may not be able to handle unaligned bios.
> > > + */
> > > +#define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
> > 
> > A new flag requires an update to IOMAP_F_FLAGS_STRINGS in trace.h for
> > tracepoint decoding.
> 
> I'm wondering who should fix this part.
> 
> The original author (myself) or Christoph?

Or the maintainer?

Here's the relevant patch for whomever actually commits it.
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

diff --git i/fs/iomap/trace.h w/fs/iomap/trace.h
index a61c1dae474270..eae9c1e5c674c8 100644
--- i/fs/iomap/trace.h
+++ w/fs/iomap/trace.h
@@ -121,13 +121,14 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
        { IOMAP_F_STALE,        "STALE" }
 
 
 #define IOMAP_DIO_STRINGS \
        {IOMAP_DIO_FORCE_WAIT,  "DIO_FORCE_WAIT" }, \
        {IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
-       {IOMAP_DIO_PARTIAL,     "DIO_PARTIAL" }
+       {IOMAP_DIO_PARTIAL,     "DIO_PARTIAL" }, \
+       {IOMAP_DIO_FSBLOCK_ALIGNED,     "DIO_FSBLOCK" }
 
 DECLARE_EVENT_CLASS(iomap_class,
        TP_PROTO(struct inode *inode, struct iomap *iomap),
        TP_ARGS(inode, iomap),
        TP_STRUCT__entry(
                __field(dev_t, dev)

> Thanks,
> Qu
> 
> > 
> > The rest of the changes look ok to me, modulo hch's subsequent fixups.
> > 
> > --D
> > 
> > >   ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> > >   		unsigned int dio_flags, void *private, size_t done_before);
> > > -- 
> > > 2.47.3
> > > 
> > > 
> 

