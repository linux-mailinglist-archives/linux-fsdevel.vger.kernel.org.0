Return-Path: <linux-fsdevel+bounces-59414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5FB388E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DD91B66D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48F2877DB;
	Wed, 27 Aug 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJtdwC1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF61E230E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316933; cv=none; b=bkFxw/ovXkk1M/gXNyu0II2diqMd11+gF781Jpwi3NBZKiUw6Jcvs52hs/BZFmmHcomuKo6cMODPm8HPTcemZQ7har+x7pBQ3j8zvrMz9lMiHsg/gP915m5CvmoOG8+S3wJ4xw5K76nxGJ6Ehrmkc0Mba1nFwM0hMslOjWn0Yws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316933; c=relaxed/simple;
	bh=jUFz9jruHYXkyKMr2r0i+WWI9/MTQ7vAdaDz5a2Ztwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU7sQL0oLi7PMTMlEvbEhhRn9Zw3nuY4JyKH4WTqg18HDXBSJ4MUplTo4BmYAY06p7pDR2A5tAqkofwq13U1IppG59KPDanHMy/iA3IMRwye00cMYnKz8sFeFS5AwQVhQGGf+DHU32uJHcREjuysiYvb2GwyGEOFNf5FulOAzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJtdwC1y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756316930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CY1ybBNELINlBW46BpY0I29Oa4pllqZv5dG3GvoWIX0=;
	b=PJtdwC1yekYVv68DMF+MbQWFVzOLLrBkw9VjchoKc39md37cfkpeBKMVqNZiapCBVux+1q
	ibATEkYuVJltcojYjQDEcPMpmT+ispixcwAiJlA7N22uMXDn14aKJkRd2LnjquKk5IzFw4
	j+JIm9o80CrPYO3XPfqA4AsAEeKBcZY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-jQMARTUAN46urj9FdaLopg-1; Wed,
 27 Aug 2025 13:48:48 -0400
X-MC-Unique: jQMARTUAN46urj9FdaLopg-1
X-Mimecast-MFC-AGG-ID: jQMARTUAN46urj9FdaLopg_1756316925
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 634BD19560B5;
	Wed, 27 Aug 2025 17:48:44 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A795C30001A6;
	Wed, 27 Aug 2025 17:48:40 +0000 (UTC)
Date: Wed, 27 Aug 2025 13:52:37 -0400
From: Brian Foster <bfoster@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <aK9F5euA3kQdGaMi@bfoster>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
 <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Aug 27, 2025 at 05:20:53PM +0200, Jan Kara wrote:
