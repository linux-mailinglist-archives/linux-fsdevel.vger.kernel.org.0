Return-Path: <linux-fsdevel+bounces-23254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27B99291A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 09:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5681C211C2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06E3E479;
	Sat,  6 Jul 2024 07:56:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49AA95B;
	Sat,  6 Jul 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252575; cv=none; b=I6qWsdTxpGpS5GIv1sTBvugGSBwhGl6vUkdZrctLBi+ccUaYhVArbb7xs2nRrGyaqX8FxyhuKJTJa11dcm1/FrTiyYJmMLegUyl6pP8V6KvcreGkVSYqPPbUWJvX6iDJzMOqetC29LX9aVaxcXL9Ojcnje6BL3vOWbfwTpwl/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252575; c=relaxed/simple;
	bh=y2norNRW3QXpNbsdRRlEeXiacbyN9pRUX/TCGtXKkWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH2Mmy96vnGstHuNGYKpjt3k5zpT1m4grJaARM/c7Cum8VgeTMfh1pt6mf9SafsOPwsAZumbU0s9q1e5ZzoB7kn3LbP/O5R2APKvWrU3XgcLS5odKVpPGRijgXrLs9f7a8yFs5zD9lz0KkK7wvyWuFugvlSj/E5t2Nh50XN1UNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A817468AA6; Sat,  6 Jul 2024 09:56:09 +0200 (CEST)
Date: Sat, 6 Jul 2024 09:56:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
	hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
Message-ID: <20240706075609.GB15212@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705162450.3481169-9-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 04:24:45PM +0000, John Garry wrote:
> -	if (xfs_inode_has_bigrtalloc(ip))
> +
> +	/* Only try to free beyond the allocation unit that crosses EOF */
> +	if (xfs_inode_has_forcealign(ip))
> +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
> +	else if (xfs_inode_has_bigrtalloc(ip))
>  		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);

Shouldn't we have a common helper to align things the right way?

But more importantly shouldn't this also cover hole punching if we
really want force aligned boundaries?


