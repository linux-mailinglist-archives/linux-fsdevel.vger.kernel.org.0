Return-Path: <linux-fsdevel+bounces-24616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C29415A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AAA1F25275
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D21B5837;
	Tue, 30 Jul 2024 15:47:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFE1B5808
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354455; cv=none; b=nxhjh7f9aBiSdS4UdcGcxn8IaM5PFtd+XRweml0CmlKcaqB4GhOqgAlNzM0jXxc6cg3PbSSt1+0fMqnqbkygxQlVj3XoVj5p+s9FuGBctZFKsuqVOKO984JuISDRC9LD9E3Jepz8E4L8JBJfxXraXdoWmOzG2j1TBlAHEvly1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354455; c=relaxed/simple;
	bh=Wz0tIiSKUxAbvj2i/N9XEudjZOrETG6KxLo8IhN0DoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpdLCi23qOLaYwHKOlC9kugAyyrro71hseP9lmuFQ6lROTAOpOjiBmFeDdaGKHV3Vcjz4wft/gZIc/gr76SjSDA/bHwyhp9zIyOc9xaJsPV7YFZpxFaptfRzXxEnn2Y89smP5XnMz7E7jmYXGYx/6pUyzWepYPe1XIA6teB9n5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B79668AA6; Tue, 30 Jul 2024 17:47:30 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:47:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, libc-alpha@sourceware.org,
	linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240730154730.GA30157@lst.de>
References: <20240729160951.GA30183@lst.de> <87a5i0krml.fsf@oldenburg.str.redhat.com> <20240729184430.GA1010@lst.de> <877cd4jajz.fsf@oldenburg.str.redhat.com> <20240729190100.GA1664@lst.de> <8734nsj93p.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734nsj93p.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 29, 2024 at 09:23:22PM +0200, Florian Weimer wrote:
> Anything that's not EOPNOTSUPP will do.  EMEDIUMTYPE or ENOTBLK might do
> it.  Any of the many STREAMS error codes could also be re-used quite
> safely because Linux doesn't do STREAMS.

Huh?  EOPNOTSUP(P) is the standard error code in Posix for operation
not supported, and clearly documented as such in the Linux man page
(for musl).  A totally random new error code doesn't really help us.

> If you remove the fallback code, applications need to be taught about
> EOPNOTSUPP, so that doesn't really make a difference.

Portable software can't assume that posix_fallocate actually does
anything.


