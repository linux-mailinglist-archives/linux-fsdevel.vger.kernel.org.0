Return-Path: <linux-fsdevel+bounces-33716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D99BDE71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 06:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92889B2301B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FC191F78;
	Wed,  6 Nov 2024 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="caWk7TAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590C191F68;
	Wed,  6 Nov 2024 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872762; cv=none; b=CdTn0+Lwf6e77Z855nbIhISX1MYDnFD7g5IlLbbHwTh+v2A2kOcy4dfSYnPfb3Xw/0B/M5k5JBCKkf5gDOsCW5W2b5UjAvJwqUvzUigNEpB66FAcDxxsZYC0wdOz5h8rewoUJubM/jX5eASp//rwk0QU1AN13Ptc4eHZgwhRpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872762; c=relaxed/simple;
	bh=pejA8p4pUQOOOfIaAqDoAbP6ujyUTye2OnK2sV0aF6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrY0qInkJB1byKXQeAEfrmo5oSPBYzTe8ryA1yexTMt6gfDi+X31hHi9E/ri/WtCgt3yiBCslPSm36Mh3arNTADjTbkQMQs93RKfx2aqgBTuVyQIITp9vA8zwrFePKEtHjYixGoOYLCl4o20wbBzYAJ6PMijg9EVdY0gwxkfmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=caWk7TAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0020CC4CECD;
	Wed,  6 Nov 2024 05:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730872761;
	bh=pejA8p4pUQOOOfIaAqDoAbP6ujyUTye2OnK2sV0aF6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caWk7TAXzoKXPI6lVr5wdAkvS026FD0NH/rEjAyH7yiRuxWUkLAIywKPukBEbCdPa
	 aoMGDqYmDjyeIBvSyvSqFqBNjQdaOzijoYFLI81hkzyUo+wArEN0EExb7MEqFvCq0H
	 wJ19qVwaU94CKXye9xK10t1Plhtr6Votwp1Ig2Sg=
Date: Wed, 6 Nov 2024 06:59:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Ebner <c.ebner@proxmox.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, stable@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 6.11.y] netfs: reset subreq->iov_iter before
 netfs_clear_unread() tail clean
Message-ID: <2024110644-audible-canine-30ca@gregkh>
References: <20241027114315.730407-1-c.ebner@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027114315.730407-1-c.ebner@proxmox.com>

On Sun, Oct 27, 2024 at 12:43:15PM +0100, Christian Ebner wrote:
> Fixes file corruption issues when reading contents via ceph client.
> 
> Call netfs_reset_subreq_iter() to align subreq->io_iter before
> calling netfs_clear_unread() to clear tail, as subreq->io_iter count
> and subreq->transferred might not be aligned after incomplete I/O,
> having the subreq's NETFS_SREQ_CLEAR_TAIL set.
> 
> Based on ee4cdf7b ("netfs: Speed up buffered reading"), which
> introduces a fix for the issue in mainline.
> 
> Fixes: 92b6cc5d ("netfs: Add iov_iters to (sub)requests to describe various buffers")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219237
> Signed-off-by: Christian Ebner <c.ebner@proxmox.com>
> ---
> Sending this patch in an attempt to backport the fix introduced by
> commit ee4cdf7b ("netfs: Speed up buffered reading"), which however
> can not be cherry picked for older kernels, as the patch is not
> independent from other commits and touches a lot of unrelated (to
> the fix) code.

We would much rather take the original series of commits, what exactly
are they here?

thanks,

greg k-h

