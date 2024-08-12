Return-Path: <linux-fsdevel+bounces-25674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE294ECF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55E71F21172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D154817A931;
	Mon, 12 Aug 2024 12:28:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B417A58F;
	Mon, 12 Aug 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465739; cv=none; b=BACpes+Cxhqe0hBA+we+Qa3BMnurdr0ELBz48qTlPTV9Ub/H9YA0cPAC7R5OXd3JpiPLK+QU/qxM+BPpriEi9QhcVK1hqRxIv1AuF+XiowPRFR8tPGNWOycAFEFZwBQD3FlfvHWvEmwmyIHxLzhbNKT1xI60nKxvDv5QcEblxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465739; c=relaxed/simple;
	bh=+oM/fXacUeAFiWhVpD0oxVas8Gsc5pSYHPWvfdNeqG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNYq3J8dxRP0c1SVIwxQNGbbHHQKFmoy8zlAOE5yfsuGD6HwUPvcMAg8QtXohAmK4b6sSsiVHyeI6zQgO3RHDRNPgwdaG+mh+SnVbDDY+ELCQ9wfG/PV2rREWqAxC9ERn1akmqfDF0XVj1sp8ikqmw1HDFxFsjWGCuRdWMZr4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 062D4227A87; Mon, 12 Aug 2024 14:28:53 +0200 (CEST)
Date: Mon, 12 Aug 2024 14:28:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xarray: add xa_set
Message-ID: <20240812122852.GA20125@lst.de>
References: <20240812063143.3806677-1-hch@lst.de> <20240812063143.3806677-2-hch@lst.de> <Zrn_J_Yo4-BY-SHc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrn_J_Yo4-BY-SHc@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 01:25:11PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 08:31:00AM +0200, Christoph Hellwig wrote:
> > Add a convenience wrapper or xa_store that returns an error value when
> > there is an existing entry instead of the old entry.  This simplifies
> > code that wants to check that it is never overwriting an existing
> > entry.
> 
> How is that different from xa_insert()?

They do look the same from a very quick glance, no idea why I missed
it.  That's even better than having to invent new helpers.

