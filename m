Return-Path: <linux-fsdevel+bounces-27859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4841D964832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95F6282B02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF91B14F9;
	Thu, 29 Aug 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qOF3cyOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3351B011C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941441; cv=none; b=lhAqPbyecRVX3OWPiLl/3G0YItcqooWbmpKg0R5nOwAUfF+gWfJBZjgW7EsZdAFkbVaS1eWE09RvTU3TK8qID2wVTiswz+OjZsQIoIFln3t2WXmnRqe8AC3UD3rlCPqdSOMwhOdOaBBYJKnJLikeaTwZvthuRLwNGVs2OgxYOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941441; c=relaxed/simple;
	bh=pF+jckgfWxXjBF58d4ruGjDrRaSQOzkK820+kNTHd0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYhvygj9jyh0mfubiNq5QqoaCW72mlxGkGy9KtmiymjIWDWkXdboUYghFS1Mt8HtT13B53pbNeck5Qb+ihHsR7AcALMKyRkieKAAmmBixTbKR4mDxvlgi97bvDBvSMoCXVqexfAtf4KaXXUkxVWeKulhX8k2TM2coBQrecqchbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qOF3cyOD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf705959f1so6654116d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724941438; x=1725546238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxLNqFqcBieEGqB+ANG8Whw6ucOXPrch4XINB9sUGKc=;
        b=qOF3cyOD0i0xZrPK8aLB6/Ac4olj/80csKvF6sltLZzgs5KawknHC8LxQbb6cAQ2eN
         mwY0fAfwjlPnFPesHE7bunkN7YxmuECFdsT5tkhUma2WGIFE7xBc4wSry1ajNtuPz5A/
         Fk66YV2qFEghABy/pom/pMVWnT0fSvx+CB+YyGYh2SMC+aD6zwKvldc4wgn6zjSTUHLg
         28fOqvy6TB9L5U5cybMRFZbQUyW/h5k8MXBNIg4kZuiGrp7bS8Nj12hw0fq+jjnp6Oth
         N8cBsF47Jzc/EpD32gJultB/7bOFAz0q0dlsPLF3NNacPkGyyxvCr/WQ4FXReHcXC+Dn
         +IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941438; x=1725546238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxLNqFqcBieEGqB+ANG8Whw6ucOXPrch4XINB9sUGKc=;
        b=grT6ca2IWgu6Rw6tyesYn2v/ZpHsQRBpDOay9yXFsrcO/HboqIb1mfc19eZzcE/uiC
         oZ6OMQYmNo9W9+mvmJb1rccpgF2H5hP1gVloSf3tt/2yfI2TkeIcGsedX5fKqqsZug44
         AG0auqLq95FKJ9Edt+4Wn4KMzXNuj3gBHTG04GKhf877ZbJaseD0xpEN38L2vTAcKwPG
         rT9gmOum0Ur6y0RLY3WoDELwBlS8BpUQmo4CqytPplOHUcsJzeBj4O+Wighj/WanwkLB
         pMyuvPsjxXasWAkZszuUSDkHcibYBXIH+dGVPdCqkKIC1AEKo0B5eHGEqnD4x1sj0NVw
         9F+w==
X-Gm-Message-State: AOJu0YzewoaIkOUgO40AGvvkp2/0Gy1KkbnV58l8l5QxCrwViBpAiFr9
	Xa2ovaJBFtfkFQhR8zQnx/JQJA1jk7sY09d8YbL8UVDFSmxERzGiPSugl6MvwE4=
X-Google-Smtp-Source: AGHT+IFneAKEY1qnAxkMEPgn0jsbaInFC3LMq/jU76tMk/poSBAffhsmVsOLwAJVKNqD5Kw0ouej0g==
X-Received: by 2002:a05:6214:411c:b0:6c3:2e4e:2a49 with SMTP id 6a1803df08f44-6c33f33cb57mr35110746d6.10.1724941438130;
        Thu, 29 Aug 2024 07:23:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bff5ccsm5544506d6.38.2024.08.29.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:23:57 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:23:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com, willy@infradead.org
Subject: Re: [PATCH v2 06/11] fuse: use iomap for writeback cache buffered
 writes
Message-ID: <20240829142356.GA3067112@perftesting>
References: <cover.1724879414.git.josef@toxicpanda.com>
 <dc1e8cd7300e1b76ae2fe77755acaf216571153b.1724879414.git.josef@toxicpanda.com>
 <Zs/wI17fs4qHoFOF@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs/wI17fs4qHoFOF@dread.disaster.area>

