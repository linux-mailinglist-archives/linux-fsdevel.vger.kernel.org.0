Return-Path: <linux-fsdevel+bounces-27754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655729638F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5262859E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2E4D8C6;
	Thu, 29 Aug 2024 03:48:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123E2837F;
	Thu, 29 Aug 2024 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903308; cv=none; b=T+NeaTliOBJEgFtbFWo7x9lZAYeFHt5uV/yJ0+3R905eCJH8tMna9bWMQE+tFtASQdF24V/kAJTmbDr/YNadEcHn8XFCgdd+jQG7zdQ5aAfam/YeRc2HuGwpdPFO+f6CwgwT+YJp78t3QskK0NSnlnzdmB3VG1At5QdbCcc4JFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903308; c=relaxed/simple;
	bh=d1v+IFWEguBYxwg1tMtkP8YpTI6g6V2Vr6vGF081P1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7mgWuUxtMTnI2FtBEvPXqIQc/cmaR9yAWjjSkVboG0F7aveafLijHVHtpCm7IXFEDrGxg4KP81e8PKKv3eNMRB/tQzp0Eikv5HtC48YzTLj9kzOEtzOpAyoTSFg44ZcI1pVKnqRFEeERk4HeNvs1bwZq8szQGHmS/YDwF2wHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 338FD68AFE; Thu, 29 Aug 2024 05:48:22 +0200 (CEST)
Date: Thu, 29 Aug 2024 05:48:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] xfs: move the tagged perag lookup helpers to
 xfs_icache.c
Message-ID: <20240829034822.GA3974@lst.de>
References: <20240821063901.650776-1-hch@lst.de> <20240821063901.650776-3-hch@lst.de> <20240821163407.GH865349@frogsfrogsfrogs> <Zs7DoMzcyh7QbfUb@infradead.org> <20240828161004.GG1977952@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828161004.GG1977952@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 28, 2024 at 09:10:04AM -0700, Darrick J. Wong wrote:
> > tags for garbage collection of zoned rtgs, but I'd rather build the
> > right abstraction when we get to that.  That will probably also
> > include sorting out the current mess with the ICI vs IWALK flags.
> 
> Or converting pag_ici_root to an xarray, and then we can make all of
> them use the same mark symbols. <shrug>

Maybe we could, but someone intentionally separated them out (and than
someone, not sure if the same persons were involved, was very sloppy
about the separation) so I'll need to look a bit more at the history.
And maybe think about a better way of doing this.


