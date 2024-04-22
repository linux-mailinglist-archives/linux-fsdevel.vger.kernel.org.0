Return-Path: <linux-fsdevel+bounces-17411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66908AD090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC21F22E75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00581534E2;
	Mon, 22 Apr 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wD7QW93K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2A14F10C;
	Mon, 22 Apr 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799596; cv=none; b=j+d+15c7K7sDf6Fxd8PN4ymzbaaIW4QSZkM+ibwloc9ARcLYhaPggKuX+hgqTJm/G1gYrwz24nYmbVz7d5q1R6CA1wGL7bvInCTJibzFOXb9D+h1ukBB0r+jSH6ks+os4mrKpRNhGbnJ3FfOcmbORRyqcTvo10AVtsuLaZCfivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799596; c=relaxed/simple;
	bh=Tt1UnZVlmJqHNoli3pDRE3GiZY/6Yt3FcAXNY24/ltg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWsuyeeql3pu+gjSnj27+CDYObHu+zLQi2KJgu4uWpm+AdthLELP4xKgrxuENrRyOIkcYJM34x9yp66DeO5xcpzYU/WW52cJRJOc+31Q2i0thc1Ppj7cZwy2sPBcOGBNkj27rjCPL8foKQjE9cD6iDVhQ1i3BbtFOKM3tNZsBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wD7QW93K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hKikBvfii3FDGdOvXvWt5fc4lW3jondvqTShoai+gfw=; b=wD7QW93KsMv+ooQlBzvh3Vrwbj
	0emZx6CIm5P2EaiJZLM+KMKEglvy+6jm2f3tivZQqu2aMs9r2VCqEezMyitJTMIrvxPqR7GRoxpv3
	LUopRous6azMMIpS9PxL+zauh8wXCtk4X+O7h3R7x6J4txGza2UIrO+4Zh033F6FgYY1ZFxwEYF/9
	dHnb/yCUumFLc8ol4+rpvI64DGXODMNvicCgrhYewYV6HKqR7w4NErf67nbwMEYIrGInbnIFj3Njm
	vDfaSdsaCY57sGLzmKroB8kHQooeJy5ATSY2r3o8DKhbZZyaSbgv/KwZ2KHa5IAQ2TviKns5ASnDR
	osPvrDLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryvYw-0000000E6vo-1OyX;
	Mon, 22 Apr 2024 15:26:34 +0000
Date: Mon, 22 Apr 2024 08:26:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZiaBqiYUx5NrunTO@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
 <ZiZ817PiBFqDYo1T@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiZ817PiBFqDYo1T@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 22, 2024 at 04:05:59PM +0100, Matthew Wilcox wrote:
> On Sun, Apr 21, 2024 at 11:16:01PM -0700, Christoph Hellwig wrote:
> > On Sat, Apr 20, 2024 at 03:50:22AM +0100, Matthew Wilcox (Oracle) wrote:
> > > The folio error flag is not checked anywhere, so we can remove the calls
> > > to set and clear it.
> > 
> > This patch on it's own looks good, but seeing this is a 27/30 I have
> > no chance to actually fully review it.
> 
> You were bcc'd on 0/30 which fully explained this.

Not on the XFS list through which I'm reading this at least.  If it
was to me personally those all go to >/dev/null anyway for mails
Cced to mailing lists.

Please always send the damn series to everyone, fishing individual
mails out of it is just a giant pain in the butt.

