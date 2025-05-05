Return-Path: <linux-fsdevel+bounces-48021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF9AA8BC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 07:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1FF3B4771
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C71B0421;
	Mon,  5 May 2025 05:40:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854610A1F;
	Mon,  5 May 2025 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423644; cv=none; b=jpfIVreyDyo5ER3drSxqsR0KzRDP9ZC8qU++/ekwZqgdYIW+oR675NDpZVX/vr9g/4oU9+vKPLzt/u2w9ItHIWsXG7iOj65qKbR7eBxlpydUcfBslJ/Q8cLHZFH9jgFnF1ZDC5SMuCddMBRK3B9JDgwUd8YeAmvtw7d0AmM7+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423644; c=relaxed/simple;
	bh=Ku17acRJb1QW1OdpnNN2OSk6KwYCHMoozzjfVO8vbhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBz7YYg7/fr6bxDdUZ8hP3riNaya79KxamUOODQrTQrNdr+e4qwbC+1t0FCJN2woZVYS1e+qgVWXS+HXoEdxQmwlhfriioYwwjfm+MtekQEtRFBlMhNJKU+Og7BRR2nHbpc4wGZ5fPsJK+nag5aCkrIphvWJsT0uo5aDlfvCnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF3B268BEB; Mon,  5 May 2025 07:40:31 +0200 (CEST)
Date: Mon, 5 May 2025 07:40:31 +0200
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
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
Message-ID: <20250505054031.GA20925@lst.de>
References: <20250504085923.1895402-1-john.g.garry@oracle.com> <20250504085923.1895402-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504085923.1895402-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, May 04, 2025 at 08:59:09AM +0000, John Garry wrote:
> +static inline int xfs_buftarg_sync(struct xfs_buftarg *btp)
> +{
> +	return sync_blockdev(btp->bt_bdev);
> +}

What is the point in having this wrapper?

> +/*
> + * Flush and invalidate all devices' pagecaches before reading any metadata
> + * because XFS doesn't use the bdev pagecache.
> + */
> +STATIC int
> +xfs_preflush_devices(
> +	struct xfs_mount	*mp)
> +{
> +	int			error;
> +
> +	error = xfs_buftarg_sync(mp->m_ddev_targp);
> +	if (error)
> +		return error;
> +
> +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
> +		error = xfs_buftarg_sync(mp->m_ddev_targp);
> +		if (error)
> +			return error;
> +	}

Why does this duplicate all the logic instead of being folded into
xfs_open_devices?


