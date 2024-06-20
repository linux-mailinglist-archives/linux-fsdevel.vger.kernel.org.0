Return-Path: <linux-fsdevel+bounces-21984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3859109E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E459F1F25B5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240DB1AF6B6;
	Thu, 20 Jun 2024 15:30:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244401BF53;
	Thu, 20 Jun 2024 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897458; cv=none; b=Nm8XxuIEHRpgZWhKJ/B/XR7S2APKEnK3xHXcYFctoSLUA2VhYM43+RQRvG4KnhqEovmb+mR5VI+zqkYh2AgplpwSWVUihnzbflmgyn9XuSOiXmQ8Dl+Z5okxB8vGv3Q+1Nz0fUVIuW/UU3CXu3ZJSKU1ZikxRZRKhdKMQI/EvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897458; c=relaxed/simple;
	bh=VrvJ06G5eyLt9+YWrUn5n5B/W/O+ADXafPHzbOVoBYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHTKXqXkuvQ3W8hvZ94SARfWZnuUXjaDSFpHM/VAcrnR1WHE8nXQJ5EeYtS9CqNyvNd8UBEGSf4mflMGKrDIFXw5F0870zFApg5qK6jv6DmZgfDXikM9xQ/8Tmyj71D2P2YD3aKVtkTDDbdQbkcMYkNItEy6xGi0k56co6rnJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9AD468AFE; Thu, 20 Jun 2024 17:30:50 +0200 (CEST)
Date: Thu, 20 Jun 2024 17:30:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs:
 allow direct io fallback to buffer io for) unaligned length or
 offset
Message-ID: <20240620153050.GA26369@lst.de>
References: <20240620132157.888559-1-lihongbo22@huawei.com> <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm> <ZnQ0gdpcplp_-aw7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQ0gdpcplp_-aw7@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 20, 2024 at 02:54:09PM +0100, Matthew Wilcox wrote:
> I'm against it.  Block devices only do sector-aligned IO and we should
> not pretend otherwise.

While I agree with that, the bvec_iter is actually used in a few other
places and could be used in more, and the 512-byte sector unit bi_sector
is the only weird thing that's not useful elsewhere.  So turning that
into a

	u64 bi_addr;

that is byte based where the meaning is specific to the user would
actually be kinda nice.  For traditional block users we'd need a
bio_sector() helpers similar to the existing bio_sectors() one,
but a lot of non-trivial drivers actually need to translated to
a variable LBA-based addressing, which would be (a tiny little bit)
simpler with the byte address.   As bi_size is already in bytes
it would also fit in pretty naturally with that.

The only thing that is really off putting is the amount of churn that
this would cause.

