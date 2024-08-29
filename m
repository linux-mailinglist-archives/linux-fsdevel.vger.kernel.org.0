Return-Path: <linux-fsdevel+bounces-27755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820159638FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E051C21B2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAEC148838;
	Thu, 29 Aug 2024 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YAQTGnHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72013B592
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903464; cv=none; b=UvZ3ZUBVwluUa0mBebJgQj2ozeTXnIHk2KygGH5LmCADBWruY2wpYseYDMHovc5b3CgKRglAkNatizKCzdsKQwTKlZdy/UJ7ai2STWJrbIS1qzC5pPDLZLu1dOf8T8f/UwaIeGe8fpL/Ll6vp83bkjSLl03friTQ2w/91j8ewMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903464; c=relaxed/simple;
	bh=6GTU7/J2AZqFOhSRPHbUrRXarqdGAbqRQWcZ6gLF/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGgNwrkUaLm/ZaE6nRqBk4AKTcJpL4RZEOwyseDLu0QrbOAqN3bZ14cMSMw/mpu1GHjsTIVIColLYW9ZPtYuRPdSr53bp3wAnGi9ZlaF7Hh0TPWC3GE8WB1VIt8vF3buxQABfDUn4natm0QhsY9azR2aN5U1E8RxrISVW0QvYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YAQTGnHM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20231aa8908so1468095ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 20:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724903462; x=1725508262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AeVVHvGnhFOklUecAbRSQEhOO6vST90twlamIGM6O4=;
        b=YAQTGnHME7Fx0wcWmvJIjE0wPUBubuTHIG4N7+gmKLlX9XvGHf9XI9KxhHBYufjyN1
         XZ5wSaDe86f1SxGPUoZCS1dsm8LbKf15TitN2aK3UmfdWdnCp54vYEgLTmnrJ9FVxC7s
         o2MGAg33J7ffGU39BhtJcobjbOw/oo/WP69MyKZr7Keuv+d+kFsny/HbclJHV3M4u11Z
         HtbV4GmU4+FYECdqD0rpkD4ZcgCfgBFXOvGupCq3pAG65atSBJzUlGkNLRAlKigXqYeD
         xI3MEdMLJamxojIVjCyit2z6B9xiWnRPU6aj8eGzfMCGDSAKtZsdxix+PpGnDYdjYToh
         gTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724903462; x=1725508262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AeVVHvGnhFOklUecAbRSQEhOO6vST90twlamIGM6O4=;
        b=Lq3PKzd+x4Q4X5lBcENlx/3euTiQTznpQ+OR328x7J1mmU15JNVUk4E7SBUM93fMrl
         F4jPHz2WPPWvtFZFqp6FRFj7SSEkhuRkkcvegaGE1c/PURAVejXucPejpZlqC6/5Zmuo
         yRlTmSNNTf0pYpRT8Ld0XWRjB0yOyQWs1x8NSq48LxwyZ+4bc3d4BAClCrlm9LzoillV
         M1dxkudkO2qpVjpsHxuHfCyGGngVen+QMIGEJ7rewsRUus12zMr6jc3LD3CF0pDErImA
         n2FOfc7oI3RHFUGzSa7NWQztNSJzyQbz8BA5IYfAGMgq/4THjIyoMwtW3RNbBat0XtpN
         lHIA==
X-Gm-Message-State: AOJu0YwlxQV4TRcaQFojFIkladolPxTC0CrFRDBafzduHkrirlo8RBKb
	ZgM1ZZPgUUJO6enk1JJsidR3lKhNC9cIs1Tcc289gb+sZ327PYQf9bqUysppzSY=
X-Google-Smtp-Source: AGHT+IHAHvk8bDxVvbJFMDeCOvhUYp8MP/kjdQMzQc9G/igD+W/2AL+g6BU55soWe1aUaxn1q5Cxlw==
X-Received: by 2002:a17:902:e84a:b0:202:3e32:5d3e with SMTP id d9443c01a7336-2050c3faf20mr16831995ad.36.1724903462038;
        Wed, 28 Aug 2024 20:51:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515569536sm2193025ad.304.2024.08.28.20.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:51:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjWBX-00GUNf-12;
	Thu, 29 Aug 2024 13:50:59 +1000
