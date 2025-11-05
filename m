Return-Path: <linux-fsdevel+bounces-67128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7AC35E20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558AC3B7BD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C5322C98;
	Wed,  5 Nov 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L5R3XLk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914E3148C9;
	Wed,  5 Nov 2025 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350026; cv=none; b=Lcxa6kslmF0dOp9szHRKCAW/zXg3WflFMcoZNQZweonzOF6v3QsxWkEQjmyayKLJs+glXHM2Dpnyhj2ud6U+uRvOpWj3aeoEhNHm6WNB96YDRepE0tRDg5RabcWo6pShNAccUSm0/VpQ9PJx9ckUFyWiqVfp5TKPBgOE6J4C55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350026; c=relaxed/simple;
	bh=huiAfikrhoOW56s4PrniPPn58VDT0QbIroQcku/eiHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6pYgTNMrLuWqpVpWu2pqubIwSDsnrb+lBi8Fx4m3VvtPubclfoXR3HYeupEVwWU1Zj0lPwFmT8cxDbeBlW+oUCb0oJowJYJTAMaIzkFCGbrAlcWOwyvlxhhi0XkSPp25NJJOYJBYDx0ESs8raIcwVbGZeAK9c8OdIldqIsXios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L5R3XLk5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mxQ57KCKoJ8C+MWXxq9cgZJUFKABoAaer30xNp0gR5g=; b=L5R3XLk5dkxptI5gJqIFC24hlY
	EjrB8jhTyu3aoCC5JXSbAuh8AdBOg8tKradtHF0s8E6CCAiQt6L8F6OjWtl/tIvkvFTas6GySeSlk
	K0kWeCkA0Qdhkobrz86ji/TqtXNwE2n9GLQbYuZ5+CvLmumACDJ46pNNY2pshzZs3qsIwztSzJ/4y
	DlYMlRP3nqMkhUJk5+EH2ThQTfZhCFVboMH16q9kG2JT6WWmiRceucfATLUMB6iVIpy7gfw97wSFM
	ek+s7qoz/H+8DsGy3cVjnI91qjNzbUblFL6rys1oBODs/Vy4tLun+mxFFIDfnX7G4PyExxfTd+7nN
	GRbEnpTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdkN-0000000DngN-2SP8;
	Wed, 05 Nov 2025 13:40:23 +0000
Date: Wed, 5 Nov 2025 05:40:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-fscrypt@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
Message-ID: <aQtTxx8ufd00_sJf@infradead.org>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
 <20251103164829.GC1735@sol>
 <aQnftXAg93-4FbaO@infradead.org>
 <20251104181006.GC1780@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104181006.GC1780@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 10:10:06AM -0800, Eric Biggers wrote:
> On Tue, Nov 04, 2025 at 03:12:53AM -0800, Christoph Hellwig wrote:
> > On Mon, Nov 03, 2025 at 08:48:29AM -0800, Eric Biggers wrote:
> > > >  	*inode_ret = inode;
> > > > -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
> > > > +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +
> > 
> > This should be using folio_pos() instead of open coding the arithmetics.
> 
> Well, folio_pos() doesn't work with sizes greater than S64_MAX, and it
> uses multiplication rather than a shift.

What do you mean with "sizes greater than S64_MAX"?  folio_pos works
on a folio and is the MM designated helper to get the file offset
from a folio, where a file offset is a loff_t, aka s64.

And as answered to the previous mail, the compiler turns that
multiplication into a shift.

> Anyway, the trivial version avoids having to consider any of this...

I see it the other way around - folio_pos is the defined way to get
the index into the inode (block device inode here) in the abstract
way.


