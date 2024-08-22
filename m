Return-Path: <linux-fsdevel+bounces-26660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17C695AC3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 05:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D98C280CE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600437160;
	Thu, 22 Aug 2024 03:47:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F92E64B;
	Thu, 22 Aug 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298462; cv=none; b=s9kBGtbt3+0x7CLn/ZWbv6ifYXaxI8CJpOSisd3baQ+OANswYLysqrtjdJ4XR139yDO6Y9QKhRlitqM1ouiNJppVMepL/cyxO6ZTb/4OiTEr03BvvL/da+BIFgnKdoKZ/+soCMe31jKvpCvGa5+EWGUuONjMwP8T1L8FNrJw6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298462; c=relaxed/simple;
	bh=vSMh5gGAamqPj3RXPyE8JcxikLlbDcEem2LdJZ5rw4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOZpOznNH7RWfuyDAw6cMtMs70wvPpW2gFkcQ8ySvuyZlB5pSxKEFZP/pRALKE+sUVtujFvHWvuftSmz3qC29aN52ntEVY9N2C8PUcpnGk8pTF+u4I4kUNPC3Zsecckm2+Me2DLBJExXkaMU81rAq3mcC2AQ3aTRb5I84ac6QmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6762227A8E; Thu, 22 Aug 2024 05:47:35 +0200 (CEST)
Date: Thu, 22 Aug 2024 05:47:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] xfs: move the tagged perag lookup helpers to
 xfs_icache.c
Message-ID: <20240822034735.GE32681@lst.de>
References: <20240821063901.650776-1-hch@lst.de> <20240821063901.650776-3-hch@lst.de> <20240821163407.GH865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821163407.GH865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 21, 2024 at 09:34:07AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 21, 2024 at 08:38:29AM +0200, Christoph Hellwig wrote:
> > The tagged perag helpers are only used in xfs_icache.c in the kernel code
> > and not at all in xfsprogs.  Move them to xfs_icache.c in preparation for
> > switching to an xarray, for which I have no plan to implement the tagged
> > lookup functions for userspace.
> 
> I don't particularly like moving these functions to another file, but I
> suppose the icache is the only user of these tags.  How hard is it to
> make userspace stubs that assert if anyone ever tries to use it?

It might be easier to just implement them in that case like the underlying
radix tree ones.  But given that they are unused I'd feel rather
uncomfortable about it.  And more importantly I like to have the
function (only one is left by the end) close to the callers as that makes
reading and understanding the code easier.


