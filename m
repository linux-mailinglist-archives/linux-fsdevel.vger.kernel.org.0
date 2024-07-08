Return-Path: <linux-fsdevel+bounces-23335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A592AC0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA20728239E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675B1509B6;
	Mon,  8 Jul 2024 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFVtHkX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633D3CF63;
	Mon,  8 Jul 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477665; cv=none; b=PtR4E0+aO8TriNZKHNLIz6h9n1XJN+O9g89EFb8MIsLC73OgnILC3Jr5arGXJ18OipJ1OzhuOBfiG5RA9qL/ce83mh0C9RX71FKUueOCWJ8WsNZaal8KnEaBQmzcXYjZHZKgK0RoK7k1ueXn5ZhYULgQG4b3huEkny8MSSOrKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477665; c=relaxed/simple;
	bh=cdy5zILmTkrtUAEBPhlgJpgFPWVDym+4zvsbx+LMWhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqOvWvCSWVPmOga+5IWzV/PRZe//AOmRji63GWYsa7dnGFXzsYPrS5MdbbhinUarTMoN0tSwwsSzz4Ig8l8Zse6d8/eVrMQddUnExPDl7yeJnjbqJ7YX8VJ5czMmy6T7aBMXLvFUViuBnBZk+Y9O7bg9jNjB3lOiGPF9PN1Y02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oFVtHkX6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BLVcL2EPYuo10mpXkM4Nfciy2mqtNKXtJyWcJeoaAt4=; b=oFVtHkX65Mdb3qO4D7Uvvgsbml
	8c4tUiCT3xY/DCu6RB3bVaMNqlRV+lb2FOXjosFbBJHVAr63YwHbThYh7koJNrDX2lA2R/4+4/WKJ
	w50l+aSFHWR2MaVqLfQxDla7Qkgx1sZP95/6HbgmdGUbwZIW3+E5eLxQlwH4lOkHAYen/dYygSqGf
	NeAl8RqvfW8qi3nWArf+VF7tqCfjuuOysFgIg5rBpTTE96/K8OdxlB3emyGS7kY42LtKZV/Vo2raX
	PefjkiI2QJriZYRUr8oyb7szDRq9rezDOhQVBMMv9dGuS86ryJhKmpDwocNtawGZqsGI2YDmQXUvS
	tVb/IBqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQwpT-00000007EGt-3hi4;
	Mon, 08 Jul 2024 22:27:27 +0000
Date: Mon, 8 Jul 2024 23:27:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Chandan Babu R <chandan.babu@oracle.com>, djwong@kernel.org,
	david@fromorbit.com, Christian Brauner <brauner@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, gost.dev@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 00/10] enable bs > ps in XFS
Message-ID: <Zoxnz7R5EBb6SCR7@casper.infradead.org>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <Zoxkap1DtwZ-1tjI@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoxkap1DtwZ-1tjI@bombadil.infradead.org>

On Mon, Jul 08, 2024 at 03:12:58PM -0700, Luis Chamberlain wrote:
> On Thu, Jul 04, 2024 at 11:23:10AM +0000, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > This is the ninth version of the series that enables block size > page size
> > (Large Block Size) in XFS.
> 
> It's too late to get this in for v6.11, but I'd like to get it more exposure
> for testing. Anyone oppose getting this to start being merged now into
> linux-next so we can start testing for *more* than a kernel release cycle?

That's not how linux-next works.  It's only for patches which are
destined for the next merge window, not for the one after that.

