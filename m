Return-Path: <linux-fsdevel+bounces-36047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27A9DB296
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 06:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A9B22FAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062D140E2E;
	Thu, 28 Nov 2024 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHB88Wus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D212C7FD;
	Thu, 28 Nov 2024 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772625; cv=none; b=lf9A7m3teIazZyR+lNaG1DhDCw6IohBY9Tsag0nUykS9pp8RLss5l5BPoaVQb380Yr16Ndiq24cOXDSkcpXWWv8OnGJEX4I8DzBBTuKP9F6uCFldY67/x1m3Fh/7KP3QDqb2MoR0qSAHN25aA60isNIElJC6ICyq8BcPb+IWkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772625; c=relaxed/simple;
	bh=KwOilkyvsWRIg+rSVQRJ19Fkv2nNhKGizjf472lxEeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSLhvdu+QFtHARpOVEt5bVsr95JANYQ5qs8oCUiO3iSiOeMuobz4ag4Epyn5GtsgCCwao82mnnHzAinno6//vNBW/6/EONVEMGtldIHJv4jZBMPW7+7bT7GdAoOmUuEwD6RnIFy9Cg7WAe9h9ymzZXyNK7AxBmoSU7KDevQB4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SHB88Wus; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KwOilkyvsWRIg+rSVQRJ19Fkv2nNhKGizjf472lxEeI=; b=SHB88WushSxBQxj/5ON4lFxtYR
	tfms5WkfuGvdo3JjMsH7iSj5QgIN4oNJdiru1ljGniVmIac+TTSUhmK3iLd/kPzNErN+otaaYgQ8M
	QDFlTYMxWhMB1bkPrxABPGVzjxUIOzp2VNjZn75V6Un72GqvVz6GnWQEr58wYkmDosHqnBviJfUCQ
	vrBtDm8sGgNPvYn+/6be4pxJM7dofCkHUIoQiu4aRYejIE2ibVM1Cgkm8j4nXem3l2HXrUfi3V0Tr
	wFbeJ+XNAi3fik+am5fZaImsYWVwUVldjYV/9WcydkXrF8TZWpSl9adqkXlez27JJ28ltzSHCsl/R
	3WT172xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGXJT-0000000EkGL-1rWv;
	Thu, 28 Nov 2024 05:43:39 +0000
Date: Wed, 27 Nov 2024 21:43:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bharata B Rao <bharata@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nikunj@amd.com, willy@infradead.org,
	vbabka@suse.cz, david@redhat.com, akpm@linux-foundation.org,
	yuzhao@google.com, mjguzik@gmail.com, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 1/1] block/ioctl: Add an ioctl to enable large folios
 for block buffered IO path
Message-ID: <Z0gDCxiv2VLQkCR_@infradead.org>
References: <20241127054737.33351-1-bharata@amd.com>
 <20241127054737.33351-2-bharata@amd.com>
 <Z0a7f9T5lRPO_sEC@infradead.org>
 <c3b1b233-841f-482b-b269-7445d9f541c2@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b1b233-841f-482b-b269-7445d9f541c2@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 04:07:02PM +0530, Bharata B Rao wrote:
> I believe you are referring to the patchset that enables bs > ps for block
> devices - https://lore.kernel.org/linux-fsdevel/20241113094727.1497722-1-mcgrof@kernel.org/

I actually thought of:

https://www.spinics.net/lists/linux-ext4/msg98151.html

but yes, the one you pointed to is more relevant.

> In fact I was trying to see if it is possible to advertise large folio
> support in bdev mapping only for those block devices which don't have FS
> mounted on them. But apparently it was not so straight forward and my
> initial attempt at this resulted in FS corruption. Hence I resorted to the
> current ioctl approach as a way to showcase the problem and the potential
> benefit.

Well, if you use the ioctl and then later mount a file system, you'll
still see the same corruption.


