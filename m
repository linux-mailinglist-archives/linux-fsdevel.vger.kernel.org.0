Return-Path: <linux-fsdevel+bounces-51396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EFAD6652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C67B1BC1682
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8D1D8DFB;
	Thu, 12 Jun 2025 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpzvQUCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274281A5B92;
	Thu, 12 Jun 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700579; cv=none; b=QpHUPO6FqNxkpCDvR19tAaZ9/YTwCSvrtgG4TmiPSVkPfPVBOHivXV4XExoofnWu7neENkUKwZMGTuYD6Xud1qmksMdcMGZrNs6HB6LMtL95zqm+9Z+GwK5AqLyKcieZM9lFeLsiU60RuDk2/z9CpNGgQwZSkf+6GRhjki1UkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700579; c=relaxed/simple;
	bh=UslVktwU7O+RBLcks1oVqzu726D8U18Bzt3PyiMDTU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUQ7XQkk+78uqiO8bzWSF9AP7PmIa6+07MSZmEyeybYKpgD6twUTopz4GbKUqkdPZtLdsLqMNKei8gQBVwNt3lzcH4hfHVO51/ZPS/GEltICvLiCGGM5YnkTOI6sdVM+uKvcl4RIlyR/IfCnASsM4/wm8EBuYLEw5s+3sWwbV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpzvQUCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE9C4CEEA;
	Thu, 12 Jun 2025 03:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749700578;
	bh=UslVktwU7O+RBLcks1oVqzu726D8U18Bzt3PyiMDTU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpzvQUCQH5Rm9CTAgGM8tvClbtdmZwQB/+Vvj/275Ox6mmZj1xOLeqB1QRsJwAhdt
	 IDtQyrMZIEsdA/kQVoQEFESvRhf0+J2UfAvJA6fIpFhUtavfHVnNm1jFnzfsp/lnaE
	 yU5y9g2dtIVjNUky/OChjqszE6FKWDsUVuUr4BWljhJJCQccDQ5746W2EdYMvOH8ft
	 xiaRJDjGCl1HaZ1YYzTmlguyDuVNwZeL8FFndmqHalQGZv1vpGKV4jQG04U7cEFRe3
	 LZ6jkM86Y0b5O0ctlev/Ciqfd9wHc5ygoF2E0dIzwmJ7qQGA9c94/As4G4ogN2YlQi
	 X7Enbp/7TdSZg==
Date: Wed, 11 Jun 2025 20:56:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM
 iomaps
Message-ID: <20250612035618.GJ6138@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com>
 <aEZx5FKK13v36wRv@infradead.org>
 <20250609165741.GK6156@frogsfrogsfrogs>
 <aEerRblqiB-h8UeL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEerRblqiB-h8UeL@infradead.org>

On Mon, Jun 09, 2025 at 08:49:25PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 09, 2025 at 09:57:41AM -0700, Darrick J. Wong wrote:
> > > It might also be worth stating what you don't use.  One big thing
> > > that springs to mind is ioends.  Which are really useful if you
> > > need more than one request to handle a folio, something that is
> > > pretty common in network file systems.  I guess you don't need
> > > that for fuse?
> > 
> > My initial thought was "I wonder if Joanne would be better off with a
> > totally separate iomap_writepage_map_blocks implementation"
> 
> I think that's basically what the patches do, right?

Yes.

> > since I
> > *think* fuse just needs a callback from iomap to initiate FUSE_WRITE
> > calls on the dirty range(s) of a folio, and then fuse can call
> > mapping_set_error and iomap_finish_folio_write when those FUSE_WRITE
> > calls complete.  There are no bios, so I don't see much point in using
> > the ioend machinery.
> 
> Note that the mapping_set_error in iomap_writepage_map is only for
> synchronous errors for mapping setup anyway, all the actual I/O error
> are handled asynchronously anyway.  Similar, clearing the writeback
> bit only happens for synchronous erorr, or the rare case of (almost)
> synchronous I/O.

Heheh, my brain has gotten fuzzy on all that pagecache error handling
changes over the years.

--D

