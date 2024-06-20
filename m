Return-Path: <linux-fsdevel+bounces-21977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6659107CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E512812DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0F1AD9FD;
	Thu, 20 Jun 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e47D9UbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8E17554A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892969; cv=none; b=GbUg/cP0vRhtLyPBrmdbg7HuxL9uhjQ7c2sIDcMx2OQdhsdsqzZxcGPjHqtnZIDObMxZVU3xz4voIQ5hQbEuDKZD5nDS7FoSaQyhKd9CSwx9r4DgJ+6JRXvEgjaW9wK1yZ8bkfK6sZBjxbABeS2jrb9+V8fGJD3jSpYgmKDA4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892969; c=relaxed/simple;
	bh=ie3mMowcLl9pO6pcPDQzyfj4GHt2JUEpIdYsa7TzX6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccqxJ8NMB+SXKISqrfyC58oqn0oX8Cq65g/0YzalDfJjq2j9OR/UrwzEDMOtokzM1TiQqvfblQgn1NFPMKXVwiAisf1DZikVMLAbyET0Lpk6GY+7KGtCQD+po6/JGsGs2GEk81K3NgS0KR+z7dv538wo19D4VrW7se8eneO1gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e47D9UbT; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718892965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVHAkEhh1ZNeSLA10+0gLjNffv+MQ5dqQHkb3aqOTl4=;
	b=e47D9UbT/UNkMordZconCUJnNASIlnV2vDpaKbf6o6sw3fP0GmeKB7BGU+qRLSw+uNRxsY
	0uQtNx+p3xYHOoXXVogSRY0qed5+uV08H3NpBNmOYkxpmqxJqA/hVLoekSa/Pem6//gCQQ
	16rlp++WZF1Jse+eAusUJ2f63Qjj4ao=
X-Envelope-To: lihongbo22@huawei.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: hch@lst.de
Date: Thu, 20 Jun 2024 10:16:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnQ0gdpcplp_-aw7@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 20, 2024 at 02:54:09PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 20, 2024 at 09:36:42AM -0400, Kent Overstreet wrote:
> > On Thu, Jun 20, 2024 at 09:21:57PM +0800, Hongbo Li wrote:
> > > Support fallback to buffered I/O if the operation being performed on
> > > unaligned length or offset. This may change the behavior for direct
> > > I/O in some cases.
> > > 
> > > [Before]
> > > For length which aligned with 256 bytes (not SECTOR aligned) will
> > > read failed under direct I/O.
> > > 
> > > [After]
> > > For length which aligned with 256 bytes (not SECTOR aligned) will
> > > read the data successfully under direct I/O because it will fallback
> > > to buffer I/O.
> 
> This is against the O_DIRECT requirements.
> 
>    O_DIRECT
>        The O_DIRECT flag may impose alignment restrictions on  the  length  and
>        address  of  user-space  buffers  and the file offset of I/Os.  In Linux
>        alignment restrictions vary by filesystem and kernel version  and  might
>        be  absent  entirely.   The  handling  of  misaligned O_DIRECT I/Os also
>        varies; they can either fail with EINVAL or fall back to buffered I/O.
> 
>        Since Linux 6.1, O_DIRECT support and alignment restrictions for a  file
>        can  be  queried using statx(2), using the STATX_DIOALIGN flag.  Support
>        for STATX_DIOALIGN varies by filesystem; see statx(2).
> 
>        Some filesystems provide their  own  interfaces  for  querying  O_DIRECT
>        alignment restrictions, for example the XFS_IOC_DIOINFO operation in xf‐
>        sctl(3).  STATX_DIOALIGN should be used instead when it is available.
> 
>        If none of the above is available, then direct I/O support and alignment
>        restrictions  can  only  be  assumed  from  known characteristics of the
>        filesystem, the individual file, the underlying storage  device(s),  and
>        the  kernel  version.  In Linux 2.4, most filesystems based on block de‐
>        vices require that the file offset and the length and memory address  of
>        all  I/O  segments  be multiples of the filesystem block size (typically
>        4096 bytes).  In Linux 2.6.0, this was relaxed to the logical block size
>        of the block device (typically 512 bytes).   A  block  device's  logical
>        block  size  can be determined using the ioctl(2) BLKSSZGET operation or
>        from the shell using the command:

That's really just descriptive, not prescriptive.

The intent of O_DIRECT is "bypass the page cache", the alignment
restrictions are just a side effect of that. Applications just care
about is having predictable performance characteristics.

> > The catch is that struct bio - bvec_iter - represents addresses with a
> > sector_t, and we'd want that to be a loff_t.
> > 
> > That's something we should do anyways; everything else in struct bio can
> > represent a byte-aligned io, bvec_iter.bi_sector is the only exception
> > and fixing that would help in consolidating our various scatter-gather
> > list data structures - but we'd need buy-in from Jens and Christoph
> > before doing that.
> 
> I'm against it.  Block devices only do sector-aligned IO and we should
> not pretend otherwise.

Eh?

bio isn't really specific to the block layer anyways, given that an
iov_iter can be a bio underneath. We _really_ should be trying for
better commonality of data structures.

