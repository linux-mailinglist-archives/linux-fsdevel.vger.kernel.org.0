Return-Path: <linux-fsdevel+bounces-25716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BD94F713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 21:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC33282220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4C18E764;
	Mon, 12 Aug 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zlk31/Pe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E8187356;
	Mon, 12 Aug 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489367; cv=none; b=ty09e4bqDSLYh+eOvhUb2HQgKzU5Z6ZRoFSymFqSgpFEM7IaXA4246toNZ4iDhMuYj1CwsTNlkjjt/LapolKFqAbwRxJzOVz/ZsW8aXTqb1SxFaklGOgBHV1Bg4+K6RSeDVTLKEj/i/ty4FQiU6AEIEO/cPDirg3AHGIaZGlafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489367; c=relaxed/simple;
	bh=ezMmUg7mHTwVHN5XujxTb1haTuUKj91GEz6kSdHQPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClL6wmZydoefitqePRCx2YurXieFRAgg8uEMTfHgbH2LQarhnlfkZROtf74FQfjjIk/zfvilikkhfnjfwv/1/FfedcHcpLcMWeSD5i2qlDeDsGDmWDJiLT9YQNFWn1tf8tjcNVkQN/vFaNuSY4ktHmOhyKOfK33VInuD8Vl5kTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zlk31/Pe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GpykWVB4jVqd4iXL28CO+MJFswhu6BiB100HaYD/b6k=; b=Zlk31/Pe8Ro8nKwrfBAa6P6ZGz
	BItQl+tCoekxITYt6NKsWG7r6hZOMSw09ROtD5nH7FuRBegXhcxOuTFOe4qAjI3FtrSvXGwSw7aWU
	SBw27vNuOfCPJJpQXfbr0AKv+VARznrJaDyn6hXi14YXmUbn4KN0EdsdcHzfv+4j36Sdb39JivTJ+
	kGjNLkCOt/QPbHpSjnitU78Yt2rpiHsSEYNRtzGzSjvkV048RnPr0NTRoTXoxqp0VK3kLlpSDjFXe
	gNLlaf3HZB1DNWZlM9Jti8hbPm2czNP75GrfI3aF2GHbevhRd+M+tU3/4SJCL5IpDMCOQpGf1u4bZ
	M5m8/cvw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdaJQ-0000000FPkA-2I3C;
	Mon, 12 Aug 2024 19:02:36 +0000
Date: Mon, 12 Aug 2024 20:02:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <ZrpcTAuJFSzE4-nA@casper.infradead.org>
References: <20240812063143.3806677-1-hch@lst.de>
 <20240812063143.3806677-3-hch@lst.de>
 <20240812163956.xduakibqyzuapfkt@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812163956.xduakibqyzuapfkt@quentin>

On Mon, Aug 12, 2024 at 04:39:56PM +0000, Pankaj Raghav (Samsung) wrote:
> On Mon, Aug 12, 2024 at 08:31:01AM +0200, Christoph Hellwig wrote:
> > diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> > index 7e80732cb54708..5efb1e8b4107a9 100644
> > --- a/fs/xfs/libxfs/xfs_ag.c
> > +++ b/fs/xfs/libxfs/xfs_ag.c
> > @@ -46,7 +46,7 @@ xfs_perag_get(
> >  	struct xfs_perag	*pag;
> >  
> >  	rcu_read_lock();
> xa_load() already calls rcu_read_lock(). So we can get rid of this I
> guess?

Almost certainly not; I assume pag is RCU-freed, so you'd be introducing
a UAF if the RCU lock is dropped before getting a refcount on the pag.



