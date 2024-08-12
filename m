Return-Path: <linux-fsdevel+bounces-25694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B0594F36F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035F81F21AF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980C187339;
	Mon, 12 Aug 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIkBzGXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8C1494B8;
	Mon, 12 Aug 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479464; cv=none; b=ad+qvFtBnqoFYf/FsuT5vJZpGI2Ro7s3DV8v70e3AHS3/8kAOXtbUS2E9MGTARa2UP1QX9MFHWG5lINFLozcwBnf9V3RgmbEG1trgQWToVO+Gx+4wsGwcEHtLAfHX+KIBr9Q0xDsdUGAidxtFghvdOL1lG/uncNhzJoWTiOLQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479464; c=relaxed/simple;
	bh=7R5c1eMCr/6z2xYSUjeH6AxoG759aZEFmcK93H+21cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzYVPZA8iprb/e1vUvsgLYPcT1IM0KEC/g/ckHI553kE2afuwhfQ9+VMAlLQ8//30ivcFxUqf6Xte6NjLT2vg+SKkXSxpcpx4joGQnctYua/PRlVhLkFtp3lidYKZx+STq1sJCsqVDzgtu9lfTes1tOxka0ODUHugymC5Lzvhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WIkBzGXZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N7aCcDiKIS+MySFqpIVpCsULfhItKTEnI07KV3d+/MY=; b=WIkBzGXZkYyYDeMAbGOQoXfJ7l
	8+BmLqzldi/Q8tkOzF8Ae1alUdZOtwC+/T6aI8/St7Tq8oHhfHIZxla6lnjPZLL/1Gmm/rn3p333u
	0a2W2kT7YFqPrU5NEuVeKc64X57XV2Zbd66/WlRUHS6H3nWsyZh/1ajV4ZgeF4j2X1YjgbLEQj3cu
	zx4lHSEE9ksJggblX02ZNnPahfBdnqPPPjutAJMbvs0Epcfh6RBXP368TNzoSXrhrbEqohQvktSJ3
	nhdvuAwnWkt0xhZIRvmmfzwqBPhTwovJFSaWziwkY+sC6gZO02LdBaZtuSojB+RPLHrAVUZNdMpUL
	N1la7oyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdXjm-0000000FF26-3eGP;
	Mon, 12 Aug 2024 16:17:38 +0000
Date: Mon, 12 Aug 2024 17:17:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if
 prefer_busy_poll is set
Message-ID: <Zro1onXfGkKoIRbY@casper.infradead.org>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-5-jdamato@fastly.com>
 <ZroL54bAzdR-Vr4d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroL54bAzdR-Vr4d@infradead.org>

On Mon, Aug 12, 2024 at 06:19:35AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 12:57:07PM +0000, Joe Damato wrote:
> > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > 
> > Setting prefer_busy_poll now leads to an effectively nonblocking
> > iteration though napi_busy_loop, even when busy_poll_usecs is 0.
> 
> Hardcoding calls to the networking code from VFS code seems like
> a bad idea.   Not that I disagree with the concept of disabling
> interrupts during busy polling, but this needs a proper abstraction
> through file_operations.

I don't understand what's going on with this patch set.  Is it just
working around badly designed hardware?  NVMe is specified in a way that
lets it be completely interruptless if the host is keeping up with the
incoming completions from the device (ie the device will interrupt if a
completion has been posted for N microseconds without being acknowledged).
I assumed this was how network devices worked too, but I didn't check.

