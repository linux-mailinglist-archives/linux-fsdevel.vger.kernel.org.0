Return-Path: <linux-fsdevel+bounces-30837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395C98EA50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AAC2850C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A673126BF7;
	Thu,  3 Oct 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3B1S+CX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30084A39;
	Thu,  3 Oct 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940291; cv=none; b=TQyRhIEdEXpv37Qnwpx40q9OrYqOIN6zPp2zA9jx28d1hb8nic5BYcx3ZJCKWoJ6wuS8E1O3BwRa1cAYdH5wY1bLGYv2H2al5yvg3fqeZnQe4LI0ABfSAOQChmYpKjcN8mrwypv2TWrv0wtM0d4UBr+o8GttNJHeyEiltLipL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940291; c=relaxed/simple;
	bh=3buJ4JD2acvezDrZZAGG2ll4OgZwe2xh3VsT06DSciY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEC45JquOxUGGDAlULEO+SAkHjcgMdO3FcVueTLOlRh/UmiRs837MDMDbY1t57vtb5xLDzdM4YfQMNoRKFegejShoyT12FaI0mDRLueZ9z0EUip9iu5OVaWeRHdVlL0KFQRMtmCwTmIYqpaFuloTFKDk/EXZtNmabyBmst8K0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R3B1S+CX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o5kRDgSsvWk+/sNFl+lWhvp9gKWS31UJ/juY/nCk85w=; b=R3B1S+CXCvRbMsHjdR7UATIQKJ
	bd+UTeRhF5W9DDAmHWwS+cDYsqWHqR7605MHb9bcqTcTMpUusRetV+o7uWULKSoBniTg/wGja6EML
	UtkNKFjlZg+is3UbZfhSxYjxJQYe8ua+R5nd8Kv9ixouEvq2QuB0I9qBibNTg5bvXTmugZiWIFXXy
	GYm2ekDJuWJYTBWDVJeMPRXClORa9WYHoTVY1MjKZOY4xq55vK/qFGNq2DxURcTL8xezgJiAPIVJO
	zNt+blEycKnDztTIbcqGaX9JATt9NwaBGik8K3idmmSIsIfhFPqsF72mDXLLtYml8h1RBlid/5kex
	DyvwegiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swGCf-00000008OAz-1d5L;
	Thu, 03 Oct 2024 07:24:49 +0000
Date: Thu, 3 Oct 2024 00:24:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 5/7] vfs: add inode iteration superblock method
Message-ID: <Zv5GwaDjkSC7Rv1Q@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-6-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-6-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 11:33:22AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> For filesytsems that provide their own inode cache that can be

s/filesytsems/filesystems/

> traversed, add a sueprblock method that can be used instead of

s/sueprblock/superblock/

> +bool super_iter_iget(struct inode *inode, int flags)

Can you add a kerneldoc comment explaining this helper?  Including
what flags is?

> +{
> +	bool	ret = false;

Weird indentation.


