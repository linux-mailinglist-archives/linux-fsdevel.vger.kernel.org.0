Return-Path: <linux-fsdevel+bounces-21375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F0902F5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F4B22888
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD716F906;
	Tue, 11 Jun 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LnBIhJqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6C64B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078002; cv=none; b=FonSSBeaLs1cafrU8YW1PGQBrFG3zy28uLz4Mp4JIskcwR6xMz0Ux4VH59wtsB7jgG3KDZtRG3fWZ+06o+qyoUwMV96xT89wQDRx+tnwy6GdLYZqQRC0+jrYi/ljI8+WRWbmlTkYECyUkJ3ccpCGfhM6NyvVpFkscJyYGqcdrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078002; c=relaxed/simple;
	bh=2ntrev8dXPjqe06DgMPBIjSY8p/6udm5dl5TxIDx9JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDkqfiN/K3SvM9Ak07PfZN2wXsJ9ToFnDG0ASRVpL3IzCKF2pAohDl2FE1Dk+IXHRDWp/PFUDKfJEcfAxKbtvaS1GmXrCoOmD2rhYW4OqH4U/Pw51YbY0KY05s0QHhK9xekCSa9Vv0kOF1stvUGS9pi3FoN3/y2KhAYAOStSFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LnBIhJqd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n/d9IHfWu78EO1GDIcTtmOceUyk/F3La2hG4TYS/w4I=; b=LnBIhJqdJDRGIUWsG6zNmi7CXr
	qhl3BVuHCNfFCVcFRW57Kidp+8RU1dRZsWj9E5z9vE8OOEE4sc4bdx+A9PjuSFPLbkkj4q39SjpH8
	fJtwcvrW4KLPcJBMqqhwle4Hg991tuqkVkrNLQYtBp+ZCRrwdajppnOd+LZb9N4zR1D+xEXmN8uXQ
	8KarQ7yhe5r/rmtIL198YFZF418kKLhvJPMnvp1stLdd8wJmx5vwfNZm07w2Z4wPqGV+4KNwkpK8g
	X6LV0jhA6/yJMUomBcCIt87VceMG8mUeFzs7Lcu+ckLyz6F9rnmgOg3CHmoDhWRRR3RaWs2E8QJ4O
	PlJ4qTYw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGsZK-000000077ZC-3eQl;
	Tue, 11 Jun 2024 03:53:10 +0000
Date: Tue, 11 Jun 2024 04:53:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, David Teigland <teigland@redhat.com>
Subject: Re: A fs-next branch
Message-ID: <ZmfKJsxTz3nwMwrh@casper.infradead.org>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
 <20240520132326.52392f8d@canb.auug.org.au>
 <ZkvCyB1-WpxH7512@casper.infradead.org>
 <20240528091629.3b8de7e0@canb.auug.org.au>
 <20240529143558.4e1fc740@canb.auug.org.au>
 <20240610131539.685670-1-agruenba@redhat.com>
 <20240611081657.27aa51b5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611081657.27aa51b5@canb.auug.org.au>

On Tue, Jun 11, 2024 at 08:16:57AM +1000, Stephen Rothwell wrote:
> Hi Andreas,
> 
> On Mon, 10 Jun 2024 15:15:38 +0200 Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > I don't know if it's relevant, but gfs2 is closely related to dlm, and dlm
> > isn't included here.  Would it make sense to either move dlm into fs-next, or
> > move gfs2 out of it, to where dlm is merged?
> 
> I don't know the answer to those questions, sorry. Hopefully someone
> can advise us.

I would add the DLM tree to fs-next since it's a normal dependency of gfs2.



