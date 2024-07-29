Return-Path: <linux-fsdevel+bounces-24508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9393FE03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 21:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B122283A16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23165374C3;
	Mon, 29 Jul 2024 19:01:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B615F32D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279667; cv=none; b=ohC/5HA0RznDP2ZGw98h5ftgpak1vOlM7sBpCwKSjYIALinDAQ83NIXNnsbHMmufkm/jLFMRCsrbcsQy1/9PX4GrFccpS5XTcheOX1KDjS70hDPrx+CKGi+p5wc+5mwyIy7LzZLvZV73XnwP10kbov+eT28NyYX2TOvw8ALH8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279667; c=relaxed/simple;
	bh=FftxMMFs31qMiL2zDNtZTUbMiSEqtYa/qT66N741k3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjoIlwqckpBjzw0RpmzoD8YsexNLSSVDOOGzCNK+BvTkO1uCeUboHTgx9s7Vvvmcr4rhNqzcf3DYOhFYXsB5aQsBnDZuQBiE64ThgrDrkB3E/oWtwJIbvogeD06ALRflli28Hg1QtBVgUnn1Qz+qHkCpkaL4knqre6Z8dfDaDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5556E68B05; Mon, 29 Jul 2024 21:01:01 +0200 (CEST)
Date: Mon, 29 Jul 2024 21:01:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, libc-alpha@sourceware.org,
	linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240729190100.GA1664@lst.de>
References: <20240729160951.GA30183@lst.de> <87a5i0krml.fsf@oldenburg.str.redhat.com> <20240729184430.GA1010@lst.de> <877cd4jajz.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cd4jajz.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 29, 2024 at 08:52:00PM +0200, Florian Weimer wrote:
> > supporting fallocate.  That's is generally the wrong thing to do, and
> > spectacularly wrong for file systems that write out of place.
> 
> In this case, the file system could return another error code besides
> EOPNOTSUPP.

What error code would that be and how do applications know about it?

> There's a difference between “no one bothered to implement
> this” and “this can't be implemented correctly”, and it could be
> reflected in the error code.

posix_fallocate can't be correctly implemented in userspace, which
is part of the problem.

> > The applications might not know about glibc/Linux implementation details
> > and expect posix_fallocate to either fail if can't be supported or
> > actually give the guarantees it is supposed to provide, which this
> > "fallback" doesn't actually do for the not entirely uncommon case of a 
> > file system that is writing out of place.
> 
> I think people are aware that with thin provisioning and whatnot, even a
> successful fallocate call doesn't mean that there's sufficient space to
> complete the actual write.

With a correctly implemented fallocate the guarantee in the standard
actually work properly.  Even if the underlying block device is thinly
provisioned and makes a write fail due to lack of space in the block
device this will actually shut down the file system entirely but not
return -ENOSPC.