On Thu, Aug 29, 2024 at 01:50:59PM +1000, Dave Chinner wrote:
> On Wed, Aug 28, 2024 at 05:13:56PM -0400, Josef Bacik wrote:
> > We're currently using the old ->write_begin()/->write_end() method of
> > doing buffered writes.  This isn't a huge deal for fuse since we
> > basically just want to copy the pages and move on, but the iomap
> > infrastructure gives us access to having huge folios.  Rework the
> > buffered write path when we have writeback cache to use the iomap
> > buffered write code, the ->get_folio() callback now handles the work
> > that we did in ->write_begin(), the rest of the work is handled inside
> > of iomap so we don't need a replacement for ->write_end.
> > 
> > This does bring BLOCK as a dependency, as the buffered write part of
> > iomap requires CONFIG_BLOCK.  This could be shed if we reworked the file
> > write iter portion of the buffered write path was separated out to not
> > need BLOCK.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/fuse/Kconfig |   2 +
> >  fs/fuse/file.c  | 154 +++++++++++++++++++++---------------------------
> >  2 files changed, 68 insertions(+), 88 deletions(-)
> > 
> > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > index 8674dbfbe59d..8a799324d7bd 100644
> > --- a/fs/fuse/Kconfig
> > +++ b/fs/fuse/Kconfig
> > @@ -1,7 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config FUSE_FS
> >  	tristate "FUSE (Filesystem in Userspace) support"
> > +	depends on BLOCK
> >  	select FS_POSIX_ACL
> > +	select FS_IOMAP
> >  	help
> >  	  With FUSE it is possible to implement a fully functional filesystem
> >  	  in a userspace program.
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index ab531a4694b3..af91043b44d7 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/filelock.h>
> >  #include <linux/splice.h>
> >  #include <linux/task_io_accounting_ops.h>
> > +#include <linux/iomap.h>
> >  
> >  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
> >  			  unsigned int open_flags, int opcode,
> > @@ -1420,6 +1421,63 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
> >  	}
> >  }
> >  
> > +static struct folio *fuse_iomap_get_folio(struct iomap_iter *iter,
> > +					  loff_t pos, unsigned len)
> > +{
> > +	struct file *file = (struct file *)iter->private;
> > +	struct inode *inode = iter->inode;
> > +	struct folio *folio;
> > +	loff_t fsize;
> > +
> > +	folio = iomap_get_folio(iter, pos, len);
> > +	if (IS_ERR(folio))
> > +		return folio;
> > +
> > +	fuse_wait_on_folio_writeback(inode, folio);
> > +
> > +	if (folio_test_uptodate(folio))
> > +		return folio;
> > +
> > +	/*
> > +	 * If we're going to write past EOF then avoid the read, but zero the
> > +	 * whole thing and mark it uptodate so that if we get a short write we
> > +	 * don't try to re-read this page, we just carry on.
> > +	 */
> > +	fsize = i_size_read(inode);
> > +	if (fsize <= folio_pos(folio)) {
> > +		folio_zero_range(folio, 0, folio_size(folio));
> 
> The comment doesn't match what this does - the folio is not marked
> uptodate at all.

I'll update the comment, it gets marked uptodate in __iomap_write_end() once the
write is complete.

> 
> > +	} else {
> > +		int err = fuse_do_readpage(file, &folio->page);
> 
> readpage on a large folio? does that work?

I haven't done the work to enable large folios yet, this is just the prep stuff.
Supporting large folios is going to take a fair bit of work, so I'm getting the
ball rolling with this prep series.

> 
> > +		if (err) {
> > +			folio_unlock(folio);
> > +			folio_put(folio);
> > +			return ERR_PTR(err);
> > +		}
> > +	}
> 
> Also, why do this here when __iomap_write_begin() will do all the
> sub-folio zeroing and read IO on the folio?
> 

I looked long and hard at iomap because I thought it would, but it turns out it
won't work for fuse.  I could be totally wrong, but looking at iomap it will
allocate an ifs because it assumes this is sub-folio blocksize, but we aren't,
and don't really want to incur that pain.  Additionally it does
iomap_read_folio_sync() to read in the folio, which just does a bio, which
obviously doesn't work on fuse.  Again totally expecting to be told I'm stupid
in some way that I missed, but it seemed like iomap won't do what we need it to
do here, and it's simple enough to handle the zeroing here for ourselves.

> > +
> > +	return folio;
> > +}
> > +
> > +static const struct iomap_folio_ops fuse_iomap_folio_ops = {
> > +	.get_folio = fuse_iomap_get_folio,
> > +};
> > +
> > +static int fuse_iomap_begin_write(struct inode *inode, loff_t pos, loff_t length,
> > +				  unsigned flags, struct iomap *iomap,
> > +				  struct iomap *srcmap)
> > +{
> > +	iomap->type = IOMAP_DELALLOC;
> > +	iomap->addr = IOMAP_NULL_ADDR;
> > +	iomap->offset = pos;
> > +	iomap->length = length;
> > +	iomap->folio_ops = &fuse_iomap_folio_ops;
> > +	return 0;
> > +}
> 
> What's the reason for using IOMAP_DELALLOC for these mappings? I'm
> not saying it is wrong, I just don't know enough about fuse to
> understand is this is valid or not because there are no iomap-based
> writeback hooks being added here....

At the time it was "oh we're doing what equates to delalloc, clearly this should
be marked as delalloc".  Now that I have been in this code longer I realize this
is supposed to be "what does this range look like now", so I suppose the "right"
thing to do here is use IOMAP_HOLE?  Thanks,

Josef

