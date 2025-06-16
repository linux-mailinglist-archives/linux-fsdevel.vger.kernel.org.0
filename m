Return-Path: <linux-fsdevel+bounces-51747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6445ADB051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BF11889046
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB5285CAD;
	Mon, 16 Jun 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQCCE4oq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BB2E425D;
	Mon, 16 Jun 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077340; cv=none; b=HHXuM9QTlsWmYGJXADnhShjJlAYj37m7aaaiWXXBgKdo79yet8cJ6G3DKwjkunJ1nuijMnEwLMNIYFOl3K0fAu1AIF3YfFjuw/aAxvVQbQ3oZELS1Au1rRcn6L+q/oy3hjudD8FLAXIV6CCQ11Bt2e0/vX6+L13cnecP2TkrsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077340; c=relaxed/simple;
	bh=T3p/MgaQS4n2whokGfV1mRN5WXW27MLePQ+rBFc7KeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHf9R1SKZ5pYLazUevbvajhW4B33s2RtKG1AQL4hKnUOv5j5+7BL+y5mQ1FsQVTxr+hOfVe55A01BLRegh81kIEgVOQa8ezLtLQQ6bcZU7z2Zd/X62Izjte78KL7EPvcTJdE3DOFOAJjZGp0gQwpaXqg6egyP7+BNm/YKvcyGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YQCCE4oq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ntp/1m+hPOyh8hlCEl59nMttCiWa+KuneucWgtv7WVw=; b=YQCCE4oqF87thzEwYSSdzpO7qw
	Hl5V0d0ywF/JSoVjwwn5MqAt+4eHjzevDr33HxmKK+7KdePcmwfXDOaHIcIPvw19qYbDOtak8DByo
	TI9NoUO3+2yupd4t6nDFPEjpeXYKzg8iU9BVUby2v7azVwGPvE+ih/lGfIyNyy4xAaGa7DCDAaX+J
	m/gykHGz697CG72WZSscUw5SSRLMc4jab54qiTrYPenof5VjmBTKYOBLZbKqWcjKuO1Wo8badjUCa
	Dg3HXkeJTIDfVOYnZMigXN63Fe1zdWOVzXYKnDmnMa29B+sczfw//L7ttC0HQjJ+2hJovHXKJwKy0
	NFgIk69A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR93q-00000004NwZ-26aw;
	Mon, 16 Jun 2025 12:35:38 +0000
Date: Mon, 16 Jun 2025 05:35:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	david.flynn@hammerspace.com
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aFAPmrp9lG4qCfRk@infradead.org>
References: <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
 <aEvuJP7_xhVk5R4S@kernel.org>
 <826d22214f01fc453a7e38953e2b8893073fcd46.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826d22214f01fc453a7e38953e2b8893073fcd46.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 09:02:23AM -0400, Jeff Layton wrote:
> This is an excellent point. If the memory alignment doesn't matter,
> then maybe it's enough to just receive the same way we do today and
> just pad out to the correct blocksize in the bvec array if the data is
> unaligned vs. the blocksize.

Note that the size and the logical offset of direct I/O writes needs to
be aligned to at least the sector size of the device, and for out of
place writing file systems the block size of the file system.  It's just
the memory address that (usually) only has minimal alignment
requirements.  So no need to pad anything IFF you writes have the
right logical offset alignment and size, and if they don't, no padding
is going to help you.

> 1. nfsd could just return nfserr_inval when a write is unaligned and
> the export is set up for DIO writes. IOW, just project the requirement
> about alignment to the client. This might be the safest option, at
> least initially. Unaligned writes are pretty uncommon. Most clients
> will probably never hit the error.

Eww.  While requiring aligned writes sounds fine (the block layout
family requires it), you'll really want to come up with a draft that
allows clients to opt into it.  Something like the server offers an
attribute, that the client opts into or so.

> 2. What if we added a new "rmw_iter" operation to file_operations that
> could be used for unaligned writes? XFS (for instance) could take the
> i_rwsem exclusive, do DIO reads of the end blocks into bounce pages,
> copy in the unaligned bits at the ends of the iter, do a DIO write and
> release the lock. It'll be slow as hell, but it wouldn't be racy.

That does sound doable.  But it's a fair amount of extra VFS and file
system code, so it needs very solid numbers to back it up.


