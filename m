Return-Path: <linux-fsdevel+bounces-8013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CC82E329
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B5283BBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A211B7E1;
	Mon, 15 Jan 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K/nnx8fV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D841B5BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Su7AgvzzQv/od8BSfTTf7y3bhWF/Y1PzmFUYIBjyfZY=; b=K/nnx8fV6XpuGQsH4SMUNAZXVP
	hhTgy/+SumHaaKO8zOXnqg0ZnF53K+A3QtOzX+18ohjW2UkX20mryXYU2k2PSLJo2BGOnh/P/1wR6
	zj+CKiVAU5NoeoFdH4WK3AyTThXagQxBwI9czfACjhTHI28EIDDXHLwBjyeq+v1PRQAv3gQvvFgTN
	YVrqTAkt1qBHFpX0o7FDf0mBZcqpfMY5ZS1G3SuGB/rio0dxw5gYt32mZysjuxNcY5l3RcomyDsbH
	GKfoPBsR4tDeyKpObLths77RJQaQyTjg6yaMmbNkIZTglRIf09AQusyjc+imFG6ipylGRhRXqn9BH
	SCrKFLYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPW4T-00B7CN-3X; Mon, 15 Jan 2024 23:08:45 +0000
Date: Mon, 15 Jan 2024 23:08:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Bruno Haible <bruno@clisp.org>, Evgeniy Dushistov <dushistov@mail.ru>,
	linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Message-ID: <ZaW6/bFaN9HEANW+@casper.infradead.org>
References: <4014963.3daJWjYHZt@nimes>
 <20240115222220.GH1674809@ZenIV>
 <20240115223300.GI1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115223300.GI1674809@ZenIV>

On Mon, Jan 15, 2024 at 10:33:00PM +0000, Al Viro wrote:
> On Mon, Jan 15, 2024 at 10:22:20PM +0000, Al Viro wrote:
> > On Mon, Jan 15, 2024 at 11:05:51PM +0100, Bruno Haible wrote:
> > 
> > > Whereas this partition can be mounted fine on FreeBSD, NetBSD, OpenBSD.
> > > FreeBSD 11:
> > > # mount -r -t ufs /dev/ada1s2 /mnt
> > > NetBSD 9.3:
> > > # mount -r -t ffs /dev/wd1a /mnt
> > > OpenBSD 7.4:
> > > # mount -r -t ffs /dev/wd1j /mnt
> > > 
> > > The source code line which emits the
> > >   ufs: ufs_fill_super(): fragment size 8192 is too large
> > > error is obviously linux/fs/ufs/super.c:1083.
> > 
> > Lovely...  Does it really have 8Kb fragments?  That would be painful
> > to deal with - a plenty of places in there assume that fragment fits
> > into a page...

Wouldn't surprise me if netbsd/arm64 had decided to go with 64kB
PAGE_SIZE and 8kB fragments ...

> FWIW, theoretically it might be possible to make that comparison with
> PAGE_SIZE instead of 4096 and require 16K or 64K pages for the kernel
> in question; that ought to work, modulo bugs in completely untested
> cases ;-/
> 
> Support with 4K pages is a different story - that would take much
> more surgery in fs/ufs.

Possibly not too much more.  With large folios, we're most of the way
to being able to support this.  If there's real interest, we can look
at supporting large folios in UFS.

