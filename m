Return-Path: <linux-fsdevel+bounces-21980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C0910990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE73282AD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE11B0132;
	Thu, 20 Jun 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fYrhRgOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83A1B0111;
	Thu, 20 Jun 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896529; cv=none; b=tCrjiqvhS5DEFyDogyOQa9QsQfzJmNTPblEH9l1+seddKE1o4Ua75d6PEPylWvF48cUzpYHk8LjT2B3v7XgxKwS2PqLSgRVV7ynWZFK+QFVOzWzQ77N+le4hcY2xmP9eN5MWjSj9E4lnHZhXtn8xmIodgJOu9SNKsElnUu7Lsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896529; c=relaxed/simple;
	bh=qdPGySHC2EuLBfA8xTbGkh1ktpe7tNvRTRYtm99TJ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnDudiz5po53C4ZtA5rJFq2SLipykfjCZA3RKH8eluVJ1AOh8CUvI44vKYQXxdjm1tqRhnA564Jz+4u+6QBLauk5xENBTOl8cYQUVF084IA6w6T+S/Veq3lbRvU8aPMIH9C4M9e1jFGifsKTBAQ+v2XPMECpsLSNIIKScfEXNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fYrhRgOU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rs1/ZsdMST+bPAaY7dzA9AIoF+wpwBEQ6B64h0WfV/g=; b=fYrhRgOUIyBGf3cl/sXs4N4Gmu
	UzmnYAXuqE7EMvGndDvrci8kbf6lcfvsSkG76qaxT0UJqxAcshK6l2DdN6PU3ZKK+3joqKUfiJpJr
	0fKLxlK2TFyuj9DOp+ludXf+VYkPnDhKfThzp5DATTX2KvgskYbAFVWoVOCgUe4GIa+iUJtqbNgzG
	vjlTl6EyD16b87JutMYkH2SEAYPUMcC3mbC/QyvE1St2vrO3LnnwdKGsZQT3ogW0LB4ucmWxoTrf5
	PZSiCAEsxe3T3KREo8cSdN2M5ZSX67LUPT7YEsshTqNz3anR0d1NwL2xxK903f7vgoR5GHbqC1aSM
	BED37gdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKJVT-00000006BnM-347i;
	Thu, 20 Jun 2024 15:15:23 +0000
Date: Thu, 20 Jun 2024 16:15:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t?
Message-ID: <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>

On Thu, Jun 20, 2024 at 08:56:39AM -0600, Jens Axboe wrote:
> On 6/20/24 8:49 AM, Matthew Wilcox wrote:
> > On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
> > I'm more sympathetic to "lets relax the alignment requirements", since
> > most IO devices actually can do IO to arbitrary boundaries (or at least
> > reasonable boundaries, eg cacheline alignment or 4-byte alignment).
> > The 512 byte alignment doesn't seem particularly rooted in any hardware
> > restrictions.
> 
> We already did, based on real world use cases to avoid copies just
> because the memory wasn't aligned on a sector size boundary. It's
> perfectly valid now to do:
> 
> struct queue_limits lim {
> 	.dma_alignment = 3,
> };
> 
> disk = blk_mq_alloc_disk(&tag_set, &lim, NULL);
> 
> and have O_DIRECT with a 32-bit memory alignment work just fine, where
> before it would EINVAL. The sector size memory alignment thing has
> always been odd and never rooted in anything other than "oh let's just
> require the whole combination of size/disk offset/alignment to be sector
> based".

Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
doesn't know about this yet; is anyone working on updating it?

