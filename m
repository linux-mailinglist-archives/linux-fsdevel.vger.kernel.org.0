Return-Path: <linux-fsdevel+bounces-47101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A69A98EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF87176922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4714E28466F;
	Wed, 23 Apr 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B96caFpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29C27FD73;
	Wed, 23 Apr 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420331; cv=none; b=Xo6IaV3U5+ttJqh1c0BrgnzhGlTlQNdI6s7vE0WBjyxKvY1X8LxSRq/9zDa0ulRjoKN3+uiGbxweTsafFURZ+TR+ciSNhhN5VOw3kzsJLDleNvGiY/MUqRu55b/3LvpKaMXriWLSXO0Rguf/iYcHmr223VoTEVMuQjxYIjCotuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420331; c=relaxed/simple;
	bh=p0S+Vbmvkneh0EjigmxBvqMbnA1NIteJLG81y1iqkhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul9o9tOPZr7BobTuNibKL3BK/PctDtD6IXQBfZipK7anSMWBAJ0KXij6e/ioN3M9vAXRtr/VPpp/bDW1J439wImp7PgzguMS988hZd8Ahz96B1//Huk0ddtaZMjTSqsx/1HtrIndqumv2d4Ga6iM0Ocn9dxnTJFFa6a9C+vTg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B96caFpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAB7C4CEE2;
	Wed, 23 Apr 2025 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420331;
	bh=p0S+Vbmvkneh0EjigmxBvqMbnA1NIteJLG81y1iqkhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B96caFpxffvL37rps1S+kY2SGOAMAMk/4kER07NSr3tDCj/LE8E8uPVNR3e0ekYsp
	 gdzZz6P0vf5+Knb9kHIQlfxNKkO/+wXLq4Nv80FqfNc/hGwzHO6+T8bYIZhddP+V4v
	 lngzqE7d+HPBFwY9WbtnGTUngmkx5i/8ahHH45o9Nwsi+2ZhWzl8YI406XSbSB9fK5
	 8Ac8zHK87SEmhis+ekYdMXeicPclsULB1ZjhiF1xyU8ONUfodFoRABgAKslu2xcbWB
	 TWwQCbEBONQNBWz9OR5g+K3laSXvlIOoNz5gjnS+6R2bKsxgX+5Cdk3fHkuTWUFNQs
	 Um4vg+hT3mVww==
Date: Wed, 23 Apr 2025 07:58:50 -0700
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
Message-ID: <20250423145850.GA25675@frogsfrogsfrogs>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-12-john.g.garry@oracle.com>
 <20250423082307.GA29539@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423082307.GA29539@lst.de>

On Wed, Apr 23, 2025 at 10:23:07AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 12:27:35PM +0000, John Garry wrote:
> > +STATIC void
> 
> Didn't we phase out STATIC for new code?
> 
> > +xfs_calc_default_atomic_ioend_reservation(
> > +	struct xfs_mount	*mp,
> > +	struct xfs_trans_resv	*resp)
> > +{
> > +	if (xfs_has_reflink(mp))
> > +		resp->tr_atomic_ioend = resp->tr_itruncate;
> > +	else
> > +		memset(&resp->tr_atomic_ioend, 0,
> > +				sizeof(resp->tr_atomic_ioend));
> > +}
> 
> What is the point of zeroing out the structure for the non-reflink
> case?  Just as a poision for not using it when not supported as no
> code should be doing that?  Just thinking of this because it is a
> potentially nasty landmine for the zoned atomic support.

Yes.  I thought about adding a really stupid helper:

static inline bool xfs_has_sw_atomic_write(struct xfs_mount *mp)
{
	return xfs_has_reflink(mp);
}

But that seemed too stupid so I left it out.  Maybe it wasn't so dumb,
since that would be where you'd enable ZNS support by changing that to:

	return xfs_has_reflink(mp) || xfs_has_zoned(mp);

--D

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

