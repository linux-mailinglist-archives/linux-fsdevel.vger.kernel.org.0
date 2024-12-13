Return-Path: <linux-fsdevel+bounces-37267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D89F03ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 05:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B40282630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F616EB76;
	Fri, 13 Dec 2024 04:55:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3F63D;
	Fri, 13 Dec 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065717; cv=none; b=dBGmCPvmSE8ru6dNoVCximwVdtnnagjIRnjEWzHUfkzbwuBM4jVKT3ocoN++dkQwppWeycHu23hVCqGwKOe9jMlHJXonPmWJTdBFdhkX/y9uziSacHaUlGSx1DxFcIlQPnW9qfdvIzJSVIVeDapE3eHBRgl0dv1TzxEv+3KrskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065717; c=relaxed/simple;
	bh=npeDeMXOygjN6+EbXuzClkCyHI5n9biRzodrHjCt4C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJcOOudBw4dOhXl9xWgiBkA/Z7gIE/n94GUb00RyCw7qPFWQoX0AfaF/DAAWoLbeiyiZvchGUaZUZuZDmr5wbt6o9SXnziWht4akDdjecm9gzIELVZxQKXZKmrsfkIP+CZJnnGF003v+2Ek3chSGaZKpJNOWSm11v2lWO/lQvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18D0E68BEB; Fri, 13 Dec 2024 05:55:13 +0100 (CET)
Date: Fri, 13 Dec 2024 05:55:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/8] iomap: add a IOMAP_F_ZONE_APPEND flag
Message-ID: <20241213045512.GG5281@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-4-hch@lst.de> <20241212180547.GG6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180547.GG6678@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 10:05:47AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 09:53:43AM +0100, Christoph Hellwig wrote:
> > This doesn't much - just always returns the start block number for each
> 
> "This doesn't much" - I don't understand the sentence very well.  How
> about:
> 
> "Add a new IOMAP_F_ZONE_APPEND flag for the filesystem to indicate that
> the storage device must inform us where it wrote the data, so that the
> filesystem can update its own internal mapping metadata.  The filesystem
> should set the starting address of the zone in iomap::addr, and extract
> the LBA address from the bio during ioend processing.  iomap builds
> bios unconstrained by the hardware limits and will split them in the bio
> submission handler."

Sounds reasonable.

> The splitting happens whenever IOMAP_F_BOUNDARY gets set by
> ->map_blocks, right?

The splitting happens when:

 (a) we run out of enough space in one zone and have to switch to another
     one.  That then most likely picks an new zone, in which case
     IOMAP_F_BOUNDARY will be set
 (b) if the hardware I/O constraints require splitting the I/O (typically
     because it's too larger)


