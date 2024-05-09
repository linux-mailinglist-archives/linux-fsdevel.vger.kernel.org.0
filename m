Return-Path: <linux-fsdevel+bounces-19189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779CD8C11AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA20D1C21AF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB915E5B1;
	Thu,  9 May 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dRnqPC+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1514B097;
	Thu,  9 May 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267208; cv=none; b=O5XOdSVxE06twBAkvDI3YFwshDWTPJ6U9mLbyeGcoij/0IPHtu3IdFCO1bfYf7J4HDeTF4n8Is7G3FbuOhcWSQWB45FKn5a0VNFNoBxYQoEDEJl5l+Uj4Pi3AU7mw+CLPe2hd6NTkLXksFqwwTpM2j8fAHJfVrwcJO7eZHyMHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267208; c=relaxed/simple;
	bh=x6JHJAdbVrRwR/f2aIKQZAixI0xnklootlO8nZFSZ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImXjWXWhxmW5uVPOpvwTOXrvw13l+irJUtc7462aR+uAuIAdNVyXR4hQJMU0+csWROLcWQ7XIGvOVhZGBJlJVcGJfiFbDLw0gpWOkdL1aSwjItpQkYeB5uGAWdFSUOdpe6kAbJ+52hDT1L1iGgr7GJn9g9SXVsF6MxqWUE5NVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dRnqPC+A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5bGAAussnDq0PNHB0NWRX56OjrRoHTwmKLfsWPNPwM0=; b=dRnqPC+AtmI8x0tQnujQqNDaiA
	KO3XojqLNuWeEtlUmYx3PNP6m1CfmBdlJlqBLLIzqjPbPwkY3ISVoAUKXt3we+gtbTU1fKugH55q7
	OJKgVDgHSYikLOlienPwFCPjk9XYCB5lc6lIXmD1JDil55sHYb0t3Ck5pHFMF43NRRsT5Tw1/Qqe0
	b6GnIRpftuhCpP/32MvAHUG5AwU2K92/ekYWNCz/4ndMqcp5Jif7PvU6mhQDzs62+nhK1L0rRfXkG
	uenNqpl9EmM2h/Zo+uXsEwUK9f4P9iXU9vN53Il/0BsXryrUAP0drB+N9QXFI79I7VluUhKGeaOOM
	PubhICsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s55M6-00000001oxT-1nxB;
	Thu, 09 May 2024 15:06:46 +0000
Date: Thu, 9 May 2024 08:06:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <Zjzmho9jm2wisUPj@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
 <ZjxZRShZLTb7SS3d@infradead.org>
 <20240509144542.GJ360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509144542.GJ360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 07:45:42AM -0700, Darrick J. Wong wrote:
> How do you salvage the content of a fsverity file if the merkle tree
> hashes don't match the data?  I'm thinking about the backup disk usecase
> where you enable fsverity to detect bitrot in your video files but
> they'd otherwise be mostly playable if it weren't for the EIO.

Why would you enable fsverity for DVD images on your backup files?


