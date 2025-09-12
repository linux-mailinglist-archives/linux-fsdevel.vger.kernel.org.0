Return-Path: <linux-fsdevel+bounces-61003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FFFB543AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365117AD1DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF62BF010;
	Fri, 12 Sep 2025 07:19:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298B2BEC45;
	Fri, 12 Sep 2025 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661552; cv=none; b=HVXI2WrgDsWhFpveKu5OtUOX6gyS1iIkyvFcSQJfiIptsa2KFonQO+OR/AiQsT1F4skgs5bUX/cyejX2omkcv5N+sTZZPq4fGiUDpNudOUoaZk71MkxKxw1BuePIRVH97Py/z3jZmyzZq0UwtFcD+ThHXPZV2lPEFtVOhCFHRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661552; c=relaxed/simple;
	bh=4VSxvnyitUuHbhqtl529rIPITQrQA9BPf6MhDT6TeK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn2AmRG9ylHWlsm37QQCbrKN4LBsR/XVGgjeqM4mVvP7VbcjsBY8zRmA8dbu7RaA5jO6UhLI8N2PoO4CqRdj//ih5DnfAXNJumMjF6e1jbhZj/xdLZjZHQtGpgUWuWJZuH1MqgJcFQ2mfEu3pl4ES/7v6+cCQ94++kynwY+3zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96F4068BFE; Fri, 12 Sep 2025 09:18:59 +0200 (CEST)
Date: Fri, 12 Sep 2025 09:18:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <20250912071859.GB13505@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-2-9e5443af0e34@kernel.org> <20250729222252.GJ2672049@frogsfrogsfrogs> <20250811114337.GA8850@lst.de> <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 02:30:14PM +0200, Andrey Albershteyn wrote:
> > Same thoughts here.  It seems like we should just have a beyond-EOF or
> > fsverity flag for ->read_iter / ->write_iter and consolidate all this
> > code.  That'll also go along nicely with the flag in the writepage_ctx
> > suggested by Joanne.
> > 
> 
> In addition to being bound by the isize the fiemap_read() copies
> data to the iov_iter, which is not really needed for fsverity.

Aka, you want an O_DIRECT read into a ITER_BVEC buffer for the data?


