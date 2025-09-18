Return-Path: <linux-fsdevel+bounces-62130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACBB85414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F037C7237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26072625;
	Thu, 18 Sep 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X4XMGZ3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4318BC3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205653; cv=none; b=sn9exC1yoDD1NUuxdibS7/sh0rR4YPvyXrkyjoicpdrm/0/R5zXPbyicIYB5Bmrrta/CnR3tspZLuHEiUxxb8/6hput6GdRJSY+JCk2Fn1C2DeTfHrhaHMSL0S67JQxmapJmyzU2UF4VMiSreiwIayOOUCKOY80yxnQrUA18MFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205653; c=relaxed/simple;
	bh=kcSAakDeIC8kEgLaPOeD+QvZpw0Y+7aZ0ITnQX4UOVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwcRhQ7p2vcAZP3yfTcg2A/5+3totfdww48tjgkazEupvlKH33j4/hHpj97zNp0KfNEJ71mqM0mqtLovGoyOIrMR3D+wRs1Kn9CqwuUQdpHORT3NIpIXS3sdqgCcgYwh4qTt/PWbwRhXZCkWValJrJHe/Qfiex2NFfRZJTKLLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X4XMGZ3W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0/7iV/rFLnm5oWLR9i47b1QrWMVx3Bqh3MXTpxaxu0w=; b=X4XMGZ3WWTojsdrmGVzzGCHoTu
	Pfw5o8AZc3x+GTm86XGnjUvpYmgUy/z6svkPiRA0Po4XhG8UNB0Rck2AYWDqlerUajunYpB96QHtZ
	ux2Q9hZ+aDMpMxIjSpvc2SXw3+XpWoYHgie6xDTmVM51WuhuYZmrFTE18jq5wqeF0h35U8nXTAZD9
	pJNLn52wxkb+WsJK0mcFyPrWjLSwWsCeZ8hl54GFLuDz24g32rzTaniCMR5O1Hx4A4fI4lEC0I7Ji
	VcXtaJYFU/t6OPI28XzlKqRo3hT1stw+1tf2w3ROg07XrSY4xS3Tcp9cZxzxgFTiiyD/7RNJBZXFm
	nSLd1s6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzFbd-000000008mR-3UAC;
	Thu, 18 Sep 2025 14:27:29 +0000
Date: Thu, 18 Sep 2025 07:27:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	hch@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
Message-ID: <aMwW0Zp2hdXfTGos@infradead.org>
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
 <aMqzoK1BAq0ed-pB@bfoster>
 <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
 <aMvtlfIRvb9dzABh@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMvtlfIRvb9dzABh@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 18, 2025 at 07:31:33AM -0400, Brian Foster wrote:
> IME the __iomap_iter_advance() would be the most low level and flexible
> version, whereas the wrappers simplify things. There's also the point
> that the wrapper seems the more common case, so maybe that makes things
> cleaner if that one is used more often.
> 
> But TBH I'm not sure there is strong precedent. I'm content if we can
> retain the current variant for the callers that take advantage of it.
> Another idea is you could rename the current function to
> iomap_iter_advance_and_update_length_for_loopy_callers() and see what
> alternative suggestions come up. ;)

Yeah, __ names are a bit nasty.  I prefer to mostly limit them to
local helpers, or to things with an obvious inline wrapper for the
fast path.  So I your latest suggestions actually aims in the right
directly, but maybe we can shorten the name a little and do something
like:

iomap_iter_advance_and_update_len

although even that would probably lead a few lines to spill.
iomap_iter_advance_len would be a shorter, but a little more confusing,
but still better than __-naming, so maybe it should be fine with a good
kerneldoc comment?

