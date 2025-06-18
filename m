Return-Path: <linux-fsdevel+bounces-52003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E1ADE2BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE002189BF3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818751E98FB;
	Wed, 18 Jun 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xRnL3Qcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9613E02D;
	Wed, 18 Jun 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750222034; cv=none; b=D2w1JAHVc7lFH5A8oi6fVWC8OsrHSnCU8jRURZAbabYzqCezm8Nnz8SIJ489O0mfLdmGiNP468yRIpa/g771RPDQPLcZ6gsmlS6cehsLlJv+1DN3USEyaQnnhVEjp0nuTJbp4vo1wmv8YSHp0ybezasxiCxsonqMuySy6WSFTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750222034; c=relaxed/simple;
	bh=Hex2wf7cguz9O50FQk21t8Ar4bJrCkM5W2V/d1UWNX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFpB5TCUu3nZwvFUSuNNorFxtGmjFMCtd+sSR2ShjUdGhqPqM+A6ilmTr5WLRJ3OcnysZD2rE++hFKfdHL2bvpqBxnS49/AThrVdGnnDBjrmD8HmN+2E7NeW+H/BW/LL7OHtDIh9nZuuXu4vWRtpOnG1a8V/iDlakMQvtLnw8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xRnL3Qcl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g0EyjvhAS1Km3yCILzus7ZZgUkl096TgjUz70d73o+s=; b=xRnL3QclCBTneZxyRvOQKeoAJw
	WFWsJRoUO17O0yPeqzV/lXobZwMedKmPqKiQuYYY/W8cjidH9cYQY9TknREFhB54Vln4cAuuaKrfI
	uQjqMorruhedHG2gDmZX9BdhJd3vPxGvK2HtGafdCxzVjwEkeHx/43ybyiXUanAUfCPTmO3jkuyOK
	5WhZZejGs9FW9D8WEgSExF1Ca5NH5e9O7YFWgvEhEdZP8vciOyUNIhjHY5qHFrx1ytDrCeGMMHXeH
	Nfi7EwG+OfK2fsKFiKLuxkUYgb9gv1LvvvVamBLUrYuz3aY0LyurBJEtxBE9vbFV9vu1W+bcwpKHH
	w9wZMM7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRkhc-000000092bR-1D3q;
	Wed, 18 Jun 2025 04:47:12 +0000
Date: Tue, 17 Jun 2025 21:47:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: does fuse need ->launder_folios, was: Re: [PATCH v1 5/8] iomap: add
 iomap_writeback_dirty_folio()
Message-ID: <aFJE0L6P9LlHobIZ@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEkHarE9_LlxFTAi@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 05:34:50AM +0100, Matthew Wilcox wrote:
> > My memory might be betraying me, but I think willy once launched an
> > attempt to see if we can kill launder_folio.  Adding him, and the
> > mm and nfs lists to check if I have a point :)
> 
> I ... got distracted with everything else.
> 
> Looking at the original addition of ->launder_page (e3db7691e9f3), I
> don't understand why we need it.  invalidate_inode_pages2() isn't
> supposed to invalidate dirty pages, so I don't understand why nfs
> found it necessary to do writeback from ->releasepage() instead
> of just returning false like iomap does.

Yeah.  Miklos (and other fuse folks), can you help figuring out
if fuse really wants ->launder_folio?  Because it would be really good
to settle this question before we have to add iomap infrastruture for
it.


