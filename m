Return-Path: <linux-fsdevel+bounces-29932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBB983CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041E81F23331
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57257CAC;
	Tue, 24 Sep 2024 06:10:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE061B85F1;
	Tue, 24 Sep 2024 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158224; cv=none; b=d6gfOYa/Wm5+64D/mQosO85sNKZJ9Lq3VSgdg5WXEFBYHyT5ozfc5c88/xDV+xi7jp5zfIo68EXA0tEwOs/H/PKq5R609/T6QoLwMw+78irPQhasTJutRkE4dbkeghAWeyk7dgOqH5tDcy4um2gGZ9zxsLExfc66BFYVSZLfFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158224; c=relaxed/simple;
	bh=eck8XPpTFY0WYB5iGVd1yS0/Tbzkhc+4cSGYm9BeJHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXiKeYlSl/ZeAOP9f2bGtaE5cZ+yJ47o+HrC8EBLsKalc+ANENo0bRcRu0/vatOxcrZ4P7KD9elGJP90kB7nRR63YswtL8EyHK6hz69BMUoOlPG9nBQq1AU81m5CJbOgiYjS8kzB+3zZVzhq//PMiTzt59k2202Rg9t4+fY6JAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1EDF227A8E; Tue, 24 Sep 2024 08:10:18 +0200 (CEST)
Date: Tue, 24 Sep 2024 08:10:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: remove
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240924061018.GA11071@lst.de>
References: <20240923152904.1747117-1-hch@lst.de> <20240923152904.1747117-3-hch@lst.de> <20240923161825.GE21877@frogsfrogsfrogs> <20240924055533.GA10756@lst.de> <20240924060516.GO21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924060516.GO21877@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 11:05:16PM -0700, Darrick J. Wong wrote:
> Yeah, please do.  What do you think of:
> 
> "When a short write occurs, the filesystem might need to use ->iomap_end
> to remove space reservations created in ->iomap_begin." ?

Sounds good, I'll update it again.

> > > Unrelated question about iomap_write_begin: Can we get rid of the
> > > !mapping_large_folio_support if-body just prior to __iomap_get_folio?
> > > filemap_get_folio won't return large folios if
> > > !mapping_large_folio_support, so I think the separate check in iomap
> > > isn't needed anymore?
> > 
> > From the iomap POV it seems like we could (after checking no one
> > is doing something weird with len in ->get_folio).
> 
> The only user I know of is gfs2, which allocates a transaction and then
> calls iomap_get_folio with pos/len unchanged.

Yeah, so it _should_ be fine.  Not really feeling like changing it now
with all the other stuff in flight, though.  And eventually I really
want to sort out a few things in the area, like confusing
__iomap_get_folio naming for the wrapper with iomap_get_folio as
the default instance, and the fact that the get_folio and invalidation
are indirect calls right next to each other.

> 
> --D
---end quoted text---

