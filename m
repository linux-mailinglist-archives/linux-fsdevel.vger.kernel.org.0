Return-Path: <linux-fsdevel+bounces-17751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555228B2193
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AB11C21F55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250512BF3E;
	Thu, 25 Apr 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="By0548us"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580312BF26;
	Thu, 25 Apr 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047826; cv=none; b=uoeS6dWQXpHLQK2pXbXMoRtjrG6B3V5ZlrCEo9l1djkpKiLCOHlWom147UVeONw2lDe0Tnh8paKhUd6A41xKUeOnTunfWfsQlEyLOPrJLJkYLzQv+38aJ3ANCEVraI/6pzIsnxO7Puqh339KRxXUfjBiqZvKmRzzEpJI+DFIYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047826; c=relaxed/simple;
	bh=UMZs5NOna9+KiMtGkQpw4EENhSINQqJWkQsUH6QLnTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlboOdXAWxSB1PT5y4KsO1hTmCAuLy2f2Z9CA/CAyC4k/RCDD6sf+s80Y3kS/qoptBPxDsyS3+G/t/a+smKHSn9dB6XieKVVffaLefkHfJNtzm+TbGD/1iMpTKxYJ/Fv86OTO1MmElaO21IhlaG7wA0q8r6panc6KZ/Xvx0XgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=By0548us; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ChaMVAjQ0oQE+nAKRlnzoREfXTW6cSwuIx4Wk/Tr2c=; b=By0548ussQBy5HAf2r92MUtdI2
	oITI1aob/WVMWsl6hWcqtdypKu09hbZOJxhfnEtGtiLdcRYNbU3eMvbVOYI6dabaIrjo58pttPHtR
	U0cFn3WjKryfC/Gub3vdo4dKZkxp2NRP8ILH6/BuOe+Jx7UGcBDpK3LMCoKqilHWeZ9w5NspOVYyY
	ozM8kbLf8VJm0sWHTvILjJb0sYD7PtoxmZvofb7fuNOkdphcQLTIJw9rX7rtxUcRBVTFybrZdTiXf
	tu3GMdVdLCq2GSSlvg3T954fOkTbMImQYsT40oIFZ7jaGF3dTRfKhtzKMYVhiCEIrF3IlB71Pmqsy
	aKdCx4AQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzy8e-00000008Cco-1Pzz;
	Thu, 25 Apr 2024 12:23:44 +0000
Date: Thu, 25 Apr 2024 05:23:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZipLUF3cZkXctvGG@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
 <ZiZ817PiBFqDYo1T@casper.infradead.org>
 <ZiaBqiYUx5NrunTO@infradead.org>
 <ZiajqYd305U8njo5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiajqYd305U8njo5@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 22, 2024 at 06:51:37PM +0100, Matthew Wilcox wrote:
> If I do that then half the mailing lists bounce them for having too
> many recipients.  b4 can fetch the entire series for you if you've
> decided to break your email workflow.  And yes, 0/30 was bcc'd to
> linux-xfs as well.

I can't find it on linux-xfs still.  And please just don't make up
your own workflow or require odd tools.


