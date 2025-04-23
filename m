Return-Path: <linux-fsdevel+bounces-47112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A1A9946B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FF1446E50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673A289340;
	Wed, 23 Apr 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl88vdl4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB232798E3;
	Wed, 23 Apr 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423932; cv=none; b=A4UtRWa4KjPuzOEr+0+DXv9s+rbsfYhvzqEb2fdRyP27usSQAojqQmtWwxkXPpoHcewKhYpj62ttaDy7Mi+s9rq11XyVsLjHJokfruotuo9cjqAv04bY4/XbVPWpxmW163YFNXAzOVeUYd9PxVaMxPFqSUhAgqMom+qYXW97l0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423932; c=relaxed/simple;
	bh=PpFC8zZMZXSzlNypRJqafF0wtsr0ftAXYGxb5xxbR54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE9EigLzOgLaiGK0esc3igNAQxFxcn7F6zdK1aQ9JZSIt1g3jxeAWcJR2rFqeaq2DGiOSVgeGcCTvwKZ196KX34atVW2d6+IVTN7IqVzX8WA1me9N0To3S2I4ejUe8RYFhv7YY5XX3XyNskS/ogCJe7ovZB/fVAAIYp8pnHwoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl88vdl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9EFC4CEE2;
	Wed, 23 Apr 2025 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745423932;
	bh=PpFC8zZMZXSzlNypRJqafF0wtsr0ftAXYGxb5xxbR54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sl88vdl4dmVc242WZOqWBaMjdg+yskYnEhkxQPq6ttrbldVbB7kFfCbEQfiXsuEbp
	 6vvML156AwB6aM5ZaOuJB+/ncxGTstLXImQx/6JqoihyrebII6CPjISjSl566D704P
	 wCu0VzyjgksQ6/OtneULglbNfWFpVEY/M4cdPA89pvwlHHcowkFND5iWljwaDI3Zcn
	 sqiu39JSffJBD8h+K2EqA0NnQc4WUY03c6Kd1Zx/A/UkOqGRqHFAuSiGQTRksuSJp2
	 GHrFS1f1LU/5kq/C4QRWhNEaR/1aU99+CJLqz3rx5aJ/UmV6WPhcoSmHl9Wfym5aKJ
	 pa6wMtPNPmYJg==
Date: Wed, 23 Apr 2025 08:58:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 11/15] xfs: commit CoW-based atomic writes atomically
Message-ID: <20250423155851.GL25700@frogsfrogsfrogs>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-12-john.g.garry@oracle.com>
 <20250423082307.GA29539@lst.de>
 <20250423145850.GA25675@frogsfrogsfrogs>
 <20250423155340.GA32225@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423155340.GA32225@lst.de>

On Wed, Apr 23, 2025 at 05:53:40PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 07:58:50AM -0700, Darrick J. Wong wrote:
> > > > +xfs_calc_default_atomic_ioend_reservation(
> > > > +	struct xfs_mount	*mp,
> > > > +	struct xfs_trans_resv	*resp)
> > > > +{
> > > > +	if (xfs_has_reflink(mp))
> > > > +		resp->tr_atomic_ioend = resp->tr_itruncate;
> > > > +	else
> > > > +		memset(&resp->tr_atomic_ioend, 0,
> > > > +				sizeof(resp->tr_atomic_ioend));
> > > > +}
> > > 
> > > What is the point of zeroing out the structure for the non-reflink
> > > case?  Just as a poision for not using it when not supported as no
> > > code should be doing that?  Just thinking of this because it is a
> > > potentially nasty landmine for the zoned atomic support.
> > 
> > Yes.  I thought about adding a really stupid helper:
> 
> Why don't we just always set up the xfs_trans_resv structure?  We
> do that for all kinds of other transactions not supported as well,
> don't we?

Works for me.  There's really no harm in it mirroring tr_itruncate since
it won't affect the log size calculation.

> > static inline bool xfs_has_sw_atomic_write(struct xfs_mount *mp)
> > {
> > 	return xfs_has_reflink(mp);
> > }
> > 
> > But that seemed too stupid so I left it out.  Maybe it wasn't so dumb,
> > since that would be where you'd enable ZNS support by changing that to:
> > 
> > 	return xfs_has_reflink(mp) || xfs_has_zoned(mp);
> 
> But that helper might actually be useful in various places, so
> independent of the above I'm in favor of it.

<nod> John, who should work on the next round, you or me?

--D

