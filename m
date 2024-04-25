Return-Path: <linux-fsdevel+bounces-17760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56928B21F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E671C22259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA4149C50;
	Thu, 25 Apr 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmdhVkm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CD1494D4;
	Thu, 25 Apr 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049507; cv=none; b=rsK6hF71mBMBD6vHRyG0hcZcmOT9JZOGb8BNE/TMohRzoqyzX1redowkenfwrEefw/qxCmknfMjY4JdL8p/x1iM6KkcqYvv9rb336vlnP7FQbm4dN+EQBmYac75wwTt9sCa345BJ++9a9kUqB1BeDQHvdyf3p1UGio0ZeOD9j8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049507; c=relaxed/simple;
	bh=BA+I+7heHrbIKNm5f6zLRZCzpNLlGhe4nnOkMCrSwCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At8CPQ6c8WERti0Rpa/qO+naQYLkuqbVdh++cxW4w5VJl0ez872iZQPKXaN0cONhqx9QxbNZ4QUoRiZ4KNcKiPpcoimLRxaV9YCtFQZe3MhYJWkxjD5Tvs0/hwiVlb4O6aJ9rru2I0VpEnQTWK4I07qlczYb72G/yvmYkoiCoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WmdhVkm2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3/N/w1qO0yBySuD/ZijtmTPz5/HW4aJaszkaYwnf0QQ=; b=WmdhVkm2PhMVOCzH10SgP0iFI9
	PqbySe+KnaUirsJeuktwX/Lwx2sEihIM9hA97ar38r8q4i2bH0LMdYJe2P0YuuPimwhe5KhdA4TL+
	ecGnRN5EsmuHxgVleUVzCVDTsXv76gJmui0V12txgf7JYOGOsgAzWxbxZtkPYuM5yPJRvCzFIpyen
	z4WiWjCSEz3DhPZp2F/shhPh8SZFL6N+TmlDwEuKkG2J+f8yM0PkiVIcXdWpDo8cUPpFmXw+mhKBG
	fvWzgY1moxTb/ojj6SxU0h4L9VccGuVNMY+SdeBQZ7m5odgI72wJIf+alsJWXwsPTZMcdHJfHEEKU
	zFh2Fycg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzyZl-00000008Jzb-3cOi;
	Thu, 25 Apr 2024 12:51:45 +0000
Date: Thu, 25 Apr 2024 05:51:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZipR4evzudGl-AgP@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
 <ZiZ817PiBFqDYo1T@casper.infradead.org>
 <ZiaBqiYUx5NrunTO@infradead.org>
 <ZiajqYd305U8njo5@casper.infradead.org>
 <ZipLUF3cZkXctvGG@infradead.org>
 <ZipQQYPLuFuh3ui6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipQQYPLuFuh3ui6@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 25, 2024 at 01:44:49PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 05:23:44AM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 22, 2024 at 06:51:37PM +0100, Matthew Wilcox wrote:
> > > If I do that then half the mailing lists bounce them for having too
> > > many recipients.  b4 can fetch the entire series for you if you've
> > > decided to break your email workflow.  And yes, 0/30 was bcc'd to
> > > linux-xfs as well.
> > 
> > I can't find it on linux-xfs still.  And please just don't make up
> > your own workflow or require odd tools.
> 
> You even quoted the bit where I explained that the workflow you insist I
> follow doesn't work.

I've regularly sent series to more list than you'd need for 30
patches even if they were entirely unrelated.  But if they are
entirely unrelated it shouldn't be a series to start with..

