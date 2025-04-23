Return-Path: <linux-fsdevel+bounces-47061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E566EA9836D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FD0168404
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAF2820BC;
	Wed, 23 Apr 2025 08:23:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AE1FE45D;
	Wed, 23 Apr 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396594; cv=none; b=KEOENt8Nwv07aSQttu1LGPBP/eSWRVlsjhUB8tPTQOeLNb5E6azVfwSsTXN2S7NHu4LnoICIFe8tOK0DflOzBnKm9FFsWI2lTkJfttyjvPmFv+HsR+uwRWvoOcHA4rUgktwQwCbTP0vCq4tJY7sgMg3T4EVeUSRp6eNZuEX9uQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396594; c=relaxed/simple;
	bh=sa40OfymsM+wntfudnwDbfz9beKE9D1/QVwSLdySqa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaYZWzXeXRSA3meD60ZCdpoEvY3xsqeUPJDsJeFLiRocXdzKO7qHd2/LjRAaMXF3IaSZNoM2aEPxFWYdjnsenN7x/7mEM4hTVfo+GSHDVInitgnQ/UZNPeQp3rqYZAom+ytPyYywB2n0NkI2Ex65dUUpHoj7Sw0Gm3S/IuNC7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C470168BFE; Wed, 23 Apr 2025 10:23:07 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:23:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 11/15] xfs: commit CoW-based atomic writes atomically
Message-ID: <20250423082307.GA29539@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422122739.2230121-12-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 12:27:35PM +0000, John Garry wrote:
> +STATIC void

Didn't we phase out STATIC for new code?

> +xfs_calc_default_atomic_ioend_reservation(
> +	struct xfs_mount	*mp,
> +	struct xfs_trans_resv	*resp)
> +{
> +	if (xfs_has_reflink(mp))
> +		resp->tr_atomic_ioend = resp->tr_itruncate;
> +	else
> +		memset(&resp->tr_atomic_ioend, 0,
> +				sizeof(resp->tr_atomic_ioend));
> +}

What is the point of zeroing out the structure for the non-reflink
case?  Just as a poision for not using it when not supported as no
code should be doing that?  Just thinking of this because it is a
potentially nasty landmine for the zoned atomic support.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

