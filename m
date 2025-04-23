Return-Path: <linux-fsdevel+bounces-47110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A5A99446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6481BC2D52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE3E2957A1;
	Wed, 23 Apr 2025 15:53:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24819DFA7;
	Wed, 23 Apr 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423628; cv=none; b=A8gCuaXPGpGEmQ2Ic5tKHzWIyZPtt7niZy+REUiUBXhlPj1a2jOgz59SCNOPzcmMkK0ya5Wn4xZczKsIPBJmtYwXO23dHgpYjTKRLmcrh+z33PB6P48KAIpnuMDUoAwpgcWywwM3DFClAvbtO8pySVRAOU2hy3mlqzKpPpLagEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423628; c=relaxed/simple;
	bh=kAkYGXhLqXgPzrZy4lBSQyt77vQUpcthss2TcC8H8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg9ai/EAbv0qE60CsWoNJFB37C0VeWtZBgVoH60ftiw4dKhM5xRIhTQXz6Qynr7iuzqD4eV7EC9YUd86CqrNPFFqQPBaSQ5tqygV4z0kTy8+trBmtn49EdzsTNZZt1GFuAuHK9LSuCQLRR8s1S1frgyJBHuwlsyJUO+rLzjtuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8676768BFE; Wed, 23 Apr 2025 17:53:40 +0200 (CEST)
Date: Wed, 23 Apr 2025 17:53:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 11/15] xfs: commit CoW-based atomic writes atomically
Message-ID: <20250423155340.GA32225@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-12-john.g.garry@oracle.com> <20250423082307.GA29539@lst.de> <20250423145850.GA25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423145850.GA25675@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 07:58:50AM -0700, Darrick J. Wong wrote:
> > > +xfs_calc_default_atomic_ioend_reservation(
> > > +	struct xfs_mount	*mp,
> > > +	struct xfs_trans_resv	*resp)
> > > +{
> > > +	if (xfs_has_reflink(mp))
> > > +		resp->tr_atomic_ioend = resp->tr_itruncate;
> > > +	else
> > > +		memset(&resp->tr_atomic_ioend, 0,
> > > +				sizeof(resp->tr_atomic_ioend));
> > > +}
> > 
> > What is the point of zeroing out the structure for the non-reflink
> > case?  Just as a poision for not using it when not supported as no
> > code should be doing that?  Just thinking of this because it is a
> > potentially nasty landmine for the zoned atomic support.
> 
> Yes.  I thought about adding a really stupid helper:

Why don't we just always set up the xfs_trans_resv structure?  We
do that for all kinds of other transactions not supported as well,
don't we?

> static inline bool xfs_has_sw_atomic_write(struct xfs_mount *mp)
> {
> 	return xfs_has_reflink(mp);
> }
> 
> But that seemed too stupid so I left it out.  Maybe it wasn't so dumb,
> since that would be where you'd enable ZNS support by changing that to:
> 
> 	return xfs_has_reflink(mp) || xfs_has_zoned(mp);

But that helper might actually be useful in various places, so
independent of the above I'm in favor of it.


