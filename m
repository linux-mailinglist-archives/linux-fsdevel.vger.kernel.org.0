Return-Path: <linux-fsdevel+bounces-25875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539389513DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B4F285223
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DD55894;
	Wed, 14 Aug 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tb7nJYp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEF10953
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613064; cv=none; b=CiaY+q8rxpRIyP2+C1p7P5x6na6pbb1/9sakJ23NceUHc6CcFFJ6EaY/1hnrmYrgGr42A3UE7bBYXdTk7QoSl+9xY4JAPiXEY7JX9EGrIZuQwM4iqM/unlYCeffDyQ5DnaoagzFwg9x8fXHkVsAZQA1MWPmyiZDvU5FLU4feVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613064; c=relaxed/simple;
	bh=Fg55pNVbtWMpyOczp6AD44cNkscHBEgaKTilvkLr50o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKE1IAzktS7VZysHAntdvI8nb4fDHL9TMl4mPsmgLVXMR0Rzr5blwOq07AHNgJZE09TehmPI98QW/FKI5Fe6MdJthgEbRiAOp3w6y8EcmmUOPaX+YVloZtoDd/Vjqak0fWH8MOjFWYd+Dg23Y7IRKNS2p8bZRzwrF6dA15HDRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tb7nJYp0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YtGli/qwsKnpfvyTqwkhaTjpFa79AO0G8UUfN1W/xSI=; b=tb7nJYp0FTmqAlbqxBJivVrXdj
	4obYfqa1Ddwr2TlS48jqiSlhoBJQ7R87ElLyAEbQq0hjY9Ub7yHDSg5lIz7dhrDGOvO6AtD++vaPC
	ABpanMbwD3KLRxWScfPhyaZvOQdhC8fy4fl+na9Ee2j8Qn2iQU6S/YfFHvf0S+bPL/qyPTwcLIQ5S
	sy/85FArFjVCIHrlAJ/TSF5qRBmTCiRP8JTdszEngGH92SqLEPE6obw/aeRnlQRk5IZVLHHghnxxr
	euaRC58SJb9vCZJz891WYtJcaNWPAguiRwcZLDmSDdFzht4g8d/pxy+W6MjlnhEx7uubKvKDTbm/f
	BugAn78Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6Uc-00000005nMv-0Kva;
	Wed, 14 Aug 2024 05:24:18 +0000
Date: Tue, 13 Aug 2024 22:24:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zrw_gtZvaFvl_pZZ@infradead.org>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <5evd6n5ncanmyc2qtjpb44bd76xj7icitdf3g6xeb2eiofh6ht@eqm6r2ch4b3l>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5evd6n5ncanmyc2qtjpb44bd76xj7icitdf3g6xeb2eiofh6ht@eqm6r2ch4b3l>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 12:48:26PM -0400, Kent Overstreet wrote:
> > Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
> > and thus will lead to kernel crashes.
>  
>  No different from passing GFP_NOWAIT to mempoool_alloc(), and we're
>  trying to get away from passing gfp flags directly for multiple reasons
>  so we need it.

It is very different.  Passing GFP_NOWAIT to mempool_alloc affects
the piece of code calling mempool_alloc.  Setting a GFP_NOWAIT context
affects all called code, i.e. all block drivers under the file system,
and possible another file system under the loop driver.  And none of
them expect the consequences of that.


