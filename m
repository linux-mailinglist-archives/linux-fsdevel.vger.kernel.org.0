Return-Path: <linux-fsdevel+bounces-60244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF91B431F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85881547B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F424635E;
	Thu,  4 Sep 2025 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NmXqdoCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1D23B605;
	Thu,  4 Sep 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965946; cv=none; b=RgtGiB6b1Y5kNInHZD4gUj+IisBZP7UxopLXbhNPePdmX21Z4SJ/pNC6ljwORExhySvv2ms4h27a0K3KVH5N0rVcHpcOZ6YQHfzW/nwNl6J1XvaKsOQBBASLiw5PaiBeJ9s1F8np3fpGZYnNmkwR3AvLIWsfFK8+NGGrbm67tKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965946; c=relaxed/simple;
	bh=WH73qhRmJByFmUSDWylUHem1HPBKpLwhDJT82iYxpHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II5l5qyOZxQPQe2y6d1LxxKhj1GAGdj7zBPNOa9zTU67Luc1ZCBXfVmEgzZYaxNLhTGiK/cHxWy+yWywx2GeoQ9VlcPH2gw7k1kuGqgKtV/iScf9C4CnI5dqk6a4OieNCewK7WCgXmtx5Y+YOtg4lQgbt5y9hUfqJPhfKreeP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NmXqdoCC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2e+/P/afQV7c+2DktRB4IRbp9gBJb9kSEzBp0kumldA=; b=NmXqdoCCC2yyNQncol58B5riVx
	t1zvq0AtkZXrsxqknfU7S2H+8Mw0VXd5EeuGo1T27+5yN1R2+4bX4dg8ws8BGlv8y0dyksV+ljtb0
	iJt6uumkAcUE3rVkbbUrFDL3+PIaqGtjX0pdGpxQx1WbH4jbx49t0Kjziw6n9JnrHAvvBzA/eM7Zc
	tlZpI0UD9fa5h8JMhWE0+L+lpaczJJaP6gjNIUxKUvD0s7vzzCQ+vnNeklriOxQJiMTcT8CBNR6u5
	KBAuTs9/tFl3zgO8ROuSdwyUr/0hJMs4atBoDUK29KOkeTs4EQkvE/L1rn2yKseQ1oMMe7eDUDdag
	rUYAzcpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu36O-00000009PTn-3ejE;
	Thu, 04 Sep 2025 06:05:44 +0000
Date: Wed, 3 Sep 2025 23:05:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 03/16] iomap: refactor read/readahead completion
Message-ID: <aLksOHVXfW7gziFB@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-4-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 29, 2025 at 04:56:14PM -0700, Joanne Koong wrote:
> Refactor the read/readahead completion logic into two new functions,
> iomap_readfolio_complete() and iomap_readfolio_submit(). This helps make
> iomap read/readahead generic when the code will be moved out of
> CONFIG_BLOCK scope.

I'll have to look how this goes further down, but I don't really like
the idea of treating bios special in common code.  I'd rather go down
the same route as for writeback and replace the bio with a generic
void pointer, and then either use callbacks to process them, or maybe
have multiple versions of iomap_read_folio / iomap_readfolio_complete
that just share the underlying iterator, but implement their own logic
around it.


