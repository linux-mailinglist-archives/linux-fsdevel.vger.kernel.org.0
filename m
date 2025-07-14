Return-Path: <linux-fsdevel+bounces-54805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E32BB036F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC8C189C20D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A16221FB1;
	Mon, 14 Jul 2025 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TAfp2lmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143A34545;
	Mon, 14 Jul 2025 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474122; cv=none; b=hC4HU9MNbksoi4mrC1VrSvvAPeUfmCPn39XB93f/Sio5nxn0QjCQQT6XyvgHu3Kq69P1336LVTlKhsTWIyAhFA4v0DlKgWgD2s3zrOif/sfv0Q4/n+41sVMrc7nBfG/SwQ2aEmzpJN8Rbdy1lAkLWafJIxhgWtDdcrsVlYc0SFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474122; c=relaxed/simple;
	bh=htCJLYk97Hmo5KbFSpDERHO7vHcVVzOLr2OBK0FK8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZITas0GWFNirI1q5p78cS0Okgm4oVQR0Yc4Dx1ifnqiEaLUG6GhMtht60ocpr0PqcVoGU94Ct++b9NVq5ZmK83EQWJhVy7QAM0kNip2hUFBbHwWd8/W2QQozmcOFGwCd616fSipqByaQ1mQg6Y7TNetFJ7HYQuPkHdnBE4PGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TAfp2lmk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=htCJLYk97Hmo5KbFSpDERHO7vHcVVzOLr2OBK0FK8iY=; b=TAfp2lmklI8o+3A0unnD1pQNSq
	8lqFPrx96zjaQF83ONVM/p9+UaCih6ANgYe246IcACJc3qxIsOOItURucS/OESGPaCs4kxllMuiR9
	RJlQm1Hz8wunee2AtW/lallZC0wLCdUTWUYrumZtO305TTAzrfSo7vL0FSm+qRFYNp2krOzHJb1Tz
	A2zxy4McZw8dd+6q92P7gqNgIE9w1Y0+9h1pWYSmIJEArk7MZplrw2xECsM+5RqwB0kMCab5ORMnt
	5u/HEXUvoh47RRyaIqR1x+1Ey6cAgvbFOuwAGye2zPcrUY2lY0Pk6CSaKaRb5L8CXTgKOPZmjw8Yg
	r6NY4aFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCZc-00000001KgQ-0sd3;
	Mon, 14 Jul 2025 06:22:00 +0000
Date: Sun, 13 Jul 2025 23:22:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
Message-ID: <aHSiCH2kQllaH9dr@infradead.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745381692.git.trond.myklebust@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I just noticed this RFC series in the nfs testing tree.

Given that is not in linux-next I guess it really just is for testing,
but if you are interestested in RWF_DONTCACHE support for NFS, please
integrated with the series at:

https://lore.kernel.org/linux-fsdevel/20250710101404.362146-1-chentaotao@didiglobal.com/#r

That adds full dontcache support for the write_begin based file systems.


