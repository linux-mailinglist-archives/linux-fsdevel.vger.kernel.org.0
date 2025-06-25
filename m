Return-Path: <linux-fsdevel+bounces-52903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFCAE8232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C2E1C22704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D025E823;
	Wed, 25 Jun 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c1h7NXjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492525DAE2;
	Wed, 25 Jun 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852610; cv=none; b=K81o3eFiv2jCDrIeJ0wTUhQ0Sq/yY+BliI7XI6TMnlvGNthVE5n9TKWmA26NBqQyKhjPyKF8zo//gtgDWblnrZNxbpKH9q3Ftft1KoU/yGSIA95b8WjfTie3t544bN9MMX+YqRw6rSJYBOUXKwg7rURQYwGP9DaLrsbZ2ZxeRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852610; c=relaxed/simple;
	bh=4IiB29Mkpr3/3JFJXEKeBcklgYBknhjO6rybRKIDOio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrCYGUExLPembY32lQNXK2Sd0mBfF0Wy5PWoDyD1YEbiwGo353iibjnqrgC0gVOyrF3Zium7shCXcq1L4ZpmS6HF1a6zqoz7xDkDVs+IqsAtoSitDcdaPC3GCqEQDHMdaBkAALumt2aDbc7RZ8UuKDB12TyIs/t3132MhJEMYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c1h7NXjR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4IiB29Mkpr3/3JFJXEKeBcklgYBknhjO6rybRKIDOio=; b=c1h7NXjRkYuG7oEnu8xynJ2OMy
	sQxidBUwVBz7XbPj74iCQBeDnGWHG6FyyELV6tDdoDPHAHeSFmama7EGcydo/ejd0/jT15XldwHLV
	tQ36YRX0uZ22DAtqNirh2r2wY+1qw8UGdVQVIYRPhh+mnwNuvKdqZPSQxLvqM4TZeUvCO3Yzv5GJp
	cXx2VHi2QsIjKmqOL1OgZmE5KMNyefezd1sqnAYUk6eTX6/VHPbz5nM6ZZMiOoZv66Vob6Vpab6Ud
	uOEUP+ZBn/prVw8IJpx17MrG4IB3a0RB7jA9N5XVsCF9b8ejpQoiHVZ4IlmpKDlieg1wBaeBEt6i6
	WU46WL+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOkC-00000008YdD-1gUL;
	Wed, 25 Jun 2025 11:56:48 +0000
Date: Wed, 25 Jun 2025 04:56:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>, david@fromorbit.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aFvkAIg4pAeCO3PN@infradead.org>
References: <aFqyyUk9lO5mSguL@infradead.org>
 <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org>
 <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 25, 2025 at 07:49:31AM -0400, Jeff Layton wrote:
> Another idea: add a new generic ioctl() that checks for writeback
> errors without syncing anything. That would be fairly simple to do and
> sounds like it would be useful, but I'd want to hear a better
> description of the use-case before we did anything like that.

That's what I mean with my above proposal, except that I though of an
fcntl or syscall and not an ioctl.


