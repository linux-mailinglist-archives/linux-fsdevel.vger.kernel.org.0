Return-Path: <linux-fsdevel+bounces-18452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604D8B91B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50ED2827A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E01304A1;
	Wed,  1 May 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Ty7X62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C11E481;
	Wed,  1 May 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603345; cv=none; b=RyvurZp1a38kczB/KPLebPwIkooKtPAMCOargQDO3AvKrQuxw76w065n4k6s3t4KAyNBOG8G4UciOhtxC+GYc1zb8OpHuGoQqOk1ZjpeKcBn9v1INPLWqJoMFYpkmgXIkp5fAg2gA8jma7sk7Y37c8iG+Zwi3B8XhYyCk6/J/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603345; c=relaxed/simple;
	bh=a3O5Gty751Q31BmCsQXEANmCrf4vdcRZ6xbthZ4/30w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbNZ3d7h5am21Tvk4axksI/xG+Y8qojrfdrdoFiVvTlusQZphvubMj4TK6IqkHs7uja7SMKGZpGYgzR3w77hid1CTLSOUPdRCFrdzbpTlmfCcSaIZd3FAu3BP9yRZgJoV7Ub8sKhLmfS3Lxqrj0reCTZE4bx1YdtGcIRYWP5/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8Ty7X62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE8DC072AA;
	Wed,  1 May 2024 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714603344;
	bh=a3O5Gty751Q31BmCsQXEANmCrf4vdcRZ6xbthZ4/30w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8Ty7X62PLCyV83S7nOVy2Vo5s2mfoS5N4SLMEx00w6RPnEtJEnLEVYCv6vh/afsS
	 wbpo3RyIvD56oZmu1JyVNDYpb69M+knjMDSxmV2qQaNSgojV1dqteWd842pSwqH49w
	 NDNGfe3mF0t/jW9cagfnULiBFGT5/lVNnIlYN5hsECcHQSTrDfL/AmzkQXWosb4tMs
	 QnyXNgEjRz0RaXbflMUxkwO8mm7C+mXXh53p2hTrXjM2JpjCufIZKU3VGVawIiTYmz
	 QYzjV9HLLiHwS+DueoJ3MXsNBLNXUOEZn4NHhcM7186unJLGAvI87GC2HQviXJyODW
	 /lH9IQTfxFefw==
Date: Wed, 1 May 2024 15:42:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/26] xfs: use an empty transaction to protect
 xfs_attr_get from deadlocks
Message-ID: <20240501224224.GJ360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680446.957659.9938547111608933605.stgit@frogsfrogsfrogs>
 <ZjHnya1jaNR1MpGP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHnya1jaNR1MpGP@infradead.org>

On Tue, Apr 30, 2024 at 11:57:13PM -0700, Christoph Hellwig wrote:
> > +	if (error)
> > +		return error;
> > +
> >  	lock_mode = xfs_ilock_attr_map_shared(args->dp);
> > +
> > +        /*
> > +	 * Make sure the attr fork iext tree is loaded.  Use the empty
> > +	 * transaction to load the bmbt so that we avoid livelocking on loops.
> > +	 */
> > +        if (xfs_inode_hasattr(args->dp)) {
> > +                error = xfs_iread_extents(args->trans, args->dp, XFS_ATTR_FORK);
> 
> Overly long line here.  But I'd expect the xfs_iread_extents to be in
> xfs_attr_get_ilocked anyway instead of duplicated in the callers.

Hmm, I think that's the result of xfs_iread_extents whackamole in
djwong-dev.  You are correct that we don't need this whitespace damaged
blob.

--D

