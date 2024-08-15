Return-Path: <linux-fsdevel+bounces-26022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107595291B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 08:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BC3287A72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 06:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020E176AC3;
	Thu, 15 Aug 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2b/M4Tny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039C18D65F;
	Thu, 15 Aug 2024 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701625; cv=none; b=QH7YWAuXm4mw5X4LxIRrTv43gg6zAjKfRh40Qh78c8knErm+MmdENHUkC9naEfYkWRt4SLdDp/w1Q1Nt4tX+68CGtjdnsb7NrPt57vT55dyUC+kYjjOL4k1NxlOQRtjekjkGpXCWUxJYXCgHuhFPqjMf6NT8weoqIl6QMc0ebKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701625; c=relaxed/simple;
	bh=PXaelrwKMZ1s8FPCKQRWlrygRpcJAkRt+IzMlQPK1MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdBpI52PP54mvN3bvaSJg+Owqfktp1+W+PKbSbGGLG6kag8eMMHGyieiobz7O3voucdj7nBNhOpoXW4pjWB+nAeCfh4P/178rWQGjePxO0TPXiI+8FxVlDp1BJOXQvmeusueMZQo23y98pYcTCmdx0HRsiBs9XuS6g278JIHs8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2b/M4Tny; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UKze76rDFjNG1UPvsO71YB4jtU6QU6F+FLF+ZvJi74Y=; b=2b/M4TnyjNVuOR1EiBZpdHhQAv
	70rjRE2LW/Kz0/mbCKO2zkOBP1sySP3kmwmsNT7MjBscf+Tbl1rNvjgTy85hQZl5EvetBx2ZCqHfu
	yt/NC2reNdPLDNcwTlYzGpeLYHk03vH5h9P2VBxwE2tJ62QEOmD7ThzlR1C8CpjzUihdGEeEgiIEX
	UYi0xxedstZhmIRGLoiAV2GZ3LTuhoYSYjxId7A0GT12w+55ET3M7SzLunoctfnURx2H/urfWegtA
	ctM9oIujfm2YfizqkerxcnPCrDUH/8ivHIwQEBB6z6LMAGACsYc+QqbJzqI1aqwJiE0b32awhngTd
	CeyvtI6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seTX5-0000000989n-0Yzr;
	Thu, 15 Aug 2024 06:00:23 +0000
Date: Wed, 14 Aug 2024 23:00:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
Message-ID: <Zr2Zd-fjb96D3ZQi@infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
 <ZrxBfKi_DpThYo94@infradead.org>
 <b098d15b-4b80-2b73-d05b-f4dbb5d4631a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b098d15b-4b80-2b73-d05b-f4dbb5d4631a@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 14, 2024 at 03:08:25PM +0800, Zhang Yi wrote:
> > iomap_invalidate_folio when it actually is needed?
> > 
> 
> Therefore, you mean current strategy of allocating ifs is to try to delay
> the allocation time as much as possible?

Yes.

> The advantage is that it could
> avoid some unnecessary allocation operations if the whole folio are
> invalidated before write back. right?

Yes.  And hopefully we can also get to the point where we don't need
to actually allocate it for writeback.  I've been wanting to do that
for a while but never got it.


