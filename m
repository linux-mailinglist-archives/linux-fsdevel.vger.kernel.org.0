Return-Path: <linux-fsdevel+bounces-34184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649C9C3827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC7D28134E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863A149DF4;
	Mon, 11 Nov 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IbsxWwUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE12914
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305027; cv=none; b=KAM0tKMyTXvUApg9I53nQioihdFkwSd4KUk4vl4WFmLldEbet5yQ1/olRRgGKzreb73zRzAYFnvR4TFS6CsX9h4fxbw1XFVKMeIS6LR5dk1Boyls2eBOVZJ7KE7NN3OUwH85NJYhQqxzQWuefeQou6AqSI/1gCumRCAE1Gl+yjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305027; c=relaxed/simple;
	bh=dvMnsW8OMh4zdj+vcPzJ99NiPqGAUQ/9mGbYqvPeOz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=insPPuN6RnB6xx4cBwlluLyIfhEcVwiV46pSPYTV+N45q7/AmigwuX5fjrEIKqkZcUyWgf3kkV+P462/trGsf5rJVw6A2pbigHVI17TvjR+UENTCM1VBodKComMmsP3Eixac/8waZHL9/OA3YfwH8NCh2LvZLoMtz4YZWSOZMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IbsxWwUe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K3U8rRBsGPA9Mox0HnDcP077Q2TLx6QcaizVgZU6jEI=; b=IbsxWwUePwFVcBGmKstBMcKg78
	gCCtGGrN8+nlNvkYR3Ev0a2jr71xXnxykpiUeRvuujpXYFSyZ63WX6WNiSi7HU+ADcTUPAPRVwP6X
	/126Fp2kvDv02rKlivZC1rzDZCVtXINTJ+/lDmzaH/LiN4HwgEQ02hIlCbl2QTG5RAqoxpW+LeP5n
	VWx30Zr+9yPBXTz2dkNq/8lZOXu5grNNUYiv35FkszMwMsEOy74Kynrdu02PFWvxUHrwP+mfBwhW7
	pU77akPaEvaw1X1TXbLvDJpX+jJ8pNjD+pchXxMo0waDreI2YdUGeqBJCZHNagQpXWErKzP9q5yVN
	7MwfAxDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tANWa-0000000GRmY-3HH5;
	Mon, 11 Nov 2024 06:03:44 +0000
Date: Sun, 10 Nov 2024 22:03:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <ZzGeQGl9zvQLkRfZ@infradead.org>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 08, 2024 at 07:42:44AM -0500, Brian Foster wrote:
> In preparation for special handling of subranges, lift the zeroed
> mapping logic from the iterator into the caller.

What's that special code?  I don't really see anything added to this
in the new code?  In general I would prefer if all code for the
iteration would be kept in a single function in preparation for
unrolling these loops.  If you want to keep this code separate
from the write zeroes logic (which seems like a good idea) please
just just move the actual real zeroing out of iomap_zero_iter into
a separate helper similar to how we e.g. have multiple different
implementations in the dio iterator.

> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		const struct iomap *s = iomap_iter_srcmap(&iter);
> +
> +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> +			loff_t p = iomap_length(&iter);

Also please stick to variable names that are readable and preferably
the same as in the surrounding code, e.g. s -> srcmap p -> pos.


