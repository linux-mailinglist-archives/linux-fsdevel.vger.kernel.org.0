Return-Path: <linux-fsdevel+bounces-50420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE4ACC037
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74C4188E934
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F209263F5D;
	Tue,  3 Jun 2025 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWgNCwE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE9263889;
	Tue,  3 Jun 2025 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932243; cv=none; b=d7S4bVZh625aovo6yb4DC/6lwGi5GUY2+cKBBffEYEKe0oyPYpyL0Nf5VoiJ9mltYWl/7bRx/yk8XM5P3N7CfNkjz3FlYohd7Ke8/UPNTFo2Mmudh+GR8KFFYwghrD3EYjNYNhyHhIyaNCOT9xAsJrMOSI0VFv6Y1eSRwM1QKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932243; c=relaxed/simple;
	bh=FDEQfpXwTpCR60SBCO/dAL0owqh+tbRf9TPzv9VQg5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9NCOlwc0/609SYh2ayAAoHGioZcj9nrBcsy7u1jvht0H2mLzib6k40OStudMRaJdpBfUkyghf9tm5p8adN90Wizs7YtLmxavgui8vYvk7iFnECBW+LxSsNkjKF7oxPh5kPEtHIjWzeO7XQo7GeX4PRF5sxNB1mIc0c0Hm+t99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWgNCwE0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=inR51H2x5eoBKXOJPD6eRxHl9aSfYeeeVuky/06KAU8=; b=gWgNCwE04JVuakBO+UJCq18dpR
	PlY7dkTg0FCXKSrujXhi/puRyBYR0F/fvsnOIptA34f2j6EZ/mQIsAH8SyACp5w73i0GeePiBzwJZ
	UuT9rRPPuclvbvzZCiTbEopsHNeHPKTRwRbPCYKA2Ilmi6jxmjS9+tvA1A8R1SRWLA1kWNrq05LdD
	BFGDyjNO93u6euAIn/YAFBi1iEzEkw1ZwCIUzpZgToSTZFUZDHVMeZwVnHrxyaSjF8m6/WuyY4jTR
	nLM0qQxHNlrJkFdPKwMr35hM0b7svbtxqOuE79XTe8Lhjm+U4oOrXBgdDsi75DzoPFXKTPcHW+0Sc
	OSqK3GQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMLAS-00000009y64-2xFV;
	Tue, 03 Jun 2025 06:30:36 +0000
Date: Mon, 2 Jun 2025 23:30:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, jack@suse.cz,
	anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
Message-ID: <aD6WjAVeSL0tNv7D@infradead.org>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
 <yq1sekheek9.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1sekheek9.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 02, 2025 at 11:12:38PM -0400, Martin K. Petersen wrote:
> As a result, the block layer considers the opaque metadata part of the
> PI but it technically isn't. It really should be the other way around:
> The PI is a subset of the metadata.
> 
> It would require quite a bit of rototilling to metadata-ize the block
> layer plumbing at this point. But for a new user API, I do think we
> should try to align with the architecture outlined in the standards.

As in exporting the total metadata size and PI tuple size?


