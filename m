Return-Path: <linux-fsdevel+bounces-51104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48FAD2CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF43B1CC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08221322F;
	Tue, 10 Jun 2025 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdbHXxgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0821CD3F;
	Tue, 10 Jun 2025 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529880; cv=none; b=KxMZ72dvW+iT0bXCoPRHno1j0u0tPcb1g5joZhl21E0JDbU4/3lROM7JY2XapFhRd6wmdyWHZEak9T2YptiIHyIvnDv7WXbOw25UkpaTOjLQYDBAhoiP63bCyAjw4oUStpjhGfcfITMlag0+FQadfVtdjysnoqQeszzwf8snT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529880; c=relaxed/simple;
	bh=9vSSfjY2/HIqXlztvjJhAcxdQL59XdstZegNmRpTYf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faOWEs6XCWJWBfQCQ+vTH5P4+aFgDnvHWnPUX8v02L9uyD3PS81ouE+784tpmDmypDkdhCf/DYoBAM3yTK2SwfD59iycfJRog7xVMbgvy3UfhlTDBcUz2dv/i3LQ5iBbqHeEPFf6LxI7wm61mHJfxc7NXtrwvgnty59o0FC68zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdbHXxgR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uEr7ULSTI9eswgFIakWh6oqioYdlLPwadRvhn0Fstjg=; b=BdbHXxgRvE5bl7y4fE3ilxl+uC
	Y6pdEwlBltQ1Z6qdOda8iuz10pHyTQ7MPI+0bVjUSuNNUd2S4DBvHsT+YH4rVNAv3BIr9qALrgK3G
	moFrlIaRcaYtkqbchAVzF9ZSNRtHLwDHvOStOM1hph9NkHTe2EL7ykJf6VXnVh7H1yhB/XKspA2Yq
	CCIybyMH/k8+8sCScdE5ikMUn/8Sm8FAwG082ESbxIhSGs+RetiGj/Re+jdbdNfvQ+TpkRRw/80dO
	/biShgLbwTSfLxKuFPlFPm1Fn/PEjMbrfzA71L4wGHXwFkCviZKCikNtDnTWbVY1mUhlf1u4FWwZ4
	AZhtDtXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqdr-00000005krI-0vsc;
	Tue, 10 Jun 2025 04:31:19 +0000
Date: Mon, 9 Jun 2025 21:31:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <aEe1F6cswolN9Och@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-6-bfoster@redhat.com>
 <20250609161219.GE6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609161219.GE6156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 09:12:19AM -0700, Darrick J. Wong wrote:
> > +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> > +						     iomap);
> 
> /me has been wondering more and more if we should just pass the iter
> directly to iomap_begin rather than make them play these container_of
> tricks... OTOH I think the whole point of this:
> 
> 	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
> 			       &iter->iomap, &iter->srcmap);
> 
> is to "avoid" allowing the iomap users to mess with the internals of the
> iomap iter...

No, the reason is that the ->iomap_begin interface predates
struct iomap_iter.  I delayed changing the prototype because I thought
I'd get to the second step of willy's iterization idea and kill these
methods in favor of a real iterator, but that just doesn't keep
happening.


