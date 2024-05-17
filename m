Return-Path: <linux-fsdevel+bounces-19682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591128C882A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1459228806C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA1651A4;
	Fri, 17 May 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVx3hBPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475163417;
	Fri, 17 May 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956693; cv=none; b=eERJ3ao0652ppMHWm2NPHW1t+iGymnUF2hYCnrPpMGaaUZbggrKwrAmv3REcwkc9ND+9URytWkOmPFZ12f7DtIaaAQRPcBERS9zBPoPo+rCX/B1M+mA0ZYN+ncqA9pOFkaVM1htwdXGZ4URRLHBj2gLuRerLBMxbsAb+80VM80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956693; c=relaxed/simple;
	bh=5gi+DTUzW3YPqxeZIoVVNsfDihx3SAkeEccu9TVI4Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ1f0J/9Do+ewgsGePubAjAhI/51nKh4sGEdjCBbnk9Uve+ibN9lrMdTfEyKUcdl3IYcwMBCa33+Czq9kmYJ7sHA4pw1quisxj1sZaF0cxvjMJzabL9ZLgpGxhuELki7XfuIdhTrhc2LiwsnrjDzIgqfrlvB3Zb6mm7jtj7NaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hVx3hBPw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t0Wr/sZLtXSS6zurWWrrdIcft16mGA/DRVSd5xr7vII=; b=hVx3hBPwm9fQ5/u8awj4CICYli
	K4QOH/Owqr4rm+oXUxqPkaZjEijVGPDi99pUTsHfbQl50tDa2QNmeXQMnqqDFp3ZzOCSLsihLrO1S
	MqxFaZCqoKspZqlFaSELPiZpllWJLzy8+Fr8pqjQfF5aCtUcCvfC+ik7mSXtr6bQHL3jzKfEcbKpj
	agSafCDqhOwfi/MDyksmQMk9b6fDJ2oIS8Ll7kkaJM45FlznFgsachU/BHQg/OQttPir+F0n9FlM4
	5OyTwvcMv2BgX+bcZ7uOz2Ldzpo7i1Qjh++3pUpHuQHN1ShaCh9uMXeGY48/c1t/YMn7CtPsGpyU2
	z8jMOD5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7yik-0000000D2Of-3u8U;
	Fri, 17 May 2024 14:38:06 +0000
Date: Fri, 17 May 2024 15:38:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: Re: [PATCH v2] iomap: avoid redundant fault_in_iov_iter_readable()
 judgement when use larger chunks
Message-ID: <ZkdrzlM8d_GowdSO@casper.infradead.org>
References: <20240517201407.2144528-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517201407.2144528-1-xu.yang_2@nxp.com>

On Sat, May 18, 2024 at 04:14:07AM +0800, Xu Yang wrote:
> Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
> iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
> mapping doesn't support large folio, only one page of maximum 4KB will
> be created and 4KB data will be writen to pagecache each time. Then,
> next 4KB will be handled in next iteration.
> 
> If chunk is 2MB, total 512 pages need to be handled finally. During this
> period, fault_in_iov_iter_readable() is called to check iov_iter readable
> validity. Since only 4KB will be handled each time, below address space
> will be checked over and over again:
> 
> start         	end
> -
> buf,    	buf+2MB
> buf+4KB, 	buf+2MB
> buf+8KB, 	buf+2MB
> ...
> buf+2044KB 	buf+2MB
> 
> Obviously the checking size is wrong since only 4KB will be handled each
> time. So this will get a correct bytes before fault_in_iov_iter_readable()
> to let iomap work well in non-large folio case.

You haven't talked at all about why this is important.  Is it a
performance problem?  If so, numbers please.  Particularly if you want
this backported to stable.

I alos think this is the wrong way to solve the problem.  We should
instead adjust 'chunk'.  Given everything else going on, I think we
want:

(in filemap.h):

static inline size_t mapping_max_folio_size(struct address_space *mapping)
{
	if (mapping_large_folio_support(mapping))
		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
	return PAGE_SIZE;
}

and then in iomap,

-	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
+	size_t chunk = mapping_max_folio_size(mapping);

(and move the initialisation of 'mapping' to before this)