> On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
> > Keith Busch <kbusch@kernel.org> writes:
> > 
> > > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
> > >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> > >> > Keith Busch <kbusch@meta.com> writes:
> > >> > >
> > >> > >   - EXT4 falls back to buffered io for writes but not for reads.
> > >> > 
> > >> > ++linux-ext4 to get any historical context behind why the difference of
> > >> > behaviour in reads v/s writes for EXT4 DIO. 
> > >> 
> > >> Hum, how did you test? Because in the basic testing I did (with vanilla
> > >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
> > >> falling back to buffered IO only if the underlying file itself does not
> > >> support any kind of direct IO.
> > >
> > > Simple test case (dio-offset-test.c) below.
> > >
> > > I also ran this on vanilla kernel and got these results:
> > >
> > >   # mkfs.ext4 /dev/vda
> > >   # mount /dev/vda /mnt/ext4/
> > >   # make dio-offset-test
> > >   # ./dio-offset-test /mnt/ext4/foobar
> > >   write: Success
> > >   read: Invalid argument
> > >
> > > I tracked the "write: Success" down to ext4's handling for the "special"
> > > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
> > >
> > 
> > Right. Ext4 has fallback only for dio writes but not for DIO reads... 
> > 
> > buffered
> > static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> > {
> > 	/* must be a directio to fall back to buffered */
> > 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> > 		    (IOMAP_WRITE | IOMAP_DIRECT))
> > 		return false;
> > 
> >     ...
> > }
> > 
> > So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
> >     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
> > 
> > 
> > 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > 		return -EINVAL;
> > 
> > EXT4 then fallsback to buffered-io only for writes, but not for reads. 
> 
> Right. And the fallback for writes was actually inadvertedly "added" by
> commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
> changed the error handling logic. Previously if iomap_dio_bio_iter()
> returned EINVAL, it got propagated to userspace regardless of what
> ->iomap_end() returned. After this commit if ->iomap_end() returns error
> (which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
> the error returned by iomap_dio_bio_iter().
> 

Ah, so IIUC you're referring to the change in iomap_iter() where the
iomap_end() error code was returned "if (ret < 0 && !iter->processed)",
where iter->processed held a potential error code from the iterator.
That was changed to !advanced, which filters out the processed < 0 case
and allows the error to return from iomap_end here rather than from
iter->processed a few lines down.

There were further changes to eliminate the advance from iomap_iter()
case (and rename processed -> status), so I suppose we could consider
changing that to something like:

	if (ret < 0 && !advanced && !iter->status)
		return ret;

... which I think would restore original error behavior. But I agree
it's not totally clear which is preferable. Certainly the change in
behavior was not intentional so thanks for the analysis. I'd have to
stare at the code and think (and test) some more to form an opinion on
whether it's worth changing. Meanwhile it looks like you have a
reasonable enough workaround..

Brian

> Now both the old and new behavior make some sense so I won't argue that the
> new iomap_iter() behavior is wrong. But I think we should change ext4 back
> to the old behavior of failing unaligned dio writes instead of them falling
> back to buffered IO. I think something like the attached patch should do
> the trick - it makes unaligned dio writes fail again while writes to holes
> of indirect-block mapped files still correctly fall back to buffered IO.
> Once fstests run completes, I'll do a proper submission...
> 
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 27 Aug 2025 14:55:19 +0200
> Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
> 
> Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> changed the error handling logic in iomap_iter(). Previously any error
> from iomap_dio_bio_iter() got propagated to userspace, after this commit
> if ->iomap_end returns error, it gets propagated to userspace instead of
> an error from iomap_dio_bio_iter(). This results in unaligned writes to
> ext4 to silently fallback to buffered IO instead of erroring out.
> 
> Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
> unnecessary these days. It is enough to return ENOTBLK from
> ext4_iomap_begin() when we don't support DIO write for that particular
> file offset (due to hole).
> 
> Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c  |  2 --
>  fs/ext4/inode.c | 35 -----------------------------------
>  2 files changed, 37 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 93240e35ee36..cf39f57d21e9 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -579,8 +579,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> -		ret = 0;
>  	if (extend) {
>  		/*
>  		 * We always perform extending DIO write synchronously so by
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..c3b23c90fd11 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> -static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> -{
> -	/* must be a directio to fall back to buffered */
> -	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> -		    (IOMAP_WRITE | IOMAP_DIRECT))
> -		return false;
> -
> -	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC)
> -		return false;
> -
> -	/* can only try again if we wrote nothing */
> -	return written == 0;
> -}
> -
> -static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> -			  ssize_t written, unsigned flags, struct iomap *iomap)
> -{
> -	/*
> -	 * Check to see whether an error occurred while writing out the data to
> -	 * the allocated blocks. If so, return the magic error code for
> -	 * non-atomic write so that we fallback to buffered I/O and attempt to
> -	 * complete the remainder of the I/O.
> -	 * For non-atomic writes, any blocks that may have been
> -	 * allocated in preparation for the direct I/O will be reused during
> -	 * buffered I/O. For atomic write, we never fallback to buffered-io.
> -	 */
> -	if (ext4_want_directio_fallback(flags, written))
> -		return -ENOTBLK;
> -
> -	return 0;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  const struct iomap_ops ext4_iomap_overwrite_ops = {
>  	.iomap_begin		= ext4_iomap_overwrite_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> -- 
> 2.43.0
> 


