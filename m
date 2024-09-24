Return-Path: <linux-fsdevel+bounces-29930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A3983C88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE60CB21845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F753370;
	Tue, 24 Sep 2024 05:55:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95E1FB4;
	Tue, 24 Sep 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157340; cv=none; b=NvVOjoF0iu9GNgPHADtua4BXJqRLz4fYF0lYO2/DMmRu+igJHXel9+G31Sb8vFDGKDT4n6GD675yrZEzBC29R7aMzcuqaoVrqfu1iBn3TWOzjWnozBY49jTdM0wvROFNGyMJ06Ai2raa/nevWLHSpsqNbvSMgEbMoJhMuRlJSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157340; c=relaxed/simple;
	bh=1lomGxzn33k/VpUN3pr/AloupyiBd06Qge2SxBxhwAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcgfqsK+ArlnwFFEzN1vl5LEBNZFe+UtSY6gILsz0TWZ9Z7XHxlpvmbJim/dE1tlhWdOCtt4eVSLeDgUJvF08ZX3YjtPhnWfDVlzlynA4dRbZNKYKud6cnue+c4V3skfnDmPa+hTGy5jnSbqjaSLaDJXrcsU7dwFJlkAoky4r3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EE91227A8E; Tue, 24 Sep 2024 07:55:34 +0200 (CEST)
Date: Tue, 24 Sep 2024 07:55:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: remove
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240924055533.GA10756@lst.de>
References: <20240923152904.1747117-1-hch@lst.de> <20240923152904.1747117-3-hch@lst.de> <20240923161825.GE21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923161825.GE21877@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 09:18:25AM -0700, Darrick J. Wong wrote:
> > + * When a short write occurs, the filesystem may need to remove reserved space
> > + * that was allocated in ->iomap_begin from it's ->iomap_end method. For
> 
> "When a short write occurs, the filesystem may need to remove space
> reservations created in ->iomap_begin.

This just moved the text from the existing comment.  I agree that your
wording is better, but I'd keep the "from it's ->iomap_end".

> Unrelated question about iomap_write_begin: Can we get rid of the
> !mapping_large_folio_support if-body just prior to __iomap_get_folio?
> filemap_get_folio won't return large folios if
> !mapping_large_folio_support, so I think the separate check in iomap
> isn't needed anymore?

From the iomap POV it seems like we could (after checking no one
is doing something weird with len in ->get_folio).


