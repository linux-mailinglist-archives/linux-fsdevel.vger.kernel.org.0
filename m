Return-Path: <linux-fsdevel+bounces-31303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEEE99449F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ECB1F2334D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D486218C035;
	Tue,  8 Oct 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yIVTlqvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB2166F29;
	Tue,  8 Oct 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380733; cv=none; b=Vv9sZZKEBjvwbx+qKSof75eBE/5R9HhSwwJqNEV4PTjAbhS7Y3VPyv3DAZHpAu2s9TEBgNjtF3ugaHQmIQVfiLVMKqxlbrWEE8dZggHxmWKidE4OpYqtqbQ0M0TjEI9GG3B5S0rXKF1uFoP4v2LXBbZhiY6ZyqOW3kQ3ZXjTz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380733; c=relaxed/simple;
	bh=YN2PwNUjfaV23Za20oCoGcvGryIL/LT8jPKhKHdNgGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGGCIbFL7prI2VlFD3WDq83sXFLZzAhkMytLrfWG4Suq2zXmFOSN09oFHXIrGii4QB8eZUWMqtgBYslqgvJQVfXwRtt0zNOX+2zHQDDbYT2GKHADq6qc7kqP1Dk4dfzjLKTPxJVWqjDxqh11TWgPY/44CFmVQOVWfv2+SRXGbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yIVTlqvy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rrGM7mlI9Xc2czdq3tr6zFJJs2zwkNCkLOY6qN7jFU4=; b=yIVTlqvyFccJDrUtQ6x6Fpf1qH
	E2ao2mE0SNaTAt6WbWX1fma6pdkaVsJa5Bk4phz2zl3OjIGitpxCaHy2CV2q4OBC8rv/0yipqItoo
	pKK0nLD0zWyet5/RlpfrcCAnsSyN0uEDZeVqhnaCPlbSu6neocm5DhZQdQvBwQ9nJgeptLLgwJEsH
	TS5Sa9mg79XsrslKiOv42Q5sTelQ+b+/BwZn9kePWd/1nzhOtHIaK+UHKfMIuCrLoeJo9J2Pt3Iy3
	DtPlB8WtGuNTQ9SZ+Ik10zmMBjg4Asi7XHS25hAsMOlZlo15zZR1qYowNbe7h4inROKUS/q+wox+q
	5j12NqJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6mZ-00000005MWq-3E0e;
	Tue, 08 Oct 2024 09:45:31 +0000
Date: Tue, 8 Oct 2024 02:45:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/12] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <ZwT_OwN9MOZSEseE@infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <95262994f8ba468ab26f1e855224c54c2a439669.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95262994f8ba468ab26f1e855224c54c2a439669.1728071257.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
> +		struct bio_set *bioset;
>  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
>  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);

Nit: I try to keep variables just declared and not initialized after
those initialized at declaration time.

> +
> +		if (ctx->ops && ctx->ops->bio_set)
> +			bioset = ctx->ops->bio_set;
> +		else
> +			bioset = &fs_bio_set;
> +
> +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> +				REQ_OP_READ, gfp, bioset);
> +

But it would be nice to move this logic into a helper, similar to what
is done in the direct I/O code.  That should robably include
picking the gfp flags from the ctx.


