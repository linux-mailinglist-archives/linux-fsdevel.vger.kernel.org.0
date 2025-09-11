Return-Path: <linux-fsdevel+bounces-60925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71BB52FE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DD1CC092D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB931280F;
	Thu, 11 Sep 2025 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1T9By0xP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BC311C15;
	Thu, 11 Sep 2025 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589192; cv=none; b=R+RcVmdL2FlmTIN6A3l6MHeBaTPBhGvfKv7fTK6GVR+7GmTfWclTfx5qXtPSDTBPiSLWOAW7XJQh/axo2XRbyx9LxkdYqMpb9po0WGqwj4m7ZqK9bdNzLsXv9SU2bCTko8+N9kwE2CZnxzY5EAq6ivA3r9FWmbm3cZEKeP+6Iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589192; c=relaxed/simple;
	bh=DlDj2AEPdMK3rWbjxjJ7qOMRhew3eiqDmzQ4GBhzJ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hadt/4k8BAdDTea8TQk1Adl8exBkl0b/aIMyLdnj+BotNjNp4ogwLkqGSGYFX0nhf9VjrC+DTiZWDURTaw1SqoJuVvfUd+4jv9ZK+80ASeF1a87eNiYsgGp1RuYchPceuHmWLEGNW8xg2SZoFehnnyr9gNldt+IQf0tKS4Kicyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1T9By0xP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lVLk7yo3S4yU/kg/aBtsSn1ppGH258uskjmwURr4PWE=; b=1T9By0xPANs7Dl4VWWT0Am3cxb
	tnX0DcuecRm0HAuHR0mM5NR5s9jTl7eMtM/nyBqJk4OTUBoxp8ekMAEsF1Rb1CyCr5lqYfua/m0MQ
	JZVmXPCxtAm3xK7lvf226NVwSUR7l9ZGMHs/+aEmf8EShEWoqAf6FanJUU70KjRSFaAZpQliOqsQg
	iijj7FmGZBnywziVS1nAw6Ij+TMNru4zQ4u7Z6Bp4B3xT8yVl4jt0um0/Z/JJZZnH6zA9A0CLScEI
	D6At7cCrgcQkYlnZddFLm+dKeDgrr3dI+ARQlK6pMVSgiU/lGGYSbR+dVannFflN0ydNHBQMwH1o2
	+Q6J+7YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfEj-00000002ap2-31kB;
	Thu, 11 Sep 2025 11:13:09 +0000
Date: Thu, 11 Sep 2025 04:13:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to
 caller
Message-ID: <aMKuxZq_MK4KWgRc@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-6-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 08, 2025 at 11:51:11AM -0700, Joanne Koong wrote:
> Propagate any error encountered in iomap_read_folio() back up to its
> caller (otherwise a default -EIO will be passed up by
> filemap_read_folio() to callers). This is standard behavior for how
> other filesystems handle their ->read_folio() errors as well.
> 
> Remove the out of date comment about setting the folio error flag.
> Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
> Remove calls to set and clear folio error flag").

As mentioned last time I actually think this is a bad idea, and the most
common helpers (mpage_read_folio and block_read_full_folio) will not
return and error here.



