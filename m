Return-Path: <linux-fsdevel+bounces-67127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F2C35E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AF93B86D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A42324B28;
	Wed,  5 Nov 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DyZPs0nF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B791322DC0;
	Wed,  5 Nov 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349902; cv=none; b=bS9JisV2DupQKqo7HPyogZIj7QV5+nQFIwRBFzpvffw4o4eCUEXvBOqZmkd+HEUntQwhU58dFCjMMb2wRaBa4IBL8XO6c9PJIyDXptAk/kcavxCpdse4k9OGWpeMTD0VGKMdO2LTrotVCK+DQizwYWm0GDN6i631TJa9j/jVLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349902; c=relaxed/simple;
	bh=a8nGpHuk3tHmtZJG/XFpw6rotTt8WNq+uNBHUL4igpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMcCRwpeKWZD82pfCEXqWbefMEWCFvQCPznW9jqoDE5bwQCPc64LAQr3I039F7hWGPLdDyJma3E5CAXWpDxGRjkh3Y/VYJDZUWtXoW9Wrbpu4GwkOXGB93A6krV0/E7F6NDA5ygLWDkG574kLufSRaXrP4EK/d+rAGiudKG3Bjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DyZPs0nF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oojFKDeK0iek2rvbziiNellE4VJMnquz1F+Om/0DEB8=; b=DyZPs0nFdUX/qUxx9EdH19I2NM
	xUF7J0fNljZjvj91GEi3dgvhuXPZ3LIwLcnoyAWMORY+zR/AnVR/IawVcm1/trhDnK9uAtAVy4Cuy
	YFsRtrbfgsC38d5ZclnkqpjVZWCyUzKP6VJG/yIuDnjq4XTgieLq3OQ8HqBDHFNx2/whkqgw0tBVO
	ehzsQBGPuMqp+2VV+PCWapCQHLrci/qd9r+VjccAjrPI8uMpuubCqad6nllt3JU0ffhPK/phM0Mzm
	32USAgGaSs+QKqoROWXOWvK3pnaAB54pPm66fR00sOGRQxWDf+rQ+Sz4ZA/0VCfi0iOXh1dY5K1SD
	nOztVlfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdiM-0000000DnWj-3dN2;
	Wed, 05 Nov 2025 13:38:18 +0000
Date: Wed, 5 Nov 2025 05:38:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-fscrypt@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
Message-ID: <aQtTSsthjYzsv66t@infradead.org>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
 <20251103164829.GC1735@sol>
 <aQnftXAg93-4FbaO@infradead.org>
 <b8f06e62-27dc-462e-83ad-33b179daf8a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8f06e62-27dc-462e-83ad-33b179daf8a2@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 11:05:49PM +0800, Yongpeng Yang wrote:
> On 11/4/2025 7:12 PM, Christoph Hellwig wrote:
> > On Mon, Nov 03, 2025 at 08:48:29AM -0800, Eric Biggers wrote:
> > > >   	*inode_ret = inode;
> > > > -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
> > > > +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +
> > 
> > This should be using folio_pos() instead of open coding the arithmetics.
> > 
> 
> How about this modification: using "<< PAGE_SHIFT" instead of "* PAGE_SIZE"
> for page_offset and folio_pos?

Any decent compiler turns a multiplication by a compіle time fixed
power of two constant in shifts, so why bother?

(and yes, I just double checked this happens here)


