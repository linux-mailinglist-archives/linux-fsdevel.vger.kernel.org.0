Return-Path: <linux-fsdevel+bounces-18919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF738BE864
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9BE28FB55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097716C454;
	Tue,  7 May 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMZM8ZA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C215FD19;
	Tue,  7 May 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098223; cv=none; b=URGcdJAhulCBL7cOBR/cjOgtlg5Grn50xBtQxkadyH0fHeb5CIonEm9qmjdZg939YsGKNDAIkl3N/UmgvzFniiztljq3ueHud6H+w92SQdFflE54jQI+Tl5gzkadBpSeBQmXvsFlPi2M0qgsgZCLNFIpzOxYGOF483SLR3Vkg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098223; c=relaxed/simple;
	bh=PfuWW8nkjC2NhKo1iSiJto7xu8Aw87jUEKcZAtQ/4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgxlLKMJF3no9pOXjtUJn/YqZUZkpKXZ0WmLmk7RpX00l96pYtO0jsUlYc2w9pCXWbWBpFW7H9mHAVD0JcFuqFX++va5PCOF99XsxcB1mN+hXToohIt/b+xinMrYCRADc+j5GUiAyLdwKx+PrWM9gkgxavdIpV4zCx9r/PvbdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tMZM8ZA/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KKGmBlgIr6xib0UMQFkFjiQCKra12CQXDOsG2WglJjY=; b=tMZM8ZA/9lKOnq5df7Z+oKqFUm
	8wcysCiLx/JxBoGpf4rcUDVlypAjmG98Q2ZxhxI0PBz/vbpAeqyPShrySIBVq8stKX1b/2ioWy698
	LyMCK7M0qLjZjjnqjc/PhfliJjfdF5PXQwTQo+A8EdIxWZYRUn+WudCOVKeiG/ePTuzNDzi5q/h+H
	tww0lMOHyf63V7lxVefKJGeIPt7Sk0kLq9Uq9YFQooxSHeTG03tC03IcgEGSU7N46tgIn3JMfgBBj
	4sGjHqsDNaoh1c1h9eFC3PskwchtIdeCf1LgyG/sPN0xxNJwy1cQd18AEbPs6JfpE228cwIJi2nL/
	YMSYc2dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4NOR-0000000BtsQ-2Lvk;
	Tue, 07 May 2024 16:10:15 +0000
Date: Tue, 7 May 2024 09:10:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZjpSZ2KjpUHPs_1Z@infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpQHA1zcLhUZa_D@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 07, 2024 at 05:00:28PM +0100, Matthew Wilcox wrote:
> If the len is more than PAGE_SIZE * BIO_MAX_VECS, __bio_add_page()
> will fail silently.  I hate this interface.

No, it won't.  You can pass an arbitray len to it.

> 
> You should be doing something like ...
> 
> 	while (len) {
> 		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> 
> 		while (!bio || bio_add_page() < io_len) {
> 			if (bio)
> 				iomap_dio_submit_bio(iter, dio, bio, pos);
> 			bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> 					REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> 		 	fscrypt_set_bio_crypt_ctx(bio, inode,
> 					pos >> inode->i_blkbits, GFP_KERNEL);
> 		}
> 	}

Wee, no.  The right way is:

	bio = iomap_dio_alloc_bio(iter, dio, 1,
			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
	__bio_add_page(bio, page, len, 0);

	fscrypt_set_bio_crypt_ctx(bio, inode,
			pos >> inode->i_blkbits, GFP_KERNEL);

(or even better the folio version)

