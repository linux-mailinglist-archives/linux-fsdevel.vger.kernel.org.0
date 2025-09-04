Return-Path: <linux-fsdevel+bounces-60243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C183FB431EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91450547AA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FAD245014;
	Thu,  4 Sep 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j8BVD1qB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAE1758B;
	Thu,  4 Sep 2025 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965836; cv=none; b=l1hLFa7Pki0ygJjBtvB0M3JUI3GikBe6ycTx3nLgmsczUh+IgAcCNxZoCDY5xnb8LP/YiPn6rhSMOqtOptWsb+dBaBdJr0drkyLGscyuWAsXDEHO+mtpVQbauxUjz5HCn2yaiaxPj/lc2BSQQz7ZwXgvWaIG/+zbZKUonNmKE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965836; c=relaxed/simple;
	bh=+mpwaLTbZlHXtQq1geajFmLeS+Sy/1KblaULrWLi5Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTNWIGmfaI1F1zFxbDcvNERkF8IYFyqkpcwJqUIWTisIQQ5VXGMRYmaFGJC6ZrTGYmejVkceiPTh2v8zR/jrjIX5+6511Z7rBE1LrdIqm3LZDRIpq3vGBsqlaIabs4oGlH/qap0hvmU0BayvtTSJc1DI7STU4zpZoIGmAXR19sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j8BVD1qB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZRIVlZfvIZBOaVHa139osW0AeVY847lyOS6rePTbMsY=; b=j8BVD1qBU1EC4b80OlRFyH3vf4
	H2InSCie3eSefeMX778LIRWr0e8aZmwheYZ/dSKCP/pB0Is2j24aI3s1qOJ3yZmsL7v3GUF6BGt/j
	RVH+v5Um/BKtn6hlb34cT1GKqrA5p0I4VD8R3wtDn1xTZMV+17t9sbtHahPtjReIY3d4hpOQegmY7
	caxQdZkw5zprtn6ycXWkEtPzeaswq75JfwMb+B6ONJqLVCJHp7myHhe3GLr24hgJ0u72auWU0sEPm
	bd5Z93A/JKb4XoyatM0T4JoV6X+QqtT21NNThLq+6NuSjSAm2x6gPqUGeQTicuqpnXoDE+hpW9iku
	FmSSvEWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu34b-00000009OzK-0K5b;
	Thu, 04 Sep 2025 06:03:53 +0000
Date: Wed, 3 Sep 2025 23:03:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 02/16] iomap: rename cur_folio_in_bio to
 folio_unlockedOM
Message-ID: <aLkryaC0K58_wXRy@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-3-joannelkoong@gmail.com>
 <20250903202637.GL1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903202637.GL1587915@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 03, 2025 at 01:26:37PM -0700, Darrick J. Wong wrote:
> On Fri, Aug 29, 2025 at 04:56:13PM -0700, Joanne Koong wrote:
> > The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to track
> > if the folio needs to be unlocked or not. Rename this to folio_unlocked
> > to make the purpose more clear and so that when iomap read/readahead
> > logic is made generic, the name also makes sense for filesystems that
> > don't use bios.
> 
> Hrmmm.  The problem is, "cur_folio_in_bio" captures the meaning that the
> (locked) folio is attached to the bio, so the bio_io_end function has to
> unlock the folio.  The readahead context is basically borrowing the
> folio and cannot unlock the folio itelf.
> 
> The name folio_unlocked doesn't capture the change in ownership, it just
> fixates on the lock state which (imo) is a side effect of the folio lock
> ownership.

Agreed.  Not sure what a good name is in a world where the folio can be
in something else than the bio.  Maybe just replace bio with ctx or
similar? cur_folio_in_ctx?  cur_folio_locked_by_ctx?

> > +	bool			folio_unlocked;
> 
> Maybe this ought to be called cur_folio_borrowed?

I don't think 'borrow' makes much sense here.  It's not like we're
borrowing it, we transfer the lock context to the bio (or whatever else
Joanne is going to use for fuse, I haven't read down to that yet).

