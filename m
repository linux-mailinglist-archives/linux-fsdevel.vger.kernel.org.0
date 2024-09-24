Return-Path: <linux-fsdevel+bounces-29931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61925983CA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 08:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928D61C2230B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2EE80C1C;
	Tue, 24 Sep 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftNJFb7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080545C1C;
	Tue, 24 Sep 2024 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157917; cv=none; b=Uv1co7nNAqiWuaUaQ6W9FLQmrbezWPxCu4BoGcPHqBFN+2SeCdNLBVjV9wdFoSW37oNBxXpTjI8L8APiA8EgoEUv/VuRqxJldUVzq7EXhemWIm8UNesqqN5DAc6L7wVQRFv10BM3i5VBH422JJ2GIS/tgTIGaYvZoGCo1yXO7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157917; c=relaxed/simple;
	bh=zZy+vWjSfTRo+NniFf5sCTkGdJXes/en2+Iogkf0f1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP4gB5F2AEWih/B0jLdwtFEN+vLoYoLHB5IQhBp+4/zokCQjD1X/gMRVFscnJI9KJR733OfbQJtpIQEeTpDoYEUVL96O2uQjbTDGzcifrsFevbsDZAKiF6arEAMoRImD6fwRPoQwHn9XFlt7k3D/OECWk6xSFMjzSlYp9kK9hHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftNJFb7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A93C4CEC5;
	Tue, 24 Sep 2024 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727157916;
	bh=zZy+vWjSfTRo+NniFf5sCTkGdJXes/en2+Iogkf0f1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftNJFb7Q/QmiIRbzKmEzmJNihZyn387dgr39qXfeiZYyrSmTdIQkmAzzAC8arqhWx
	 K5cJiy3/97KslzgYPDhIaLRd6I/+SLBihB9QskiahukQot9sd2rmkgcjUN2dOp59AO
	 wNfvKUewKJu2RnTENIGZeG+vNr02GVrIHIMKjhMDKtidCWRgmTRV6hap5qXXt38Ked
	 f3UptYK96lTfJY2Xp9Kaq8yMaYQtgDbHp9Dp1Y2jEWtKwy6V67X5lNbWKjie7GHaSQ
	 JIU2ZqgNlCGuxdrrjigEAiKmGfg2jB/PiYD+q/UNuhT04AB8SflB7xw43IBjyHlEDX
	 bOGYstzvDjDuA==
Date: Mon, 23 Sep 2024 23:05:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: remove
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240924060516.GO21877@frogsfrogsfrogs>
References: <20240923152904.1747117-1-hch@lst.de>
 <20240923152904.1747117-3-hch@lst.de>
 <20240923161825.GE21877@frogsfrogsfrogs>
 <20240924055533.GA10756@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924055533.GA10756@lst.de>

On Tue, Sep 24, 2024 at 07:55:33AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 23, 2024 at 09:18:25AM -0700, Darrick J. Wong wrote:
> > > + * When a short write occurs, the filesystem may need to remove reserved space
> > > + * that was allocated in ->iomap_begin from it's ->iomap_end method. For
> > 
> > "When a short write occurs, the filesystem may need to remove space
> > reservations created in ->iomap_begin.
> 
> This just moved the text from the existing comment.  I agree that your
> wording is better, but I'd keep the "from it's ->iomap_end".

Yeah, please do.  What do you think of:

"When a short write occurs, the filesystem might need to use ->iomap_end
to remove space reservations created in ->iomap_begin." ?

> > Unrelated question about iomap_write_begin: Can we get rid of the
> > !mapping_large_folio_support if-body just prior to __iomap_get_folio?
> > filemap_get_folio won't return large folios if
> > !mapping_large_folio_support, so I think the separate check in iomap
> > isn't needed anymore?
> 
> From the iomap POV it seems like we could (after checking no one
> is doing something weird with len in ->get_folio).

The only user I know of is gfs2, which allocates a transaction and then
calls iomap_get_folio with pos/len unchanged.

--D

