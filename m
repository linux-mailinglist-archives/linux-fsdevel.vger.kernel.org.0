Return-Path: <linux-fsdevel+bounces-18922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEA8BE87A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF92928FA30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41816ABE2;
	Tue,  7 May 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTAiAMbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562916190C;
	Tue,  7 May 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098403; cv=none; b=b45NwDFeXsE9aPAehsjXwyGCrylBVF/6SF+ZIZmcUF9bs9Y+q7ZQhFF6AwUP4MVctQ3ucRMNKtTSsDve88HkaVOeA/x39FQxIqA9CRd1HCgUBe2Y+y8Es0jxroqOyvXRsPwd9KduN0hr84HVuVMurTT/wngFCCCvpmMUdT66FjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098403; c=relaxed/simple;
	bh=x4+X5D9b7YnRPJkgsyxVvYPYvZHUUomQ2HsXzEmbWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqzUVldIMh3tzLqB7wmp4hrurzFA7pkGaEI1+wgJ4rjJ3zJGV6HwblXfrgRYqcvZCAgwGzuEydJRVrdnz7XLXcfKsLWSkrgM0IFADxCjSKLsIFTnWskHhux7pN8ChBhCc7Pmiti58fyKkUGAzJv7beUcDHD5RMXA/7o4s2ds1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TTAiAMbN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QikOvGJohtB2wgzDEFYigsChZEmsotuQTXOsqh0RHI0=; b=TTAiAMbNovozyEA1ekZkN7rDGQ
	KssDxMqjazEd2Cwc8LEWLFWgqCZi8a/vUUgSt0w/l02+ByDKMuI41l5FJjc+QI9wqCkzPNVOAsymD
	QjKRw8xVnskDMPa4okD/5j3kxNIqUP7irorBXi/PW8mF+cnf2kowwxn0IUrIFUs3To4KplLDLHMLy
	+ImiGwMASJm2I+0rPVeDDDQvmH9SnMXRx3jntCgK1N016tNEDzyNCbqrVRr5rul+r3O1AAgRIaTVL
	48IzDW2HUywaR2GLLcF/u1YujMAVAGYPFPrwPDca2fNuF33fvzWcAdmxSfRDfIjVuszqJfVWlZkWN
	i8w9MFxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4NRN-0000000Bub8-1jNj;
	Tue, 07 May 2024 16:13:17 +0000
Date: Tue, 7 May 2024 09:13:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZjpTHdtPJr1wLZBL@infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
 <ZjpSZ2KjpUHPs_1Z@infradead.org>
 <ZjpSzi-HiZkx_Kdq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpSzi-HiZkx_Kdq@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 07, 2024 at 05:11:58PM +0100, Matthew Wilcox wrote:
> > 	__bio_add_page(bio, page, len, 0);
> 
> no?  len can be > PAGE_SIZE.

Yes. So what?

