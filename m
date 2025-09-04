Return-Path: <linux-fsdevel+bounces-60245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E3CB431FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E971BC7FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F77C24635E;
	Thu,  4 Sep 2025 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="waSjbf23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330431F61C;
	Thu,  4 Sep 2025 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966035; cv=none; b=rCXPVWcBbczMl2x4PUFC4rbzcrVWHGR8Dan4//8fiJWXQD74ZYu5eyZ+XsGBAsHV7JcG4ioTKJlldbmYEF+Ue3tSBRi5eMPK2oaTV0XkKN5ozodtpsp9/qus3iZ0rJlPO7muhMGnJgizfzjGk24trftp7WUrR52hW4VXVMcwWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966035; c=relaxed/simple;
	bh=Vyop7jWl/p8keoF6jRhS0WjLIB3+VJOrR+Eh3hutuEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5VZkxSYkFotbEZjd3raJ4oMVdJvie/PM1mus4kNTZfFxEvmEA2Ui3n0H3upYaQFXhEOODB19pYqBODXyWoX2Ov1FHcAu0yNj/+u+9XHMOvmnXtSTen5Fo5cBanzWUnlMPIwEIw6H+UFmFgUbFDnbr/O6rUTtwpr3hFIGatU7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=waSjbf23; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=owWE83gVW4qgSId7PwU0Efw06MYvwmQjpEHoUrndmiA=; b=waSjbf23Xu7GkZnyivL0LFB6Pn
	3M7wyXJtd5nPYDWs/mvT9WppMPGm7n+4VmpnNLax9ng6zZ4uSqxbTLi2YebEgotu/Femzqnyh3aY8
	ax/83KRnp3BxoJgtwRWw79KiRjnrUtmxnQJgwY6CSqjEAuU/WBdeXCTedvxfxGOkn8b69lYu8N0Jr
	cm7okEGo7l+w3fQOUY9zLpNvGm067uaFFjjxwE2xDnRSI/OzS2fptGOUEZC8zC61go4WjmQrlQORd
	Ee4UFACZ9czn3iWZDZJ8zvb6/7QwiRVjjFHuIT+d6TJCXebkbneewrKYH7xQLIw2B6FXLJEenXko5
	vPn5vJlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu37p-00000009Q0q-3Ju9;
	Thu, 04 Sep 2025 06:07:13 +0000
Date: Wed, 3 Sep 2025 23:07:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 04/16] iomap: use iomap_iter->private for stashing
 read/readahead bio
Message-ID: <aLkskcgl3Z91oIVB@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-5-joannelkoong@gmail.com>
 <20250903203031.GM1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903203031.GM1587915@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 03, 2025 at 01:30:31PM -0700, Darrick J. Wong wrote:
> On Fri, Aug 29, 2025 at 04:56:15PM -0700, Joanne Koong wrote:
> > Use the iomap_iter->private field for stashing any read/readahead bios
> > instead of defining the bio as part of the iomap_readpage_ctx struct.
> > This makes the read/readahead interface more generic. Some filesystems
> > that will be using iomap for read/readahead may not have CONFIG_BLOCK
> > set.
> 
> Sorry, but I don't like abusing iomap_iter::private because (a) it's a
> void pointer which means shenanigans; and (b) private exists to store
> some private data for an iomap caller, not iomap itself.

I don't think we can do without the void pointer for a generic
lower library, but I fully agree on not using iomap_iter::private.
We'll need that for something caller provided sooner or later.

The right way ahead is to have a void pointer for the I/O-type specific
context in iomap_readpage_ctx, and then hopefully reasonable type safe
wrappers around it.


