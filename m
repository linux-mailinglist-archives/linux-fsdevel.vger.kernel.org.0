Return-Path: <linux-fsdevel+bounces-48049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E7AA9159
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EC31895FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF520102D;
	Mon,  5 May 2025 10:49:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B2EAC6;
	Mon,  5 May 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442149; cv=none; b=twnTqZ31Q5E2lriW3p3m44v40amtXv9p5++31FhaYd8YG9gGllHSjVakWeV6MWDq2g2nPOandmOfPiign2T89VX0XhbmiPwQ8XfEQjKK7a724Utx1H5b5zCsqKMi5G+GoDn3ZUzDFGa/650YB+bLrvR6vNPqKyqdMnIykIE0lyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442149; c=relaxed/simple;
	bh=TWSLfPAQGFr10Sswmc3ZrKNirAwVgspFxtgXmzrbs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqJQp4GHwl6UKzh3v6FtWt5uQl0YtEySYXa5G0tc4kxZwZ5gymVRczordgq2GsQn7Gwmt1NtskbB8Gvh+7vYuqRpL3cicWQgyU8nRljZAL7fMNcgDLlMK2cQf0+XsqEts8phlXNOEpjcP/AcPujLEHG/ALkIjGoYVg7U4I5uX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7EC1E67373; Mon,  5 May 2025 12:49:01 +0200 (CEST)
Date: Mon, 5 May 2025 12:49:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
Message-ID: <20250505104901.GA10128@lst.de>
References: <20250504085923.1895402-1-john.g.garry@oracle.com> <20250504085923.1895402-3-john.g.garry@oracle.com> <20250505054031.GA20925@lst.de> <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 05, 2025 at 11:04:55AM +0100, John Garry wrote:
> @@ -503,6 +509,9 @@ xfs_open_devices(
>  		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
>  		if (!mp->m_logdev_targp)
>  			goto out_free_rtdev_targ;
> +		error = sync_blockdev(mp->m_logdev_targp->bt_bdev);
> +		if (error)
> +			goto out_free_rtdev_targ;
>  	} else {
>  		mp->m_logdev_targp = mp->m_ddev_targp;
>  		/* Handle won't be used, drop it */
>
>
> Right?

Yes.  Or in fact just folding it into xfs_alloc_buftarg, which might
be even simpler.  While you're at it adding a command why we are doing
the sync would also be really useful, and having it in just one place
helps with that.

