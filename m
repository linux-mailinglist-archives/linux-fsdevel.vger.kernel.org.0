Return-Path: <linux-fsdevel+bounces-52845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60556AE76ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F29174C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F421F30CC;
	Wed, 25 Jun 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7ZCT2KO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA9189B8C;
	Wed, 25 Jun 2025 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750832777; cv=none; b=atgD0q6ID4H40qWungqX8QJL/AltxJY2d3BupH5Q5FWHBl6XOPfwXJeI22x2VebECJwIIAjznB2+7ZT0PU8+Alnyz0KqBAvAXGbjHAoKi7WtYuow2p7DQIB3Hp2oMCVCjuyPDPUlVXOw8JMMcC+xnj+N/qG7+3Htmvwwp8E2bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750832777; c=relaxed/simple;
	bh=ZodBrEr46pf6hoElc4B7uA1dFN57Uv6t+cGsWYXR9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzjC+7i1aoUYsUtb2kdvkgBomZFBF5ItGVdDWdAAugru/B40r5kk+ZbVmrR8PV9G3Vx4HLyfcul7Y6HICenv7I8c6K6EwsB4x+bqfnzK2eklO1w+vugU2tJaFJo6aZ/vrXHxW1SReCTct6sgsLHPR2nPfI1LlujBt+oN/5Wwsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7ZCT2KO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3XnnY6mYnsr+cZrq2WIhH2EnyI4e0J3kr1/WKamV2Oc=; b=S7ZCT2KOF1JLrcr+/vCrqCURxA
	23StPBuy1slIcKX1GxPymKkGYWQQieRiGTVpNnYv2b7lbSJcg0/8K+TOD1iZlJZboa3GqrFKzIXYL
	PTY6BJbsbdPDG1EVBiwEebUlzJgaOIo9uBZr3WrbUgPa1hsXsAl6+l5sy9RwN/YCwxGFxmNLqNryi
	M7EZlS0z+vmELvnXbD+CV1jAohc9FrreexgIIhsuRHfiPHSBc2M/q7ZKYCAAFnRlMpSJ7K41HiJus
	pYesNOLCI2AL5K3w6Gmgq8csF4gZJlSRYbaSqQqQyQcbK0yNmiG6UHXaYpNEtr3XO2VBYgTIIJWMF
	/Cds1dXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJaI-00000007ea5-1tFo;
	Wed, 25 Jun 2025 06:26:14 +0000
Date: Tue, 24 Jun 2025 23:26:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <aFuWhnjsKqo6ftit@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org>
 <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org>
 <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 10:26:01PM -0700, Joanne Koong wrote:
> > The question is whether this is acceptable for all the filesystem
> > which implement ->launder_folio today.  Because we could just move the
> > folio_test_dirty() to after the folio_lock() and remove all the testing
> > of folio dirtiness from individual filesystems.
> 
> Or could the filesystems that implement ->launder_folio (from what I
> see, there's only 4: fuse, nfs, btrfs, and orangefs) just move that
> logic into their .release_folio implementation? I don't see why not.
> In folio_unmap_invalidate(), we call:

Without even looking into the details from the iomap POV that basically
doesn't matter.  You'd still need the write back a single locked folio
interface, which adds API surface, and because it only writes a single
folio at a time is rather inefficient.  Not a deal breaker because
the current version look ok, but it would still be preferable to not
have an extra magic interface for it.


