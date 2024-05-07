Return-Path: <linux-fsdevel+bounces-18920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4008BE86F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107C51F273DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227E16ABCE;
	Tue,  7 May 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jm+aAaQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32466200D2;
	Tue,  7 May 2024 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098319; cv=none; b=ICzqNN1CaekwnKaakOG5XCoh+8m6vj+6Zc2IHtjkbCgWD2QScgPZrsZuOckg4YtSsIS6G9FrNuj6iTXcyhVx6ZYiJXJqqRKqNcI0S15t8l2R8gop++EDsnNedvAq1kT0sNAH94P9sEeaHR2D7hZGP87b6GXof712fBnDtaTAOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098319; c=relaxed/simple;
	bh=OKQV9eQzIRkDPE8N9Xt2w4elQXhWLS0OJgwXDxmyCLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydc4w+C4B8Tp+xuxTJQCMYGAGGIirhN89b5mH9nQvL8/nAJxmGyUhJDFfWctKJ/zSyM7e6AuHpm3LCFRGfjOTkCzJelcl4N69IEf8DNv/1N4Ymzvq0hLPgxFwquTBC1yV5s6SWoRb6DsJwJGOfUMqd7RHmNnvKHdpAxV/x/EJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jm+aAaQc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gVfMQUZg1wdXjtGTbxuj76HRVAiL9pzO4movtSyOhPc=; b=jm+aAaQcvzxyHGbuXqnxjXzv2z
	S0wDxO05vQ7d/EkP2IhDFxXgzpXrPMODSEm5QNXQo0OKKzN96XIrUldwY1/r6c7ti4ulq3zyVgXL+
	7T7vKFPLCl/VxhfGfS7Gv5nPStwZd6zCG12Rrh7CqLMj2dQv2MRcp+QOcIAfS/I3HOox3LTY9M0M2
	g88CXmkINSESPm6k0RhJDoz8Pc8SISduQr1IO9SeqR03QP66Gdg4wJW1MN0ziVqm4k6i6ExKo1vG+
	K30YQ4EpXsAIHWUxN9lkHP1nkYQ3vCmk6T2Fe4MC7UeV77ItSdcw0cIPBVe3jfPn0y2QfwvCczCUJ
	k5q+ay8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4NPz-0000000BuFy-1Qgs;
	Tue, 07 May 2024 16:11:51 +0000
Date: Tue, 7 May 2024 09:11:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: hch@lst.de, willy@infradead.org, mcgrof@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZjpSx7SBvzQI4oRV@infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507145811.52987-1-kernel@pankajraghav.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> +	if (len > PAGE_SIZE) {
> +		folio = mm_get_huge_zero_folio(current->mm);

I don't think the mm_struct based interfaces work well here, as I/O
completions don't come in through the same mm.  You'll want to use
lower level interfaces like get_huge_zero_page and use them at
mount time.

> +		if (!folio)
> +			folio = zero_page_folio;

And then don't bother with a fallback.


