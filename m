Return-Path: <linux-fsdevel+bounces-61733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE715B59829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC76D1BC3F18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488231B81B;
	Tue, 16 Sep 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMzwvu/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620D305070;
	Tue, 16 Sep 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030631; cv=none; b=Hz6Wbgc6RRRwwVbDrxPxE7dx3RF+7XbPBcFQVXuXbcqqbVOKP5N1swpRC01yVoKKzxG+OXwd7A6XGOa1OpBFLd6GBIc7OFMhVa4MMU69wHb5nrju9MiuWL/oJvMB2zAcAuNSRCCsfqtzieWHrvUQo4G22ZWdb17T6XF/5qOc5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030631; c=relaxed/simple;
	bh=ynciiF/GJ0aJikUljBkleY/zDmGIO6gPWFO44xgNXrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6pQhW2PTmCWviG1j9p+7JUbqPmYgAhQ5Xfa1bAa8BDqjf8RjU1kMYr6ImIzMIQeLivexj3zjHZFnxs/1WGBtXItUrXzUKvLcq/BiZ9g3Dz1OyojEQZFQ1arMoZVgnT59tyGEBLIiWwujyAX1u5GRPMdnqyrD4W2bjc4lrqmlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMzwvu/J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f1DeyvceXPuj/3OJItCEGCYf7YliZX4BUht4KJTHOgw=; b=JMzwvu/JUPXPvD/+nnObn6neNK
	YUDc+bk7HRl2urXfiXjGuBrdMaVijIe+nh0ZXZo9uThUJjjBmbqxX/4YpVuJoABorpBjfWbwHN9er
	PwBvG+1AU55tOE0CLkfMb/6z2aeVBD4CJQNMvFfp2cTt7p3g5gphYZEhPlZ26bW8Z4hsnXEwDMb0s
	ABmobF68FszSMyzK4hcWtm6zpCQNrFlfALc379lb8LhwxdgX/WujFDVzIk/zhEla7QZL6HMFRahIn
	U08AvJy7H+7x1xYbdJiY1wiDaD0c6Xn1SkZ56kU1FiVkhCupmJgySp7UCcrwD4EhVkUrS71z8+uqH
	Kjw3/BbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyW4h-00000007zSR-0SYo;
	Tue, 16 Sep 2025 13:50:27 +0000
Date: Tue, 16 Sep 2025 06:50:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/2] iomap: error out on file IO when there is no
 inline_data buffer
Message-ID: <aMlrI3IfhtyI0eYR@infradead.org>
References: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
 <175798150460.382342.6574514049895510791.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175798150460.382342.6574514049895510791.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	if (WARN_ON_ONCE(iomap->inline_data == NULL))

Shorten this to just !iomap->inline_data instead of checking for NULL?

Same for the other two.

Otherwise this looks good, and I'd prefer to see it go upstream ASAP
instead of hiding it in your big patch pile if possible.


