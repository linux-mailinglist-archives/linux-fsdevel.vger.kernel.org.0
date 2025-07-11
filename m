Return-Path: <linux-fsdevel+bounces-54590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5EB01511
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B071F5A0E5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A231F63C1;
	Fri, 11 Jul 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xjps7REC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830D1F4E34;
	Fri, 11 Jul 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219862; cv=none; b=JtNnD8LotnKdX+gHhXczIBKwU2149Fa+rRgU73OpjG3mFTqZKvcMSrEpYuJVTtIxzD/WDKiygAEQtXXcjLaX70djhz3kL6Ov7bEX0i9VHsy5y8gSoZO1Hitxz5015HED8lRy2XJ0CptfEDcrOzAJb45Y30BHlbHnlx4/NywsWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219862; c=relaxed/simple;
	bh=RB1sFH6b2xQkebBeiQsOerryCg0Aj3zPN+yrOmqcFvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfLvvrKiioRWnAsfCprhRvSjJ241VOgiTdtW5jDohSuRiNjlL1zEHMqHoGAmzTUbxrw8naFkf+zd8w6NYyB1nIz7cVkrSGpIsaToudYiuamtVKKD/CQYWvEo3TZdemDCDCVLkQba5AD4JD0Yil1IlelucuNNNdoDctYQXFYc+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xjps7REC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MuN+Al+ugsSZkiKtnKTZ8BlZNb3ssd//9YQiEWcYVm8=; b=Xjps7RECqthfJ6sxTSYVPLQiwL
	FzRrLdepGyG++mr80FZt1bYSukuJvqWcE28T7MklVGBReJeVe6c+cjEiR/3apon0YHkvo8aielt8q
	2Jj8u5ZxARHYNrRD7yH3T+06pGXoSQ5AbLL4RQSwUe124QQb6uaitby2C1UcIAKGCN1FyCbQop8/r
	Sc/vTm3IZlrTeOS35wdoaqU3fHCpPLc/3ipSbwEAGTyhK6m2Qrn7b/TrJ37UQEF5qhm8nxu82sd31
	kbFATO6xtLxdP72krGpxaIxtONWHCNqQBPSlkIPNECKna64yqGoD8op3+wjeduEja1pJZksxyxWps
	cnDDlHDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8QU-0000000E0sc-16jE;
	Fri, 11 Jul 2025 07:44:10 +0000
Date: Fri, 11 Jul 2025 00:44:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: hch@infradead.org, alexjlzheng@tencent.com, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with
 locks
Message-ID: <aHDAykGCnDXeUZD1@infradead.org>
References: <aGaLLHq3pRjGlO2W@infradead.org>
 <20250709033042.249954-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709033042.249954-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 09, 2025 at 11:30:42AM +0800, Jinliang Zheng wrote:
> In addition, what I want to say is that once folio_test_uptodate() is
> true, all bits in ifs->state are in the uptodate state. So there is no
> need to acquire the lock and set it again. This repeated setting happens
> in __iomap_write_end().

Yes, that seems fine.  Can you update the commit message with some of
the insights from this discussion, and with that the patch should be
fine.


