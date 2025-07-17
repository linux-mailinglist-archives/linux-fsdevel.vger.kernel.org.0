Return-Path: <linux-fsdevel+bounces-55241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE5B08BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119E2A4557F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1A29ACE4;
	Thu, 17 Jul 2025 11:43:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B628C01B
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752604; cv=none; b=W+0USXqKLGXFRpbmoYQS9lReT7STCDahU8ahs7quqYB3xHBsop5dGHLmH1bk7KlWfRcdMsORZ/4Rh5nRkbgtXuyAbFJQk8xEyICnveL/vjyEJ7LCfmHHmG67bdrQ0T/GxNpD9Vt8LaqaB5p7WIkrjia6RmwHkhX5E8TZadNeQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752604; c=relaxed/simple;
	bh=tVTYe1hPfC3pXk89rmJf4VHy8PbLnO56N4smH/DHum8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezs7gOVZvU+03GCxtsas/O/GJwq20QAFstR8hImPxR6EKx5VtJQbMoMTvGZe4LDApxk/CqKRQmlUjTp2l4rsXDsGetoUuUoMpGDjZSiSOidOT3GcnnWwfxLsLZFcK+gmoQhGTvMnmgCss82hxtWjP3IRV410jdGrKQqLZ1IulGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D716F227A87; Thu, 17 Jul 2025 13:43:17 +0200 (CEST)
Date: Thu, 17 Jul 2025 13:43:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250717114317.GA18449@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <20250716112149.GA29673@lst.de> <20250716-unwahr-dumpf-835be7215e4c@brauner> <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org> <aHeydTPax7kh5p28@casper.infradead.org> <20250716141030.GA11490@lst.de> <20250717-drehbaren-rabiat-850d4c5212fb@brauner> <scdueoausnzt2gusp2i5yt4nvf4adso7oe3gzunb4j5lavyi4p@xzzmjddppihf> <20250717-klammheimlich-rosen-1868e233883a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-klammheimlich-rosen-1868e233883a@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 17, 2025 at 01:40:15PM +0200, Christian Brauner wrote:
> The benefit will still be there for any filesystem that doesn't care
> about any of it which is most of them. One could also just split this up
> into topics: fsverity & fscrypt, quota likely separately, and then other
> stuff. But we can also just do that later and start with splitting it
> individually.

Having these arbitrary groups feels worse than just embedded structures
with the offset in the inode ops.  Because with more such semi-generic
fields there will be combinatoric explosion.

In general the even better option would of course be to either eliminate
the fields (which I think is doable for quotas), or restructure their
users to be proper library code so the file systems directly pass the
expected structures.  But both of these are a lot more work and I'm not
sure we'll get them done for all these.

