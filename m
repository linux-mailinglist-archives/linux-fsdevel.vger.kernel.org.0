Return-Path: <linux-fsdevel+bounces-18078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B58B5354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D6FB221DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD11C294;
	Mon, 29 Apr 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiLXElr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F01862E;
	Mon, 29 Apr 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380032; cv=none; b=bnsWrGT0YODCwLbRjr3f7ohgExiV52k60xVB2hJ/XT7YyeTUCvXe24X1JWeWaYsmKeVLs+R1RZWNnzpZ7bVh+czVBXPiGLl0+JXSl6dWwIghWFHKGEzmlVSAI3CwygVqDHrE6ZtDAeWgP2U0Z6LI/yQeYUumYlESNH/u6H/7Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380032; c=relaxed/simple;
	bh=LxM8GKVsmdfKbEQ956UzVPgI6MNFerX/PZxE2lQLJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENPODfSYFrP9Vq2DUrRMyQaZPRnVDBWJig3gKq94elg0eC6mKbzUZJIG15seBSeToWl6eCbNaC6MeacpVmwwtgHrRfMznKF6Bl5mS44w6WJxZxWdE6plqb5pT7DYhTw+xKW0s6rO5d6tiyuOZ2+p789D3hqtHgkV/eUA8McUpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiLXElr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B157C113CD;
	Mon, 29 Apr 2024 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714380032;
	bh=LxM8GKVsmdfKbEQ956UzVPgI6MNFerX/PZxE2lQLJrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiLXElr4r5RQmugkAtBUuGdqG3RwKYPu0piGRK99yiHP4/Pe+sFo5X2oj6Yq2Y0mB
	 wdUAqWo45IHGORCW5NrswdNF9B8UgPaS4Sa81gepNzkTQsDuPbUmGFjvbbrJuJYqiH
	 GdAa5+s1XvOB63/3xF21az1UauVmIjSPPsaXUkOSrnBf9futJvmTfiBYxC2MJ2IeUD
	 3o6mAlUS+v0YCMowcPKlJ4xcQOtPk6opXU/csXTBhpwBrnILs9zbjj4PiNoqXZzyt5
	 uVEKuQbJch0WBHdn/IpziPs282ZlmFW30P/jM2mjZeU96iI4jdeX4afz+QP2eYxyTM
	 ibYurqkY8cTbA==
Date: Mon, 29 Apr 2024 10:40:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] btrfs_get_dev_args_from_path(): don't call
 set_blocksize()
Message-ID: <20240429-deponie-jedoch-7339eb0c26a4@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211230.GF1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211230.GF1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:12:30PM +0100, Al Viro wrote:
> We don't have bdev opened exclusive there.  And I'm rather dubious
> about the need to do set_blocksize() anywhere in btrfs, to be
> honest - there's some access to page cache of underlying block
> devices in there, but it's nowhere near the hot paths, AFAICT.
> 
> In any case, btrfs_get_dev_args_from_path() only needs to read
> the on-disk superblock and copy several fields out of it; all
> callers are only interested in devices that are already opened
> and brought into per-filesystem set, so setting the block size
> is redundant for those and actively harmful if we are given
> a pathname of unrelated device.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