Date: Thu, 29 Aug 2024 13:50:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com, willy@infradead.org
Subject: Re: [PATCH v2 06/11] fuse: use iomap for writeback cache buffered
 writes
Message-ID: <Zs/wI17fs4qHoFOF@dread.disaster.area>
References: <cover.1724879414.git.josef@toxicpanda.com>
 <dc1e8cd7300e1b76ae2fe77755acaf216571153b.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1e8cd7300e1b76ae2fe77755acaf216571153b.1724879414.git.josef@toxicpanda.com>

On Wed, Aug 28, 2024 at 05:13:56PM -0400, Josef Bacik wrote:
> We're currently using the old ->write_begin()/->write_end() method of
> doing buffered writes.  This isn't a huge deal for fuse since we
> basically just want to copy the pages and move on, but the iomap
> infrastructure gives us access to having huge folios.  Rework the
> buffered write path when we have writeback cache to use the iomap
> buffered write code, the ->get_folio() callback now handles the work
> that we did in ->write_begin(), the rest of the work is handled inside
> of iomap so we don't need a replacement for ->write_end.
> 
> This does bring BLOCK as a dependency, as the buffered write part of
> iomap requires CONFIG_BLOCK.  This could be shed if we reworked the file
> write iter portion of the buffered write path was separated out to not
> need BLOCK.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/Kconfig |   2 +
>  fs/fuse/file.c  | 154 +++++++++++++++++++++---------------------------
>  2 files changed, 68 insertions(+), 88 deletions(-)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 8674dbfbe59d..8a799324d7bd 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config FUSE_FS
>  	tristate "FUSE (Filesystem in Userspace) support"
> +	depends on BLOCK
>  	select FS_POSIX_ACL
> +	select FS_IOMAP
>  	help
>  	  With FUSE it is possible to implement a fully functional filesystem
>  	  in a userspace program.
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index ab531a4694b3..af91043b44d7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/filelock.h>
>  #include <linux/splice.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include <linux/iomap.h>
>  
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
> @@ -1420,6 +1421,63 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
>  	}
>  }
>  
> +static struct folio *fuse_iomap_get_folio(struct iomap_iter *iter,
> +					  loff_t pos, unsigned len)
> +{
> +	struct file *file = (struct file *)iter->private;
> +	struct inode *inode = iter->inode;
> +	struct folio *folio;
> +	loff_t fsize;
> +
> +	folio = iomap_get_folio(iter, pos, len);
> +	if (IS_ERR(folio))
> +		return folio;
> +
> +	fuse_wait_on_folio_writeback(inode, folio);
> +
> +	if (folio_test_uptodate(folio))
> +		return folio;
> +
> +	/*
> +	 * If we're going to write past EOF then avoid the read, but zero the
> +	 * whole thing and mark it uptodate so that if we get a short write we
> +	 * don't try to re-read this page, we just carry on.
> +	 */
> +	fsize = i_size_read(inode);
> +	if (fsize <= folio_pos(folio)) {
> +		folio_zero_range(folio, 0, folio_size(folio));

The comment doesn't match what this does - the folio is not marked
uptodate at all.

> +	} else {
> +		int err = fuse_do_readpage(file, &folio->page);

readpage on a large folio? does that work?

> +		if (err) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			return ERR_PTR(err);
> +		}
> +	}

Also, why do this here when __iomap_write_begin() will do all the
sub-folio zeroing and read IO on the folio?

> +
> +	return folio;
> +}
> +
> +static const struct iomap_folio_ops fuse_iomap_folio_ops = {
> +	.get_folio = fuse_iomap_get_folio,
> +};
> +
> +static int fuse_iomap_begin_write(struct inode *inode, loff_t pos, loff_t length,
> +				  unsigned flags, struct iomap *iomap,
> +				  struct iomap *srcmap)
> +{
> +	iomap->type = IOMAP_DELALLOC;
> +	iomap->addr = IOMAP_NULL_ADDR;
> +	iomap->offset = pos;
> +	iomap->length = length;
> +	iomap->folio_ops = &fuse_iomap_folio_ops;
> +	return 0;
> +}

What's the reason for using IOMAP_DELALLOC for these mappings? I'm
not saying it is wrong, I just don't know enough about fuse to
understand is this is valid or not because there are no iomap-based
writeback hooks being added here....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

