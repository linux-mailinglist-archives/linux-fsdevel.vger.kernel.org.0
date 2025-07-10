Return-Path: <linux-fsdevel+bounces-54470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D54EAFFFE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5261C8565B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E652E3371;
	Thu, 10 Jul 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F31DW1Wa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CE2E11B3;
	Thu, 10 Jul 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145190; cv=none; b=ghjzX7wnmNK6mTk2shJRbz9eZUkZfvR8J07Iv2qf/zNtldmxE62ndc/Zhte131VPyXgvZpLacao9u+dbZxSVXmRnSFH7txdqUzsBLVpER2V13VG3F4b+ne/aa3n+evDBUyDBbbrAPQZOSyxgX7GiW+8jxmAJtM+1sJWpk5mEjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145190; c=relaxed/simple;
	bh=YddTB88+2/kA7OwDamO75o6X4XVq0EuQfkSw74+nQxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL/8/mMMZCfOuTojWLWI2jkX4rNq2pe0n6j4AXfNK+upFRVdZ3tw6Y0dPdoru04+eTej6fMjrIBbY3yIUeyJUU11mO+mmnEXQWOrii+nWAcLcN0tgQa1/ZqX/J37DHo69bxxDsRawVv6fgHoCEBRWqSPTyIUSlXj2VmczrwzzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F31DW1Wa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WvqIPEfWD9uD4rQga0dMwrnfQPe1vBwSUrMxLgce8Pk=; b=F31DW1Wa5Nx5SLpLnoAlmgXvTt
	wF+bfPNY37kl4oiz+KPTroEs3Fzg0GaJYS1pxWOkc4wQ7D0DDxiDm6vKrh7M+nSlrbof4Vcp/azDN
	bIkeFcgl3G7/C+LN9W2mzy6vupqXsn2VnU37yqV+JaqTbRwAfZBZVJdevQI/KBx2G4PI4pL8ONeOw
	VgPcDKTEQo3zVNTRihed1GniZOlEh7K+2UlD9y4SgIIsFGgW/UwYu7GQiXaEnHYiGLimKRcs1P9Wi
	cwsNw+G46LRmrdpXjSLtjP7jHXd1cma1CDTFyJCDiGL+xw/RlMwFCbxekawE6JdHt7P2BhClCn34B
	boPWe5aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZp0F-0000000BYbt-1Zv1;
	Thu, 10 Jul 2025 10:59:47 +0000
Date: Thu, 10 Jul 2025 03:59:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, LTP List <ltp@lists.linux.it>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Copeland <benjamin.copeland@linaro.org>, rbm@suse.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <aG-dI2wJDl-HfzFG@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
 <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 10, 2025 at 12:50:44PM +0200, Arnd Bergmann wrote:
> There are multiple methods we've used to do this in the past,
> but I don't think any of them are great, including the version
> that Christian is trying to push now:
> 
> The most common variant is to leave extra room at the end of
> a structure and use that as in your 1fd8159e7ca4 ("xfs: export zoned
> geometry via XFS_FSOP_GEOM") and many other examples.

That's using the space.  I had that discussion before in context of
this API, and I still think that reserving a small amount of space
that can be used for extensions is usually good practice.  Often
we get some of that for free by 64-bit aligning anyway, and adding
a bit more tends to also be useful.

> This is probably the easiest and it only fails once you run out of
> spare room and have to pick a new command number. A common mistake
> here is to forget checking the padding in the input data against
> zero, so old kernels just ignore whatever new userspace tried
> to pass.
> 
> I think the variant from commit 1b6d968de22b ("xfs: bump
> XFS_IOC_FSGEOMETRY to v5 structures") where the old structure
> gets renamed and the existing macro refers to a different
> command code is more problematic. We used to always require
> userspace to be built against the oldest kernel headers it could run
> on. This worked fine in the past but it appears that userspace
> (in particular glibc) has increasingly expected to also work
> on older kernels when building against new headers.

This is what I meant.  Note that the userspace in this case also keeps a
case trying the old structure, but that does indeed require keeping the
userspace somewhat in lockstep if you do the renaming as in this example.
The better example would be one using a new new for the extended
structure, or requiring a feature macro to get the larger structure.

> Christian's version using the copy_struct_{from,to}_user()
> aims to avoid most of the problems. The main downside I see
> here is the extra complexity in the kernel. As far as I can
> tell, this has mainly led to extra kernel bugs but has not
> actually resulted in any structure getting seamlessly
> extended.

That is my (non-scientific) impression as well.


