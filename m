Return-Path: <linux-fsdevel+bounces-61289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950ECB573AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21297AE938
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5902F28E9;
	Mon, 15 Sep 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vbwVVjC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF72280324;
	Mon, 15 Sep 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926453; cv=none; b=uhBAFtfKHA8S7niiF6+A0ZPykgll//0aLHcY+r/gG4aTFJYqaJ1ecrI4kB/RgNKCzrF6hXAHZ3ALF1Xx2sd+0+JijBCiUqXvZSmkTKzMpEATMMG2OqD3mWQRnRkea8Grw4BNCVOnhRz5wt16f+GaY0v/JVz88u55XU7R2Zjbv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926453; c=relaxed/simple;
	bh=3QH8jfxnxiJC5/pA5g969OM6/iyZecl36CeunWruEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSxAGmNYcqGYZVIDAtOVf4qYKKGEAP2e8/aLnugZEYjdvI4QaAXaJNX/BHRkWjqlGkloNS71Y5+ywkRsYNbFaNDAXL4qk3GHvjjIVGjXbxUz6CnXQ3+/VRkykeqjw5p/wSHc/xhBQmgPYlx8vvnKK72TP9X6V4+ILRcFVpwpBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vbwVVjC0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cQJjq47vJz9t6h;
	Mon, 15 Sep 2025 10:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757926447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXYT8VnndAIVnGLP4Y41Pax3Xg6FNmOji9mCCp6RHuE=;
	b=vbwVVjC0GQifCpkzoJjmCtcxRLBNtUVCAYP48GIReoj1rov11buL5yAV3BFe+RcVfXTDAb
	16hE8Ndnqa1dbePbDOZBHFemF8IjWkEVNdaGs8pGKDSu++QrCCI9q5p14OMoBFZMeM6REU
	YGSB9E/d+3ZAs9o58Bv0GzzhV8YzbCEibd3RmJ7wo3PUL1REHaHkaS9DFyhq0X0qK0HKe7
	kzOMt3kWh5uL0+G+wjLY3MCDN1GUczsUJc0pev1x2RvV64CSvIQf6cVQ8Qp+n/AFKqUTe9
	Kx0y8yGZ8F84bpnLjpYS8Me8l5nDQZrXVyP0X7xlK/Q7DQUrnjPD81f2wdoAZA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 15 Sep 2025 10:54:00 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: alexjlzheng@tencent.com, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are
 aligned with block_size
Message-ID: <eyyshgzsxupyen6ms3izkh45ydh3ekxycpk5p4dbets6mpyhch@q4db2ayr4g3r>
References: <vath6pctmyay5ruk43zwj3jd274sx2kqbjkfgvhg3bnmn75oar@373wvrue5pal>
 <20250914124006.3597588-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914124006.3597588-1-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 4cQJjq47vJz9t6h

On Sun, Sep 14, 2025 at 08:40:06PM +0800, Jinliang Zheng wrote:
> On Sun, 14 Sep 2025 13:45:16 +0200, kernel@pankajraghav.com wrote:
> > On Sat, Sep 14, 2025 at 11:37:15AM +0800, alexjlzheng@gmail.com wrote:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > iomap_folio_state marks the uptodate state in units of block_size, so
> > > it is better to check that pos and length are aligned with block_size.
> > > 
> > > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index fd827398afd2..0c38333933c6 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> > >  	unsigned first = poff >> block_bits;
> > >  	unsigned last = (poff + plen - 1) >> block_bits;
> > >  
> > > +	WARN_ON(*pos & (block_size - 1));
> > > +	WARN_ON(length & (block_size - 1));
> > Any reason you chose WARN_ON instead of WARN_ON_ONCE?
> 
> I just think it's a fatal error that deserves attention every time
> it's triggered.
> 

Is this a general change or does your later changes depend on these on
warning to work correctly?

> > 
> > I don't see WARN_ON being used in iomap/buffered-io.c.
> 
> I'm not sure if there are any community guidelines for using these
> two macros. If there are, please let me know and I'll be happy to
> follow them as a guide.

We typically use WARN_ON_ONCE to prevent spamming.

--
Pankaj

