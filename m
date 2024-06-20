Return-Path: <linux-fsdevel+bounces-21971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC59106D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC728249A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AF1AD4A8;
	Thu, 20 Jun 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lo2SxhaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF748CCD;
	Thu, 20 Jun 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891656; cv=none; b=C97SFtVnQ1uXWdyk6pxUtxz71H1TVQqOwmOyFaUS15O3FxYyIcdOWWthgpmX5k/BqAgWnOsUoXu9bSZMe2KNMMZFg/5p5u8Hr0HmxoReo6kqzGrsDTycoWFcGcuyZYqrkDBx8XVuy+u39BNkTTnEnmr94mILMtqAoF7DbsjTVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891656; c=relaxed/simple;
	bh=NOQGTWXdj9G8iFM3066oMr6y2PwQOndNQ8YChh2uMDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ1iYlguL3n3H6VlUAnVuxvxI+GQCmI6c0whBrtj7or9R9DuUOlHTWpu8f7pYqrz6h0/xcklv7nkL6J1vAkhvCvTOjEo8WYdNmjGwEsDe8qYlCAdVH+OWbP5BtIKRoDKBzFwVeizmSgqD/2g+Tp0Nehstl8Zzvw7DJYS+5JYYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lo2SxhaN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nwO0+HfO+dip8/h67A8BnvwxWh0on9U35/Dl4WuOIfU=; b=Lo2SxhaN0/KQyxYCFidkI/xAp9
	DFEjgCJIfDlorCZKzKfJG65hYbIY7OmkW3yhLnLJxMsB43CR2rBoqqln1K8R1S+i7nWmZkIBPxOrp
	T/P7Q0KdNaD50g62HkP06PrX+ugCfcPOZaRfCJZ0C8u/waDheUEBMzrJEeWWSehNC1sxEhE94Xnjn
	gI2Pzczh99bExFatTf25waUVQmyZAlWFH7+9VHw08wI+F96ypOmZFfp5UzTHrwA7K2ydkH8ne0j4p
	yru1fLYtX0fKMpf1fOMOsn/DOIyBxQtr6y+VixWy2Ui0q9b1FNO/ZZKrFUujzwSdwZ5WaBGmDt3XM
	JkHrFh5A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKIEr-000000067er-2uG5;
	Thu, 20 Jun 2024 13:54:09 +0000
Date: Thu, 20 Jun 2024 14:54:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <ZnQ0gdpcplp_-aw7@casper.infradead.org>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>

On Thu, Jun 20, 2024 at 09:36:42AM -0400, Kent Overstreet wrote:
> On Thu, Jun 20, 2024 at 09:21:57PM +0800, Hongbo Li wrote:
> > Support fallback to buffered I/O if the operation being performed on
> > unaligned length or offset. This may change the behavior for direct
> > I/O in some cases.
> > 
> > [Before]
> > For length which aligned with 256 bytes (not SECTOR aligned) will
> > read failed under direct I/O.
> > 
> > [After]
> > For length which aligned with 256 bytes (not SECTOR aligned) will
> > read the data successfully under direct I/O because it will fallback
> > to buffer I/O.

This is against the O_DIRECT requirements.

   O_DIRECT
       The O_DIRECT flag may impose alignment restrictions on  the  length  and
       address  of  user-space  buffers  and the file offset of I/Os.  In Linux
       alignment restrictions vary by filesystem and kernel version  and  might
       be  absent  entirely.   The  handling  of  misaligned O_DIRECT I/Os also
       varies; they can either fail with EINVAL or fall back to buffered I/O.

       Since Linux 6.1, O_DIRECT support and alignment restrictions for a  file
       can  be  queried using statx(2), using the STATX_DIOALIGN flag.  Support
       for STATX_DIOALIGN varies by filesystem; see statx(2).

       Some filesystems provide their  own  interfaces  for  querying  O_DIRECT
       alignment restrictions, for example the XFS_IOC_DIOINFO operation in xf‐
       sctl(3).  STATX_DIOALIGN should be used instead when it is available.

       If none of the above is available, then direct I/O support and alignment
       restrictions  can  only  be  assumed  from  known characteristics of the
       filesystem, the individual file, the underlying storage  device(s),  and
       the  kernel  version.  In Linux 2.4, most filesystems based on block de‐
       vices require that the file offset and the length and memory address  of
       all  I/O  segments  be multiples of the filesystem block size (typically
       4096 bytes).  In Linux 2.6.0, this was relaxed to the logical block size
       of the block device (typically 512 bytes).   A  block  device's  logical
       block  size  can be determined using the ioctl(2) BLKSSZGET operation or
       from the shell using the command:

           blockdev --getss

> The catch is that struct bio - bvec_iter - represents addresses with a
> sector_t, and we'd want that to be a loff_t.
> 
> That's something we should do anyways; everything else in struct bio can
> represent a byte-aligned io, bvec_iter.bi_sector is the only exception
> and fixing that would help in consolidating our various scatter-gather
> list data structures - but we'd need buy-in from Jens and Christoph
> before doing that.

I'm against it.  Block devices only do sector-aligned IO and we should
not pretend otherwise.


